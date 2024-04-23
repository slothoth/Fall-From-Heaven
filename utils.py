import sqlite3
import pandas as pd
import os
from collections import Counter
import logging
from itertools import chain


class Sql:
    def __init__(self):
        self.tables = {}
        self.logger = logging.getLogger(__name__)

    def old_build_sql_table(self, list_of_dicts, table_name):
        if isinstance(list_of_dicts, dict):
            list_of_dicts = [value for value in list_of_dicts.values()]
        if len(list_of_dicts) == 0:
            self.logger.error(f'empty list of dicts for {table_name} found while building sql')
            return ''
        self.check_sql(list_of_dicts, table_name)
        schema_string = '('
        longest_index = max(range(len(list_of_dicts)), key=lambda i: len(list_of_dicts[i]))
        possible_keys = list(set(chain.from_iterable(sub.keys() for sub in list_of_dicts)))
        master_dict = {i: [j[i] for j in list_of_dicts if i in j][0] for i in possible_keys}
        for key, val in master_dict.items():
            try:
                val = int(val)
            except ValueError:
                silent_string = 'string staying silent'
            if isinstance(val, str):
                master_dict[key] = 'NULL'
            elif isinstance(val, int):
                master_dict[key] = 0
            else:
                self.logger.info(f'odd data structure encountered while building sql insert string, of type: {type(val)}')
        for schema_key in master_dict:
            if schema_key == 'Column':                              # SQL reserved keyword
                schema_key = '"Column"'
            schema_string += f'{schema_key}, '
        schema_string = schema_string[:-2] + ') VALUES\n'
        table_string = f"INSERT INTO {table_name}" + schema_string

        for item in list_of_dicts:
            table_string += "("
            for schema_key in master_dict:
                table_string += f"'{item.get(schema_key, master_dict[schema_key])}', "
            table_string = table_string[:-2]
            table_string += "),\n"
        table_string = table_string[:-2]
        table_string += ";\n"
        return table_string


    def update_sql_table(self, list_of_dicts, table_name: str, columns_to_select: list):
        if isinstance(list_of_dicts, dict):
            list_of_dicts = [value for value in list_of_dicts.values()]
        table_string = ''

        for item in list_of_dicts:
            table_string += f"UPDATE {table_name} SET "
            for key, value in item.items():
                if key not in columns_to_select:
                    table_string += f"{key} = '{value}', "
            table_string = table_string[:-2]
            table_string += f" WHERE {columns_to_select[0]} = '{item[columns_to_select[0]]}'"
            for column in columns_to_select[1:]:
                table_string += f" AND {column} = '{item[column]}'"
            table_string += ";\n"
        return table_string

    def build_sql_table(self, list_of_dicts, table_name):
        if isinstance(list_of_dicts, dict):
            list_of_dicts = [value for value in list_of_dicts.values()]
        if len(list_of_dicts) == 0:
            return ''
        self.check_sql(list_of_dicts, table_name)
        table_string = ''

        for item in list_of_dicts:
            column_names = []
            value_names = []
            for column, value in item.items():
                column_names.append(column)
                value_names.append(str(value))

            column_names = "'" + "', '".join(column_names) + "'"
            value_names = "'" + "', '".join(value_names) + "'"

            table_string += f"INSERT INTO {table_name} ({column_names}) VALUES ({value_names});\n"

        table_string = table_string[:-2]
        table_string += ";\n"
        return table_string

    def check_sql(self, list_of_dicts, table_name):
        if table_name not in self.tables:
            self.tables[table_name] = list_of_dicts
        else:
            self.tables[table_name].append(list_of_dicts)


def split_dict(dictionary, condition, equalto=None):
    if equalto is not None:
        has_condition = {key: i for key, i in dictionary.items() if i.get(condition, False) == equalto}
        hasnt_condition = {key: i for key, i in dictionary.items() if i.get(condition, False) != equalto}
    else:
        has_condition = {key: i for key, i in dictionary.items() if i.get(condition, False)}
        hasnt_condition = {key: i for key, i in dictionary.items() if not i.get(condition, False)}
    return has_condition, hasnt_condition


def localize(model_obj):
    logger = logging.getLogger(__name__)
    tables_to_translate = ['Buildings', 'Districts', 'Improvements', 'Projects', 'Civics', 'Policies', 'Civilizations',
                           'Leaders', 'Traits', 'Resources', 'Terrains', 'Features', 'UnitPromotions', 'UnitPromotionClasses',
                           'Units', 'Abilities', 'Technologies', ]
    weird_tables = ['CityNames', 'CivilopediaConcepts', 'CivilizationFrontEnd']
    col_types = []
    for table_name, table in model_obj['sql_inserts'].items():
        if table_name not in tables_to_translate:
            continue
        if isinstance(table, list):
            table = {idx: i for idx, i in enumerate(table)}
        loc_cols = [i for i, j in list(table.values())[0].items() if isinstance(j, str) and 'LOC' in j]
        common_strings = []
        for loc_col in loc_cols:
            result = []
            [result.extend(i[loc_col].split('_')) for i in table.values()]
            common_strings.extend([name for name, count in Counter(result).items() if count > len(table) * 0.8])
        common_strings = set(common_strings)
        for key, row in table.items():
            loc_entry = []
            for col in loc_cols:
                tag_value = row[col]
                text = tag_value
                for remove_str in common_strings:
                    text = text.replace(remove_str, '')
                text = ' '.join([i.capitalize() for i in text.replace('_', ' ').strip().split()])
                if col == 'Name':
                    col_types.append(col)
                elif col == 'Adjective':
                    col_types.append(col)
                    if text[-1] == 's':
                        text = text[:-1]
                    else:
                        text += 'ian'
                elif col == 'Description':
                    if isinstance(key, str) and key in model_obj['modifiers'].loc:
                        modifier_description = ''
                        for i in model_obj['modifiers'].loc[key]:
                            if 'SLTH' in i:
                                string_replace = i.split('###')
                                string_replace[1] = string_replace[1].replace('SLTH', '')
                                string_replace[1] = "".join([j.capitalize() for j in string_replace[1].split('_')])
                                i = " ".join([i.strip() for i in string_replace])
                            modifier_description += i + ' '
                        text = modifier_description.strip()
                    elif isinstance(key, str) and 'COOL' in key:
                        modifier_description = ''
                        if 'EMBERS' in key:
                            civ = "_".join(key.split('_')[-4:-1])
                        else:
                            civ = key.split('_')[-2]
                        for i in model_obj['modifiers'].loc[f"SLTH_BUILDING_PALACE_{civ}"]:
                            modifier_description += i + ' '
                        text = modifier_description.strip()
                    else:
                        text = text + ' Description'
                else:
                    logger.error(f'unrecognized loc_tag {col}')
                if 'Mana ' in text and table_name == 'Resources':
                    text = ' '.join(text.split(' ')[::-1])
                if 'Null' in text and 'Nullstone' not in text:
                    text = 'ZZ_Banned for Civ'
                if table_name == 'Units':
                    text = text.replace('Equipment', '').replace('Unit', '')
                if table_name == 'UnitPromotions':
                    text = text.replace('1', ' I').replace('2', ' II').replace('3', ' III')
                    text = text.replace('4', ' IV').replace('5', ' V')
                text = text.replace('+-', '-')
                loc_entry.append({'Language': 'en_us', 'Tag': tag_value, 'Text': text.strip()})
            if len(loc_entry) > 0:
                if table_name in model_obj['loc']:
                    model_obj['loc'][table_name].extend(loc_entry)
                else:
                    model_obj['loc'][table_name] = loc_entry
    logger.info(set(col_types))


def text_convert(text_loc):
    localised = text_loc.replace('LOC_', '').replace('_', ' ').strip()
    return localised


def setup_tables():
    os.makedirs('../FallFromHeaven/Core/', exist_ok=True)
    # build pandas tables
    if not os.path.exists('data/tables'):
        # ran once, to convert database to pandas for conversion
        conn = sqlite3.connect('data/DebugGameplay.sqlite')
        cursor = conn.cursor()
        cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
        table_names = cursor.fetchall()
        tables = [table[0] for table in table_names] + ['sqlite_master']
        dfs = {}
        os.makedirs('data/tables', exist_ok=True)
        for table in tables:
            query = f"SELECT * FROM {table}"
            dfs[table] = pd.read_sql_query(query, conn)
            dfs[table].to_csv(f"data/tables/{table}.csv", index=False)
        conn.close()


def small_dict(big_dict, four_to_six_map):
    smaller_dict = {}
    for j in big_dict:
        if j in four_to_six_map:
            smaller_dict[four_to_six_map[j]] = big_dict[j]
    for to_insert, default_value in four_to_six_map.items():
        if default_value not in smaller_dict:
            smaller_dict[to_insert] = default_value
    return smaller_dict


def make_or_add(to_sql, list_of_dicts, table_name):
    if table_name in to_sql:
        if isinstance(to_sql[table_name], list):
            if not isinstance(list_of_dicts, list):
                list_of_dicts = list_of_dicts.values()
            to_sql[table_name].extend(list_of_dicts)

        elif isinstance(to_sql[table_name], dict) and isinstance(list_of_dicts, dict):
            to_sql[table_name].update(list_of_dicts)
        else:
            print(f'rejected append for sql table {table_name} as preexisting is {type(to_sql[table_name])} and '
                  f'addition is {type(list_of_dicts)}')

    else:
        to_sql[table_name] = list_of_dicts


def update_or_add(to_sql, list_of_dicts, table_name, columns_to_select):
    if table_name in to_sql:
        if isinstance(to_sql[table_name], type(list_of_dicts)):
            to_sql[table_name].extend(list_of_dicts)
        else:
            print(f'rejected append for sql table {table_name} as preexisting is {type(to_sql[table_name])} and '
                  f'addition is {type(list_of_dicts)}')

    else:
        if not isinstance(list_of_dicts, list):
            list_of_dicts = [list_of_dicts]
        to_sql[table_name] = (list_of_dicts, columns_to_select)
