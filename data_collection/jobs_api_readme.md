# Jobs Data Ingestion Pipeline

A robust data ingestion pipeline that fetches job postings from the Findwork API and loads them into a Databricks environment for downstream analytics and processing.

## Overview

This pipeline automates the extraction of job listings from the Findwork job board API, handling pagination seamlessly to retrieve the complete dataset. The data is then transformed and persisted in a Databricks bronze layer table, establishing the foundation for a medallion architecture data warehouse.

## Architecture

The pipeline implements a straightforward ETL (Extract, Transform, Load) process:

1. **Extract**: Fetches job data from the Findwork API with automatic pagination handling
2. **Transform**: Converts API responses into structured DataFrames
3. **Load**: Persists data to Databricks using PySpark for scalable storage

## Technical Stack

- **Python 3.x**: Core programming language
- **PySpark**: Distributed data processing
- **Pandas**: Data manipulation and transformation
- **Requests**: HTTP client for API communication
- **Databricks**: Cloud-based data platform

## Prerequisites

- Databricks workspace with cluster access
- Findwork API token (included in configuration)
- Python environment with required dependencies:
  ```
  requests
  pandas
  pyspark
  ```

## Database Schema

The pipeline creates and populates the following database structure:

- **Schema**: `bronze`
- **Table**: `bronze.jobs_table`

The bronze schema follows the medallion architecture pattern, serving as the raw data layer for subsequent silver and gold transformations.

## Implementation Details

### API Configuration

The pipeline connects to the Findwork API at `https://findwork.dev/api/jobs/` using token-based authentication. The implementation handles rate limiting and pagination automatically.

### Data Flow

1. **Pagination Handling**: Iteratively fetches all available job postings across multiple API pages
2. **Progress Tracking**: Provides real-time feedback on ingestion progress
3. **Data Persistence**: Overwrites the target table on each run to ensure data freshness

### Key Functions

- `fetch_all_jobs()`: Retrieves complete job dataset from the API with pagination support
- `load_to_database()`: Transforms and loads data into Databricks table

## Execution

Run the notebook cells sequentially:

1. Create the bronze schema
2. Configure API credentials and imports
3. Define extraction and loading functions
4. Execute the main pipeline

**Expected Output**: Successfully fetches and loads approximately 1,400+ job records into the bronze layer.

## Performance

- Processes full dataset in under 2 minutes (typical)
- Utilizes PySpark for efficient distributed writes

## Error Handling

The pipeline includes basic error handling for API failures, logging status codes and error messages when requests fail. Successful operations provide confirmation with record counts.

## Future Enhancements

- Implement incremental loading to reduce API calls
- Add data quality validation checks
- Create automated scheduling via Databricks Jobs
- Implement error notification system
- Add data lineage tracking

## License

This project is developed for portfolio demonstration purposes.

## Contact

For questions or collaboration opportunities, please reach out through the project repository.
