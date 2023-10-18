/*

	Raw data vault hub standard satellite tables

*/


USE Data_Vault;
GO


-- S_H_Customer_Northwind

DROP TABLE IF EXISTS rv.S_H_Customer_Northwind;
GO

CREATE TABLE rv.S_H_Customer_Northwind (
	  HK_H_Customer binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, HD_S_H_Customer_Northwind binary(32) NOT NULL
	, CompanyName nvarchar(40) NULL
	, ContactName nvarchar(30) NULL
	, ContactTitle nvarchar(30) NULL
	, [Address] nvarchar(60) NULL
	, City nvarchar(15) NULL
	, Region nvarchar(15) NULL
	, PostalCode nvarchar(10) NULL
	, Country nvarchar(15) NULL
	, Phone nvarchar(24) NULL
	, Fax nvarchar(24) NULL
	, CONSTRAINT PK_S_H_Customer_Northwind PRIMARY KEY NONCLUSTERED (HK_H_Customer, DV_Load_Datetime) ON [INDEX]
) ON [DATA];
GO




-- S_H_Customer_Type_Northwind

DROP TABLE IF EXISTS rv.S_H_Customer_Type_Northwind;
GO

CREATE TABLE rv.S_H_Customer_Type_Northwind (
	  HK_H_Customer_Type binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, HD_S_H_Customer_Type_Northwind binary(32) NOT NULL
	, CustomerDesc ntext NULL
	, CONSTRAINT PK_S_H_Customer_Type_Northwind PRIMARY KEY NONCLUSTERED (HK_H_Customer_Type, DV_Load_Datetime) ON [INDEX]
) ON [DATA];
GO




-- S_H_Employee_Northwind

DROP TABLE IF EXISTS rv.S_H_Employee_Northwind;
GO

CREATE TABLE rv.S_H_Employee_Northwind (
	  HK_H_Employee binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, HD_S_H_Employee_Northwind binary(32) NOT NULL
	, LastName nvarchar(20) NULL
	, FirstName nvarchar(10) NULL
	, Title nvarchar(30) NULL
	, TitleOfCourtesy nvarchar(25) NULL
	, BirthDate datetime NULL
	, HireDate datetime NULL
	, [Address] nvarchar(60) NULL
	, City nvarchar(15) NULL
	, Region nvarchar(15) NULL
	, PostalCode nvarchar(10) NULL
	, Country nvarchar(15) NULL
	, HomePhone nvarchar(24) NULL
	, Extension nvarchar(4) NULL
	, Photo image NULL
	, Notes ntext NULL
	, PhotoPath nvarchar(255) NULL
	, CONSTRAINT PK_S_H_Employee_Northwind PRIMARY KEY NONCLUSTERED (HK_H_Employee, DV_Load_Datetime) ON [INDEX]
) ON [DATA];
GO




-- S_H_Order_Northwind

DROP TABLE IF EXISTS rv.S_H_Order_Northwind;
GO

CREATE TABLE rv.S_H_Order_Northwind (
	  HK_H_Order binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, HD_S_H_Order_Northwind binary(32) NOT NULL
	, OrderDate datetime NULL
	, RequiredDate datetime NULL
	, ShippedDate datetime NULL
	, Freight money NULL
	, ShipName nvarchar(40) NULL
	, ShipAddress nvarchar(60) NULL
	, ShipCity nvarchar(15) NULL
	, ShipRegion nvarchar(15) NULL
	, ShipPostalCode nvarchar(10) NULL
	, ShipCountry nvarchar(15) NULL
	, CONSTRAINT PK_S_H_Order_Northwind PRIMARY KEY NONCLUSTERED (HK_H_Order, DV_Load_Datetime) ON [INDEX]
) ON [DATA];
GO




-- S_H_Product_Northwind

DROP TABLE IF EXISTS rv.S_H_Product_Northwind;
GO

CREATE TABLE rv.S_H_Product_Northwind (
	  HK_H_Product binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, HD_S_H_Product_Northwind binary(32) NOT NULL
	, ProductName nvarchar(40) NULL
	, QuantityPerUnit nvarchar(20) NULL
	, UnitPrice money NULL
	, UnitsInStock smallint NULL
	, UnitsOnOrder smallint NULL
	, ReorderLevel smallint NULL
	, Discontinued bit NULL
	, CONSTRAINT PK_S_H_Product_Northwind PRIMARY KEY NONCLUSTERED (HK_H_Product, DV_Load_Datetime) ON [INDEX]
) ON [DATA];
GO




-- S_H_Product_Category_Northwind

DROP TABLE IF EXISTS rv.S_H_Product_Category_Northwind;
GO

CREATE TABLE rv.S_H_Product_Category_Northwind (
	  HK_H_Product_Category binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, HD_S_H_Product_Category_Northwind binary(32) NOT NULL
	, CategoryName nvarchar(15) NULL
	, [Description] ntext NULL
	, Picture image NULL
	, CONSTRAINT PK_S_H_Product_Category_Northwind PRIMARY KEY NONCLUSTERED (HK_H_Product_Category, DV_Load_Datetime) ON [INDEX]
) ON [DATA];
GO




-- S_H_Region_Northwind

DROP TABLE IF EXISTS rv.S_H_Region_Northwind;
GO

CREATE TABLE rv.S_H_Region_Northwind (
	  HK_H_Region binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, HD_S_H_Region_Northwind binary(32) NOT NULL
	, RegionDescription nchar(50) NULL
	, CONSTRAINT PK_S_H_Region_Northwind PRIMARY KEY NONCLUSTERED (HK_H_Region, DV_Load_Datetime) ON [INDEX]
) ON [DATA];
GO




-- S_H_Shipper_Northwind

DROP TABLE IF EXISTS rv.S_H_Shipper_Northwind;
GO

CREATE TABLE rv.S_H_Shipper_Northwind (
	  HK_H_Shipper binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, HD_S_H_Shipper_Northwind binary(32) NOT NULL
	, CompanyName nvarchar(40) NULL
	, Phone nvarchar(24) NULL
	, CONSTRAINT PK_S_H_Shipper_Northwind PRIMARY KEY NONCLUSTERED (HK_H_Shipper, DV_Load_Datetime) ON [INDEX]
) ON [DATA];
GO




-- S_H_Supplier_Northwind

DROP TABLE IF EXISTS rv.S_H_Supplier_Northwind;
GO

CREATE TABLE rv.S_H_Supplier_Northwind (
	  HK_H_Supplier binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, HD_S_H_Supplier_Northwind binary(32) NOT NULL
	, CompanyName nvarchar(40) NULL
	, ContactName nvarchar(30) NULL
	, ContactTitle nvarchar(30) NULL
	, [Address] nvarchar(60) NULL
	, City nvarchar(15) NULL
	, Region nvarchar(15) NULL
	, PostalCode nvarchar(10) NULL
	, Country nvarchar(15) NULL
	, Phone nvarchar(24) NULL
	, Fax nvarchar(24) NULL
	, HomePage ntext NULL
	, CONSTRAINT PK_S_H_Supplier_Northwind PRIMARY KEY NONCLUSTERED (HK_H_Supplier, DV_Load_Datetime) ON [INDEX]
) ON [DATA];
GO




-- S_H_Territory_Northwind

DROP TABLE IF EXISTS rv.S_H_Territory_Northwind;
GO

CREATE TABLE rv.S_H_Territory_Northwind (
	  HK_H_Territory binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, HD_S_H_Territory_Northwind binary(32) NOT NULL
	, TerritoryDescription nchar(50) NULL
	, CONSTRAINT PK_S_H_Territory_Northwind PRIMARY KEY NONCLUSTERED (HK_H_Territory, DV_Load_Datetime) ON [INDEX]
) ON [DATA];
GO