WITH raw_data AS (
    SELECT
        city,
        country,
        date_time,
        temperature,
        pressure,
        humidity,
        weather_main,
        weather_description
    FROM "postgres"."public"."stg_weather_raw"
)

SELECT
    lw.location_id,  -- From dim_location
    ld.date_id,      -- From dim_date
    wc.weather_condition_id,  -- From dim_weather_condition
    temperature,
    pressure,
    humidity
FROM raw_data rw
JOIN "postgres"."public"."dim_location" lw
    ON rw.city = lw.city
    AND rw.country = lw.country
JOIN "postgres"."public"."dim_date" ld
    ON rw.date_time::DATE = ld.date
JOIN "postgres"."public"."dim_weather_condition" wc
    ON rw.weather_main = wc.weather_main
    AND rw.weather_description = wc.weather_description