{% test valid_vaccines(model, column_name) %}

WITH validation AS (
    SELECT
        {{ column_name }} AS vaccines
    FROM {{ model }}
),
validation_errors AS (
    SELECT
        vaccines
    FROM validation
    WHERE NOT ARRAY['Johnson&Johnson', 'Moderna', 'Novavax', 'Pfizer/BioNTech'] @> STRING_TO_ARRAY(vaccines, ', ')
)
SELECT *
FROM validation_errors

{% endtest %}