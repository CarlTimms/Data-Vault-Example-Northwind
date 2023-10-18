/*
	
	Staging level one stage views

*/


USE Staging;
GO


-- v_stage_L1_Northwind_Categories

DROP VIEW IF EXISTS northwind.v_stage_L1_Northwind_Categories;
GO

CREATE VIEW northwind.v_stage_L1_Northwind_Categories (
	  CategoryID
	, CategoryName
	, [Description]
	, Picture
)
AS
SELECT 
	  CategoryID
	, CategoryName
	, [Description]
	, Picture
FROM
	Northwind.dbo.Categories;
GO




-- v_stage_L1_Northwind_CustomerCustomerDemo

DROP VIEW IF EXISTS northwind.v_stage_L1_Northwind_CustomerCustomerDemo;
GO

CREATE VIEW northwind.v_stage_L1_Northwind_CustomerCustomerDemo (
	  CustomerID
	, CustomerTypeID
)
AS
SELECT 
	  CustomerID
	, CustomerTypeID
FROM
	Northwind.dbo.CustomerCustomerDemo;
GO




-- v_stage_L1_Northwind_CustomerDemographics

DROP VIEW IF EXISTS northwind.v_stage_L1_Northwind_CustomerDemographics;
GO

CREATE VIEW northwind.v_stage_L1_Northwind_CustomerDemographics (
	  CustomerTypeID
	, CustomerDesc
)
AS
SELECT
	  CustomerTypeID
	, CustomerDesc
FROM
	Northwind.dbo.CustomerDemographics;
GO




-- v_stage_L1_Northwind_Customers

DROP VIEW IF EXISTS northwind.v_stage_L1_Northwind_Customers;
GO

CREATE VIEW northwind.v_stage_L1_Northwind_Customers (
	  CustomerID
	, CompanyName
	, ContactName
	, ContactTitle
	, [Address]
	, City
	, Region
	, PostalCode
	, Country
	, Phone
	, Fax
)
AS
SELECT
	  CustomerID
	, CompanyName
	, ContactName
	, ContactTitle
	, [Address]
	, City
	, Region
	, PostalCode
	, Country
	, Phone
	, Fax
FROM
	Northwind.dbo.Customers;
GO




-- v_stage_L1_Northwind_Employees

DROP VIEW IF EXISTS northwind.v_stage_L1_Northwind_Employees;
GO

CREATE VIEW northwind.v_stage_L1_Northwind_Employees (
	  EmployeeID
	, LastName
	, FirstName
	, Title
	, TitleOfCourtesy
	, BirthDate
	, HireDate
	, [Address]
	, City
	, Region
	, PostalCode
	, Country
	, HomePhone
	, Extension
	, Photo
	, Notes
	, ReportsTo
	, PhotoPath
)
AS
SELECT
	  EmployeeID
	, LastName
	, FirstName
	, Title
	, TitleOfCourtesy
	, BirthDate
	, HireDate
	, [Address]
	, City
	, Region
	, PostalCode
	, Country
	, HomePhone
	, Extension
	, Photo
	, Notes
	, ReportsTo
	, PhotoPath
FROM
	Northwind.dbo.Employees;
GO




-- v_stage_L1_Northwind_EmployeeTerritories

DROP VIEW IF EXISTS northwind.v_stage_L1_Northwind_EmployeeTerritories;
GO

CREATE VIEW northwind.v_stage_L1_Northwind_EmployeeTerritories (
	  EmployeeID
	, TerritoryID
)
AS
SELECT
	  EmployeeID
	, TerritoryID
FROM
	Northwind.dbo.EmployeeTerritories;
GO




-- v_stage_L1_Northwind_Order_Details

DROP VIEW IF EXISTS northwind.v_stage_L1_Northwind_Order_Details;
GO

CREATE VIEW northwind.v_stage_L1_Northwind_Order_Details (
	  OrderID
	, ProductID
	, UnitPrice
	, Quantity
	, Discount
)
AS
SELECT 
	  OrderID
	, ProductID
	, UnitPrice
	, Quantity
	, Discount
FROM
	Northwind.dbo.[Order Details];
GO




-- v_stage_L1_Northwind_Orders

DROP VIEW IF EXISTS northwind.v_stage_L1_Northwind_Orders;
GO

CREATE VIEW northwind.v_stage_L1_Northwind_Orders (
	  OrderID
	, CustomerID
	, EmployeeID
	, OrderDate
	, RequiredDate
	, ShippedDate
	, ShipVia
	, Freight
	, ShipName
	, ShipAddress
	, ShipCity
	, ShipRegion
	, ShipPostalCode
	, ShipCountry
)
AS
SELECT 
	  OrderID
	, CustomerID
	, EmployeeID
	, OrderDate
	, RequiredDate
	, ShippedDate
	, ShipVia
	, Freight
	, ShipName
	, ShipAddress
	, ShipCity
	, ShipRegion
	, ShipPostalCode
	, ShipCountry
FROM
	Northwind.dbo.Orders;
GO




-- v_stage_L1_Northwind_Products

DROP VIEW IF EXISTS northwind.v_stage_L1_Northwind_Products;
GO

CREATE VIEW northwind.v_stage_L1_Northwind_Products (
	  ProductID
	, ProductName
	, SupplierID
	, CategoryID
	, QuantityPerUnit
	, UnitPrice
	, UnitsInStock
	, UnitsOnOrder
	, ReorderLevel
	, Discontinued
)
AS
SELECT
	  ProductID
	, ProductName
	, SupplierID
	, CategoryID
	, QuantityPerUnit
	, UnitPrice
	, UnitsInStock
	, UnitsOnOrder
	, ReorderLevel
	, Discontinued
FROM
	Northwind.dbo.Products;
GO




-- v_stage_L1_Northwind_Region

DROP VIEW IF EXISTS northwind.v_stage_L1_Northwind_Region;
GO

CREATE VIEW northwind.v_stage_L1_Northwind_Region (
	  RegionID
	, RegionDescription
)
AS
SELECT
	  RegionID
	, RegionDescription
FROM
	Northwind.dbo.Region;
GO




-- v_stage_L1_Northwind_Shippers

DROP VIEW IF EXISTS northwind.v_stage_L1_Northwind_Shippers;
GO

CREATE VIEW northwind.v_stage_L1_Northwind_Shippers (
	  ShipperID
	, CompanyName
	, Phone
)
AS
SELECT 
	  ShipperID
	, CompanyName
	, Phone
FROM
	Northwind.dbo.Shippers;
GO




-- v_stage_L1_Northwind_Suppliers

DROP VIEW IF EXISTS northwind.v_stage_L1_Northwind_Suppliers;
GO

CREATE VIEW northwind.v_stage_L1_Northwind_Suppliers (
	  SupplierID
	, CompanyName
	, ContactName
	, ContactTitle
	, [Address]
	, City
	, Region
	, PostalCode
	, Country
	, Phone
	, Fax
	, HomePage
)
AS
SELECT 
	  SupplierID
	, CompanyName
	, ContactName
	, ContactTitle
	, [Address]
	, City
	, Region
	, PostalCode
	, Country
	, Phone
	, Fax
	, HomePage
FROM
	Northwind.dbo.Suppliers;
GO




-- v_stage_L1_Northwind_Territories

DROP VIEW IF EXISTS northwind.v_stage_L1_Northwind_Territories;
GO

CREATE VIEW northwind.v_stage_L1_Northwind_Territories (
	  TerritoryID
	, TerritoryDescription
	, RegionID
)
AS
SELECT
	  TerritoryID
	, TerritoryDescription
	, RegionID
FROM
	Northwind.dbo.Territories;
GO