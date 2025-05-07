
    
    

with child as (
    select weather_condition_id as from_field
    from "postgres"."public"."dim_weather_condition"
    where weather_condition_id is not null
),

parent as (
    select weather_condition_id as to_field
    from "postgres"."public"."fact_weather"
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


