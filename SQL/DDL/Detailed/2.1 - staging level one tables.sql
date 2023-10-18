/*
	
	Staging level one tables

*/


USE Staging;
GO


-- L1_Northwind_Categories

DROP TABLE IF EXISTS northwind.L1_Northwind_Categories;
GO

CREATE TABLE northwind.L1_Northwind_Categories (
	  CategoryID int NULL
	, CategoryName nvarchar(15) NULL
	, [Description] ntext NULL
	, Picture image NULL
) ON [DATA];
GO




-- L1_Northwind_CustomerCustomerDemo

DROP TABLE IF EXISTS northwind.L1_Northwind_CustomerCustomerDemo;
GO

CREATE TABLE northwind.L1_Northwind_CustomerCustomerDemo (
	  CustomerID nchar(5) NULL
	, CustomerTypeID nchar(10) NULL
) ON [DATA];
GO




-- L1_Northwind_CustomerDemographics

DROP TABLE IF EXISTS northwind.L1_Northwind_CustomerDemographics;
GO

CREATE TABLE northwind.L1_Northwind_CustomerDemographics (
	  CustomerTypeID nchar(10) NULL
	, CustomerDesc ntext NULL
) ON [DATA];
GO




-- L1_Northwind_Customers

DROP TABLE IF EXISTS northwind.L1_Northwind_Customers;
GO

CREATE TABLE northwind.L1_Northwind_Customers (
	  CustomerID nchar(5) NULL
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
) ON [DATA];
GO




-- L1_Northwind_Employees

DROP TABLE IF EXISTS northwind.L1_Northwind_Employees;
GO

CREATE TABLE northwind.L1_Northwind_Employees (
	  EmployeeID int NULL
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
	, ReportsTo int NULL
	, PhotoPath nvarchar(255) NULL
) ON [DATA];
GO




-- L1_Northwind_EmployeeTerritories

DROP TABLE IF EXISTS northwind.L1_Northwind_EmployeeTerritories;
GO

CREATE TABLE northwind.L1_Northwind_EmployeeTerritories (
	  EmployeeID int NULL
	, TerritoryID nvarchar(20) NULL
) ON [DATA];
GO




-- L1_Northwind_Order_Details

DROP TABLE IF EXISTS northwind.L1_Northwind_Order_Details;
GO

CREATE TABLE northwind.L1_Northwind_Order_Details (
	  OrderID int NULL
	, ProductID int NULL
	, UnitPrice money NULL
	, Quantity smallint NULL
	, Discount real NULL
) ON [DATA];
GO




-- L1_Northwind_Orders

DROP TABLE IF EXISTS northwind.L1_Northwind_Orders;
GO

CREATE TABLE northwind.L1_Northwind_Orders (
	  OrderID int NULL
	, CustomerID nchar(5) NULL
	, EmployeeID int NULL
	, OrderDate datetime NULL
	, RequiredDate datetime NULL
	, ShippedDate datetime NULL
	, ShipVia int NULL
	, Freight money NULL
	, ShipName nvarchar(40) NULL
	, ShipAddress nvarchar(60) NULL
	, ShipCity nvarchar(15) NULL
	, ShipRegion nvarchar(15) NULL
	, ShipPostalCode nvarchar(10) NULL
	, ShipCountry nvarchar(15) NULL
) ON [DATA];
GO




-- L1_Northwind_Products

DROP TABLE IF EXISTS northwind.L1_Northwind_Products;
GO

CREATE TABLE northwind.L1_Northwind_Products (
	  ProductID int NULL
	, ProductName nvarchar(40) NULL
	, SupplierID int NULL
	, CategoryID int NULL
	, QuantityPerUnit nvarchar(20) NULL
	, UnitPrice money NULL
	, UnitsInStock smallint NULL
	, UnitsOnOrder smallint NULL
	, ReorderLevel smallint NULL
	, Discontinued bit NULL
) ON [DATA];
GO




-- L1_Northwind_Region

DROP TABLE IF EXISTS northwind.L1_Northwind_Region;
GO

CREATE TABLE northwind.L1_Northwind_Region (
	  RegionID int NULL
	, RegionDescription nchar(50) NULL
) ON [DATA];
GO




-- L1_Northwind_Shippers

DROP TABLE IF EXISTS northwind.L1_Northwind_Shippers;
GO

CREATE TABLE northwind.L1_Northwind_Shippers (
	  ShipperID int NULL
	, CompanyName nvarchar(40) NULL
	, Phone nvarchar(24) NULL
) ON [DATA];
GO




-- L1_Northwind_Suppliers

DROP TABLE IF EXISTS northwind.L1_Northwind_Suppliers;
GO

CREATE TABLE northwind.L1_Northwind_Suppliers (
	  SupplierID int NULL
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
) ON [DATA];
GO




-- L1_Northwind_Territories

DROP TABLE IF EXISTS northwind.L1_Northwind_Territories;
GO

CREATE TABLE northwind.L1_Northwind_Territories (
	  TerritoryID nvarchar(20) NULL
	, TerritoryDescription nchar(50) NULL
	, RegionID int NULL
) ON [DATA];
GO