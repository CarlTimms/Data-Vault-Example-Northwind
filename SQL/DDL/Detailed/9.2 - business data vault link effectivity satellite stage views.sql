/*

	Business data vault link effectivity satellite stage views

*/


USE Data_Vault;
GO


-- v_stage_S_LE_L_Employee_Reporting_Line_Northwind__L2_Northwind_Employees

DROP VIEW IF EXISTS bv.v_stage_S_LE_L_Employee_Reporting_Line_Northwind__L2_Northwind_Employees;
GO

CREATE VIEW bv.v_stage_S_LE_L_Employee_Reporting_Line_Northwind__L2_Northwind_Employees
(  
	  HK_L_Employee_Reporting_Line
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Employee__Direct_Report__DK
	, Start_Datetime
	, HK_L_Employee_Reporting_Line__Previous
	, DV_Load_Datetime__Previous
)
AS
SELECT DISTINCT 
	  stage.HK_L_Employee_Reporting_Line
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, stage.DV_Record_Source
	, stage.HK_H_Employee AS HK_H_Employee__Direct_Report__DK
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS Start_Datetime
	, sat1.HK_L_Employee_Reporting_Line AS HK_L_Employee_Reporting_Line__Previous
	, sat1.DV_Load_Datetime AS DV_Load_Datetime__Previous
FROM
	Staging.northwind.L2_Northwind_Employees AS stage
		LEFT OUTER JOIN Data_Vault.bv.S_LE_L_Employee_Reporting_Line_Northwind AS sat1
			ON stage.HK_H_Employee = sat1.HK_H_Employee__Direct_Report__DK
		   AND sat1.DV_Load_Datetime = (
					SELECT
						MAX(sat2.DV_Load_Datetime)
					FROM
						Data_Vault.bv.S_LE_L_Employee_Reporting_Line_Northwind AS sat2
					WHERE
						sat1.HK_H_Employee__Direct_Report__DK = sat2.HK_H_Employee__Direct_Report__DK 
				)
WHERE
	sat1.HK_L_Employee_Reporting_Line IS NULL
	OR (
		stage.HK_H_Employee = sat1.HK_H_Employee__Direct_Report__DK
		AND stage.HK_L_Employee_Reporting_Line <> sat1.HK_L_Employee_Reporting_Line
	);
GO



-- v_stage_S_LE_L_Order_Header_Northwind__L2_Northwind_Orders

DROP VIEW IF EXISTS bv.v_stage_S_LE_L_Order_Header_Northwind__L2_Northwind_Orders;
GO

CREATE VIEW bv.v_stage_S_LE_L_Order_Header_Northwind__L2_Northwind_Orders
(  
	  HK_L_Order_Header
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Order__DK
	, Start_Datetime
	, HK_L_Order_Header__Previous
	, DV_Load_Datetime__Previous
)
AS
SELECT DISTINCT 
	  stage.HK_L_Order_Header
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, stage.DV_Record_Source
	, stage.HK_H_Order AS HK_H_Order__DK
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS Start_Datetime
	, sat1.HK_L_Order_Header AS HK_L_Order_Header__Previous
	, sat1.DV_Load_Datetime AS DV_Load_Datetime__Previous
FROM
	Staging.northwind.L2_Northwind_Orders AS stage
		LEFT OUTER JOIN Data_Vault.bv.S_LE_L_Order_Header_Northwind AS sat1
			ON stage.HK_H_Order = sat1.HK_H_Order__DK
		   AND sat1.DV_Load_Datetime = (
					SELECT
						MAX(sat2.DV_Load_Datetime)
					FROM
						Data_Vault.bv.S_LE_L_Order_Header_Northwind AS sat2
					WHERE
						sat1.HK_H_Order__DK = sat2.HK_H_Order__DK 
				)
WHERE
	sat1.HK_L_Order_Header IS NULL
	OR (
		stage.HK_H_Order = sat1.HK_H_Order__DK
		AND stage.HK_L_Order_Header <> sat1.HK_L_Order_Header
	);
GO




-- v_stage_S_LE_L_Product_Category_Northwind__L2_Northwind_Products

DROP VIEW IF EXISTS bv.v_stage_S_LE_L_Product_Category_Northwind__L2_Northwind_Products;
GO

CREATE VIEW bv.v_stage_S_LE_L_Product_Category_Northwind__L2_Northwind_Products
(  
	  HK_L_Product_Category
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Product__DK
	, Start_Datetime
	, HK_L_Product_Category__Previous
	, DV_Load_Datetime__Previous
)
AS
SELECT DISTINCT
	  stage.HK_L_Product_Category
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, stage.DV_Record_Source
	, stage.HK_H_Product AS HK_H_Product__DK
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS Start_Datetime
	, sat1.HK_L_Product_Category AS HK_L_Product_Category__Previous
	, sat1.DV_Load_Datetime AS DV_Load_Datetime__Previous
FROM
	Staging.northwind.L2_Northwind_Products AS stage
		LEFT OUTER JOIN Data_Vault.bv.S_LE_L_Product_Category_Northwind AS sat1
			ON stage.HK_H_Product = sat1.HK_H_Product__DK
		   AND sat1.DV_Load_Datetime = (
					SELECT
						MAX(sat2.DV_Load_Datetime)
					FROM
						Data_Vault.bv.S_LE_L_Product_Category_Northwind AS sat2
					WHERE
						sat1.HK_H_Product__DK = sat2.HK_H_Product__DK 
				)
WHERE
	sat1.HK_L_Product_Category IS NULL
	OR (
		stage.HK_H_Product = sat1.HK_H_Product__DK
		AND stage.HK_L_Product_Category <> sat1.HK_L_Product_Category
	);
GO




-- v_stage_S_LE_L_Product_Supplier_Northwind__L2_Northwind_Products

DROP VIEW IF EXISTS bv.v_stage_S_LE_L_Product_Supplier_Northwind__L2_Northwind_Products;
GO

CREATE VIEW bv.v_stage_S_LE_L_Product_Supplier_Northwind__L2_Northwind_Products
(  
	  HK_L_Product_Supplier
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Product__DK
	, Start_Datetime
	, HK_L_Product_Supplier__Previous
	, DV_Load_Datetime__Previous
)
AS
SELECT DISTINCT
	  stage.HK_L_Product_Supplier
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, stage.DV_Record_Source
	, stage.HK_H_Product AS HK_H_Product__DK
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS Start_Datetime
	, sat1.HK_L_Product_Supplier AS HK_L_Product_Supplier__Previous
	, sat1.DV_Load_Datetime AS DV_Load_Datetime__Previous
FROM
	Staging.northwind.L2_Northwind_Products AS stage
		LEFT OUTER JOIN Data_Vault.bv.S_LE_L_Product_Supplier_Northwind AS sat1
			ON stage.HK_H_Product = sat1.HK_H_Product__DK
		   AND sat1.DV_Load_Datetime = (
					SELECT
						MAX(sat2.DV_Load_Datetime)
					FROM
						Data_Vault.bv.S_LE_L_Product_Supplier_Northwind AS sat2
					WHERE
						sat1.HK_H_Product__DK = sat2.HK_H_Product__DK 
				)
WHERE
	sat1.HK_L_Product_Supplier IS NULL
	OR (
		stage.HK_H_Product = sat1.HK_H_Product__DK
		AND stage.HK_L_Product_Supplier <> sat1.HK_L_Product_Supplier
	);
GO




-- v_stage_S_LE_L_Territory_Region_Northwind__L2_Northwind_Territories

DROP VIEW IF EXISTS bv.v_stage_S_LE_L_Territory_Region_Northwind__L2_Northwind_Territories;
GO

CREATE VIEW bv.v_stage_S_LE_L_Territory_Region_Northwind__L2_Northwind_Territories
(  
	  HK_L_Territory_Region
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Territory__DK
	, Start_Datetime
	, HK_L_Territory_Region__Previous
	, DV_Load_Datetime__Previous
)
AS
SELECT DISTINCT 
	  stage.HK_L_Territory_Region
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, stage.DV_Record_Source
	, stage.HK_H_Territory AS HK_H_Territory__DK
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS Start_Datetime
	, sat1.HK_L_Territory_Region AS HK_L_Territory_Region__Previous
	, sat1.DV_Load_Datetime AS DV_Load_Datetime__Previous
FROM
	Staging.northwind.L2_Northwind_Territories AS stage
		LEFT OUTER JOIN Data_Vault.bv.S_LE_L_Territory_Region_Northwind AS sat1
			ON stage.HK_H_Territory = sat1.HK_H_Territory__DK
		   AND sat1.DV_Load_Datetime = (
					SELECT
						MAX(sat2.DV_Load_Datetime)
					FROM
						Data_Vault.bv.S_LE_L_Territory_Region_Northwind AS sat2
					WHERE
						sat1.HK_H_Territory__DK = sat2.HK_H_Territory__DK 
				)
WHERE
	sat1.HK_L_Territory_Region IS NULL
	OR (
		stage.HK_H_Territory = sat1.HK_H_Territory__DK
		AND stage.HK_L_Territory_Region <> sat1.HK_L_Territory_Region
	);
GO