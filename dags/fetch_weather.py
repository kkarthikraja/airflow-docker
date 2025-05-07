"""

This is a OpenWeatherMap API Fetch file.

"""
import pandas as pd
from sqlalchemy import create_engine
import requests
import json
import datetime
import logging

# Setup logging
logging.basicConfig(level=logging.ERROR, format='%(asctime)s - %(levelname)s - %(message)s')

def fetch_weather():
    API_KEY = '11b06ee31ceb982488fe3fe14edbf2cc'
    CITY = 'Aarhus'
    URL = f'https://api.openweathermap.org/data/2.5/weather?q={CITY}&appid={API_KEY}&units=metric'

    try:
        # Make the API request
        response = requests.get(URL, timeout=10)
        response.raise_for_status()  # It will raise an HTTPError for bad responses (4xx, 5xx)

        # Attempt to parse the JSON response
        try:
            data = response.json()
        except json.JSONDecodeError as e:
            logging.error(f"JSON Decode Error: {e}")
            raise Exception("Failed to parse JSON response.")

        # Extract weather data from the API response
        weather_info = {
            'city': data['name'],
            'country': data['sys']['country'],
            'latitude': data['coord']['lat'],
            'longitude': data['coord']['lon'],
            'date_time': datetime.datetime.utcfromtimestamp(data['dt']).isoformat(),
            'temperature': data['main']['temp'],
            'pressure': data['main']['pressure'],
            'humidity': data['main']['humidity'],
            'weather_main': data['weather'][0]['main'],
            'weather_description': data['weather'][0]['description']
        }

        # Save raw JSON
        with open('/opt/airflow/dags/weather_raw.json', 'w') as f:
            json.dump(weather_info, f)

        # Save to staging DB
        DB_URI = 'postgresql://postgres:postgres@host.docker.internal:5433/postgres'
        engine = create_engine(DB_URI)
        df = pd.DataFrame([weather_info])
        df.to_sql('raw_weather_data', engine, if_exists='append', index=False)

        logging.info("Weather data fetched and saved successfully.")

    except requests.exceptions.HTTPError as e:
        logging.error(f"HTTP Error occurred: {e}")
    except requests.exceptions.Timeout as e:
        logging.error(f"Timeout occurred: {e}")
    except requests.exceptions.TooManyRedirects as e:
        logging.error(f"Too many redirects: {e}")
    except requests.exceptions.RequestException as e:
        logging.error(f"RequestException occurred: {e}")
    except Exception as e:
        logging.error(f"Unexpected error: {e}")