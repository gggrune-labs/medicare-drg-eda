-- 07_q5_ownership_and_rating.sql
-- Q5: Does markup differ by hospital ownership or CMS star rating?
-- Descriptive only. No causal claims.

select
  coalesce(ownership, 'Unmatched') as ownership,
  coalesce(overall_rating, 'Unmatched') as overall_rating,
  count(distinct ccn) as hospitals,
  sum(discharges) as discharges,
  sum(total_charges) / sum(total_payments) as wtd_markup,
  sum(total_payments) / sum(discharges) as avg_pymt_per_stay
from drg_clean
where state = 'NY'
group by all
order by ownership, overall_rating
