/*
Job Market Overview:
This file contains a collection of analytical queries to explore the job market.
*/

-- What are the most common job titles in the dataset?
-- The following query retrievs the top ten most common job titles
SELECT
  role,
  COUNT(*) AS number_of_jobs
FROM gold.fact_job_postings
GROUP BY role
ORDER BY number_of_jobs DESC
LIMIT 10
;

-- Which employment types are the most prevalent?
-- The following query retieves the count of job types found in the dataset
SELECT
  employment_type,
  COUNT(*) AS employment_type_count
FROM gold.fact_job_postings
GROUP BY employment_type
ORDER BY employment_type_count DESC
;

-- How many jobs are posted each month?
-- The following query retrieves the number of jobs posted each month
SELECT
  DATE_FORMAT(date_posted, 'MMMM') AS month_posted,
  COUNT(*) AS number_of_postings
FROM gold.fact_job_postings
GROUP BY DATE_FORMAT(date_posted, 'MMMM')
;

-- How many jobs are posted each day?
-- The following query return how many jobs have been posted each day
SELECT
  date_posted,
  COUNT(*) AS number_of_postings
FROM gold.fact_job_postings
GROUP BY date_posted
ORDER BY number_of_postings DESC
;

-- What is the distribution of employment types in the dataset?
-- The following query returns the percentage of each employment type
SELECT
  employment_type,
  ROUND((100 * COUNT(employment_type)) / (SELECT COUNT(*) FROM gold.fact_job_postings), 2) AS employment_type_percentage  
FROM gold.fact_job_postings
GROUP BY employment_type
;

-- What is the distribution of remote jobs in the dataset?
-- The following query returns the percentage of remote jobs
SELECT
  remote,
  ROUND((100 * COUNT(remote)) / (SELECT COUNT(*) FROM gold.fact_job_postings), 2) AS remote_percentage  
FROM gold.fact_job_postings
GROUP BY remote
;