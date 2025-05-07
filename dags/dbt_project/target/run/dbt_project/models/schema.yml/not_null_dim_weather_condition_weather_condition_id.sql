select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select weather_condition_id
from "postgres"."public"."dim_weather_condition"
where weather_condition_id is null



      
    ) dbt_internal_test