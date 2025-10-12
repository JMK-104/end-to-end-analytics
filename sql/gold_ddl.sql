/*
Gold DDL:
  The purpose of this script is to create gold tables from data in the silver table

  Tables created:
  - dim_companies
  - dim_locations has already been created in city_and_country.ipynb
  - fact_job_postings
*/

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
    l.location,
    l.city,
    l.country,
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