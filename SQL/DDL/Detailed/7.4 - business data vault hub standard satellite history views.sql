/*

	Business data vault hub standard satellite history views

*/


USE Data_Vault;
GO


-- v_history_S_H_Customer_Northwind

DROP VIEW IF EXISTS bv.v_history_S_H_Customer_Northwind;
GO

CREATE VIEW bv.v_history_S_H_Customer_Northwind (
	  HK_H_Customer
	, DV_Load_Datetime_Start
	, DV_Load_Datetime_End
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
SELECT
	  HK_H_Customer
	, DV_Load_Datetime AS DV_Load_Datetime_Start
	, LEAD(DATEADD(NS, -100, DV_Load_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_H_Customer ORDER BY DV_Load_Datetime ASC) AS DV_Load_Datetime_End
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
FROM
	Data_Vault.rv.S_H_Customer_Northwind;

GO




-- v_history_S_H_Customer_Type_Northwind

DROP VIEW IF EXISTS bv.v_history_S_H_Customer_Type_Northwind;
GO

CREATE VIEW bv.v_history_S_H_Customer_Type_Northwind (
	  HK_H_Customer_Type
	, DV_Load_Datetime
	, DV_Load_Datetime_Start
	, DV_Load_Datetime_End
	, DV_Record_Source
	, HD_S_H_Customer_Type_Northwind
	, CustomerDesc
)
AS
SELECT
	  HK_H_Customer_Type
	, DV_Load_Datetime
	, DV_Load_Datetime AS DV_Load_Datetime_Start
	, LEAD(DATEADD(NS, -100, DV_Load_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_H_Customer_Type ORDER BY DV_Load_Datetime ASC) AS DV_Load_Datetime_End
	, DV_Record_Source
	, HD_S_H_Customer_Type_Northwind
	, CustomerDesc
FROM
	Data_Vault.rv.S_H_Customer_Type_Northwind;
GO




-- v_history_S_H_Employee_Northwind

DROP VIEW IF EXISTS bv.v_history_S_H_Employee_Northwind;
GO

CREATE VIEW bv.v_history_S_H_Employee_Northwind (
	  HK_H_Employee
	, DV_Load_Datetime_Start
	, DV_Load_Datetime_End
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
SELECT 
	  HK_H_Employee
	, DV_Load_Datetime AS DV_Load_Datetime_Start
	, LEAD(DATEADD(NS, -100, DV_Load_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_H_Employee ORDER BY DV_Load_Datetime ASC) AS DV_Load_Datetime_End
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
FROM
	Data_Vault.rv.S_H_Employee_Northwind;
GO




-- v_history_S_H_Order_Northwind

DROP VIEW IF EXISTS bv.v_history_S_H_Order_Northwind;
GO

CREATE VIEW bv.v_history_S_H_Order_Northwind (
	  HK_H_Order
	, DV_Load_Datetime_Start 
	, DV_Load_Datetime_End
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
SELECT 
	  HK_H_Order
	, DV_Load_Datetime AS DV_Load_Datetime_Start 
	, LEAD(DATEADD(NS, -100, DV_Load_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_H_Order ORDER BY DV_Load_Datetime ASC) AS DV_Load_Datetime_End
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
FROM
	Data_Vault.rv.S_H_Order_Northwind;
GO




-- v_history_S_H_Product_Category_Northwind

DROP VIEW IF EXISTS bv.v_history_S_H_Product_Category_Northwind;
GO

CREATE VIEW bv.v_history_S_H_Product_Category_Northwind (
	  HK_H_Product_Category
	, DV_Load_Datetime_Start
	, DV_Load_Datetime_End
	, DV_Record_Source
	, HD_S_H_Product_Category_Northwind
	, CategoryName
	, [Description]
	, Picture
)
AS
SELECT 
	  HK_H_Product_Category
	, DV_Load_Datetime AS DV_Load_Datetime_Start
	, LEAD(DATEADD(NS, -100, DV_Load_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_H_Product_Category ORDER BY DV_Load_Datetime ASC) AS DV_Load_Datetime_End
	, DV_Record_Source
	, HD_S_H_Product_Category_Northwind
	, CategoryName
	, [Description]
	, Picture
FROM
	Data_Vault.rv.S_H_Product_Category_Northwind;
GO




-- v_history_S_H_Product_Northwind

DROP VIEW IF EXISTS bv.v_history_S_H_Product_Northwind;
GO

CREATE VIEW bv.v_history_S_H_Product_Northwind (
	  HK_H_Product
	, DV_Load_Datetime_Start
	, DV_Load_Datetime_End
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
SELECT
	  HK_H_Product
	, DV_Load_Datetime AS DV_Load_Datetime_Start
	, LEAD(DATEADD(NS, -100, DV_Load_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_H_Product ORDER BY DV_Load_Datetime ASC) AS DV_Load_Datetime_End
	, DV_Record_Source
	, HD_S_H_Product_Northwind
	, ProductName
	, QuantityPerUnit
	, UnitPrice
	, UnitsInStock
	, UnitsOnOrder
	, ReorderLevel
	, Discontinued
FROM
	Data_Vault.rv.S_H_Product_Northwind;
GO




-- v_history_S_H_Region_Northwind

DROP VIEW IF EXISTS bv.v_history_S_H_Region_Northwind;
GO

CREATE VIEW bv.v_history_S_H_Region_Northwind (
	  HK_H_Region
	, DV_Load_Datetime_Start
	, DV_Load_Datetime_End
	, DV_Record_Source
	, HD_S_H_Region_Northwind
	, RegionDescription
)
AS
SELECT
	  HK_H_Region
	, DV_Load_Datetime AS DV_Load_Datetime_Start
	, LEAD(DATEADD(NS, -100, DV_Load_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_H_Region ORDER BY DV_Load_Datetime ASC) AS DV_Load_Datetime_End
	, DV_Record_Source
	, HD_S_H_Region_Northwind
	, RegionDescription
FROM
	Data_Vault.rv.S_H_Region_Northwind;
GO




-- v_history_S_H_Shipper_Northwind

DROP VIEW IF EXISTS bv.v_history_S_H_Shipper_Northwind;
GO

CREATE VIEW bv.v_history_S_H_Shipper_Northwind (
	  HK_H_Shipper
	, DV_Load_Datetime_Start
	, DV_Load_Datetime_End
	, DV_Record_Source
	, HD_S_H_Shipper_Northwind
	, CompanyName
	, Phone
)
AS
SELECT
	  HK_H_Shipper
	, DV_Load_Datetime AS DV_Load_Datetime_Start
	, LEAD(DATEADD(NS, -100, DV_Load_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_H_Shipper ORDER BY DV_Load_Datetime ASC) AS DV_Load_Datetime_End
	, DV_Record_Source
	, HD_S_H_Shipper_Northwind
	, CompanyName
	, Phone
FROM
	Data_Vault.rv.S_H_Shipper_Northwind;
GO




-- v_history_S_H_Supplier_Northwind

DROP VIEW IF EXISTS bv.v_history_S_H_Supplier_Northwind;
GO

CREATE VIEW bv.v_history_S_H_Supplier_Northwind (
	  HK_H_Supplier
	, DV_Load_Datetime_Start
	, DV_Load_Datetime_End
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
SELECT
	  HK_H_Supplier
	, DV_Load_Datetime AS DV_Load_Datetime_Start
	, LEAD(DATEADD(NS, -100, DV_Load_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_H_Supplier ORDER BY DV_Load_Datetime ASC) AS DV_Load_Datetime_End
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
FROM 
	Data_Vault.rv.S_H_Supplier_Northwind;
GO




-- v_history_S_H_Territory_Northwind

DROP VIEW IF EXISTS bv.v_history_S_H_Territory_Northwind;
GO

CREATE VIEW bv.v_history_S_H_Territory_Northwind (
	  HK_H_Territory
	, DV_Load_Datetime_Start
	, DV_Load_Datetime_End
	, DV_Record_Source
	, HD_S_H_Territory_Northwind
	, TerritoryDescription
)
AS
SELECT
	  HK_H_Territory
	, DV_Load_Datetime DV_Load_Datetime_Start
	, LEAD(DATEADD(NS, -100, DV_Load_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_H_Territory ORDER BY DV_Load_Datetime ASC) AS DV_Load_Datetime_End
	, DV_Record_Source
	, HD_S_H_Territory_Northwind
	, TerritoryDescription
FROM
	Data_Vault.rv.S_H_Territory_Northwind;
GO