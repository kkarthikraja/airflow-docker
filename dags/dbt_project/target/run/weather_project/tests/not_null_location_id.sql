select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      SELECT COUNT(*) 
FROM "postgres"."public"."fact_weather"
      
    ) dbt_internal_test