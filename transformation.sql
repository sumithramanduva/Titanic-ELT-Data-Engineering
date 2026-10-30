
USE titanic_db;

DROP TABLE IF EXISTS clean_passengers;

CREATE TABLE clean_passengers AS
WITH age_filled AS (
    SELECT
        s.*,
        COALESCE(
            s.age,
            AVG(s.age) OVER (
                PARTITION BY s.passenger_class, s.sex
            )
        ) AS filled_age
    FROM stg_titanic AS s
),
embarked_filled AS (
    SELECT
        a.*,
        COALESCE(
            a.embarked,
            (
                SELECT e.embarked
                FROM stg_titanic AS e
                WHERE e.embarked IS NOT NULL
                GROUP BY e.embarked
                ORDER BY COUNT(*) DESC, e.embarked
                LIMIT 1
            )
        ) AS filled_embarked
    FROM age_filled AS a
),
numbered AS (
    SELECT
        e.*,
        NTILE(4) OVER (ORDER BY e.fare) AS fare_quartile
    FROM embarked_filled AS e
)
SELECT
    survived,
    passenger_class,
    CASE
        WHEN sex = 'female' THEN 0
        WHEN sex = 'male' THEN 1
        ELSE NULL
    END AS sex,
    filled_age AS age,
    siblings_spouses,
    parents_children,
    fare,
    filled_embarked AS embarked,
    passenger_class_name,
    passenger_type,
    adult_male,
    alive,
    alone,
    load_timestamp,
    batch_id,
    CASE
        WHEN filled_age <= 12 THEN 'Child'
        WHEN filled_age <= 19 THEN 'Teen'
        WHEN filled_age <= 59 THEN 'Adult'
        WHEN filled_age >= 60 THEN 'Senior'
        ELSE NULL
    END AS age_group,
    siblings_spouses + parents_children + 1 AS family_size,
    CASE
        WHEN siblings_spouses + parents_children = 0 THEN 1
        ELSE 0
    END AS is_alone,
    CASE fare_quartile
        WHEN 1 THEN 'Low'
        WHEN 2 THEN 'Medium'
        WHEN 3 THEN 'High'
        WHEN 4 THEN 'Premium'
    END AS fare_category
FROM numbered;
