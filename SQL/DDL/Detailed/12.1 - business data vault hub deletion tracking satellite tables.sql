/*

	Business data vault hub deletion tracking satellite tables

*/


USE Data_Vault;
GO


-- S_HDT_H_Customer_Northwind

DROP TABLE IF EXISTS bv.S_HDT_H_Customer_Northwind
GO

CREATE TABLE bv.S_HDT_H_Customer_Northwind (
	  HK_H_Customer binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, Is_Deleted_Flag bit NOT NULL
	, Deleted_Datetime datetimeoffset(7) NULL
	, CONSTRAINT PK_S_HDT_H_Customer_Northwind PRIMARY KEY NONCLUSTERED (HK_H_Customer, DV_Load_Datetime) ON [INDEX]
) ON [INDEX];
GO




-- S_HDT_H_Customer_Type_Northwind

DROP TABLE IF EXISTS bv.S_HDT_H_Customer_Type_Northwind
GO

CREATE TABLE bv.S_HDT_H_Customer_Type_Northwind (
	  HK_H_Customer_Type binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, Is_Deleted_Flag bit NOT NULL
	, Deleted_Datetime datetimeoffset(7) NULL
	, CONSTRAINT PK_S_HDT_H_Customer_Type_Northwind PRIMARY KEY NONCLUSTERED (HK_H_Customer_Type, DV_Load_Datetime) ON [INDEX]
) ON [INDEX];
GO




-- S_HDT_H_Employee_Northwind

DROP TABLE IF EXISTS bv.S_HDT_H_Employee_Northwind
GO

CREATE TABLE bv.S_HDT_H_Employee_Northwind (
	  HK_H_Employee binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, Is_Deleted_Flag bit NOT NULL
	, Deleted_Datetime datetimeoffset(7) NULL
	, CONSTRAINT PK_S_HDT_H_Employee_Northwind PRIMARY KEY NONCLUSTERED (HK_H_Employee, DV_Load_Datetime) ON [INDEX]
) ON [INDEX];
GO




-- S_HDT_H_Order_Northwind

DROP TABLE IF EXISTS bv.S_HDT_H_Order_Northwind
GO

CREATE TABLE bv.S_HDT_H_Order_Northwind (
	  HK_H_Order binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, Is_Deleted_Flag bit NOT NULL
	, Deleted_Datetime datetimeoffset(7) NULL
	, CONSTRAINT PK_S_HDT_H_Order_Northwind PRIMARY KEY NONCLUSTERED (HK_H_Order, DV_Load_Datetime) ON [INDEX]
) ON [INDEX];
GO




-- S_HDT_H_Product_Category_Northwind

DROP TABLE IF EXISTS bv.S_HDT_H_Product_Category_Northwind
GO

CREATE TABLE bv.S_HDT_H_Product_Category_Northwind (
	  HK_H_Product_Category binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, Is_Deleted_Flag bit NOT NULL
	, Deleted_Datetime datetimeoffset(7) NULL
	, CONSTRAINT PK_S_HDT_H_Product_Category_Northwind PRIMARY KEY NONCLUSTERED (HK_H_Product_Category, DV_Load_Datetime) ON [INDEX]
) ON [INDEX];
GO




-- S_HDT_H_Product_Northwind

DROP TABLE IF EXISTS bv.S_HDT_H_Product_Northwind
GO

CREATE TABLE bv.S_HDT_H_Product_Northwind (
	  HK_H_Product binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, Is_Deleted_Flag bit NOT NULL
	, Deleted_Datetime datetimeoffset(7) NULL
	, CONSTRAINT PK_S_HDT_H_Product_Northwind PRIMARY KEY NONCLUSTERED (HK_H_Product, DV_Load_Datetime) ON [INDEX]
) ON [INDEX];
GO




-- S_HDT_H_Region_Northwind

DROP TABLE IF EXISTS bv.S_HDT_H_Region_Northwind
GO

CREATE TABLE bv.S_HDT_H_Region_Northwind (
	  HK_H_Region binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, Is_Deleted_Flag bit NOT NULL
	, Deleted_Datetime datetimeoffset(7) NULL
	, CONSTRAINT PK_S_HDT_H_Region_Northwind PRIMARY KEY NONCLUSTERED (HK_H_Region, DV_Load_Datetime) ON [INDEX]
) ON [INDEX];
GO




-- S_HDT_H_Shipper_Northwind

DROP TABLE IF EXISTS bv.S_HDT_H_Shipper_Northwind
GO

CREATE TABLE bv.S_HDT_H_Shipper_Northwind (
	  HK_H_Shipper binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, Is_Deleted_Flag bit NOT NULL
	, Deleted_Datetime datetimeoffset(7) NULL
	, CONSTRAINT PK_S_HDT_H_Shipper_Northwind PRIMARY KEY NONCLUSTERED (HK_H_Shipper, DV_Load_Datetime) ON [INDEX]
) ON [INDEX];
GO




-- S_HDT_H_Supplier_Northwind

DROP TABLE IF EXISTS bv.S_HDT_H_Supplier_Northwind
GO

CREATE TABLE bv.S_HDT_H_Supplier_Northwind (
	  HK_H_Supplier binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, Is_Deleted_Flag bit NOT NULL
	, Deleted_Datetime datetimeoffset(7) NULL
	, CONSTRAINT PK_S_HDT_H_Supplier_Northwind PRIMARY KEY NONCLUSTERED (HK_H_Supplier, DV_Load_Datetime) ON [INDEX]
) ON [INDEX];
GO




-- S_HDT_H_Territory_Northwind

DROP TABLE IF EXISTS bv.S_HDT_H_Territory_Northwind
GO

CREATE TABLE bv.S_HDT_H_Territory_Northwind (
	  HK_H_Territory binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, Is_Deleted_Flag bit NOT NULL
	, Deleted_Datetime datetimeoffset(7) NULL
	, CONSTRAINT PK_S_HDT_H_Territory_Northwind PRIMARY KEY NONCLUSTERED (HK_H_Territory, DV_Load_Datetime) ON [INDEX]
) ON [INDEX];
GO