import sqlite3
import pandas as pd


def db_checker(kinds):
    existing_types = pd.read_csv('data/tables/Types.csv')
    will_error = [i for i in kinds if i in existing_types.to_dict('list')['Type']]
    print(f'Existing Types that will be rejected:\n{will_error}')
