select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

with child as (
    select location_id as from_field
    from "postgres"."public"."fact_weather"
    where location_id is not null
),

parent as (
    select location_id as to_field
    from "postgres"."public"."dim_location"
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null



      
    ) dbt_internal_test