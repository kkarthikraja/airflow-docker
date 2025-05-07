FROM apache/airflow:2.9.1

# Switch to the 'airflow' user before running pip install
USER airflow

# Install dbt packages
RUN pip install dbt-core dbt-postgres