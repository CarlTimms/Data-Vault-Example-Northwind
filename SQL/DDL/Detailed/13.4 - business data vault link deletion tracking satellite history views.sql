/*

	Business data vault hub deletion tracking satellite history views 

*/


USE Data_Vault;
GO


-- v_history_S_LDT_L_Customer_Type_Northwind

DROP VIEW IF EXISTS bv.v_history_S_LDT_L_Customer_Type_Northwind;
GO

CREATE VIEW bv.v_history_S_LDT_L_Customer_Type_Northwind (
	  HK_L_Customer_Type
	, DV_Load_Datetime_Start
	, DV_Load_Datetime_End
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
AS
SELECT
	  HK_L_Customer_Type
	, DV_Load_Datetime AS DV_Load_Datetime_Start
	, LEAD(DATEADD(NS, -100, DV_Load_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_L_Customer_Type ORDER BY DV_Load_Datetime ASC) AS DV_Load_Datetime_End
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
FROM
	Data_Vault.bv.S_LDT_L_Customer_Type_Northwind;
GO




-- v_history_S_LDT_L_Employee_Territory_Northwind

DROP VIEW IF EXISTS bv.v_history_S_LDT_L_Employee_Territory_Northwind;
GO

CREATE VIEW bv.v_history_S_LDT_L_Employee_Territory_Northwind (
	  HK_L_Employee_Territory
	, DV_Load_Datetime_Start
	, DV_Load_Datetime_End
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
AS
SELECT
	  HK_L_Employee_Territory
	, DV_Load_Datetime AS DV_Load_Datetime_Start
	, LEAD(DATEADD(NS, -100, DV_Load_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_L_Employee_Territory ORDER BY DV_Load_Datetime ASC) AS DV_Load_Datetime_End
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
FROM
	Data_Vault.bv.S_LDT_L_Employee_Territory_Northwind;
GO




-- v_history_S_LDT_L_Order_Detail_Northwind

DROP VIEW IF EXISTS bv.v_history_S_LDT_L_Order_Detail_Northwind;
GO

CREATE VIEW bv.v_history_S_LDT_L_Order_Detail_Northwind (
	  HK_L_Order_Detail
	, DV_Load_Datetime_Start
	, DV_Load_Datetime_End
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
AS
SELECT
	  HK_L_Order_Detail
	, DV_Load_Datetime AS DV_Load_Datetime_Start
	, LEAD(DATEADD(NS, -100, DV_Load_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_L_Order_Detail ORDER BY DV_Load_Datetime ASC) AS DV_Load_Datetime_End
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
FROM
	Data_Vault.bv.S_LDT_L_Order_Detail_Northwind;
GO