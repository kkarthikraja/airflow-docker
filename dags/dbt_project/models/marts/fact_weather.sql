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
    FROM {{ ref('stg_weather_raw') }}
)

SELECT
    lw.location_id,  -- From dim_location
    ld.date_id,      -- From dim_date
    wc.weather_condition_id,  -- From dim_weather_condition
    rw.temperature,
    rw.pressure,
    rw.humidity
FROM raw_data rw
JOIN {{ ref('dim_location') }} lw
    ON rw.city = lw.city
    AND rw.country = lw.country
JOIN {{ ref('dim_date') }} ld
    ON rw.date_time::DATE = ld.date
JOIN {{ ref('dim_weather_condition') }} wc
    ON rw.weather_main = wc.weather_main
    AND rw.weather_description = wc.weather_description