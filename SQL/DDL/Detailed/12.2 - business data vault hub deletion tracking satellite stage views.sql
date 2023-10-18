/*

	Business data vault hub deletion tracking satellite stage views

	If not seen for more than 24 hours, a key is marked as deleted

*/


USE Data_Vault;
GO


-- v_stage_S_HDT_H_Customer_Northwind__S_HRT_H_Customer_Northwind

DROP VIEW IF EXISTS bv.v_stage_S_HDT_H_Customer_Northwind__S_HRT_H_Customer_Northwind;
GO

CREATE VIEW bv.v_stage_S_HDT_H_Customer_Northwind__S_HRT_H_Customer_Northwind (
	  HK_H_Customer
	, DV_Load_Datetime
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
AS
WITH 
	cte_stage AS (
		SELECT
			  HK_H_Customer
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
			Data_Vault.bv.v_history_S_HRT_H_Customer_Northwind
		WHERE
			SYSUTCDATETIME() AT TIME ZONE 'UTC' BETWEEN DV_Load_Datetime_Start AND DV_Load_Datetime_End
	)

	SELECT
		  stage.HK_H_Customer
		, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
		, stage.DV_Record_Source
		, stage.Is_Deleted_Flag
		, stage.Deleted_Datetime
	FROM
		cte_stage AS stage
			LEFT JOIN Data_Vault.bv.S_HDT_H_Customer_Northwind AS sat1
				ON stage.HK_H_Customer = sat1.HK_H_Customer
			   AND sat1.DV_Load_Datetime = (
						SELECT
							MAX(sat2.DV_Load_Datetime)
						FROM
							Data_Vault.bv.S_HDT_H_Customer_Northwind AS sat2
						WHERE
							sat1.HK_H_Customer = sat2.HK_H_Customer
					)
	WHERE
		sat1.HK_H_Customer IS NULL
		OR (
			stage.HK_H_Customer = sat1.HK_H_Customer
			AND stage.Is_Deleted_Flag <> sat1.Is_Deleted_Flag
		);
GO




-- v_stage_S_HDT_H_Customer_Type_Northwind__S_HRT_H_Customer_Type_Northwind

DROP VIEW IF EXISTS bv.v_stage_S_HDT_H_Customer_Type_Northwind__S_HRT_H_Customer_Type_Northwind;
GO

CREATE VIEW bv.v_stage_S_HDT_H_Customer_Type_Northwind__S_HRT_H_Customer_Type_Northwind (
	  HK_H_Customer_Type
	, DV_Load_Datetime
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
AS
WITH 
	cte_stage AS (
		SELECT
			  HK_H_Customer_Type
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
			Data_Vault.bv.v_history_S_HRT_H_Customer_Type_Northwind
		WHERE
			SYSUTCDATETIME() AT TIME ZONE 'UTC' BETWEEN DV_Load_Datetime_Start AND DV_Load_Datetime_End
	)

	SELECT
		  stage.HK_H_Customer_Type
		, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
		, stage.DV_Record_Source
		, stage.Is_Deleted_Flag
		, stage.Deleted_Datetime
	FROM
		cte_stage AS stage
			LEFT JOIN Data_Vault.bv.S_HDT_H_Customer_Type_Northwind AS sat1
				ON stage.HK_H_Customer_Type = sat1.HK_H_Customer_Type
			   AND sat1.DV_Load_Datetime = (
						SELECT
							MAX(sat2.DV_Load_Datetime)
						FROM
							Data_Vault.bv.S_HDT_H_Customer_Type_Northwind AS sat2
						WHERE
							sat1.HK_H_Customer_Type= sat2.HK_H_Customer_Type
					)
	WHERE
		sat1.HK_H_Customer_Type IS NULL
		OR (
			stage.HK_H_Customer_Type = sat1.HK_H_Customer_Type
			AND stage.Is_Deleted_Flag <> sat1.Is_Deleted_Flag
		);
GO




-- v_stage_S_HDT_H_Employee_Northwind__S_HRT_H_Employee_Northwind

DROP VIEW IF EXISTS bv.v_stage_S_HDT_H_Employee_Northwind__S_HRT_H_Employee_Northwind;
GO

CREATE VIEW bv.v_stage_S_HDT_H_Employee_Northwind__S_HRT_H_Employee_Northwind (
	  HK_H_Employee
	, DV_Load_Datetime
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
AS
WITH 
	cte_stage AS (
		SELECT
			  HK_H_Employee
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
			Data_Vault.bv.v_history_S_HRT_H_Employee_Northwind
		WHERE
			SYSUTCDATETIME() AT TIME ZONE 'UTC' BETWEEN DV_Load_Datetime_Start AND DV_Load_Datetime_End
	)

	SELECT
		  stage.HK_H_Employee
		, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
		, stage.DV_Record_Source
		, stage.Is_Deleted_Flag
		, stage.Deleted_Datetime
	FROM
		cte_stage AS stage
			LEFT JOIN Data_Vault.bv.S_HDT_H_Employee_Northwind AS sat1
				ON stage.HK_H_Employee = sat1.HK_H_Employee
			   AND sat1.DV_Load_Datetime = (
						SELECT
							MAX(sat2.DV_Load_Datetime)
						FROM
							Data_Vault.bv.S_HDT_H_Employee_Northwind AS sat2
						WHERE
							sat1.HK_H_Employee= sat2.HK_H_Employee
					)
	WHERE
		sat1.HK_H_Employee IS NULL
		OR (
			stage.HK_H_Employee = sat1.HK_H_Employee
			AND stage.Is_Deleted_Flag <> sat1.Is_Deleted_Flag
		);
GO




-- v_stage_S_HDT_H_Order_Northwind__S_HRT_H_Order_Northwind

DROP VIEW IF EXISTS bv.v_stage_S_HDT_H_Order_Northwind__S_HRT_H_Order_Northwind;
GO

CREATE VIEW bv.v_stage_S_HDT_H_Order_Northwind__S_HRT_H_Order_Northwind (
	  HK_H_Order
	, DV_Load_Datetime
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
AS
WITH 
	cte_stage AS (
		SELECT
			  HK_H_Order
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
			Data_Vault.bv.v_history_S_HRT_H_Order_Northwind
		WHERE
			SYSUTCDATETIME() AT TIME ZONE 'UTC' BETWEEN DV_Load_Datetime_Start AND DV_Load_Datetime_End
	)

	SELECT
		  stage.HK_H_Order
		, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
		, stage.DV_Record_Source
		, stage.Is_Deleted_Flag
		, stage.Deleted_Datetime
	FROM
		cte_stage AS stage
			LEFT JOIN Data_Vault.bv.S_HDT_H_Order_Northwind AS sat1
				ON stage.HK_H_Order = sat1.HK_H_Order
			   AND sat1.DV_Load_Datetime = (
						SELECT
							MAX(sat2.DV_Load_Datetime)
						FROM
							Data_Vault.bv.S_HDT_H_Order_Northwind AS sat2
						WHERE
							sat1.HK_H_Order= sat2.HK_H_Order
					)
	WHERE
		sat1.HK_H_Order IS NULL
		OR (
			stage.HK_H_Order = sat1.HK_H_Order
			AND stage.Is_Deleted_Flag <> sat1.Is_Deleted_Flag
		);
GO




-- v_stage_S_HDT_H_Product_Category_Northwind__S_HRT_H_Product_Category_Northwind

DROP VIEW IF EXISTS bv.v_stage_S_HDT_H_Product_Category_Northwind__S_HRT_H_Product_Category_Northwind;
GO

CREATE VIEW bv.v_stage_S_HDT_H_Product_Category_Northwind__S_HRT_H_Product_Category_Northwind (
	  HK_H_Product_Category
	, DV_Load_Datetime
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
AS
WITH 
	cte_stage AS (
		SELECT
			  HK_H_Product_Category
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
			Data_Vault.bv.v_history_S_HRT_H_Product_Category_Northwind
		WHERE
			SYSUTCDATETIME() AT TIME ZONE 'UTC' BETWEEN DV_Load_Datetime_Start AND DV_Load_Datetime_End
	)

	SELECT
		  stage.HK_H_Product_Category
		, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
		, stage.DV_Record_Source
		, stage.Is_Deleted_Flag
		, stage.Deleted_Datetime
	FROM
		cte_stage AS stage
			LEFT JOIN Data_Vault.bv.S_HDT_H_Product_Category_Northwind AS sat1
				ON stage.HK_H_Product_Category = sat1.HK_H_Product_Category
			   AND sat1.DV_Load_Datetime = (
						SELECT
							MAX(sat2.DV_Load_Datetime)
						FROM
							Data_Vault.bv.S_HDT_H_Product_Category_Northwind AS sat2
						WHERE
							sat1.HK_H_Product_Category = sat2.HK_H_Product_Category
					)
	WHERE
		sat1.HK_H_Product_Category IS NULL
		OR (
			stage.HK_H_Product_Category = sat1.HK_H_Product_Category
			AND stage.Is_Deleted_Flag <> sat1.Is_Deleted_Flag
		);
GO	




-- v_stage_S_HDT_H_Product_Northwind__S_HRT_H_Product_Northwind

DROP VIEW IF EXISTS bv.v_stage_S_HDT_H_Product_Northwind__S_HRT_H_Product_Northwind;
GO

CREATE VIEW bv.v_stage_S_HDT_H_Product_Northwind__S_HRT_H_Product_Northwind (
	  HK_H_Product
	, DV_Load_Datetime
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
AS
WITH 
	cte_stage AS (
		SELECT
			  HK_H_Product
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
			Data_Vault.bv.v_history_S_HRT_H_Product_Northwind
		WHERE
			SYSUTCDATETIME() AT TIME ZONE 'UTC' BETWEEN DV_Load_Datetime_Start AND DV_Load_Datetime_End
	)

	SELECT
		  stage.HK_H_Product
		, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
		, stage.DV_Record_Source
		, stage.Is_Deleted_Flag
		, stage.Deleted_Datetime
	FROM
		cte_stage AS stage
			LEFT JOIN Data_Vault.bv.S_HDT_H_Product_Northwind AS sat1
				ON stage.HK_H_Product = sat1.HK_H_Product
			   AND sat1.DV_Load_Datetime = (
						SELECT
							MAX(sat2.DV_Load_Datetime)
						FROM
							Data_Vault.bv.S_HDT_H_Product_Northwind AS sat2
						WHERE
							sat1.HK_H_Product = sat2.HK_H_Product
					)
	WHERE
		sat1.HK_H_Product IS NULL
		OR (
			stage.HK_H_Product = sat1.HK_H_Product
			AND stage.Is_Deleted_Flag <> sat1.Is_Deleted_Flag
		);
GO	




-- v_stage_S_HDT_H_Region_Northwind__S_HRT_H_Region_Northwind

DROP VIEW IF EXISTS bv.v_stage_S_HDT_H_Region_Northwind__S_HRT_H_Region_Northwind;
GO

CREATE VIEW bv.v_stage_S_HDT_H_Region_Northwind__S_HRT_H_Region_Northwind (
	  HK_H_Region
	, DV_Load_Datetime
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
AS
WITH 
	cte_stage AS (
		SELECT
			  HK_H_Region
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
			Data_Vault.bv.v_history_S_HRT_H_Region_Northwind
		WHERE
			SYSUTCDATETIME() AT TIME ZONE 'UTC' BETWEEN DV_Load_Datetime_Start AND DV_Load_Datetime_End
	)

	SELECT
		  stage.HK_H_Region
		, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
		, stage.DV_Record_Source
		, stage.Is_Deleted_Flag
		, stage.Deleted_Datetime
	FROM
		cte_stage AS stage
			LEFT JOIN Data_Vault.bv.S_HDT_H_Region_Northwind AS sat1
				ON stage.HK_H_Region = sat1.HK_H_Region
			   AND sat1.DV_Load_Datetime = (
						SELECT
							MAX(sat2.DV_Load_Datetime)
						FROM
							Data_Vault.bv.S_HDT_H_Region_Northwind AS sat2
						WHERE
							sat1.HK_H_Region = sat2.HK_H_Region
					)
	WHERE
		sat1.HK_H_Region IS NULL
		OR (
			stage.HK_H_Region = sat1.HK_H_Region
			AND stage.Is_Deleted_Flag <> sat1.Is_Deleted_Flag
		);
GO	




-- v_stage_S_HDT_H_Shipper_Northwind__S_HRT_H_Shipper_Northwind

DROP VIEW IF EXISTS bv.v_stage_S_HDT_H_Shipper_Northwind__S_HRT_H_Shipper_Northwind;
GO

CREATE VIEW bv.v_stage_S_HDT_H_Shipper_Northwind__S_HRT_H_Shipper_Northwind (
	  HK_H_Shipper
	, DV_Load_Datetime
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
AS
WITH 
	cte_stage AS (
		SELECT
			  HK_H_Shipper
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
			Data_Vault.bv.v_history_S_HRT_H_Shipper_Northwind
		WHERE
			SYSUTCDATETIME() AT TIME ZONE 'UTC' BETWEEN DV_Load_Datetime_Start AND DV_Load_Datetime_End
	)

	SELECT
		  stage.HK_H_Shipper
		, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
		, stage.DV_Record_Source
		, stage.Is_Deleted_Flag
		, stage.Deleted_Datetime
	FROM
		cte_stage AS stage
			LEFT JOIN Data_Vault.bv.S_HDT_H_Shipper_Northwind AS sat1
				ON stage.HK_H_Shipper = sat1.HK_H_Shipper
			   AND sat1.DV_Load_Datetime = (
						SELECT
							MAX(sat2.DV_Load_Datetime)
						FROM
							Data_Vault.bv.S_HDT_H_Shipper_Northwind AS sat2
						WHERE
							sat1.HK_H_Shipper= sat2.HK_H_Shipper
					)
	WHERE
		sat1.HK_H_Shipper IS NULL
		OR (
			stage.HK_H_Shipper = sat1.HK_H_Shipper
			AND stage.Is_Deleted_Flag <> sat1.Is_Deleted_Flag
		);
GO	




-- v_stage_S_HDT_H_Supplier_Northwind__S_HRT_H_Supplier_Northwind

DROP VIEW IF EXISTS bv.v_stage_S_HDT_H_Supplier_Northwind__S_HRT_H_Supplier_Northwind;
GO

CREATE VIEW bv.v_stage_S_HDT_H_Supplier_Northwind__S_HRT_H_Supplier_Northwind (
	  HK_H_Supplier
	, DV_Load_Datetime
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
AS
WITH 
	cte_stage AS (
		SELECT
			  HK_H_Supplier
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
			Data_Vault.bv.v_history_S_HRT_H_Supplier_Northwind
		WHERE
			SYSUTCDATETIME() AT TIME ZONE 'UTC' BETWEEN DV_Load_Datetime_Start AND DV_Load_Datetime_End
	)

	SELECT
		  stage.HK_H_Supplier
		, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
		, stage.DV_Record_Source
		, stage.Is_Deleted_Flag
		, stage.Deleted_Datetime
	FROM
		cte_stage AS stage
			LEFT JOIN Data_Vault.bv.S_HDT_H_Supplier_Northwind AS sat1
				ON stage.HK_H_Supplier = sat1.HK_H_Supplier
			   AND sat1.DV_Load_Datetime = (
						SELECT
							MAX(sat2.DV_Load_Datetime)
						FROM
							Data_Vault.bv.S_HDT_H_Supplier_Northwind AS sat2
						WHERE
							sat1.HK_H_Supplier = sat2.HK_H_Supplier
					)
	WHERE
		sat1.HK_H_Supplier IS NULL
		OR (
			stage.HK_H_Supplier = sat1.HK_H_Supplier
			AND stage.Is_Deleted_Flag <> sat1.Is_Deleted_Flag
		);
GO	




-- v_stage_S_HDT_H_Territory_Northwind__S_HRT_H_Territory_Northwind

DROP VIEW IF EXISTS bv.v_stage_S_HDT_H_Territory_Northwind__S_HRT_H_Territory_Northwind;
GO

CREATE VIEW bv.v_stage_S_HDT_H_Territory_Northwind__S_HRT_H_Territory_Northwind (
	  HK_H_Territory
	, DV_Load_Datetime
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
AS
WITH 
	cte_stage AS (
		SELECT
			  HK_H_Territory
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
			Data_Vault.bv.v_history_S_HRT_H_Territory_Northwind
		WHERE
			SYSUTCDATETIME() AT TIME ZONE 'UTC' BETWEEN DV_Load_Datetime_Start AND DV_Load_Datetime_End
	)

	SELECT
		  stage.HK_H_Territory
		, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
		, stage.DV_Record_Source
		, stage.Is_Deleted_Flag
		, stage.Deleted_Datetime
	FROM
		cte_stage AS stage
			LEFT JOIN Data_Vault.bv.S_HDT_H_Territory_Northwind AS sat1
				ON stage.HK_H_Territory = sat1.HK_H_Territory
			   AND sat1.DV_Load_Datetime = (
						SELECT
							MAX(sat2.DV_Load_Datetime)
						FROM
							Data_Vault.bv.S_HDT_H_Territory_Northwind AS sat2
						WHERE
							sat1.HK_H_Territory= sat2.HK_H_Territory
					)
	WHERE
		sat1.HK_H_Territory IS NULL
		OR (
			stage.HK_H_Territory = sat1.HK_H_Territory
			AND stage.Is_Deleted_Flag <> sat1.Is_Deleted_Flag
		);
GO	