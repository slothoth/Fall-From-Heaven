import sqlite3
import pandas as pd
import os

if not os.path.exists('data/tables'):
    # ran once, to convert database to pandas for conversion
    conn = sqlite3.connect('DebugGameplay.sqlite')
    cursor = conn.cursor()
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
    table_names = cursor.fetchall()
    tables = [table[0] for table in table_names]
    dfs = {}
    os.makedirs('data/tables', exist_ok=True)
    for table in tables:
        query = f"SELECT * FROM {table}"
        dfs[table] = pd.read_sql_query(query, conn)
        dfs[table].to_csv(f"data/tables/{table}.csv", index=False)

    conn.close()
# wtf is this sorcery
# ModifierArguments(ModifierId, Name, Type, "Value")
# ('MODIFIER_SHRINE_CITY_HERO_EXTRA_LIFESPAN', 'Key', 'ARGTYPE_IDENTITY', 'CityHeroExtraLifespan');
# This to me implies that CityHeroExtraLifeSpan is a key to an internal dictionary of city properties: MODIFIER_SINGLE_CITY_ADJUST_PROPERTY
# could we find hidden keys that are exposed but undocumented? Apparently you can find it in a lua property
substring = 'VICTORY'
records = {}
for i in os.listdir('data/tables/'):
    if i == 'Kinds.csv':
        continue
    if i.endswith('.csv'):
        df = pd.read_csv(f'data/tables/{i}')
        records['i'] = []
        for column in df.columns:
            if df[column].apply(lambda x: isinstance(x, str)).any():
                if df[column].str.contains(substring, case=False).any():
                    try:
                        found_in_table = df[df[column].str.contains(substring, case=False).fillna(False)]
                        records['i'].append(df[df[column].str.contains(substring, case=False).fillna(False)])
                    except Exception as e:
                        print(f'failed read on {i}.{column} with error {e}')
