import sqlite3
import re
import json
import os
import pandas as pd
import logging


def get_primary_keys(logger):
    if os.path.exists('data/primary_keys.json'):
        with open('data/primary_keys.json', 'r') as file:
            table_primary_keys = json.load(file)
        return table_primary_keys
    conn = sqlite3.connect('data/DebugGameplay.sqlite')
    cursor = conn.cursor()
    # Query the sqlite_master table to get information about database objects
    cursor.execute("SELECT name, sql FROM sqlite_master WHERE type='table';")
    tables = cursor.fetchall()
    cursor.close()
    conn.close()

    table_primary_keys = {}
    for table in tables:
        table_name = table[0]
        table_sql = table[1]
        if 'PRIMARY KEY' in table_sql:
            split_sql = table_sql.split('PRIMARY KEY')
            if len(split_sql) > 1:
                match = re.search(r'\((.*?)\)', split_sql[1])
                if match:
                    value_inside_parentheses = match.group(1)
                    value_inside_parentheses = value_inside_parentheses.replace('"', '')
                    table_primary_keys[table_name] = value_inside_parentheses.split(', ')
                else:
                    logger.error("No parentheses found")
            else:
                logger.debug(f'{table_name} had no primary key')
        else:
            logger.debug(f"Table '{table_name}' does not have any PRIMARY KEY")

    with open('data/primary_keys.json', 'w') as file:
        json.dump(table_primary_keys, file)

    return table_primary_keys


def get_foreign_keys(logger):
    if os.path.exists('data/foreign_keys.json'):
        with open('data/foreign_keys.json', 'r') as file:
            table_foreign_keys = json.load(file)
        return table_foreign_keys

    conn = sqlite3.connect('data/DebugGameplay.sqlite')
    cursor = conn.cursor()
    # Query the sqlite_master table to get information about database objects
    cursor.execute("SELECT name, sql FROM sqlite_master WHERE type='table';")
    tables = cursor.fetchall()
    cursor.close()
    conn.close()

    table_foreign_keys = {}
    for table in tables:
        table_name = table[0]
        table_sql = table[1]
        if 'FOREIGN KEY' in table_sql:
            split_sql = table_sql.split('FOREIGN KEY')
            if len(split_sql) > 1:
                for i in split_sql[1:]:
                    match = re.search(r'\((.*?)\)', i)
                    if match:
                        value_inside_parentheses = match.group(1)
                        value_inside_parentheses = value_inside_parentheses.replace('"', '')
                        reference = i.split(' ')[3].split('(')
                        if table_name not in table_foreign_keys:
                            table_foreign_keys[table_name] = {}
                        table_foreign_keys[table_name][value_inside_parentheses] = {'table': reference[0],
                                                                                    'column':reference[1][:-1]}
                    else:
                        logger.critical("No parentheses found")
            else:
                logger.debug(f'{table_name} had no primary key')
        else:
            logger.debug(f"Table '{table_name}' does not have any PRIMARY KEY")

    with open('data/foreign_keys.json', 'w') as file:
        json.dump(table_foreign_keys, file)

    return table_foreign_keys


def check_primary_keys(model_obj):
    logger = logging.getLogger(__name__)
    primary_keys = get_primary_keys(logger)
    foreign_keys = get_foreign_keys(logger)
    constraints = {}
    succeeded_constraints, failed_constraints, mod_dupes, to_pop, vanilla_dupes = 0, [], [], [], []
    for name, insert in model_obj['sql_inserts'].items():
        # primary_inserts = [[i[j] for j in primary_keys[name]] for i in insert]
        if isinstance(insert, dict):
            prim = []
            for key, val in insert.items():
                    prim.append([val[j] for j in primary_keys[name]])

            fk = [{j: val.get(j, None) for j in foreign_keys.get(name, [])} for key, val in insert.items()]
            fk_mapper = [i for i in insert]

        elif isinstance(insert, list):
            prim = [[i[j] for j in primary_keys[name]] for i in insert]
            fk = [{j: i.get(j, None) for j in foreign_keys.get(name, [])} for i in insert]
            fk_mapper = [i for i in range(len(fk))]

        else:
            logger.critical(f'malformed insert data structure {name}')

        df = pd.read_csv(f'data/tables/{name}.csv')
        if name in model_obj['deletes']:
            to_remove = model_obj['deletes'][name]
            if list(to_remove[0].values()) == [1,1]:
                df_prim = []
            else:
                ordered_remove = {i['WHERE_COL']: i['WHERE_EQUALS'] for i in to_remove}
                masks = [~df[col].isin(vals) if isinstance(vals, list) else ~df[col].isin([vals]) for col, vals in ordered_remove.items()]
                combined_mask = masks[0]
                for mask in masks[1:]:
                    combined_mask &= mask
                df_prim = df[combined_mask]
                df_prim = df_prim[primary_keys[name]].values.tolist()
        elif name in model_obj['updates']:
            updates = model_obj['updates'][name]
            for up in updates:
                df.loc[df[up['WHERE_COL']] == up['WHERE_EQUALS'], up['SET_COL']] = up['SET_EQUALS']
            df_prim = df[primary_keys[name]].values.tolist()

        else:
            df_prim = df[primary_keys[name]].values.tolist()

        uniques = []
        for idx, i in enumerate(prim):
            if i in uniques:
                mod_dupes.append(f"{name}: {i}")
                if isinstance(insert, list):
                    to_pop.append((name, idx))
                else:
                    to_pop.append((name, i[0]))
            elif i in df_prim:
                df_details = {i: j for i, j in df.loc[df_prim.index(i)].items()}
                vanilla_dupes.append(f'{df_details}')
                if isinstance(insert, list):
                    to_pop.append((name, idx))
                else:
                    to_pop.append((name, i[0]))
            else:
                uniques.append(i)

        for idx, i in enumerate(fk):
            for native_col, constraint_req in i.items():
                if constraint_req is None or constraint_req == 'NULL':
                    continue
                constraint_table = foreign_keys[name][native_col]['table']
                constraint_col = foreign_keys[name][native_col]['column']
                if constraint_table not in constraints:
                    constraints[constraint_table] = {}
                if constraint_col not in constraints[constraint_table]:
                    constraints[constraint_table][constraint_col] = {}
                if constraint_req not in constraints[constraint_table][constraint_col]:
                    constraints[constraint_table][constraint_col][constraint_req] = [False, [insert[fk_mapper[idx]]]]
                else:
                    constraints[constraint_table][constraint_col][constraint_req][1].append(insert[fk_mapper[idx]])

    # second pass to set bools
    for name, insert in model_obj['sql_inserts'].items():
        for fk_table_name,  constraint_col in constraints.items():
            for col_name, column_reqs in constraint_col.items():
                for fk_name, constraint in column_reqs.items():
                    reference_table = model_obj['sql_inserts'].get(fk_table_name, [{}])
                    if isinstance(reference_table, list):
                        foreign_keys_added = [i.get(col_name, None) for i in reference_table]
                    else:
                        foreign_keys_added = [i[col_name] for i in reference_table.values()]
                    if fk_name in foreign_keys_added + ['NULL', None]:
                        constraint[0] = True
                    else:
                        df = pd.read_csv(f'data/tables/{fk_table_name}.csv')
                        if (df[col_name] == fk_name).any():
                            constraint[0] = True

    for table_name, table in constraints.items():
        for col_name, columns in table.items():
            for value_needed, checker in columns.items():
                if not checker[0]:
                    failed_constraints.append(f'FOREIGN KEY CONSTRAINT FAILED: need table {table_name}, column {col_name} to have value {value_needed}'
                          f'\nfor rows {checker[1]}\n')
                else:
                    succeeded_constraints += 1

    # remove dupes
    to_pop_list = [i for i in to_pop if isinstance(i[1], int)]
    new_pop_list = {}
    for i in to_pop_list:
        if i[0] not in new_pop_list:
            new_pop_list[i[0]] = [i[1]]
        else:
            new_pop_list[i[0]].append(i[1])

    to_pop_dict = [i for i in to_pop if not isinstance(i[1], int)]
    new_pop_dict = {}
    for i in to_pop_dict:
        if i[0] not in new_pop_dict:
            new_pop_dict[i[0]] = [i[1]]
        else:
            new_pop_dict[i[0]].append(i[1])

    popped_tables = {}
    for table_name, indexes_to_pop in new_pop_list.items():
        indexes_to_pop.sort(reverse=True)
        popped_tables[table_name] = []
        for idx in indexes_to_pop:
            popped_tables[table_name].append(model_obj['sql_inserts'][table_name].pop(idx))

    for table_name, keys_to_pop in new_pop_dict.items():
        popped_tables[table_name] = []
        for key in keys_to_pop:
            popped_tables[table_name].append(model_obj['sql_inserts'][table_name].pop(key))

    for table_name, table in popped_tables.items():
        for i in table:
            logger.info(f"popped from table {table_name}: {i}")

    logger.info('UNIQUE CONSTRAINT FAILED. Already existing record:')
    for i in set(vanilla_dupes):
        logger.info(i)
        logger.info('\n')

    logger.info('\nUNIQUE CONSTRAINT FAILED. Duplicate mod records:')
    for i in set(mod_dupes):
        logger.info(i)

    logger.info(f'Unique Constraints Removed: {len(vanilla_dupes)+ len(mod_dupes)}')
    for i in failed_constraints:
        logger.critical(i)
    logger.warning(f'Foreign Key Constraints Failed: {len(failed_constraints)}, Succeeded: {succeeded_constraints}')
