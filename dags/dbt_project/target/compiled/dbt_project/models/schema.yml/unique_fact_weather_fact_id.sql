
    
    

select
    fact_id as unique_field,
    count(*) as n_records

from "postgres"."public"."fact_weather"
where fact_id is not null
group by fact_id
having count(*) > 1


