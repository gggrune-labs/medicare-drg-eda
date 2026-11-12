# SQL

Queries exported from the Hex project. They run in Hex SQL cells, which use DuckDB, against the two CSVs loaded as dataframes. Run them in order: every query after `01` reads from `drg_clean`.

| File | Purpose |
| --- | --- |
| `01_clean_and_join.sql` | Clean IDs and money fields, add derived metrics, join hospital attributes. Output: `drg_clean` |
| `02_profile_national.sql` | Row counts, distinct hospitals and DRGs, duplicates, markup outliers, join match |
| `03_ny_quality_checks.sql` | NY markup (weighted and median hospital), outliers, unmatched rows |
| `04_q1_q3_drg_spend_and_spread.sql` | Q1 and Q3: DRG spend rank, share of NY spend, payment spread across hospitals |
| `05_q2_hospital_markup.sql` | Q2: charge-to-payment ratio by NY hospital |
| `06_q4_county_state_national.sql` | Q4: Bronx and Westchester vs. NY vs. national, by DRG |
| `07_q5_ownership_and_rating.sql` | Q5: markup and payment by ownership and star rating |
| `08_ny_detail_for_app.sql` | Row-level NY table behind the app's DRG lookup |

## Derived metrics

| Column | Formula |
| --- | --- |
| `total_payments` | `Tot_Dschrgs * Avg_Tot_Pymt_Amt` |
| `total_charges` | `Tot_Dschrgs * Avg_Submtd_Cvrd_Chrg` |
| `markup_ratio` | `Avg_Submtd_Cvrd_Chrg / Avg_Tot_Pymt_Amt` |
| `medicare_share` | `Avg_Mdcr_Pymt_Amt / Avg_Tot_Pymt_Amt` |

Whenever hospital-level averages are combined, they are weighted by discharges (sum of totals divided by sum of discharges), not averaged directly.
