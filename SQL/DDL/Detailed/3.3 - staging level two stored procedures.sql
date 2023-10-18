/*
	
	Staging level two stored procedures

*/


USE Staging;
GO


-- usp_insert_L2_Northwind_Categories__L1_Northwind_Categories

DROP PROCEDURE IF EXISTS northwind.usp_insert_L2_Northwind_Categories__L1_Northwind_Categories;
GO

CREATE PROCEDURE northwind.usp_insert_L2_Northwind_Categories__L1_Northwind_Categories 
AS
	BEGIN

		TRUNCATE TABLE northwind.L2_Northwind_Categories;

		INSERT INTO northwind.L2_Northwind_Categories (
			  DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Product_Category
			, HD_S_H_Product_Category_Northwind
			, CategoryID
			, CategoryName
			, [Description]
			, Picture
		)
		SELECT
			  DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Product_Category
			, HD_S_H_Product_Category_Northwind
			, CategoryID
			, CategoryName
			, [Description]
			, Picture
		FROM
			northwind.v_stage_L2_Northwind_Categories__L1_Northwind_Categories;

	END
GO




-- usp_insert_L2_Northwind_CustomerCustomerDemo__L1_Northwind_CustomerCustomerDemo

DROP PROCEDURE IF EXISTS northwind.usp_insert_L2_Northwind_CustomerCustomerDemo__L1_Northwind_CustomerCustomerDemo;
GO

CREATE PROCEDURE northwind.usp_insert_L2_Northwind_CustomerCustomerDemo__L1_Northwind_CustomerCustomerDemo
AS
	BEGIN

		TRUNCATE TABLE northwind.L2_Northwind_CustomerCustomerDemo;

		INSERT INTO northwind.L2_Northwind_CustomerCustomerDemo (
			  DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Customer
			, HK_H_Customer_Type
			, HK_L_Customer_Type
			, CustomerID
			, CustomerTypeID
		)
		SELECT 
			  DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Customer
			, HK_H_Customer_Type
			, HK_L_Customer_Type
			, CustomerID
			, CustomerTypeID
		FROM
			northwind.v_stage_L2_Northwind_CustomerCustomerDemo__L1_Northwind_CustomerCustomerDemo;

	END
GO




-- usp_insert_L2_Northwind_CustomerDemographics__L1_Northwind_CustomerDemographics

DROP PROCEDURE IF EXISTS northwind.usp_insert_L2_Northwind_CustomerDemographics__L1_Northwind_CustomerDemographics;
GO

CREATE PROCEDURE northwind.usp_insert_L2_Northwind_CustomerDemographics__L1_Northwind_CustomerDemographics
AS
	BEGIN

		TRUNCATE TABLE northwind.L2_Northwind_CustomerDemographics;

		INSERT INTO northwind.L2_Northwind_CustomerDemographics (
			  DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Customer_Type
			, HD_S_H_Customer_Type_Northwind
			, CustomerTypeID
			, CustomerDesc
		)
		SELECT 
			  DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Customer_Type
			, HD_S_H_Customer_Type_Northwind
			, CustomerTypeID
			, CustomerDesc
		FROM
			northwind.v_stage_L2_Northwind_CustomerDemographics__L1_Northwind_CustomerDemographics;

	END
GO




-- usp_insert_L2_Northwind_Customers__L1_Northwind_Customers

DROP PROCEDURE IF EXISTS northwind.usp_insert_L2_Northwind_Customers__L1_Northwind_Customers;
GO

CREATE PROCEDURE northwind.usp_insert_L2_Northwind_Customers__L1_Northwind_Customers
AS
	BEGIN

		TRUNCATE TABLE northwind.L2_Northwind_Customers;

		INSERT INTO northwind.L2_Northwind_Customers (
			  DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Customer
			, HD_S_H_Customer_Northwind
			, CustomerID
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
			  DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Customer
			, HD_S_H_Customer_Northwind
			, CustomerID
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
			northwind.v_stage_L2_Northwind_Customers__L1_Northwind_Customers;

	END
GO




-- usp_insert_L2_Northwind_Employees__L1_Northwind_Employees

DROP PROCEDURE IF EXISTS northwind.usp_insert_L2_Northwind_Employees__L1_Northwind_Employees;
GO

CREATE PROCEDURE northwind.usp_insert_L2_Northwind_Employees__L1_Northwind_Employees
AS
	BEGIN

		TRUNCATE TABLE northwind.L2_Northwind_Employees;

		INSERT INTO northwind.L2_Northwind_Employees (
			  DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Employee
			, HK_H_Employee__Manager
			, HK_L_Employee_Reporting_Line
			, HD_S_H_Employee_Northwind
			, EmployeeID
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
			  DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Employee
			, HK_H_Employee__Manager
			, HK_L_Employee_Reporting_Line
			, HD_S_H_Employee_Northwind
			, EmployeeID
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
			northwind.v_stage_L2_Northwind_Employees__L1_Northwind_Employees;

	END
GO




-- usp_insert_L2_Northwind_EmployeeTerritories__L1_Northwind_EmployeeTerritories

DROP PROCEDURE IF EXISTS northwind.usp_insert_L2_Northwind_EmployeeTerritories__L1_Northwind_EmployeeTerritories;
GO

CREATE PROCEDURE northwind.usp_insert_L2_Northwind_EmployeeTerritories__L1_Northwind_EmployeeTerritories
AS
	BEGIN

		TRUNCATE TABLE northwind.L2_Northwind_EmployeeTerritories;

		INSERT INTO northwind.L2_Northwind_EmployeeTerritories (
			  DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Employee
			, HK_H_Territory
			, HK_L_Employee_Territory
			, EmployeeID
			, TerritoryID
		)
		SELECT 
			  DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Employee
			, HK_H_Territory
			, HK_L_Employee_Territory
			, EmployeeID
			, TerritoryID
		FROM
			northwind.v_stage_L2_Northwind_EmployeeTerritories__L1_Northwind_EmployeeTerritories;

	END
GO




-- usp_insert_L2_Northwind_Order_Details__L1_Northwind_Order_Details

DROP PROCEDURE IF EXISTS northwind.usp_insert_L2_Northwind_Order_Details__L1_Northwind_Order_Details;
GO

CREATE PROCEDURE northwind.usp_insert_L2_Northwind_Order_Details__L1_Northwind_Order_Details
AS
	BEGIN

		TRUNCATE TABLE northwind.L2_Northwind_Order_Details;

		INSERT INTO northwind.L2_Northwind_Order_Details (
			  DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Order
			, HK_H_Product
			, HK_L_Order_Detail
			, HD_S_L_Order_Detail_Northwind
			, OrderID
			, ProductID
			, UnitPrice
			, Quantity
			, Discount
		)
		SELECT 
			  DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Order
			, HK_H_Product
			, HK_L_Order_Detail
			, HD_S_L_Order_Detail_Northwind
			, OrderID
			, ProductID
			, UnitPrice
			, Quantity
			, Discount
		FROM
			northwind.v_stage_L2_Northwind_Order_Details__L1_Northwind_Order_Details;

	END
GO




-- usp_insert_L2_Northwind_Orders__L1_Northwind_Orders

DROP PROCEDURE IF EXISTS northwind.usp_insert_L2_Northwind_Orders__L1_Northwind_Orders;
GO

CREATE PROCEDURE northwind.usp_insert_L2_Northwind_Orders__L1_Northwind_Orders
AS
	BEGIN

		TRUNCATE TABLE northwind.L2_Northwind_Orders;

		INSERT INTO northwind.L2_Northwind_Orders (
			  DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Order
			, HK_H_Customer
			, HK_H_Employee
			, HK_H_Shipper
			, HK_L_Order_Header
			, HD_S_H_Order_Northwind
			, OrderID
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
			  DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Order
			, HK_H_Customer
			, HK_H_Employee
			, HK_H_Shipper
			, HK_L_Order_Header
			, HD_S_H_Order_Northwind
			, OrderID
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
			northwind.v_stage_L2_Northwind_Orders__L1_Northwind_Orders;

	END
GO




-- usp_insert_L2_Northwind_Products__L1_Northwind_Products

DROP PROCEDURE IF EXISTS northwind.usp_insert_L2_Northwind_Products__L1_Northwind_Products;
GO

CREATE PROCEDURE northwind.usp_insert_L2_Northwind_Products__L1_Northwind_Products
AS
	BEGIN

		TRUNCATE TABLE northwind.L2_Northwind_Products;

		INSERT INTO northwind.L2_Northwind_Products (
			  DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Product
			, HK_H_Supplier
			, HK_H_Product_Category
			, HK_L_Product_Supplier
			, HK_L_Product_Category
			, HD_S_H_Product_Northwind
			, ProductID
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
			  DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Product
			, HK_H_Supplier
			, HK_H_Product_Category
			, HK_L_Product_Supplier
			, HK_L_Product_Category
			, HD_S_H_Product_Northwind
			, ProductID
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
			northwind.v_stage_L2_Northwind_Products__L1_Northwind_Products;

	END
GO




-- usp_insert_L2_Northwind_Region__L1_Northwind_Region

DROP PROCEDURE IF EXISTS northwind.usp_insert_L2_Northwind_Region__L1_Northwind_Region;
GO

CREATE PROCEDURE northwind.usp_insert_L2_Northwind_Region__L1_Northwind_Region
AS
	BEGIN

		TRUNCATE TABLE northwind.L2_Northwind_Region;

		INSERT INTO northwind.L2_Northwind_Region (
			  DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Region
			, HD_S_H_Region_Northwind
			, RegionID
			, RegionDescription
		)
		SELECT 
			  DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Region
			, HD_S_H_Region_Northwind
			, RegionID
			, RegionDescription
		FROM
			northwind.v_stage_L2_Northwind_Region__L1_Northwind_Region;

	END
GO




-- usp_insert_L2_Northwind_Shippers__L1_Northwind_Shippers

DROP PROCEDURE IF EXISTS northwind.usp_insert_L2_Northwind_Shippers__L1_Northwind_Shippers;
GO

CREATE PROCEDURE northwind.usp_insert_L2_Northwind_Shippers__L1_Northwind_Shippers
AS
	BEGIN

		TRUNCATE TABLE northwind.L2_Northwind_Shippers;

		INSERT INTO northwind.L2_Northwind_Shippers (
			  DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Shipper
			, HD_S_H_Shipper_Northwind
			, ShipperID
			, CompanyName
			, Phone
		)
		SELECT 
			  DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Shipper
			, HD_S_H_Shipper_Northwind
			, ShipperID
			, CompanyName
			, Phone
		FROM
			northwind.v_stage_L2_Northwind_Shippers__L1_Northwind_Shippers;

	END
GO




-- usp_insert_L2_Northwind_Suppliers__L1_Northwind_Suppliers

DROP PROCEDURE IF EXISTS northwind.usp_insert_L2_Northwind_Suppliers__L1_Northwind_Suppliers;
GO

CREATE PROCEDURE northwind.usp_insert_L2_Northwind_Suppliers__L1_Northwind_Suppliers
AS
	BEGIN

		TRUNCATE TABLE northwind.L2_Northwind_Suppliers;

		INSERT INTO northwind.L2_Northwind_Suppliers (
			  DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Supplier
			, HD_S_H_Supplier_Northwind
			, SupplierID
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
			  DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Supplier
			, HD_S_H_Supplier_Northwind
			, SupplierID
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
			northwind.v_stage_L2_Northwind_Suppliers__L1_Northwind_Suppliers;

	END
GO




-- usp_insert_L2_Northwind_Territories__L1_Northwind_Territories

DROP PROCEDURE IF EXISTS northwind.usp_insert_L2_Northwind_Territories__L1_Northwind_Territories;
GO

CREATE PROCEDURE northwind.usp_insert_L2_Northwind_Territories__L1_Northwind_Territories
AS
	BEGIN

		TRUNCATE TABLE northwind.L2_Northwind_Territories;

		INSERT INTO northwind.L2_Northwind_Territories (
			  DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Territory
			, HK_H_Region
			, HK_L_Territory_Region
			, HD_S_H_Territory_Northwind
			, TerritoryID
			, TerritoryDescription
			, RegionID
		)
		SELECT 
			  DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Territory
			, HK_H_Region
			, HK_L_Territory_Region
			, HD_S_H_Territory_Northwind
			, TerritoryID
			, TerritoryDescription
			, RegionID
		FROM
			northwind.v_stage_L2_Northwind_Territories__L1_Northwind_Territories;

	END
GO