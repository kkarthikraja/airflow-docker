WITH raw_data AS (
    SELECT DISTINCT
        city,
        country,
        latitude,
        longitude
    FROM "postgres"."public"."stg_weather_raw"
)

SELECT
    city,
    country,
    latitude,
    longitude,
    ROW_NUMBER() OVER (PARTITION BY city, country ORDER BY city) AS location_id  -- Assigning a unique location_id
FROM raw_data