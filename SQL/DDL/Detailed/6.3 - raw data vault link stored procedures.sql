/*

	Raw data vault link stored procedures

*/


USE Data_Vault;
GO


-- usp_insert_L_Customer_Type__L2_Northwind_CustomerCustomerDemo

DROP PROCEDURE IF EXISTS rv.usp_insert_L_Customer_Type__L2_Northwind_CustomerCustomerDemo;
GO

CREATE PROCEDURE rv.usp_insert_L_Customer_Type__L2_Northwind_CustomerCustomerDemo 
AS
	BEGIN

		INSERT INTO rv.L_Customer_Type (
			  HK_L_Customer_Type
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Customer
			, HK_H_Customer_Type
		)
		SELECT
			  HK_L_Customer_Type
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Customer
			, HK_H_Customer_Type
		FROM
			rv.v_stage_L_Customer_Type__L2_Northwind_CustomerCustomerDemo;

	END
GO




-- usp_insert_L_Employee_Reporting_Line__L2_Northwind_Employees

DROP PROCEDURE IF EXISTS rv.usp_insert_L_Employee_Reporting_Line__L2_Northwind_Employees;
GO

CREATE PROCEDURE rv.usp_insert_L_Employee_Reporting_Line__L2_Northwind_Employees 
AS
	BEGIN

		INSERT INTO rv.L_Employee_Reporting_Line (
			  HK_L_Employee_Reporting_Line
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Employee__Direct_Report__DK
			, HK_H_Employee__Manager
		)
		SELECT
			  HK_L_Employee_Reporting_Line
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Employee__Direct_Report__DK
			, HK_H_Employee__Manager
		FROM
			rv.v_stage_L_Employee_Reporting_Line__L2_Northwind_Employees;

	END
GO




-- usp_insert_L_Employee_Territory__L2_Northwind_EmployeeTerritories

DROP PROCEDURE IF EXISTS rv.usp_insert_L_Employee_Territory__L2_Northwind_EmployeeTerritories;
GO

CREATE PROCEDURE rv.usp_insert_L_Employee_Territory__L2_Northwind_EmployeeTerritories 
AS
	BEGIN

		INSERT INTO rv.L_Employee_Territory (
			  HK_L_Employee_Territory
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Employee
			, HK_H_Territory
		)
		SELECT
			  HK_L_Employee_Territory
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Employee
			, HK_H_Territory
		FROM
			rv.v_stage_L_Employee_Territory__L2_Northwind_EmployeeTerritories;

	END
GO




-- usp_insert_L_Order_Detail__L2_Northwind_Order_Details

DROP PROCEDURE IF EXISTS rv.usp_insert_L_Order_Detail__L2_Northwind_Order_Details;
GO

CREATE PROCEDURE rv.usp_insert_L_Order_Detail__L2_Northwind_Order_Details 
AS
	BEGIN

		INSERT INTO rv.L_Order_Detail (
			  HK_L_Order_Detail
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Order
			, HK_H_Product
		)
		SELECT
			  HK_L_Order_Detail
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Order
			, HK_H_Product
		FROM
			rv.v_stage_L_Order_Detail__L2_Northwind_Order_Details;

	END
GO




-- usp_insert_L_Order_Header__L2_Northwind_Orders

DROP PROCEDURE IF EXISTS rv.usp_insert_L_Order_Header__L2_Northwind_Orders;
GO

CREATE PROCEDURE rv.usp_insert_L_Order_Header__L2_Northwind_Orders 
AS
	BEGIN

		INSERT INTO rv.L_Order_Header (
			  HK_L_Order_Header
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Order__DK
			, HK_H_Customer
			, HK_H_Employee
			, HK_H_Shipper
		)
		SELECT
			  HK_L_Order_Header
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Order__DK
			, HK_H_Customer
			, HK_H_Employee
			, HK_H_Shipper
		FROM
			rv.v_stage_L_Order_Header__L2_Northwind_Orders;

	END
GO




-- usp_insert_L_Product_Category__L2_Northwind_Products

DROP PROCEDURE IF EXISTS rv.usp_insert_L_Product_Category__L2_Northwind_Products;
GO

CREATE PROCEDURE rv.usp_insert_L_Product_Category__L2_Northwind_Products 
AS
	BEGIN

		INSERT INTO rv.L_Product_Category (
			  HK_L_Product_Category
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Product__DK
			, HK_H_Product_Category
		)
		SELECT
			  HK_L_Product_Category
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Product__DK
			, HK_H_Product_Category
		FROM
			rv.v_stage_L_Product_Category__L2_Northwind_Products;

	END
GO




-- usp_insert_L_Product_Supplier__L2_Northwind_Products

DROP PROCEDURE IF EXISTS rv.usp_insert_L_Product_Supplier__L2_Northwind_Products;
GO

CREATE PROCEDURE rv.usp_insert_L_Product_Supplier__L2_Northwind_Products 
AS
	BEGIN

		INSERT INTO rv.L_Product_Supplier (
			  HK_L_Product_Supplier
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Product__DK
			, HK_H_Supplier
		)
		SELECT
			  HK_L_Product_Supplier
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Product__DK
			, HK_H_Supplier
		FROM
			rv.v_stage_L_Product_Supplier__L2_Northwind_Products;

	END
GO
	
	


-- usp_insert_L_Territory_Region__L2_Northwind_Territories

DROP PROCEDURE IF EXISTS rv.usp_insert_L_Territory_Region__L2_Northwind_Territories;
GO

CREATE PROCEDURE rv.usp_insert_L_Territory_Region__L2_Northwind_Territories
AS
	BEGIN

		INSERT INTO rv.L_Territory_Region (
			  HK_L_Territory_Region
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Territory__DK
			, HK_H_Region
		)
		SELECT
			  HK_L_Territory_Region
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Territory__DK
			, HK_H_Region
		FROM
			rv.v_stage_L_Territory_Region__L2_Northwind_Territories;

	END
GO