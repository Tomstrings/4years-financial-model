-- SQL PERSONAL ASSIGNMENT TASK 1: ESPN_CHARGES
-- BEGINNING OF SCRIPT --
-- DATE OF CREATION: 08/03/2026
-- DATE OF LAST MODIFICATION: 11/03/2026
-- THE ASSIGNMENT
#1. You are required to create a database named: "SEPN_charges_db" in MySQL and then 
#2. Create three tables named sepn_charges_2022_23_tb, sepn_charges_2023_24_tb and sepn_charges_2024_25_tb.
#Load the below three csv files into each tables.
#1. sepn_charges_2022_23.csv
#2. sepn_charges_2023_24.csv
#3. sepn_charges_2024_25.csv

# SPECIFIC STEPS
#1. Write SQL codes to check the structures of each of the 3 tables
#2. Write SQL codes to display the number of records in each tables
#3. Write SQL codes to display the number of customers who are Non-final demand 
-- (That is customers with zero(0) values as Residual Bands for the year 2023/24 and 2024/25.
#4. Write SQL codes to display the number of customers who are final demand
-- (That is customers with values 1 to 4 as Residual Bands for the year 2023/24 and 2024/25.
#5. Write SQL Codes calculate the annual import fixed charges for each customers of the three years.
#6. Write SQL code to extract the year 2023/24 customer name, 2023/24 residual bands, 
-- each year daily import fixed charge, and each year annual import fixed charge. 
-- The result should be extracted where 23/24 residual bands is equal to 24/25 residual bands, and 
-- the 2023/24 customer names is equal to 2024/25 customer names and 2022/23 customer names. 
#7. Create a temporary table (view) based on the query results in question 6.
#8. Write a SQL query to extract the residual bands and annual fixed charges from the view created in question 7 
-- and then Aggregate the annual fixed charges based on bands for each year and order them based on bands.

-- CODE TO CREATE SEPN_charges Database
DROP DATABASE IF EXISTS SEPN_charges_db;
CREATE DATABASE IF NOT EXISTS SEPN_charges_db;

-- TO SELECT SEPN_charges Database for use
USE SEPN_charges_db;

-- CREATING THE FIRST TABLE
-- Creating the sepn_charges_2022_23 table
DROP TABLE IF EXISTS sepn_charges_2022_23_tb;
CREATE TABLE IF NOT EXISTS sepn_charges_2022_23_tb(
cust_name VARCHAR(10) NOT NULL PRIMARY KEY,
Import_Super_Red_charge DECIMAL(8,3) DEFAULT 0,
Import_fixed_charge DECIMAL(8,2) DEFAULT 0,
Export_Super_Red_charge DECIMAL(8,3) DEFAULT 0,
Export_fixed_charge DECIMAL(8,2) DEFAULT 0
)ENGINE=INNODB 
DEFAULT CHARSET=UTF8MB4 
DEFAULT COLLATE = UTF8MB4_UNICODE_CI;

-- CREATING THE SECOND TABLE
-- Creating the sepn_charges_2023_24 table
DROP TABLE IF EXISTS sepn_charges_2023_24_tb;
CREATE TABLE IF NOT EXISTS sepn_charges_2023_24_tb(
cust_name VARCHAR(10) NOT NULL PRIMARY KEY,
Residual_Charging_Band SMALLINT,
Import_Super_Red_charge DECIMAL(8,3) DEFAULT 0,
Import_fixed_charge DECIMAL(8,2) DEFAULT 0,
Export_Super_Red_charge DECIMAL(8,3) DEFAULT 0,
Export_fixed_charge DECIMAL(8,2) DEFAULT 0
)ENGINE=INNODB 
DEFAULT CHARSET=UTF8MB4 
DEFAULT COLLATE = UTF8MB4_UNICODE_CI;

-- CREATING THE THIRD TABLE
-- Creating the sepn_charges_2024_25 table
DROP TABLE IF EXISTS sepn_charges_2024_25_tb;
CREATE TABLE IF NOT EXISTS sepn_charges_2024_25_tb(
cust_name VARCHAR(10) NOT NULL PRIMARY KEY,
Residual_Charging_Band SMALLINT,
Import_Super_Red_charge DECIMAL(8,3) DEFAULT 0,
Import_fixed_charge DECIMAL(8,2) DEFAULT 0,
Export_Super_Red_charge DECIMAL(8,3) DEFAULT 0,
Export_fixed_charge DECIMAL(8,2) DEFAULT 0
)ENGINE=INNODB 
DEFAULT CHARSET=UTF8MB4 
DEFAULT COLLATE = UTF8MB4_UNICODE_CI;

-- Set the local_infile to 'ON' for faster loading
SET GLOBAL local_infile = 'ON';

-- Use the SHOW command to see that it is effected
SHOW GLOBAL VARIABLES LIKE 'local_infile';
SHOW VARIABLES LIKE "secure_file_priv";

-- Script to load data from sepn_charges_2022_23.csv file into the table
TRUNCATE sepn_charges_2022_23_tb;
-- NB: 'ORCHRD' was a duplicate record under customer name in the sepn_charges_2022_23.csv
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/input_files/sepn_charges_2022_23.csv'
INTO TABLE sepn_charges_2022_23_tb
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(cust_name,Import_Super_Red_charge,Import_fixed_charge,
Export_Super_Red_charge,Export_fixed_charge);

-- script to load data from sepn_charges_2023_24.csv file into the table
TRUNCATE sepn_charges_2023_24_tb;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/input_files/sepn_charges_2023_24.csv' 
INTO TABLE sepn_charges_2023_24_tb
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(cust_name,Residual_Charging_Band,Import_Super_Red_charge,Import_fixed_charge,
Export_Super_Red_charge,Export_fixed_charge);

-- Script to load data from sepn_charges_2024_25.csv file into the table
TRUNCATE sepn_charges_2024_25_tb;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/input_files/sepn_charges_2024_25.csv' 
INTO TABLE sepn_charges_2024_25_tb
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(cust_name,Residual_Charging_Band,Import_Super_Red_charge,Import_fixed_charge,
Export_Super_Red_charge,Export_fixed_charge);

-- 1. DISPLAYING THE STRUCTURE OF THE THREE TABLES CREATED 
-- Displaying the Table Structure for sepn_charges_2022_23_tb
DESCRIBE sepn_charges_2022_23_tb;

-- Displaying the Table Structure for sepn_charges_2023_24_tb
DESCRIBE sepn_charges_2023_24_tb;

-- Displaying the Table Structure for sepn_charges_2024_25_tb
DESCRIBE sepn_charges_2024_25_tb;

-- 2. DISPLAYING TOTAL NUMBER OF RECORDS IMPORTED INTO EACH TABLE
-- Displaying the total number of records in the tables sepn_charges_2022_23_tb
SELECT COUNT(*) -- Using COUNT function is faster
FROM sepn_charges_2022_23_tb;

SELECT *   -- The asterisk (*) is used to indicate all data
FROM sepn_charges_2022_23_tb
LIMIT 5;
-- Displaying the total number of records in the table sepn_charges_2023_24_tb
SELECT COUNT(*) -- Using COUNT function is faster
FROM sepn_charges_2023_24_tb;

SELECT *   -- The asterisk (*) is used to indicate all data
FROM sepn_charges_2023_24_tb
LIMIT 5;

-- Displaying the total number of records in the tables sepn_charges_2024_25_tb
SELECT COUNT(*) -- Using COUNT function is faster
FROM sepn_charges_2024_25_tb;

SELECT *   -- The asterisk (*) is used to indicate all data
FROM sepn_charges_2024_25_tb
LIMIT 5;

-- 3. TO DISPLAY THE NUMBER OF CUSTOMERS WHO ARE NON-FINAL DEMAND 
-- That is customers with zero(0) values as Residual Bands for the year 2023/24
SELECT * 
FROM sepn_charges_2023_24_tb
WHERE Residual_Charging_Band = 0;

-- That is customers with zero(0) values as Residual Bands for the year 2024/25
SELECT * 
FROM sepn_charges_2024_25_tb
WHERE Residual_Charging_Band = 0;

-- 4. TO DISPLAY THE NUMBER OF CUSTOMERS WHO ARE FINAL DEMAND 
-- That is customers with values 1 to 4 as Residual Bands for the year 2023/24
SELECT *
FROM sepn_charges_2023_24_tb
WHERE Residual_Charging_Band != 0
ORDER BY Residual_Charging_Band;

-- That is customers with values 1 to 4 as Residual Bands for the year 2024/25
SELECT * 
FROM sepn_charges_2024_25_tb
WHERE Residual_Charging_Band != 0
ORDER BY Residual_Charging_Band;

-- 5. TO EXTRACT CUNSTOMER NAME, RCB AND IMPORT FIXED CAHRGES FOR EACH CUSTOMER
SELECT sepn_2023.cust_name AS sepn_23_cust_name,
sepn_2023.Residual_Charging_Band AS sepn_23_rcb,
sepn_2022.Import_fixed_charge AS sepn_22_ifc,
sepn_2023.Import_fixed_charge AS sepn_23_ifc,
sepn_2024.Import_fixed_charge AS sepn_24_ifc
FROM
sepn_charges_2024_25_tb AS sepn_2024,
sepn_charges_2023_24_tb AS sepn_2023,
sepn_charges_2022_23_tb AS sepn_2022
WHERE
sepn_2023.cust_name = sepn_2022.cust_name
AND sepn_2023.cust_name = sepn_2024.cust_name;

-- 6. TO CALCULATE ANNUAL IMPORT FIXED CAHRGES FOR EACH CUSTOMER FOR 3 FULL YEARS
SELECT sepn_2023.cust_name AS sepn_23_cust_name,
sepn_2023.Residual_Charging_Band AS sepn_23_rcb,
sepn_2022.Import_fixed_charge AS sepn_22_ifc,
sepn_2023.Import_fixed_charge AS sepn_23_ifc,
sepn_2024.Import_fixed_charge AS sepn_24_ifc,
ROUND((sepn_2022.Import_fixed_charge/100),2)*365 AS sepn_22_afc,
ROUND((sepn_2023.Import_fixed_charge/100),2)*366 AS sepn_23_afc,
ROUND((sepn_2024.Import_fixed_charge/100),2)*365 AS sepn_24_afc
FROM
sepn_charges_2024_25_tb AS sepn_2024,
sepn_charges_2023_24_tb AS sepn_2023,
sepn_charges_2022_23_tb AS sepn_2022
WHERE
sepn_2023.cust_name = sepn_2022.cust_name
AND sepn_2023.cust_name = sepn_2024.cust_name
AND sepn_2023.Residual_Charging_Band = sepn_2024.Residual_Charging_Band;

-- 7.  TO CREATE A VIEW TABLE FOR THE RESULT OF THE COMPUTATION ABOVE
DROP VIEW IF EXISTS full_3_years_sepn_charges_vw;
CREATE VIEW full_3_years_sepn_charges_vw AS 
SELECT sepn_2023.cust_name AS sepn_23_cust_name,
sepn_2023.Residual_Charging_Band AS sepn_23_rcb,
sepn_2022.Import_fixed_charge AS sepn_22_ifc,
sepn_2023.Import_fixed_charge AS sepn_23_ifc,
sepn_2024.Import_fixed_charge AS sepn_24_ifc,
ROUND((sepn_2022.Import_fixed_charge/100),2)*365 AS sepn_22_afc,
ROUND((sepn_2023.Import_fixed_charge/100),2)*366 AS sepn_23_afc,
ROUND((sepn_2024.Import_fixed_charge/100),2)*365 AS sepn_24_afc
FROM
sepn_charges_2024_25_tb AS sepn_2024,
sepn_charges_2023_24_tb AS sepn_2023,
sepn_charges_2022_23_tb AS sepn_2022
WHERE
sepn_2023.cust_name = sepn_2022.cust_name
AND sepn_2023.cust_name = sepn_2024.cust_name
AND sepn_2023.Residual_Charging_Band = sepn_2024.Residual_Charging_Band;

-- VIEWING THE TEMPORARY TABLE CREATED
SELECT *
FROM full_3_years_sepn_charges_vw;

-- CODE TO EXPORT THE RESULT TO AN EXTERNAL CSV FILE
SELECT 'sepn_23_cust_name', 'sepn_23_rcb', 'sepn_22_ifc', 'sepn_23_ifc', 'sepn_24_ifc', 'sepn_22_afc', 'sepn_23_afc', 'sepn_24_afc' # Header
UNION 
SELECT sepn_23_cust_name, sepn_23_rcb, sepn_22_ifc, sepn_23_ifc, sepn_24_ifc, sepn_22_afc, sepn_23_afc, sepn_24_afc # Actual Data
FROM full_3_years_sepn_charges_vw
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/output_files/full_3_years_sepn_charges_19-03-2026_v2.csv' 
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n';
 
-- 8. AGGREGATING ANNUAL FIXED CHARGES BASED ON RESIDUAL BANDS FROM THE VIEW CREATED
SELECT DISTINCT(COALESCE(sepn_23_rcb,0)) AS RCB,
SUM(sepn_22_afc) AS total_sepn_22_afc,
SUM(sepn_23_afc) AS total_sepn_23_afc,
SUM(sepn_24_afc) AS total_sepn_24_afc
FROM full_3_years_sepn_charges_vw
GROUP BY RCB
HAVING RCB>0
ORDER BY RCB;

-- END OF SCRIPT