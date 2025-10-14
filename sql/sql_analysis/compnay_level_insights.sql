/*
Company Level Insights

The following SQL queries are intended to provide insights into companies and their job postings.
*/

-- Which companies post the highest number of jobs overall
-- The following query returns the top 10 companies by number of postings
SELECT
  c.company_name AS company,
  COUNT(*) AS num_postings
FROM gold.fact_job_postings AS p
LEFT JOIN gold.dim_companies AS c ON c.company_key = p.company_key
GROUP BY c.company_name
ORDER BY num_postings DESC
LIMIT 10
;

-- Which companies have the largest proportion of remote job postings
-- The following query returns the top 10 companies by number of remote postings
SELECT
  c.company_name AS company,
  COUNT(*) AS num_remote_jobs,
  ROUND((100 * COUNT(*)) / (SELECT COUNT(*) FROM gold.fact_job_postings WHERE remote='true'), 2) AS remote_percentage
FROM gold.fact_job_postings AS p
LEFT JOIN gold.dim_companies AS c ON c.company_key = p.company_key
WHERE p.remote = 'true'
GROUP BY c.company_name
ORDER BY remote_percentage DESC
LIMIT 10
;

-- What are the top companies hiring for full time roles
-- The following query returns the top 10 companies by number of full time postings
SELECT
  c.company_name AS company,
  COUNT(*) AS full_time_postings
FROM gold.fact_job_postings AS p
LEFT JOIN gold.dim_companies AS c ON c.company_key = p.company_key
WHERE employment_type = 'full time'
GROUP BY c.company_name, p.employment_type
ORDER BY full_time_postings DESC
LIMIT 10
;

-- What are the top companies hiring for non-full time roles
-- The following query returns the top 10 companies by number of non-full time postings
SELECT
  c.company_name AS company,
  COUNT(*) AS non_full_time_postings
FROM gold.fact_job_postings AS p
LEFT JOIN gold.dim_companies AS c ON c.company_key = p.company_key
WHERE employment_type != 'full time'
GROUP BY c.company_name, p.employment_type
ORDER BY non_full_time_postings DESC
LIMIT 10
;

-- What are the top roles that companies are hiring for
-- The following query returns the top 10 roles by number of postings
SELECT
  c.company_name AS company,
  p.role AS role,
  COUNT(*) AS role_count
FROM gold.fact_job_postings AS p
LEFT JOIN gold.dim_companies AS c ON c.company_key = p.company_key
GROUP BY c.company_name, p.role
ORDER BY role_count DESC
LIMIT 10
;