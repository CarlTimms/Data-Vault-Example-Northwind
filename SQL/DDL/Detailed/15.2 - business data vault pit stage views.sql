/*

	Business data vault PIT stage views

*/


USE Information_Mart;
GO


/* Hub PITs */

-- v_stage_PIT_Customer

DROP VIEW IF EXISTS bv.v_stage_PIT_Customer;
GO

CREATE VIEW bv.v_stage_PIT_Customer (
	  DV_Snapshot_Datetime
	, HK_H_Customer
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Customer__S_H_Customer_Northwind
	, DV_Load_Datetime__S_H_Customer_Northwind
	, HK_H_Customer__S_HDT_H_Customer_Northwind
	, DV_Load_Datetime__S_HDT_H_Customer_Northwind
	, CustomerID
	, Is_Deleted_Flag
)
AS
SELECT
	  snap.DV_Snapshot_Datetime
	, hub.HK_H_Customer
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, 'SYSTEM | Information_Mart.bv.v_stage_PIT_Customer' AS DV_Record_Source
	, COALESCE(sat_h.HK_H_Customer, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Customer__S_H_Customer_Northwind
	, COALESCE(sat_h.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_H_Customer_Northwind
	, COALESCE(sat_hdt.HK_H_Customer, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Customer__S_HDT_H_Customer_Northwind
	, COALESCE(sat_hdt.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_HDT_H_Customer_Northwind
	, hub.CustomerID
	, sat_hdt.Is_Deleted_Flag
FROM
	Data_Vault.rv.H_Customer AS hub
		CROSS JOIN Information_Mart.bv.R_Snapshot_Control AS snap	
		LEFT JOIN Data_Vault.bv.v_history_S_H_Customer_Northwind AS sat_h
			ON hub.HK_H_Customer = sat_h.HK_H_Customer
			AND snap.DV_Snapshot_Datetime BETWEEN sat_h.DV_Load_Datetime_Start AND sat_h.DV_Load_Datetime_End
		LEFT JOIN Data_Vault.bv.v_history_S_HDT_H_Customer_Northwind AS sat_hdt
			ON hub.HK_H_Customer = sat_hdt.HK_H_Customer
			AND snap.DV_Snapshot_Datetime BETWEEN sat_hdt.DV_Load_Datetime_Start AND sat_hdt.DV_Load_Datetime_End
WHERE
	NOT EXISTS (
		SELECT
			1
		FROM
			Information_Mart.bv.PIT_Customer AS pit
		WHERE
			snap.DV_Snapshot_Datetime = pit.DV_Snapshot_Datetime
			AND hub.HK_H_Customer = pit.HK_H_Customer
	);
GO




-- v_stage_PIT_Customer_Type

DROP VIEW IF EXISTS bv.v_stage_PIT_Customer_Type;
GO

CREATE VIEW bv.v_stage_PIT_Customer_Type (
	  DV_Snapshot_Datetime
	, HK_H_Customer_Type
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Customer_Type__S_H_Customer_Type_Northwind
	, DV_Load_Datetime__S_H_Customer_Type_Northwind
	, HK_H_Customer_Type__S_HDT_H_Customer_Type_Northwind
	, DV_Load_Datetime__S_HDT_H_Customer_Type_Northwind
	, CustomerTypeID
	, Is_Deleted_Flag
)
AS
SELECT
	  snap.DV_Snapshot_Datetime
	, hub.HK_H_Customer_Type
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, 'SYSTEM | Information_Mart.bv.v_stage_PIT_Customer_Type' AS DV_Record_Source
	, COALESCE(sat_h.HK_H_Customer_Type, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Customer_Type__S_H_Customer_Type_Northwind
	, COALESCE(sat_h.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_H_Customer_Type_Northwind
	, COALESCE(sat_hdt.HK_H_Customer_Type, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Customer_Type__S_HDT_H_Customer_Type_Northwind
	, COALESCE(sat_hdt.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_HDT_H_Customer_Type_Northwind
	, hub.CustomerTypeID
	, sat_hdt.Is_Deleted_Flag
FROM
	Data_Vault.rv.H_Customer_Type AS hub
		CROSS JOIN Information_Mart.bv.R_Snapshot_Control AS snap
		LEFT JOIN Data_Vault.bv.v_history_S_H_Customer_Type_Northwind AS sat_h
			ON hub.HK_H_Customer_Type = sat_h.HK_H_Customer_Type
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_h.DV_Load_Datetime_Start AND sat_h.DV_Load_Datetime_End
		LEFT JOIN Data_Vault.bv.v_history_S_HDT_H_Customer_Type_Northwind AS sat_hdt
			ON hub.HK_H_Customer_Type = sat_hdt.HK_H_Customer_Type
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_hdt.DV_Load_Datetime_Start AND sat_hdt.DV_Load_Datetime_End
WHERE
	NOT EXISTS (
		SELECT
			1
		FROM
			Information_Mart.bv.PIT_Customer_Type AS pit
		WHERE
			snap.DV_Snapshot_Datetime = pit.DV_Snapshot_Datetime
			AND hub.HK_H_Customer_Type = pit.HK_H_Customer_Type
	);
GO




-- v_stage_PIT_Employee

DROP VIEW IF EXISTS bv.v_stage_PIT_Employee;
GO

CREATE VIEW bv.v_stage_PIT_Employee (
	  DV_Snapshot_Datetime
	, HK_H_Employee
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Employee__S_H_Employee_Northwind
	, DV_Load_Datetime__S_H_Employee_Northwind
	, HK_H_Employee__S_HDT_H_Employee_Northwind
	, DV_Load_Datetime__S_HDT_H_Employee_Northwind
	, EmployeeID
	, Employee_Name
	, Is_Deleted_Flag
)
AS
SELECT
	  snap.DV_Snapshot_Datetime
	, hub.HK_H_Employee
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, 'SYSTEM | Information_Mart.bv.v_stage_PIT_Employee' AS DV_Record_Source
	, COALESCE(sat_h.HK_H_Employee, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Employee__S_H_Employee_Northwind
	, COALESCE(sat_h.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_H_Employee_Northwind
	, COALESCE(sat_hdt.HK_H_Employee, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Employee__S_HDT_H_Employee_Northwind
	, COALESCE(sat_hdt.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_HDT_H_Employee_Northwind
	, hub.EmployeeID
	, NULLIF(CONCAT_WS(' ', sat_h.TitleOfCourtesy, sat_h.FirstName, sat_h.LastName), '') AS Employee_Name
	, Is_Deleted_Flag
FROM
	Data_Vault.rv.H_Employee AS hub
		CROSS JOIN Information_Mart.bv.R_Snapshot_Control AS snap
		LEFT JOIN Data_Vault.bv.v_history_S_H_Employee_Northwind AS sat_h
			ON hub.HK_H_Employee = sat_h.HK_H_Employee
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_h.DV_Load_Datetime_Start AND sat_h.DV_Load_Datetime_End
		LEFT JOIN Data_Vault.bv.v_history_S_HDT_H_Employee_Northwind AS sat_hdt
			ON hub.HK_H_Employee = sat_hdt.HK_H_Employee
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_hdt.DV_Load_Datetime_Start AND sat_hdt.DV_Load_Datetime_End
WHERE
	NOT EXISTS (
		SELECT
			1
		FROM
			Information_Mart.bv.PIT_Employee AS pit
		WHERE
			snap.DV_Snapshot_Datetime = pit.DV_Snapshot_Datetime
			AND hub.HK_H_Employee = pit.HK_H_Employee
	);
GO




-- v_stage_PIT_Order

DROP VIEW IF EXISTS bv.v_stage_PIT_Order;
GO

CREATE VIEW bv.v_stage_PIT_Order (
	  DV_Snapshot_Datetime 
	, HK_H_Order 
	, DV_Load_Datetime 
	, DV_Record_Source 
	, HK_H_Order__S_H_Order_Northwind 
	, DV_Load_Datetime__S_H_Order_Northwind 
	, HK_H_Order__S_HDT_H_Order_Northwind 
	, DV_Load_Datetime__S_HDT_H_Order_Northwind 
	, OrderID 
	, Is_Deleted_Flag 
)
AS
SELECT 
	  snap.DV_Snapshot_Datetime 
	, hub.HK_H_Order 
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, 'SYSTEM | Information_Mart.bv.v_stage_PIT_Order' AS DV_Record_Source
	, COALESCE(sat_h.HK_H_Order, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Order__S_H_Order_Northwind 
	, COALESCE(sat_h.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_H_Order_Northwind 
	, COALESCE(sat_hdt.HK_H_Order, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Order__S_HDT_H_Order_Northwind 
	, COALESCE(sat_hdt.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_HDT_H_Order_Northwind 
	, hub.OrderID 
	, sat_hdt.Is_Deleted_Flag 
FROM
	Data_Vault.rv.H_Order AS hub
		CROSS JOIN Information_Mart.bv.R_Snapshot_Control AS snap
		LEFT JOIN Data_Vault.bv.v_history_S_H_Order_Northwind AS sat_h
			ON hub.HK_H_Order = sat_h.HK_H_Order
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_h.DV_Load_Datetime_Start AND sat_h.DV_Load_Datetime_End
		LEFT JOIN Data_Vault.bv.v_history_S_HDT_H_Order_Northwind AS sat_hdt
			ON hub.HK_H_Order = sat_hdt.HK_H_Order
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_hdt.DV_Load_Datetime_Start AND sat_hdt.DV_Load_Datetime_End
WHERE
	NOT EXISTS (
		SELECT
			1
		FROM
			Information_Mart.bv.PIT_Order AS pit
		WHERE
			snap.DV_Snapshot_Datetime = pit.DV_Snapshot_Datetime
			AND hub.HK_H_Order = pit.HK_H_Order
	);
GO




-- v_stage_PIT_Product

DROP VIEW IF EXISTS bv.v_stage_PIT_Product;
GO

CREATE VIEW bv.v_stage_PIT_Product (
	  DV_Snapshot_Datetime 
	, HK_H_Product 
	, DV_Load_Datetime 
	, DV_Record_Source 
	, HK_H_Product__S_H_Product_Northwind 
	, DV_Load_Datetime__S_H_Product_Northwind 
	, HK_H_Product__S_HDT_H_Product_Northwind 
	, DV_Load_Datetime__S_HDT_H_Product_Northwind
	, ProductID 
	, Is_Deleted_Flag 
)
AS
SELECT
	  snap.DV_Snapshot_Datetime 
	, hub.HK_H_Product 
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, 'SYSTEM | Information_Mart.bv.v_stage_PIT_Product' AS DV_Record_Source
	, COALESCE(sat_h.HK_H_Product, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Product__S_H_Product_Northwind 
	, COALESCE(sat_h.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_H_Product_Northwind 
	, COALESCE(sat_hdt.HK_H_Product, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Product__S_HDT_H_Product_Northwind 
	, COALESCE(sat_hdt.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_HDT_H_Product_Northwind
	, hub.ProductID 
	, sat_hdt.Is_Deleted_Flag 
FROM
	Data_Vault.rv.H_Product AS hub
		CROSS JOIN Information_Mart.bv.R_Snapshot_Control AS snap
		LEFT JOIN Data_Vault.bv.v_history_S_H_Product_Northwind AS sat_h
			ON hub.HK_H_Product = sat_h.HK_H_Product
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_h.DV_Load_Datetime_Start AND sat_h.DV_Load_Datetime_End
		LEFT JOIN Data_Vault.bv.v_history_S_HDT_H_Product_Northwind AS sat_hdt
			ON hub.HK_H_Product = sat_hdt.HK_H_Product
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_hdt.DV_Load_Datetime_Start AND sat_hdt.DV_Load_Datetime_End
WHERE
	NOT EXISTS (
		SELECT
			1
		FROM
			Information_Mart.bv.PIT_Product AS pit
		WHERE
			snap.DV_Snapshot_Datetime = pit.DV_Snapshot_Datetime
			AND hub.HK_H_Product = pit.HK_H_Product
	);
GO




-- v_stage_PIT_Product_Category

DROP VIEW IF EXISTS bv.v_stage_PIT_Product_Category;
GO

CREATE VIEW bv.v_stage_PIT_Product_Category (
	  DV_Snapshot_Datetime
	, HK_H_Product_Category
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Product_Category__S_H_Product_Category_Northwind
	, DV_Load_Datetime__S_H_Product_Category_Northwind
	, HK_H_Product_Category__S_HDT_H_Product_Category_Northwind
	, DV_Load_Datetime__S_HDT_H_Product_Category_Northwind
	, CategoryID
	, Is_Deleted_Flag
)
AS
SELECT
	  snap.DV_Snapshot_Datetime
	, hub.HK_H_Product_Category
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, 'SYSTEM | Information_Mart.bv.v_stage_PIT_Product_Category' AS DV_Record_Source
	, COALESCE(sat_h.HK_H_Product_Category, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Product_Category__S_H_Product_Category_Northwind
	, COALESCE(sat_h.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_H_Product_Category_Northwind
	, COALESCE(sat_hdt.HK_H_Product_Category, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Product_Category__S_HDT_H_Product_Category_Northwind
	, COALESCE(sat_hdt.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_HDT_H_Product_Category_Northwind
	, hub.CategoryID
	, sat_hdt.Is_Deleted_Flag
FROM
	Data_Vault.rv.H_Product_Category AS hub
		CROSS JOIN Information_Mart.bv.R_Snapshot_Control AS snap
		LEFT JOIN Data_Vault.bv.v_history_S_H_Product_Category_Northwind AS sat_h
			ON hub.HK_H_Product_Category = sat_h.HK_H_Product_Category
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_h.DV_Load_Datetime_Start AND sat_h.DV_Load_Datetime_End
		LEFT JOIN Data_Vault.bv.v_history_S_HDT_H_Product_Category_Northwind AS sat_hdt
			ON hub.HK_H_Product_Category = sat_hdt.HK_H_Product_Category
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_hdt.DV_Load_Datetime_Start AND sat_hdt.DV_Load_Datetime_End
WHERE
	NOT EXISTS (
		SELECT
			1
		FROM
			Information_Mart.bv.PIT_Product_Category AS pit
		WHERE
			snap.DV_Snapshot_Datetime = pit.DV_Snapshot_Datetime
			AND hub.HK_H_Product_Category = pit.HK_H_Product_Category
	);
GO




-- v_stage_PIT_Region

DROP VIEW IF EXISTS bv.v_stage_PIT_Region;
GO

CREATE VIEW bv.v_stage_PIT_Region (
	  DV_Snapshot_Datetime 
	, HK_H_Region 
	, DV_Load_Datetime 
	, DV_Record_Source 
	, HK_H_Region__S_H_Region_Northwind 
	, DV_Load_Datetime__S_H_Region_Northwind 
	, HK_H_Region__S_HDT_H_Region_Northwind 
	, DV_Load_Datetime__S_HDT_H_Region_Northwind 
	, RegionID 
	, Is_Deleted_Flag 
)
AS
SELECT
	  snap.DV_Snapshot_Datetime 
	, hub.HK_H_Region 
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, 'SYSTEM | Information_Mart.bv.v_stage_PIT_Region' AS DV_Record_Source
	, COALESCE(sat_h.HK_H_Region, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Region__S_H_Region_Northwind 
	, COALESCE(sat_h.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_H_Region_Northwind 
	, COALESCE(sat_hdt.HK_H_Region, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Region__S_HDT_H_Region_Northwind 
	, COALESCE(sat_hdt.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_HDT_H_Region_Northwind 
	, hub.RegionID 
	, sat_hdt.Is_Deleted_Flag
FROM
	Data_Vault.rv.H_Region AS hub
		CROSS JOIN Information_Mart.bv.R_Snapshot_Control AS snap
		LEFT JOIN Data_Vault.bv.v_history_S_H_Region_Northwind AS sat_h
			ON hub.HK_H_Region = sat_h.HK_H_Region
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_h.DV_Load_Datetime_Start AND sat_h.DV_Load_Datetime_End
		LEFT JOIN Data_Vault.bv.v_history_S_HDT_H_Region_Northwind AS sat_hdt
			ON hub.HK_H_Region = sat_hdt.HK_H_Region
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_hdt.DV_Load_Datetime_Start AND sat_hdt.DV_Load_Datetime_End
WHERE
	NOT EXISTS (
		SELECT
			1
		FROM
			Information_Mart.bv.PIT_Region AS pit
		WHERE
			snap.DV_Snapshot_Datetime = pit.DV_Snapshot_Datetime
			AND hub.HK_H_Region = pit.HK_H_Region
	);
GO




-- v_stage_PIT_Shipper

DROP VIEW IF EXISTS bv.v_stage_PIT_Shipper;
GO

CREATE VIEW bv.v_stage_PIT_Shipper (
	  DV_Snapshot_Datetime 
	, HK_H_Shipper 
	, DV_Load_Datetime 
	, DV_Record_Source 
	, HK_H_Shipper__S_H_Shipper_Northwind 
	, DV_Load_Datetime__S_H_Shipper_Northwind 
	, HK_H_Shipper__S_HDT_H_Shipper_Northwind 
	, DV_Load_Datetime__S_HDT_H_Shipper_Northwind 
	, ShipperID 
	, Is_Deleted_Flag 
)
AS
SELECT
	  snap.DV_Snapshot_Datetime 
	, hub.HK_H_Shipper 
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, 'SYSTEM | Information_Mart.bv.v_stage_PIT_Shipper' AS DV_Record_Source
	, COALESCE(sat_h.HK_H_Shipper, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Shipper__S_H_Shipper_Northwind 
	, COALESCE(sat_h.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_H_Shipper_Northwind 
	, COALESCE(sat_hdt.HK_H_Shipper, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Shipper__S_HDT_H_Shipper_Northwind 
	, COALESCE(sat_hdt.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_HDT_H_Shipper_Northwind 
	, hub.ShipperID 
	, sat_hdt.Is_Deleted_Flag 
FROM
	Data_Vault.rv.H_Shipper AS hub
		CROSS JOIN Information_Mart.bv.R_Snapshot_Control AS snap
		LEFT JOIN Data_Vault.bv.v_history_S_H_Shipper_Northwind AS sat_h
			ON hub.HK_H_Shipper = sat_h.HK_H_Shipper
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_h.DV_Load_Datetime_Start AND sat_h.DV_Load_Datetime_End
		LEFT JOIN Data_Vault.bv.v_history_S_HDT_H_Shipper_Northwind AS sat_hdt
			ON hub.HK_H_Shipper = sat_hdt.HK_H_Shipper
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_hdt.DV_Load_Datetime_Start AND sat_hdt.DV_Load_Datetime_End
WHERE
	NOT EXISTS (
		SELECT
			1
		FROM
			Information_Mart.bv.PIT_Shipper AS pit
		WHERE
			snap.DV_Snapshot_Datetime = pit.DV_Snapshot_Datetime
			AND hub.HK_H_Shipper = pit.HK_H_Shipper
	);
GO




-- v_stage_PIT_Supplier

DROP VIEW IF EXISTS bv.v_stage_PIT_Supplier;
GO

CREATE VIEW bv.v_stage_PIT_Supplier (
	  DV_Snapshot_Datetime
	, HK_H_Supplier
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Supplier__S_H_Supplier_Northwind
	, DV_Load_Datetime__S_H_Supplier_Northwind
	, HK_H_Supplier__S_HDT_H_Supplier_Northwind
	, DV_Load_Datetime__S_HDT_H_Supplier_Northwind
	, SupplierID
	, Is_Deleted_Flag
)
AS
SELECT
	  snap.DV_Snapshot_Datetime
	, hub.HK_H_Supplier
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, 'SYSTEM | Information_Mart.bv.v_stage_PIT_Supplier' AS DV_Record_Source
	, COALESCE(sat_h.HK_H_Supplier, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Supplier__S_H_Supplier_Northwind
	, COALESCE(sat_h.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_H_Supplier_Northwind
	, COALESCE(sat_hdt.HK_H_Supplier, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Supplier__S_HDT_H_Supplier_Northwind
	, COALESCE(sat_hdt.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_HDT_H_Supplier_Northwind
	, hub.SupplierID
	, sat_hdt.Is_Deleted_Flag
FROM
	Data_Vault.rv.H_Supplier AS hub
		CROSS JOIN Information_Mart.bv.R_Snapshot_Control AS snap
		LEFT JOIN Data_Vault.bv.v_history_S_H_Supplier_Northwind AS sat_h
			ON hub.HK_H_Supplier = sat_h.HK_H_Supplier
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_h.DV_Load_Datetime_Start AND sat_h.DV_Load_Datetime_End
		LEFT JOIN Data_Vault.bv.v_history_S_HDT_H_Supplier_Northwind AS sat_hdt
			ON hub.HK_H_Supplier = sat_hdt.HK_H_Supplier
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_hdt.DV_Load_Datetime_Start AND sat_hdt.DV_Load_Datetime_End 
WHERE
	NOT EXISTS (
		SELECT
			1
		FROM
			Information_Mart.bv.PIT_Supplier AS pit
		WHERE
			snap.DV_Snapshot_Datetime = pit.DV_Snapshot_Datetime
			AND hub.HK_H_Supplier = pit.HK_H_Supplier
	);
GO




-- v_stage_PIT_Territory

DROP VIEW IF EXISTS bv.v_stage_PIT_Territory;
GO

CREATE VIEW bv.v_stage_PIT_Territory (
	  DV_Snapshot_Datetime
	, HK_H_Territory
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Territory__S_H_Territory_Northwind
	, DV_Load_Datetime__S_H_Territory_Northwind
	, HK_H_Territory__S_HDT_H_Territory_Northwind
	, DV_Load_Datetime__S_HDT_H_Territory_Northwind
	, TerritoryID
	, Is_Deleted_Flag
)
AS
SELECT
	  snap.DV_Snapshot_Datetime
	, hub.HK_H_Territory
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, 'SYSTEM | Information_Mart.bv.v_stage_PIT_Territory' AS DV_Record_Source
	, COALESCE(sat_h.HK_H_Territory, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Territory__S_H_Territory_Northwind
	, COALESCE(sat_h.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_H_Territory_Northwind
	, COALESCE(sat_hdt.HK_H_Territory, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Territory__S_HDT_H_Territory_Northwind
	, COALESCE(sat_hdt.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_HDT_H_Territory_Northwind
	, hub.TerritoryID
	, sat_hdt.Is_Deleted_Flag
FROM
	Data_Vault.rv.H_Territory AS hub
		CROSS JOIN Information_Mart.bv.R_Snapshot_Control AS snap
		LEFT JOIN Data_Vault.bv.v_history_S_H_Territory_Northwind AS sat_h
			ON hub.HK_H_Territory = sat_h.HK_H_Territory
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_h.DV_Load_Datetime_Start AND sat_h.DV_Load_Datetime_End
		LEFT JOIN Data_Vault.bv.v_history_S_HDT_H_Territory_Northwind AS sat_hdt
			ON hub.HK_H_Territory = sat_hdt.HK_H_Territory
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_hdt.DV_Load_Datetime_Start AND sat_hdt.DV_Load_Datetime_End
WHERE
	NOT EXISTS (
		SELECT
			1
		FROM
			Information_Mart.bv.PIT_Territory AS pit
		WHERE
			snap.DV_Snapshot_Datetime = pit.DV_Snapshot_Datetime
			AND hub.HK_H_Territory = pit.HK_H_Territory
	);
GO




/* Link PITs */

-- v_stage_PIT_Order_Detail

DROP VIEW IF EXISTS bv.v_stage_PIT_Order_Detail;
GO

CREATE VIEW bv.v_stage_PIT_Order_Detail (
	  DV_Snapshot_Datetime
	, HK_L_Order_Detail
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_L_Order_Detail__S_L_Order_Detail_Northwind
	, DV_Load_Datetime__S_L_Order_Detail_Northwind
	, HK_L_Order_Detail__S_LDT_L_Order_Detail_Northwind
	, DV_Load_Datetime__S_LDT_L_Order_Detail_Northwind
	, OrderID 
	, ProductID
	, Is_Deleted_Flag
)
AS
SELECT
	  snap.DV_Snapshot_Datetime
	, link.HK_L_Order_Detail
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, 'SYSTEM | Information_Mart.bv.v_stage_PIT_Order_Detail' AS DV_Record_Source
	, COALESCE(sat_l.HK_L_Order_Detail, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_L_Order_Detail__S_L_Order_Detail_Northwind
	, COALESCE(sat_l.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_L_Order_Detail_Northwind
	, COALESCE(sat_ldt.HK_L_Order_Detail, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_L_Order_Detail__S_LDT_L_Order_Detail_Northwind
	, COALESCE(sat_ldt.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_LDT_L_Order_Detail_Northwind
	, hub_order.OrderID 
	, hub_product.ProductID
	, sat_ldt.Is_Deleted_Flag
FROM
	Data_Vault.rv.L_Order_Detail AS link
		CROSS JOIN Information_Mart.bv.R_Snapshot_Control AS snap
		LEFT JOIN Data_Vault.rv.H_Order AS hub_order
			ON link.HK_H_Order = hub_order.HK_H_Order
		LEFT JOIN Data_Vault.rv.H_Product AS hub_product
			ON link.HK_H_Product = hub_product.HK_H_Product
		LEFT JOIN Data_Vault.bv.v_history_S_L_Order_Detail_Northwind AS sat_l
			ON link.HK_L_Order_Detail = sat_l.HK_L_Order_Detail
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_l.DV_Load_Datetime_Start AND sat_l.DV_Load_Datetime_End
		LEFT JOIN Data_Vault.bv.v_history_S_LDT_L_Order_Detail_Northwind AS sat_ldt
			ON link.HK_L_Order_Detail = sat_ldt.HK_L_Order_Detail
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_ldt.DV_Load_Datetime_Start AND sat_ldt.DV_Load_Datetime_End
WHERE
	NOT EXISTS (
		SELECT
			1
		FROM
			Information_Mart.bv.PIT_Order_Detail AS pit
		WHERE
			snap.DV_Snapshot_Datetime = pit.DV_Snapshot_Datetime
			AND link.HK_L_Order_Detail = pit.HK_L_Order_Detail
	);
GO