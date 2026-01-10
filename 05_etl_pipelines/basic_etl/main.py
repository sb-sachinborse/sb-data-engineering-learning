from extract.api_extractor import extract_data
from transform.transformer import transform_data
from load.db_loader import load_to_postgres


def run_pipeline():
    print("Starting Data pipeline")

    raw_data = extract_data()
    print("Data extract")

    transform_df = transform_data(raw_data)
    print("Data Transform")

    load_to_postgres(transform_df)
    print("Data Loade into postgreSQL")

if __name__== "__main__":
    run_pipeline()