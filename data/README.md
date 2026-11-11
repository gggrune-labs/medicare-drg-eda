# Data

Raw data files are not committed to this repo. Download them from CMS and save them here with the file names below. They are git-ignored.

## 1. Medicare Inpatient Hospitals - by Provider and Service

- Page: https://data.cms.gov/provider-summary-by-type-of-service/medicare-inpatient-hospitals/medicare-inpatient-hospitals-by-provider-and-service
- Pick the latest data year (2024) and download the CSV.
- Save as: `inpatient_drg_2024_raw.csv`
- Data dictionary: https://data.cms.gov/resources/medicare-inpatient-hospitals-by-provider-and-service-data-dictionary-0
- Methodology: https://data.cms.gov/resources/medicare-inpatient-hospitals-methodology

## 2. Hospital General Information

- Page: https://data.cms.gov/provider-data/dataset/xubh-q36u
- Download the CSV.
- Save as: `hospital_general_info_raw.csv`

## Notes

- Load hospital IDs as text so leading zeros survive: `Rndrng_Prvdr_CCN` and `Facility ID` should both be 6-character strings.
- Don't open and re-save the raw CSVs in Excel. It can strip leading zeros from the IDs.
- Column names can change between data years. Check them against the data dictionary for the year you download.
