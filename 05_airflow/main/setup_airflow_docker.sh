#!/bin/bash

set -e  # exit on error

echo "🚀 Starting Apache Airflow Docker setup..."

# -------------------------------
# 1. Create Python virtual env
# -------------------------------
if [ ! -d "airflow_venv" ]; then
  echo "🐍 Creating Python virtual environment..."
  python3 -m venv airflow_venv
fi

source airflow_venv/bin/activate
echo "✅ Python venv activated"

# -------------------------------
# 2. Check Docker
# -------------------------------
if ! command -v docker &> /dev/null; then
  echo "❌ Docker not installed. Install Docker first."
  exit 1
fi

# -------------------------------
# 3. Check Docker Compose
# -------------------------------
if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null; then
  echo "❌ Docker Compose not installed."
  exit 1
fi

# -------------------------------
# 4. Create Airflow directory
# -------------------------------
mkdir -p airflow/{dags,logs,plugins}
cd airflow

# -------------------------------
# 5. Download official docker-compose
# -------------------------------
if [ ! -f docker-compose.yaml ]; then
  echo "⬇️ Downloading Airflow docker-compose.yaml..."
  curl -LfO https://airflow.apache.org/docs/apache-airflow/stable/docker-compose.yaml
fi

# -------------------------------
# 6. Set AIRFLOW_UID (important!)
# -------------------------------
echo "AIRFLOW_UID=$(id -u)" > .env

# -------------------------------
# 7. Create Simple DAG
# -------------------------------
DAG_FILE="dags/simple_dag.py"

if [ ! -f "$DAG_FILE" ]; then
cat <<EOF > $DAG_FILE
from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime

def hello():
    print("Hello Airflow from Docker!")

with DAG(
    dag_id="simple_hello_dag",
    start_date=datetime(2025, 1, 1),
    schedule_interval="@daily",
    catchup=False
) as dag:

    task = PythonOperator(
        task_id="hello_task",
        python_callable=hello
    )
EOF
fi

# -------------------------------
# 8. Start Airflow
# -------------------------------
echo "🐳 Starting Airflow with Docker Compose..."
docker compose up -d

echo "⏳ Waiting for Airflow to start..."
sleep 15

# -------------------------------
# 9. Done
# -------------------------------
echo "✅ Airflow is running!"
echo "🌐 Open http://localhost:8080"
echo "🔑 Login: airflow / airflow"
echo "▶️ Enable DAG: simple_hello_dag"

