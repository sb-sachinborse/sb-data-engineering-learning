from dotenv import load_dotenv
import os


load_dotenv()


# MSSQL config
MSSQL_CONFIG = {
    "server": os.getenv("MSSQL_SERVER"),
    "database": os.getenv("MSSQL_DATABASE"),
    "driver": os.getenv("MSSQL_DRIVER"),
    "trusted_connection": os.getenv("TRUSTED_CONNECTION")
}