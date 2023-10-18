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

 
-- v_stage_S_HRT_H_Customer_Northwind__L2_Northwind_Customers

DROP VIEW IF EXISTS bv.v_stage_S_HRT_H_Customer_Northwind__L2_Northwind_Customers;
GO

CREATE VIEW bv.v_stage_S_HRT_H_Customer_Northwind__L2_Northwind_Customers (
	  HK_H_Customer
	, DV_Load_Datetime
	, DV_Record_Source
	, Appearance_Flag
	, Last_Seen_Datetime
)
AS
SELECT DISTINCT
	  key_set.HK_H_Customer
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, COALESCE(stage.DV_Record_Source, 'SYSTEM') AS DV_Record_Source
	, CASE
		WHEN stage.HK_H_Customer IS NOT NULL THEN 1
		ELSE 0
	  END AS Appearance_Flag
	, COALESCE(stage.DV_Load_Datetime, sat1.Last_Seen_Datetime) AS Last_Seen_Datetime
FROM
	(
		SELECT
			  HK_H_Customer
		FROM
			Staging.northwind.L2_Northwind_Customers
		UNION
		SELECT
			  HK_H_Customer
		FROM
			Data_Vault.rv.H_Customer
	) AS key_set
		LEFT JOIN Staging.northwind.L2_Northwind_Customers AS stage
			ON key_set.HK_H_Customer = stage.HK_H_Customer
		LEFT JOIN bv.S_HRT_H_Customer_Northwind AS sat1 
			ON key_set.HK_H_Customer = sat1.HK_H_Customer
		   AND sat1.DV_Load_Datetime = (
					SELECT
						MAX(sat2.DV_Load_Datetime)
					FROM
						bv.S_HRT_H_Customer_Northwind AS sat2
					WHERE
						sat1.HK_H_Customer = sat2.HK_H_Customer
				)
WHERE
	key_set.HK_H_Customer NOT IN (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
	);
GO




-- v_stage_S_HRT_H_Customer_Type_Northwind__L2_Northwind_CustomerDemographics

DROP VIEW IF EXISTS bv.v_stage_S_HRT_H_Customer_Type_Northwind__L2_Northwind_CustomerDemographics;
GO

CREATE VIEW bv.v_stage_S_HRT_H_Customer_Type_Northwind__L2_Northwind_CustomerDemographics (
	  HK_H_Customer_Type
	, DV_Load_Datetime
	, DV_Record_Source
	, Appearance_Flag
	, Last_Seen_Datetime
)
AS
SELECT DISTINCT
	  key_set.HK_H_Customer_Type
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, COALESCE(stage.DV_Record_Source, 'SYSTEM') AS DV_Record_Source
	, CASE
		WHEN stage.HK_H_Customer_Type IS NOT NULL THEN 1
		ELSE 0
	  END AS Appearance_Flag
	, COALESCE(stage.DV_Load_Datetime, sat1.Last_Seen_Datetime) AS Last_Seen_Datetime
FROM
	(
		SELECT
			  HK_H_Customer_Type
		FROM
			Staging.northwind.L2_Northwind_CustomerDemographics
		UNION
		SELECT
			  HK_H_Customer_Type
		FROM
			Data_Vault.rv.H_Customer_Type
	) AS key_set
		LEFT JOIN Staging.northwind.L2_Northwind_CustomerDemographics AS stage
			ON key_set.HK_H_Customer_Type = stage.HK_H_Customer_Type
		LEFT JOIN bv.S_HRT_H_Customer_Type_Northwind AS sat1 
			ON key_set.HK_H_Customer_Type= sat1.HK_H_Customer_Type
		   AND sat1.DV_Load_Datetime = (
					SELECT
						MAX(sat2.DV_Load_Datetime)
					FROM
						bv.S_HRT_H_Customer_Type_Northwind AS sat2
					WHERE
						sat1.HK_H_Customer_Type = sat2.HK_H_Customer_Type
				)
WHERE
	key_set.HK_H_Customer_Type NOT IN (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
	);
GO




-- v_stage_S_HRT_H_Employee_Northwind__L2_Northwind_Employees

DROP VIEW IF EXISTS bv.v_stage_S_HRT_H_Employee_Northwind__L2_Northwind_Employees;
GO

CREATE VIEW bv.v_stage_S_HRT_H_Employee_Northwind__L2_Northwind_Employees (
	  HK_H_Employee
	, DV_Load_Datetime
	, DV_Record_Source
	, Appearance_Flag
	, Last_Seen_Datetime
)
AS
SELECT DISTINCT
	  key_set.HK_H_Employee
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, COALESCE(stage.DV_Record_Source, 'SYSTEM') AS DV_Record_Source
	, CASE
		WHEN stage.HK_H_Employee IS NOT NULL THEN 1
		ELSE 0
	  END AS Appearance_Flag
	, COALESCE(stage.DV_Load_Datetime, sat1.Last_Seen_Datetime) AS Last_Seen_Datetime
FROM
	(
		SELECT
			  HK_H_Employee
		FROM
			Staging.northwind.L2_Northwind_Employees
		UNION
		SELECT
			  HK_H_Employee
		FROM
			Data_Vault.rv.H_Employee
	) AS key_set
		LEFT JOIN Staging.northwind.L2_Northwind_Employees AS stage
			ON key_set.HK_H_Employee = stage.HK_H_Employee
		LEFT JOIN bv.S_HRT_H_Employee_Northwind AS sat1 
			ON key_set.HK_H_Employee = sat1.HK_H_Employee
		   AND sat1.DV_Load_Datetime = (
					SELECT
						MAX(sat2.DV_Load_Datetime)
					FROM
						bv.S_HRT_H_Employee_Northwind AS sat2
					WHERE
						sat1.HK_H_Employee = sat2.HK_H_Employee
				)
WHERE
	key_set.HK_H_Employee NOT IN (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
	);
GO




-- v_stage_S_HRT_H_Order_Northwind__L2_Northwind_Orders

DROP VIEW IF EXISTS bv.v_stage_S_HRT_H_Order_Northwind__L2_Northwind_Orders;
GO

CREATE VIEW bv.v_stage_S_HRT_H_Order_Northwind__L2_Northwind_Orders (
	  HK_H_Order
	, DV_Load_Datetime
	, DV_Record_Source
	, Appearance_Flag
	, Last_Seen_Datetime
)
AS
SELECT DISTINCT
	  key_set.HK_H_Order
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, COALESCE(stage.DV_Record_Source, 'SYSTEM') AS DV_Record_Source
	, CASE
		WHEN stage.HK_H_Order IS NOT NULL THEN 1
		ELSE 0
	  END AS Appearance_Flag
	, COALESCE(stage.DV_Load_Datetime, sat1.Last_Seen_Datetime) AS Last_Seen_Datetime
FROM
	(
		SELECT
			  HK_H_Order
		FROM
			Staging.northwind.L2_Northwind_Orders
		UNION
		SELECT
			  HK_H_Order
		FROM
			Data_Vault.rv.H_Order
	) AS key_set
		LEFT JOIN Staging.northwind.L2_Northwind_Orders AS stage
			ON key_set.HK_H_Order = stage.HK_H_Order
		LEFT JOIN bv.S_HRT_H_Order_Northwind AS sat1 
			ON key_set.HK_H_Order = sat1.HK_H_Order
		   AND sat1.DV_Load_Datetime = (
					SELECT
						MAX(sat2.DV_Load_Datetime)
					FROM
						bv.S_HRT_H_Order_Northwind AS sat2
					WHERE
						sat1.HK_H_Order = sat2.HK_H_Order
				)
WHERE
	key_set.HK_H_Order NOT IN (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
	);
GO




-- v_stage_S_HRT_H_Product_Category_Northwind__L2_Northwind_Categories

DROP VIEW IF EXISTS bv.v_stage_S_HRT_H_Product_Category_Northwind__L2_Northwind_Categories;
GO

CREATE VIEW bv.v_stage_S_HRT_H_Product_Category_Northwind__L2_Northwind_Categories (
	  HK_H_Product_Category
	, DV_Load_Datetime
	, DV_Record_Source
	, Appearance_Flag
	, Last_Seen_Datetime
)
AS
SELECT DISTINCT
	  key_set.HK_H_Product_Category
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, COALESCE(stage.DV_Record_Source, 'SYSTEM') AS DV_Record_Source
	, CASE
		WHEN stage.HK_H_Product_Category IS NOT NULL THEN 1
		ELSE 0
	  END AS Appearance_Flag
	, COALESCE(stage.DV_Load_Datetime, sat1.Last_Seen_Datetime) AS Last_Seen_Datetime
FROM
	(
		SELECT
			  HK_H_Product_Category
		FROM
			Staging.northwind.L2_Northwind_Categories
		UNION
		SELECT
			  HK_H_Product_Category
		FROM
			Data_Vault.rv.H_Product_Category
	) AS key_set
		LEFT JOIN Staging.northwind.L2_Northwind_Categories AS stage
			ON key_set.HK_H_Product_Category = stage.HK_H_Product_Category
		LEFT JOIN bv.S_HRT_H_Product_Category_Northwind AS sat1 
			ON key_set.HK_H_Product_Category = sat1.HK_H_Product_Category
		   AND sat1.DV_Load_Datetime = (
					SELECT
						MAX(sat2.DV_Load_Datetime)
					FROM
						bv.S_HRT_H_Product_Category_Northwind AS sat2
					WHERE
						sat1.HK_H_Product_Category = sat2.HK_H_Product_Category
				)
WHERE
	key_set.HK_H_Product_Category NOT IN (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
	);
GO




-- v_stage_S_HRT_H_Product_Northwind__L2_Northwind_Products

DROP VIEW IF EXISTS bv.v_stage_S_HRT_H_Product_Northwind__L2_Northwind_Products;
GO

CREATE VIEW bv.v_stage_S_HRT_H_Product_Northwind__L2_Northwind_Products (
	  HK_H_Product
	, DV_Load_Datetime
	, DV_Record_Source
	, Appearance_Flag
	, Last_Seen_Datetime
)
AS
SELECT DISTINCT
	  key_set.HK_H_Product
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, COALESCE(stage.DV_Record_Source, 'SYSTEM') AS DV_Record_Source
	, CASE
		WHEN stage.HK_H_Product IS NOT NULL THEN 1
		ELSE 0
	  END AS Appearance_Flag
	, COALESCE(stage.DV_Load_Datetime, sat1.Last_Seen_Datetime) AS Last_Seen_Datetime
FROM
	(
		SELECT
			  HK_H_Product
		FROM
			Staging.northwind.L2_Northwind_Products
		UNION
		SELECT
			  HK_H_Product
		FROM
			Data_Vault.rv.H_Product
	) AS key_set
		LEFT JOIN Staging.northwind.L2_Northwind_Products AS stage
			ON key_set.HK_H_Product = stage.HK_H_Product
		LEFT JOIN bv.S_HRT_H_Product_Northwind AS sat1 
			ON key_set.HK_H_Product = sat1.HK_H_Product
		   AND sat1.DV_Load_Datetime = (
					SELECT
						MAX(sat2.DV_Load_Datetime)
					FROM
						bv.S_HRT_H_Product_Northwind AS sat2
					WHERE
						sat1.HK_H_Product = sat2.HK_H_Product
				)
WHERE
	key_set.HK_H_Product NOT IN (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
	);
GO




-- v_stage_S_HRT_H_Region_Northwind__L2_Northwind_Region

DROP VIEW IF EXISTS bv.v_stage_S_HRT_H_Region_Northwind__L2_Northwind_Region;
GO

CREATE VIEW bv.v_stage_S_HRT_H_Region_Northwind__L2_Northwind_Region (
	  HK_H_Region
	, DV_Load_Datetime
	, DV_Record_Source
	, Appearance_Flag
	, Last_Seen_Datetime
)
AS
SELECT DISTINCT
	  key_set.HK_H_Region
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, COALESCE(stage.DV_Record_Source, 'SYSTEM') AS DV_Record_Source
	, CASE
		WHEN stage.HK_H_Region IS NOT NULL THEN 1
		ELSE 0
	  END AS Appearance_Flag
	, COALESCE(stage.DV_Load_Datetime, sat1.Last_Seen_Datetime) AS Last_Seen_Datetime
FROM
	(
		SELECT
			  HK_H_Region
		FROM
			Staging.northwind.L2_Northwind_Region
		UNION
		SELECT
			  HK_H_Region
		FROM
			Data_Vault.rv.H_Region
	) AS key_set
		LEFT JOIN Staging.northwind.L2_Northwind_Region AS stage
			ON key_set.HK_H_Region = stage.HK_H_Region
		LEFT JOIN bv.S_HRT_H_Region_Northwind AS sat1 
			ON key_set.HK_H_Region = sat1.HK_H_Region
		   AND sat1.DV_Load_Datetime = (
					SELECT
						MAX(sat2.DV_Load_Datetime)
					FROM
						bv.S_HRT_H_Region_Northwind AS sat2
					WHERE
						sat1.HK_H_Region = sat2.HK_H_Region
				)
WHERE
	key_set.HK_H_Region NOT IN (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
	);
GO




-- v_stage_S_HRT_H_Shipper_Northwind__L2_Northwind_Shippers

DROP VIEW IF EXISTS bv.v_stage_S_HRT_H_Shipper_Northwind__L2_Northwind_Shippers;
GO

CREATE VIEW bv.v_stage_S_HRT_H_Shipper_Northwind__L2_Northwind_Shippers (
	  HK_H_Shipper
	, DV_Load_Datetime
	, DV_Record_Source
	, Appearance_Flag
	, Last_Seen_Datetime
)
AS
SELECT DISTINCT
	  key_set.HK_H_Shipper
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, COALESCE(stage.DV_Record_Source, 'SYSTEM') AS DV_Record_Source
	, CASE
		WHEN stage.HK_H_Shipper IS NOT NULL THEN 1
		ELSE 0
	  END AS Appearance_Flag
	, COALESCE(stage.DV_Load_Datetime, sat1.Last_Seen_Datetime) AS Last_Seen_Datetime
FROM
	(
		SELECT
			  HK_H_Shipper
		FROM
			Staging.northwind.L2_Northwind_Shippers
		UNION
		SELECT
			  HK_H_Shipper
		FROM
			Data_Vault.rv.H_Shipper
	) AS key_set
		LEFT JOIN Staging.northwind.L2_Northwind_Shippers AS stage
			ON key_set.HK_H_Shipper = stage.HK_H_Shipper
		LEFT JOIN bv.S_HRT_H_Shipper_Northwind AS sat1 
			ON key_set.HK_H_Shipper = sat1.HK_H_Shipper
		   AND sat1.DV_Load_Datetime = (
					SELECT
						MAX(sat2.DV_Load_Datetime)
					FROM
						bv.S_HRT_H_Shipper_Northwind AS sat2
					WHERE
						sat1.HK_H_Shipper = sat2.HK_H_Shipper
				)
WHERE
	key_set.HK_H_Shipper NOT IN (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
	);
GO




-- v_stage_S_HRT_H_Supplier_Northwind__L2_Northwind_Suppliers

DROP VIEW IF EXISTS bv.v_stage_S_HRT_H_Supplier_Northwind__L2_Northwind_Suppliers;
GO

CREATE VIEW bv.v_stage_S_HRT_H_Supplier_Northwind__L2_Northwind_Suppliers (
	  HK_H_Supplier
	, DV_Load_Datetime
	, DV_Record_Source
	, Appearance_Flag
	, Last_Seen_Datetime
)
AS
SELECT DISTINCT
	  key_set.HK_H_Supplier
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, COALESCE(stage.DV_Record_Source, 'SYSTEM') AS DV_Record_Source
	, CASE
		WHEN stage.HK_H_Supplier IS NOT NULL THEN 1
		ELSE 0
	  END AS Appearance_Flag
	, COALESCE(stage.DV_Load_Datetime, sat1.Last_Seen_Datetime) AS Last_Seen_Datetime
FROM
	(
		SELECT
			  HK_H_Supplier
		FROM
			Staging.northwind.L2_Northwind_Suppliers
		UNION
		SELECT
			  HK_H_Supplier
		FROM
			Data_Vault.rv.H_Supplier
	) AS key_set
		LEFT JOIN Staging.northwind.L2_Northwind_Suppliers AS stage
			ON key_set.HK_H_Supplier = stage.HK_H_Supplier
		LEFT JOIN bv.S_HRT_H_Supplier_Northwind AS sat1 
			ON key_set.HK_H_Supplier = sat1.HK_H_Supplier
		   AND sat1.DV_Load_Datetime = (
					SELECT
						MAX(sat2.DV_Load_Datetime)
					FROM
						bv.S_HRT_H_Supplier_Northwind AS sat2
					WHERE
						sat1.HK_H_Supplier = sat2.HK_H_Supplier
				)
WHERE
	key_set.HK_H_Supplier NOT IN (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
	);
GO




-- v_stage_S_HRT_H_Territory_Northwind__L2_Northwind_Territories

DROP VIEW IF EXISTS bv.v_stage_S_HRT_H_Territory_Northwind__L2_Northwind_Territories;
GO

CREATE VIEW bv.v_stage_S_HRT_H_Territory_Northwind__L2_Northwind_Territories (
	  HK_H_Territory
	, DV_Load_Datetime
	, DV_Record_Source
	, Appearance_Flag
	, Last_Seen_Datetime
)
AS
SELECT DISTINCT
	  key_set.HK_H_Territory
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, COALESCE(stage.DV_Record_Source, 'SYSTEM') AS DV_Record_Source
	, CASE
		WHEN stage.HK_H_Territory IS NOT NULL THEN 1
		ELSE 0
	  END AS Appearance_Flag
	, COALESCE(stage.DV_Load_Datetime, sat1.Last_Seen_Datetime) AS Last_Seen_Datetime
FROM
	(
		SELECT
			  HK_H_Territory
		FROM
			Staging.northwind.L2_Northwind_Territories
		UNION
		SELECT
			  HK_H_Territory
		FROM
			Data_Vault.rv.H_Territory
	) AS key_set
		LEFT JOIN Staging.northwind.L2_Northwind_Territories AS stage
			ON key_set.HK_H_Territory = stage.HK_H_Territory
		LEFT JOIN bv.S_HRT_H_Territory_Northwind AS sat1 
			ON key_set.HK_H_Territory = sat1.HK_H_Territory
		   AND sat1.DV_Load_Datetime = (
					SELECT
						MAX(sat2.DV_Load_Datetime)
					FROM
						bv.S_HRT_H_Territory_Northwind AS sat2
					WHERE
						sat1.HK_H_Territory = sat2.HK_H_Territory
				)
WHERE
	key_set.HK_H_Territory NOT IN (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
	);
GO