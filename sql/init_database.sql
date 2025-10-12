/*
Initialize Database Schemas;
  The purpose of this script is to initialize all necessary schemas for this project
  
  Schemas:
    - bronze
    - silver
    - gold
*/

-- Create bronze schema
CREATE SCHEMA IF NOT EXISTS bronze;

-- Create silver schema
CREATE SCHEMA IF NOT EXISTS silver;

-- Create gold schema
CREATE SCHEMA IF NOT EXISTS gold;