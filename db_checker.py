import sqlite3
import re
import json
import os


def get_primary_keys():
    if os.path.exists('data/primary_keys.json'):
        with open('data/primary_keys.json', 'r') as file:
            table_primary_keys = json.load(file)
        return table_primary_keys
    # Connect to your SQLite database
    conn = sqlite3.connect('data/DebugGameplay.sqlite')

    # Create a cursor object to execute SQL commands
    cursor = conn.cursor()

    # Query the sqlite_master table to get information about database objects
    cursor.execute("SELECT name, sql FROM sqlite_master WHERE type='table';")

    # Fetch all rows from the result set
    tables = cursor.fetchall()
    # Close the cursor and connection
    cursor.close()
    conn.close()

    # Iterate through each table to find unique constraints
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
                    print("No parentheses found")
            else:
                print(f'{table_name} had no primary key')
        else:
            print(f"Table '{table_name}' does not have any PRIMARY KEY")

    with open('data/primary_keys.json', 'w') as file:
        json.dump(table_primary_keys, file)

    return table_primary_keys


def check_primary_keys(model_obj):
    primary_keys = get_primary_keys()
    for name, insert in model_obj['sql_inserts'].items():
        rules = primary_keys[name]
        unique_tuples = [[i[j] for j in rules] for i in insert]
        for i in


