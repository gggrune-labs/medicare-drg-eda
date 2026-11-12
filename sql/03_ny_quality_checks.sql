-- 03_ny_quality_checks.sql
-- Output: ny_quality_checks
-- 2024 results: weighted markup 4.97x, median hospital markup 2.73x,
-- 39 rows under 1x, 0 rows over 20x, 7 rows unmatched to the hospital file.

select
  sum(total_charges) / sum(total_payments) as ny_wtd_markup,
  (select median(m)
     from (select sum(total_charges) / sum(total_payments) as m
             from drg_clean where state = 'NY' group by ccn)) as ny_median_hospital_markup,
  sum(case when markup_ratio < 1 then 1 else 0 end) as ny_markup_under_1,
  sum(case when markup_ratio > 20 then 1 else 0 end) as ny_markup_over_20,
  sum(case when county is null then 1 else 0 end) as ny_rows_unmatched,
  count(distinct case when county is null then ccn end) as ny_hospitals_unmatched
from drg_clean
where state = 'NY'
