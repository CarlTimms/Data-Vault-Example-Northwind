/*

	Business data vault link deletion tracking satellite stage views

*/


USE Data_Vault;
GO


-- v_stage_S_LDT_L_Customer_Type_Northwind__S_LRT_L_Customer_Type_Northwind

DROP VIEW IF EXISTS bv.v_stage_S_LDT_L_Customer_Type_Northwind__S_LRT_L_Customer_Type_Northwind;
GO

CREATE VIEW bv.v_stage_S_LDT_L_Customer_Type_Northwind__S_LRT_L_Customer_Type_Northwind (
	  HK_L_Customer_Type
	, DV_Load_Datetime
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
AS
WITH
	cte_stage AS (
		SELECT 
			  HK_L_Customer_Type
			, DV_Load_Datetime_Start
			, DV_Load_Datetime_End
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
			, CASE
				WHEN DV_Load_Datetime_Start > DATEADD(HOUR, 24, Last_Seen_Datetime) THEN 1
				ELSE 0
				END AS Is_Deleted_Flag
			, CASE
				WHEN DV_Load_Datetime_Start > DATEADD(HOUR, 24, Last_Seen_Datetime) THEN DATEADD(HOUR, 24, Last_Seen_Datetime)
				ELSE NULL
				END AS Deleted_Datetime
		FROM
			Data_Vault.bv.v_history_S_LRT_L_Customer_Type_Northwind
		WHERE
			SYSUTCDATETIME() AT TIME ZONE 'UTC' BETWEEN DV_Load_Datetime_Start AND DV_Load_Datetime_End
	)

	SELECT
		  stage.HK_L_Customer_Type
		, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
		, stage.DV_Record_Source
		, stage.Is_Deleted_Flag
		, stage.Deleted_Datetime
	FROM
		cte_stage AS stage
			LEFT JOIN Data_Vault.bv.S_LDT_L_Customer_Type_Northwind AS sat1
				ON stage.HK_L_Customer_Type = sat1.HK_L_Customer_Type
			   AND sat1.DV_Load_Datetime = (
						SELECT
							MAX(sat2.DV_Load_Datetime)
						FROM
							Data_Vault.bv.S_LDT_L_Customer_Type_Northwind AS sat2
						WHERE
							sat1.HK_L_Customer_Type = sat2.HK_L_Customer_Type
						
					)
		WHERE
			sat1.HK_L_Customer_Type IS NULL
			OR (
				stage.HK_L_Customer_Type = sat1.HK_L_Customer_Type
				AND stage.Is_Deleted_Flag <> sat1.Is_Deleted_Flag
			);
GO




-- v_stage_S_LDT_L_Employee_Territory_Northwind__S_LRT_L_Employee_Territory_Northwind

DROP VIEW IF EXISTS bv.v_stage_S_LDT_L_Employee_Territory_Northwind__S_LRT_L_Employee_Territory_Northwind;
GO

CREATE VIEW bv.v_stage_S_LDT_L_Employee_Territory_Northwind__S_LRT_L_Employee_Territory_Northwind (
	  HK_L_Employee_Territory
	, DV_Load_Datetime
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
AS
WITH
	cte_stage AS (
		SELECT 
			  HK_L_Employee_Territory
			, DV_Load_Datetime_Start
			, DV_Load_Datetime_End
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
			, CASE
				WHEN DV_Load_Datetime_Start > DATEADD(HOUR, 24, Last_Seen_Datetime) THEN 1
				ELSE 0
				END AS Is_Deleted_Flag
			, CASE
				WHEN DV_Load_Datetime_Start > DATEADD(HOUR, 24, Last_Seen_Datetime) THEN DATEADD(HOUR, 24, Last_Seen_Datetime)
				ELSE NULL
				END AS Deleted_Datetime
		FROM
			Data_Vault.bv.v_history_S_LRT_L_Employee_Territory_Northwind
		WHERE
			SYSUTCDATETIME() AT TIME ZONE 'UTC' BETWEEN DV_Load_Datetime_Start AND DV_Load_Datetime_End
	)

	SELECT
		  stage.HK_L_Employee_Territory
		, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
		, stage.DV_Record_Source
		, stage.Is_Deleted_Flag
		, stage.Deleted_Datetime
	FROM
		cte_stage AS stage
			LEFT JOIN Data_Vault.bv.S_LDT_L_Employee_Territory_Northwind AS sat1
				ON stage.HK_L_Employee_Territory = sat1.HK_L_Employee_Territory
			   AND sat1.DV_Load_Datetime = (
						SELECT
							MAX(sat2.DV_Load_Datetime)
						FROM
							Data_Vault.bv.S_LDT_L_Employee_Territory_Northwind AS sat2
						WHERE
							sat1.HK_L_Employee_Territory = sat2.HK_L_Employee_Territory	
					)
		WHERE
			sat1.HK_L_Employee_Territory IS NULL
			OR (
				stage.HK_L_Employee_Territory = sat1.HK_L_Employee_Territory
				AND stage.Is_Deleted_Flag <> sat1.Is_Deleted_Flag
			);
GO




-- v_stage_S_LDT_L_Order_Detail_Northwind__S_LRT_L_Order_Detail_Northwind

DROP VIEW IF EXISTS bv.v_stage_S_LDT_L_Order_Detail_Northwind__S_LRT_L_Order_Detail_Northwind;
GO

CREATE VIEW bv.v_stage_S_LDT_L_Order_Detail_Northwind__S_LRT_L_Order_Detail_Northwind (
	  HK_L_Order_Detail
	, DV_Load_Datetime
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
AS
WITH
	cte_stage AS (
		SELECT 
			  HK_L_Order_Detail
			, DV_Load_Datetime_Start
			, DV_Load_Datetime_End
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
			, CASE
				WHEN DV_Load_Datetime_Start > DATEADD(HOUR, 24, Last_Seen_Datetime) THEN 1
				ELSE 0
				END AS Is_Deleted_Flag
			, CASE
				WHEN DV_Load_Datetime_Start > DATEADD(HOUR, 24, Last_Seen_Datetime) THEN DATEADD(HOUR, 24, Last_Seen_Datetime)
				ELSE NULL
				END AS Deleted_Datetime
		FROM
			Data_Vault.bv.v_history_S_LRT_L_Order_Detail_Northwind
		WHERE
			SYSUTCDATETIME() AT TIME ZONE 'UTC' BETWEEN DV_Load_Datetime_Start AND DV_Load_Datetime_End
	)

	SELECT
		  stage.HK_L_Order_Detail
		, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
		, stage.DV_Record_Source
		, stage.Is_Deleted_Flag
		, stage.Deleted_Datetime
	FROM
		cte_stage AS stage
			LEFT JOIN Data_Vault.bv.S_LDT_L_Order_Detail_Northwind AS sat1
				ON stage.HK_L_Order_Detail = sat1.HK_L_Order_Detail
			   AND sat1.DV_Load_Datetime = (
						SELECT
							MAX(sat2.DV_Load_Datetime)
						FROM
							Data_Vault.bv.S_LDT_L_Order_Detail_Northwind AS sat2
						WHERE
							sat1.HK_L_Order_Detail = sat2.HK_L_Order_Detail
						
					)
		WHERE
			sat1.HK_L_Order_Detail IS NULL
			OR (
				stage.HK_L_Order_Detail = sat1.HK_L_Order_Detail
				AND stage.Is_Deleted_Flag <> sat1.Is_Deleted_Flag
			);
GO