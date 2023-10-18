/*
	
	Staging level two stage views

*/


USE Staging;
GO


-- v_stage_L2_Northwind_Categories__L1_Northwind_Categories

DROP VIEW IF EXISTS northwind.v_stage_L2_Northwind_Categories__L1_Northwind_Categories;
GO

CREATE VIEW northwind.v_stage_L2_Northwind_Categories__L1_Northwind_Categories (
	  DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Product_Category
	, HD_S_H_Product_Category_Northwind
	, CategoryID
	, CategoryName
	, [Description]
	, Picture
)
AS
SELECT 
	  SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, CAST('Northwind.dbo.Categories' AS varchar(255)) AS DV_Record_Source
	, CAST(
		HASHBYTES(
			  'SHA2_256'
			, UPPER(TRIM(COALESCE(CAST(CategoryID AS nvarchar(10)), '-1')))
	  ) AS binary(32)) AS HK_H_Product_Category
	, CAST(
		HASHBYTES(
			  'SHA2_256'
			, CONCAT(
				  TRIM(COALESCE(CategoryName, '')), '|'
				, TRIM(COALESCE(CAST([Description] AS nvarchar(max)), '')), '|'
				, TRIM(COALESCE(CAST(Picture AS varbinary(max)), ''))
			)
	  ) AS binary(32)) AS HD_S_H_Product_Category_Northwind
	, CAST(COALESCE(CategoryID, -1) AS int) AS CategoryID
	, CategoryName
	, CAST([Description] AS nvarchar(max)) AS [Description]  -- Data type ntext deprecated. use nvarchar(max) instead
	, CAST(Picture AS varbinary(max)) AS Picture  -- Data type image deprecated. Use varbinary(max) instead
FROM 
	northwind.L1_Northwind_Categories;
GO




-- v_stage_L2_Northwind_CustomerCustomerDemo__L1_Northwind_CustomerCustomerDemo

DROP VIEW IF EXISTS northwind.v_stage_L2_Northwind_CustomerCustomerDemo__L1_Northwind_CustomerCustomerDemo;
GO

CREATE VIEW northwind.v_stage_L2_Northwind_CustomerCustomerDemo__L1_Northwind_CustomerCustomerDemo (
	  DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Customer
	, HK_H_Customer_Type
	, HK_L_Customer_Type
	, CustomerID
	, CustomerTypeID
)
AS
SELECT 
	  SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, CAST('Northwind.dbo.CustomerCustomerDemo' AS varchar(255)) AS DV_Record_Source
	, CAST(
		HASHBYTES(
			 'SHA2_256'
			, UPPER(TRIM(COALESCE(CAST(CustomerID AS nvarchar(5)), '-1')))
		) 
	  AS binary(32)) AS HK_H_Customer
	, CAST(
		HASHBYTES(
			  'SHA2_256'
			, UPPER(TRIM(COALESCE(CAST(CustomerTypeID AS nvarchar(10)), '-1')))
		) 
	  AS binary(32)) AS HK_H_Customer_Type
	, CAST(
		HASHBYTES(
			  'SHA2_256'
			, UPPER(
				CONCAT(
					  TRIM(COALESCE(CAST(CustomerID AS nvarchar(5)), '-1')), '|'
					, TRIM(COALESCE(CAST(CustomerTypeID AS nvarchar(10)), '-1'))
				)
			  )
		) 
	  AS binary(32)) AS HK_L_Customer_Type
	, CAST(COALESCE(CustomerID, '-1') AS nchar(5)) AS CustomerID
	, CAST(COALESCE(CustomerTypeID, '-1') AS nchar(10)) AS CustomerTypeID
FROM
	northwind.L1_Northwind_CustomerCustomerDemo;
GO




-- v_stage_L2_Northwind_CustomerDemographics__L1_Northwind_CustomerDemographics

DROP VIEW IF EXISTS northwind.v_stage_L2_Northwind_CustomerDemographics__L1_Northwind_CustomerDemographics;
GO

CREATE VIEW northwind.v_stage_L2_Northwind_CustomerDemographics__L1_Northwind_CustomerDemographics (
	  DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Customer_Type
	, HD_S_H_Customer_Type_Northwind
	, CustomerTypeID
	, CustomerDesc
)
AS
SELECT
	  SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, CAST('Northwind.dbo.CustomerDemographics' AS varchar(255)) AS DV_Record_Source
	, CAST(
		HASHBYTES(
			  'SHA2_256'
			, UPPER(TRIM(COALESCE(CAST(CustomerTypeID AS nvarchar(10)), '-1')))
		) 
	  AS binary(32)) AS HK_H_Customer_Type
	, CAST(
		HASHBYTES(
			  'SHA2_256'
			, TRIM(COALESCE(CAST(CustomerDesc AS nvarchar(max)), ''))
		) 
	  AS binary(32)) AS HD_S_H_Customer_Type_Northwind
	, CAST(COALESCE(CustomerTypeID, '-1') AS nchar(10)) AS CustomerTypeID
	, CAST(CustomerDesc AS nvarchar(max)) AS CustomerDesc  -- Data type ntext deprecated. use nvarchar(max) instead
FROM
	northwind.L1_Northwind_CustomerDemographics;
GO




-- v_stage_L2_Northwind_Customers__L1_Northwind_Customers

DROP VIEW IF EXISTS northwind.v_stage_L2_Northwind_Customers__L1_Northwind_Customers;
GO

CREATE VIEW northwind.v_stage_L2_Northwind_Customers__L1_Northwind_Customers (
	  DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Customer
	, HD_S_H_Customer_Northwind
	, CustomerID
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
	  SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, CAST('Northwind.dbo.Customers' AS varchar(255)) AS DV_Record_Source
	, CAST(
		  HASHBYTES(
			  'SHA2_256'
			, UPPER(TRIM(COALESCE(CAST(CustomerID AS nvarchar(5)), '-1')))
		  ) 
	  AS binary(32)) AS HK_H_Customer
	, CAST(
		HASHBYTES(
			  'SHA2_256'
			, CONCAT(
				  TRIM(COALESCE(CompanyName, '')), '|'
				, TRIM(COALESCE(ContactName, '')), '|'
				, TRIM(COALESCE(ContactTitle, '')), '|'
				, TRIM(COALESCE([Address], '')), '|'
				, TRIM(COALESCE(City, '')), '|'
				, TRIM(COALESCE(Region, '')), '|'
				, TRIM(COALESCE(PostalCode, '')), '|'
				, TRIM(COALESCE(Country, '')), '|'
				, TRIM(COALESCE(Phone, '')), '|'
				, TRIM(COALESCE(Fax, ''))
			  )
		) 
	  AS binary(32)) AS HD_S_H_Customer_Northwind
	, CAST(COALESCE(CustomerID, '-1') AS nchar(5)) AS CustomerID
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
	northwind.L1_Northwind_Customers;
GO




-- v_stage_L2_Northwind_Employees__L1_Northwind_Employees

DROP VIEW IF EXISTS northwind.v_stage_L2_Northwind_Employees__L1_Northwind_Employees;
GO

CREATE VIEW northwind.v_stage_L2_Northwind_Employees__L1_Northwind_Employees (
        DV_Load_Datetime
      , DV_Record_Source
      , HK_H_Employee
      , HK_H_Employee__Manager
      , HK_L_Employee_Reporting_Line
      , HD_S_H_Employee_Northwind
      , EmployeeID
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
      , ReportsTo
      , PhotoPath
)
AS
SELECT
	  SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, CAST('Northwind.dbo.Employees' AS varchar(255)) AS DV_Record_Source
	, CAST(
		HASHBYTES(
			  'SHA2_256'
			, UPPER(TRIM(COALESCE(CAST(EmployeeID AS nvarchar(10)), '-1')))
		) 
	  AS binary(32)) AS HK_H_Employee
	, CAST(
		HASHBYTES(
			  'SHA2_256'
			, UPPER(TRIM(COALESCE(CAST(ReportsTo AS nvarchar(10)), '-2')))
		) 
	  AS binary(32)) AS HK_H_Employee__Manager
	, CAST(
		HASHBYTES(
			  'SHA2_256'
			, UPPER(
				CONCAT(
					  TRIM(COALESCE(CAST(EmployeeID AS nvarchar(10)), '-1')), '|'
					, TRIM(COALESCE(CAST(ReportsTo AS nvarchar(10)), '-2'))
				)
			  )
		) 
	  AS binary(32)) AS HK_L_Employee_Reporting_Line
	, CAST(
		HASHBYTES(
			  'SHA2_256'
			, CONCAT(
				  TRIM(COALESCE(LastName, '')), '|'
				, TRIM(COALESCE(FirstName, '')), '|'
				, TRIM(COALESCE(Title, '')), '|'
				, TRIM(COALESCE(TitleOfCourtesy, '')), '|'
				, TRIM(COALESCE(CONVERT(nvarchar(23), BirthDate, 21), '')), '|'
				, TRIM(COALESCE(CONVERT(nvarchar(23), HireDate, 21), '')), '|'
				, TRIM(COALESCE([Address], '')), '|'
				, TRIM(COALESCE(City, '')), '|'
				, TRIM(COALESCE(Region, '')), '|'
				, TRIM(COALESCE(PostalCode, '')), '|'
				, TRIM(COALESCE(Country, '')), '|'
				, TRIM(COALESCE(HomePhone, '')), '|'
				, TRIM(COALESCE(Extension, '')), '|'
				, TRIM(COALESCE(CAST(Photo AS varbinary(max)), '')), '|'
				, TRIM(COALESCE(CAST(Notes AS nvarchar(max)), '')), '|'
				, TRIM(COALESCE(PhotoPath, ''))
			  )
		) 
	  AS binary(32)) AS HD_S_H_Employee_Northwind
	, CAST(COALESCE(EmployeeID, -1) AS int) AS EmployeeID
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
	, CAST(Photo AS varbinary(max)) AS Photo  -- Data type image deprecated. Use varbinary(max) instead
	, CAST(Notes AS nvarchar(max)) AS Notes  -- Data type ntext deprecated. use nvarchar(max) instead
	, CAST(COALESCE(ReportsTo, -2) AS int) AS ReportsTo
	, PhotoPath
FROM
	northwind.L1_Northwind_Employees;
GO




-- v_stage_L2_Northwind_EmployeeTerritories__L1_Northwind_EmployeeTerritories

DROP VIEW IF EXISTS northwind.v_stage_L2_Northwind_EmployeeTerritories__L1_Northwind_EmployeeTerritories;
GO

CREATE VIEW northwind.v_stage_L2_Northwind_EmployeeTerritories__L1_Northwind_EmployeeTerritories (
	  DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Employee 
	, HK_H_Territory 
	, HK_L_Employee_Territory
	, EmployeeID
	, TerritoryID
)
AS
SELECT
	  SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, CAST('Northwind.dbo.EmployeeTerritories' AS varchar(255)) AS DV_Record_Source
	, CAST(
		HASHBYTES(
			  'SHA2_256'
			, UPPER(TRIM(COALESCE(CAST(EmployeeID AS nvarchar(10)), '-1')))
		) 
	  AS binary(32)) AS HK_H_Employee 
	, CAST(
		HASHBYTES(
			  'SHA2_256'
			, UPPER(TRIM(COALESCE(CAST(TerritoryID AS nvarchar(20)), '-1')))
		) 
	  AS binary(32)) AS HK_H_Territory 
	, CAST( 
		HASHBYTES(
			  'SHA2_256'
			, UPPER(
				CONCAT(
					  TRIM(COALESCE(CAST(EmployeeID AS nvarchar(10)), '-1')), '|'
					, TRIM(COALESCE(CAST(TerritoryID AS nvarchar(20)), '-1'))
				)
			  )
		) 
	  AS binary(32)) AS HK_L_Employee_Territory
	, CAST(COALESCE(EmployeeID, -1) AS int) AS EmployeeID
	, CAST(COALESCE(TerritoryID, '-1') AS nvarchar(20)) AS TerritoryID
FROM
	northwind.L1_Northwind_EmployeeTerritories;
GO




-- v_stage_L2_Northwind_Order_Details__L1_Northwind_Order_Details

DROP VIEW IF EXISTS northwind.v_stage_L2_Northwind_Order_Details__L1_Northwind_Order_Details;
GO

CREATE VIEW northwind.v_stage_L2_Northwind_Order_Details__L1_Northwind_Order_Details (
	  DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Order
	, HK_H_Product
	, HK_L_Order_Detail
	, HD_S_L_Order_Detail_Northwind
	, OrderID
	, ProductID
	, UnitPrice
	, Quantity
	, Discount
)
AS
SELECT
	  SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, CAST('Northwind.dbo.Order Details' AS varchar(255)) AS DV_Record_Source
	, CAST(
		HASHBYTES(
			  'SHA2_256'
			, UPPER(TRIM(COALESCE(CAST(OrderID AS nvarchar(10)), '-1')))
		) 
	  AS binary(32)) AS HK_H_Order
	, CAST(
		HASHBYTES(
			  'SHA2_256'
			, UPPER(TRIM(COALESCE(CAST(ProductID AS nvarchar(10)), '-1')))
		) 
	  AS binary(32)) AS HK_H_Product
	, CAST(
		HASHBYTES(
			  'SHA2_256'
			, UPPER(
				CONCAT(
					  TRIM(COALESCE(CAST(OrderID AS nvarchar(10)), '-1')), '|'
					, TRIM(COALESCE(CAST(ProductID AS nvarchar(10)), '-1'))
				)
			  )
		) 
	  AS binary(32)) AS HK_L_Order_Detail
	, CAST(
		HASHBYTES(
			  'SHA2_256'
			, CONCAT(
				  TRIM(COALESCE(CONVERT(nvarchar(21), UnitPrice, 2), '')), '|'
				, TRIM(COALESCE(CAST(Quantity AS nvarchar(6)), '')), '|'
				, TRIM(COALESCE(CONVERT(nvarchar(50), Discount,3), ''))
			  )
		) 
	  AS binary(32)) AS HD_S_L_Order_Detail_Northwind
	, CAST(COALESCE(OrderID, -1) AS int) AS OrderID
	, CAST(COALESCE(ProductID, -1) AS int) AS ProductID
	, UnitPrice
	, Quantity
	, Discount
FROM
	northwind.L1_Northwind_Order_Details;
GO




-- v_stage_L2_Northwind_Orders__L1_Northwind_Orders

DROP VIEW IF EXISTS northwind.v_stage_L2_Northwind_Orders__L1_Northwind_Orders;
GO

CREATE VIEW northwind.v_stage_L2_Northwind_Orders__L1_Northwind_Orders (
	  DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Order
	, HK_H_Customer
	, HK_H_Employee
	, HK_H_Shipper
	, HK_L_Order_Header
	, HD_S_H_Order_Northwind
	, OrderID
	, CustomerID
	, EmployeeID
	, OrderDate
	, RequiredDate
	, ShippedDate
	, ShipVia
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
	  SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, CAST('Northwind.dbo.Orders' AS varchar(255)) AS DV_Record_Source
	, CAST(
		HASHBYTES(
			  'SHA2_256'
			, UPPER(TRIM(COALESCE(CAST(OrderID AS nvarchar(10)), '-1')))
		) 
	  AS binary(32)) AS HK_H_Order
	, CAST(
		HASHBYTES(
			  'SHA2_256'
			, UPPER(TRIM(COALESCE(CAST(CustomerID AS nvarchar(5)), '-1')))
		) 
	  AS binary(32)) AS HK_H_Customer
	, CAST(
		HASHBYTES(
			  'SHA2_256'
			, UPPER(TRIM(COALESCE(CAST(EmployeeID AS nvarchar(10)), '-1')))
		) 
	  AS binary(32)) AS HK_H_Employee
	, CAST(
		HASHBYTES(
			  'SHA2_256'
			, UPPER(TRIM(COALESCE(CAST(ShipVia AS nvarchar(10)), '-1')))
		) 
	  AS binary(32)) AS HK_H_Shipper
	, CAST(
		HASHBYTES(
			  'SHA2_256'
			, UPPER(
				CONCAT(
					  TRIM(COALESCE(CAST(OrderID AS nvarchar(10)), '-1')), '|'
					, TRIM(COALESCE(CAST(CustomerID AS nvarchar(5)), '-1')), '|'
					, TRIM(COALESCE(CAST(EmployeeID AS nvarchar(10)), '-1')), '|'
					, TRIM(COALESCE(CAST(ShipVia AS nvarchar(10)), '-1'))
				)
			  )
		) 
	  AS binary(32)) AS HK_L_Order_Header
	, CAST(
		HASHBYTES(
			  'SHA2_256'
			, CONCAT(
				  TRIM(COALESCE(CONVERT(nvarchar(23), OrderDate, 21), '')), '|'
				, TRIM(COALESCE(CONVERT(nvarchar(23), RequiredDate, 21), '')), '|'
				, TRIM(COALESCE(CONVERT(nvarchar(23), ShippedDate, 21), '')), '|'
				, TRIM(COALESCE(CONVERT(nvarchar(21), Freight, 2), '')), '|'
				, TRIM(COALESCE(ShipName, '')), '|'
				, TRIM(COALESCE(ShipAddress, '')), '|'
				, TRIM(COALESCE(ShipCity, '')), '|'
				, TRIM(COALESCE(ShipRegion, '')), '|'
				, TRIM(COALESCE(ShipPostalCode, '')), '|'
				, TRIM(COALESCE(ShipCountry, ''))
			  )
		) 
	  AS binary(32)) AS HD_S_H_Order_Northwind
	, CAST(COALESCE(OrderID, -1) AS int) AS OrderID
	, CAST(COALESCE(CustomerID, '-1') AS nchar(5)) AS CustomerID
	, CAST(COALESCE(EmployeeID, -1) AS int) AS EmployeeID
	, OrderDate
	, RequiredDate
	, ShippedDate
	, CAST(COALESCE(ShipVia, -1) AS int) AS ShipVia
	, Freight
	, ShipName
	, ShipAddress
	, ShipCity
	, ShipRegion
	, ShipPostalCode
	, ShipCountry
FROM
	northwind.L1_Northwind_Orders;
GO
	



-- v_stage_L2_Northwind_Products__L1_Northwind_Products

DROP VIEW IF EXISTS northwind.v_stage_L2_Northwind_Products__L1_Northwind_Products;
GO

CREATE VIEW northwind.v_stage_L2_Northwind_Products__L1_Northwind_Products (
	  DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Product
	, HK_H_Supplier
	, HK_H_Product_Category
	, HK_L_Product_Supplier
	, HK_L_Product_Category
	, HD_S_H_Product_Northwind
	, ProductID
	, ProductName
	, SupplierID
	, CategoryID
	, QuantityPerUnit
	, UnitPrice
	, UnitsInStock
	, UnitsOnOrder
	, ReorderLevel
	, Discontinued
)
AS
SELECT
	  SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, CAST('Northwind.dbo.Products' AS varchar(255)) AS DV_Record_Source
	, CAST(
		HASHBYTES(
			  'SHA2_256'
			, UPPER(TRIM(COALESCE(CAST(ProductID AS nvarchar(10)), '-1')))
		) 
	  AS binary(32)) AS HK_H_Product
	, CAST(
		HASHBYTES(
			  'SHA2_256'
			, UPPER(TRIM(COALESCE(CAST(SupplierID AS nvarchar(10)), '-1')))
		) 
	  AS binary(32)) AS HK_H_Supplier
	, CAST(
		HASHBYTES(
			  'SHA2_256'
			, UPPER(TRIM(COALESCE(CAST(CategoryID AS nvarchar(10)), '-1')))
		) 
	  AS binary(32)) AS HK_H_Product_Category
	, CAST(
		HASHBYTES(
			  'SHA2_256'
			, UPPER(
				CONCAT(
					  TRIM(COALESCE(CAST(ProductID AS nvarchar(10)), '-1')), '|'
					, TRIM(COALESCE(CAST(SupplierID AS nvarchar(10)), '-1'))
				)
			  )
		) 
	  AS binary(32)) AS HK_L_Product_Supplier
	, CAST(
		HASHBYTES(
			  'SHA2_256'
			, UPPER(
				CONCAT(
					  TRIM(COALESCE(CAST(ProductID AS nvarchar(10)), '-1')), '|'
					, TRIM(COALESCE(CAST(CategoryID AS nvarchar(10)), '-1'))
				)
			  )
		) 
	  AS binary(32)) AS HK_L_Product_Category 
	, CAST(
		HASHBYTES(
			  'SHA2_256'
			, CONCAT(
				  TRIM(COALESCE(ProductName, '')), '|'
				, TRIM(COALESCE(QuantityPerUnit, '')), '|'
				, TRIM(COALESCE(CONVERT(nvarchar(21), UnitPrice, 2), '')), '|'
				, TRIM(COALESCE(CAST(UnitsInStock AS nvarchar(6)), '')), '|'
				, TRIM(COALESCE(CAST(UnitsOnOrder AS nvarchar(6)), '')), '|'
				, TRIM(COALESCE(CAST(ReorderLevel AS nvarchar(6)), '')), '|'
				, TRIM(COALESCE(CAST(Discontinued AS nvarchar(6)), ''))
			  )
		) 
	  AS binary(32)) AS HD_S_H_Product_Northwind
	, CAST(COALESCE(ProductID, -1) AS int) AS ProductID
	, ProductName
	, CAST(COALESCE(SupplierID, -1) AS int) AS SupplierID
	, CAST(COALESCE(CategoryID, -1) AS int) AS CategoryID
	, QuantityPerUnit
	, UnitPrice
	, UnitsInStock
	, UnitsOnOrder
	, ReorderLevel
	, Discontinued
FROM
	northwind.L1_Northwind_Products;
GO




-- v_stage_L2_Northwind_Region__L1_Northwind_Region

DROP VIEW IF EXISTS northwind.v_stage_L2_Northwind_Region__L1_Northwind_Region;
GO

CREATE VIEW northwind.v_stage_L2_Northwind_Region__L1_Northwind_Region (
	  DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Region
	, HD_S_H_Region_Northwind
	, RegionID
	, RegionDescription
)
AS
SELECT
	  SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, CAST('Northwind.dbo.Region' AS varchar(255)) AS DV_Record_Source
	, CAST(
		HASHBYTES(
			  'SHA2_256'
			, UPPER(TRIM(COALESCE(CAST(RegionID AS nvarchar(10)), '-1')))
		) 
	  AS binary(32)) AS HK_H_Region
	, CAST(
		HASHBYTES(
			  'SHA2_256'
			, TRIM(COALESCE(RegionDescription, ''))
		) 
	  AS binary(32)) AS HD_S_H_Region_Northwind
	, CAST(COALESCE(RegionID, -1) AS int) AS RegionID
	, RegionDescription
FROM
	northwind.L1_Northwind_Region;
GO




-- v_stage_L2_Northwind_Shippers__L1_Northwind_Shippers

DROP VIEW IF EXISTS northwind.v_stage_L2_Northwind_Shippers__L1_Northwind_Shippers;
GO

CREATE VIEW northwind.v_stage_L2_Northwind_Shippers__L1_Northwind_Shippers (
	  DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Shipper
	, HD_S_H_Shipper_Northwind
	, ShipperID
	, CompanyName
	, Phone
)
AS
SELECT
	  SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, CAST('Northwind.dbo.Shippers' AS varchar(255)) AS DV_Record_Source
	, CAST(
		HASHBYTES(
			  'SHA2_256'
			, UPPER(TRIM(COALESCE(CAST(ShipperID AS nvarchar(10)), '-1')))
		) 
	  AS binary(32)) AS HK_H_Shipper
	, CAST(
		HASHBYTES(
			  'SHA2_256'
			, CONCAT(
				  TRIM(COALESCE(CompanyName, '')), '|'
				, TRIM(COALESCE(Phone, ''))
			  )
		) 
	  AS binary(32)) AS HD_S_H_Shipper_Northwind
	, CAST(COALESCE(ShipperID, -1) AS int) AS ShipperID
	, CompanyName
	, Phone
FROM
	northwind.L1_Northwind_Shippers;
GO




-- v_stage_L2_Northwind_Suppliers__L1_Northwind_Suppliers

DROP VIEW IF EXISTS northwind.v_stage_L2_Northwind_Suppliers__L1_Northwind_Suppliers;
GO

CREATE VIEW northwind.v_stage_L2_Northwind_Suppliers__L1_Northwind_Suppliers (
	  DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Supplier
	, HD_S_H_Supplier_Northwind
	, SupplierID
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
	  SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, CAST('Northwind.dbo.Suppliers' AS varchar(255)) AS DV_Record_Source
	, CAST(
		HASHBYTES(
			  'SHA2_256'
			, UPPER(TRIM(COALESCE(CAST(SupplierID AS nvarchar(10)), '-1')))
		) 
	  AS binary(32)) AS HK_H_Supplier
	, CAST(
		HASHBYTES(
			  'SHA2_256'
			, CONCAT(
				  TRIM(COALESCE(CompanyName, '')), '|'
				, TRIM(COALESCE(ContactName, '')), '|'
				, TRIM(COALESCE(ContactTitle, '')), '|'
				, TRIM(COALESCE([Address], '')), '|'
				, TRIM(COALESCE(City, '')), '|'
				, TRIM(COALESCE(Region, '')), '|'
				, TRIM(COALESCE(PostalCode, '')), '|'
				, TRIM(COALESCE(Country, '')), '|'
				, TRIM(COALESCE(Phone, '')), '|'
				, TRIM(COALESCE(Fax, '')), '|'
				, TRIM(COALESCE(CAST(HomePage AS nvarchar(max)), ''))
			  )
		) 
	  AS binary(32)) AS HD_S_H_Supplier_Northwind
	, CAST(COALESCE(SupplierID, -1) AS int) AS SupplierID
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
	, CAST(HomePage AS nvarchar(max)) AS HomePage  -- Data type ntext deprecated. use nvarchar(max) instead
FROM
	northwind.L1_Northwind_Suppliers;
GO




-- v_stage_L2_Northwind_Territories__L1_Northwind_Territories

DROP VIEW IF EXISTS northwind.v_stage_L2_Northwind_Territories__L1_Northwind_Territories;
GO

CREATE VIEW northwind.v_stage_L2_Northwind_Territories__L1_Northwind_Territories (
	  DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Territory
	, HK_H_Region
	, HK_L_Territory_Region
	, HD_S_H_Territory_Northwind
	, TerritoryID
	, TerritoryDescription
	, RegionID
)
AS
SELECT
	  SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, CAST('Northwind.dbo.Territories' AS varchar(255)) AS DV_Record_Source
	, CAST(
		HASHBYTES(
			  'SHA2_256'
			, UPPER(TRIM(COALESCE(CAST(TerritoryID AS nvarchar(20)), '-1')))
		) 
	  AS binary(32)) AS HK_H_Territory
	, CAST(
		HASHBYTES(
			  'SHA2_256'
			, UPPER(TRIM(COALESCE(CAST(RegionID AS nvarchar(10)), '-1')))
		) 
	  AS binary(32)) AS HK_H_Region
	, CAST(
		HASHBYTES(
			  'SHA2_256'
			, UPPER(
				CONCAT(
					  TRIM(COALESCE(CAST(TerritoryID AS nvarchar(20)), '-1')), '|'
					, TRIM(COALESCE(CAST(RegionID AS nvarchar(10)), '-1'))
				)
			  )
		  ) 
	  AS binary(32)) AS HK_L_Territory_Region
	, CAST(
		HASHBYTES(
			  'SHA2_256'
			, TRIM(COALESCE(TerritoryDescription, ''))
		) 
	  AS binary(32)) AS HD_S_H_Territory_Northwind
	, CAST(COALESCE(TerritoryID, '-1') AS nvarchar(20)) AS TerritoryID
	, TerritoryDescription
	, CAST(COALESCE(RegionID, -1) AS int) AS RegionID
FROM
	northwind.L1_Northwind_Territories;
GO