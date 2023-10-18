/*

	Business data vault hub record tracking satellite stage views


	NB: I am not aware of any official examples demonstrating how to load a record tracking satellite,
	    though their form is described in 'Building a Data Warehouse with Data Vault 2.0'.

		This hopefully represents a reasonable attempt.
		Note the inclusion of the last seen datetime field, no longer permitted to be included in
		hubs and links according to DV2.0 standards, but entirely at home in the RTS satellite 
		in my opinion. This enables easy implementation of data aging rules downstream to
		define deleted business keys.

	NB: At the time of writing, CDVP2 materials only mention the use of a type of calculated status tracking
		satellite for this purpose (Record Source Tracking / Deleted Status Satellite), though no meaningful
		implementation details were provided, hence the use of record tracking satellites here.
	    
*/


USE Data_Vault;
GO
 

-- v_stage_S_LRT_L_Customer_Type_Northwind__L2_Northwind_CustomerCustomerDemo

DROP VIEW IF EXISTS bv.v_stage_S_LRT_L_Customer_Type_Northwind__L2_Northwind_CustomerCustomerDemo;
GO

CREATE VIEW bv.v_stage_S_LRT_L_Customer_Type_Northwind__L2_Northwind_CustomerCustomerDemo (
	  HK_L_Customer_Type
	, DV_Load_Datetime
	, DV_Record_Source
	, Appearance_Flag
	, Last_Seen_Datetime
)
AS
SELECT DISTINCT
	  key_set.HK_L_Customer_Type
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, COALESCE(stage.DV_Record_Source, 'SYSTEM') AS DV_Record_Source
	, CASE
		WHEN stage.HK_L_Customer_Type IS NOT NULL THEN 1
		ELSE 0
	  END AS Appearance_Flag
	, COALESCE(stage.DV_Load_Datetime, sat1.Last_Seen_Datetime) AS Last_Seen_Datetime
FROM
	(
		SELECT
			HK_L_Customer_Type
		FROM
			Staging.northwind.L2_Northwind_CustomerCustomerDemo
		UNION
		SELECT
			HK_L_Customer_Type
		FROM
			Data_Vault.rv.L_Customer_Type
	) AS key_set
		LEFT JOIN Staging.northwind.L2_Northwind_CustomerCustomerDemo AS stage
			ON key_set.HK_L_Customer_Type = stage.HK_L_Customer_Type
		LEFT JOIN bv.S_LRT_L_Customer_Type_Northwind AS sat1 
			ON key_set.HK_L_Customer_Type = sat1.HK_L_Customer_Type
		   AND sat1.DV_Load_Datetime = (
					SELECT
						MAX(sat2.DV_Load_Datetime)
					FROM
						bv.S_LRT_L_Customer_Type_Northwind AS sat2
					WHERE
						sat1.HK_L_Customer_Type = sat2.HK_L_Customer_Type
				)
WHERE
	key_set.HK_L_Customer_Type NOT IN (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
	);
GO




-- v_stage_S_LRT_L_Employee_Territory_Northwind__L2_Northwind_EmployeeTerritories

DROP VIEW IF EXISTS bv.v_stage_S_LRT_L_Employee_Territory_Northwind__L2_Northwind_EmployeeTerritories;
GO

CREATE VIEW bv.v_stage_S_LRT_L_Employee_Territory_Northwind__L2_Northwind_EmployeeTerritories (
	  HK_L_Employee_Territory
	, DV_Load_Datetime
	, DV_Record_Source
	, Appearance_Flag
	, Last_Seen_Datetime
)
AS
SELECT DISTINCT
	  key_set.HK_L_Employee_Territory
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, COALESCE(stage.DV_Record_Source, 'SYSTEM') AS DV_Record_Source
	, CASE
		WHEN stage.HK_L_Employee_Territory IS NOT NULL THEN 1
		ELSE 0
	  END AS Appearance_Flag
	, COALESCE(stage.DV_Load_Datetime, sat1.Last_Seen_Datetime) AS Last_Seen_Datetime
FROM
	(
		SELECT
			HK_L_Employee_Territory
		FROM
			Staging.northwind.L2_Northwind_EmployeeTerritories
		UNION
		SELECT
			HK_L_Employee_Territory
		FROM
			Data_Vault.rv.L_Employee_Territory
	) AS key_set
		LEFT JOIN Staging.northwind.L2_Northwind_EmployeeTerritories AS stage
			ON key_set.HK_L_Employee_Territory = stage.HK_L_Employee_Territory
		LEFT JOIN bv.S_LRT_L_Employee_Territory_Northwind AS sat1 
			ON key_set.HK_L_Employee_Territory = sat1.HK_L_Employee_Territory
		   AND sat1.DV_Load_Datetime = (
					SELECT
						MAX(sat2.DV_Load_Datetime)
					FROM
						bv.S_LRT_L_Employee_Territory_Northwind AS sat2
					WHERE
						sat1.HK_L_Employee_Territory = sat2.HK_L_Employee_Territory
				)
WHERE
	key_set.HK_L_Employee_Territory NOT IN (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
	);
GO




-- v_stage_S_LRT_L_Order_Detail_Northwind__L2_Northwind_Order_Details

DROP VIEW IF EXISTS bv.v_stage_S_LRT_L_Order_Detail_Northwind__L2_Northwind_Order_Details;
GO

CREATE VIEW bv.v_stage_S_LRT_L_Order_Detail_Northwind__L2_Northwind_Order_Details (
	  HK_L_Order_Detail
	, DV_Load_Datetime
	, DV_Record_Source
	, Appearance_Flag
	, Last_Seen_Datetime
)
AS
SELECT DISTINCT
	  key_set.HK_L_Order_Detail
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, COALESCE(stage.DV_Record_Source, 'SYSTEM') AS DV_Record_Source
	, CASE
		WHEN stage.HK_L_Order_Detail IS NOT NULL THEN 1
		ELSE 0
	  END AS Appearance_Flag
	, COALESCE(stage.DV_Load_Datetime, sat1.Last_Seen_Datetime) AS Last_Seen_Datetime
FROM
	(
		SELECT
			HK_L_Order_Detail
		FROM
			Staging.northwind.L2_Northwind_Order_Details
		UNION
		SELECT
			HK_L_Order_Detail
		FROM
			Data_Vault.rv.L_Order_Detail
	) AS key_set
		LEFT JOIN Staging.northwind.L2_Northwind_Order_Details AS stage
			ON key_set.HK_L_Order_Detail = stage.HK_L_Order_Detail
		LEFT JOIN bv.S_LRT_L_Order_Detail_Northwind AS sat1 
			ON key_set.HK_L_Order_Detail = sat1.HK_L_Order_Detail
		   AND sat1.DV_Load_Datetime = (
					SELECT
						MAX(sat2.DV_Load_Datetime)
					FROM
						bv.S_LRT_L_Order_Detail_Northwind AS sat2
					WHERE
						sat1.HK_L_Order_Detail = sat2.HK_L_Order_Detail
				)
WHERE
	key_set.HK_L_Order_Detail NOT IN (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
	);
GO