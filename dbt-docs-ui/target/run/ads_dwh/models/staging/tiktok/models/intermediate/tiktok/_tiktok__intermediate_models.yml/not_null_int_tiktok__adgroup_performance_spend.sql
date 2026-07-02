
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select spend
from `hv-data`.`DE_testing`.`int_tiktok__adgroup_performance`
where spend is null



  
  
      
    ) dbt_internal_test