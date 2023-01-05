# Data-Vault-Example-Northwind

An example Data Vault data warehouse modelling Microsoft's Northwind sample database, built for SQL Server.


### Purpose

The objective of this project is to develop an accessible example data warehouse illustrating how to model the well-known Northwind sample database using the Data Vault methodology.

I intend the repository to mostly be of use to new Data Vault practitioners and go some way to helping join a few in dots in the somewhat steep learning curve that comes with Data Vault modelling. Personally, I found the 'getting the data in' part of Data Vault intuitive enough, but the 'getting the data out' a bit more challenging, and I hope the content of this repository is helpful in that regard.


### Setup and Documentation

1. Set up a SQL Server instance to hold the five component databases.
2. Open SQL Server Management Studio and connect to your SQL Server instance.
3. Run the following SQL scripts in this order to create the five databases.
	* SQL\DDL\Northwind\instnwnd.sql
	* SQL\DDL\Create_Database_Stage_Area.sql
	* SQL\DDL\Create_Database_Meta_Metrics_Error_Mart.sql
	* SQL\DDL\Create_Database_Data_Vault.sql
	* SQL\DDL\Create_Database_Information_Mart.sql
4. Confirm setup is correct with an initial load. Run the following SQL script to execute the stored procedures for the Stage_Area and Data_Vault databases.
	* SQL\ETL\Load_Data_Vault.sql
5. Additionally, check the contents of Meta_Metrics_Error_Mart.error.Error_Log for any unxpected errors.
6. Basic documentation covering the data model and table mapping can be found in the Documentation directory.
7. From here, follow your nose until it all makes sense. I recommend starting by altering some Northwind source data, rerunning the load, and following the changes through the layers into the Information_Mart views.


### Caveats and Notes

* First and foremost, if you're interested in working with Data Vault professionally, theres's no replacement for proper training and expert advice. I recommend seeking out a Data Vault Alliance course as your first port of call.

* My implementation here most closely adheres to Dan Linstedt's Data Vault 2.0 standard, but also takes some inspiration from the work of others, primarily Hans Hultgren and Patrick Cuba.

* This implementation should not be considered 'textbook' or representative of a real production Data Vault data warehouse; it is intended as a simplified example for educational purposes. A full-scale production data warehouse would almost certainly integrate data from multiple source systems, use incremental loads, and employ parallelised ETL scheduling as a just a few examples. My goal here was to have something somebody can set up, load, and be getting info out of the mart with just SQL Server in minutes.

* This project was coded by hand, so do not be surprised if there are occasional syntax inconsistencies. In a production implementation, I would consider a code automation tool to be a non-negotiable expense (WhereScape 3D/RED, Vaultspeed, dbtvault, etc.).

* My approach to Satellite types is simplistic, illustrating a few basic functions they commonly serve - link effectivity (including deletions and driving key relationships), business key deletions, and historisation of contextual attributes.

* The genuine business keys in Northwind are seldom uniquely indexed, so the surrogate IDs have been used where necessary.

* Information Mart objects are fully virtual, i.e. views. In addition to star schema fact, dimension, and bridge views, I have included 'replica' views, which, as the name suggests, exactly replicate all Northwind database source tables from their respective Data Vault objects. 

* Information Mart views present 'current' data as it existed in the data warehouse as at the specific (load effective) time specified in the 'Value' field of the 'Information_Mart_Load_Effective_Datetime' (ID = 1) record in Meta_Metrics_Error_Mart.meta.Parameter. If this field is left blank, the current datetime will be employed. This functionality is enabled by the use of PIT tables built for each Hub. 

* I haven't invested a great deal of time just yet in tweaking indexes for Information_Mart query performance.