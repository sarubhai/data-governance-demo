CREATE SCHEMA stage;
SET SCHEMA 'stage';
COMMENT ON SCHEMA stage IS 'Staging Database Schema';

CREATE TABLE IF NOT EXISTS stg_covid_vaccination (
    location VARCHAR(255),
    date VARCHAR(255),
    vaccine VARCHAR(255),
    source_url VARCHAR(255),
    total_vaccinations VARCHAR(255),
    people_vaccinated VARCHAR(255),
    people_fully_vaccinated VARCHAR(255),
    total_boosters VARCHAR(255)
);

COMMENT ON TABLE stg_covid_vaccination IS 'Raw Data of US COVID-19 vaccinations';
COMMENT ON COLUMN stg_covid_vaccination.location IS 'Name of the state or federal entity';
COMMENT ON COLUMN stg_covid_vaccination.date IS 'Date of the observation';
COMMENT ON COLUMN stg_covid_vaccination.vaccine IS 'List of vaccines administered';
COMMENT ON COLUMN stg_covid_vaccination.source_url IS 'Web location of public official source data';
COMMENT ON COLUMN stg_covid_vaccination.total_vaccinations IS 'Total number of doses administered';
COMMENT ON COLUMN stg_covid_vaccination.people_vaccinated IS 'Total number of people who received at least one vaccine dose';
COMMENT ON COLUMN stg_covid_vaccination.people_fully_vaccinated IS 'Total number of people who received all doses';
COMMENT ON COLUMN stg_covid_vaccination.total_boosters IS 'Total number of COVID-19 vaccination booster doses administered';


CREATE SCHEMA model;
COMMENT ON SCHEMA model IS 'Curated Database Schema';
