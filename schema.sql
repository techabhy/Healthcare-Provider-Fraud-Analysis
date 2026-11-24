
USE healthcare_fraud_analysis;

-- 1. Beneficiary Table
CREATE TABLE IF NOT EXISTS train_beneficiarydata (
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

-- 2. Provider Table
CREATE TABLE IF NOT EXISTS train_provider (
    Provider VARCHAR(20) PRIMARY KEY,
    PotentialFraud VARCHAR(5)
);

-- 3. Inpatient Claims Table
CREATE TABLE IF NOT EXISTS train_inpatientdata (
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

-- 4. Outpatient Claims Table
CREATE TABLE IF NOT EXISTS train_outpatientdata (
    BeneID VARCHAR(20),
    ClaimID VARCHAR(20) PRIMARY KEY,
    ClaimStartDt DATE,
    ClaimEndDt DATE,
    Provider VARCHAR(20),
    InscClaimAmtReimbursed BIGINT,
    AttendingPhysician VARCHAR(20),
    OperatingPhysician VARCHAR(20),
    OtherPhysician VARCHAR(20),
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
    ClmProcedureCode_6 VARCHAR(20),
    DeductibleAmtPaid BIGINT,
    ClmAdmitDiagnosisCode VARCHAR(20)
);
