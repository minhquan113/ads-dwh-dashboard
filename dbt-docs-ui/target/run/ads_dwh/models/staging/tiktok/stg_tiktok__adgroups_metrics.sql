

  create or replace view `hv-data`.`DE_testing`.`stg_tiktok__adgroups_metrics`
  OPTIONS()
  as select
    cast(account_id as string) as account_id,
    account_name,
    cast(adgroup_id as string) as adgroup_id,
    spend,
    impressions,
    clicks,
    conversion,
    conversion_rate,
    cost_per_conversion,
    ctr,
    cpc,
    cpm,
    checkout,
    complete_payment,
    complete_payment_rate
    -- thêm các cột metrics khác bạn cần dùng
from `hv-data`.`tiktok_data_ads_dwh`.`tiktok_ads_adgroups`;

