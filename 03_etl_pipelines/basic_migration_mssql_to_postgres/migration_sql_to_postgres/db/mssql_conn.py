from sqlalchemy import create_engine
from config.mssql_config import MSSQL_CONFIG


class MSSQLConnection:

    @staticmethod
    def get_engine():
        conn_str = (
            f"mssql+pyodbc://@{MSSQL_CONFIG['server']}/"
            f"{MSSQL_CONFIG['database']}?"
            f"driver={MSSQL_CONFIG['driver'].replace(' ', '+')}"
            f"&trusted_connection={MSSQL_CONFIG['trusted_connection']}"
        )
        return create_engine(conn_str)