from extract.extractor import MSSQLExtractor
from transform.transformer import DataTransformer
from load.loader import PostgresLoader

class MigrationPipeline:

    def run(self):
        extractor = MSSQLExtractor()
        transformer = DataTransformer()
        loader = PostgresLoader()

        customers = extractor.extract("customers_raw")
        orders = extractor.extract("orders_raw")
        payments = extractor.extract("payments_raw")

        final_df = transformer.transform(customers, orders, payments)

        loader.load(final_df, "customer_order_summary")
