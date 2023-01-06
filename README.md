# Data-Vault-Example-Northwind

An example Data Vault data warehouse modelling Microsoft's Northwind sample database, built for SQL Server.


### Purpose

The objective of this project is to develop an easily accessible example data warehouse illustrating how to model the well-known Northwind sample database using the Data Vault methodology.

I intend the repository to mostly be of use to new Data Vault practitioners, providing a convenient option for hands-on experimentation. Hopefully it helps join a few dots on the somewhat steep learning curve that comes with Data Vault modelling.


### Setup

1. Set up a SQL Server instance to hold the five component databases.
2. Run the following SQL scripts in this order to create the five databases.
	* SQL\DDL\Northwind\instnwnd.sql
	* SQL\DDL\Create_Database_Stage_Area.sql
	* SQL\DDL\Create_Database_Meta_Metrics_Error_Mart.sql
	* SQL\DDL\Create_Database_Data_Vault.sql
	* SQL\DDL\Create_Database_Information_Mart.sql
3. Confirm setup is correct with an initial load. Run the following SQL script to execute the stored procedures for the Stage_Area and Data_Vault databases.
	* SQL\ETL\Load_Data_Vault.sql
4. Additionally, check the contents of Meta_Metrics_Error_Mart.error.Error_Log for any unexpected errors.


### Documentation
Basic documentation covering the data models and table mapping can be found in the Documentation directory.