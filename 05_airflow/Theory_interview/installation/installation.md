### installation Apache Airflow

- create a python enviornment
```
python3 -m venv py_env
```
- activate envirnment
```
source py_env/bin/activate
```

### install Apache Airflow
```
pip install 'apache-airflow==3.1.6' \
 --constraint "https://raw.githubusercontent.com/apache/airflow/constraints-3.1.6/constraints-3.10.txt"
```
- Everything in this current directory
```
export AIRFLOW_HOME=.
```
- Initialize database
```
airflow db init
```