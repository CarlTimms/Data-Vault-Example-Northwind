/*

	Business data vault link record tracking satellite tables 

*/


USE Data_Vault;
GO


-- S_LRT_L_Customer_Type_Northwind

DROP TABLE IF EXISTS bv.S_LRT_L_Customer_Type_Northwind;
GO

CREATE TABLE bv.S_LRT_L_Customer_Type_Northwind (
	  HK_L_Customer_Type binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, Appearance_Flag bit NOT NULL
	, Last_Seen_Datetime datetimeoffset(7) NULL
	, CONSTRAINT PK_S_LRT_L_Customer_Type_Northwind PRIMARY KEY NONCLUSTERED (HK_L_Customer_Type, DV_Load_Datetime) ON [INDEX]
) ON [DATA];
GO




-- S_LRT_L_Employee_Territory_Northwind

DROP TABLE IF EXISTS bv.S_LRT_L_Employee_Territory_Northwind;
GO

CREATE TABLE bv.S_LRT_L_Employee_Territory_Northwind (
	  HK_L_Employee_Territory binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, Appearance_Flag bit NOT NULL
	, Last_Seen_Datetime datetimeoffset(7) NULL
	, CONSTRAINT PK_S_LRT_L_Employee_Territory_Northwind PRIMARY KEY NONCLUSTERED (HK_L_Employee_Territory, DV_Load_Datetime) ON [INDEX]
) ON [DATA];
GO




-- S_LRT_L_Order_Detail_Northwind

DROP TABLE IF EXISTS bv.S_LRT_L_Order_Detail_Northwind;
GO

CREATE TABLE bv.S_LRT_L_Order_Detail_Northwind (
	  HK_L_Order_Detail binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, Appearance_Flag bit NOT NULL
	, Last_Seen_Datetime datetimeoffset(7) NULL
	, CONSTRAINT PK_S_LRT_L_Order_Detail_Northwind PRIMARY KEY NONCLUSTERED (HK_L_Order_Detail, DV_Load_Datetime) ON [INDEX]
) ON [DATA];
GO