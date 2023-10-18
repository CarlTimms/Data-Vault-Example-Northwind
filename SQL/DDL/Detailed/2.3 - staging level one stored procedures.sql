/*
	
	Staging level one stored procedures

*/


USE Staging;


-- usp_insert_L1_Northwind_Categories

DROP PROCEDURE IF EXISTS northwind.usp_insert_L1_Northwind_Categories;
GO

CREATE PROCEDURE northwind.usp_insert_L1_Northwind_Categories 
AS
	BEGIN

		TRUNCATE TABLE northwind.L1_Northwind_Categories;

		INSERT INTO northwind.L1_Northwind_Categories (
			  CategoryID
			, CategoryName
			, [Description]
			, Picture
		)
		SELECT
			  CategoryID
			, CategoryName
			, [Description]
			, Picture
		FROM
			northwind.v_stage_L1_Northwind_Categories;

	END
GO




-- usp_insert_L1_Northwind_CustomerCustomerDemo

DROP PROCEDURE IF EXISTS northwind.usp_insert_L1_Northwind_CustomerCustomerDemo;
GO

CREATE PROCEDURE northwind.usp_insert_L1_Northwind_CustomerCustomerDemo
AS
	BEGIN

		TRUNCATE TABLE northwind.L1_Northwind_CustomerCustomerDemo;

		INSERT INTO northwind.L1_Northwind_CustomerCustomerDemo (
			  CustomerID
			, CustomerTypeID
		)
		SELECT
			  CustomerID
			, CustomerTypeID
		FROM
			northwind.v_stage_L1_Northwind_CustomerCustomerDemo;

	END
GO




-- usp_insert_L1_Northwind_CustomerDemographics

DROP PROCEDURE IF EXISTS northwind.usp_insert_L1_Northwind_CustomerDemographics;
GO

CREATE PROCEDURE northwind.usp_insert_L1_Northwind_CustomerDemographics
AS
	BEGIN
		
		TRUNCATE TABLE northwind.L1_Northwind_CustomerDemographics;
		
		INSERT INTO northwind.L1_Northwind_CustomerDemographics (
			  CustomerTypeID
			, CustomerDesc
		)
		SELECT
			  CustomerTypeID
			, CustomerDesc
		FROM
			northwind.v_stage_L1_Northwind_CustomerDemographics;

	END
GO




-- usp_insert_L1_Northwind_Customers

DROP PROCEDURE IF EXISTS northwind.usp_insert_L1_Northwind_Customers;
GO

CREATE PROCEDURE northwind.usp_insert_L1_Northwind_Customers
AS
	BEGIN

		TRUNCATE TABLE northwind.L1_Northwind_Customers;

		INSERT INTO northwind.L1_Northwind_Customers (
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
			northwind.v_stage_L1_Northwind_Customers;

	END
GO




-- usp_insert_L1_Northwind_Employees

DROP PROCEDURE IF EXISTS northwind.usp_insert_L1_Northwind_Employees;
GO

CREATE PROCEDURE northwind.usp_insert_L1_Northwind_Employees
AS
	BEGIN
	
		TRUNCATE TABLE northwind.L1_Northwind_Employees;

		INSERT INTO northwind.L1_Northwind_Employees (
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
			northwind.v_stage_L1_Northwind_Employees;
	
	END
GO




-- usp_insert_L1_Northwind_EmployeeTerritories

DROP PROCEDURE IF EXISTS northwind.usp_insert_L1_Northwind_EmployeeTerritories;
GO

CREATE PROCEDURE northwind.usp_insert_L1_Northwind_EmployeeTerritories
AS
	BEGIN
	
		TRUNCATE TABLE northwind.L1_Northwind_EmployeeTerritories;

		INSERT INTO northwind.L1_Northwind_EmployeeTerritories (
			  EmployeeID
			, TerritoryID	
		)
		SELECT
			  EmployeeID
			, TerritoryID
		FROM
			northwind.v_stage_L1_Northwind_EmployeeTerritories;
	
	END
GO




-- usp_insert_L1_Northwind_Order_Details

DROP PROCEDURE IF EXISTS northwind.usp_insert_L1_Northwind_Order_Details;
GO

CREATE PROCEDURE northwind.usp_insert_L1_Northwind_Order_Details
AS
	BEGIN
	
		TRUNCATE TABLE northwind.L1_Northwind_Order_Details;

		INSERT INTO northwind.L1_Northwind_Order_Details (
			  OrderID
			, ProductID
			, UnitPrice
			, Quantity
			, Discount	
		)
		SELECT
			  OrderID
			, ProductID
			, UnitPrice
			, Quantity
			, Discount
		FROM
			northwind.v_stage_L1_Northwind_Order_Details;
	
	END
GO




-- usp_insert_L1_Northwind_Orders

DROP PROCEDURE IF EXISTS northwind.usp_insert_L1_Northwind_Orders;
GO

CREATE PROCEDURE northwind.usp_insert_L1_Northwind_Orders
AS
	BEGIN
	
		TRUNCATE TABLE northwind.L1_Northwind_Orders;

		INSERT INTO northwind.L1_Northwind_Orders (
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
			northwind.v_stage_L1_Northwind_Orders;
	
	END
GO




-- usp_insert_L1_Northwind_Products

DROP PROCEDURE IF EXISTS northwind.usp_insert_L1_Northwind_Products;
GO

CREATE PROCEDURE northwind.usp_insert_L1_Northwind_Products
AS
	BEGIN
	
		TRUNCATE TABLE northwind.L1_Northwind_Products;

		INSERT INTO northwind.L1_Northwind_Products (
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
			northwind.v_stage_L1_Northwind_Products;
	
	END
GO




-- usp_insert_L1_Northwind_Region

DROP PROCEDURE IF EXISTS northwind.usp_insert_L1_Northwind_Region;
GO

CREATE PROCEDURE northwind.usp_insert_L1_Northwind_Region
AS
	BEGIN
	
		TRUNCATE TABLE northwind.L1_Northwind_Region;

		INSERT INTO northwind.L1_Northwind_Region (
			  RegionID
			, RegionDescription	
		)
		SELECT
			  RegionID
			, RegionDescription
		FROM
			northwind.v_stage_L1_Northwind_Region;
	
	END
GO




-- usp_insert_L1_Northwind_Shippers

DROP PROCEDURE IF EXISTS northwind.usp_insert_L1_Northwind_Shippers;
GO

CREATE PROCEDURE northwind.usp_insert_L1_Northwind_Shippers
AS
	BEGIN
	
		TRUNCATE TABLE northwind.L1_Northwind_Shippers;

		INSERT INTO northwind.L1_Northwind_Shippers (
			  ShipperID
			, CompanyName
			, Phone	
		)
		SELECT
			  ShipperID
			, CompanyName
			, Phone
		FROM
			northwind.v_stage_L1_Northwind_Shippers;
	
	END
GO




-- usp_insert_L1_Northwind_Suppliers

DROP PROCEDURE IF EXISTS northwind.usp_insert_L1_Northwind_Suppliers;
GO

CREATE PROCEDURE northwind.usp_insert_L1_Northwind_Suppliers
AS
	BEGIN
	
		TRUNCATE TABLE northwind.L1_Northwind_Suppliers;

		INSERT INTO northwind.L1_Northwind_Suppliers (
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
			northwind.v_stage_L1_Northwind_Suppliers;
	
	END
GO




-- usp_insert_L1_Northwind_Territories

DROP PROCEDURE IF EXISTS northwind.usp_insert_L1_Northwind_Territories;
GO

CREATE PROCEDURE northwind.usp_insert_L1_Northwind_Territories
AS
	BEGIN
	
		TRUNCATE TABLE northwind.L1_Northwind_Territories;

		INSERT INTO northwind.L1_Northwind_Territories (
			  TerritoryID
			, TerritoryDescription
			, RegionID	
		)
		SELECT
			  TerritoryID
			, TerritoryDescription
			, RegionID
		FROM
			northwind.v_stage_L1_Northwind_Territories;
	
	END
GO