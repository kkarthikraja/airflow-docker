select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select fact_id
from "postgres"."public"."fact_weather"
where fact_id is null



      
    ) dbt_internal_test