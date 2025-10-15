# SQL Data Analytics Project  
**End-to-End Data Pipeline & Analytics with the Findwork API**

This project demonstrates a complete **data analytics pipeline** — from automated data collection to analytical insights — built with **Python, SQL, and Databricks**.  
It highlights how modern data engineering practices can be applied to real-world job market data to extract meaningful business insights.

---

## 📁 Project Overview

| Phase | Description |
|-------|--------------|
| **Phase 1 — Data Collection** | Fetched live job postings via the [Findwork API](https://findwork.dev) and ingested them into the Databricks environment. |
| **Phase 2 — Data Processing** | Transformed data through a **Bronze–Silver–Gold** layered architecture for data cleaning, enrichment, and modeling. |
| **Phase 3 — Data Analysis** | Conducted SQL-based exploratory and business analysis to uncover trends and insights. 

---

## ⚙️ Tech Stack

- **Python 3.9+** — for API integration and preprocessing  
- **Databricks SQL Warehouse** — for query execution and data warehousing  
- **Apache Spark (PySpark)** — for scalable transformations  
- **SQL** — for analysis and data modeling  
- **GeoText + FuzzyWuzzy** — for location extraction and cleaning  
- **YAML** — for process configuration and automation  

---

## 🧩 Repository Structure

```text
end-to-end-analytics/
│
├── LICENSE
├── README.md
├── requirements.txt
│
├── data_collection/
│ ├── fetch_data.ipynb
│ └── jobs_api_readme.md
│
├── sql/
│ ├── city_and_country.ipynb
│ ├── exploratory_data_analysis.sql
│ ├── gold_ddl.sql
│ ├── init.ipynb
│ ├── silver_transformations.sql
│ │
│ └── sql_analysis/
│ ├── company_level_insights.sql
│ ├── geographic_insights.sql
│ ├── job_market_overview.sql
│ └── temporal_trends.sql
│
└── etl/
└── data_collection_and_transformation.yaml
```

---

## 🔁 Data Pipeline Overview

### 🥉 **Bronze Layer**
- Raw job posting data fetched via Findwork API (`fetch_data.ipynb`)
- Data automatically refreshed **once per day** using a scheduled Databricks workflow

### 🥈 **Silver Layer**
- Cleansed and standardized the bronze data
- Handled missing fields, normalized column names, and prepared data for analytics

### 🥇 **Gold Layer**
- Enriched data with derived attributes such as **city** and **country** (via NLP/GeoText)
- Created analytical models:
  - `gold.fact_job_postings`
  - `gold.dim_locations`
  - `gold.dim_companies`

---

## 📊 Analytical Questions

Some of the key analytical questions answered include:

1. Which companies are hiring the most across different regions?  
2. Are there countries or cities where hiring activity is growing or declining?  
3. What roles are most frequently advertised globally?  
4. How has job demand evolved over time by employment type?  
5. Which regions show the highest remote job opportunities?  
6. What are the top employers for tech vs non-tech roles?  
7. How does job posting activity vary seasonally?  
8. What are the top hiring cities by job category?  
9. How diverse is the global job market across industries?  
10. Which companies consistently post over multiple months?

*(See `sql/sql_analysis/` for all analytical queries.)*

---

## 🚀 Automation & Orchestration

- **Daily refresh** of job data via Databricks job scheduler  
- **ETL configuration** managed in `etl/data_collection_and_transformation.yaml`  
- **Automated Gold Layer build** integrates NLP-based country detection before model creation  

---
