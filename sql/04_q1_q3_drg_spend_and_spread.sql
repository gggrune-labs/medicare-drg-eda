-- 04_q1_q3_drg_spend_and_spread.sql
-- Q1: Which DRGs drive the most Medicare inpatient spending in NY?
-- Q3: For the same DRG, how much does payment vary across NY hospitals?
--
-- One row per DRG: spend rank, share of NY spend, discharge-weighted markup,
-- and the spread of hospital-level average payments (min, median, max, max/min ratio,
-- coefficient of variation).

with d as (
  select
    drg_cd,
    drg_label,
    sum(total_payments) as total_spend,
    sum(discharges) as discharges,
    sum(total_charges) / sum(total_payments) as wtd_markup,
    count(*) as hospitals,
    min(avg_total_pymt) as min_pymt,
    median(avg_total_pymt) as median_pymt,
    max(avg_total_pymt) as max_pymt,
    stddev_samp(avg_total_pymt) / avg(avg_total_pymt) as cv
  from drg_clean
  where state = 'NY'
  group by 1, 2
)
select
  rank() over (order by total_spend desc) as spend_rank,
  *,
  total_spend / discharges as avg_pymt_per_stay,
  max_pymt / min_pymt as max_min_ratio,
  total_spend / sum(total_spend) over () as share_of_ny_spend
from d
order by spend_rank
