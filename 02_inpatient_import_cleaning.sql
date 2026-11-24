USE healthcare_fraud_analysis;

CREATE TABLE train_inpatientdata (
    BeneID VARCHAR(20),
    ClaimID VARCHAR(20) PRIMARY KEY,
    ClaimStartDt DATE,
    ClaimEndDt DATE,
    Provider VARCHAR(20),
    InscClaimAmtReimbursed BIGINT,
    AttendingPhysician VARCHAR(20),
    OperatingPhysician VARCHAR(20),
    OtherPhysician VARCHAR(20),
    AdmissionDt DATE,
    ClmAdmitDiagnosisCode VARCHAR(20),
    DeductibleAmtPaid DECIMAL(10,2),
    DischargeDt DATE,
    DiagnosisGroupCode VARCHAR(20),
    ClmDiagnosisCode_1 VARCHAR(20),
    ClmDiagnosisCode_2 VARCHAR(20),
    ClmDiagnosisCode_3 VARCHAR(20),
    ClmDiagnosisCode_4 VARCHAR(20),
    ClmDiagnosisCode_5 VARCHAR(20),
    ClmDiagnosisCode_6 VARCHAR(20),
    ClmDiagnosisCode_7 VARCHAR(20),
    ClmDiagnosisCode_8 VARCHAR(20),
    ClmDiagnosisCode_9 VARCHAR(20),
    ClmDiagnosisCode_10 VARCHAR(20),
    ClmProcedureCode_1 VARCHAR(20),
    ClmProcedureCode_2 VARCHAR(20),
    ClmProcedureCode_3 VARCHAR(20),
    ClmProcedureCode_4 VARCHAR(20),
    ClmProcedureCode_5 VARCHAR(20),
    ClmProcedureCode_6 VARCHAR(20)
);



SELECT
    ClaimID,
    ClaimStartDt,
    ClaimEndDt,
    AdmissionDt,
    DischargeDt,
    DeductibleAmtPaid
FROM healthcare_fraud_analysis.train_inpatientdata
LIMIT 10;

DESCRIBE healthcare_fraud_analysis.train_inpatientdata;

TRUNCATE TABLE healthcare_fraud_analysis.train_inpatientdata;
LOAD DATA LOCAL INFILE 'C:/Users/hp/Desktop/Healthcare_fraud_project/Inpatient_Clean.csv'
INTO TABLE healthcare_fraud_analysis.train_inpatientdata
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    BeneID,
    ClaimID,
    @ClaimStartDt,
    @ClaimEndDt,
    Provider,
    InscClaimAmtReimbursed,
    AttendingPhysician,
    OperatingPhysician,
    OtherPhysician,
    @AdmissionDt,
    ClmAdmitDiagnosisCode,
    @DeductibleAmtPaid,
    @DischargeDt,
    DiagnosisGroupCode,
    ClmDiagnosisCode_1,
    ClmDiagnosisCode_2,
    ClmDiagnosisCode_3,
    ClmDiagnosisCode_4,
    ClmDiagnosisCode_5,
    ClmDiagnosisCode_6,
    ClmDiagnosisCode_7,
    ClmDiagnosisCode_8,
    ClmDiagnosisCode_9,
    ClmDiagnosisCode_10,
    ClmProcedureCode_1,
    ClmProcedureCode_2,
    ClmProcedureCode_3,
    ClmProcedureCode_4,
    ClmProcedureCode_5,
    ClmProcedureCode_6
)
SET
    ClaimStartDt = STR_TO_DATE(@ClaimStartDt, '%d-%m-%Y'),
    ClaimEndDt = STR_TO_DATE(@ClaimEndDt, '%d-%m-%Y'),
    AdmissionDt = STR_TO_DATE(@AdmissionDt, '%d-%m-%Y'),
    DischargeDt = STR_TO_DATE(@DischargeDt, '%d-%m-%Y'),
    DeductibleAmtPaid = NULLIF(@DeductibleAmtPaid, '');
    
    
SELECT
    ClaimID,
    ClaimStartDt,
    ClaimEndDt,
    AdmissionDt,
    DischargeDt,
    DeductibleAmtPaid
FROM healthcare_fraud_analysis.train_inpatientdata
LIMIT 10;
    
SELECT COUNT(*) AS total_inpatient_claims
FROM healthcare_fraud_analysis.train_inpatientdata;
