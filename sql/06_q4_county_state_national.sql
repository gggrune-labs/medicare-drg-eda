-- 06_q4_county_state_national.sql
-- Q4: How do Bronx and Westchester hospitals compare with NY and the US, DRG by DRG?
-- Note: the national rows include Maryland, which is paid under an all-payer waiver
-- rather than IPPS rates. Consider excluding MD for a strict IPPS benchmark.

with g as (
  select drg_cd, drg_label, 'National' as geo, total_payments, total_charges, discharges
  from drg_clean
  union all
  select drg_cd, drg_label, 'New York State', total_payments, total_charges, discharges
  from drg_clean where state = 'NY'
  union all
  select drg_cd, drg_label,
    case when upper(county) = 'BRONX' then 'Bronx County' else 'Westchester County' end,
    total_payments, total_charges, discharges
  from drg_clean
  where state = 'NY' and upper(county) in ('BRONX', 'WESTCHESTER')
)
select
  drg_cd,
  drg_label,
  geo,
  sum(discharges) as discharges,
  sum(total_payments) / sum(discharges) as avg_pymt_per_stay,
  sum(total_charges) / sum(total_payments) as wtd_markup
from g
group by all
order by drg_cd, geo
