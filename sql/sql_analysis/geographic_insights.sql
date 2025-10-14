/*
Geographical Insights:

The following SQL queries are designed to provide insights into geographical trends in the job market.
*/

-- Which cities have the highest number of job postings
-- The following query returns the top 10 cities with the highest number of job postings
SELECT
  l.city AS city,
  COUNT(*) AS job_postings
FROM gold.fact_job_postings AS p
LEFT JOIN gold.dim_locations AS l ON p.location_key = l.location_key
WHERE l.city != 'Unknown'
GROUP BY l.city
ORDER BY job_postings DESC
LIMIT 10
;

-- Which countries have the highest number of job postings
-- The following query returns the top 10 countries with the highest number of job postings
SELECT
  l.country AS country,
  COUNT(*) AS job_postings
FROM gold.fact_job_postings AS p
LEFT JOIN gold.dim_locations AS l ON p.location_key = l.location_key
WHERE l.country != 'Unknown'
GROUP BY l.country
ORDER BY job_postings DESC
LIMIT 10
;

-- Which roles have the highest number of job postings in each country
-- The following query returns the top 10 roles with the highest number of job postings in each country
SELECT
  p.role AS role,
  l.country AS country,
  COUNT(*) AS job_postings
FROM gold.fact_job_postings AS p
LEFT JOIN gold.dim_locations AS l ON p.location_key = l.location_key
WHERE l.country != 'Unknown'
GROUP BY l.country, p.role
ORDER BY job_postings DESC
LIMIT 10
;

-- Which cities have the highest number of remote jobs
-- The following qeury returns the top 10 cities with the highest number of remote jobs
SELECT
  l.city AS city,
  COUNT(*) AS remote_jobs
FROM gold.fact_job_postings AS p
LEFT JOIN gold.dim_locations AS l ON l.location_key = p.location_key
WHERE p.remote = 'true' AND l.city != 'Unknown'
GROUP BY l.city
ORDER BY remote_jobs DESC
LIMIT 10
;

-- Which countries have the highest number of remote jobs
-- The following qeury returns the top 10 countries with the highest number of remote jobs
SELECT
  l.country AS country,
  COUNT(*) AS remote_jobs
FROM gold.fact_job_postings AS p
LEFT JOIN gold.dim_locations AS l ON l.location_key = p.location_key
WHERE p.remote = 'true' AND l.country != 'Unknown'
GROUP BY l.country
ORDER BY remote_jobs DESC
LIMIT 10
;

-- Are there cities where hiring activity is growing or declining?
-- The following query returns cities' trends in hiring activity, and growth rate
WITH city_data AS (
  SELECT
    l.city,
    DATE_TRUNC('week', p.date_posted) AS week_posted,
    COUNT(*) AS job_postings
  FROM gold.fact_job_postings AS p
  LEFT JOIN gold.dim_locations AS l ON l.location_key = p.location_key
  WHERE l.city != 'Unknown'
  GROUP BY l.city, week_posted
  ORDER BY l.city, week_posted
), city_trends AS (
  SELECT
    city,
    FIRST_VALUE(job_postings) OVER (PARTITION BY city ORDER BY week_posted ASC) AS first_postings,
    LAST_VALUE(job_postings) OVER (PARTITION BY city ORDER BY week_posted ASC
      ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_postings
  FROM city_data
)
SELECT
  city,
  AVG(first_postings) AS first_postings,
  AVG(last_postings) AS last_postings,
  ROUND(100.0 * (AVG(last_postings) - AVG(first_postings)) / NULLIF(AVG(first_postings), 0), 2) AS growth_rate_pct,
  CASE 
    WHEN (AVG(last_postings) - AVG(first_postings)) > 0 THEN 'Growing'
    WHEN (AVG(last_postings) - AVG(first_postings)) < 0 THEN 'Declining'
    ELSE 'Stable'
  END AS trend_category
FROM city_trends
GROUP BY city
ORDER BY growth_rate_pct DESC;