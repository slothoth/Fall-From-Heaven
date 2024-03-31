import sqlite3


def small_dict(big_dict, four_to_six_map):
    smaller_dict = {}
    for j in big_dict:
        if j in four_to_six_map:
            smaller_dict[four_to_six_map[j]] = big_dict[j]
    for to_insert, default_value in four_to_six_map.items():
        if default_value not in smaller_dict:
            smaller_dict[to_insert] = default_value
    return smaller_dict


def build_sql_table(list_of_dicts, table_name):
    if isinstance(list_of_dicts, dict):
        list_of_dicts = [value for value in list_of_dicts.values()]
    schema_string = '('
    for schema_key in [i for i in list_of_dicts[0]]:
        schema_string += f'{schema_key}, '
    schema_string = schema_string[:-2] + ') VALUES\n'
    table_string = f"INSERT INTO {table_name}" + schema_string

    for item in list_of_dicts:
        table_string += "("
        for item_attribute in item.values():
            table_string += f"'{item_attribute}', "
        table_string = table_string[:-2]
        table_string += "),\n"
    table_string = table_string[:-2]
    table_string += ";\n"
    return table_string


def update_sql_table(list_of_dicts, table_name: str, columns_to_select: list):
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


def sql_check(tablename):
    conn = sqlite3.connect('DebugGameplay.sqlite')
    cursor = conn.cursor()
    cursor.execute(f"SELECT * FROM {tablename}")
    sql_column_values = cursor.fetchall()
    cursor.close()
    return sql_column_values


def localization(names):
    loc_string = ''
    type_description = 'LOC_PEDIA_UNITS_PAGE'
    if isinstance(names, dict):
        names = [i for i in names.values()]
    if 'UnitType' in names[0]:
        type_description = 'LOC_PEDIA_UNITS_PAGE'
    elif 'BuildingType' in names[0]:
        type_description = 'LOC_PEDIA_BUILDINGS_PAGE'
    for item in names:
        en_name = ' '.join([word.capitalize() for word in item['Name'].split('_')][2:-1])
        loc_string += f"('en_us', '{item['Name']}', '{en_name}'),\n"
        loc_string += f"('en_us', '{item['Description']}',  'Description'),\n"
        loc_string += f"('en_us', '{type_description}_{item['Name'][4:-4]}CHAPTER_HISTORY_PARA_1', 'DESCRIPTION'),\n"

    with open('../FallFromHeaven/Core/localization.sql', 'a') as file:
        file.write(loc_string)
