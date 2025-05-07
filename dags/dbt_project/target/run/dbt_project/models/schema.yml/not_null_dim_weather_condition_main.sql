select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select main
from "postgres"."public"."dim_weather_condition"
where main is null



      
    ) dbt_internal_test