import pandas as pd
from db.mssql_conn import MSSQLConnection

class MSSQLExtractor:

    def extract(self,table_name):
        engine = MSSQLConnection.get_engine()
        query = f"SELECT * FROM {table_name}"
        return pd.read_sql(query, engine)