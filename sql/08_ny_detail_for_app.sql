-- 08_ny_detail_for_app.sql
-- Row-level NY table that feeds the DRG lookup in the Hex app
-- (filterable by DRG and by county or all of NY).

select
  ccn,
  hospital_name,
  city,
  county,
  ownership,
  overall_rating,
  drg_cd,
  drg_label,
  discharges,
  avg_charge,
  avg_total_pymt,
  avg_medicare_pymt,
  markup_ratio,
  medicare_share
from drg_clean
where state = 'NY'
