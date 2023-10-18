/*
	
	Raw data vault hub stage views

*/


USE Data_Vault;
GO


-- v_stage_H_Customer__L2_Northwind_CustomerCustomerDemo

DROP VIEW IF EXISTS rv.v_stage_H_Customer__L2_Northwind_CustomerCustomerDemo;
GO

CREATE VIEW rv.v_stage_H_Customer__L2_Northwind_CustomerCustomerDemo (
	  HK_H_Customer
	, DV_Load_Datetime
	, DV_Record_Source
	, CustomerID
)
AS
SELECT DISTINCT
	  HK_H_Customer
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, CustomerID
FROM
	Staging.northwind.L2_Northwind_CustomerCustomerDemo AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Customer
		FROM
			Data_Vault.rv.H_Customer AS hub
		WHERE
			stage.HK_H_Customer = hub.HK_H_Customer
	);
GO




-- v_stage_H_Customer__L2_Northwind_Customers

DROP VIEW IF EXISTS rv.v_stage_H_Customer__L2_Northwind_Customers;
GO

CREATE VIEW rv.v_stage_H_Customer__L2_Northwind_Customers (
	  HK_H_Customer
	, DV_Load_Datetime
	, DV_Record_Source
	, CustomerID
)
AS
SELECT DISTINCT
	  HK_H_Customer
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, CustomerID
FROM
	Staging.northwind.L2_Northwind_Customers AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Customer
		FROM
			Data_Vault.rv.H_Customer AS hub
		WHERE
			stage.HK_H_Customer = hub.HK_H_Customer
	);
GO




-- v_stage_H_Customer__L2_Northwind_Orders

DROP VIEW IF EXISTS rv.v_stage_H_Customer__L2_Northwind_Orders;
GO

CREATE VIEW rv.v_stage_H_Customer__L2_Northwind_Orders (
	  HK_H_Customer
	, DV_Load_Datetime
	, DV_Record_Source
	, CustomerID
)
AS
SELECT DISTINCT
	  HK_H_Customer
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, CustomerID
FROM
	Staging.northwind.L2_Northwind_Orders AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Customer
		FROM
			Data_Vault.rv.H_Customer AS hub
		WHERE
			stage.HK_H_Customer = hub.HK_H_Customer
	);
GO




-- v_stage_H_Customer_Type__L2_Northwind_CustomerCustomerDemo

DROP VIEW IF EXISTS rv.v_stage_H_Customer_Type__L2_Northwind_CustomerCustomerDemo;
GO

CREATE VIEW rv.v_stage_H_Customer_Type__L2_Northwind_CustomerCustomerDemo (
	  HK_H_Customer_Type
	, DV_Load_Datetime
	, DV_Record_Source
	, CustomerTypeID
)
AS
SELECT DISTINCT
	  HK_H_Customer_Type
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, CustomerTypeID
FROM
	Staging.northwind.L2_Northwind_CustomerCustomerDemo AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Customer_Type
		FROM
			Data_Vault.rv.H_Customer_Type AS hub
		WHERE
			stage.HK_H_Customer_Type = hub.HK_H_Customer_Type
	);
GO




-- v_stage_H_Customer_Type__L2_Northwind_CustomerDemographics

DROP VIEW IF EXISTS rv.v_stage_H_Customer_Type__L2_Northwind_CustomerDemographics;
GO

CREATE VIEW rv.v_stage_H_Customer_Type__L2_Northwind_CustomerDemographics (
	  HK_H_Customer_Type
	, DV_Load_Datetime
	, DV_Record_Source
	, CustomerTypeID
)
AS
SELECT DISTINCT
	  HK_H_Customer_Type
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, CustomerTypeID
FROM
	Staging.northwind.L2_Northwind_CustomerDemographics AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Customer_Type
		FROM
			Data_Vault.rv.H_Customer_Type AS hub
		WHERE
			stage.HK_H_Customer_Type= hub.HK_H_Customer_Type
	);
GO




-- v_stage_H_Employee__L2_Northwind_Employees__EmployeeID

DROP VIEW IF EXISTS rv.v_stage_H_Employee__L2_Northwind_Employees__EmployeeID ;
GO

CREATE VIEW rv.v_stage_H_Employee__L2_Northwind_Employees__EmployeeID (
	  HK_H_Employee
	, DV_Load_Datetime
	, DV_Record_Source
	, EmployeeID
)
AS
SELECT DISTINCT
	  HK_H_Employee
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, EmployeeID
FROM
	Staging.northwind.L2_Northwind_Employees AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Employee
		FROM
			Data_Vault.rv.H_Employee AS hub
		WHERE
			stage.HK_H_Employee = hub.HK_H_Employee
	);
GO




-- v_stage_H_Employee__L2_Northwind_Employees__ReportsTo

DROP VIEW IF EXISTS rv.v_stage_H_Employee__L2_Northwind_Employees__ReportsTo;
GO

CREATE VIEW rv.v_stage_H_Employee__L2_Northwind_Employees__ReportsTo (
	  HK_H_Employee
	, DV_Load_Datetime
	, DV_Record_Source
	, EmployeeID
)
AS
SELECT DISTINCT
	  HK_H_Employee__Manager AS HK_H_Employee
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, ReportsTo AS EmployeeID
FROM
	Staging.northwind.L2_Northwind_Employees AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Employee
		FROM
			Data_Vault.rv.H_Employee AS hub
		WHERE
			stage.HK_H_Employee__Manager = hub.HK_H_Employee
	);
GO




-- v_stage_H_Employee__L2_Northwind_EmployeeTerritories

DROP VIEW IF EXISTS rv.v_stage_H_Employee__L2_Northwind_EmployeeTerritories;
GO

CREATE VIEW rv.v_stage_H_Employee__L2_Northwind_EmployeeTerritories (
	  HK_H_Employee
	, DV_Load_Datetime
	, DV_Record_Source
	, EmployeeID
)
AS
SELECT DISTINCT
	  HK_H_Employee
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, EmployeeID
FROM
	Staging.northwind.L2_Northwind_EmployeeTerritories AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Employee
		FROM
			Data_Vault.rv.H_Employee AS hub
		WHERE
			stage.HK_H_Employee = hub.HK_H_Employee
	);
GO




-- v_stage_H_Employee__L2_Northwind_Orders

DROP VIEW IF EXISTS rv.v_stage_H_Employee__L2_Northwind_Orders;
GO

CREATE VIEW rv.v_stage_H_Employee__L2_Northwind_Orders (
	  HK_H_Employee
	, DV_Load_Datetime
	, DV_Record_Source
	, EmployeeID
)
AS
SELECT DISTINCT
	  HK_H_Employee
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, EmployeeID
FROM
	Staging.northwind.L2_Northwind_Orders AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Employee
		FROM
			Data_Vault.rv.H_Employee AS hub
		WHERE
			stage.HK_H_Employee = hub.HK_H_Employee
	);
GO




-- v_stage_H_Order__L2_Northwind_Order_Details

DROP VIEW IF EXISTS rv.v_stage_H_Order__L2_Northwind_Order_Details;
GO

CREATE VIEW rv.v_stage_H_Order__L2_Northwind_Order_Details (
	  HK_H_Order
	, DV_Load_Datetime
	, DV_Record_Source
	, OrderID
)
AS
SELECT DISTINCT
	  HK_H_Order
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, OrderID
FROM
	Staging.northwind.L2_Northwind_Order_Details AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Order
		FROM
			Data_Vault.rv.H_Order AS hub
		WHERE
			stage.HK_H_Order = hub.HK_H_Order
	);
GO




-- v_stage_H_Order__L2_Northwind_Orders

DROP VIEW IF EXISTS rv.v_stage_H_Order__L2_Northwind_Orders;
GO

CREATE VIEW rv.v_stage_H_Order__L2_Northwind_Orders (
	  HK_H_Order
	, DV_Load_Datetime
	, DV_Record_Source
	, OrderID
)
AS
SELECT DISTINCT
	  HK_H_Order
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, OrderID
FROM
	Staging.northwind.L2_Northwind_Orders AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Order
		FROM
			Data_Vault.rv.H_Order AS hub
		WHERE
			stage.HK_H_Order = hub.HK_H_Order
	);
GO




-- v_stage_H_Product__L2_Northwind_Order_Details

DROP VIEW IF EXISTS rv.v_stage_H_Product__L2_Northwind_Order_Details;
GO

CREATE VIEW rv.v_stage_H_Product__L2_Northwind_Order_Details (
	  HK_H_Product
	, DV_Load_Datetime
	, DV_Record_Source
	, ProductID
)
AS
SELECT DISTINCT
	  HK_H_Product
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, ProductID
FROM
	Staging.northwind.L2_Northwind_Order_Details AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Product
		FROM
			Data_Vault.rv.H_Product AS hub
		WHERE
			stage.HK_H_Product = hub.HK_H_Product
	);
GO




-- v_stage_H_Product__L2_Northwind_Products

DROP VIEW IF EXISTS rv.v_stage_H_Product__L2_Northwind_Products;
GO

CREATE VIEW rv.v_stage_H_Product__L2_Northwind_Products (
	  HK_H_Product
	, DV_Load_Datetime
	, DV_Record_Source
	, ProductID
)
AS
SELECT DISTINCT
	  HK_H_Product
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, ProductID
FROM
	Staging.northwind.L2_Northwind_Products AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Product
		FROM
			Data_Vault.rv.H_Product AS hub
		WHERE
			stage.HK_H_Product = hub.HK_H_Product
	);
GO




-- v_stage_H_Product_Category__L2_Northwind_Categories

DROP VIEW IF EXISTS rv.v_stage_H_Product_Category__L2_Northwind_Categories;
GO

CREATE VIEW rv.v_stage_H_Product_Category__L2_Northwind_Categories (
	  HK_H_Product_Category
	, DV_Load_Datetime
	, DV_Record_Source
	, CategoryID
)
AS
SELECT DISTINCT
	  HK_H_Product_Category
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, CategoryID
FROM
	Staging.northwind.L2_Northwind_Categories AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Product_Category
		FROM
			Data_Vault.rv.H_Product_Category AS hub
		WHERE
			stage.HK_H_Product_Category = hub.HK_H_Product_Category
	);
GO




-- v_stage_H_Product_Category__L2_Northwind_Products

DROP VIEW IF EXISTS rv.v_stage_H_Product_Category__L2_Northwind_Products;
GO

CREATE VIEW rv.v_stage_H_Product_Category__L2_Northwind_Products (
	  HK_H_Product_Category
	, DV_Load_Datetime
	, DV_Record_Source
	, CategoryID
)
AS
SELECT DISTINCT
	  HK_H_Product_Category
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, CategoryID
FROM
	Staging.northwind.L2_Northwind_Products AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Product_Category
		FROM
			Data_Vault.rv.H_Product_Category AS hub
		WHERE
			stage.HK_H_Product_Category = hub.HK_H_Product_Category
	);
GO




-- v_stage_H_Region__L2_Northwind_Region

DROP VIEW IF EXISTS rv.v_stage_H_Region__L2_Northwind_Region;
GO

CREATE VIEW rv.v_stage_H_Region__L2_Northwind_Region (
	  HK_H_Region
	, DV_Load_Datetime
	, DV_Record_Source
	, RegionID
)
AS
SELECT DISTINCT
	  HK_H_Region
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, RegionID
FROM
	Staging.northwind.L2_Northwind_Region AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Region
		FROM
			Data_Vault.rv.H_Region AS hub
		WHERE
			stage.HK_H_Region = hub.HK_H_Region
	);
GO




-- v_stage_H_Region__L2_Northwind_Territories

DROP VIEW IF EXISTS rv.v_stage_H_Region__L2_Northwind_Territories;
GO

CREATE VIEW rv.v_stage_H_Region__L2_Northwind_Territories (
	  HK_H_Region
	, DV_Load_Datetime
	, DV_Record_Source
	, RegionID
)
AS
SELECT DISTINCT
	  HK_H_Region
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, RegionID
FROM
	Staging.northwind.L2_Northwind_Territories AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Region
		FROM
			Data_Vault.rv.H_Region AS hub
		WHERE
			stage.HK_H_Region = hub.HK_H_Region
	);
GO




-- v_stage_H_Shipper__L2_Northwind_Orders

DROP VIEW IF EXISTS rv.v_stage_H_Shipper__L2_Northwind_Orders;
GO

CREATE VIEW rv.v_stage_H_Shipper__L2_Northwind_Orders (
	  HK_H_Shipper
	, DV_Load_Datetime
	, DV_Record_Source
	, ShipperID
)
AS
SELECT DISTINCT
	  HK_H_Shipper
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, ShipVia AS ShipperID
FROM
	Staging.northwind.L2_Northwind_Orders AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Shipper
		FROM
			Data_Vault.rv.H_Shipper AS hub
		WHERE
			stage.HK_H_Shipper = hub.HK_H_Shipper
	);
GO




-- v_stage_H_Shipper__L2_Northwind_Shippers

DROP VIEW IF EXISTS rv.v_stage_H_Shipper__L2_Northwind_Shippers;
GO

CREATE VIEW rv.v_stage_H_Shipper__L2_Northwind_Shippers (
	  HK_H_Shipper
	, DV_Load_Datetime
	, DV_Record_Source
	, ShipperID
)
AS
SELECT DISTINCT
	  HK_H_Shipper
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, ShipperID
FROM
	Staging.northwind.L2_Northwind_Shippers AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Shipper
		FROM
			Data_Vault.rv.H_Shipper AS hub
		WHERE
			stage.HK_H_Shipper = hub.HK_H_Shipper
	);
GO




-- v_stage_H_Supplier__L2_Northwind_Products

DROP VIEW IF EXISTS rv.v_stage_H_Supplier__L2_Northwind_Products;
GO

CREATE VIEW rv.v_stage_H_Supplier__L2_Northwind_Products (
	  HK_H_Supplier
	, DV_Load_Datetime
	, DV_Record_Source
	, SupplierID
)
AS
SELECT DISTINCT
	  HK_H_Supplier
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, SupplierID
FROM
	Staging.northwind.L2_Northwind_Products AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Supplier
		FROM
			Data_Vault.rv.H_Supplier AS hub
		WHERE
			stage.HK_H_Supplier = hub.HK_H_Supplier
	);
GO




-- v_stage_H_Supplier__L2_Northwind_Suppliers

DROP VIEW IF EXISTS rv.v_stage_H_Supplier__L2_Northwind_Suppliers;
GO

CREATE VIEW rv.v_stage_H_Supplier__L2_Northwind_Suppliers (
	  HK_H_Supplier
	, DV_Load_Datetime
	, DV_Record_Source
	, SupplierID
)
AS
SELECT DISTINCT
	  HK_H_Supplier
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, SupplierID
FROM
	Staging.northwind.L2_Northwind_Suppliers AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Supplier
		FROM
			Data_Vault.rv.H_Supplier AS hub
		WHERE
			stage.HK_H_Supplier = hub.HK_H_Supplier
	);
GO




-- v_stage_H_Territory__L2_Northwind_EmployeeTerritories

DROP VIEW IF EXISTS rv.v_stage_H_Territory__L2_Northwind_EmployeeTerritories;
GO

CREATE VIEW rv.v_stage_H_Territory__L2_Northwind_EmployeeTerritories (
	  HK_H_Territory
	, DV_Load_Datetime
	, DV_Record_Source
	, TerritoryID
)
AS
SELECT DISTINCT
	  HK_H_Territory
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, TerritoryID
FROM
	Staging.northwind.L2_Northwind_EmployeeTerritories AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Territory
		FROM
			Data_Vault.rv.H_Territory AS hub
		WHERE
			stage.HK_H_Territory = hub.HK_H_Territory
	);
GO




-- v_stage_H_Territory__L2_Northwind_Territories

DROP VIEW IF EXISTS rv.v_stage_H_Territory__L2_Northwind_Territories;
GO

CREATE VIEW rv.v_stage_H_Territory__L2_Northwind_Territories (
	  HK_H_Territory
	, DV_Load_Datetime
	, DV_Record_Source
	, TerritoryID
)
AS
SELECT DISTINCT
	  HK_H_Territory
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, TerritoryID
FROM
	Staging.northwind.L2_Northwind_Territories AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Territory
		FROM
			Data_Vault.rv.H_Territory AS hub
		WHERE
			stage.HK_H_Territory = hub.HK_H_Territory
	);
GO