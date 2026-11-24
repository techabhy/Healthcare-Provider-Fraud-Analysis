USE healthcare_fraud_analysis;

CREATE TABLE train_provider (
    Provider VARCHAR(20) PRIMARY KEY,
    PotentialFraud VARCHAR(5)
);

LOAD DATA LOCAL INFILE 'C:/Users/hp/Desktop/Healthcare_fraud_project/Train.csv'
INTO TABLE healthcare_fraud_analysis.train_provider
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SHOW GLOBAL VARIABLES LIKE 'local_infile';

SET GLOBAL local_infile = 1;

SELECT
    COUNT(*) AS total_providers,
    COUNT(DISTINCT Provider) AS unique_providers
FROM healthcare_fraud_analysis.train_provider;