
  create view "postgres"."public"."dim_weather_condition__dbt_tmp"
    
    
  as (
    WITH raw_data AS (
    SELECT DISTINCT
        weather_main,
        weather_description
    FROM "postgres"."public"."stg_weather_raw"
),
ranked_data AS (
    SELECT
        weather_main,
        weather_description,
        DENSE_RANK() OVER (
            PARTITION BY weather_main, weather_description ORDER BY weather_main, weather_description
        ) AS weather_condition_id
    FROM raw_data
)

SELECT 
    weather_condition_id,
    weather_main,      
    weather_description 
FROM ranked_data
ORDER BY weather_condition_id
  );