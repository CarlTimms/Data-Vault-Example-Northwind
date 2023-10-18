# Data-Vault-Example-Northwind

An example Data Vault 2.0 data warehouse modelling Microsoft's Northwind sample database.


### Purpose

The objective of this project is to develop an easily accessible example data warehouse illustrating how to model the well-known Northwind sample database using the Data Vault 2.0 modelling standards.


### Setup

1. Set up a new SQL Server instance to hold the five component databases
2. Run the following script to create the source Northwind database
	* SQL\DDL\Source\instnwnd.sql
3. Create the Data Vault databases. You have two options:  
	They can be set up quickly by executing the SQL scripts in the following directory  
	* SQL\DDL\Simple  
	Alternatively, they can be created in a step-by-step fashion by executing the scripts within  
	* SQL\DDL\Detailed  
4. Conduct the one-off load of ghost records into the necessary raw Data Vault tables
	* SQL\DML\ghost records.sql
5. Confirm setup is correct with an initial load. Run the following script to execute the stored procedures in Staging, Data_Vault, and Information_Mart
	* SQL\DCL\load all.sql
6. From here you should be able to query the dimensionally-modelled 'star' schema views in Information_Mart


### Notes

- Basic documentation covering the data models, standards, conventions, etc. can be located in the Documentation directory
- This project does not cover the creation of the meta/metrics/error marts at this stage. Refer to Dan Linstedt's book 'Building a Scalable Data Warehouse with Data Vault 2.0' for the necessary details
- Any attempt at building a production Data Vault 2.0 data warehouse should be preceded by taking the CDVP2 course offered by [Data Vault Alliance](https://datavaultalliance.com/) and their authorised training partners
- This implementation is compliant with Data Vault 2.0 standards taught in CDVP2 as at July 2023