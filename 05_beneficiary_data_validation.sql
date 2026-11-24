#data analyze and cleaning 
#1)
SELECT 
    COUNT(*) AS total_rows,
    COUNT(BeneID) AS non_null_ids,
    COUNT(DISTINCT BeneID) AS unique_ids,
    COUNT(*) - COUNT(DISTINCT BeneID) AS extra_occurrences
FROM
    train_beneficiarydata;
    
#2)
SELECT 
    COUNT(*) AS total_records,
    SUM(BeneID IS NULL) AS missing_BeneID,
    SUM(DOB IS NULL) AS missing_DOB,
    SUM(DOD IS NULL) AS missing_DOD,
    SUM(Gender IS NULL) AS missing_Gender,
    SUM(Race IS NULL) AS missing_Race,
    SUM(RenalDiseaseIndicator IS NULL) AS missing_RenalDiseaseIndicator,
    SUM(State IS NULL) AS missing_State,
    SUM(County IS NULL) AS missing_County
FROM
    train_beneficiarydata;

#3)
SELECT 
    SUM(NoOfMonths_PartACov IS NULL) AS missing_PartA,
    SUM(NoOfMonths_PartBCov IS NULL) AS missing_PartB,
    SUM(ChronicCond_Alzheimer IS NULL) AS missing_Alzheimer,
    SUM(ChronicCond_Heartfailure IS NULL) AS missing_Heartfailure,
    SUM(ChronicCond_KidneyDisease IS NULL) AS missing_KidneyDisease,
    SUM(ChronicCond_Cancer IS NULL) AS missing_Cancer,
    SUM(ChronicCond_ObstrPulmonary IS NULL) AS missing_Pulmonary,
    SUM(ChronicCond_Depression IS NULL) AS missing_Depression,
    SUM(ChronicCond_Diabetes IS NULL) AS missing_Diabetes
FROM
    train_beneficiarydata;

#4)
-- Check NULL values in remaining columns
SELECT 
    SUM(ChronicCond_IschemicHeart IS NULL) AS missing_IschemicHeart,
    SUM(ChronicCond_Osteoporasis IS NULL) AS missing_Osteoporosis,
    SUM(ChronicCond_rheumatoidarthritis IS NULL) AS missing_RheumatoidArthritis,
    SUM(ChronicCond_stroke IS NULL) AS missing_Stroke,
    SUM(IPAnnualReimbursementAmt IS NULL) AS missing_IPReimbursement,
    SUM(IPAnnualDeductibleAmt IS NULL) AS missing_IPDeductible,
    SUM(OPAnnualReimbursementAmt IS NULL) AS missing_OPReimbursement,
    SUM(OPAnnualDeductibleAmt IS NULL) AS missing_OPDeductible
FROM
    train_beneficiarydata;

#5) Date Validation
SELECT 
    SUM(DOB > CURRENT_DATE()) AS future_DOB,
    SUM(DOD < DOB) AS DOD_before_DOB,
    SUM(DOD > CURRENT_DATE()) AS future_DOD
FROM
    train_beneficiarydata;
    
#6)
SELECT 
    SUM(IPAnnualReimbursementAmt < 0) AS negative_IP_reimbursement,
    SUM(IPAnnualDeductibleAmt < 0) AS negative_IP_deductible,
    SUM(OPAnnualReimbursementAmt < 0) AS negative_OP_reimbursement,
    SUM(OPAnnualDeductibleAmt < 0) AS negative_OP_deductible
FROM
    train_beneficiarydata;

#7)
SELECT 
    BeneID,
    IPAnnualReimbursementAmt,
    IPAnnualDeductibleAmt,
    OPAnnualReimbursementAmt,
    OPAnnualDeductibleAmt
FROM
    train_beneficiarydata
WHERE
    IPAnnualReimbursementAmt < 0
        OR OPAnnualReimbursementAmt < 0;
        
#8) 
SELECT 
    MIN(IPAnnualReimbursementAmt) AS min_IP_amount,
    MAX(IPAnnualReimbursementAmt) AS max_IP_amount,
    MIN(OPAnnualReimbursementAmt) AS min_OP_amount,
    MAX(OPAnnualReimbursementAmt) AS max_OP_amount
FROM
    train_beneficiarydata
WHERE
    IPAnnualReimbursementAmt < 0
        OR OPAnnualReimbursementAmt < 0;

#9)
SELECT
    BeneID,
    IPAnnualReimbursementAmt,
    OPAnnualReimbursementAmt
FROM train_beneficiarydata
WHERE IPAnnualReimbursementAmt < 0
   OR OPAnnualReimbursementAmt < 0
ORDER BY IPAnnualReimbursementAmt ASC;

#10)
-- Gender
SELECT 'Gender' AS column_name,
       CAST(Gender AS CHAR) AS column_value,
       COUNT(*) AS total_records
FROM train_beneficiarydata
GROUP BY Gender

UNION ALL

-- Race
SELECT 'Race',
       CAST(Race AS CHAR),
       COUNT(*)
FROM train_beneficiarydata
GROUP BY Race

UNION ALL

-- Renal Disease Indicator
SELECT 'RenalDiseaseIndicator',
       RenalDiseaseIndicator,
       COUNT(*)
FROM train_beneficiarydata
GROUP BY RenalDiseaseIndicator

UNION ALL

-- Chronic Conditions
SELECT 'ChronicCond_Alzheimer',
       CAST(ChronicCond_Alzheimer AS CHAR),
       COUNT(*)
FROM train_beneficiarydata
GROUP BY ChronicCond_Alzheimer

UNION ALL

SELECT 'ChronicCond_Heartfailure',
       CAST(ChronicCond_Heartfailure AS CHAR),
       COUNT(*)
FROM train_beneficiarydata
GROUP BY ChronicCond_Heartfailure

UNION ALL

SELECT 'ChronicCond_KidneyDisease',
       CAST(ChronicCond_KidneyDisease AS CHAR),
       COUNT(*)
FROM train_beneficiarydata
GROUP BY ChronicCond_KidneyDisease

UNION ALL

SELECT 'ChronicCond_Cancer',
       CAST(ChronicCond_Cancer AS CHAR),
       COUNT(*)
FROM train_beneficiarydata
GROUP BY ChronicCond_Cancer

UNION ALL

SELECT 'ChronicCond_ObstrPulmonary',
       CAST(ChronicCond_ObstrPulmonary AS CHAR),
       COUNT(*)
FROM train_beneficiarydata
GROUP BY ChronicCond_ObstrPulmonary

UNION ALL

SELECT 'ChronicCond_Depression',
       CAST(ChronicCond_Depression AS CHAR),
       COUNT(*)
FROM train_beneficiarydata
GROUP BY ChronicCond_Depression

UNION ALL

SELECT 'ChronicCond_Diabetes',
       CAST(ChronicCond_Diabetes AS CHAR),
       COUNT(*)
FROM train_beneficiarydata
GROUP BY ChronicCond_Diabetes

UNION ALL

SELECT 'ChronicCond_IschemicHeart',
       CAST(ChronicCond_IschemicHeart AS CHAR),
       COUNT(*)
FROM train_beneficiarydata
GROUP BY ChronicCond_IschemicHeart

UNION ALL

SELECT 'ChronicCond_Osteoporasis',
       CAST(ChronicCond_Osteoporasis AS CHAR),
       COUNT(*)
FROM train_beneficiarydata
GROUP BY ChronicCond_Osteoporasis

UNION ALL

SELECT 'ChronicCond_rheumatoidarthritis',
       CAST(ChronicCond_rheumatoidarthritis AS CHAR),
       COUNT(*)
FROM train_beneficiarydata
GROUP BY ChronicCond_rheumatoidarthritis

UNION ALL

SELECT 'ChronicCond_stroke',
       CAST(ChronicCond_stroke AS CHAR),
       COUNT(*)
FROM train_beneficiarydata
GROUP BY ChronicCond_stroke;

#11)
SELECT
    SUM(NoOfMonths_PartACov < 0 OR NoOfMonths_PartACov > 12)
        AS invalid_PartA_months,

    SUM(NoOfMonths_PartBCov < 0 OR NoOfMonths_PartBCov > 12)
        AS invalid_PartB_months

FROM train_beneficiarydata;

#12)
DESCRIBE train_beneficiarydata;