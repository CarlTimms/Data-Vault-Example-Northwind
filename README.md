# Data-Vault-Example-Northwind

An example Data Vault data warehouse modelling Microsoft's Northwind sample database, built for SQL Server.


### Purpose

The objective of this project is to develop an easiily accessible example data warehouse illustrating how to model the well-known Northwind sample database using the Data Vault methodology.

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
4. Additionally, check the contents of Meta_Metrics_Error_Mart.error.Error_Log for any unxpected errors.


### Documentation
Basic documentation covering the data model and table mapping can be found in the Documentation directory.


### Caveats and Notes

* My implementation here most closely adheres to Dan Linstedt's Data Vault 2.0 standard, but also takes some inspiration from the work of others, primarily Hans Hultgren and Patrick Cuba.

* This implementation should not be considered 'textbook' or representative of a real production Data Vault data warehouse; it is intended as a simplified example for educational purposes. A full-scale production data warehouse would almost certainly integrate data from multiple source systems, use incremental loads, and employ parallelised ETL scheduling as a just a few examples. My goal here was to have something somebody can set up, load, and be getting info out of the information mart with just SQL Server in a matter of minutes.

* This project was coded by hand, so no doubt there are a few inconsistencies in coding conventions. In a professional Data Vault implementation, I would consider a code automation tool to be a non-negotiable expense (WhereScape 3D/RED, Vaultspeed, dbtvault, etc.).

* My approach to Satellite types is simplistic, illustrating a few basic functions they commonly serve - link effectivity (including deletions and driving key relationships), business key deletions, and historisation of contextual attributes.

* Business keys in Northwind are seldom uniquely indexed, so the surrogate IDs have been used where necessary.

* Information Mart objects are fully virtual, i.e. views. In addition to star schema facts, dimensions, and bridges, I have included 'replica' views, which, as the name suggests, exactly replicate all Northwind database source tables from their respective Data Vault objects. 

* Information Mart views present 'current' data as it existed in the data warehouse as at the specific (load effective) time specified in the 'Value' field of the 'Information_Mart_Load_Effective_Datetime' (ID = 1) record in Meta_Metrics_Error_Mart.meta.Parameter. If this field is left blank, the current datetime will be employed. This functionality is enabled by the use of PIT tables built for each Hub. 

* Remaining to-do items include fleshing out the Meta_Metrics_Error_Mart and tweaking indexing for Information_Mart query performance.
