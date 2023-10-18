/*

	Business data vault hub deletion tracking satellite history views 

*/


USE Data_Vault;
GO


-- v_history_S_HDT_H_Customer_Northwind

DROP VIEW IF EXISTS bv.v_history_S_HDT_H_Customer_Northwind;
GO

CREATE VIEW bv.v_history_S_HDT_H_Customer_Northwind (
	  HK_H_Customer
	, DV_Load_Datetime_Start
	, DV_Load_Datetime_End
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
AS
SELECT
	  HK_H_Customer
	, DV_Load_Datetime AS DV_Load_Datetime_Start
	, LEAD(DATEADD(NS, -100, DV_Load_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_H_Customer ORDER BY DV_Load_Datetime ASC) AS DV_Load_Datetime_End
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
FROM
	Data_Vault.bv.S_HDT_H_Customer_Northwind;
GO




-- v_history_S_HDT_H_Customer_Type_Northwind

DROP VIEW IF EXISTS bv.v_history_S_HDT_H_Customer_Type_Northwind;
GO

CREATE VIEW bv.v_history_S_HDT_H_Customer_Type_Northwind (
	  HK_H_Customer_Type	
	, DV_Load_Datetime_Start
	, DV_Load_Datetime_End
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
AS
SELECT
	  HK_H_Customer_Type
	, DV_Load_Datetime AS DV_Load_Datetime_Start
	, LEAD(DATEADD(NS, -100, DV_Load_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_H_Customer_Type ORDER BY DV_Load_Datetime ASC) AS DV_Load_Datetime_End
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
FROM
	Data_Vault.bv.S_HDT_H_Customer_Type_Northwind;
GO




-- v_history_S_HDT_H_Employee_Northwind

DROP VIEW IF EXISTS bv.v_history_S_HDT_H_Employee_Northwind;
GO

CREATE VIEW bv.v_history_S_HDT_H_Employee_Northwind (
	  HK_H_Employee
	, DV_Load_Datetime_Start
	, DV_Load_Datetime_End
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
AS
SELECT
	  HK_H_Employee
	, DV_Load_Datetime AS DV_Load_Datetime_Start
	, LEAD(DATEADD(NS, -100, DV_Load_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_H_Employee ORDER BY DV_Load_Datetime ASC) AS DV_Load_Datetime_End
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
FROM
	Data_Vault.bv.S_HDT_H_Employee_Northwind;
GO




-- v_history_S_HDT_H_Order_Northwind

DROP VIEW IF EXISTS bv.v_history_S_HDT_H_Order_Northwind;
GO

CREATE VIEW bv.v_history_S_HDT_H_Order_Northwind (
	  HK_H_Order
	, DV_Load_Datetime_Start
	, DV_Load_Datetime_End
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
AS
SELECT
	  HK_H_Order
	, DV_Load_Datetime AS DV_Load_Datetime_Start
	, LEAD(DATEADD(NS, -100, DV_Load_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_H_Order ORDER BY DV_Load_Datetime ASC) AS DV_Load_Datetime_End
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
FROM
	Data_Vault.bv.S_HDT_H_Order_Northwind;
GO




-- v_history_S_HDT_H_Product_Category_Northwind

DROP VIEW IF EXISTS bv.v_history_S_HDT_H_Product_Category_Northwind;
GO

CREATE VIEW bv.v_history_S_HDT_H_Product_Category_Northwind (
	  HK_H_Product_Category
	, DV_Load_Datetime_Start
	, DV_Load_Datetime_End
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
AS
SELECT
	  HK_H_Product_Category
	, DV_Load_Datetime AS DV_Load_Datetime_Start
	, LEAD(DATEADD(NS, -100, DV_Load_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_H_Product_Category ORDER BY DV_Load_Datetime ASC) AS DV_Load_Datetime_End
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
FROM
	Data_Vault.bv.S_HDT_H_Product_Category_Northwind;
GO




-- v_history_S_HDT_H_Product_Northwind

DROP VIEW IF EXISTS bv.v_history_S_HDT_H_Product_Northwind;
GO

CREATE VIEW bv.v_history_S_HDT_H_Product_Northwind (
	  HK_H_Product
	, DV_Load_Datetime_Start
	, DV_Load_Datetime_End
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
AS
SELECT
	  HK_H_Product
	, DV_Load_Datetime AS DV_Load_Datetime_Start
	, LEAD(DATEADD(NS, -100, DV_Load_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_H_Product ORDER BY DV_Load_Datetime ASC) AS DV_Load_Datetime_End	
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
FROM
	Data_Vault.bv.S_HDT_H_Product_Northwind;
GO




-- v_history_S_HDT_H_Region_Northwind

DROP VIEW IF EXISTS bv.v_history_S_HDT_H_Region_Northwind;
GO

CREATE VIEW bv.v_history_S_HDT_H_Region_Northwind (
	  HK_H_Region
	, DV_Load_Datetime_Start
	, DV_Load_Datetime_End
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
AS
SELECT
	  HK_H_Region
	, DV_Load_Datetime AS DV_Load_Datetime_Start
	, LEAD(DATEADD(NS, -100, DV_Load_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_H_Region ORDER BY DV_Load_Datetime ASC) AS DV_Load_Datetime_End
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
FROM
	Data_Vault.bv.S_HDT_H_Region_Northwind;
GO




-- v_history_S_HDT_H_Shipper_Northwind

DROP VIEW IF EXISTS bv.v_history_S_HDT_H_Shipper_Northwind;
GO

CREATE VIEW bv.v_history_S_HDT_H_Shipper_Northwind (
	  HK_H_Shipper
	, DV_Load_Datetime_Start
	, DV_Load_Datetime_End
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
AS
SELECT
	  HK_H_Shipper
	, DV_Load_Datetime AS DV_Load_Datetime_Start
	, LEAD(DATEADD(NS, -100, DV_Load_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_H_Shipper ORDER BY DV_Load_Datetime ASC) AS DV_Load_Datetime_End
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
FROM
	Data_Vault.bv.S_HDT_H_Shipper_Northwind;
GO




-- v_history_S_HDT_H_Supplier_Northwind

DROP VIEW IF EXISTS bv.v_history_S_HDT_H_Supplier_Northwind;
GO

CREATE VIEW bv.v_history_S_HDT_H_Supplier_Northwind (
	  HK_H_Supplier
	, DV_Load_Datetime_Start
	, DV_Load_Datetime_End
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
AS
SELECT
	  HK_H_Supplier
	, DV_Load_Datetime AS DV_Load_Datetime_Start
	, LEAD(DATEADD(NS, -100, DV_Load_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_H_Supplier ORDER BY DV_Load_Datetime ASC) AS DV_Load_Datetime_End
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
FROM
	Data_Vault.bv.S_HDT_H_Supplier_Northwind;
GO




-- v_history_S_HDT_H_Territory_Northwind

DROP VIEW IF EXISTS bv.v_history_S_HDT_H_Territory_Northwind;
GO

CREATE VIEW bv.v_history_S_HDT_H_Territory_Northwind (
	  HK_H_Territory
	, DV_Load_Datetime_Start
	, DV_Load_Datetime_End
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
AS
SELECT
	  HK_H_Territory
	, DV_Load_Datetime AS DV_Load_Datetime_Start
	, LEAD(DATEADD(NS, -100, DV_Load_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_H_Territory ORDER BY DV_Load_Datetime ASC) AS DV_Load_Datetime_End
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
FROM
	Data_Vault.bv.S_HDT_H_Territory_Northwind;
GO