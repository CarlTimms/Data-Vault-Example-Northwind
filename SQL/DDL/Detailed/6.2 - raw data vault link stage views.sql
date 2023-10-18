/*

	Raw data vault link stage views

*/


USE Data_Vault;
GO


-- v_stage_L_Customer_Type__L2_Northwind_CustomerCustomerDemo

DROP VIEW IF EXISTS rv.v_stage_L_Customer_Type__L2_Northwind_CustomerCustomerDemo;
GO

CREATE VIEW rv.v_stage_L_Customer_Type__L2_Northwind_CustomerCustomerDemo (
	  HK_L_Customer_Type
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Customer
	, HK_H_Customer_Type
)
AS
SELECT DISTINCT 
	  HK_L_Customer_Type
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Customer
	, HK_H_Customer_Type
FROM
	Staging.northwind.L2_Northwind_CustomerCustomerDemo AS stage
WHERE
	NOT EXISTS (
		SELECT
			link.HK_L_Customer_Type
		FROM
			rv.L_Customer_Type AS link
		WHERE
			stage.HK_L_Customer_Type = link.HK_L_Customer_Type
	);
GO




-- v_stage_L_Employee_Reporting_Line__L2_Northwind_Employees

DROP VIEW IF EXISTS rv.v_stage_L_Employee_Reporting_Line__L2_Northwind_Employees;
GO

CREATE VIEW rv.v_stage_L_Employee_Reporting_Line__L2_Northwind_Employees (
	  HK_L_Employee_Reporting_Line
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Employee__Direct_Report__DK
	, HK_H_Employee__Manager
)
AS
SELECT DISTINCT 
	  HK_L_Employee_Reporting_Line
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Employee AS HK_H_Employee__Direct_Report__DK
	, HK_H_Employee__Manager
FROM
	Staging.northwind.L2_Northwind_Employees AS stage
WHERE
	NOT EXISTS (
		SELECT
			link.HK_L_Employee_Reporting_Line
		FROM
			rv.L_Employee_Reporting_Line AS link
		WHERE
			stage.HK_L_Employee_Reporting_Line = link.HK_L_Employee_Reporting_Line
	);
GO




-- v_stage_L_Employee_Territory__L2_Northwind_EmployeeTerritories

DROP VIEW IF EXISTS rv.v_stage_L_Employee_Territory__L2_Northwind_EmployeeTerritories;
GO

CREATE VIEW rv.v_stage_L_Employee_Territory__L2_Northwind_EmployeeTerritories (
	  HK_L_Employee_Territory
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Employee
	, HK_H_Territory
)
AS
SELECT DISTINCT 
	  HK_L_Employee_Territory
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Employee
	, HK_H_Territory
FROM
	Staging.northwind.L2_Northwind_EmployeeTerritories AS stage
WHERE
	NOT EXISTS (
		SELECT
			link.HK_L_Employee_Territory
		FROM
			rv.L_Employee_Territory AS link
		WHERE
			stage.HK_L_Employee_Territory = link.HK_L_Employee_Territory
	);
GO




-- v_stage_L_Order_Detail__L2_Northwind_Order_Details

DROP VIEW IF EXISTS rv.v_stage_L_Order_Detail__L2_Northwind_Order_Details;
GO

CREATE VIEW rv.v_stage_L_Order_Detail__L2_Northwind_Order_Details (
	  HK_L_Order_Detail
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Order
	, HK_H_Product
)
AS
SELECT DISTINCT 
	  HK_L_Order_Detail
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Order
	, HK_H_Product
FROM
	Staging.northwind.L2_Northwind_Order_Details AS stage
WHERE
	NOT EXISTS (
		SELECT
			link.HK_L_Order_Detail
		FROM
			rv.L_Order_Detail AS link
		WHERE
			stage.HK_L_Order_Detail = link.HK_L_Order_Detail
	);
GO




-- v_stage_L_Order_Header__L2_Northwind_Orders

DROP VIEW IF EXISTS rv.v_stage_L_Order_Header__L2_Northwind_Orders;
GO

CREATE VIEW rv.v_stage_L_Order_Header__L2_Northwind_Orders (
	  HK_L_Order_Header
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Order__DK
	, HK_H_Customer
	, HK_H_Employee
	, HK_H_Shipper
)
AS
SELECT DISTINCT 
	  HK_L_Order_Header
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Order AS HK_H_Order__DK
	, HK_H_Customer
	, HK_H_Employee
	, HK_H_Shipper
FROM
	Staging.northwind.L2_Northwind_Orders AS stage
WHERE
	NOT EXISTS (
		SELECT
			link.HK_L_Order_Header
		FROM
			rv.L_Order_Header AS link
		WHERE
			stage.HK_L_Order_Header = link.HK_L_Order_Header
	);
GO




-- v_stage_L_Product_Category__L2_Northwind_Products

DROP VIEW IF EXISTS rv.v_stage_L_Product_Category__L2_Northwind_Products;
GO

CREATE VIEW rv.v_stage_L_Product_Category__L2_Northwind_Products (
	  HK_L_Product_Category
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Product__DK
	, HK_H_Product_Category
)
AS
SELECT DISTINCT 
	  HK_L_Product_Category
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Product AS HK_H_Product__DK
	, HK_H_Product_Category
FROM
	Staging.northwind.L2_Northwind_Products AS stage
WHERE
	NOT EXISTS (
		SELECT
			link.HK_L_Product_Category
		FROM
			rv.L_Product_Category AS link
		WHERE
			stage.HK_L_Product_Category = link.HK_L_Product_Category
	);
GO




-- v_stage_L_Product_Supplier__L2_Northwind_Products

DROP VIEW IF EXISTS rv.v_stage_L_Product_Supplier__L2_Northwind_Products;
GO

CREATE VIEW rv.v_stage_L_Product_Supplier__L2_Northwind_Products (
	  HK_L_Product_Supplier
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Product__DK
	, HK_H_Supplier
)
AS
SELECT DISTINCT 
	  HK_L_Product_Supplier
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Product AS HK_H_Product__DK
	, HK_H_Supplier
FROM
	Staging.northwind.L2_Northwind_Products AS stage
WHERE
	NOT EXISTS (
		SELECT
			link.HK_L_Product_Supplier
		FROM
			rv.L_Product_Supplier AS link
		WHERE
			stage.HK_L_Product_Supplier = link.HK_L_Product_Supplier
	);
GO




-- v_stage_L_Territory_Region__L2_Northwind_Territories

DROP VIEW IF EXISTS rv.v_stage_L_Territory_Region__L2_Northwind_Territories;
GO

CREATE VIEW rv.v_stage_L_Territory_Region__L2_Northwind_Territories (
	  HK_L_Territory_Region
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Territory__DK
	, HK_H_Region
)
AS
SELECT DISTINCT 
	  HK_L_Territory_Region
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Territory AS HK_H_Territory__DK
	, HK_H_Region
FROM
	Staging.northwind.L2_Northwind_Territories AS stage
WHERE
	NOT EXISTS (
		SELECT
			link.HK_L_Territory_Region
		FROM
			rv.L_Territory_Region AS link
		WHERE
			stage.HK_L_Territory_Region = link.HK_L_Territory_Region
	);
GO