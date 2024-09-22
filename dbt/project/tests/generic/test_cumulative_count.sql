{% test cummulative_count(model, column_name, order_column_name) %}

WITH validation AS (
    SELECT
        {{ order_column_name }} AS order_column_name,
        {{ column_name }} AS current_total,
        LAG({{ column_name }}) OVER(ORDER BY {{ order_column_name }}) AS previous_total
    FROM {{ model }}
),
validation_errors AS (
    SELECT
        order_column_name,
        current_total,
        previous_total
    FROM validation
    WHERE current_total < previous_total
)
SELECT *
FROM validation_errors

{% endtest %}