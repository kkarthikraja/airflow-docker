
    
    

select
    weather_condition_id as unique_field,
    count(*) as n_records

from "postgres"."public"."dim_weather_condition"
where weather_condition_id is not null
group by weather_condition_id
having count(*) > 1


