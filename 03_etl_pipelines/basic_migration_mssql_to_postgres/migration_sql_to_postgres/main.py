from pipeline.migration_pipeline import MigrationPipeline

if __name__ == "__main__":
    pipeline = MigrationPipeline()
    pipeline.run()
    print("✅ MSSQL → PostgreSQL migration completed successfully")

