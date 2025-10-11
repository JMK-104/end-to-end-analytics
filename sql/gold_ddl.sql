/*
Gold DDL:
  The purpose of this script is to create gold tables from data in the silver table

  Tables created:
  - dim_locations
    - country column derived from location column
  - dim_companies
  - fact_job_postings
*/

-- Create gold schema
CREATE SCHEMA IF NOT EXISTS gold;

-- Create Location Table
CREATE OR REPLACE TABLE gold.dim_locations AS
WITH loc_full AS (
  SELECT DISTINCT
    location,
    CASE
      WHEN location LIKE '%United States%' OR location LIKE '%US%' THEN 'United States'
      WHEN location LIKE '%Canada%' THEN 'Canada'
      WHEN location LIKE '%China%' THEN 'China'
      WHEN location LIKE '%India%' THEN 'India'
      WHEN location LIKE '%Australia%' THEN 'Australia'
      WHEN location LIKE '%Germany%' THEN 'Germany'
      WHEN location LIKE '%France%' THEN 'France'
      WHEN location LIKE '%Spain%' THEN 'Spain'
      WHEN location LIKE '%Italy%' THEN 'Italy'
      WHEN location LIKE '%Japan%' THEN 'Japan'
      WHEN location LIKE '%Brazil%' THEN 'Brazil'
      WHEN location LIKE '%Mexico%' THEN 'Mexico'
      WHEN location LIKE '%South Africa%' THEN 'South Africa'
      WHEN location LIKE '%Nigeria%' THEN 'Nigeria'
      WHEN location LIKE '%Belgium%' THEN 'Belgium'
      WHEN location LIKE '%Netherlands%' THEN 'Netherlands'
      WHEN location LIKE '%Sweden%' THEN 'Sweden'
      WHEN location LIKE '%Norway%' THEN 'Norway'
      WHEN location LIKE '%Switzerland%' THEN 'Switzerland'
      WHEN location LIKE '%Denmark%' THEN 'Denmark'
      WHEN location LIKE '%Greece%' THEN 'Greece'
      WHEN location LIKE '%Portugal%' THEN 'Portugal'
      WHEN location LIKE '%Poland%' THEN 'Poland'
      WHEN location LIKE '%Turkey%' THEN 'Turkey' 
      WHEN location LIKE '%New Zealand%' THEN 'New Zealand'
      WHEN location LIKE '%Vietnam%' THEN 'Vietnam'
      WHEN location LIKE '%Austria%' THEN 'Austria'
      WHEN location LIKE '%Singapore%' THEN 'Singapore'
      WHEN location LIKE '%Slovenia%' THEN 'Slovenia'
      WHEN location LIKE '%Scotland%' THEN 'Scotland'
      WHEN location LIKE '%Luxembourg%' THEN 'Luxembourg'
      WHEN location LIKE '%Ireland%' THEN 'Ireland'
      WHEN location LIKE '%Malta%' THEN 'Malta'
      WHEN location LIKE '%Thailand%' THEN 'Thailand'
      WHEN location LIKE '%Hong Kong%' THEN 'Hong Kong'
      WHEN location LIKE '%Finland%' THEN 'Finland'
      WHEN location LIKE '%Czech Republic%' THEN 'Czech Republic'
      WHEN location LIKE '%Romania%' THEN 'Romania'
      WHEN location LIKE '%Croatia%' THEN 'Croatia'
      WHEN location LIKE '%Iceland%' THEN 'Iceland'
      WHEN location LIKE '%Estonia%' THEN 'Estonia'
      WHEN location LIKE '%Latvia%' THEN 'Latvia'
      WHEN location LIKE '%South Korea%' THEN 'South Korea'
      WHEN location LIKE '%United Arab Emirates%' THEN 'United Arab Emirates'
      WHEN location LIKE '%UK%' OR location LIKE '%United Kingdom%' THEN 'United Kingdom'
      WHEN location LIKE '%,%' AND (location LIKE '%US%' OR location LIKE '%Canada%' OR location LIKE '%UK%') THEN 'Multiple'
      ELSE NULL
    END AS country
  FROM silver.jobs_table
)
SELECT
  DENSE_RANK() OVER(ORDER BY country, location) AS location_key,
  location,
  country
FROM loc_full
WHERE country IS NOT NULL
GROUP BY country, location
;

-- Create Companies table
CREATE OR REPLACE TABLE gold.dim_companies AS
  SELECT
    DENSE_RANK() OVER(ORDER BY company_name) AS company_key,
    company_name
  FROM silver.jobs_table
  GROUP BY company_name
;

-- Create Job Postings Table
CREATE OR REPLACE TABLE gold.fact_job_postings AS
  SELECT
    p.id AS job_id,
    c.company_key AS company_key,
    l.location_key AS location_key,
    p.role,
    c.company_name,
    p.company_num_employees,
    p.employment_type,
    p.remote,
    p.url,
    p.text AS job_description,
    p.date_posted
  FROM silver.jobs_table AS p
  LEFT JOIN gold.dim_companies AS c ON c.company_name = p.company_name
  INNER JOIN gold.dim_locations AS l ON l.location = p.location
;