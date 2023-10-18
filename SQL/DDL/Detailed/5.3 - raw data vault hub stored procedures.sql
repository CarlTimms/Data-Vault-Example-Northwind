/*
	
	Raw data vault hub stored procedures

*/


USE Data_Vault;
GO


-- usp_insert_H_Customer__L2_Northwind_CustomerCustomerDemo

DROP PROCEDURE IF EXISTS rv.usp_insert_H_Customer__L2_Northwind_CustomerCustomerDemo;
GO

CREATE PROCEDURE rv.usp_insert_H_Customer__L2_Northwind_CustomerCustomerDemo
AS
	BEGIN

		INSERT INTO rv.H_Customer (
			  HK_H_Customer
			, DV_Load_Datetime
			, DV_Record_Source
			, CustomerID
		)
		SELECT
			  HK_H_Customer
			, DV_Load_Datetime
			, DV_Record_Source
			, CustomerID
		FROM
			rv.v_stage_H_Customer__L2_Northwind_CustomerCustomerDemo;

	END
GO




-- usp_insert_H_Customer__L2_Northwind_Customers

DROP PROCEDURE IF EXISTS rv.usp_insert_H_Customer__L2_Northwind_Customers;
GO

CREATE PROCEDURE rv.usp_insert_H_Customer__L2_Northwind_Customers
AS
	BEGIN

		INSERT INTO rv.H_Customer (
			  HK_H_Customer
			, DV_Load_Datetime
			, DV_Record_Source
			, CustomerID
		)
		SELECT
			  HK_H_Customer
			, DV_Load_Datetime
			, DV_Record_Source
			, CustomerID
		FROM
			rv.v_stage_H_Customer__L2_Northwind_Customers;

	END
GO




-- usp_insert_H_Customer__L2_Northwind_Orders

DROP PROCEDURE IF EXISTS rv.usp_insert_H_Customer__L2_Northwind_Orders;
GO

CREATE PROCEDURE rv.usp_insert_H_Customer__L2_Northwind_Orders
AS
	BEGIN

		INSERT INTO rv.H_Customer (
			  HK_H_Customer
			, DV_Load_Datetime
			, DV_Record_Source
			, CustomerID
		)
		SELECT
			  HK_H_Customer
			, DV_Load_Datetime
			, DV_Record_Source
			, CustomerID
		FROM
			rv.v_stage_H_Customer__L2_Northwind_Orders;

	END
GO




-- usp_insert_H_Customer_Type__L2_Northwind_CustomerCustomerDemo

DROP PROCEDURE IF EXISTS rv.usp_insert_H_Customer_Type__L2_Northwind_CustomerCustomerDemo;
GO

CREATE PROCEDURE rv.usp_insert_H_Customer_Type__L2_Northwind_CustomerCustomerDemo
AS
	BEGIN

		INSERT INTO rv.H_Customer_Type (
			  HK_H_Customer_Type
			, DV_Load_Datetime
			, DV_Record_Source
			, CustomerTypeID
		)
		SELECT
			  HK_H_Customer_Type
			, DV_Load_Datetime
			, DV_Record_Source
			, CustomerTypeID
		FROM
			rv.v_stage_H_Customer_Type__L2_Northwind_CustomerCustomerDemo;

	END
GO




-- usp_insert_H_Customer_Type__L2_Northwind_CustomerDemographics

DROP PROCEDURE IF EXISTS rv.usp_insert_H_Customer_Type__L2_Northwind_CustomerDemographics;
GO

CREATE PROCEDURE rv.usp_insert_H_Customer_Type__L2_Northwind_CustomerDemographics
AS
	BEGIN

		INSERT INTO rv.H_Customer_Type (
			  HK_H_Customer_Type
			, DV_Load_Datetime
			, DV_Record_Source
			, CustomerTypeID
		)
		SELECT
			  HK_H_Customer_Type
			, DV_Load_Datetime
			, DV_Record_Source
			, CustomerTypeID
		FROM
			rv.v_stage_H_Customer_Type__L2_Northwind_CustomerDemographics;

	END
GO




-- usp_insert_H_Employee__L2_Northwind_Employees__EmployeeID

DROP PROCEDURE IF EXISTS rv.usp_insert_H_Employee__L2_Northwind_Employees__EmployeeID ;
GO

CREATE PROCEDURE rv.usp_insert_H_Employee__L2_Northwind_Employees__EmployeeID
AS
	BEGIN

		INSERT INTO rv.H_Employee (
			  HK_H_Employee
			, DV_Load_Datetime
			, DV_Record_Source
			, EmployeeID
		)
		SELECT
			  HK_H_Employee
			, DV_Load_Datetime
			, DV_Record_Source
			, EmployeeID
		FROM
			rv.v_stage_H_Employee__L2_Northwind_Employees__EmployeeID;

	END
GO




-- usp_insert_H_Employee__L2_Northwind_Employees__ReportsTo

DROP PROCEDURE IF EXISTS rv.usp_insert_H_Employee__L2_Northwind_Employees__ReportsTo;
GO

CREATE PROCEDURE rv.usp_insert_H_Employee__L2_Northwind_Employees__ReportsTo
AS
	BEGIN

		INSERT INTO rv.H_Employee (
			  HK_H_Employee
			, DV_Load_Datetime
			, DV_Record_Source
			, EmployeeID
		)
		SELECT
			  HK_H_Employee
			, DV_Load_Datetime
			, DV_Record_Source
			, EmployeeID
		FROM
			rv.v_stage_H_Employee__L2_Northwind_Employees__ReportsTo;

	END
GO




-- usp_insert_H_Employee__L2_Northwind_EmployeeTerritories

DROP PROCEDURE IF EXISTS rv.usp_insert_H_Employee__L2_Northwind_EmployeeTerritories;
GO

CREATE PROCEDURE rv.usp_insert_H_Employee__L2_Northwind_EmployeeTerritories
AS
	BEGIN

		INSERT INTO rv.H_Employee (
			  HK_H_Employee
			, DV_Load_Datetime
			, DV_Record_Source
			, EmployeeID
		)
		SELECT
			  HK_H_Employee
			, DV_Load_Datetime
			, DV_Record_Source
			, EmployeeID
		FROM
			rv.v_stage_H_Employee__L2_Northwind_EmployeeTerritories;

	END
GO




-- usp_insert_H_Employee__L2_Northwind_Orders

DROP PROCEDURE IF EXISTS rv.usp_insert_H_Employee__L2_Northwind_Orders;
GO

CREATE PROCEDURE rv.usp_insert_H_Employee__L2_Northwind_Orders
AS
	BEGIN

		INSERT INTO rv.H_Employee (
			  HK_H_Employee
			, DV_Load_Datetime
			, DV_Record_Source
			, EmployeeID
		)
		SELECT
			  HK_H_Employee
			, DV_Load_Datetime
			, DV_Record_Source
			, EmployeeID
		FROM
			rv.v_stage_H_Employee__L2_Northwind_Orders;

	END
GO




-- usp_insert_H_Order__L2_Northwind_Order_Details

DROP PROCEDURE IF EXISTS rv.usp_insert_H_Order__L2_Northwind_Order_Details;
GO

CREATE PROCEDURE rv.usp_insert_H_Order__L2_Northwind_Order_Details
AS
	BEGIN

		INSERT INTO rv.H_Order (
			  HK_H_Order
			, DV_Load_Datetime
			, DV_Record_Source
			, OrderID
		)
		SELECT
			  HK_H_Order
			, DV_Load_Datetime
			, DV_Record_Source
			, OrderID
		FROM
			rv.v_stage_H_Order__L2_Northwind_Order_Details;

	END
GO




-- usp_insert_H_Order__L2_Northwind_Orders

DROP PROCEDURE IF EXISTS rv.usp_insert_H_Order__L2_Northwind_Orders;
GO

CREATE PROCEDURE rv.usp_insert_H_Order__L2_Northwind_Orders
AS
	BEGIN

		INSERT INTO rv.H_Order (
			  HK_H_Order
			, DV_Load_Datetime
			, DV_Record_Source
			, OrderID
		)
		SELECT
			  HK_H_Order
			, DV_Load_Datetime
			, DV_Record_Source
			, OrderID
		FROM
			rv.v_stage_H_Order__L2_Northwind_Orders;

	END
GO




-- usp_insert_H_Product__L2_Northwind_Order_Details

DROP PROCEDURE IF EXISTS rv.usp_insert_H_Product__L2_Northwind_Order_Details;
GO

CREATE PROCEDURE rv.usp_insert_H_Product__L2_Northwind_Order_Details
AS
	BEGIN

		INSERT INTO rv.H_Product (
			  HK_H_Product
			, DV_Load_Datetime
			, DV_Record_Source
			, ProductID
		)
		SELECT
			  HK_H_Product
			, DV_Load_Datetime
			, DV_Record_Source
			, ProductID
		FROM
			rv.v_stage_H_Product__L2_Northwind_Order_Details;

	END
GO




-- usp_insert_H_Product__L2_Northwind_Products

DROP PROCEDURE IF EXISTS rv.usp_insert_H_Product__L2_Northwind_Products;
GO

CREATE PROCEDURE rv.usp_insert_H_Product__L2_Northwind_Products
AS
	BEGIN

		INSERT INTO rv.H_Product (
			  HK_H_Product
			, DV_Load_Datetime
			, DV_Record_Source
			, ProductID
		)
		SELECT
			  HK_H_Product
			, DV_Load_Datetime
			, DV_Record_Source
			, ProductID
		FROM
			rv.v_stage_H_Product__L2_Northwind_Products;

	END
GO




-- usp_insert_H_Product_Category__L2_Northwind_Categories

DROP PROCEDURE IF EXISTS rv.usp_insert_H_Product_Category__L2_Northwind_Categories;
GO

CREATE PROCEDURE rv.usp_insert_H_Product_Category__L2_Northwind_Categories
AS
	BEGIN

		INSERT INTO rv.H_Product_Category (
			  HK_H_Product_Category
			, DV_Load_Datetime
			, DV_Record_Source
			, CategoryID
		)
		SELECT
			  HK_H_Product_Category
			, DV_Load_Datetime
			, DV_Record_Source
			, CategoryID
		FROM
			rv.v_stage_H_Product_Category__L2_Northwind_Categories;

	END
GO




-- usp_insert_H_Product_Category__L2_Northwind_Products

DROP PROCEDURE IF EXISTS rv.usp_insert_H_Product_Category__L2_Northwind_Products;
GO

CREATE PROCEDURE rv.usp_insert_H_Product_Category__L2_Northwind_Products
AS
	BEGIN

		INSERT INTO rv.H_Product_Category (
			  HK_H_Product_Category
			, DV_Load_Datetime
			, DV_Record_Source
			, CategoryID
		)
		SELECT
			  HK_H_Product_Category
			, DV_Load_Datetime
			, DV_Record_Source
			, CategoryID
		FROM
			rv.v_stage_H_Product_Category__L2_Northwind_Products;

	END
GO




-- usp_insert_H_Region__L2_Northwind_Region

DROP PROCEDURE IF EXISTS rv.usp_insert_H_Region__L2_Northwind_Region;
GO

CREATE PROCEDURE rv.usp_insert_H_Region__L2_Northwind_Region
AS
	BEGIN

		INSERT INTO rv.H_Region (
			  HK_H_Region
			, DV_Load_Datetime
			, DV_Record_Source
			, RegionID
		)
		SELECT
			  HK_H_Region
			, DV_Load_Datetime
			, DV_Record_Source
			, RegionID
		FROM
			rv.v_stage_H_Region__L2_Northwind_Region;

	END
GO




-- usp_insert_H_Region__L2_Northwind_Territories

DROP PROCEDURE IF EXISTS rv.usp_insert_H_Region__L2_Northwind_Territories;
GO

CREATE PROCEDURE rv.usp_insert_H_Region__L2_Northwind_Territories
AS
	BEGIN

		INSERT INTO rv.H_Region (
			  HK_H_Region
			, DV_Load_Datetime
			, DV_Record_Source
			, RegionID
		)
		SELECT
			  HK_H_Region
			, DV_Load_Datetime
			, DV_Record_Source
			, RegionID
		FROM
			rv.v_stage_H_Region__L2_Northwind_Territories;

	END
GO




-- usp_insert_H_Shipper__L2_Northwind_Orders

DROP PROCEDURE IF EXISTS rv.usp_insert_H_Shipper__L2_Northwind_Orders;
GO

CREATE PROCEDURE rv.usp_insert_H_Shipper__L2_Northwind_Orders
AS
	BEGIN

		INSERT INTO rv.H_Shipper (
			  HK_H_Shipper
			, DV_Load_Datetime
			, DV_Record_Source
			, ShipperID
		)
		SELECT
			  HK_H_Shipper
			, DV_Load_Datetime
			, DV_Record_Source
			, ShipperID
		FROM
			rv.v_stage_H_Shipper__L2_Northwind_Orders;

	END
GO




-- usp_insert_H_Shipper__L2_Northwind_Shippers

DROP PROCEDURE IF EXISTS rv.usp_insert_H_Shipper__L2_Northwind_Shippers;
GO

CREATE PROCEDURE rv.usp_insert_H_Shipper__L2_Northwind_Shippers
AS
	BEGIN

		INSERT INTO rv.H_Shipper (
			  HK_H_Shipper
			, DV_Load_Datetime
			, DV_Record_Source
			, ShipperID
		)
		SELECT
			  HK_H_Shipper
			, DV_Load_Datetime
			, DV_Record_Source
			, ShipperID
		FROM
			rv.v_stage_H_Shipper__L2_Northwind_Shippers;

	END
GO




-- usp_insert_H_Supplier__L2_Northwind_Products

DROP PROCEDURE IF EXISTS rv.usp_insert_H_Supplier__L2_Northwind_Products;
GO

CREATE PROCEDURE rv.usp_insert_H_Supplier__L2_Northwind_Products
AS
	BEGIN

		INSERT INTO rv.H_Supplier (
			  HK_H_Supplier
			, DV_Load_Datetime
			, DV_Record_Source
			, SupplierID
		)
		SELECT
			  HK_H_Supplier
			, DV_Load_Datetime
			, DV_Record_Source
			, SupplierID
		FROM
			rv.v_stage_H_Supplier__L2_Northwind_Products;

	END
GO




-- usp_insert_H_Supplier__L2_Northwind_Suppliers

DROP PROCEDURE IF EXISTS rv.usp_insert_H_Supplier__L2_Northwind_Suppliers;
GO

CREATE PROCEDURE rv.usp_insert_H_Supplier__L2_Northwind_Suppliers
AS
	BEGIN

		INSERT INTO rv.H_Supplier (
			  HK_H_Supplier
			, DV_Load_Datetime
			, DV_Record_Source
			, SupplierID
		)
		SELECT
			  HK_H_Supplier
			, DV_Load_Datetime
			, DV_Record_Source
			, SupplierID
		FROM
			rv.v_stage_H_Supplier__L2_Northwind_Suppliers;

	END
GO




-- usp_insert_H_Territory__L2_Northwind_EmployeeTerritories

DROP PROCEDURE IF EXISTS rv.usp_insert_H_Territory__L2_Northwind_EmployeeTerritories;
GO

CREATE PROCEDURE rv.usp_insert_H_Territory__L2_Northwind_EmployeeTerritories
AS
	BEGIN

		INSERT INTO rv.H_Territory (
			  HK_H_Territory
			, DV_Load_Datetime
			, DV_Record_Source
			, TerritoryID
		)
		SELECT
			  HK_H_Territory
			, DV_Load_Datetime
			, DV_Record_Source
			, TerritoryID
		FROM
			rv.v_stage_H_Territory__L2_Northwind_EmployeeTerritories;

	END
GO




-- usp_insert_H_Territory__L2_Northwind_Territories

DROP PROCEDURE IF EXISTS rv.usp_insert_H_Territory__L2_Northwind_Territories;
GO

CREATE PROCEDURE rv.usp_insert_H_Territory__L2_Northwind_Territories
AS
	BEGIN

		INSERT INTO rv.H_Territory (
			  HK_H_Territory
			, DV_Load_Datetime
			, DV_Record_Source
			, TerritoryID
		)
		SELECT
			  HK_H_Territory
			, DV_Load_Datetime
			, DV_Record_Source
			, TerritoryID
		FROM
			rv.v_stage_H_Territory__L2_Northwind_Territories;

	END
GO