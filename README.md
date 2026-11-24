# Healthcare Provider Fraud Detection Analysis

**A SQL Data Analytics Project using MySQL**

## 1. Project Overview

This project focuses on analyzing healthcare insurance claims and identifying patterns associated with potentially fraudulent healthcare providers using MySQL.

The analysis uses beneficiary information, inpatient claims, outpatient claims, and provider fraud labels to explore reimbursement patterns, provider performance, and potential fraud indicators.

The project includes data importing, cleaning, validation, SQL analysis, and business insights.

## 2. Project Objectives

- Analyze healthcare insurance claims.
- Identify fraud-labelled and non-fraud-labelled providers.
- Compare inpatient and outpatient claims.
- Analyze provider-wise reimbursement patterns.
- Identify providers with high claim volumes and reimbursements.
- Generate meaningful business insights using SQL.

## 3. Dataset Information

**Dataset Name:** Healthcare Provider Fraud Detection Analysis

**Dataset Source:** [Kaggle – Healthcare Provider Fraud Detection Analysis](https://www.kaggle.com/datasets/rohitrox/healthcare-provider-fraud-detection-analysis)

The project uses four cleaned datasets:

| Dataset | Records |
|---|---:|
| Beneficiary | 138,556 |
| Inpatient Claims | 40,474 |
| Outpatient Claims | 517,737 |
| Provider | 5,410 |

**Total Claims Analyzed:** 558,211

The CSV files are not included in this repository. Download the dataset from the original source and prepare the cleaned CSV files before running the import scripts.

## 4. Database Tables

The project contains four MySQL tables:

**1. train_beneficiarydata**
- Beneficiary ID
- Date of Birth and Date of Death
- Gender and Race
- Chronic health conditions
- Annual reimbursement and deductible amounts

**2. train_inpatientdata**
- Claim ID
- Beneficiary ID
- Provider ID
- Claim start and end dates
- Admission and discharge dates
- Diagnosis and procedure codes
- Reimbursement and deductible amounts

**3. train_outpatientdata**
- Claim ID
- Beneficiary ID
- Provider ID
- Claim dates
- Diagnosis and procedure codes
- Reimbursement and deductible amounts

**4. train_provider**
- Provider ID
- PotentialFraud (Yes/No)

## 5. Data Cleaning and Validation

Performed data preparation and validation using SQL.

**Data Cleaning:**
- Imported CSV datasets into MySQL.
- Converted date columns into appropriate DATE formats.
- Handled empty date values.
- Prepared tables using suitable data types.

**Data Validation:**
- Checked missing and NULL values.
- Checked duplicate beneficiary IDs and claim IDs.
- Validated date formats and date ranges.
- Checked negative reimbursement and deductible values.
- Validated categorical values.
- Checked beneficiary and provider relationships.
- Reviewed table structures and data types.

## 6. SQL Analysis – 40 Questions

A total of 40 SQL questions were solved and organized into four sections.

| Section | Questions | Focus |
|---|---|---|
| Basic Analysis | Q1–Q16 | Filtering and aggregate analysis |
| Joins Analysis | Q17–Q24 | Combining multiple tables |
| Advanced SQL | Q25–Q32 | Subqueries, CTEs and window functions |
| Business Insights | Q33–Q40 | Fraud and reimbursement analysis |

## 7. SQL Concepts Used

- SELECT, WHERE, ORDER BY
- GROUP BY and HAVING
- Aggregate Functions: COUNT, SUM, AVG
- INNER JOIN and LEFT JOIN
- UNION and UNION ALL
- Subqueries
- Common Table Expressions (CTEs)
- Window Functions: RANK(), ROW_NUMBER()
- PARTITION BY
- Data validation queries

## 8. Key Findings

- Total healthcare providers: **5,410**
- Fraud-labelled providers: **506**
- Non-fraud-labelled providers: **4,904**
- Fraud-labelled providers represent approximately **9.35%** of all providers.
- Total inpatient claims: **40,474**
- Total outpatient claims: **517,737**
- All inpatient and outpatient claims matched their beneficiary and provider records during relationship validation.

## 9. Tools and Technologies

- MySQL
- MySQL Workbench
- SQL
- Google Colab (Data Preparation)

## 10. Repository Structure

```text
Healthcare-Provider-Fraud-Analysis/
│
├── 01_beneficiary_import_cleaning.sql
├── 02_inpatient_import_cleaning.sql
├── 03_provider_import_cleaning.sql
├── 04_outpatient_import_cleaning.sql
│
├── 05_beneficiary_data_validation.sql
├── 06_inpatient_data_validation.sql
├── 07_outpatient_data_validation.sql
├── 08_provider_data_validation.sql
│
├── 09_basic_analysis1.sql
├── 10_joins_analysis.sql
├── 11_advanced_sql.sql
├── 12_business_insights.sql
│
├── schema.sql
├── README.md
└── .gitignore
```

## 11. How to Run This Project

1. Download the dataset from the Kaggle source.
2. Install MySQL and MySQL Workbench.
3. Create the `healthcare_fraud_analysis` database.
4. Execute `schema.sql` to create the four tables.
5. Prepare the cleaned CSV files.
6. Update the CSV file paths in the import scripts.
7. Execute the data import and cleaning scripts.
8. Run the data validation scripts.
9. Execute the SQL analysis scripts to explore business insights.

## 12. Disclaimer

The `PotentialFraud` column represents the existing fraud labels provided in the dataset. This project analyzes those labels and related claim patterns; it does not independently prove that a provider committed fraud.

## 13. Author

**Abhay Kokani**

- GitHub: [techabhy](https://github.com/techabhy)
- LinkedIn: [Abhay Kokani](https://www.linkedin.com/in/abhay-kokani-890816373/)
