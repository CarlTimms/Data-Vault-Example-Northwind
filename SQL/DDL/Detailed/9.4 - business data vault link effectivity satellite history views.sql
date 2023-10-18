/* 

	Business data vault link effectivity satellite history views

*/


USE Data_Vault;
GO


-- v_history_S_LE_L_Employee_Reporting_Line_Northwind

DROP VIEW IF EXISTS bv.v_history_S_LE_L_Employee_Reporting_Line_Northwind;
GO

CREATE VIEW bv.v_history_S_LE_L_Employee_Reporting_Line_Northwind (
	  HK_L_Employee_Reporting_Line
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Employee__Direct_Report__DK
	, Start_Datetime
	, End_Datetime
	, HK_L_Employee_Reporting_Line__Previous
	, DV_Load_Datetime__Previous
)
AS
SELECT
	  HK_L_Employee_Reporting_Line
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Employee__Direct_Report__DK
	, Start_Datetime
	, LEAD(DATEADD(NS, -100, Start_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_H_Employee__Direct_Report__DK ORDER BY Start_Datetime ASC) AS End_Datetime
	, HK_L_Employee_Reporting_Line__Previous
	, DV_Load_Datetime__Previous
FROM
	Data_Vault.bv.S_LE_L_Employee_Reporting_Line_Northwind;
GO




-- v_history_S_LE_L_Order_Header_Northwind

DROP VIEW IF EXISTS bv.v_history_S_LE_L_Order_Header_Northwind;
GO

CREATE VIEW bv.v_history_S_LE_L_Order_Header_Northwind (
	  HK_L_Order_Header
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Order__DK
	, Start_Datetime
	, End_Datetime
	, HK_L_Order_Header__Previous
	, DV_Load_Datetime__Previous
)
AS
SELECT
	  HK_L_Order_Header
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Order__DK
	, Start_Datetime
	, LEAD(DATEADD(NS, -100, Start_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_H_Order__DK ORDER BY Start_Datetime ASC) AS End_Datetime
	, HK_L_Order_Header__Previous
	, DV_Load_Datetime__Previous
FROM 
	Data_Vault.bv.S_LE_L_Order_Header_Northwind;
GO




-- v_history_S_LE_L_Product_Category_Northwind

DROP VIEW IF EXISTS bv.v_history_S_LE_L_Product_Category_Northwind;
GO

CREATE VIEW bv.v_history_S_LE_L_Product_Category_Northwind (
	  HK_L_Product_Category
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Product__DK
	, Start_Datetime
	, End_Datetime
	, HK_L_Product_Category__Previous
	, DV_Load_Datetime__Previous
)
AS
SELECT
	  HK_L_Product_Category
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Product__DK
	, Start_Datetime
	, LEAD(DATEADD(NS, -100, Start_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_H_Product__DK ORDER BY Start_Datetime ASC) AS End_Datetime
	, HK_L_Product_Category__Previous
	, DV_Load_Datetime__Previous
FROM
	Data_Vault.bv.S_LE_L_Product_Category_Northwind;
GO




-- v_history_S_LE_L_Product_Supplier_Northwind

DROP VIEW IF EXISTS bv.v_history_S_LE_L_Product_Supplier_Northwind;
GO

CREATE VIEW bv.v_history_S_LE_L_Product_Supplier_Northwind (
	  HK_L_Product_Supplier
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Product__DK
	, Start_Datetime
	, End_Datetime
	, HK_L_Product_Supplier__Previous
	, DV_Load_Datetime__Previous
)
AS
SELECT
	  HK_L_Product_Supplier
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Product__DK
	, Start_Datetime
	, LEAD(DATEADD(NS, -100, Start_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_H_Product__DK ORDER BY Start_Datetime ASC) AS End_Datetime
	, HK_L_Product_Supplier__Previous
	, DV_Load_Datetime__Previous
FROM
	Data_Vault.bv.S_LE_L_Product_Supplier_Northwind;
GO




-- v_history_S_LE_L_Territory_Region_Northwind

DROP VIEW IF EXISTS bv.v_history_S_LE_L_Territory_Region_Northwind;
GO

CREATE VIEW bv.v_history_S_LE_L_Territory_Region_Northwind (
	  HK_L_Territory_Region
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Territory__DK
	, Start_Datetime
	, End_Datetime
	, HK_L_Territory_Region__Previous
	, DV_Load_Datetime__Previous
)
AS
SELECT
	  HK_L_Territory_Region
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Territory__DK
	, Start_Datetime
	, LEAD(DATEADD(NS, -100, Start_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_H_Territory__DK ORDER BY Start_Datetime ASC) AS End_Datetime
	, HK_L_Territory_Region__Previous
	, DV_Load_Datetime__Previous
FROM
	Data_Vault.bv.S_LE_L_Territory_Region_Northwind;
GO