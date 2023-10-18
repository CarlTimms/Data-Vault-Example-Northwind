/*

	Business data vault hub deletion tracking satellite stored procedures

*/


USE Data_Vault;
GO


-- usp_insert_S_HDT_H_Customer_Northwind__S_HRT_H_Customer_Northwind

DROP PROCEDURE IF EXISTS bv.usp_insert_S_HDT_H_Customer_Northwind__S_HRT_H_Customer_Northwind;
GO

CREATE PROCEDURE bv.usp_insert_S_HDT_H_Customer_Northwind__S_HRT_H_Customer_Northwind
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_HDT_H_Customer_Northwind (
			  HK_H_Customer
			, DV_Load_Datetime
			, DV_Record_Source
			, Is_Deleted_Flag
			, Deleted_Datetime
		)
		SELECT
			  HK_H_Customer
			, DV_Load_Datetime
			, DV_Record_Source
			, Is_Deleted_Flag
			, Deleted_Datetime
		FROM
			Data_Vault.bv.v_stage_S_HDT_H_Customer_Northwind__S_HRT_H_Customer_Northwind;

	END
GO




-- S_HDT_H_Customer_Type_Northwind__S_HRT_H_Customer_Type_Northwind

DROP PROCEDURE IF EXISTS bv.usp_insert_S_HDT_H_Customer_Type_Northwind__S_HRT_H_Customer_Type_Northwind;
GO

CREATE PROCEDURE bv.usp_insert_S_HDT_H_Customer_Type_Northwind__S_HRT_H_Customer_Type_Northwind
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_HDT_H_Customer_Type_Northwind (
			  [HK_H_Customer_Type]
			, [DV_Load_Datetime]
			, [DV_Record_Source]
			, [Is_Deleted_Flag]
			, [Deleted_Datetime]
		)
		SELECT
			  [HK_H_Customer_Type]
			, [DV_Load_Datetime]
			, [DV_Record_Source]
			, [Is_Deleted_Flag]
			, [Deleted_Datetime]
		FROM
			Data_Vault.bv.v_stage_S_HDT_H_Customer_Type_Northwind__S_HRT_H_Customer_Type_Northwind;

	END
GO




-- S_HDT_H_Employee_Northwind__S_HRT_H_Employee_Northwind

DROP PROCEDURE IF EXISTS bv.usp_insert_S_HDT_H_Employee_Northwind__S_HRT_H_Employee_Northwind;
GO

CREATE PROCEDURE bv.usp_insert_S_HDT_H_Employee_Northwind__S_HRT_H_Employee_Northwind
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_HDT_H_Employee_Northwind (
			  [HK_H_Employee]
			, [DV_Load_Datetime]
			, [DV_Record_Source]
			, [Is_Deleted_Flag]
			, [Deleted_Datetime]
		)
		SELECT
			  [HK_H_Employee]
			, [DV_Load_Datetime]
			, [DV_Record_Source]
			, [Is_Deleted_Flag]
			, [Deleted_Datetime]
		FROM
			Data_Vault.bv.v_stage_S_HDT_H_Employee_Northwind__S_HRT_H_Employee_Northwind;

	END
GO




-- S_HDT_H_Order_Northwind__S_HRT_H_Order_Northwind

DROP PROCEDURE IF EXISTS bv.usp_insert_S_HDT_H_Order_Northwind__S_HRT_H_Order_Northwind;
GO

CREATE PROCEDURE bv.usp_insert_S_HDT_H_Order_Northwind__S_HRT_H_Order_Northwind
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_HDT_H_Order_Northwind (
			  [HK_H_Order]
			, [DV_Load_Datetime]
			, [DV_Record_Source]
			, [Is_Deleted_Flag]
			, [Deleted_Datetime]
		)
		SELECT
			  [HK_H_Order]
			, [DV_Load_Datetime]
			, [DV_Record_Source]
			, [Is_Deleted_Flag]
			, [Deleted_Datetime]
		FROM
			Data_Vault.bv.v_stage_S_HDT_H_Order_Northwind__S_HRT_H_Order_Northwind;

	END
GO




-- S_HDT_H_Product_Category_Northwind__S_HRT_H_Product_Category_Northwind

DROP PROCEDURE IF EXISTS bv.usp_insert_S_HDT_H_Product_Category_Northwind__S_HRT_H_Product_Category_Northwind;
GO

CREATE PROCEDURE bv.usp_insert_S_HDT_H_Product_Category_Northwind__S_HRT_H_Product_Category_Northwind
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_HDT_H_Product_Category_Northwind (
			  [HK_H_Product_Category]
			, [DV_Load_Datetime]
			, [DV_Record_Source]
			, [Is_Deleted_Flag]
			, [Deleted_Datetime]
		)
		SELECT
			  [HK_H_Product_Category]
			, [DV_Load_Datetime]
			, [DV_Record_Source]
			, [Is_Deleted_Flag]
			, [Deleted_Datetime]			  
		FROM
			Data_Vault.bv.v_stage_S_HDT_H_Product_Category_Northwind__S_HRT_H_Product_Category_Northwind;

	END
GO




-- S_HDT_H_Product_Northwind__S_HRT_H_Product_Northwind

DROP PROCEDURE IF EXISTS bv.usp_insert_S_HDT_H_Product_Northwind__S_HRT_H_Product_Northwind;
GO

CREATE PROCEDURE bv.usp_insert_S_HDT_H_Product_Northwind__S_HRT_H_Product_Northwind
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_HDT_H_Product_Northwind (
			  [HK_H_Product]
			, [DV_Load_Datetime]
			, [DV_Record_Source]
			, [Is_Deleted_Flag]
			, [Deleted_Datetime]
		)
		SELECT
			  [HK_H_Product]
			, [DV_Load_Datetime]
			, [DV_Record_Source]
			, [Is_Deleted_Flag]
			, [Deleted_Datetime]			  
		FROM
			Data_Vault.bv.v_stage_S_HDT_H_Product_Northwind__S_HRT_H_Product_Northwind;

	END
GO




-- S_HDT_H_Region_Northwind__S_HRT_H_Region_Northwind

DROP PROCEDURE IF EXISTS bv.usp_insert_S_HDT_H_Region_Northwind__S_HRT_H_Region_Northwind;
GO

CREATE PROCEDURE bv.usp_insert_S_HDT_H_Region_Northwind__S_HRT_H_Region_Northwind
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_HDT_H_Region_Northwind (
			  [HK_H_Region]
			, [DV_Load_Datetime]
			, [DV_Record_Source]
			, [Is_Deleted_Flag]
			, [Deleted_Datetime]  
		)
		SELECT
			  [HK_H_Region]
			, [DV_Load_Datetime]
			, [DV_Record_Source]
			, [Is_Deleted_Flag]
			, [Deleted_Datetime]			  
		FROM
			Data_Vault.bv.v_stage_S_HDT_H_Region_Northwind__S_HRT_H_Region_Northwind;

	END
GO




-- S_HDT_H_Shipper_Northwind__S_HRT_H_Shipper_Northwind

DROP PROCEDURE IF EXISTS bv.usp_insert_S_HDT_H_Shipper_Northwind__S_HRT_H_Shipper_Northwind;
GO

CREATE PROCEDURE bv.usp_insert_S_HDT_H_Shipper_Northwind__S_HRT_H_Shipper_Northwind
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_HDT_H_Shipper_Northwind (
			  [HK_H_Shipper]
			, [DV_Load_Datetime]
			, [DV_Record_Source]
			, [Is_Deleted_Flag]
			, [Deleted_Datetime]
		)
		SELECT
			  [HK_H_Shipper]
			, [DV_Load_Datetime]
			, [DV_Record_Source]
			, [Is_Deleted_Flag]
			, [Deleted_Datetime]			  
		FROM
			Data_Vault.bv.v_stage_S_HDT_H_Shipper_Northwind__S_HRT_H_Shipper_Northwind;

	END
GO




-- S_HDT_H_Supplier_Northwind__S_HRT_H_Supplier_Northwind

DROP PROCEDURE IF EXISTS bv.usp_insert_S_HDT_H_Supplier_Northwind__S_HRT_H_Supplier_Northwind;
GO

CREATE PROCEDURE bv.usp_insert_S_HDT_H_Supplier_Northwind__S_HRT_H_Supplier_Northwind
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_HDT_H_Supplier_Northwind (
			  [HK_H_Supplier]
			, [DV_Load_Datetime]
			, [DV_Record_Source]
			, [Is_Deleted_Flag]
			, [Deleted_Datetime]
		)
		SELECT
			  [HK_H_Supplier]
			, [DV_Load_Datetime]
			, [DV_Record_Source]
			, [Is_Deleted_Flag]
			, [Deleted_Datetime]			  
		FROM
			Data_Vault.bv.v_stage_S_HDT_H_Supplier_Northwind__S_HRT_H_Supplier_Northwind;

	END
GO




-- S_HDT_H_Territory_Northwind__S_HRT_H_Territory_Northwind

DROP PROCEDURE IF EXISTS bv.usp_insert_S_HDT_H_Territory_Northwind__S_HRT_H_Territory_Northwind;
GO

CREATE PROCEDURE bv.usp_insert_S_HDT_H_Territory_Northwind__S_HRT_H_Territory_Northwind
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_HDT_H_Territory_Northwind (
			  [HK_H_Territory]
			, [DV_Load_Datetime]
			, [DV_Record_Source]
			, [Is_Deleted_Flag]
			, [Deleted_Datetime]  
		)
		SELECT
			  [HK_H_Territory]
			, [DV_Load_Datetime]
			, [DV_Record_Source]
			, [Is_Deleted_Flag]
			, [Deleted_Datetime] 			  
		FROM
			Data_Vault.bv.v_stage_S_HDT_H_Territory_Northwind__S_HRT_H_Territory_Northwind;

	END
GO