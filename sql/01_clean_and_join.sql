-- 01_clean_and_join.sql
-- Output: drg_clean (national, one row per hospital + DRG)
-- Dialect: DuckDB (Hex SQL cells on dataframes)
-- Inputs: MUP_INP_RY26_P03_V10_DY24_PrvSvc (CMS Provider and Service, 2024 data year)
--         Hospital_General_Information (CMS Provider Data Catalog)
--
-- Cleans IDs (6-character CCN with leading zeros, 3-character DRG), casts the money
-- columns, adds the derived metrics and LEFT JOINs county, ownership and star rating.
-- Rows with zero or negative total payments are dropped (there were none in 2024).

select
  lpad(trim(cast(Rndrng_Prvdr_CCN as varchar)), 6, '0') as ccn,
  trim(Rndrng_Prvdr_Org_Name) as hospital_name,
  trim(Rndrng_Prvdr_City) as city,
  Rndrng_Prvdr_State_Abrvtn as state,
  lpad(trim(cast(DRG_Cd as varchar)), 3, '0') as drg_cd,
  trim(DRG_Desc) as drg_desc,
  lpad(trim(cast(DRG_Cd as varchar)), 3, '0') || ' - ' || trim(DRG_Desc) as drg_label,
  cast(Tot_Dschrgs as double) as discharges,
  cast(Avg_Submtd_Cvrd_Chrg as double) as avg_charge,
  cast(Avg_Tot_Pymt_Amt as double) as avg_total_pymt,
  cast(Avg_Mdcr_Pymt_Amt as double) as avg_medicare_pymt,
  cast(Tot_Dschrgs as double) * cast(Avg_Tot_Pymt_Amt as double) as total_payments,
  cast(Tot_Dschrgs as double) * cast(Avg_Submtd_Cvrd_Chrg as double) as total_charges,
  cast(Avg_Submtd_Cvrd_Chrg as double) / nullif(cast(Avg_Tot_Pymt_Amt as double), 0) as markup_ratio,
  cast(Avg_Mdcr_Pymt_Amt as double) / nullif(cast(Avg_Tot_Pymt_Amt as double), 0) as medicare_share,
  h."County/Parish" as county,
  h."Hospital Ownership" as ownership,
  h."Hospital overall rating" as overall_rating
from MUP_INP_RY26_P03_V10_DY24_PrvSvc p
left join Hospital_General_Information h
  on lpad(trim(cast(p.Rndrng_Prvdr_CCN as varchar)), 6, '0')
   = lpad(trim(cast(h."Facility ID" as varchar)), 6, '0')
where cast(Avg_Tot_Pymt_Amt as double) > 0
