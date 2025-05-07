WITH raw_data AS (
    SELECT DISTINCT
        weather_main,
        weather_description
    FROM "postgres"."public"."stg_weather_raw"
)

SELECT
    weather_main,
    weather_description,
    ROW_NUMBER() OVER (PARTITION BY weather_main, weather_description ORDER BY weather_main) AS weather_condition_id  -- Unique identifier for weather condition
FROM raw_data