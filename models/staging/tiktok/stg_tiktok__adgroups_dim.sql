select
    account_id,
    account_name,
    campaign_id,
    campaign_name,
    adgroup_id,
    adgroup_name,
    create_time,
    modify_time,
    budget
from {{ source('tiktok_data_ads_dwh', 'tiktok_ads_adgroups_adgroup') }}