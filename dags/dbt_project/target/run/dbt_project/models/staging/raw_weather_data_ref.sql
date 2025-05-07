
  create view "postgres"."public"."raw_weather_data_ref__dbt_tmp"
    
    
  as (
    SELECT *
FROM public.raw_weather_data
  );