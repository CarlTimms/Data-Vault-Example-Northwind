/* 

	business data vault link standard satellite history views

*/


USE Data_Vault;
GO


-- v_history_S_L_Order_Detail_Northwind

DROP VIEW IF EXISTS bv.v_history_S_L_Order_Detail_Northwind;
GO

CREATE VIEW bv.v_history_S_L_Order_Detail_Northwind (
	  HK_L_Order_Detail
	, DV_Load_Datetime_Start
	, DV_Load_Datetime_End
	, DV_Record_Source
	, HD_S_L_Order_Detail_Northwind
	, UnitPrice
	, Quantity
	, Discount
)
AS
SELECT
	  HK_L_Order_Detail
	, DV_Load_Datetime AS DV_Load_Datetime_Start
	, LEAD(DATEADD(NS, -100, DV_Load_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_L_Order_Detail ORDER BY DV_Load_Datetime ASC) AS DV_Load_Datetime_End
	, DV_Record_Source
	, HD_S_L_Order_Detail_Northwind
	, UnitPrice
	, Quantity
	, Discount
FROM
	Data_Vault.rv.S_L_Order_Detail_Northwind;
GO