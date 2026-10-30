
USE titanic_db;

-- Step 1: Create data quality results table
CREATE TABLE IF NOT EXISTS dq_results (
    check_name VARCHAR(100),
    status VARCHAR(10),
    checked_at DATETIME
);

-- Step 2: Clear previous results
DELETE FROM dq_results;


-- Check 1: Raw and clean row counts match
INSERT INTO dq_results
SELECT
    'Raw and clean row counts match',
    CASE
        WHEN (SELECT COUNT(*) FROM raw_titanic) =
             (SELECT COUNT(*) FROM clean_passengers)
        THEN 'PASS'
        ELSE 'FAIL'
    END,
    NOW();


-- Check 2: No NULL values in age or embarked
INSERT INTO dq_results
SELECT
    'No nulls in age or embarked',
    CASE
        WHEN SUM(age IS NULL OR embarked IS NULL) = 0
        THEN 'PASS'
        ELSE 'FAIL'
    END,
    NOW()
FROM clean_passengers;


-- Check 3: No exact duplicate passenger records
-- Compare all 15 original Titanic attributes
INSERT INTO dq_results
SELECT
    'No exact duplicate passenger records',
    CASE
        WHEN COUNT(*) = 0
        THEN 'PASS'
        ELSE 'FAIL'
    END,
    NOW()
FROM (
    SELECT
        survived,
        pclass,
        sex,
        age,
        sibsp,
        parch,
        fare,
        embarked,
        class,
        who,
        adult_male,
        deck,
        embark_town,
        alive,
        alone
    FROM raw_titanic
    GROUP BY
        survived,
        pclass,
        sex,
        age,
        sibsp,
        parch,
        fare,
        embarked,
        class,
        who,
        adult_male,
        deck,
        embark_town,
        alive,
        alone
    HAVING COUNT(*) > 1
) AS duplicates_found;


-- Check 4: Age must be between 0 and 100
INSERT INTO dq_results
SELECT
    'Age is between 0 and 100',
    CASE
        WHEN SUM(age < 0 OR age > 100 OR age IS NULL) = 0
        THEN 'PASS'
        ELSE 'FAIL'
    END,
    NOW()
FROM clean_passengers;


-- Check 5: Sex must contain only 0 or 1
INSERT INTO dq_results
SELECT
    'Sex contains only 0 or 1',
    CASE
        WHEN SUM(sex IS NULL OR sex NOT IN (0, 1)) = 0
        THEN 'PASS'
        ELSE 'FAIL'
    END,
    NOW()
FROM clean_passengers;


-- Step 3: Display all data quality results
SELECT
    check_name,
    status,
    checked_at
FROM dq_results;
