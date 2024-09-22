WITH source AS (
    SELECT * FROM {{ source("src_stage", "stg_covid_vaccination") }}
),
final AS (
    SELECT
        TRIM(location) AS location,
        TO_DATE(date, 'YYYY-MM-DD') AS date,
        TRIM(vaccine) AS vaccine,
        TRIM(source_url) AS source_url,
        CAST(total_vaccinations AS INTEGER) AS total_vaccinations,
        CAST(people_vaccinated AS INTEGER) AS people_vaccinated,
        CAST(people_fully_vaccinated AS INTEGER) AS people_fully_vaccinated,
        CAST(total_boosters AS INTEGER) AS total_boosters
    FROM source
)
SELECT 
    *
FROM final