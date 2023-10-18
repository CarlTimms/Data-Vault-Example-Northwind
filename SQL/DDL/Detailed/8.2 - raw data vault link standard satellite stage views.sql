/*

	Raw data vault link standard satellite stage views

*/


USE Data_Vault;
GO


-- v_stage_S_L_Order_Detail_Northwind__L2_Northwind_Order_Details

DROP VIEW IF EXISTS rv.v_stage_S_L_Order_Detail_Northwind__L2_Northwind_Order_Details;
GO

CREATE VIEW rv.v_stage_S_L_Order_Detail_Northwind__L2_Northwind_Order_Details (
	  HK_L_Order_Detail
	, DV_Load_Datetime
	, DV_Record_Source
	, HD_S_L_Order_Detail_Northwind
	, UnitPrice
	, Quantity
	, Discount
)
AS
SELECT DISTINCT
	  stage.HK_L_Order_Detail
	, stage.DV_Load_Datetime
	, stage.DV_Record_Source
	, stage.HD_S_L_Order_Detail_Northwind
	, stage.UnitPrice
	, stage.Quantity
	, stage.Discount
FROM
	Staging.northwind.L2_Northwind_Order_Details AS stage
		LEFT OUTER JOIN Data_Vault.rv.S_L_Order_Detail_Northwind AS sat1
			ON stage.HK_L_Order_Detail = sat1.HK_L_Order_Detail
		   AND sat1.DV_Load_Datetime = (
					SELECT
						MAX(sat2.DV_Load_Datetime)
					FROM
						Data_Vault.rv.S_L_Order_Detail_Northwind AS sat2
					WHERE
						sat1.HK_L_Order_Detail = sat2.HK_L_Order_Detail
				)
WHERE
	sat1.HK_L_Order_Detail IS NULL
	OR (
		stage.HK_L_Order_Detail = sat1.HK_L_Order_Detail
		AND stage.HD_S_L_Order_Detail_Northwind <> sat1.HD_S_L_Order_Detail_Northwind
	);
GO