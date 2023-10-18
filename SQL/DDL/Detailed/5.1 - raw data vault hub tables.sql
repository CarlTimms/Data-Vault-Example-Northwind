/*
	
	Raw data vault tables - Hubs

*/


USE Data_Vault;
GO


-- H_Customer

DROP TABLE IF EXISTS rv.H_Customer;
GO

CREATE TABLE rv.H_Customer (
	  HK_H_Customer binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, CustomerID nchar(5)
	, CONSTRAINT PK_H_Customer PRIMARY KEY NONCLUSTERED (HK_H_Customer) ON [INDEX]
	, CONSTRAINT UK_H_Customer UNIQUE NONCLUSTERED (CustomerID) ON [INDEX]
) ON [DATA];
GO




-- H_Customer_Type

DROP TABLE IF EXISTS rv.H_Customer_Type;
GO

CREATE TABLE rv.H_Customer_Type (
	  HK_H_Customer_Type binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, CustomerTypeID nchar(10)
	, CONSTRAINT PK_H_Customer_Type PRIMARY KEY NONCLUSTERED (HK_H_Customer_Type) ON [INDEX]
	, CONSTRAINT UK_H_Customer_Type UNIQUE NONCLUSTERED (CustomerTypeID) ON [INDEX]
) ON [DATA];
GO




-- H_Employee

DROP TABLE IF EXISTS rv.H_Employee;
GO

CREATE TABLE rv.H_Employee (
	  HK_H_Employee binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, EmployeeID int NOT NULL
	, CONSTRAINT PK_H_Employee PRIMARY KEY NONCLUSTERED (HK_H_Employee) ON [INDEX]
	, CONSTRAINT UK_H_Employee UNIQUE NONCLUSTERED (EmployeeID) ON [INDEX]
) ON [DATA];
GO




-- H_Order

DROP TABLE IF EXISTS rv.H_Order;
GO

CREATE TABLE rv.H_Order (
	  HK_H_Order binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, OrderID int NOT NULL
	, CONSTRAINT PK_H_Order PRIMARY KEY NONCLUSTERED (HK_H_Order) ON [INDEX]
	, CONSTRAINT UK_H_Order UNIQUE NONCLUSTERED (OrderID) ON [INDEX]
) ON [DATA];
GO




-- H_Product

DROP TABLE IF EXISTS rv.H_Product;
GO

CREATE TABLE rv.H_Product (
	  HK_H_Product binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, ProductID int NOT NULL
	, CONSTRAINT PK_H_Product PRIMARY KEY NONCLUSTERED (HK_H_Product) ON [INDEX]
	, CONSTRAINT UK_H_Product UNIQUE NONCLUSTERED (ProductID) ON [INDEX]
) ON [DATA];
GO




-- H_Product_Category

DROP TABLE IF EXISTS rv.H_Product_Category;
GO

CREATE TABLE rv.H_Product_Category (
	  HK_H_Product_Category binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, CategoryID int NOT NULL
	, CONSTRAINT PK_H_Product_Category PRIMARY KEY NONCLUSTERED (HK_H_Product_Category) ON [INDEX]
	, CONSTRAINT UK_H_Product_Category UNIQUE NONCLUSTERED (CategoryID) ON [INDEX]
) ON [DATA];
GO




-- H_Region

DROP TABLE IF EXISTS rv.H_Region;
GO

CREATE TABLE rv.H_Region (
	  HK_H_Region binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, RegionID int NOT NULL
	, CONSTRAINT PK_H_Region PRIMARY KEY NONCLUSTERED (HK_H_Region) ON [INDEX]
	, CONSTRAINT UK_H_Region UNIQUE NONCLUSTERED (RegionID) ON [INDEX]
) ON [DATA];
GO




-- H_Shipper

DROP TABLE IF EXISTS rv.H_Shipper;
GO

CREATE TABLE rv.H_Shipper (
	  HK_H_Shipper binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, ShipperID int NOT NULL
	, CONSTRAINT PK_H_Shipper PRIMARY KEY NONCLUSTERED (HK_H_Shipper) ON [INDEX]
	, CONSTRAINT UK_H_Shipper UNIQUE NONCLUSTERED (ShipperID) ON [INDEX]
) ON [DATA];
GO




-- H_Supplier

DROP TABLE IF EXISTS rv.H_Supplier;
GO

CREATE TABLE rv.H_Supplier (
	  HK_H_Supplier binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, SupplierID int NOT NULL
	, CONSTRAINT PK_H_Supplier PRIMARY KEY NONCLUSTERED (HK_H_Supplier) ON [INDEX]
	, CONSTRAINT UK_H_Supplier UNIQUE NONCLUSTERED (SupplierID) ON [INDEX]
) ON [DATA];
GO




-- H_Territory

DROP TABLE IF EXISTS rv.H_Territory;
GO

CREATE TABLE rv.H_Territory (
	  HK_H_Territory binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, TerritoryID nvarchar(20) NOT NULL
	, CONSTRAINT PK_H_Territory PRIMARY KEY NONCLUSTERED (HK_H_Territory) ON [INDEX]
	, CONSTRAINT UK_H_Territory UNIQUE NONCLUSTERED (TerritoryID) ON [INDEX]
) ON [DATA];
GO