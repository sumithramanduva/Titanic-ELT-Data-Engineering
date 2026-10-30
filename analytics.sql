
USE titanic_db;

CREATE OR REPLACE VIEW vw_survival_by_class_sex AS
SELECT
    passenger_class,
    sex,
    COUNT(*) AS passenger_count,
    SUM(survived) AS survivors,
    ROUND(AVG(survived) * 100, 2) AS survival_rate_percent
FROM clean_passengers
GROUP BY passenger_class, sex;


CREATE OR REPLACE VIEW vw_survival_by_age_group AS
SELECT
    age_group,
    COUNT(*) AS passenger_count,
    SUM(survived) AS survivors,
    ROUND(AVG(survived) * 100, 2) AS survival_rate_percent
FROM clean_passengers
GROUP BY age_group;


CREATE OR REPLACE VIEW vw_top_3_fares_per_class AS
WITH ranked_fares AS (
    SELECT
        passenger_class,
        fare,
        survived,
        sex,
        ROW_NUMBER() OVER (
            PARTITION BY passenger_class
            ORDER BY fare DESC
        ) AS fare_rank
    FROM clean_passengers
)
SELECT
    passenger_class,
    fare,
    survived,
    sex,
    fare_rank
FROM ranked_fares
WHERE fare_rank <= 3;
