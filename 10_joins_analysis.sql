#Question: Display all inpatient claims along with their provider's fraud status (PotentialFraud).

SELECT 
    i.ClaimID AS inpatient_claim_id,
    i.BeneID,
    i.Provider,
    i.InscClaimAmtReimbursed,
    p.PotentialFraud
FROM
    train_inpatientdata i
        LEFT JOIN
    train_provider p ON i.Provider = p.Provider;
    
#Q18) Display all Outpatient claims with Provider Fraud Status.
SELECT 
    o.ClaimID AS outpatient_claim_id,
    o.BeneID,
    o.Provider,
    o.InscClaimAmtReimbursed,
    p.PotentialFraud
FROM
    train_outpatientdata o
        LEFT JOIN
    train_provider p ON o.Provider = p.Provider;
    

#Q19) Find the number of Inpatient claims submitted by Fraud vs Non-Fraud providers.
SELECT 
    p.PotentialFraud, COUNT(*) AS total_inpatient_claims
FROM
    train_inpatientdata i
        INNER JOIN
    train_provider p ON i.Provider = p.Provider
GROUP BY p.PotentialFraud;


#Q20) Find the number of Outpatient claims submitted by Fraud vs Non-Fraud providers.
SELECT 
    p.PotentialFraud, COUNT(*) AS total_outpatient_claims
FROM
    train_outpatientdata o
        INNER JOIN
    train_provider p ON o.Provider = p.Provider
GROUP BY p.PotentialFraud;

#Q21) Display Beneficiary details along with their Inpatient claims.
SELECT 
    b.BeneID,
    b.DOB,
    b.Gender,
    b.Race,
    i.ClaimID,
    i.Provider,
    i.InscClaimAmtReimbursed
FROM
    train_beneficiarydata b
        INNER JOIN
    train_inpatientdata i ON b.BeneID = i.BeneID;

#Q22) Display Beneficiary details along with their Outpatient claims.
SELECT
    b.BeneID,
    b.DOB,
    b.Gender,
    b.Race,
    o.ClaimID,
    o.Provider,
    o.InscClaimAmtReimbursed
FROM train_beneficiarydata b
INNER JOIN train_outpatientdata o
    ON b.BeneID = o.BeneID;
    

#Q23) Find the total reimbursement paid to Fraud-labelled providers.

SELECT
    SUM(i.InscClaimAmtReimbursed) AS inpatient_reimbursement
FROM train_inpatientdata i
INNER JOIN train_provider p
    ON i.Provider = p.Provider
WHERE p.PotentialFraud = 'Yes';

#Q24) Compare the average claim reimbursement between Fraud and Non-Fraud providers.
SELECT
    p.PotentialFraud,
    AVG(c.InscClaimAmtReimbursed) AS avg_reimbursement
FROM
(
    SELECT Provider, InscClaimAmtReimbursed
    FROM train_inpatientdata

    UNION ALL

    SELECT Provider, InscClaimAmtReimbursed
    FROM train_outpatientdata
) AS c
INNER JOIN train_provider p
    ON c.Provider = p.Provider
GROUP BY p.PotentialFraud;