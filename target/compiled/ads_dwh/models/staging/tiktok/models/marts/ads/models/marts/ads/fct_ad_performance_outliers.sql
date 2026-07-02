

with fact as (
    select *
    from `hv-data`.`a_dwh_ads`.`FactAdPerformance`
    where spend is not null
),

stats as (
    select
        avg(spend) as avg_spend,
        stddev(spend) as stddev_spend
    from fact
),

outliers as (
    select
        fact.start_date,
        fact.account_id,
        fact.campaign_id,
        fact.ad_id,
        fact.platform,
        fact.spend,
        (fact.spend - stats.avg_spend) / nullif(stats.stddev_spend, 0) as z_score
    from fact
    cross join stats
)

select *
from outliers
where z_score > 3
  and start_date >= date_sub(current_date(), interval 1 day)
order by spend desc