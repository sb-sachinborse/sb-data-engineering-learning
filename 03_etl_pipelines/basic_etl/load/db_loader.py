from utils.db_connection import get_db_engine
from config.config import TABLE_NAME


def load_to_postgres(df):
    engine = get_db_engine()
    df.to_sql(
        TABLE_NAME,
        engine,
        if_exists="replace",
        index=False
    )