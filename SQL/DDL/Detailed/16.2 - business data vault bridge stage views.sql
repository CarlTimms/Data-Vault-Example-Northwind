/*

	Bridge stage views

*/


USE Information_Mart;
GO


-- v_stage_B_Customer_Type

DROP VIEW IF EXISTS bv.v_stage_B_Customer_Type;
GO

CREATE VIEW bv.v_stage_B_Customer_Type (
	    DV_Snapshot_Datetime
	  , HK_L_Customer_Type
	  , DV_Load_Datetime
	  , DV_Record_Source
	  , HK_H_Customer
	  , HK_H_Customer_Type
	  , CustomerID
	  , CustomerTypeID
)
AS
SELECT 
	    snap.DV_Snapshot_Datetime
	  , sat_ldt.HK_L_Customer_Type
	  , SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	  , 'SYSTEM | Information_Mart.bv.v_stage_B_Customer_Type' AS DV_Record_Source
	  , hub_customer.HK_H_Customer
	  , hub_customer_type.HK_H_Customer_Type
	  , hub_customer.CustomerID
	  , hub_customer_type.CustomerTypeID
FROM 
	Data_Vault.rv.L_Customer_Type AS link
		CROSS JOIN Information_Mart.bv.R_Snapshot_Control AS snap 
		INNER JOIN Data_Vault.bv.v_history_S_LDT_L_Customer_Type_Northwind AS sat_ldt
			ON link.HK_L_Customer_Type = sat_ldt.HK_L_Customer_Type
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_ldt.DV_Load_Datetime_Start AND sat_ldt.DV_Load_Datetime_End
		   AND sat_ldt.Is_Deleted_Flag = 0
		INNER JOIN Data_Vault.rv.H_Customer AS hub_customer
			ON link.HK_H_Customer = hub_customer.HK_H_Customer
		INNER JOIN Data_Vault.rv.H_Customer_Type AS hub_customer_type
			ON link.HK_H_Customer_Type = hub_customer_type.HK_H_Customer_Type
WHERE
	NOT EXISTS (
		SELECT
			1
		FROM
			Information_Mart.bv.B_Customer_Type AS bridge
		WHERE
			snap.DV_Snapshot_Datetime = bridge.DV_Snapshot_Datetime
			AND link.HK_L_Customer_Type = bridge.HK_L_Customer_Type
	);
GO




-- v_stage_B_Employee_Reporting_Line

DROP VIEW IF EXISTS bv.v_stage_B_Employee_Reporting_Line;
GO

CREATE VIEW bv.v_stage_B_Employee_Reporting_Line (
	  DV_Snapshot_Datetime
	, HK_L_Employee_Reporting_Line
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Employee__Direct_Report
	, HK_H_Employee__Manager
	, EmployeeID__Direct_Report
	, EmployeeID__Manager
)
AS
SELECT
	  snap.DV_Snapshot_Datetime
	, COALESCE(link.HK_L_Employee_Reporting_Line, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_L_Employee_Reporting_Line
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, 'SYSTEM | Information_Mart.bv.v_stage_B_Employee_Reporting_Line' AS DV_Record_Source
	, COALESCE(hub_employee__direct_report.HK_H_Employee, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Employee__Direct_Report
	, COALESCE(hub_employee__manager.HK_H_Employee, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Employee__Manager
	, COALESCE(hub_employee__direct_report.EmployeeID, 0) AS EmployeeID__Direct_Report
	, COALESCE(hub_employee__manager.EmployeeID, 0) AS EmployeeID__Manager
FROM
	Data_Vault.rv.H_Employee AS hub_employee__direct_report
		CROSS JOIN Information_Mart.bv.R_Snapshot_Control AS snap
		LEFT JOIN Data_Vault.bv.v_history_S_LE_L_Employee_Reporting_Line_Northwind AS sat_le
			ON hub_employee__direct_report.HK_H_Employee = sat_le.HK_H_Employee__Direct_Report__DK
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_le.Start_Datetime AND sat_le.End_Datetime
		LEFT JOIN Data_Vault.rv.L_Employee_Reporting_Line AS link
			ON sat_le.HK_L_Employee_Reporting_Line = link.HK_L_Employee_Reporting_Line
		LEFT JOIN Data_Vault.rv.H_Employee AS hub_employee__manager
			ON link.HK_H_Employee__Manager = hub_employee__manager.HK_H_Employee
WHERE
	NOT EXISTS (
		SELECT
			1
		FROM
			Information_Mart.bv.B_Employee_Reporting_Line AS bridge
		WHERE
			snap.DV_Snapshot_Datetime = bridge.DV_Snapshot_Datetime
			AND hub_employee__direct_report.HK_H_Employee = bridge.HK_H_Employee__Direct_Report
	);
GO




-- v_stage_B_Employee_Territory

DROP VIEW IF EXISTS bv.v_stage_B_Employee_Territory;
GO

CREATE VIEW bv.v_stage_B_Employee_Territory (
	  DV_Snapshot_Datetime
	, HK_L_Employee_Territory
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Employee
	, HK_H_Territory
	, EmployeeID
	, TerritoryID
)
AS
SELECT
	  snap.DV_Snapshot_Datetime
	, sat_ldt.HK_L_Employee_Territory
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, 'SYSTEM | Information_Mart.bv.v_stage_B_Employee_Territory' AS DV_Record_Source4
	, hub_employee.HK_H_Employee
	, hub_territory.HK_H_Territory
	, hub_employee.EmployeeID
	, hub_territory.TerritoryID
FROM
	Data_Vault.rv.L_Employee_Territory AS link
		CROSS JOIN Information_Mart.bv.R_Snapshot_Control AS snap
		INNER JOIN Data_Vault.bv.v_history_S_LDT_L_Employee_Territory_Northwind AS sat_ldt
			ON link.HK_L_Employee_Territory = sat_ldt.HK_L_Employee_Territory
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_ldt.DV_Load_Datetime_Start AND sat_ldt.DV_Load_Datetime_End
		   AND sat_ldt.Is_Deleted_Flag = 0
		INNER JOIN Data_Vault.rv.H_Employee AS hub_employee
			ON link.HK_H_Employee = hub_employee.HK_H_Employee
		INNER JOIN Data_Vault.rv.H_Territory AS hub_territory
			ON link.HK_H_Territory = hub_territory.HK_H_Territory
WHERE
	NOT EXISTS (
		SELECT
			1
		FROM
			Information_Mart.bv.B_Employee_Territory AS bridge
		WHERE
			snap.DV_Snapshot_Datetime = bridge.DV_Snapshot_Datetime
			AND link.HK_L_Employee_Territory = bridge.HK_L_Employee_Territory
	);
GO




-- v_stage_B_Order

DROP VIEW IF EXISTS bv.v_stage_B_Order;
GO

CREATE VIEW bv.v_stage_B_Order (
	  DV_Snapshot_Datetime
	, HK_L_Order_Header
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Order
	, HK_H_Customer
	, HK_H_Employee
	, HK_H_Shipper
	, Date_Key__OrderDate
	, Date_Key__RequiredDate
	, Date_Key__ShippedDate
	, OrderID
	, Is_Deleted_Flag
	, Freight
	, Order_Count
)
AS
SELECT 
	  snap.DV_Snapshot_Datetime
	, link.HK_L_Order_Header
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, 'SYSTEM | Information_Mart.bv.v_stage_B_Order' AS DV_Record_Source
	, link.HK_H_Order__DK AS HK_H_Order
	, link.HK_H_Customer
	, link.HK_H_Employee
	, link.HK_H_Shipper
	, COALESCE(CAST(CONVERT(varchar(8), sat_h.OrderDate, 112) AS int), 19000101) AS Date_Key__OrderDate
	, COALESCE(CAST(CONVERT(varchar(8), sat_h.RequiredDate, 112) AS int), 19000101) AS Date_Key__RequiredDate
	, COALESCE(CAST(CONVERT(varchar(8), sat_h.ShippedDate, 112) AS int), 19000101) AS Date_Key__ShippedDate
	, hub.OrderID
	, COALESCE(sat_hdt.Is_Deleted_Flag, 0) AS Is_Deleted_Flag
	, sat_h.Freight
	, CASE
		WHEN link.HK_L_Order_Header IN (
				  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
				, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
				, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
			) THEN NULL
		ELSE 1
	  END AS Order_Detail_Count
FROM
	Data_Vault.rv.L_Order_Header AS link
		CROSS JOIN Information_Mart.bv.R_Snapshot_Control AS snap
		INNER JOIN Data_Vault.bv.v_history_S_LE_L_Order_Header_Northwind AS sat_le
			ON link.HK_L_Order_Header = sat_le.HK_L_Order_Header
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_le.Start_Datetime AND sat_le.End_Datetime  
		LEFT JOIN Data_Vault.rv.H_Order AS hub
			ON link.HK_H_Order__DK = hub.HK_H_Order
		LEFT JOIN Data_Vault.bv.v_history_S_HDT_H_Order_Northwind AS sat_hdt
			ON link.HK_H_Order__DK = sat_hdt.HK_H_Order
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_hdt.DV_Load_Datetime_Start AND sat_hdt.DV_Load_Datetime_End
		LEFT JOIN Data_Vault.bv.v_history_S_H_Order_Northwind AS sat_h
			ON link.HK_H_Order__DK = sat_h.HK_H_Order
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_h.DV_Load_Datetime_Start AND sat_h.DV_Load_Datetime_End
WHERE
	NOT EXISTS (
		SELECT
			1
		FROM
			Information_Mart.bv.B_Order AS bridge
		WHERE
			snap.DV_Snapshot_Datetime = bridge.DV_Snapshot_Datetime
			AND link.HK_H_Order__DK = bridge.HK_H_Order
	);
GO




-- v_stage_B_Order_Detail

DROP VIEW IF EXISTS bv.v_stage_B_Order_Detail;
GO

CREATE VIEW bv.v_stage_B_Order_Detail (
	  DV_Snapshot_Datetime
	, HK_L_Order_Detail
	, HK_L_Order_Header
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Customer
	, HK_H_Employee
	, HK_H_Shipper
	, HK_H_Product
	, Date_Key__OrderDate
	, Date_Key__RequiredDate
	, Date_Key__ShippedDate
	, OrderID
	, ProductID
	, Is_Deleted_Flag
	, UnitPrice
	, Quantity
	, Discount
	, Total_Price
	, Order_Detail_Count
)
AS
SELECT
	  snap.DV_Snapshot_Datetime AS DV_Snapshot_Datetime
	, link_order_detail.HK_L_Order_Detail
	, link_order_header.HK_L_Order_Header
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, 'SYSTEM | Information_Mart.bv.v_stage_B_Order_Detail' AS DV_Record_Source
	, link_order_header.HK_H_Customer
	, link_order_header.HK_H_Employee
	, link_order_header.HK_H_Shipper
	, link_order_detail.HK_H_Product
	, COALESCE(CAST(CONVERT(varchar(8), sat_h_order.OrderDate, 112) AS int), 19000101) AS Date_Key__Order_Submitted_Date
	, COALESCE(CAST(CONVERT(varchar(8), sat_h_order.RequiredDate, 112) AS int), 19000101) AS Date_Key__Order_Required_Date
	, COALESCE(CAST(CONVERT(varchar(8), sat_h_order.ShippedDate, 112) AS int), 19000101) AS Date_Key__Order_Shipped_Date
	, hub_order.OrderID
	, hub_product.ProductID
	, CASE
		WHEN sat_hdt_order.Is_Deleted_Flag = 1 OR sat_ldt_order_detail.Is_Deleted_Flag = 1 THEN 1
		ELSE 0
	  END AS Is_Deleted_Flag
	, CAST(sat_l_order_detail.UnitPrice AS decimal(19, 4)) AS UnitPrice
	, sat_l_order_detail.Quantity
	, CAST(sat_l_order_detail.Discount AS decimal(19, 4)) AS Discount
	, CAST((sat_l_order_detail.[UnitPrice] * sat_l_order_detail.[Quantity]) * (1 - sat_l_order_detail.[Discount]) AS decimal(19, 4)) AS Total_Price
	, CASE
		WHEN link_order_detail.HK_L_Order_Detail IN (
				  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
				, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
				, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
			) THEN NULL
		ELSE 1
	  END AS Order_Detail_Count
FROM
	Data_Vault.rv.L_Order_Header AS link_order_header
		INNER JOIN Data_Vault.rv.L_Order_Detail AS link_order_detail
			ON link_order_header.HK_H_Order__DK = link_order_detail.HK_H_Order
		CROSS JOIN Information_Mart.bv.R_Snapshot_Control AS snap
		INNER JOIN Data_Vault.bv.v_history_S_LE_L_Order_Header_Northwind AS sat_le_order
			ON link_order_header.HK_L_Order_Header = sat_le_order.HK_L_Order_Header
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_le_order.Start_Datetime AND sat_le_order.End_Datetime
		LEFT JOIN Data_Vault.rv.H_Order AS hub_order
			ON link_order_header.HK_H_Order__DK = hub_order.HK_H_Order
		LEFT JOIN Data_Vault.rv.H_Product AS hub_product
			ON link_order_detail.HK_H_Product = hub_product.HK_H_Product
		LEFT JOIN Data_Vault.bv.v_history_S_HDT_H_Order_Northwind AS sat_hdt_order
			ON link_order_header.HK_H_Order__DK = sat_hdt_order.HK_H_Order
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_hdt_order.DV_Load_Datetime_Start AND sat_hdt_order.DV_Load_Datetime_End
		LEFT JOIN Data_Vault.bv.v_history_S_H_Order_Northwind AS sat_h_order
			ON link_order_header.HK_H_Order__DK = sat_h_order.HK_H_Order
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_h_order.DV_Load_Datetime_Start AND sat_h_order.DV_Load_Datetime_End
		LEFT JOIN Data_Vault.bv.v_history_S_LDT_L_Order_Detail_Northwind AS sat_ldt_order_detail 
			ON link_order_detail.HK_L_Order_Detail = sat_ldt_order_detail.HK_L_Order_Detail
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_ldt_order_detail.DV_Load_Datetime_Start AND sat_ldt_order_detail.DV_Load_Datetime_End
		LEFT JOIN Data_Vault.bv.v_history_S_L_Order_Detail_Northwind AS sat_l_order_detail
			ON link_order_detail.HK_L_Order_Detail = sat_l_order_detail.HK_L_Order_Detail
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_l_order_detail.DV_Load_Datetime_Start AND sat_l_order_detail.DV_Load_Datetime_End
WHERE
	NOT EXISTS (
		SELECT
			1
		FROM
			Information_Mart.bv.B_Order_Detail AS bridge
		WHERE
			snap.DV_Snapshot_Datetime = bridge.DV_Snapshot_Datetime
			AND link_order_detail.HK_L_Order_Detail = bridge.HK_L_Order_Detail
	);
GO




-- v_stage_B_Product_Supplier_Category

DROP VIEW IF EXISTS bv.v_stage_B_Product_Supplier_Category;
GO

CREATE VIEW bv.v_stage_B_Product_Supplier_Category (
	  DV_Snapshot_Datetime
	, HK_L_Product_Supplier
	, HK_L_Product_Category
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Product
	, HK_H_Supplier
	, HK_H_Product_Category
	, ProductID
	, SupplierID
	, CategoryID
)
AS
SELECT
	  snap.DV_Snapshot_Datetime
	, COALESCE(link_product_supplier.HK_L_Product_Supplier, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_L_Product_Supplier
	, COALESCE(link_product_category.HK_L_Product_Category, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_L_Product_Category
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, 'SYSTEM | Information_Mart.bv.v_stage_B_Product_Supplier_Category' AS DV_Record_Source
	, hub_product.HK_H_Product
	, COALESCE(hub_supplier.HK_H_Supplier, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Supplier
	, COALESCE(hub_category.HK_H_Product_Category, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Product_Category
	, COALESCE(hub_product.ProductID, 0) AS ProductID
	, COALESCE(hub_supplier.SupplierID, 0) AS SupplierID
	, COALESCE(hub_category.CategoryID, 0) AS CategoryID
FROM
	Data_Vault.rv.H_Product AS hub_product
		CROSS JOIN Information_Mart.bv.R_Snapshot_Control AS snap
		LEFT JOIN Data_Vault.bv.v_history_S_LE_L_Product_Supplier_Northwind AS sat_le_l_product_supplier
			ON hub_product.HK_H_Product = sat_le_l_product_supplier.HK_H_Product__DK
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_le_l_product_supplier.Start_Datetime AND sat_le_l_product_supplier.End_Datetime
		LEFT JOIN Data_Vault.rv.L_Product_Supplier AS link_product_supplier
			ON sat_le_l_product_supplier.HK_L_Product_Supplier = link_product_supplier.HK_L_Product_Supplier
		LEFT JOIN Data_Vault.rv.H_Supplier AS hub_supplier
			ON link_product_supplier.HK_H_Supplier = hub_supplier.HK_H_Supplier
		LEFT JOIN Data_Vault.bv.v_history_S_LE_L_Product_Category_Northwind AS sat_le_l_product_category
			ON hub_product.HK_H_Product = sat_le_l_product_category.HK_H_Product__DK
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_le_l_product_category.Start_Datetime AND sat_le_l_product_category.End_Datetime
		LEFT JOIN Data_Vault.rv.L_Product_Category AS link_product_category
			ON sat_le_l_product_category.HK_L_Product_Category = link_product_category.HK_L_Product_Category
		LEFT JOIN Data_Vault.rv.H_Product_Category AS hub_category
			ON link_product_category.HK_H_Product_Category = hub_category.HK_H_Product_Category
WHERE
	NOT EXISTS (
		SELECT
			1
		FROM
			Information_Mart.bv.B_Product_Supplier_Category AS bridge
		WHERE
			snap.DV_Snapshot_Datetime = bridge.DV_Snapshot_Datetime
			AND hub_product.HK_H_Product = bridge.HK_H_Product
	);
GO




-- v_stage_B_Territory_Region

DROP VIEW IF EXISTS bv.v_stage_B_Territory_Region;
GO

CREATE VIEW bv.v_stage_B_Territory_Region (
	  DV_Snapshot_Datetime
	, HK_L_Territory_Region
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Territory
	, HK_H_Region
	, TerritoryID
	, RegionID
)
AS
SELECT
	  snap.DV_Snapshot_Datetime
	, COALESCE(link.HK_L_Territory_Region, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_L_Territory_Region
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, 'SYSTEM | Information_Mart.bv.v_stage_B_Territory_Region' AS DV_Record_Source
	, COALESCE(hub_territory.HK_H_Territory, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Territory
	, COALESCE(hub_region.HK_H_Region, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Region
	, COALESCE(hub_territory.TerritoryID, 0) AS TerritoryID
	, COALESCE(hub_region.RegionID, 0) AS RegionID
FROM
	Data_Vault.rv.H_Territory AS hub_territory
	CROSS JOIN Information_Mart.bv.R_Snapshot_Control AS snap
	LEFT JOIN Data_Vault.bv.v_history_S_LE_L_Territory_Region_Northwind AS sat_le
		ON hub_territory.HK_H_Territory = sat_le.HK_H_Territory__DK
	   AND snap.DV_Snapshot_Datetime BETWEEN sat_le.Start_Datetime AND sat_le.End_Datetime
	LEFT JOIN Data_Vault.rv.L_Territory_Region AS link
		ON sat_le.HK_L_Territory_Region = link.HK_L_Territory_Region
	LEFT JOIN Data_Vault.rv.H_Region AS hub_region
		ON link.HK_H_Region = hub_region.HK_H_Region
WHERE
	NOT EXISTS (
		SELECT
			1
		FROM
			Information_Mart.bv.B_Territory_Region AS bridge
		WHERE
			snap.DV_Snapshot_Datetime = bridge.DV_Snapshot_Datetime
			AND hub_territory.HK_H_Territory = bridge.HK_H_Territory
	);
GO