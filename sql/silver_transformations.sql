/*
Silver Transformations:
  The purpose of this script is to clean raw data collected in the bronze layer
  and prepare it for later transformations in the gold layer
  
  Transformations Performed:
    - Remove NULL values
    - Remove White Spaces
    - Change date_posted column from TIMESTAMP to DATE datatype
*/

SELECT 
  TRIM(id) AS id,
  TRIM(role) AS role,
  TRIM(company_name) AS company_name,
  CASE
    WHEN company_num_employees IS NULL THEN 'N/A'
    ELSE TRIM(company_num_employees)
  END AS company_num_employees,
  CASE
    WHEN employment_type IS NULL THEN 'N/A'
    ELSE TRIM(employment_type)
  END AS employment_type,
  CASE
    WHEN location IS NULL THEN 'N/A'
    ELSE TRIM(location)
  END AS location,
  TRIM(remote) AS remote,
  CASE
    WHEN logo IS NULL THEN 'N/A'
    ELSE TRIM(logo)
  END AS logo,
  TRIM(url) AS url,
  CASE
    WHEN text IS NULL THEN 'N/A'
    ELSE TRIM(text)
  END AS text,
  CAST(date_posted AS DATE) AS date_posted
FROM bronze.jobs_table
;