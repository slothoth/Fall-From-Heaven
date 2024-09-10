import sqlite3

import pandas as pd

with open('../Core/Improvements.sql') as file:
    lines = file.readlines()

insert_indices = [idx for idx, i in enumerate(lines) if 'INSERT' in i]

semicolon_indices = [idx for idx, i in enumerate(lines) if ';' in i]

table_inserts = {}
for idx, i in enumerate(insert_indices):
    name = lines[i].split('INTO ')[1].split('(')[0]
    chis = [j for j in semicolon_indices if len(insert_indices) - 1 > idx and i < j < insert_indices[idx + 1]]
    if len(chis) > 1:
        for k in chis:
            if 'UPDATE' not in lines[k]:
                table_inserts[name] = (i, k)
    elif len(chis) == 1:
        table_inserts[name] = (i, chis[0])
    else:
        print('NO LINES?')

        table_inserts[name] = (i, len(lines)-1)

# parse into tables
table_values = {}
for key, val in table_inserts.items():
    cols = lines[val[0]].split('(')[1].split(')')[0].split(',')
    cols = [i.replace("'", '').strip() for i in cols]           # get sql columns
    df_dict = {i: [] for i in cols}
    lines_to_parse = range(val[0] + 1, val[1]+1)
    for i in lines_to_parse:
        line = lines[i]
        chs = line.replace('(', '').replace(')', '').replace(',\n', '').split(',')
        multi_col = [(idx, k) for idx, k in enumerate(chs) if 'NULL' not in k and k[0] !="'" and (k[1] !="'" or k[-1]!="'")]# get value in sql statement
        if len(multi_col) > 1:
            idx_to_remove = [l[0] for l in multi_col]
            multi_col_values = [l[1] for l in multi_col]
            insert = ','.join(multi_col_values) + "'"
            new_chs = [i for idx, i in enumerate(chs) if idx not in idx_to_remove]
            chs = new_chs
            chs.insert(1, insert)
            chs = [insert if idx == idx_to_remove[0] else i for idx, i in enumerate(chs)]
        for idx, value in enumerate(chs):
            name = cols[idx]
            stripped_val = value.replace("'", '').replace(';', '').strip()
            df_dict[name].append(stripped_val)
    table_values[key] = df_dict

conn = sqlite3.connect('data/DebugGameplay.sqlite')
cursor = conn.cursor()
remapper = {}
defaults = {}
for table_name in table_inserts:
    cursor.execute(f"PRAGMA table_info({table_name});")
    columns_info = cursor.fetchall()
    column_names = [col[1] for col in columns_info]
    column_defaults = {col[1]: col[4] for col in columns_info}
    remapper[table_name] = column_names
    defaults[table_name] = column_defaults
conn.close()

for key, val in table_values.items():
    val_lengths = [len(i) for i in val.values()]
    if not all(x == val_lengths[0] for x in val_lengths):
        print(key)
tables_as_dfs = {key: pd.DataFrame().from_dict(val) for key, val in table_values.items()}
ordered_tables_as_dfs = {}
for name, df in tables_as_dfs.items():
    df_ = df.copy()
    new_cols = remapper[name]
    new_cols = [i for i in new_cols if i in df_.columns]
    df_ = df_[new_cols]
    for column in df_:
        if defaults[name][column] is not None:
            all_default = (df_[column] == defaults[name][column]).all()
            if all_default:
                df_.drop(columns=column, inplace=True)
    ordered_tables_as_dfs[name] = df_


def convert_to_sql(df, table_name):
    sql_string = f'INSERT INTO {table_name}({", ".join(list(df.columns))}) VALUES\n'
    for i in df.iterrows():
        sql_string += ("('" + "', '".join(list(i[1])) + "'),\n").replace("'NULL'", "NULL")
    sql_string = sql_string[:-2] + ';\n'
    return sql_string
dhes = ''
for key, val in ordered_tables_as_dfs.items():
    if len(val) == 0:
        print(f'ERROR: no VALUES found for table {key}')
    dhes += convert_to_sql(val, key)
print('')
