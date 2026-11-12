-- 02_profile_national.sql
-- Profile and data quality checks on the national table (drg_clean).
-- 2024 results: 145,879 rows, no zero or negative payments, no duplicate CCN + DRG rows.
-- National markup outliers: 223 rows under 1x, 289 rows over 20x (kept and flagged).
-- 341 national rows did not match the hospital file (7 of them in NY, see 03).

select
  (select count(*) from MUP_INP_RY26_P03_V10_DY24_PrvSvc) as raw_rows,
  (select count(*) from MUP_INP_RY26_P03_V10_DY24_PrvSvc where Avg_Tot_Pymt_Amt <= 0) as nonpositive_payments,
  count(*) as clean_rows,
  count(distinct ccn) as hospitals_national,
  count(distinct drg_cd) as drgs_national,
  count(distinct state) as states,
  sum(case when markup_ratio < 1 then 1 else 0 end) as markup_under_1,
  sum(case when markup_ratio > 20 then 1 else 0 end) as markup_over_20,
  count(*) - count(distinct ccn || '|' || drg_cd) as duplicate_ccn_drg,
  sum(case when county is null then 1 else 0 end) as rows_unmatched_join,
  count(distinct case when state = 'NY' then ccn end) as ny_hospitals,
  count(distinct case when state = 'NY' then drg_cd end) as ny_drgs,
  sum(case when state = 'NY' then discharges end) as ny_discharges,
  sum(case when state = 'NY' then total_payments end) as ny_total_payments
from drg_clean
