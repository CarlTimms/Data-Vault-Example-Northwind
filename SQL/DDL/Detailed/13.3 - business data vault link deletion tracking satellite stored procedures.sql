/*

	Business data vault link deletion tracking satellite stored procedures

*/


USE Data_Vault;
GO


-- usp_insert_S_LDT_L_Customer_Type_Northwind__S_LRT_L_Customer_Type_Northwind

DROP PROCEDURE IF EXISTS bv.usp_insert_S_LDT_L_Customer_Type_Northwind__S_LRT_L_Customer_Type_Northwind;
GO

CREATE PROCEDURE bv.usp_insert_S_LDT_L_Customer_Type_Northwind__S_LRT_L_Customer_Type_Northwind
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_LDT_L_Customer_Type_Northwind (
			  HK_L_Customer_Type
			, DV_Load_Datetime
			, DV_Record_Source
			, Is_Deleted_Flag
			, Deleted_Datetime
		)
		SELECT
			  HK_L_Customer_Type
			, DV_Load_Datetime
			, DV_Record_Source
			, Is_Deleted_Flag
			, Deleted_Datetime			 
		FROM
			Data_Vault.bv.v_stage_S_LDT_L_Customer_Type_Northwind__S_LRT_L_Customer_Type_Northwind;

	END
GO




-- usp_insert_S_LDT_L_Employee_Territory_Northwind__S_LRT_L_Employee_Territory_Northwind

DROP PROCEDURE IF EXISTS bv.usp_insert_S_LDT_L_Employee_Territory_Northwind__S_LRT_L_Employee_Territory_Northwind;
GO

CREATE PROCEDURE bv.usp_insert_S_LDT_L_Employee_Territory_Northwind__S_LRT_L_Employee_Territory_Northwind
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_LDT_L_Employee_Territory_Northwind (
			  HK_L_Employee_Territory
			, DV_Load_Datetime
			, DV_Record_Source
			, Is_Deleted_Flag
			, Deleted_Datetime
		)
		SELECT
			  HK_L_Employee_Territory
			, DV_Load_Datetime
			, DV_Record_Source
			, Is_Deleted_Flag
			, Deleted_Datetime
		FROM
			Data_Vault.bv.v_stage_S_LDT_L_Employee_Territory_Northwind__S_LRT_L_Employee_Territory_Northwind;

	END
GO




-- usp_insert_S_LDT_L_Order_Detail_Northwind__S_LRT_L_Order_Detail_Northwind

DROP PROCEDURE IF EXISTS bv.usp_insert_S_LDT_L_Order_Detail_Northwind__S_LRT_L_Order_Detail_Northwind;
GO

CREATE PROCEDURE bv.usp_insert_S_LDT_L_Order_Detail_Northwind__S_LRT_L_Order_Detail_Northwind
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_LDT_L_Order_Detail_Northwind (
			  HK_L_Order_Detail
			, DV_Load_Datetime
			, DV_Record_Source
			, Is_Deleted_Flag
			, Deleted_Datetime
		)
		SELECT
			  HK_L_Order_Detail
			, DV_Load_Datetime
			, DV_Record_Source
			, Is_Deleted_Flag
			, Deleted_Datetime
		FROM
			Data_Vault.bv.v_stage_S_LDT_L_Order_Detail_Northwind__S_LRT_L_Order_Detail_Northwind;

	END
GO