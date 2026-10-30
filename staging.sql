
USE titanic_db;

DROP TABLE IF EXISTS stg_titanic;

CREATE TABLE stg_titanic AS
SELECT
    CAST(survived AS UNSIGNED) AS survived,
    CAST(pclass AS UNSIGNED) AS passenger_class,
    LOWER(sex) AS sex,
    CAST(age AS DECIMAL(5,2)) AS age,
    CAST(sibsp AS UNSIGNED) AS siblings_spouses,
    CAST(parch AS UNSIGNED) AS parents_children,
    CAST(fare AS DECIMAL(10,4)) AS fare,
    LOWER(embarked) AS embarked,
    LOWER(`class`) AS passenger_class_name,
    LOWER(who) AS passenger_type,
    adult_male,
    LOWER(deck) AS deck,
    LOWER(embark_town) AS embark_town,
    LOWER(alive) AS alive,
    alone,
    load_timestamp,
    batch_id
FROM raw_titanic;
