# 🌦️ Weather Data Pipeline - Data Engineering Assignment

This project explains a complete ETL pipeline using **OpenWeatherMap API**, **Apache Airflow**, **dbt**, and **PostgreSQL**. It fetches real-time weather data, transforms it using dimensional modeling principles (star schema), and loads it into a local Postgres data warehouse.

---

## 📦 Tech Stack

- **Apache Airflow** – ETL orchestration
- **dbt (Data Build Tool)** – SQL transformations
- **PostgreSQL** – Data warehouse
- **SQLAlchemy & Pandas** – Raw data loading
- **Docker** – Containerized setup
- **pytest** – Unit testing
- **OpenWeatherMap API** – Real-time weather source

---

## 📁 Project Structure

├── dags/
│ ├── weather_etl_dag.py # Airflow DAG definition
│ ├── fetch_weather.py # API data extraction script
│ └── weather_raw.json # Sample raw data
│
├── dbt_project/
│ ├── models/
│ │ ├── staging/
│ │ │ └── stg_weather_raw.sql
│ │ ├── dimensional/
│ │ │ ├── dim_location.sql
│ │ │ ├── dim_date.sql
│ │ │ ├── dim_weather_condition.sql
│ │ │ └── fact_weather.sql
│ │ └── tests/
│ │ └── fact_weather_test.sql
│ ├── dbt_project.yml
│ └── profiles.yml
│
├── tests/
│ └── test_extract.py # Unit tests for fetch_weather.py
│
├── docker-compose.yml
├── requirements.txt
└── README.md