
  
    

  create  table "postgres"."public"."stg_weather_raw__dbt_tmp"
  
  
    as
  
  (
    SELECT * FROM public.stg_weather_raw
  );
  