
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select adgroup_id
from `hv-data`.`DE_testing`.`int_tiktok__adgroup_performance`
where adgroup_id is null



  
  
      
    ) dbt_internal_test