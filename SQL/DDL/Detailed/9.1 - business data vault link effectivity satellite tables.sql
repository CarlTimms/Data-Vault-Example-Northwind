/*

	Business data vault link effectivity satellite tables

*/


USE Data_Vault;
GO


-- S_LE_L_Employee_Reporting_Line_Northwind

DROP TABLE IF EXISTS bv.S_LE_L_Employee_Reporting_Line_Northwind;
GO

CREATE TABLE bv.S_LE_L_Employee_Reporting_Line_Northwind (
	  HK_L_Employee_Reporting_Line binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL 
	, HK_H_Employee__Direct_Report__DK binary(32) NOT NULL
	, Start_Datetime datetimeoffset(7) NOT NULL
	, HK_L_Employee_Reporting_Line__Previous binary(32) NULL
	, DV_Load_Datetime__Previous datetimeoffset(7) NULL
	, CONSTRAINT PK_S_LE_L_Employee_Reporting_Line_Northwind PRIMARY KEY NONCLUSTERED (HK_L_Employee_Reporting_Line, DV_Load_Datetime) ON [INDEX]
) ON [DATA];
GO




-- S_LE_L_Order_Header_Northwind

DROP TABLE IF EXISTS bv.S_LE_L_Order_Header_Northwind;
GO

CREATE TABLE bv.S_LE_L_Order_Header_Northwind (
	  HK_L_Order_Header binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL 
	, HK_H_Order__DK binary(32) NOT NULL
	, Start_Datetime datetimeoffset(7) NOT NULL
	, HK_L_Order_Header__Previous binary(32) NULL
	, DV_Load_Datetime__Previous datetimeoffset(7) NULL
	, CONSTRAINT PK_S_LE_L_Order_Header_Northwind PRIMARY KEY NONCLUSTERED (HK_L_Order_Header, DV_Load_Datetime) ON [INDEX]
) ON [DATA];
GO




-- S_LE_L_Product_Category_Northwind

DROP TABLE IF EXISTS bv.S_LE_L_Product_Category_Northwind;
GO

CREATE TABLE bv.S_LE_L_Product_Category_Northwind (
	  HK_L_Product_Category binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL 
	, HK_H_Product__DK binary(32) NOT NULL
	, Start_Datetime datetimeoffset(7) NOT NULL
	, HK_L_Product_Category__Previous binary(32) NULL
	, DV_Load_Datetime__Previous datetimeoffset(7) NULL
	, CONSTRAINT PK_S_LE_L_Product_Category_Northwind PRIMARY KEY NONCLUSTERED (HK_L_Product_Category, DV_Load_Datetime) ON [INDEX]
) ON [DATA];
GO




-- S_LE_L_Product_Supplier_Northwind

DROP TABLE IF EXISTS bv.S_LE_L_Product_Supplier_Northwind;
GO

CREATE TABLE bv.S_LE_L_Product_Supplier_Northwind (
	  HK_L_Product_Supplier binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL 
	, HK_H_Product__DK binary(32) NOT NULL
	, Start_Datetime datetimeoffset(7) NOT NULL
	, HK_L_Product_Supplier__Previous binary(32) NULL
	, DV_Load_Datetime__Previous datetimeoffset(7) NULL
	, CONSTRAINT PK_S_LE_L_Product_Supplier_Northwind PRIMARY KEY NONCLUSTERED (HK_L_Product_Supplier, DV_Load_Datetime) ON [INDEX]
) ON [DATA];
GO




-- S_LE_L_Territory_Region_Northwind

DROP TABLE IF EXISTS bv.S_LE_L_Territory_Region_Northwind;
GO

CREATE TABLE bv.S_LE_L_Territory_Region_Northwind (
	  HK_L_Territory_Region binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL 
	, HK_H_Territory__DK binary(32) NOT NULL
	, Start_Datetime datetimeoffset(7) NOT NULL
	, HK_L_Territory_Region__Previous binary(32) NULL
	, DV_Load_Datetime__Previous datetimeoffset(7) NULL
	, CONSTRAINT PK_S_LE_L_Territory_Region_Northwind PRIMARY KEY NONCLUSTERED (HK_L_Territory_Region, DV_Load_Datetime) ON [INDEX]
) ON [DATA];
GO