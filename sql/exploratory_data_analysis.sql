/*
Exploratory Data Analysis (EDA):
  Purpose:
    - Explore the data set to identify key characteristics
    - Build an understanding of the relevant columns, rows and datatypes
  Scope:
    This EDA script will identify the following:
    - Number of rown in the dataset
    - Distinct roles represented in the dataset
    - Distinct company names represented in the dataset
    - Distinct employment types
    - Distinct job locations
    - Remote vs non-remote status
    - Source information for job posting
    - Relevant metadata for the dataset 
*/

-- High level overview of the data
SELECT * FROM bronze.jobs_table;

-- Show the number of items in the database (1466 rows)
SELECT COUNT(*) FROM bronze.jobs_table;

-- Distinct roles
-- 1181 distinct roles. High cardinality
SELECT DISTINCT role FROM bronze.jobs_table;

-- Distinct company names
-- 937 rows. High Caridnality
SELECT DISTINCT company_name FROM bronze.jobs_table;

-- Distinct employment type
-- 3 items (conract, full time, null). Low Cardinality
SELECT DISTINCT employment_type FROM bronze.jobs_table;

-- Distinct Job Locations
-- 294 rows: Medium Cardinality
SELECT DISTINCT location FROM bronze.jobs_table;

-- Distinct values for remote column
-- 2 values (true, false), Low Cardinality
SELECT DISTINCT remote FROM bronze.jobs_table;

-- Distinct sources for job posting
-- 5 rows: Low Cardinality
SELECT DISTINCT source FROM bronze.jobs_table;

-- Relevant metadata about jobs_table and load_log
SELECT 
  table_name,
  column_name,
  is_nullable,
  data_type
FROM information_schema.columns
WHERE table_schema = 'bronze';