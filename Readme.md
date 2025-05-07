# 🌦️ Weather Data Pipeline

This project creates a complete ETL pipeline using **OpenWeatherMap API**, **Apache Airflow**, **dbt**, and **PostgreSQL**. It fetches real-time weather data, transforms it using dimensional modeling principles (star schema), and loads it into a local Postgres data warehouse.

---

## 📦 Tech Stack

- **Apache Airflow** – ETL orchestration
- **dbt (Data Build Tool)** – SQL transformations
- **PostgreSQL** – Data warehouse
- **SQLAlchemy & Pandas** – Raw data loading
- **Docker** – Containerized setup
- **pytest** – Unit testing
- **OpenWeatherMap API** – Real-time weather source [openweathermap](https://openweathermap.org/)

---

## 📁 Project Structure

├── dags/  
│   ├── weather_etl_dag.py         # Airflow DAG definition  
│   ├── fetch_weather.py           # API data extraction script  
│   └── weather_raw.json           # Sample raw data  
│
├── dbt_project/  
│   ├── models/  
│   │   ├── staging/  
│   │   │   └── stg_weather_raw.sql  
│   │   ├── marts/  
│   │   │   ├── dim_location.sql  
│   │   │   ├── dim_date.sql  
│   │   │   ├── dim_weather_condition.sql  
│   │   │   └── fact_weather.sql  
│   │   └── tests/  
│   │   │   └── fact_weather_test.sql
│   │   │   └── test_extract.py    # Unit tests for fetch_weather.py
│   ├── dbt_project.yml  
│   └── profiles.yml  
│
├── tests/  
│   └── test_extract.py            # Unit tests for fetch_weather.py  
│
├── docker-compose.yml  
├── requirements.txt  
└── README.md 

## Setup Instructions

1. **Clone the repository:**
  ```bash
  git clone https://github.com/kkarthikraja/airflow-docker.git
  cd airflow-docker
  ```

2. **Install required Python dependencies:**
   ```bash
   pip install -r requirements.txt
   ```
   
3. **Set up your environment variables:**

   Set the OpenWeatherMap API key as an environment variable @[openweathermap](https://openweathermap.org/)

   Export the following:

  ```bash
  export OPENWEATHERMAP_API_KEY=<your_api_key>
  export DB_HOST=localhost
  export DB_NAME=weather_db
  export DB_USER=postgres
  export DB_PASSWORD=postgres
  ```
   
5. **Download and Install Docker Desktop:**
   Download and install Docker Desktop from https://www.docker.com/products/docker-desktop and ensure it's running in the background.

6. **Install PostgreSQL database:**
   Install PostgreSQL locally or use a Docker container. Make sure your credentials match the ones provided in the environment variables or ```bash profiles.yml ```.

7. **Set up your PostgreSQL credentials as environment variables:**
   ```bash
   pip install -r requirements.txt
   ```

8. **Run the Docker desktop on the background:**
   ```bash
   pip install -r requirements.txt
   ```

9. **Set up the dbt project:**

   Update your `profiles.yml` under the `dags/dbt_project/` folder with:
   
   ```yaml
  my_postgres:
    target: dev
    outputs:
      dev:
        type: postgres
        host: localhost
        user: postgres
        password: postgres
        dbname: weather_db
        schema: public
    ```


10. **Run the Airflow on your docker from executing on your root folder /docker-airflow/ :**

   ```bash
   docker exec -it airflow-docker-airflow-webserver-1 bashdocker exec -it airflow-docker-airflow-webserver-1 bash
   ``` 

11. **Run Airflow with Docker:**

   Build and start the Airflow Docker containers:

   Run the following command from the root folder:

  ```bash
  docker-compose up --build
  ```

   Access the Airflow UI at: [http://localhost:8080](http://localhost:8080) (Default login: `admin` / `admin`)

   
10. **Running the Data Pipeline:**

    The pipeline will automatically fetch weather data, perform transformation (using dbt), and load it into PostgreSQL.

    The Airflow DAG is scheduled to run every 60 minutes.

    Airflow will trigger dbt runs through the subprocess command.

11. **Testing:**

    You can add unit tests for the dbt models inside the /tests folder.

    The pipeline includes a fact_weather_test.sql file that checks for NULLs in foreign keys.

    Airflow will trigger dbt runs through the subprocess command.
   
11. **Exception Handling:**

    The API extraction step includes exception handling for failed requests.

    Any errors encountered during the pipeline execution will be logged by Airflow.
