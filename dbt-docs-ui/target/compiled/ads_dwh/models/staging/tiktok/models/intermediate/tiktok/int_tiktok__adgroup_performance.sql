with metrics as (
    select * from `hv-data`.`DE_testing`.`stg_tiktok__adgroups_metrics`
),

dim as (
    select * from `hv-data`.`DE_testing`.`stg_tiktok__adgroups_dim`
)

select
    dim.campaign_id,
    dim.campaign_name,
    metrics.adgroup_id,
    dim.adgroup_name,
    metrics.account_id,
    metrics.account_name,
    metrics.spend,
    metrics.impressions,
    metrics.clicks,
    metrics.conversion,
    metrics.conversion_rate,
    metrics.cost_per_conversion,
    metrics.ctr,
    metrics.cpc,
    metrics.cpm,
    metrics.checkout,
    metrics.complete_payment,
    metrics.complete_payment_rate
from metrics
left join dim
    on metrics.adgroup_id = dim.adgroup_id