from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime

def hello():
    print("Hello Airflow from Docker!")

with DAG(
    dag_id="simple_hello_dag",
    start_date=datetime(2025, 1, 1),
    schedule="@daily",   # ✅ Airflow 3.x uses `schedule`
    catchup=False,
) as dag:

    hello_task = PythonOperator(
        task_id="hello_task",
        python_callable=hello,
    )

