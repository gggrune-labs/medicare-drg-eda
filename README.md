# What Does a Hospital Stay Cost Medicare in New York?

Exploratory data analysis of CMS Medicare inpatient payments by DRG (Diagnosis Related Group), focused on New York hospitals, with a closer look at the Bronx and Westchester.

**Status:** Analysis complete and built as an interactive Hex app. Headline numbers below were checked against the raw CMS file. Public app link and charts coming next.

## Key Findings (2024 data year, Original Medicare)

1. **A NY hospital stay averaged about $24,600.** Medicare inpatient stays at 125 NY hospitals came to $8.09B in total payments across 328,890 discharges.
2. **Sepsis is the single biggest cost.** Sepsis with major complications (DRG 871) accounts for $997M, or 12.3% of NY spend. The top 15 DRGs make up about 40%.
3. **The same DRG can pay several times more at one hospital than another.** Routine medical DRGs vary most: cellulitis (DRG 603) is 8.1x from the lowest-paid to the highest-paid hospital, kidney and urinary infections (DRG 690) 7.2x, and sepsis (DRG 871) 4.3x ($15,879 to $68,676 per stay). Planned procedures vary least: catheter heart valve replacement (DRG 267) is 1.6x and hip/knee replacement (DRG 470) 2.0x. The likely drivers are Medicare's standard adjustments: the local wage index, teaching add-ons (IME), safety-net add-ons (DSH) and outlier payments.
4. **Billed charges are about 5x what gets paid, but that number is skewed.** Across NY, charges run 5.0x total payments when weighted by discharges, while the median NY hospital is 2.7x. A few large, high-markup hospitals pull the weighted number up: Westchester Medical Center is 9.6x, while Jacobi (2.0x), Bellevue (1.9x) and Kings County (1.5x) are far lower.
5. **The Bronx pays well above the national average for sepsis.** DRG 871 averages about $34,300 per stay in the Bronx vs. about $18,200 nationally.

Every number above traces back to a query in [`sql/`](sql/).

## Questions

1. Which DRGs drive the most Medicare inpatient spending in New York?
2. How far apart are what hospitals bill (covered charges) and what actually gets paid?
3. For the same DRG, how much does payment vary across New York hospitals, and why?
4. How do Bronx and Westchester hospitals compare with the state and national averages?
5. Does the gap between charges and payments differ by hospital ownership or CMS star rating?

## Data

All data is public and comes from the Centers for Medicare & Medicaid Services (CMS). Raw files are not stored in this repo. See [`data/README.md`](data/README.md) for download steps.

| Dataset | Publisher | Use |
| --- | --- | --- |
| [Medicare Inpatient Hospitals - by Provider and Service](https://data.cms.gov/provider-summary-by-type-of-service/medicare-inpatient-hospitals/medicare-inpatient-hospitals-by-provider-and-service) | CMS | Main dataset: discharges, charges and payments by hospital and DRG (2024: 145,879 rows, 2,906 hospitals, 540 DRGs) |
| [Hospital General Information](https://data.cms.gov/provider-data/dataset/xubh-q36u) | CMS Provider Data Catalog | County, ownership and star rating |

## Method

1. Load both CSVs with hospital IDs as text, then clean: 6-character CCN with leading zeros, 3-character DRG code, numeric money fields.
2. Add derived metrics: total payments, total charges, charge-to-payment ratio (markup) and Medicare's share of payment.
3. Join hospital attributes on CCN = Facility ID. Only 7 of 8,310 NY rows (341 nationally) had no match. They were kept.
4. Run quality checks: no zero or negative payments and no duplicate hospital + DRG rows. Markup outliers were flagged and kept, since they are what hospitals reported (NY: 39 rows under 1x, none over 20x).
5. Answer each question in SQL (CTEs, window functions, medians, discharge-weighted averages).
6. Publish the results as an interactive Hex app with a DRG lookup by county or all of NY.

## Caveats

- Covers **Original Medicare (fee-for-service)** only. Medicare Advantage, Medicaid, commercial and uninsured patients are not included.
- Covers short-stay acute hospitals paid under the **Inpatient Prospective Payment System (IPPS)** only. Critical access, long-term care, rehab, psychiatric and 11 cancer hospitals are excluded. Maryland hospitals appear in the national file but are paid under the state's all-payer waiver.
- CMS suppresses hospital + DRG rows with **fewer than 11 discharges**, so small hospitals and rare DRGs are undercounted.
- **Covered charges are list prices**, not costs and not what anyone actually pays. Total payments include Medicare's payment plus the patient's deductible and coinsurance plus any third-party payments.
- Ownership and star-rating comparisons are descriptive only, not causal.

## Repo Structure

```
medicare-drg-eda/
├── data/        # Download instructions only (raw CSVs are git-ignored)
├── notebooks/   # Hex project exports
├── sql/         # Analysis queries in run order (see sql/README.md)
└── images/      # Chart exports used in the README and LinkedIn post
```

## Tools

Hex (SQL cells on DuckDB, charts, published app), SQL, GitHub

## Links

- Hex app: coming soon
- LinkedIn post: coming soon

## Author

Greg Grunewald · [LinkedIn](https://www.linkedin.com/in/gregory-grunewald) · [GitHub](https://github.com/gggrune-labs)
