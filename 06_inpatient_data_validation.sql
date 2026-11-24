#1)
SELECT
    COUNT(*) AS total_records,
    SUM(ClaimID IS NULL) AS missing_ClaimID,
    SUM(BeneID IS NULL) AS missing_BeneID,
    SUM(Provider IS NULL) AS missing_Provider
FROM train_inpatientdata;

#2)
SELECT
    COUNT(*) AS total_rows,
    COUNT(ClaimID) AS non_null_claims,
    COUNT(DISTINCT ClaimID) AS unique_claims
FROM train_inpatientdata;

#3)
SELECT
    SUM(ClaimStartDt IS NULL) AS missing_claim_start,
    SUM(ClaimEndDt IS NULL) AS missing_claim_end,
    SUM(AdmissionDt IS NULL) AS missing_admission,
    SUM(DischargeDt IS NULL) AS missing_discharge,

    SUM(ClaimEndDt < ClaimStartDt) AS invalid_claim_dates,
    SUM(DischargeDt < AdmissionDt) AS invalid_stay_dates

FROM train_inpatientdata;

#4)
SELECT
    SUM(InscClaimAmtReimbursed < 0) AS negative_reimbursement,
    SUM(DeductibleAmtPaid < 0) AS negative_deductible
FROM train_inpatientdata;

#5)
SELECT 
    COUNT(*) AS total_inpatient_records,
    COUNT(b.BeneID) AS matched_beneficiaries,
    COUNT(*) - COUNT(b.BeneID) AS unmatched_beneficiaries
FROM
    train_inpatientdata i
        LEFT JOIN
    train_beneficiarydata b ON i.BeneID = b.BeneID;
    
#6)
SELECT
    COUNT(*) AS total_inpatient_records,
    COUNT(p.Provider) AS matched_providers,
    COUNT(*) - COUNT(p.Provider) AS unmatched_providers
FROM train_inpatientdata i
LEFT JOIN train_provider p
    ON i.Provider = p.Provider;