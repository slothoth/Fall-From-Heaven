import sqlite3

def db_checker(kinds):
    conn = sqlite3.connect('DebugGameplay.sqlite')
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM Types')
    existing_types = cursor.fetchall()
    cursor.close()
    will_error = [i for i in kinds if i in [j[0] for j in existing_types]]
    print(f'Existing Types that will be rejected:\n{will_error}')

