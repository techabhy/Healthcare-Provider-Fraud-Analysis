
-- Q1) Find the total number of beneficiaries.

SELECT
    COUNT(*) AS total_beneficiaries
FROM train_beneficiarydata;


-- Q2) Find the total number of inpatient claims.

SELECT
    COUNT(*) AS total_inpatient_claims
FROM train_inpatientdata;


-- Q3) Find the total number of outpatient claims.

SELECT
    COUNT(*) AS total_outpatient_claims
FROM train_outpatientdata;


-- Q4) Find the total number of healthcare providers.

SELECT
    COUNT(*) AS total_providers
FROM train_provider;


-- Q5) Find the total number of providers marked as PotentialFraud = 'Yes'.

SELECT
    COUNT(*) AS fraud_providers
FROM train_provider
WHERE PotentialFraud = 'Yes';


-- Q6) Find the total number of providers marked as PotentialFraud = 'No'.

SELECT
    COUNT(*) AS non_fraud_providers
FROM train_provider
WHERE PotentialFraud = 'No';


-- Q7) Find the total inpatient reimbursement amount.

SELECT
    SUM(InscClaimAmtReimbursed) AS total_inpatient_reimbursement
FROM train_inpatientdata;


-- Q8) Find the total outpatient reimbursement amount.

SELECT
    SUM(InscClaimAmtReimbursed) AS total_outpatient_reimbursement
FROM train_outpatientdata;
