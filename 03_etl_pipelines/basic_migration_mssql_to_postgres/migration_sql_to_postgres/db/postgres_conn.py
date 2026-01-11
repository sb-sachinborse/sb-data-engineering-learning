from sqlalchemy import create_engine
from config.postgres_config import POSTGRES_CONFIG

class PostgresConnection:

    @staticmethod
    def get_engine():
        conn_str = (
            f"postgresql://{POSTGRES_CONFIG['user']}:{POSTGRES_CONFIG['password']}"
            f"@{POSTGRES_CONFIG['host']}:{POSTGRES_CONFIG['port']}/{POSTGRES_CONFIG['database']}"
        )
        return create_engine(conn_str)
