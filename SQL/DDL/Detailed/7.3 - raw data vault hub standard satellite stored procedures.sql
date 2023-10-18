/*

	Raw data vault hub standard satellite stored procedures

*/


USE Data_Vault;
GO


-- usp_insert_S_H_Customer_Northwind__L2_Northwind_Customers

DROP PROCEDURE IF EXISTS rv.usp_insert_S_H_Customer_Northwind__L2_Northwind_Customers;
GO

CREATE PROCEDURE rv.usp_insert_S_H_Customer_Northwind__L2_Northwind_Customers 
AS
	BEGIN

		INSERT INTO Data_Vault.rv.S_H_Customer_Northwind (
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
		SELECT 
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
		FROM
			Data_Vault.rv.v_stage_S_H_Customer_Northwind__L2_Northwind_Customers;

	END
GO




-- usp_insert_S_H_Customer_Type_Northwind__L2_Northwind_CustomerDemographics

DROP PROCEDURE IF EXISTS rv.usp_insert_S_H_Customer_Type_Northwind__L2_Northwind_CustomerDemographics;
GO

CREATE PROCEDURE rv.usp_insert_S_H_Customer_Type_Northwind__L2_Northwind_CustomerDemographics
AS
	BEGIN

		INSERT INTO Data_Vault.rv.S_H_Customer_Type_Northwind (
			  HK_H_Customer_Type
			, DV_Load_Datetime
			, DV_Record_Source
			, HD_S_H_Customer_Type_Northwind
			, CustomerDesc
		)
		SELECT
			  HK_H_Customer_Type
			, DV_Load_Datetime
			, DV_Record_Source
			, HD_S_H_Customer_Type_Northwind
			, CustomerDesc
		FROM
			Data_Vault.rv.v_stage_S_H_Customer_Type_Northwind__L2_Northwind_CustomerDemographics;

	END
GO




-- usp_insert_S_H_Employee_Northwind__L2_Northwind_Employees

DROP PROCEDURE IF EXISTS rv.usp_insert_S_H_Employee_Northwind__L2_Northwind_Employees;
GO

CREATE PROCEDURE rv.usp_insert_S_H_Employee_Northwind__L2_Northwind_Employees 
AS
	BEGIN

		INSERT INTO Data_Vault.rv.S_H_Employee_Northwind (
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
		SELECT
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
		FROM
			Data_Vault.rv.v_stage_S_H_Employee_Northwind__L2_Northwind_Employees;

	END
GO




-- usp_insert_S_H_Order_Northwind__L2_Northwind_Orders

DROP PROCEDURE IF EXISTS rv.usp_insert_S_H_Order_Northwind__L2_Northwind_Orders;
GO

CREATE PROCEDURE rv.usp_insert_S_H_Order_Northwind__L2_Northwind_Orders
AS
	BEGIN

		INSERT INTO Data_Vault.rv.S_H_Order_Northwind (
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
		SELECT
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
		FROM
			Data_Vault.rv.v_stage_S_H_Order_Northwind__L2_Northwind_Orders;

	END
GO




-- usp_insert_S_H_Product_Category_Northwind__L2_Northwind_Categories

DROP PROCEDURE IF EXISTS rv.usp_insert_S_H_Product_Category_Northwind__L2_Northwind_Categories;
GO

CREATE PROCEDURE rv.usp_insert_S_H_Product_Category_Northwind__L2_Northwind_Categories
AS
	BEGIN

		INSERT INTO Data_Vault.rv.S_H_Product_Category_Northwind (
			  HK_H_Product_Category
			, DV_Load_Datetime
			, DV_Record_Source
			, HD_S_H_Product_Category_Northwind
			, CategoryName
			, [Description]
			, Picture
		)
		SELECT
			  HK_H_Product_Category
			, DV_Load_Datetime
			, DV_Record_Source
			, HD_S_H_Product_Category_Northwind
			, CategoryName
			, [Description]
			, Picture
		FROM
			Data_Vault.rv.v_stage_S_H_Product_Category_Northwind__L2_Northwind_Categories;

	END
GO




-- usp_insert_S_H_Product_Northwind__L2_Northwind_Products

DROP PROCEDURE IF EXISTS rv.usp_insert_S_H_Product_Northwind__L2_Northwind_Products;
GO

CREATE PROCEDURE rv.usp_insert_S_H_Product_Northwind__L2_Northwind_Products
AS
	BEGIN

		INSERT INTO Data_Vault.rv.S_H_Product_Northwind (
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
		SELECT
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
		FROM
			Data_Vault.rv.v_stage_S_H_Product_Northwind__L2_Northwind_Products;
	
	END
GO




-- usp_insert_S_H_Region_Northwind__L2_Northwind_Region

DROP PROCEDURE IF EXISTS rv.usp_insert_S_H_Region_Northwind__L2_Northwind_Region;
GO

CREATE PROCEDURE rv.usp_insert_S_H_Region_Northwind__L2_Northwind_Region
AS
	BEGIN

		INSERT INTO Data_Vault.rv.S_H_Region_Northwind (
			  HK_H_Region
			, DV_Load_Datetime
			, DV_Record_Source
			, HD_S_H_Region_Northwind
			, RegionDescription
		)
		SELECT
			  HK_H_Region
			, DV_Load_Datetime
			, DV_Record_Source
			, HD_S_H_Region_Northwind
			, RegionDescription
		FROM
			Data_Vault.rv.v_stage_S_H_Region_Northwind__L2_Northwind_Region;

	END
GO




-- usp_insert_S_H_Shipper_Northwind__L2_Northwind_Shippers

DROP PROCEDURE IF EXISTS rv.usp_insert_S_H_Shipper_Northwind__L2_Northwind_Shippers;
GO

CREATE PROCEDURE rv.usp_insert_S_H_Shipper_Northwind__L2_Northwind_Shippers
AS
	BEGIN

		INSERT INTO Data_Vault.rv.S_H_Shipper_Northwind (
			  HK_H_Shipper
			, DV_Load_Datetime
			, DV_Record_Source
			, HD_S_H_Shipper_Northwind
			, CompanyName
			, Phone
		)
		SELECT
			  HK_H_Shipper
			, DV_Load_Datetime
			, DV_Record_Source
			, HD_S_H_Shipper_Northwind
			, CompanyName
			, Phone
		FROM
			Data_Vault.rv.v_stage_S_H_Shipper_Northwind__L2_Northwind_Shippers;

	END
GO




-- usp_insert_S_H_Supplier_Northwind__L2_Northwind_Suppliers

DROP PROCEDURE IF EXISTS rv.usp_insert_S_H_Supplier_Northwind__L2_Northwind_Suppliers;
GO

CREATE PROCEDURE rv.usp_insert_S_H_Supplier_Northwind__L2_Northwind_Suppliers
AS
	BEGIN

		INSERT INTO Data_Vault.rv.S_H_Supplier_Northwind (
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
		SELECT
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
		FROM
			Data_Vault.rv.v_stage_S_H_Supplier_Northwind__L2_Northwind_Suppliers;

	END
GO




-- usp_insert_S_H_Territory_Northwind__L2_Northwind_Territories

DROP PROCEDURE IF EXISTS rv.usp_insert_S_H_Territory_Northwind__L2_Northwind_Territories;
GO

CREATE PROCEDURE rv.usp_insert_S_H_Territory_Northwind__L2_Northwind_Territories
AS
	BEGIN

		INSERT INTO Data_Vault.rv.S_H_Territory_Northwind (
			  HK_H_Territory
			, DV_Load_Datetime
			, DV_Record_Source
			, HD_S_H_Territory_Northwind
			, TerritoryDescription
		)
		SELECT
			  HK_H_Territory
			, DV_Load_Datetime
			, DV_Record_Source
			, HD_S_H_Territory_Northwind
			, TerritoryDescription
		FROM
			Data_Vault.rv.v_stage_S_H_Territory_Northwind__L2_Northwind_Territories;

	END
GO