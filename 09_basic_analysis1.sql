
-- Q9) Find the top 10 providers with the highest number of inpatient claims.

SELECT
    Provider,
    COUNT(*) AS total_inpatient_claims
FROM train_inpatientdata
GROUP BY Provider
ORDER BY total_inpatient_claims DESC
LIMIT 10;


-- Q10) Find the top 10 providers with the highest number of outpatient claims.

SELECT
    Provider,
    COUNT(*) AS total_outpatient_claims
FROM train_outpatientdata
GROUP BY Provider
ORDER BY total_outpatient_claims DESC
LIMIT 10;


-- Q11) Find the average inpatient reimbursement amount.

SELECT
    AVG(InscClaimAmtReimbursed) AS avg_inpatient_reimbursement
FROM train_inpatientdata;


-- Q12) Find the average outpatient reimbursement amount.

SELECT
    AVG(InscClaimAmtReimbursed) AS avg_outpatient_reimbursement
FROM train_outpatientdata;


-- Q13) Find all inpatient and outpatient claims with reimbursement above 10,000.

SELECT
    ClaimID,
    Provider,
    InscClaimAmtReimbursed,
    'Inpatient' AS claim_type
FROM train_inpatientdata
WHERE InscClaimAmtReimbursed > 10000

UNION ALL

SELECT
    ClaimID,
    Provider,
    InscClaimAmtReimbursed,
    'Outpatient' AS claim_type
FROM train_outpatientdata
WHERE InscClaimAmtReimbursed > 10000;


-- Q14) Find beneficiaries who have more than one inpatient claim.

SELECT
    BeneID,
    COUNT(*) AS total_inpatient_claims
FROM train_inpatientdata
GROUP BY BeneID
HAVING COUNT(*) > 1;


-- Q15) Find the top 10 providers with the highest total reimbursement
-- from both inpatient and outpatient claims.

SELECT
    Provider,
    SUM(total_reimbursement) AS total_reimbursement
FROM
(
    SELECT
        Provider,
        InscClaimAmtReimbursed AS total_reimbursement
    FROM train_inpatientdata

    UNION ALL

    SELECT
        Provider,
        InscClaimAmtReimbursed AS total_reimbursement
    FROM train_outpatientdata
) AS all_claims
GROUP BY Provider
ORDER BY total_reimbursement DESC
LIMIT 10;


-- Q16) Find the claim with the highest reimbursement amount
-- across inpatient and outpatient tables.

SELECT
    ClaimID,
    Provider,
    InscClaimAmtReimbursed,
    claim_type
FROM
(
    SELECT
        ClaimID,
        Provider,
        InscClaimAmtReimbursed,
        'Inpatient' AS claim_type
    FROM train_inpatientdata

    UNION ALL

    SELECT
        ClaimID,
        Provider,
        InscClaimAmtReimbursed,
        'Outpatient' AS claim_type
    FROM train_outpatientdata
) AS all_claims
ORDER BY InscClaimAmtReimbursed DESC
LIMIT 1;
