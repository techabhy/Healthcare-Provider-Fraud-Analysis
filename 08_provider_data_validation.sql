SELECT
    COUNT(*) AS total_records,
    SUM(Provider IS NULL) AS missing_provider
FROM train_provider;

SELECT
    COUNT(*) AS total_rows,
    COUNT(Provider) AS non_null_providers,
    COUNT(DISTINCT Provider) AS unique_providers,
    COUNT(Provider) - COUNT(DISTINCT Provider) AS extra_occurrences
FROM train_provider;

SELECT
    PotentialFraud,
    COUNT(*) AS total_providers
FROM train_provider
GROUP BY PotentialFraud;

SELECT
    COUNT(*) AS total_records,
    SUM(PotentialFraud IS NULL) AS missing_fraud_status,
    SUM(PotentialFraud NOT IN ('Yes', 'No')) AS unexpected_values
FROM train_provider;

DESCRIBE train_provider;