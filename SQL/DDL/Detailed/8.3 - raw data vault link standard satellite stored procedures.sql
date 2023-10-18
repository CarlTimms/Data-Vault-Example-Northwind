/*

	Raw data vault link standard satellite stored procedures

*/


USE Data_Vault;
GO


-- usp_insert_S_L_Order_Detail_Northwind__L2_Northwind_Order_Details

DROP PROCEDURE IF EXISTS rv.usp_insert_S_L_Order_Detail_Northwind__L2_Northwind_Order_Details;
GO

CREATE PROCEDURE rv.usp_insert_S_L_Order_Detail_Northwind__L2_Northwind_Order_Details 
AS
	BEGIN

		INSERT INTO Data_Vault.rv.S_L_Order_Detail_Northwind (
			  HK_L_Order_Detail
			, DV_Load_Datetime
			, DV_Record_Source
			, HD_S_L_Order_Detail_Northwind
			, UnitPrice
			, Quantity
			, Discount
		)
		SELECT 
			  HK_L_Order_Detail
			, DV_Load_Datetime
			, DV_Record_Source
			, HD_S_L_Order_Detail_Northwind
			, UnitPrice
			, Quantity
			, Discount
		FROM
			Data_Vault.rv.v_stage_S_L_Order_Detail_Northwind__L2_Northwind_Order_Details;

	END
GO
