/*

	Business data vault link effectivity satellite stage views

*/


USE Data_Vault;
GO


-- usp_insert_S_LE_L_Employee_Reporting_Line_Northwind__L2_Northwind_Employees

DROP PROCEDURE IF EXISTS bv.usp_insert_S_LE_L_Employee_Reporting_Line_Northwind__L2_Northwind_Employees;
GO

CREATE PROCEDURE bv.usp_insert_S_LE_L_Employee_Reporting_Line_Northwind__L2_Northwind_Employees
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_LE_L_Employee_Reporting_Line_Northwind (  
			  HK_L_Employee_Reporting_Line
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Employee__Direct_Report__DK
			, Start_Datetime
			, HK_L_Employee_Reporting_Line__Previous
			, DV_Load_Datetime__Previous
		)
		SELECT
			  HK_L_Employee_Reporting_Line
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Employee__Direct_Report__DK
			, Start_Datetime
			, HK_L_Employee_Reporting_Line__Previous
			, DV_Load_Datetime__Previous
		FROM
			Data_Vault.bv.v_stage_S_LE_L_Employee_Reporting_Line_Northwind__L2_Northwind_Employees;

	END
GO




-- usp_insert_S_LE_L_Order_Header_Northwind__L2_Northwind_Orders

DROP PROCEDURE IF EXISTS bv.usp_insert_S_LE_L_Order_Header_Northwind__L2_Northwind_Orders;
GO

CREATE PROCEDURE bv.usp_insert_S_LE_L_Order_Header_Northwind__L2_Northwind_Orders
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_LE_L_Order_Header_Northwind (  
			  HK_L_Order_Header
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Order__DK
			, Start_Datetime
			, HK_L_Order_Header__Previous
			, DV_Load_Datetime__Previous
		)
		SELECT
			  HK_L_Order_Header
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Order__DK
			, Start_Datetime
			, HK_L_Order_Header__Previous
			, DV_Load_Datetime__Previous
		FROM
			Data_Vault.bv.v_stage_S_LE_L_Order_Header_Northwind__L2_Northwind_Orders;

	END
GO




-- usp_insert_S_LE_L_Product_Category_Northwind__L2_Northwind_Products

DROP PROCEDURE IF EXISTS bv.usp_insert_S_LE_L_Product_Category_Northwind__L2_Northwind_Products;
GO

CREATE PROCEDURE bv.usp_insert_S_LE_L_Product_Category_Northwind__L2_Northwind_Products
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_LE_L_Product_Category_Northwind (  
			  HK_L_Product_Category
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Product__DK
			, Start_Datetime
			, HK_L_Product_Category__Previous
			, DV_Load_Datetime__Previous
		)
		SELECT
			  HK_L_Product_Category
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Product__DK
			, Start_Datetime
			, HK_L_Product_Category__Previous
			, DV_Load_Datetime__Previous
		FROM
			Data_Vault.bv.v_stage_S_LE_L_Product_Category_Northwind__L2_Northwind_Products;

	END
GO




-- usp_insert_S_LE_L_Product_Supplier_Northwind__L2_Northwind_Products

DROP PROCEDURE IF EXISTS bv.usp_insert_S_LE_L_Product_Supplier_Northwind__L2_Northwind_Products;
GO

CREATE PROCEDURE bv.usp_insert_S_LE_L_Product_Supplier_Northwind__L2_Northwind_Products
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_LE_L_Product_Supplier_Northwind (  
			  HK_L_Product_Supplier
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Product__DK
			, Start_Datetime
			, HK_L_Product_Supplier__Previous
			, DV_Load_Datetime__Previous
		)
		SELECT
			  HK_L_Product_Supplier
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Product__DK
			, Start_Datetime
			, HK_L_Product_Supplier__Previous
			, DV_Load_Datetime__Previous
		FROM
			Data_Vault.bv.v_stage_S_LE_L_Product_Supplier_Northwind__L2_Northwind_Products;

	END
GO




-- usp_insert_S_LE_L_Territory_Region_Northwind__L2_Northwind_Territories

DROP PROCEDURE IF EXISTS bv.usp_insert_S_LE_L_Territory_Region_Northwind__L2_Northwind_Territories;
GO

CREATE PROCEDURE bv.usp_insert_S_LE_L_Territory_Region_Northwind__L2_Northwind_Territories
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_LE_L_Territory_Region_Northwind (  
			  HK_L_Territory_Region
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Territory__DK
			, Start_Datetime
			, HK_L_Territory_Region__Previous
			, DV_Load_Datetime__Previous
		)
		SELECT
			  HK_L_Territory_Region
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Territory__DK
			, Start_Datetime
			, HK_L_Territory_Region__Previous
			, DV_Load_Datetime__Previous
		FROM
			Data_Vault.bv.v_stage_S_LE_L_Territory_Region_Northwind__L2_Northwind_Territories;

	END
GO