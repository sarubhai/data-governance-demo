WITH date_range AS (
    {{ dbt_utils.date_spine(
        datepart="day", 
        start_date="CAST('2020-01-01' AS DATE)",
        end_date="CAST('2030-12-31' AS DATE)"
    ) }}
),
dates_raw AS (
    SELECT
        CAST(date_day AS DATE) AS date_day
    FROM date_range
)
SELECT
    CAST(TO_CHAR(date_day, 'YYYYMMDD') AS INTEGER) AS date_key,
    CAST(date_day AS DATE) AS date,
    CAST(EXTRACT(year FROM date_day) AS INTEGER) AS year,
    CAST(EXTRACT(month FROM date_day) AS INTEGER) AS month_number,
    CAST(TO_CHAR(date_day, 'YYYYMM') AS INTEGER) AS month_key,
    TO_CHAR(date_day, 'Month') AS month_name,
    CAST(EXTRACT(quarter FROM date_day) AS INTEGER) AS quarter,
    CAST(EXTRACT(week FROM date_day) AS INTEGER) AS week_of_year,
    CAST(EXTRACT(isodow FROM date_day) AS INTEGER) AS day_of_week_iso,
    TO_CHAR(date_day, 'Day') AS day_name,
    CAST(EXTRACT(day FROM date_day) AS INTEGER) AS day_of_month,
    CAST(EXTRACT(doy FROM date_day) AS INTEGER) AS day_of_year,
    case 
        when EXTRACT(isodow FROM date_day) in (6, 7) then true 
        else false 
    end AS is_weekend,
    TO_CHAR(date_day, 'YYYY-MM-DD') AS iso_date_format,
    CAST(DATE_TRUNC('week', date_day) AS DATE) AS week_start_date,
    CAST(DATE_TRUNC('month', date_day) AS DATE) AS month_start_date,
    CAST(DATE_TRUNC('quarter', date_day) AS DATE) AS quarter_start_date,
    CAST(DATE_TRUNC('year', date_day) AS DATE) AS year_start_date
FROM date_range
ORDER BY date_day
