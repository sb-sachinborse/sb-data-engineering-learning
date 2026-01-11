from db.postgres_conn import PostgresConnection

class PostgresLoader:

    def load(self, df, table_name):
        engine = PostgresConnection.get_engine()
        df.to_sql(
            table_name,
            engine,
            if_exists="append",
            index=False
        )
