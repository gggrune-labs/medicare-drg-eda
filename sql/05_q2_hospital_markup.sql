-- 05_q2_hospital_markup.sql
-- Q2: How far apart are billed charges and actual payments, hospital by hospital?
-- Markup = total charges / total payments, weighted by discharges.
-- Covered charges are list prices, not what anyone pays.

select
  ccn,
  hospital_name,
  city,
  county,
  ownership,
  overall_rating,
  sum(discharges) as discharges,
  sum(total_payments) as total_payments,
  sum(total_charges) as total_charges,
  sum(total_charges) / sum(total_payments) as wtd_markup
from drg_clean
where state = 'NY'
group by all
order by total_payments desc
