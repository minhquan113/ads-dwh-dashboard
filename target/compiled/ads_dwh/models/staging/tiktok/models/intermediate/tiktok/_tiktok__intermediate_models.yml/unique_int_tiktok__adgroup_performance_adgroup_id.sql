
    
    

with dbt_test__target as (

  select adgroup_id as unique_field
  from `hv-data`.`DE_testing`.`int_tiktok__adgroup_performance`
  where adgroup_id is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


