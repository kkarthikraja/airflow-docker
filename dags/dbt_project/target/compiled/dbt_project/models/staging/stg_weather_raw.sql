

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
FROM "postgres"."public"."raw_weather_data_ref"