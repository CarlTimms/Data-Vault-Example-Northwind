/* 

	Information mart dimension views

*/


USE Information_Mart;
GO


-- Dim_Customer

DROP VIEW IF EXISTS star.Dim_Customer;
GO

CREATE VIEW star.Dim_Customer (
	  Snapshot_Datetime
	, Dim_Customer_Key
	, Customer_ID
	, Customer_Company_Name
	, Customer_Contact_Name
	, Customer_Contact_Job_Title
	, Customer_Postal_Code
	, Customer_City
	, Customer_Region_Code
	, Customer_Country
	, Customer_Deleted_Flag
)
AS
SELECT
	  pit.DV_Snapshot_Datetime AS Snapshot_Datetime
	, pit.HK_H_Customer AS Dim_Customer_Key
	, pit.CustomerID AS Customer_ID
	, COALESCE(sat_h.CompanyName, 'Unknown') AS Customer_Company_Name
	, COALESCE(sat_h.ContactName,'Unknown') AS Customer_Contact_Name
	, COALESCE(sat_h.ContactTitle,'Unknown') AS Customer_Contact_Job_Title
	, COALESCE(sat_h.PostalCode,'?') AS Customer_Postal_Code
	, COALESCE(sat_h.City,'Unknown') AS Customer_City
	, COALESCE(sat_h.Region,'?') AS Customer_Region_Code
	, COALESCE(sat_h.Country,'Unknown') Customer_Country
	, COALESCE(pit.Is_Deleted_Flag, 0) AS Customer_Is_Deleted_Flag
FROM
	Information_Mart.bv.PIT_Customer AS pit
		INNER JOIN Data_Vault.rv.S_H_Customer_Northwind AS sat_h
			ON pit.HK_H_Customer__S_H_Customer_Northwind = sat_h.HK_H_Customer
		   AND pit.DV_Load_Datetime__S_H_Customer_Northwind = sat_h.DV_Load_Datetime;
GO




-- Dim_Customer_Type

DROP VIEW IF EXISTS star.Dim_Customer_Type;
GO

CREATE VIEW star.Dim_Customer_Type (
	  Snapshot_Datetime
	, Dim_Customer_Type_Key
	, Customer_Type_ID
	, Customer_Type_Description
	, Customer_Type_Deleted_Flag
)
AS
SELECT 
	  pit.DV_Snapshot_Datetime AS Snapshot_Datetime
	, pit.HK_H_Customer_Type AS Dim_Customer_Type_Key
	, pit.CustomerTypeID AS Customer_Type_ID
	, COALESCE(sat_h.CustomerDesc, 'Unknown') AS Customer_Type_Description
	, COALESCE(pit.Is_Deleted_Flag, 0) AS Customer_Type_Is_Deleted_Flag
FROM
	Information_Mart.bv.PIT_Customer_Type AS pit
		INNER JOIN Data_Vault.rv.S_H_Customer_Type_Northwind AS sat_h
			ON pit.HK_H_Customer_Type__S_H_Customer_Type_Northwind = sat_h.HK_H_Customer_Type
		   AND pit.DV_Load_Datetime__S_H_Customer_Type_Northwind = sat_h.DV_Load_Datetime;
GO




-- Dim_Date

--DROP VIEW IF EXISTS star.Dim_Date;
--GO

--CREATE VIEW star.Dim_Date (
--	  Dim_Date_Key
--	, Date
--	, Date_String
--	, Start_Datetime
--	, End_Datetime
--	, Day_Of_Month_Number
--	, Month_Number
--	, Month_Name
--	, Year_Number
--	, Day_Of_Week_Number
--	, Day_Of_Week_Name
--	, Quarter_Number
--	, Quarter_Name
--)
--AS
--SELECT
--	  Date_Key AS Dim_Date_Key
--	, Date
--	, Date_String
--	, Start_Datetime
--	, End_Datetime
--	, Day_Of_Month_Number
--	, Month_Number
--	, Month_Name
--	, Year_Number
--	, Day_Of_Week_Number
--	, Day_Of_Week_Name
--	, Quarter_Number
--	, Quarter_Name
--FROM
--	Data_Vault.rv.R_Date;
--GO




-- Dim_Date role-play Dim_Order_Required_Date

DROP VIEW IF EXISTS star.Dim_Order_Required_Date;
GO

CREATE VIEW star.Dim_Order_Required_Date (
	  Dim_Order_Required_Date_Key
	, Order_Required_Date
	, Order_Required_Date_String
	, Order_Required_Date_Start_Datetime
	, Order_Required_Date_End_Datetime
	, Order_Required_Date_Day_Of_Month_Number
	, Order_Required_Date_Month_Number
	, Order_Required_Date_Month_Name
	, Order_Required_Date_Year_Number
	, Order_Required_Date_Day_Of_Week_Number
	, Order_Required_Date_Day_Of_Week_Name
	, Order_Required_Date_Quarter_Number
	, Order_Required_Date_Quarter_Name
)
AS
SELECT
	  Date_Key AS Dim_Order_Required_Date_Key
	, [Date] AS Order_Required_Date
	, Date_String AS Order_Required_Date_String
	, Start_Datetime AS Order_Required_Date_Start_Datetime
	, End_Datetime AS Order_Required_Date_End_Datetime
	, Day_Of_Month_Number AS Order_Required_Date_Day_Of_Month_Number
	, Month_Number AS Order_Required_Date_Month_Number
	, Month_Name AS Order_Required_Date_Month_Name
	, Year_Number AS Order_Required_Date_Year_Number
	, Day_Of_Week_Number AS Order_Required_Date_Day_Of_Week_Number
	, Day_Of_Week_Name AS Order_Required_Date_Day_Of_Week_Name
	, Quarter_Number AS Order_Required_Date_Quarter_Number
	, Quarter_Name AS Order_Required_Date_Quarter_Name
FROM
	Data_Vault.rv.R_Date;
GO




-- Dim_Date role-play Dim_Order_Shipped_Date

DROP VIEW IF EXISTS star.Dim_Order_Shipped_Date;
GO

CREATE VIEW star.Dim_Order_Shipped_Date (
	  Dim_Order_Shipped_Date_Key
	, Order_Shipped_Date
	, Order_Shipped_Date_String
	, Order_Shipped_Date_Start_Datetime
	, Order_Shipped_Date_End_Datetime
	, Order_Shipped_Date_Day_Of_Month_Number
	, Order_Shipped_Date_Month_Number
	, Order_Shipped_Date_Month_Name
	, Order_Shipped_Date_Year_Number
	, Order_Shipped_Date_Day_Of_Week_Number
	, Order_Shipped_Date_Day_Of_Week_Name
	, Order_Shipped_Date_Quarter_Number
	, Order_Shipped_Date_Quarter_Name
)
AS
SELECT
	  Date_Key AS Dim_Order_Shipped_Date_Key
	, [Date] AS Order_Shipped_Date
	, Date_String AS Order_Shipped_Date_String
	, Start_Datetime AS Order_Shipped_Date_Start_Datetime
	, End_Datetime AS Order_Shipped_Date_End_Datetime
	, Day_Of_Month_Number AS Order_Shipped_Date_Day_Of_Month_Number
	, Month_Number AS Order_Shipped_Date_Month_Number
	, Month_Name AS Order_Shipped_Date_Month_Name
	, Year_Number AS Order_Shipped_Date_Year_Number
	, Day_Of_Week_Number AS Order_Shipped_Date_Day_Of_Week_Number
	, Day_Of_Week_Name AS Order_Shipped_Date_Day_Of_Week_Name
	, Quarter_Number AS Order_Shipped_Date_Quarter_Number
	, Quarter_Name AS Order_Shipped_Date_Quarter_Name
FROM
	Data_Vault.rv.R_Date;
GO




-- Dim_Date role-play Dim_Order_Submitted_Date

DROP VIEW IF EXISTS star.Dim_Order_Submitted_Date;
GO

CREATE VIEW star.Dim_Order_Submitted_Date (
	  Dim_Order_Submitted_Date_Key
	, Order_Submitted_Date
	, Order_Submitted_Date_String
	, Order_Submitted_Date_Start_Datetime
	, Order_Submitted_Date_End_Datetime
	, Order_Submitted_Date_Day_Of_Month_Number
	, Order_Submitted_Date_Month_Number
	, Order_Submitted_Date_Month_Name
	, Order_Submitted_Date_Year_Number
	, Order_Submitted_Date_Day_Of_Week_Number
	, Order_Submitted_Date_Day_Of_Week_Name
	, Order_Submitted_Date_Quarter_Number
	, Order_Submitted_Date_Quarter_Name
)
AS
SELECT
	  Date_Key AS Dim_Order_Submitted_Date_Key
	, [Date] AS Order_Submitted_Date
	, Date_String AS Order_Submitted_Date_String
	, Start_Datetime AS Order_Submitted_Date_Start_Datetime
	, End_Datetime AS Order_Submitted_Date_End_Datetime
	, Day_Of_Month_Number AS Order_Submitted_Date_Day_Of_Month_Number
	, Month_Number AS Order_Submitted_Date_Month_Number
	, Month_Name AS Order_Submitted_Date_Month_Name
	, Year_Number AS Order_Submitted_Date_Year_Number
	, Day_Of_Week_Number AS Order_Submitted_Date_Day_Of_Week_Number
	, Day_Of_Week_Name AS Order_Submitted_Date_Day_Of_Week_Name
	, Quarter_Number AS Order_Submitted_Date_Quarter_Number
	, Quarter_Name AS Order_Submitted_Date_Quarter_Name
FROM
	Data_Vault.rv.R_Date;
GO




-- Dim_Employee

DROP VIEW IF EXISTS star.Dim_Employee;
GO

CREATE VIEW star.Dim_Employee (
	  Snapshot_Datetime
	, Dim_Employee_Key
	, Dim_Manager_Key
	, Employee_ID
	, Employee_Name
	, Employee_Birth_Date
	, Employee_Hire_Date
	, Employee_Job_Title
	, Employee_Postal_Code
	, Employee_City
	, Employee_Region_Code
	, Employee_Country_Code
	, Employee_Is_Deleted_Flag
)
AS
SELECT
	  pit.DV_Snapshot_Datetime AS Snapshot_Datetime
	, pit.HK_H_Employee AS Dim_Employee_Key
	, bridge.HK_H_Employee__Manager AS Dim_Manager_Key
	, pit.EmployeeID AS Employee_ID
	, COALESCE(pit.Employee_Name, 'Unknown') AS Employee_Name
	, COALESCE(sat_h.BirthDate, '1900-01-01') AS Employee_Birth_Date
	, COALESCE(sat_h.HireDate, '1900-01-01') AS Employee_Hire_Date
	, COALESCE(sat_h.Title, 'Unknown') AS Employee_Job_Title
	, COALESCE(sat_h.PostalCode, '?') AS Employee_Postal_Code
	, COALESCE(sat_h.City, 'Unknown') AS Employee_City
	, COALESCE(sat_h.Region, '?')  AS Employee_Region_Code
	, COALESCE(sat_h.Country, 'Unknown') AS Employee_Country_Code
	, COALESCE(pit.Is_Deleted_Flag, 0) AS Employee_Is_Deleted_Flag
FROM
	Information_Mart.bv.PIT_Employee AS pit
		INNER JOIN Data_Vault.rv.S_H_Employee_Northwind AS sat_h
			ON pit.HK_H_Employee__S_H_Employee_Northwind = sat_h.HK_H_Employee
		   AND pit.DV_Load_Datetime__S_H_Employee_Northwind = sat_h.DV_Load_Datetime
		INNER JOIN Information_Mart.bv.B_Employee_Reporting_Line AS bridge
			ON pit.DV_Snapshot_Datetime = bridge.DV_Snapshot_Datetime
		   AND pit.HK_H_Employee = bridge.HK_H_Employee__Direct_Report;
GO




-- Dim_Employee role-play Dim_Manager

DROP VIEW IF EXISTS star.Dim_Manager;
GO

CREATE VIEW star.Dim_Manager (
	  Snapshot_Datetime
	, Dim_Manager_Key
	, Manager_ID
	, Manager_Name
	, Manager_Birth_Date
	, Manager_Hire_Date
	, Manager_Job_Title
	, Manager_Postal_Code
	, Manager_City
	, Manager_Region_Code
	, Manager_Country_Code
	, Manager_Is_Deleted_Flag
)
AS
SELECT
	  pit1.DV_Snapshot_Datetime AS Snapshot_Datetime
	, pit1.HK_H_Employee AS Dim_Manager_Key
	, pit1.EmployeeID AS Manager_ID
	, COALESCE(pit1.Employee_Name, 'Unknown') AS Manager_Name
	, COALESCE(sat_h.BirthDate, '1900-01-01') AS Manager_Birth_Date
	, COALESCE(sat_h.HireDate, '1900-01-01') AS Manager_Hire_Date
	, COALESCE(sat_h.Title, 'Unknown') AS Manager_Job_Title
	, COALESCE(sat_h.PostalCode, '?') AS Manager_Postal_Code
	, COALESCE(sat_h.City, 'Unknown') AS Manager_City
	, COALESCE(sat_h.Region, '?')  AS Manager_Region_Code
	, COALESCE(sat_h.Country, 'Unknown') AS Manager_Country_Code
	, COALESCE(pit1.Is_Deleted_Flag, 0) AS Manager_Is_Deleted_Flag
FROM
	Information_Mart.bv.PIT_Employee AS pit1
		INNER JOIN Data_Vault.rv.S_H_Employee_Northwind AS sat_h
			ON pit1.HK_H_Employee__S_H_Employee_Northwind = sat_h.HK_H_Employee
		   AND pit1.DV_Load_Datetime__S_H_Employee_Northwind = sat_h.DV_Load_Datetime
WHERE
	-- Limit to employees who are managers at the snapshot time
	EXISTS (
		SELECT
			1
		FROM
			Information_Mart.bv.B_Employee_Reporting_Line AS bridge
		WHERE
			pit1.DV_Snapshot_Datetime = bridge.DV_Snapshot_Datetime
			AND pit1.HK_H_Employee = bridge.HK_H_Employee__Manager
	);
GO




-- Dim_Product

DROP VIEW IF EXISTS star.Dim_Product;
GO

CREATE VIEW star.Dim_Product (
	  Snapshot_Datetime
	, Dim_Product_Key
	, Product_ID
	, Product_Name
	, Product_Quantity_Per_Unit
	, Product_Unit_Price
	, Product_Units_In_Stock
	, Product_Units_On_Order
	, Product_Reorder_Level
	, Product_Is_Discontinued_Flag
	, Product_Is_Deleted_Flag
	, Supplier_ID
	, Supplier_Name
	, Suppplier_Country
	, Supplier_Is_Deleted_Flag
	, Category_ID
	, Category_Name
	, Category_Description
	, Category_Is_Deleted_Flag
)
AS
SELECT
	  -- Product
	  bridge.DV_Snapshot_Datetime AS Snapshot_Datetime
	, bridge.HK_H_Product AS Dim_Product_Key
	, bridge.ProductID AS Product_ID
	, COALESCE(sat_h_product.ProductName, 'Unknown') AS Product_Name
	, COALESCE(sat_h_product.QuantityPerUnit, 'Unknown') AS Product_Quantity_Per_Unit
	, COALESCE(sat_h_product.UnitPrice, 0) AS Product_Unit_Price
	, COALESCE(sat_h_product.UnitsInStock, 0) AS Product_Units_In_Stock
	, COALESCE(sat_h_product.UnitsOnOrder, 0) AS Product_Units_On_Order
	, COALESCE(sat_h_product.ReorderLevel, 0) AS Product_Reorder_Level
	, COALESCE(sat_h_product.Discontinued, 0) AS Product_Is_Discontinued_Flag
	, COALESCE(pit_product.Is_Deleted_Flag, 0) AS Product_Is_Deleted_Flag

	  -- Supplier
	, bridge.SupplierID AS Supplier_ID
	, COALESCE(sat_h_supplier.CompanyName, 'Unknown') AS Supplier_Name
	, COALESCE(sat_h_supplier.Country, 'Unknown') AS Suppplier_Country
	, COALESCE(pit_supplier.Is_Deleted_Flag, 0) AS Supplier_Is_Deleted_Flag

	  -- Product Category
	, bridge.CategoryID AS Category_ID
	, COALESCE(sat_h_product_category.CategoryName, 'Unknown') AS Category_Name
	, COALESCE(sat_h_product_category.[Description], 'Unknown') AS Category_Description
	, COALESCE(pit_product_category.Is_Deleted_Flag, 0) AS Category_Is_Deleted_Flag
FROM
	Information_Mart.bv.B_Product_Supplier_Category AS bridge
		INNER JOIN Information_Mart.bv.PIT_Product AS pit_product
			ON bridge.DV_Snapshot_Datetime = pit_product.DV_Snapshot_Datetime
		   AND bridge.HK_H_Product = pit_product.HK_H_Product
		INNER JOIN Data_Vault.rv.S_H_Product_Northwind AS sat_h_product
			ON pit_product.HK_H_Product__S_H_Product_Northwind = sat_h_product.HK_H_Product
		   AND pit_product.DV_Load_Datetime__S_H_Product_Northwind = sat_h_product.DV_Load_Datetime 
		INNER JOIN Information_Mart.bv.PIT_Supplier AS pit_supplier
			ON bridge.DV_Snapshot_Datetime = pit_supplier.DV_Snapshot_Datetime
		   AND bridge.HK_H_Supplier = pit_supplier.HK_H_Supplier
		INNER JOIN Data_Vault.rv.S_H_Supplier_Northwind AS sat_h_supplier
			ON pit_supplier.HK_H_Supplier__S_H_Supplier_Northwind = sat_h_supplier.HK_H_Supplier
		   AND pit_supplier.DV_Load_Datetime__S_H_Supplier_Northwind = sat_h_supplier.DV_Load_Datetime
		INNER JOIN Information_Mart.bv.PIT_Product_Category AS pit_product_category
			ON bridge.DV_Snapshot_Datetime = pit_product_category.DV_Snapshot_Datetime
		   AND bridge.HK_H_Product_Category = pit_product_category.HK_H_Product_Category
		INNER JOIN Data_Vault.rv.S_H_Product_Category_Northwind AS sat_h_product_category
			ON pit_product_category.HK_H_Product_Category__S_H_Product_Category_Northwind = sat_h_product_category.HK_H_Product_Category
		   AND pit_product_category.DV_Load_Datetime__S_H_Product_Category_Northwind = sat_h_product_category.DV_Load_Datetime;
GO




-- Dim_Shipper

DROP VIEW IF EXISTS star.Dim_Shipper;
GO

CREATE VIEW star.Dim_Shipper (
	  Snapshot_Datetime
	, Dim_Shipper_Key
	, Shipper_ID
	, Shipper_Name
	, Shipper_Is_Deleted_Flag
)
AS
SELECT
	  pit.DV_Snapshot_Datetime AS Snapshot_Datetime
	, pit.HK_H_Shipper AS Dim_Shipper_Key
	, pit.ShipperID AS Shipper_ID
	, COALESCE(sat_h.[CompanyName], 'Unknown') AS Shipper_Name
	, COALESCE(pit.Is_Deleted_Flag, 0) AS Shipper_Is_Deleted_Flag
FROM
	Information_Mart.bv.PIT_Shipper AS pit
		INNER JOIN Data_Vault.rv.S_H_Shipper_Northwind AS sat_h
			ON pit.HK_H_Shipper__S_H_Shipper_Northwind = sat_h.HK_H_Shipper
		   AND pit.DV_Load_Datetime__S_H_Shipper_Northwind = sat_h.DV_Load_Datetime;
GO




 -- Dim_Territory

DROP VIEW IF EXISTS star.Dim_Territory;
GO

CREATE VIEW star.Dim_Territory (
		  Snapshot_Datetime
		, Dim_Territory_Key
		, Territory_ID
		, Territory_Description
		, Territory_Is_Deleted_Flag
		, Region_ID
		, Region_Description
		, Region_Is_Deleted_Flag
)
AS
SELECT
		  -- Territory
		  pit_territory.DV_Snapshot_Datetime AS Snapshot_Datetime
		, pit_territory.HK_H_Territory AS Dim_Territory_Key
		, pit_territory.TerritoryID AS Territory_ID
		, COALESCE(sat_h_territory.TerritoryDescription, 'Unknown') AS Territory_Description
		, COALESCE(pit_territory.Is_Deleted_Flag, 0) AS Territory_Is_Deleted_Flag

		  -- Region
		, pit_region.RegionID AS Region_ID
		, COALESCE(sat_h_region.RegionDescription, 'Unknown') AS Region_Description
		, COALESCE(pit_region.Is_Deleted_Flag, 0) AS Region_Is_Deleted_Flag
FROM
	Information_Mart.bv.PIT_Territory AS pit_territory
		INNER JOIN Data_Vault.rv.S_H_Territory_Northwind AS sat_h_territory
			ON pit_territory.HK_H_Territory__S_H_Territory_Northwind = sat_h_territory.HK_H_Territory
		   AND pit_territory.DV_Load_Datetime__S_H_Territory_Northwind = sat_h_territory.DV_Load_Datetime
		INNER JOIN Information_Mart.bv.B_Territory_Region AS bridge
			ON pit_territory.DV_Snapshot_Datetime = bridge.DV_Snapshot_Datetime
		   AND pit_territory.HK_H_Territory = bridge.HK_H_Territory
		INNER JOIN Information_Mart.bv.PIT_Region AS pit_region
			ON bridge.DV_Snapshot_Datetime = pit_region.DV_Snapshot_Datetime 
		   AND bridge.HK_H_Region = pit_region.HK_H_Region
		INNER JOIN Data_Vault.rv.S_H_Region_Northwind AS sat_h_region
			ON pit_region.HK_H_Region__S_H_Region_Northwind = sat_h_region.HK_H_Region
		   AND pit_region.DV_Load_Datetime__S_H_Region_Northwind = sat_h_region.DV_Load_Datetime;
GO