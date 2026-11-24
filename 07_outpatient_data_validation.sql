#1)
SELECT
    COUNT(*) AS total_records,
    SUM(ClaimID IS NULL) AS missing_ClaimID,
    SUM(BeneID IS NULL) AS missing_BeneID,
    SUM(Provider IS NULL) AS missing_Provider
FROM train_outpatientdata;

#2)
SELECT
    COUNT(*) AS total_rows,
    COUNT(ClaimID) AS non_null_claims,
    COUNT(DISTINCT ClaimID) AS unique_claims,
    COUNT(ClaimID) - COUNT(DISTINCT ClaimID) AS extra_occurrences
FROM train_outpatientdata;

#3)
SELECT
    SUM(ClaimStartDt IS NULL) AS missing_claim_start,
    SUM(ClaimEndDt IS NULL) AS missing_claim_end,
    SUM(ClaimEndDt < ClaimStartDt) AS invalid_claim_dates
FROM train_outpatientdata;

#4)
SELECT
    SUM(InscClaimAmtReimbursed < 0) AS negative_reimbursement,
    SUM(DeductibleAmtPaid < 0) AS negative_deductible
FROM train_outpatientdata;

#5)
SELECT
    COUNT(*) AS total_outpatient_records,
    COUNT(b.BeneID) AS matched_beneficiaries,
    COUNT(*) - COUNT(b.BeneID) AS unmatched_beneficiaries
FROM train_outpatientdata o
LEFT JOIN train_beneficiarydata b
    ON o.BeneID = b.BeneID;
    
#6)
SELECT
    COUNT(*) AS total_outpatient_records,
    COUNT(p.Provider) AS matched_providers,
    COUNT(*) - COUNT(p.Provider) AS unmatched_providers
FROM train_outpatientdata o
LEFT JOIN train_provider p
    ON o.Provider = p.Provider;