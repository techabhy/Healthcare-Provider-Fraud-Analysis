-- Q25: Find the top 5 providers based on their total reimbursement amount.
-- Include both inpatient and outpatient claims.

SELECT
    Provider,
    SUM(total_reimbursement) AS total_reimbursement
FROM
(
    SELECT Provider, InscClaimAmtReimbursed AS total_reimbursement
    FROM train_inpatientdata

    UNION ALL

    SELECT Provider, InscClaimAmtReimbursed AS total_reimbursement
    FROM train_outpatientdata
) AS all_claims
GROUP BY Provider
ORDER BY total_reimbursement DESC
LIMIT 5;

-- Q26: Display each provider's total number of claims
-- and total reimbursement from both inpatient and outpatient tables.

SELECT
    Provider,
    COUNT(*) AS total_claims,
    SUM(total_reimbursement) AS total_reimbursement
FROM
(
    SELECT Provider, InscClaimAmtReimbursed AS total_reimbursement
    FROM train_inpatientdata

    UNION ALL

    SELECT Provider, InscClaimAmtReimbursed AS total_reimbursement
    FROM train_outpatientdata
) AS all_claims
GROUP BY Provider
ORDER BY total_reimbursement DESC;

-- Q27: Find providers whose total reimbursement
-- is greater than the average total reimbursement of all providers.
-- Consider both inpatient and outpatient claims.

SELECT
    Provider,
    SUM(total_reimbursement) AS total_reimbursement
FROM
(
    -- Step 1: Combine inpatient and outpatient claims

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

-- Step 2: Calculate provider-wise total
GROUP BY Provider

-- Step 3: Filter providers whose total is above the average
HAVING SUM(total_reimbursement) >
(
    -- Step 4: Calculate average of all provider totals

    SELECT AVG(provider_total)
    FROM
    (
        SELECT
            Provider,
            SUM(total_reimbursement) AS provider_total
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

        ) AS claims

        GROUP BY Provider

    ) AS provider_avg

)

ORDER BY total_reimbursement DESC;


-- Q28: Rank all providers based on their total number of claims.
-- Consider both inpatient and outpatient claims.
-- Display Provider, total_claims and provider_rank.
select Provider,total_claims,
rank() over (order by total_claims desc) as provider_rank
from(
      select Provider,
       count(*) as total_claims
       from
       (
       select Provider
       from train_inpatientdata
       
       union all
       
       select Provider
       from train_outpatientdata
       ) as all_claims
       group by Provider
       )as provider_data
       limit 10;
       
-- now with ctes

with all_claims as (
    SELECT Provider
    FROM train_inpatientdata

    UNION ALL

    SELECT Provider
    FROM train_outpatientdata
),

provider_claims as (
select provider,count(*) as total_claims
from all_claims
group by provider
)

SELECT
    Provider,
    total_claims,
    RANK() OVER (ORDER BY total_claims DESC) AS provider_rank
FROM provider_claims;


-- Q29: Find the top 3 providers based on total reimbursement
-- separately for Fraud and Non-Fraud categories.
-- Display Provider, PotentialFraud, total_reimbursement and provider_rank.
-- Use ROW_NUMBER() window function.

-- Q29: Find top 3 providers based on total reimbursement
-- separately for Fraud and Non-Fraud categories.
-- Use CTE, ROW_NUMBER() and PARTITION BY.

WITH all_claims AS
(
    SELECT
        Provider,
        InscClaimAmtReimbursed AS reimbursement
    FROM train_inpatientdata

    UNION ALL

    SELECT
        Provider,
        InscClaimAmtReimbursed AS reimbursement
    FROM train_outpatientdata
),

provider_reimbursement AS
(
    SELECT
        Provider,
        SUM(reimbursement) AS total_reimbursement
    FROM all_claims
    GROUP BY Provider
),

ranked_providers AS
(
    SELECT
        pr.Provider,
        p.PotentialFraud,
        pr.total_reimbursement,

        ROW_NUMBER() OVER
        (
            PARTITION BY p.PotentialFraud
            ORDER BY pr.total_reimbursement DESC
        ) AS provider_rank

    FROM provider_reimbursement pr

    INNER JOIN train_provider p
        ON pr.Provider = p.Provider
)

SELECT *
FROM ranked_providers
WHERE provider_rank <= 3;


-- Q30: Combine inpatient and outpatient claims into one result.
-- Display ClaimID, BeneID, Provider, reimbursement and claim_type.

SELECT
    ClaimID,
    BeneID,
    Provider,
    InscClaimAmtReimbursed AS reimbursement,
    'Inpatient' AS claim_type
FROM train_inpatientdata

UNION ALL

SELECT
    ClaimID,
    BeneID,
    Provider,
    InscClaimAmtReimbursed AS reimbursement,
    'Outpatient' AS claim_type
FROM train_outpatientdata;


-- Q31: Find beneficiaries having more than 1 claim.
-- Include both inpatient and outpatient claims.

SELECT
    BeneID,
    COUNT(*) AS total_claims
FROM
(
    SELECT BeneID
    FROM train_inpatientdata

    UNION ALL

    SELECT BeneID
    FROM train_outpatientdata

) AS all_claims

GROUP BY BeneID

HAVING COUNT(*) > 1

ORDER BY total_claims DESC;

-- Q32: Find beneficiaries who have used both inpatient
-- and outpatient services.
-- Display BeneID and number of claims in each service.

SELECT
    i.BeneID,
    COUNT(DISTINCT i.ClaimID) AS inpatient_claims,
    COUNT(DISTINCT o.ClaimID) AS outpatient_claims

FROM train_inpatientdata i

INNER JOIN train_outpatientdata o
    ON i.BeneID = o.BeneID

GROUP BY i.BeneID;