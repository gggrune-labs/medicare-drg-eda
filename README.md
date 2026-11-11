# What Does a Hospital Stay Cost Medicare in New York?

Exploratory data analysis of CMS Medicare inpatient payments by DRG (Diagnosis Related Group), focused on New York hospitals, with a closer look at the Bronx and Westchester.

**Status:** In progress. Findings will be added here once the analysis is complete and verified.

## Questions

1. Which DRGs drive the most Medicare inpatient spending in New York?
2. How far apart are what hospitals bill (covered charges) and what actually gets paid?
3. For the same DRG, how much does payment vary across New York hospitals, and why?
4. How do Bronx and Westchester hospitals compare with the state and national averages?
5. Does the gap between charges and payments differ by hospital ownership, type or CMS star rating?

## Data

All data is public and comes from the Centers for Medicare & Medicaid Services (CMS). Raw files are not stored in this repo. See [`data/README.md`](data/README.md) for download steps.

| Dataset | Publisher | Use |
| --- | --- | --- |
| [Medicare Inpatient Hospitals - by Provider and Service](https://data.cms.gov/provider-summary-by-type-of-service/medicare-inpatient-hospitals/medicare-inpatient-hospitals-by-provider-and-service) | CMS | Main dataset: discharges, charges and payments by hospital and DRG |
| [Hospital General Information](https://data.cms.gov/provider-data/dataset/xubh-q36u) | CMS Provider Data Catalog | County, hospital type, ownership and star rating |

## Method

1. Profile the raw data (row counts, types, nulls, distinct hospitals and DRGs).
2. Clean and standardize (6-character hospital IDs, numeric money fields).
3. Filter to New York and join hospital attributes on the CMS Certification Number (CCN).
4. Add derived metrics: total payments, total charges, charge-to-payment ratio, Medicare share of payment.
5. Answer each question in SQL (CTEs, window functions, percentiles).
6. Publish the results as an interactive Hex app.

## Caveats

- Covers **Original Medicare (fee-for-service)** only. Medicare Advantage patients are not included.
- Covers hospitals paid under the **Inpatient Prospective Payment System (IPPS)** only.
- CMS suppresses rows with **fewer than 11 discharges**, so small hospitals and rare DRGs undercount.
- **Covered charges are list prices**, not costs and not what anyone actually pays.

## Repo Structure

```
medicare-drg-eda/
├── data/        # Download instructions only (raw CSVs are git-ignored)
├── notebooks/   # Hex project exports
├── sql/         # Analysis queries, one file per question
└── images/      # Chart exports used in the README and LinkedIn post
```

## Tools

Hex (SQL + Python cells, charts, published app), pandas, GitHub

## Links

- Hex app: coming soon
- LinkedIn post: coming soon

## Author

Greg Grunewald · [LinkedIn](https://www.linkedin.com/in/gregory-grunewald) · [GitHub](https://github.com/gggrune-labs)
