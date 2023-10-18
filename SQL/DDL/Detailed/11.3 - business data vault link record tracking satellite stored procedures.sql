/*

	Business data vault link record tracking satellite stored procedures
 
*/


USE Data_Vault;
GO


/* 
	Insert
*/

-- usp_insert_S_LRT_L_Customer_Type_Northwind__L2_Northwind_CustomerCustomerDemo

DROP PROCEDURE IF EXISTS bv.usp_insert_S_LRT_L_Customer_Type_Northwind__L2_Northwind_CustomerCustomerDemo;
GO

CREATE PROCEDURE bv.usp_insert_S_LRT_L_Customer_Type_Northwind__L2_Northwind_CustomerCustomerDemo
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_LRT_L_Customer_Type_Northwind (
			  HK_L_Customer_Type
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		)
		SELECT
			  HK_L_Customer_Type
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		FROM
			Data_Vault.bv.v_stage_S_LRT_L_Customer_Type_Northwind__L2_Northwind_CustomerCustomerDemo;

	END
GO




-- usp_insert_S_LRT_L_Employee_Territory_Northwind__L2_Northwind_EmployeeTerritories

DROP PROCEDURE IF EXISTS bv.usp_insert_S_LRT_L_Employee_Territory_Northwind__L2_Northwind_EmployeeTerritories;
GO

CREATE PROCEDURE bv.usp_insert_S_LRT_L_Employee_Territory_Northwind__L2_Northwind_EmployeeTerritories
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_LRT_L_Employee_Territory_Northwind (
			  HK_L_Employee_Territory
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		)
		SELECT
			  HK_L_Employee_Territory
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		FROM
			Data_Vault.bv.v_stage_S_LRT_L_Employee_Territory_Northwind__L2_Northwind_EmployeeTerritories;

	END
GO




-- usp_insert_S_LRT_L_Order_Detail_Northwind__L2_Northwind_Order_Details

DROP PROCEDURE IF EXISTS bv.usp_insert_S_LRT_L_Order_Detail_Northwind__L2_Northwind_Order_Details;
GO

CREATE PROCEDURE bv.usp_insert_S_LRT_L_Order_Detail_Northwind__L2_Northwind_Order_Details
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_LRT_L_Order_Detail_Northwind (
			  HK_L_Order_Detail
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		)
		SELECT
			  HK_L_Order_Detail
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		FROM
			Data_Vault.bv.v_stage_S_LRT_L_Order_Detail_Northwind__L2_Northwind_Order_Details;

	END
GO




/* 
	Delete history 
	
	Keep a 7 day load window and ensure the latest loaded record for a given key is always retained regardless of age 	
*/

-- usp_delete_S_LRT_L_Customer_Type_Northwind

DROP PROCEDURE IF EXISTS bv.usp_delete_S_LRT_L_Customer_Type_Northwind;
GO

CREATE PROCEDURE bv.usp_delete_S_LRT_L_Customer_Type_Northwind
AS
	BEGIN

		DELETE FROM
			Data_Vault.bv.S_LRT_L_Customer_Type_Northwind
		WHERE
			S_LRT_L_Customer_Type_Northwind.DV_Load_Datetime <> (
				select
					MAX(sat2.DV_Load_Datetime)
				FROM
					Data_Vault.bv.S_LRT_L_Customer_Type_Northwind AS sat2
				WHERE
					S_LRT_L_Customer_Type_Northwind.HK_L_Customer_Type = sat2.HK_L_Customer_Type
			)
			AND DATEDIFF(DAY, S_LRT_L_Customer_Type_Northwind.DV_Load_Datetime, SYSUTCDATETIME() AT TIME ZONE 'UTC') > 7
			;

	END
GO




-- usp_delete_S_LRT_L_Employee_Territory_Northwind

DROP PROCEDURE IF EXISTS bv.usp_delete_S_LRT_L_Employee_Territory_Northwind;
GO

CREATE PROCEDURE bv.usp_delete_S_LRT_L_Employee_Territory_Northwind
AS
	BEGIN

		DELETE FROM
			Data_Vault.bv.S_LRT_L_Employee_Territory_Northwind
		WHERE
			S_LRT_L_Employee_Territory_Northwind.DV_Load_Datetime <> (
				select
					MAX(sat2.DV_Load_Datetime)
				FROM
					Data_Vault.bv.S_LRT_L_Employee_Territory_Northwind AS sat2
				WHERE
					S_LRT_L_Employee_Territory_Northwind.HK_L_Employee_Territory = sat2.HK_L_Employee_Territory
			)
			AND DATEDIFF(DAY, S_LRT_L_Employee_Territory_Northwind.DV_Load_Datetime, SYSUTCDATETIME() AT TIME ZONE 'UTC') > 7;

	END
GO




-- usp_delete_S_LRT_L_Order_Detail_Northwind

DROP PROCEDURE IF EXISTS bv.usp_delete_S_LRT_L_Order_Detail_Northwind
GO

CREATE PROCEDURE bv.usp_delete_S_LRT_L_Order_Detail_Northwind
AS
	BEGIN

		DELETE FROM
			Data_Vault.bv.S_LRT_L_Order_Detail_Northwind
		WHERE
			S_LRT_L_Order_Detail_Northwind.DV_Load_Datetime <> (
				select
					MAX(sat2.DV_Load_Datetime)
				FROM
					Data_Vault.bv.S_LRT_L_Order_Detail_Northwind AS sat2
				WHERE
					S_LRT_L_Order_Detail_Northwind.HK_L_Order_Detail = sat2.HK_L_Order_Detail
			)
			AND DATEDIFF(DAY, S_LRT_L_Order_Detail_Northwind.DV_Load_Datetime, SYSUTCDATETIME() AT TIME ZONE 'UTC') > 7;

	END
GO