-- Q33: Find the total number of fraud and non-fraud providers.
-- Also calculate the percentage of each category.

SELECT
    PotentialFraud,
    COUNT(*) AS total_providers,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM train_provider),
        2
    ) AS percentage
FROM train_provider
GROUP BY PotentialFraud;


-- Q34: Calculate the total inpatient and outpatient reimbursement
-- made by fraud-labelled providers.

SELECT
    p.PotentialFraud,
    SUM(c.reimbursement) AS total_reimbursement
FROM
(
    SELECT Provider, InscClaimAmtReimbursed AS reimbursement
    FROM train_inpatientdata

    UNION ALL

    SELECT Provider, InscClaimAmtReimbursed AS reimbursement
    FROM train_outpatientdata
) AS c
INNER JOIN train_provider p
    ON c.Provider = p.Provider
WHERE p.PotentialFraud = 'Yes'
GROUP BY p.PotentialFraud;

-- Q35: Compare total claims, average reimbursement
-- and total reimbursement between fraud and non-fraud providers.

SELECT
    p.PotentialFraud,
    COUNT(*) AS total_claims,
    ROUND(AVG(c.reimbursement), 2) AS avg_reimbursement,
    SUM(c.reimbursement) AS total_reimbursement
FROM
(
    SELECT Provider, InscClaimAmtReimbursed AS reimbursement
    FROM train_inpatientdata

    UNION ALL

    SELECT Provider, InscClaimAmtReimbursed AS reimbursement
    FROM train_outpatientdata
) AS c
INNER JOIN train_provider p
    ON c.Provider = p.Provider
GROUP BY p.PotentialFraud;


-- Q36: Find the top 10 fraud-labelled providers
-- based on their average claim reimbursement.

SELECT
    p.Provider,
    AVG(c.reimbursement) AS avg_reimbursement,
    COUNT(*) AS total_claims
FROM
(
    SELECT Provider, InscClaimAmtReimbursed AS reimbursement
    FROM train_inpatientdata

    UNION ALL

    SELECT Provider, InscClaimAmtReimbursed AS reimbursement
    FROM train_outpatientdata
) AS c
INNER JOIN train_provider p
    ON c.Provider = p.Provider
WHERE p.PotentialFraud = 'Yes'
GROUP BY p.Provider
ORDER BY avg_reimbursement DESC
LIMIT 10;


-- Q37: Find the top 10 beneficiaries based on
-- their total reimbursement from inpatient and outpatient claims.

SELECT
    BeneID,
    SUM(reimbursement) AS total_reimbursement,
    COUNT(*) AS total_claims
FROM
(
    SELECT BeneID, InscClaimAmtReimbursed AS reimbursement
    FROM train_inpatientdata

    UNION ALL

    SELECT BeneID, InscClaimAmtReimbursed AS reimbursement
    FROM train_outpatientdata
) AS all_claims
GROUP BY BeneID
ORDER BY total_reimbursement DESC
LIMIT 10;

-- Q38: Find providers having both high claim volume
-- and high total reimbursement.
-- Consider providers above the overall average
-- claim count and average total reimbursement.

WITH provider_summary AS
(
    SELECT
        Provider,
        COUNT(*) AS total_claims,
        SUM(reimbursement) AS total_reimbursement
    FROM
    (
        SELECT Provider, InscClaimAmtReimbursed AS reimbursement
        FROM train_inpatientdata

        UNION ALL

        SELECT Provider, InscClaimAmtReimbursed AS reimbursement
        FROM train_outpatientdata
    ) AS all_claims
    GROUP BY Provider
)

SELECT *
FROM provider_summary
WHERE total_claims >
(
    SELECT AVG(total_claims)
    FROM provider_summary
)
AND total_reimbursement >
(
    SELECT AVG(total_reimbursement)
    FROM provider_summary
)
ORDER BY total_reimbursement DESC;


-- Q39: Compare the total number of inpatient and outpatient claims.
-- Also calculate their percentage contribution.

SELECT
    claim_type,
    COUNT(*) AS total_claims,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM
            (
                SELECT ClaimID FROM train_inpatientdata
                UNION ALL
                SELECT ClaimID FROM train_outpatientdata
            ) AS all_claims
        ),
        2
    ) AS percentage
FROM
(
    SELECT ClaimID, 'Inpatient' AS claim_type
    FROM train_inpatientdata

    UNION ALL

    SELECT ClaimID, 'Outpatient' AS claim_type
    FROM train_outpatientdata
) AS claims
GROUP BY claim_type;


-- Q40: Prepare an overall fraud analysis summary.
-- Display fraud category, provider count, total claims,
-- total reimbursement and average reimbursement.

SELECT
    p.PotentialFraud,
    COUNT(DISTINCT p.Provider) AS total_providers,
    COUNT(*) AS total_claims,
    SUM(c.reimbursement) AS total_reimbursement,
    ROUND(AVG(c.reimbursement), 2) AS avg_reimbursement
FROM
(
    SELECT Provider, InscClaimAmtReimbursed AS reimbursement
    FROM train_inpatientdata

    UNION ALL

    SELECT Provider, InscClaimAmtReimbursed AS reimbursement
    FROM train_outpatientdata
) AS c
INNER JOIN train_provider p
    ON c.Provider = p.Provider
GROUP BY p.PotentialFraud;