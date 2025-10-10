/*
Silver Transformations:
  The purpose of this script is to clean raw data collected in the bronze layer
  and prepare it for later transformations in the gold layer
  
  Transformations Performed:
    - Remove NULL values from employment_type column
    - Remove NULL values from location column 
    - Change date_posted column from TIMESTAMP to DATE datatype
*/
SELECT 
  id,
  role,
  company_name,
  CASE
    WHEN employment_type IS NULL THEN 'N/A'
    ELSE employment_type
  END AS employment_type,
  CASE
    WHEN location IS NULL THEN 'N/A'
    ELSE location
  END AS location,
  remote,
  CAST(date_posted AS DATE) AS date_posted
FROM bronze.jobs_table
;