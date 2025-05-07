WITH fact_check AS (
    SELECT
        location_id,
        date_id,
        weather_condition_id
    FROM "postgres"."public"."fact_weather"
    WHERE location_id IS NULL
       OR date_id IS NULL
       OR weather_condition_id IS NULL
)
SELECT COUNT(*) 
FROM fact_check
HAVING COUNT(*) > 0