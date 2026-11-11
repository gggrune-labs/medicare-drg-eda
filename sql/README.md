# SQL

One file per step, exported from the Hex project.

| File | Purpose |
| --- | --- |
| `01_profile.sql` | Row counts, nulls, distinct hospitals and DRGs |
| `02_ny_slice_and_join.sql` | New York filter and hospital attribute join |
| `03_derived_metrics.sql` | Total payments, total charges, charge-to-payment ratio |
| `04_q1_top_drgs_by_spend.sql` | Q1: top DRGs by Medicare spending |
| `05_q2_charges_vs_payments.sql` | Q2: charge-to-payment gap |
| `06_q3_payment_variation.sql` | Q3: payment spread for the same DRG |
| `07_q4_bronx_westchester.sql` | Q4: county vs. state vs. national |
| `08_q5_by_hospital_attributes.sql` | Q5: gap by ownership, type and star rating |

Files are added as each step is finished.
