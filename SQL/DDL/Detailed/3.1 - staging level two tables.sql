/*
	
	Staging level two tables

*/


USE Staging;
GO


-- Categories

DROP TABLE IF EXISTS northwind.L2_Northwind_Categories;
GO

CREATE TABLE northwind.L2_Northwind_Categories (
	  DV_Sequence_Number integer identity(1, 1) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, HK_H_Product_Category binary(32) NOT NULL
	, HD_S_H_Product_Category_Northwind binary(32) NOT NULL
	, CategoryID int NULL  -- PK
	, CategoryName nvarchar(15) NULL
	, [Description] nvarchar(max) NULL  -- Data type ntext deprecated. use nvarchar(max) instead
	, Picture varbinary(max) NULL  -- Data type image deprecated. Use varbinary(max) instead
	, CONSTRAINT PK_L2_Northwind_Categories PRIMARY KEY CLUSTERED (DV_Sequence_Number) ON [INDEX]
) ON [DATA];
GO




-- CustomerCustomerDemo

DROP TABLE IF EXISTS northwind.L2_Northwind_CustomerCustomerDemo;
GO

CREATE TABLE northwind.L2_Northwind_CustomerCustomerDemo (
	  DV_Sequence_Number integer identity(1, 1) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, HK_H_Customer binary(32) NOT NULL
	, HK_H_Customer_Type binary(32) NOT NULL
	, HK_L_Customer_Type binary(32) NOT NULL
	, CustomerID nchar(5) NULL  -- PK, FK (Customers)
	, CustomerTypeID nchar(10) NULL  -- PK, FK (CustomerDemographics)
	, CONSTRAINT PK_L2_Northwind_CustomerCustomerDemo PRIMARY KEY CLUSTERED (DV_Sequence_Number) ON [INDEX]
) ON [DATA];
GO




-- CustomerDemographics

DROP TABLE IF EXISTS northwind.L2_Northwind_CustomerDemographics;
GO

CREATE TABLE northwind.L2_Northwind_CustomerDemographics (
	  DV_Sequence_Number integer identity(1, 1) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, HK_H_Customer_Type binary(32) NOT NULL
	, HD_S_H_Customer_Type_Northwind binary(32) NOT NULL
	, CustomerTypeID nchar(10) NULL  -- PK
	, CustomerDesc nvarchar(max) NULL  -- Data type ntext deprecated. use nvarchar(max) instead
	, CONSTRAINT PK_L2_Northwind_CustomerDemographics PRIMARY KEY CLUSTERED (DV_Sequence_Number) ON [INDEX]
) ON [DATA];
GO




-- Customers

DROP TABLE IF EXISTS northwind.L2_Northwind_Customers;
GO

CREATE TABLE northwind.L2_Northwind_Customers (
	  DV_Sequence_Number integer identity(1, 1) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, HK_H_Customer binary(32) NOT NULL
	, HD_S_H_Customer_Northwind binary(32) NOT NULL
	, CustomerID nchar(5) NULL  -- PK
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
	, CONSTRAINT PK_L2_Northwind_Customers PRIMARY KEY CLUSTERED (DV_Sequence_Number) ON [INDEX]
) ON [DATA];
GO




-- Employees

DROP TABLE IF EXISTS northwind.L2_Northwind_Employees;
GO

CREATE TABLE northwind.L2_Northwind_Employees (
	  DV_Sequence_Number integer identity(1, 1) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, HK_H_Employee binary(32) NOT NULL
	, HK_H_Employee__Manager binary(32) NOT NULL
	, HK_L_Employee_Reporting_Line binary(32) NOT NULL
	, HD_S_H_Employee_Northwind binary(32) NOT NULL
	, EmployeeID int NULL  -- PK
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
	, Photo varbinary(max) NULL  -- Data type image deprecated. Use varbinary(max) instead
	, Notes nvarchar(max) NULL  -- Data type ntext deprecated. use nvarchar(max) instead
	, ReportsTo int NULL  -- FK (Employees)
	, PhotoPath nvarchar(255) NULL
	, CONSTRAINT PK_L2_Northwind_Employees PRIMARY KEY CLUSTERED (DV_Sequence_Number) ON [INDEX]
) ON [DATA];
GO




-- EmployeeTerritories

DROP TABLE IF EXISTS northwind.L2_Northwind_EmployeeTerritories;
GO

CREATE TABLE northwind.L2_Northwind_EmployeeTerritories (
	  DV_Sequence_Number integer identity(1, 1) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, HK_H_Employee binary(32) NOT NULL 
	, HK_H_Territory binary(32) NOT NULL 
	, HK_L_Employee_Territory binary(32) NOT NULL 
	, EmployeeID int NULL  -- PK, FK (Employees) 
	, TerritoryID nvarchar(20) NULL  -- PK, FK (Territories) 
	, CONSTRAINT PK_L2_Northwind_EmployeeTerritories PRIMARY KEY CLUSTERED (DV_Sequence_Number) ON [INDEX]
) ON [DATA];
GO




-- Order Details

DROP TABLE IF EXISTS northwind.L2_Northwind_Order_Details;
GO

CREATE TABLE northwind.L2_Northwind_Order_Details (
	  DV_Sequence_Number integer identity(1, 1) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, HK_H_Order binary(32) NOT NULL 
	, HK_H_Product binary(32) NOT NULL 
	, HK_L_Order_Detail binary(32) NOT NULL 
	, HD_S_L_Order_Detail_Northwind binary(32) NOT NULL 
	, OrderID int NULL  -- PK, FK (Orders)
	, ProductID int NULL  -- PK, FK (Products)
	, UnitPrice money NULL
	, Quantity smallint NULL
	, Discount real NULL
	, CONSTRAINT PK_L2_Northwind_Order_Details PRIMARY KEY CLUSTERED (DV_Sequence_Number) ON [INDEX]
) ON [DATA];
GO




-- Orders

DROP TABLE IF EXISTS northwind.L2_Northwind_Orders;
GO

CREATE TABLE northwind.L2_Northwind_Orders (
	  DV_Sequence_Number integer identity(1, 1) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, HK_H_Order binary(32) NOT NULL
	, HK_H_Customer binary(32) NOT NULL
	, HK_H_Employee binary(32) NOT NULL
	, HK_H_Shipper binary(32) NOT NULL
	, HK_L_Order_Header binary(32) NOT NULL
	, HD_S_H_Order_Northwind binary(32) NOT NULL
	, OrderID int NULL  -- PK
	, CustomerID nchar(5) NULL  -- FK (Customers)
	, EmployeeID int NULL  -- FK (Employees)
	, OrderDate datetime NULL
	, RequiredDate datetime NULL
	, ShippedDate datetime NULL
	, ShipVia int NULL  -- FK (Shippers)
	, Freight money NULL
	, ShipName nvarchar(40) NULL
	, ShipAddress nvarchar(60) NULL
	, ShipCity nvarchar(15) NULL
	, ShipRegion nvarchar(15) NULL
	, ShipPostalCode nvarchar(10) NULL
	, ShipCountry nvarchar(15) NULL
	, CONSTRAINT PK_L2_Northwind_Orders PRIMARY KEY CLUSTERED (DV_Sequence_Number) ON [INDEX]
) ON [DATA];
GO




-- Products

DROP TABLE IF EXISTS northwind.L2_Northwind_Products;
GO

CREATE TABLE northwind.L2_Northwind_Products (
	  DV_Sequence_Number integer identity(1, 1) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, HK_H_Product binary(32) NOT NULL
	, HK_H_Supplier binary(32) NOT NULL
	, HK_H_Product_Category binary(32) NOT NULL
	, HK_L_Product_Supplier binary(32) NOT NULL
	, HK_L_Product_Category binary(32) NOT NULL
	, HD_S_H_Product_Northwind binary(32) NOT NULL
	, ProductID int NULL  -- PK
	, ProductName nvarchar(40) NULL
	, SupplierID int NULL  -- FK (Suppliers)
	, CategoryID int NULL  -- FK (Categories)
	, QuantityPerUnit nvarchar(20) NULL
	, UnitPrice money NULL
	, UnitsInStock smallint NULL
	, UnitsOnOrder smallint NULL
	, ReorderLevel smallint NULL
	, Discontinued bit NULL
	, CONSTRAINT PK_L2_Northwind_Products PRIMARY KEY CLUSTERED (DV_Sequence_Number) ON [INDEX]
) ON [DATA];
GO




-- Region

DROP TABLE IF EXISTS northwind.L2_Northwind_Region;
GO

CREATE TABLE northwind.L2_Northwind_Region (
	  DV_Sequence_Number integer identity(1, 1) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, HK_H_Region binary(32) NOT NULL
	, HD_S_H_Region_Northwind binary(32) NOT NULL
	, RegionID int NULL  -- PK
	, RegionDescription nchar(50) NULL
	, CONSTRAINT PK_L2_Northwind_Region PRIMARY KEY CLUSTERED (DV_Sequence_Number) ON [INDEX]
) ON [DATA];
GO




-- Shippers

DROP TABLE IF EXISTS northwind.L2_Northwind_Shippers;
GO

CREATE TABLE northwind.L2_Northwind_Shippers (
	  DV_Sequence_Number integer identity(1, 1) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, HK_H_Shipper binary(32) NOT NULL
	, HD_S_H_Shipper_Northwind binary(32) NOT NULL
	, ShipperID int NULL  -- PK
	, CompanyName nvarchar(40) NULL
	, Phone nvarchar(24) NULL
	, CONSTRAINT PK_L2_Northwind_Shippers PRIMARY KEY CLUSTERED (DV_Sequence_Number) ON [INDEX]
) ON [DATA];
GO




-- Suppliers

DROP TABLE IF EXISTS northwind.L2_Northwind_Suppliers;
GO

CREATE TABLE northwind.L2_Northwind_Suppliers (
	  DV_Sequence_Number integer identity(1, 1) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, HK_H_Supplier binary(32) NOT NULL 
	, HD_S_H_Supplier_Northwind binary(32) NOT NULL
	, SupplierID int NULL  -- PK
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
	, HomePage nvarchar(max) NULL  -- Data type ntext deprecated. use nvarchar(max) instead
	, CONSTRAINT PK_L2_Northwind_Suppliers PRIMARY KEY CLUSTERED (DV_Sequence_Number) ON [INDEX]
) ON [DATA];
GO




-- Territories

DROP TABLE IF EXISTS northwind.L2_Northwind_Territories;
GO

CREATE TABLE northwind.L2_Northwind_Territories (
	  DV_Sequence_Number integer identity(1, 1) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, HK_H_Territory binary(32) NOT NULL 
	, HK_H_Region binary(32) NOT NULL 
	, HK_L_Territory_Region binary(32) NOT NULL 
	, HD_S_H_Territory_Northwind binary(32) NOT NULL 
	, TerritoryID nvarchar(20) NULL  -- PK
	, TerritoryDescription nchar(50) NULL
	, RegionID int NULL  -- FK (Region)
	, CONSTRAINT PK_L2_Northwind_Territories PRIMARY KEY CLUSTERED (DV_Sequence_Number) ON [INDEX]
) ON [DATA];
GO