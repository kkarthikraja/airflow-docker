from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.operators.bash import BashOperator
from airflow.utils.dates import days_ago
from fetch_weather import fetch_weather
import subprocess

def run_dbt():
    try:
        subprocess.run(['dbt', 'run'], check=True, cwd='/opt/airflow/dags/dbt_project')
        print("dbt run completed successfully.")
    except subprocess.CalledProcessError as e:
        print("dbt run failed:", e)

with DAG(
    dag_id='weather_etl_dag',
    schedule_interval='*/60 * * * *',  # Every 60 minutes
    start_date=days_ago(1),
    catchup=False,
    description="ETL pipeline for weather data using OpenWeatherMap API, dbt, and Airflow",
    tags=['weather', 'etl', 'dbt']
) as dag:

    fetch = PythonOperator(
        task_id='fetch_weather',
        python_callable=fetch_weather,
    )

    transform = PythonOperator(
        task_id='run_dbt',
        python_callable=run_dbt,
    )

    dbt_test = BashOperator(
        task_id='dbt_test',
        bash_command='cd /opt/airflow/dags/dbt_project && dbt test',
    )

    fetch >> transform >> dbt_test