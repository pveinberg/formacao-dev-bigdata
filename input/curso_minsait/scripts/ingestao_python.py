import pandas as pd
import pymysql
from sqlalchemy import create_engine

USER = 'root'
PASSWORD = 'secret'
PORT = 33061
DATABASE = 'employees'
HOSTNAME = 'localhost'
string_connection = f"mysql+pymysql://{USER}:{PASSWORD}@{HOSTNAME}:{PORT}/{DATABASE}"
cnx = create_engine(string_connection)
db_connection = cnx.connect()

data = pd.read_sql_query("select * from employees.employees", db_connection)


data.head()

# engine = create_engine(f"mysql:///?User={USER}&;Password={PASSWORD}&Database={DATABASE}&Server={HOSTNAME}&Port={PORT}")

# con = pymysql.connect(host='localhost', 
#                       user='root', 
#                       passwd='secret', 
#                       database='employees',
#                       port=33061)

# try:
#     with con.cursor() as cur:
#         cur.execute('SELECT * FROM employees limit 10')
#         rows = cur.fetchall()
#         for row in rows:
#             print(f'{row[0]} {row[1]} {row[2]}')
# finally:
#     con.close()
