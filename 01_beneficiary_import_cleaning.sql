
TRUNCATE TABLE healthcare_fraud_analysis.train_beneficiarydata;
CREATE TABLE train_beneficiarydata (
    BeneID VARCHAR(20) PRIMARY KEY,
    DOB DATE,
    DOD DATE,
    Gender INT,
    Race INT,
    RenalDiseaseIndicator VARCHAR(5),
    State INT,
    County INT,
    NoOfMonths_PartACov INT,
    NoOfMonths_PartBCov INT,
    ChronicCond_Alzheimer INT,
    ChronicCond_Heartfailure INT,
    ChronicCond_KidneyDisease INT,
    ChronicCond_Cancer INT,
    ChronicCond_ObstrPulmonary INT,
    ChronicCond_Depression INT,
    ChronicCond_Diabetes INT,
    ChronicCond_IschemicHeart INT,
    ChronicCond_Osteoporasis INT,
    ChronicCond_rheumatoidarthritis INT,
    ChronicCond_stroke INT,
    IPAnnualReimbursementAmt BIGINT,
    IPAnnualDeductibleAmt BIGINT,
    OPAnnualReimbursementAmt BIGINT,
    OPAnnualDeductibleAmt BIGINT
);

LOAD DATA LOCAL INFILE 'C:/Users/hp/Desktop/Healthcare_fraud_project/Beneficiary_Clean.csv'
INTO TABLE healthcare_fraud_analysis.train_beneficiarydata
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SHOW GLOBAL VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;

SELECT BeneID, DOB, DOD
FROM healthcare_fraud_analysis.train_beneficiarydata
LIMIT 10;

ALTER TABLE healthcare_fraud_analysis.train_beneficiarydata
MODIFY DOB VARCHAR(20),
MODIFY DOD VARCHAR(20);

SELECT
    BeneID,
    DOB,
    HEX(DOB) AS DOB_Raw
FROM healthcare_fraud_analysis.train_beneficiarydata
LIMIT 5;

SELECT
    COUNT(*) AS total_rows,
    SUM(DOB REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}$') AS valid_dob_format
FROM healthcare_fraud_analysis.train_beneficiarydata;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DOD) AS non_null_dod,
    SUM(DOD REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}$') AS valid_dod_format
FROM healthcare_fraud_analysis.train_beneficiarydata;

SELECT
    COUNT(*) AS total_rows,
    SUM(DOD = '') AS empty_dod,
    SUM(DOD IS NULL) AS null_dod,
    SUM(DOD REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}$') AS valid_dod
FROM healthcare_fraud_analysis.train_beneficiarydata;

CREATE TABLE beneficiary_backup AS
SELECT *
FROM healthcare_fraud_analysis.train_beneficiarydata;

UPDATE healthcare_fraud_analysis.train_beneficiarydata
SET
    DOB = DATE_FORMAT(STR_TO_DATE(DOB, '%d-%m-%Y'), '%Y-%m-%d'),
    DOD = CASE
        WHEN DOD = '' THEN NULL
        ELSE DATE_FORMAT(STR_TO_DATE(DOD, '%d-%m-%Y'), '%Y-%m-%d')
    END
WHERE BeneID IS NOT NULL;

ALTER TABLE healthcare_fraud_analysis.train_beneficiarydata
MODIFY DOB DATE,
MODIFY DOD DATE;
