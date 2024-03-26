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


def sql_check(tablename):
    conn = sqlite3.connect('DebugGameplay.sqlite')
    cursor = conn.cursor()
    cursor.execute(f"SELECT * FROM {tablename}")
    sql_column_values = [i[0] for i in cursor.fetchall()]
    cursor.close()
    return sql_column_values


def localization(final_units):
    loc_string = 'INSERT OR REPLACE INTO LocalizedText (Language, Tag, Text)\n VALUES\n'
    for unit in final_units:
        en_name = ' '.join([word.capitalize() for word in unit['Name'][4:-4].split('_')])[:-1]
        loc_string += f"('en_us', '{unit['Name']}', '{en_name}'),\n"
        loc_string += f"('en_us', '{unit['Description']}',  'Description'),\n"
        loc_string += f"('en_us', 'LOC_PEDIA_UNITS_PAGE_{unit['Name'][4:-4]}CHAPTER_HISTORY_PARA_1', 'DESCRIPTION'),\n"
    loc_string = loc_string[:-2] + ';'

    with open('../Core/localization.sql', 'w') as file:
        file.write(loc_string)
