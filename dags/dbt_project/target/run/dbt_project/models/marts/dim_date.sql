
  create view "postgres"."public"."dim_date__dbt_tmp"
    
    
  as (
    WITH raw_data AS (
    SELECT
        date_time::timestamp AS date_time
    FROM "postgres"."public"."stg_weather_raw"
)

SELECT
    DISTINCT
    date_time::DATE AS date,
    EXTRACT(YEAR FROM date_time) AS year,
    EXTRACT(MONTH FROM date_time) AS month,
    EXTRACT(DAY FROM date_time) AS day,
    EXTRACT(DOW FROM date_time) AS day_of_week,  -- Use DOW (Day of Week)
    EXTRACT(QUARTER FROM date_time) AS quarter,
    TO_CHAR(date_time, 'Day') AS day_name,
    ROW_NUMBER() OVER (PARTITION BY date_time::DATE ORDER BY date_time) AS date_id  -- Unique date identifier
FROM raw_data
  );