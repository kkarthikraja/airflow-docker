select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select date_id
from "postgres"."public"."fact_weather"
where date_id is null



      
    ) dbt_internal_test