{{ config(materialized='view') }}

SELECT
    city,
    country,
    latitude,
    longitude,
    date_time,
    temperature,
    pressure,
    humidity,
    weather_main,
    weather_description
FROM {{ ref('raw_weather_data_ref') }}