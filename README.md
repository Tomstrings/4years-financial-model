# 3 years-financial-model
Building SEPN charges 3 years financial model using MySQL
SQL PERSONAL PROJECT TASKS

1. Create a database named: "SEPN_charges_db" in MySQL and then 

2. Create three tables named sepn_charges_2022_23_tb, sepn_charges_2023_24_tb and sepn_charges_2024_25_tb.

Load the three csv files into each tables.
1. sepn_charges_2022_23.csv
2. sepn_charges_2023_24.csv
3. sepn_charges_2024_25.csv

Tasks:

1. Write SQL codes to check the structures of each of the 3 tables

2. Write SQL codes to display the number of records in each tables

3. Write SQL codes to display the number of customers who are Non-final demand (That is customers with zero(0) values as Residual Bands for the year 2023/24 and 2024/25.

4. Write SQL codes to display the number of customers who are final demand (That is customers with values 1 to 4 as Residual Bands for the year 2023/24 and 2024/25.

5. Write SQL Codes calculate the annual import fixed charges for each customers of the three years.

6. Write SQL code to extract the year 2023/24 customer name, 2023/24 residual bands, each year daily import fixed charge, and each year annual import fixed charge. The result should be extracted where 23/24 residual bands is equal to 24/25 residual bands, and the 2023/24 customer names is equal to 2024/25 customer names and 2022/23 customer names. 

7. Create a temporary table (view) based on the query results in question 6.
8. Write a SQL query to extract the residual bands and annual fixed charges from the view created in question 7 and then Aggregate the annual fixed charges based on bands for each year and order them based on bands.
al fixed charges from the view created in question 7 and then Aggregate the annual fixed charges based on bands for each year and order them based on bands.
