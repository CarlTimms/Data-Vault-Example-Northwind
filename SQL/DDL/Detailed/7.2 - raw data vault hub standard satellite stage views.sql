/*

	Raw data vault hub standard satellite stage views

*/


USE Data_Vault;
GO


-- v_stage_S_H_Customer_Northwind__L2_Northwind_Customers

DROP VIEW IF EXISTS rv.v_stage_S_H_Customer_Northwind__L2_Northwind_Customers;
GO

CREATE VIEW rv.v_stage_S_H_Customer_Northwind__L2_Northwind_Customers (
	  HK_H_Customer
	, DV_Load_Datetime
	, DV_Record_Source
	, HD_S_H_Customer_Northwind
	, CompanyName
	, ContactName
	, ContactTitle
	, [Address]
	, City
	, Region
	, PostalCode
	, Country
	, Phone
	, Fax
)
AS
SELECT DISTINCT
	  stage.HK_H_Customer
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, stage.DV_Record_Source
	, stage.HD_S_H_Customer_Northwind
	, stage.CompanyName
	, stage.ContactName
	, stage.ContactTitle
	, stage.[Address]
	, stage.City
	, stage.Region
	, stage.PostalCode
	, stage.Country
	, stage.Phone
	, stage.Fax

FROM
	Staging.northwind.L2_Northwind_Customers AS stage
		LEFT OUTER JOIN Data_Vault.rv.S_H_Customer_Northwind AS sat1
			ON stage.HK_H_Customer = sat1.HK_H_Customer
		   AND sat1.DV_Load_Datetime = (
					SELECT
						MAX(sat2.DV_Load_Datetime)
					FROM
						Data_Vault.rv.S_H_Customer_Northwind AS sat2
					WHERE
						sat1.HK_H_Customer = sat2.HK_H_Customer
				)
WHERE
	sat1.HK_H_Customer IS NULL
	OR (
		stage.HK_H_Customer = sat1.HK_H_Customer
		AND stage.HD_S_H_Customer_Northwind <> sat1.HD_S_H_Customer_Northwind
	);
GO




-- v_stage_S_H_Customer_Type_Northwind__L2_Northwind_CustomerDemographics

DROP VIEW IF EXISTS rv.v_stage_S_H_Customer_Type_Northwind__L2_Northwind_CustomerDemographics;
GO

CREATE VIEW rv.v_stage_S_H_Customer_Type_Northwind__L2_Northwind_CustomerDemographics (
	  HK_H_Customer_Type
	, DV_Load_Datetime
	, DV_Record_Source
	, HD_S_H_Customer_Type_Northwind
	, CustomerDesc
)
AS
SELECT DISTINCT
	  stage.HK_H_Customer_Type
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, stage.DV_Record_Source
	, stage.HD_S_H_Customer_Type_Northwind
	, stage.CustomerDesc
FROM
	Staging.northwind.L2_Northwind_CustomerDemographics AS stage
		LEFT OUTER JOIN Data_Vault.rv.S_H_Customer_Type_Northwind AS sat1
			ON stage.HK_H_Customer_Type = sat1.HK_H_Customer_Type
		   AND sat1.DV_Load_Datetime = (
					SELECT
						MAX(sat2.DV_Load_Datetime)
					FROM
						Data_Vault.rv.S_H_Customer_Type_Northwind AS sat2
					WHERE
						sat1.HK_H_Customer_Type = sat2.HK_H_Customer_Type
				)
WHERE
	sat1.HK_H_Customer_Type IS NULL
	OR (
		stage.HK_H_Customer_Type = sat1.HK_H_Customer_Type
		AND stage.HD_S_H_Customer_Type_Northwind<> sat1.HD_S_H_Customer_Type_Northwind
	);
GO




-- v_stage_S_H_Employee_Northwind__L2_Northwind_Employees

DROP VIEW IF EXISTS rv.v_stage_S_H_Employee_Northwind__L2_Northwind_Employees;
GO

CREATE VIEW rv.v_stage_S_H_Employee_Northwind__L2_Northwind_Employees (
	  HK_H_Employee
	, DV_Load_Datetime
	, DV_Record_Source
	, HD_S_H_Employee_Northwind
	, LastName
	, FirstName
	, Title
	, TitleOfCourtesy
	, BirthDate
	, HireDate
	, [Address]
	, City
	, Region
	, PostalCode
	, Country
	, HomePhone
	, Extension
	, Photo
	, Notes
	, PhotoPath
)
AS
SELECT DISTINCT
	  stage.HK_H_Employee
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, stage.DV_Record_Source
	, stage.HD_S_H_Employee_Northwind
	, stage.LastName
	, stage.FirstName
	, stage.Title
	, stage.TitleOfCourtesy
	, stage.BirthDate
	, stage.HireDate
	, stage.[Address]
	, stage.City
	, stage.Region
	, stage.PostalCode
	, stage.Country
	, stage.HomePhone
	, stage.Extension
	, stage.Photo
	, stage.Notes
	, stage.PhotoPath
FROM
	Staging.northwind.L2_Northwind_Employees AS stage
		LEFT OUTER JOIN Data_Vault.rv.S_H_Employee_Northwind AS sat1
			ON stage.HK_H_Employee = sat1.HK_H_Employee
		   AND sat1.DV_Load_Datetime = (
					SELECT
						MAX(sat2.DV_Load_Datetime)
					FROM
						Data_Vault.rv.S_H_Employee_Northwind AS sat2
					WHERE
						sat1.HK_H_Employee = sat2.HK_H_Employee
				)
WHERE
	sat1.HK_H_Employee IS NULL
	OR (
		stage.HK_H_Employee = sat1.HK_H_Employee
		AND stage.HD_S_H_Employee_Northwind <> sat1.HD_S_H_Employee_Northwind
	);
GO




-- v_stage_S_H_Order_Northwind__L2_Northwind_Orders

DROP VIEW IF EXISTS rv.v_stage_S_H_Order_Northwind__L2_Northwind_Orders;
GO

CREATE VIEW rv.v_stage_S_H_Order_Northwind__L2_Northwind_Orders (
	  HK_H_Order
	, DV_Load_Datetime
	, DV_Record_Source
	, HD_S_H_Order_Northwind
	, OrderDate
	, RequiredDate
	, ShippedDate
	, Freight
	, ShipName
	, ShipAddress
	, ShipCity
	, ShipRegion
	, ShipPostalCode
	, ShipCountry
)
AS
SELECT DISTINCT
	  stage.HK_H_Order
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, stage.DV_Record_Source
	, stage.HD_S_H_Order_Northwind
	, stage.OrderDate
	, stage.RequiredDate
	, stage.ShippedDate
	, stage.Freight
	, stage.ShipName
	, stage.ShipAddress
	, stage.ShipCity
	, stage.ShipRegion
	, stage.ShipPostalCode
	, stage.ShipCountry
FROM
	Staging.northwind.L2_Northwind_Orders AS stage
		LEFT OUTER JOIN Data_Vault.rv.S_H_Order_Northwind AS sat1
			ON stage.HK_H_Order = sat1.HK_H_Order
		   AND sat1.DV_Load_Datetime = (
					SELECT
						MAX(sat2.DV_Load_Datetime)
					FROM
						Data_Vault.rv.S_H_Order_Northwind AS sat2
					WHERE
						sat1.HK_H_Order = sat2.HK_H_Order
				)
WHERE
	sat1.HK_H_Order IS NULL
	OR (
		stage.HK_H_Order = sat1.HK_H_Order
		AND stage.HD_S_H_Order_Northwind <> sat1.HD_S_H_Order_Northwind
	);
GO




-- v_stage_S_H_Product_Category_Northwind__L2_Northwind_Categories

DROP VIEW IF EXISTS rv.v_stage_S_H_Product_Category_Northwind__L2_Northwind_Categories;
GO

CREATE VIEW rv.v_stage_S_H_Product_Category_Northwind__L2_Northwind_Categories (
	  HK_H_Product_Category
	, DV_Load_Datetime
	, DV_Record_Source
	, HD_S_H_Product_Category_Northwind
	, CategoryName
	, [Description]
	, Picture
)
AS
SELECT DISTINCT
	  stage.HK_H_Product_Category
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, stage.DV_Record_Source
	, stage.HD_S_H_Product_Category_Northwind
	, stage.CategoryName
	, stage.[Description]
	, stage.Picture
FROM
	Staging.northwind.L2_Northwind_Categories AS stage
		LEFT OUTER JOIN Data_Vault.rv.S_H_Product_Category_Northwind AS sat1
			ON stage.HK_H_Product_Category = sat1.HK_H_Product_Category
		   AND sat1.DV_Load_Datetime = (
					SELECT
						MAX(sat2.DV_Load_Datetime)
					FROM
						Data_Vault.rv.S_H_Product_Category_Northwind AS sat2
					WHERE
						sat1.HK_H_Product_Category = sat2.HK_H_Product_Category
				)
WHERE
	sat1.HK_H_Product_Category IS NULL
	OR (
		stage.HK_H_Product_Category = sat1.HK_H_Product_Category
		AND stage.HD_S_H_Product_Category_Northwind <> sat1.HD_S_H_Product_Category_Northwind
	);
GO




-- v_stage_S_H_Product_Northwind__L2_Northwind_Products

DROP VIEW IF EXISTS rv.v_stage_S_H_Product_Northwind__L2_Northwind_Products;
GO

CREATE VIEW rv.v_stage_S_H_Product_Northwind__L2_Northwind_Products (
	  HK_H_Product
	, DV_Load_Datetime
	, DV_Record_Source
	, HD_S_H_Product_Northwind
	, ProductName
	, QuantityPerUnit
	, UnitPrice
	, UnitsInStock
	, UnitsOnOrder
	, ReorderLevel
	, Discontinued
)
AS
SELECT DISTINCT
	  stage.HK_H_Product
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, stage.DV_Record_Source
	, stage.HD_S_H_Product_Northwind
	, stage.ProductName
	, stage.QuantityPerUnit
	, stage.UnitPrice
	, stage.UnitsInStock
	, stage.UnitsOnOrder
	, stage.ReorderLevel
	, stage.Discontinued
FROM
	Staging.northwind.L2_Northwind_Products AS stage
		LEFT OUTER JOIN Data_Vault.rv.S_H_Product_Northwind AS sat1
			ON stage.HK_H_Product = sat1.HK_H_Product
		   AND sat1.DV_Load_Datetime = (
					SELECT
						MAX(sat2.DV_Load_Datetime)
					FROM
						Data_Vault.rv.S_H_Product_Northwind AS sat2
					WHERE
						sat1.HK_H_Product = sat2.HK_H_Product
				)
WHERE
	sat1.HK_H_Product IS NULL
	OR (
		stage.HK_H_Product = sat1.HK_H_Product
		AND stage.HD_S_H_Product_Northwind <> sat1.HD_S_H_Product_Northwind
	);
GO




-- v_stage_S_H_Region_Northwind__L2_Northwind_Region

DROP VIEW IF EXISTS rv.v_stage_S_H_Region_Northwind__L2_Northwind_Region;
GO

CREATE VIEW rv.v_stage_S_H_Region_Northwind__L2_Northwind_Region (
	  HK_H_Region
	, DV_Load_Datetime
	, DV_Record_Source
	, HD_S_H_Region_Northwind
	, RegionDescription
)
AS
SELECT DISTINCT
	  stage.HK_H_Region
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, stage.DV_Record_Source
	, stage.HD_S_H_Region_Northwind
	, stage.RegionDescription
FROM
	Staging.northwind.L2_Northwind_Region AS stage
		LEFT OUTER JOIN Data_Vault.rv.S_H_Region_Northwind AS sat1
			ON stage.HK_H_Region = sat1.HK_H_Region
		   AND sat1.DV_Load_Datetime = (
					SELECT
						MAX(sat2.DV_Load_Datetime)
					FROM
						Data_Vault.rv.S_H_Region_Northwind AS sat2
					WHERE
						sat1.HK_H_Region = sat2.HK_H_Region
				)
WHERE
	sat1.HK_H_Region IS NULL
	OR (
		stage.HK_H_Region = sat1.HK_H_Region
		AND stage.HD_S_H_Region_Northwind <> sat1.HD_S_H_Region_Northwind
	);
GO




-- v_stage_S_H_Shipper_Northwind__L2_Northwind_Shippers

DROP VIEW IF EXISTS rv.v_stage_S_H_Shipper_Northwind__L2_Northwind_Shippers;
GO

CREATE VIEW rv.v_stage_S_H_Shipper_Northwind__L2_Northwind_Shippers (
	  HK_H_Shipper
	, DV_Load_Datetime
	, DV_Record_Source
	, HD_S_H_Shipper_Northwind
	, CompanyName
	, Phone
)
AS
SELECT DISTINCT
	  stage.HK_H_Shipper
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, stage.DV_Record_Source
	, stage.HD_S_H_Shipper_Northwind
	, stage.CompanyName
	, stage.Phone
FROM
	Staging.northwind.L2_Northwind_Shippers AS stage
		LEFT OUTER JOIN Data_Vault.rv.S_H_Shipper_Northwind AS sat1
			ON stage.HK_H_Shipper = sat1.HK_H_Shipper
		   AND sat1.DV_Load_Datetime = (
					SELECT
						MAX(sat2.DV_Load_Datetime)
					FROM
						Data_Vault.rv.S_H_Shipper_Northwind AS sat2
					WHERE
						sat1.HK_H_Shipper = sat2.HK_H_Shipper
				)
WHERE
	sat1.HK_H_Shipper IS NULL
	OR (
		stage.HK_H_Shipper = sat1.HK_H_Shipper
		AND stage.HD_S_H_Shipper_Northwind <> sat1.HD_S_H_Shipper_Northwind
	);
GO




-- v_stage_S_H_Supplier_Northwind__L2_Northwind_Suppliers

DROP VIEW IF EXISTS rv.v_stage_S_H_Supplier_Northwind__L2_Northwind_Suppliers;
GO

CREATE VIEW rv.v_stage_S_H_Supplier_Northwind__L2_Northwind_Suppliers (
	  HK_H_Supplier
	, DV_Load_Datetime
	, DV_Record_Source
	, HD_S_H_Supplier_Northwind
	, CompanyName
	, ContactName
	, ContactTitle
	, [Address]
	, City
	, Region
	, PostalCode
	, Country
	, Phone
	, Fax
	, HomePage
)
AS
SELECT DISTINCT
	  stage.HK_H_Supplier
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, stage.DV_Record_Source
	, stage.HD_S_H_Supplier_Northwind
	, stage.CompanyName
	, stage.ContactName
	, stage.ContactTitle
	, stage.[Address]
	, stage.City
	, stage.Region
	, stage.PostalCode
	, stage.Country
	, stage.Phone
	, stage.Fax
	, stage.HomePage
FROM
	Staging.northwind.L2_Northwind_Suppliers AS stage
		LEFT OUTER JOIN Data_Vault.rv.S_H_Supplier_Northwind AS sat1
			ON stage.HK_H_Supplier = sat1.HK_H_Supplier
		   AND sat1.DV_Load_Datetime = (
					SELECT
						MAX(sat2.DV_Load_Datetime)
					FROM
						Data_Vault.rv.S_H_Supplier_Northwind AS sat2
					WHERE
						sat1.HK_H_Supplier = sat2.HK_H_Supplier
				)
WHERE
	sat1.HK_H_Supplier IS NULL
	OR (
		stage.HK_H_Supplier = sat1.HK_H_Supplier
		AND stage.HD_S_H_Supplier_Northwind <> sat1.HD_S_H_Supplier_Northwind
	);
GO




-- v_stage_S_H_Territory_Northwind__L2_Northwind_Territories

DROP VIEW IF EXISTS rv.v_stage_S_H_Territory_Northwind__L2_Northwind_Territories;
GO

CREATE VIEW rv.v_stage_S_H_Territory_Northwind__L2_Northwind_Territories (
	  HK_H_Territory
	, DV_Load_Datetime
	, DV_Record_Source
	, HD_S_H_Territory_Northwind
	, TerritoryDescription
)
AS
SELECT DISTINCT
	  stage.HK_H_Territory
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, stage.DV_Record_Source
	, stage.HD_S_H_Territory_Northwind
	, stage.TerritoryDescription
FROM
	Staging.northwind.L2_Northwind_Territories AS stage
		LEFT OUTER JOIN Data_Vault.rv.S_H_Territory_Northwind AS sat1
			ON stage.HK_H_Territory = sat1.HK_H_Territory
		   AND sat1.DV_Load_Datetime = (
					SELECT
						MAX(sat2.DV_Load_Datetime)
					FROM
						Data_Vault.rv.S_H_Territory_Northwind AS sat2
					WHERE
						sat1.HK_H_Territory = sat2.HK_H_Territory
				)
WHERE
	sat1.HK_H_Territory IS NULL
	OR (
		stage.HK_H_Territory = sat1.HK_H_Territory
		AND stage.HD_S_H_Territory_Northwind <> sat1.HD_S_H_Territory_Northwind
	);
GO