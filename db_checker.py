import sqlite3

# Connect to your SQLite database
conn = sqlite3.connect('data/DebugGameplay.sqlite')

# Create a cursor object to execute SQL commands
cursor = conn.cursor()

# Query the sqlite_master table to get information about database objects
cursor.execute("SELECT name, sql FROM sqlite_master WHERE type='table';")

# Fetch all rows from the result set
tables = cursor.fetchall()

# Iterate through each table to find unique constraints
for table in tables:
    table_name = table[0]
    table_sql = table[1]

    # Look for UNIQUE constraints in the table's SQL definition
    if 'UNIQUE' in table_sql:
        print(f"Table '{table_name}' has the following UNIQUE constraints:")

        # Extract the UNIQUE constraints from the SQL definition
        unique_constraints = [constraint.strip() for constraint in table_sql.split('\n') if 'UNIQUE' in constraint]

        for constraint in unique_constraints:
            print(constraint)

    else:
        print(f"Table '{table_name}' does not have any UNIQUE constraints.")

# Close the cursor and connection
cursor.close()
conn.close()



