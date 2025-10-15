/*
Temporal Trends

The following SQL queries are designed to give insights into time-based trends in the data.
*/

-- What is the overall trand in job postings over time?
-- The following query returns the number of jobs posted per month, and the trend (growing, decreasing, or stable)
WITH monthly_data AS (
  SELECT
    DATE_TRUNC('month', date_posted) AS month_posted,
    COUNT(*) AS jobs_posted
  FROM gold.fact_job_postings
  GROUP BY month_posted
  ORDER BY month_posted
), aggregated_data AS (
SELECT
  DATE_FORMAT(month_posted, 'MMM-yyyy') AS month_posted,
  jobs_posted,
  LAG(jobs_posted) OVER(ORDER BY month_posted) AS prev_month_jobs_posted
FROM monthly_data
)
SELECT
  month_posted,
  jobs_posted,
  CASE
    WHEN jobs_posted > prev_month_jobs_posted THEN 'Growing'
    WHEN jobs_posted < prev_month_jobs_posted THEN 'Decreasing'
    ELSE 'Stable'
  END AS trend
FROM aggregated_data
;

-- Is there seasonality in hiring patterns?
-- The following query returns total job postings per month, showing potential seasonality
WITH monthly_data AS (
  SELECT
    DATE_TRUNC('month', date_posted) AS month_posted,
    COUNT(*) AS jobs_posted
  FROM gold.fact_job_postings
  GROUP BY role, month_posted
  ORDER BY month_posted, jobs_posted DESC
)
SELECT
  DATE_FORMAT(month_posted, 'MMM-yyyy') AS month_posted,
  SUM(jobs_posted) AS sum_jobs_posted
FROM monthly_data
GROUP BY month_posted
ORDER BY DATE_TRUNC('month', monthly_data.month_posted)
;