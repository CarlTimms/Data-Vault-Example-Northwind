USE [master]
GO
/****** Object:  Database [Staging]    Script Date: 17/10/2023 5:57:45 pm ******/
CREATE DATABASE [Staging]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'StageArea', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.DATAWAREHOUSE\MSSQL\DATA\StageArea.mdf' , SIZE = 9216KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [DATA] 
( NAME = N'StageArea_data', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.DATAWAREHOUSE\MSSQL\DATA\StageArea_data.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%), 
 FILEGROUP [INDEX] 
( NAME = N'StageArea_index', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.DATAWAREHOUSE\MSSQL\DATA\StageArea_index.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 LOG ON 
( NAME = N'StageArea_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.DATAWAREHOUSE\MSSQL\DATA\StageArea_log.ldf' , SIZE = 17664KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Staging] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Staging].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Staging] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Staging] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Staging] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Staging] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Staging] SET ARITHABORT OFF 
GO
ALTER DATABASE [Staging] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Staging] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Staging] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Staging] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Staging] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Staging] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Staging] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Staging] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Staging] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Staging] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Staging] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Staging] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Staging] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Staging] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Staging] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Staging] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Staging] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Staging] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Staging] SET  MULTI_USER 
GO
ALTER DATABASE [Staging] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Staging] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Staging] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Staging] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Staging] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Staging] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Staging] SET QUERY_STORE = OFF
GO
USE [Staging]
GO
/****** Object:  Schema [northwind]    Script Date: 17/10/2023 5:57:45 pm ******/
CREATE SCHEMA [northwind]
GO
/****** Object:  Table [northwind].[L1_Northwind_Categories]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [northwind].[L1_Northwind_Categories](
	[CategoryID] [int] NULL,
	[CategoryName] [nvarchar](15) NULL,
	[Description] [ntext] NULL,
	[Picture] [image] NULL
) ON [DATA] TEXTIMAGE_ON [DATA]
GO
/****** Object:  View [northwind].[v_stage_L2_Northwind_Categories__L1_Northwind_Categories]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [northwind].[v_stage_L2_Northwind_Categories__L1_Northwind_Categories] (
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
/****** Object:  Table [northwind].[L1_Northwind_CustomerCustomerDemo]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [northwind].[L1_Northwind_CustomerCustomerDemo](
	[CustomerID] [nchar](5) NULL,
	[CustomerTypeID] [nchar](10) NULL
) ON [DATA]
GO
/****** Object:  View [northwind].[v_stage_L2_Northwind_CustomerCustomerDemo__L1_Northwind_CustomerCustomerDemo]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [northwind].[v_stage_L2_Northwind_CustomerCustomerDemo__L1_Northwind_CustomerCustomerDemo] (
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
/****** Object:  Table [northwind].[L1_Northwind_CustomerDemographics]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [northwind].[L1_Northwind_CustomerDemographics](
	[CustomerTypeID] [nchar](10) NULL,
	[CustomerDesc] [ntext] NULL
) ON [DATA] TEXTIMAGE_ON [DATA]
GO
/****** Object:  View [northwind].[v_stage_L2_Northwind_CustomerDemographics__L1_Northwind_CustomerDemographics]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [northwind].[v_stage_L2_Northwind_CustomerDemographics__L1_Northwind_CustomerDemographics] (
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
/****** Object:  Table [northwind].[L1_Northwind_Customers]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [northwind].[L1_Northwind_Customers](
	[CustomerID] [nchar](5) NULL,
	[CompanyName] [nvarchar](40) NULL,
	[ContactName] [nvarchar](30) NULL,
	[ContactTitle] [nvarchar](30) NULL,
	[Address] [nvarchar](60) NULL,
	[City] [nvarchar](15) NULL,
	[Region] [nvarchar](15) NULL,
	[PostalCode] [nvarchar](10) NULL,
	[Country] [nvarchar](15) NULL,
	[Phone] [nvarchar](24) NULL,
	[Fax] [nvarchar](24) NULL
) ON [DATA]
GO
/****** Object:  View [northwind].[v_stage_L2_Northwind_Customers__L1_Northwind_Customers]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [northwind].[v_stage_L2_Northwind_Customers__L1_Northwind_Customers] (
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
/****** Object:  Table [northwind].[L1_Northwind_Employees]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [northwind].[L1_Northwind_Employees](
	[EmployeeID] [int] NULL,
	[LastName] [nvarchar](20) NULL,
	[FirstName] [nvarchar](10) NULL,
	[Title] [nvarchar](30) NULL,
	[TitleOfCourtesy] [nvarchar](25) NULL,
	[BirthDate] [datetime] NULL,
	[HireDate] [datetime] NULL,
	[Address] [nvarchar](60) NULL,
	[City] [nvarchar](15) NULL,
	[Region] [nvarchar](15) NULL,
	[PostalCode] [nvarchar](10) NULL,
	[Country] [nvarchar](15) NULL,
	[HomePhone] [nvarchar](24) NULL,
	[Extension] [nvarchar](4) NULL,
	[Photo] [image] NULL,
	[Notes] [ntext] NULL,
	[ReportsTo] [int] NULL,
	[PhotoPath] [nvarchar](255) NULL
) ON [DATA] TEXTIMAGE_ON [DATA]
GO
/****** Object:  View [northwind].[v_stage_L2_Northwind_Employees__L1_Northwind_Employees]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [northwind].[v_stage_L2_Northwind_Employees__L1_Northwind_Employees] (
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
/****** Object:  Table [northwind].[L1_Northwind_EmployeeTerritories]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [northwind].[L1_Northwind_EmployeeTerritories](
	[EmployeeID] [int] NULL,
	[TerritoryID] [nvarchar](20) NULL
) ON [DATA]
GO
/****** Object:  View [northwind].[v_stage_L2_Northwind_EmployeeTerritories__L1_Northwind_EmployeeTerritories]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [northwind].[v_stage_L2_Northwind_EmployeeTerritories__L1_Northwind_EmployeeTerritories] (
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
/****** Object:  Table [northwind].[L1_Northwind_Order_Details]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [northwind].[L1_Northwind_Order_Details](
	[OrderID] [int] NULL,
	[ProductID] [int] NULL,
	[UnitPrice] [money] NULL,
	[Quantity] [smallint] NULL,
	[Discount] [real] NULL
) ON [DATA]
GO
/****** Object:  View [northwind].[v_stage_L2_Northwind_Order_Details__L1_Northwind_Order_Details]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [northwind].[v_stage_L2_Northwind_Order_Details__L1_Northwind_Order_Details] (
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
/****** Object:  Table [northwind].[L1_Northwind_Orders]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [northwind].[L1_Northwind_Orders](
	[OrderID] [int] NULL,
	[CustomerID] [nchar](5) NULL,
	[EmployeeID] [int] NULL,
	[OrderDate] [datetime] NULL,
	[RequiredDate] [datetime] NULL,
	[ShippedDate] [datetime] NULL,
	[ShipVia] [int] NULL,
	[Freight] [money] NULL,
	[ShipName] [nvarchar](40) NULL,
	[ShipAddress] [nvarchar](60) NULL,
	[ShipCity] [nvarchar](15) NULL,
	[ShipRegion] [nvarchar](15) NULL,
	[ShipPostalCode] [nvarchar](10) NULL,
	[ShipCountry] [nvarchar](15) NULL
) ON [DATA]
GO
/****** Object:  View [northwind].[v_stage_L2_Northwind_Orders__L1_Northwind_Orders]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [northwind].[v_stage_L2_Northwind_Orders__L1_Northwind_Orders] (
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
/****** Object:  Table [northwind].[L1_Northwind_Products]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [northwind].[L1_Northwind_Products](
	[ProductID] [int] NULL,
	[ProductName] [nvarchar](40) NULL,
	[SupplierID] [int] NULL,
	[CategoryID] [int] NULL,
	[QuantityPerUnit] [nvarchar](20) NULL,
	[UnitPrice] [money] NULL,
	[UnitsInStock] [smallint] NULL,
	[UnitsOnOrder] [smallint] NULL,
	[ReorderLevel] [smallint] NULL,
	[Discontinued] [bit] NULL
) ON [DATA]
GO
/****** Object:  View [northwind].[v_stage_L2_Northwind_Products__L1_Northwind_Products]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [northwind].[v_stage_L2_Northwind_Products__L1_Northwind_Products] (
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
/****** Object:  Table [northwind].[L1_Northwind_Region]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [northwind].[L1_Northwind_Region](
	[RegionID] [int] NULL,
	[RegionDescription] [nchar](50) NULL
) ON [DATA]
GO
/****** Object:  View [northwind].[v_stage_L2_Northwind_Region__L1_Northwind_Region]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [northwind].[v_stage_L2_Northwind_Region__L1_Northwind_Region] (
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
/****** Object:  Table [northwind].[L1_Northwind_Shippers]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [northwind].[L1_Northwind_Shippers](
	[ShipperID] [int] NULL,
	[CompanyName] [nvarchar](40) NULL,
	[Phone] [nvarchar](24) NULL
) ON [DATA]
GO
/****** Object:  View [northwind].[v_stage_L2_Northwind_Shippers__L1_Northwind_Shippers]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [northwind].[v_stage_L2_Northwind_Shippers__L1_Northwind_Shippers] (
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
/****** Object:  Table [northwind].[L1_Northwind_Suppliers]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [northwind].[L1_Northwind_Suppliers](
	[SupplierID] [int] NULL,
	[CompanyName] [nvarchar](40) NULL,
	[ContactName] [nvarchar](30) NULL,
	[ContactTitle] [nvarchar](30) NULL,
	[Address] [nvarchar](60) NULL,
	[City] [nvarchar](15) NULL,
	[Region] [nvarchar](15) NULL,
	[PostalCode] [nvarchar](10) NULL,
	[Country] [nvarchar](15) NULL,
	[Phone] [nvarchar](24) NULL,
	[Fax] [nvarchar](24) NULL,
	[HomePage] [ntext] NULL
) ON [DATA] TEXTIMAGE_ON [DATA]
GO
/****** Object:  View [northwind].[v_stage_L2_Northwind_Suppliers__L1_Northwind_Suppliers]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [northwind].[v_stage_L2_Northwind_Suppliers__L1_Northwind_Suppliers] (
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
/****** Object:  Table [northwind].[L1_Northwind_Territories]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [northwind].[L1_Northwind_Territories](
	[TerritoryID] [nvarchar](20) NULL,
	[TerritoryDescription] [nchar](50) NULL,
	[RegionID] [int] NULL
) ON [DATA]
GO
/****** Object:  View [northwind].[v_stage_L2_Northwind_Territories__L1_Northwind_Territories]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [northwind].[v_stage_L2_Northwind_Territories__L1_Northwind_Territories] (
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
/****** Object:  View [northwind].[v_stage_L1_Northwind_Categories]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [northwind].[v_stage_L1_Northwind_Categories] (
	  CategoryID
	, CategoryName
	, [Description]
	, Picture
)
AS
SELECT 
	  CategoryID
	, CategoryName
	, [Description]
	, Picture
FROM
	Northwind.dbo.Categories;
GO
/****** Object:  View [northwind].[v_stage_L1_Northwind_CustomerCustomerDemo]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [northwind].[v_stage_L1_Northwind_CustomerCustomerDemo] (
	  CustomerID
	, CustomerTypeID
)
AS
SELECT 
	  CustomerID
	, CustomerTypeID
FROM
	Northwind.dbo.CustomerCustomerDemo;
GO
/****** Object:  View [northwind].[v_stage_L1_Northwind_CustomerDemographics]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [northwind].[v_stage_L1_Northwind_CustomerDemographics] (
	  CustomerTypeID
	, CustomerDesc
)
AS
SELECT
	  CustomerTypeID
	, CustomerDesc
FROM
	Northwind.dbo.CustomerDemographics;
GO
/****** Object:  View [northwind].[v_stage_L1_Northwind_Customers]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [northwind].[v_stage_L1_Northwind_Customers] (
	  CustomerID
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
	  CustomerID
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
	Northwind.dbo.Customers;
GO
/****** Object:  View [northwind].[v_stage_L1_Northwind_Employees]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [northwind].[v_stage_L1_Northwind_Employees] (
	  EmployeeID
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
	  EmployeeID
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
FROM
	Northwind.dbo.Employees;
GO
/****** Object:  View [northwind].[v_stage_L1_Northwind_EmployeeTerritories]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [northwind].[v_stage_L1_Northwind_EmployeeTerritories] (
	  EmployeeID
	, TerritoryID
)
AS
SELECT
	  EmployeeID
	, TerritoryID
FROM
	Northwind.dbo.EmployeeTerritories;
GO
/****** Object:  View [northwind].[v_stage_L1_Northwind_Order_Details]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [northwind].[v_stage_L1_Northwind_Order_Details] (
	  OrderID
	, ProductID
	, UnitPrice
	, Quantity
	, Discount
)
AS
SELECT 
	  OrderID
	, ProductID
	, UnitPrice
	, Quantity
	, Discount
FROM
	Northwind.dbo.[Order Details];
GO
/****** Object:  View [northwind].[v_stage_L1_Northwind_Orders]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [northwind].[v_stage_L1_Northwind_Orders] (
	  OrderID
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
	  OrderID
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
FROM
	Northwind.dbo.Orders;
GO
/****** Object:  View [northwind].[v_stage_L1_Northwind_Products]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [northwind].[v_stage_L1_Northwind_Products] (
	  ProductID
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
	  ProductID
	, ProductName
	, SupplierID
	, CategoryID
	, QuantityPerUnit
	, UnitPrice
	, UnitsInStock
	, UnitsOnOrder
	, ReorderLevel
	, Discontinued
FROM
	Northwind.dbo.Products;
GO
/****** Object:  View [northwind].[v_stage_L1_Northwind_Region]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [northwind].[v_stage_L1_Northwind_Region] (
	  RegionID
	, RegionDescription
)
AS
SELECT
	  RegionID
	, RegionDescription
FROM
	Northwind.dbo.Region;
GO
/****** Object:  View [northwind].[v_stage_L1_Northwind_Shippers]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [northwind].[v_stage_L1_Northwind_Shippers] (
	  ShipperID
	, CompanyName
	, Phone
)
AS
SELECT 
	  ShipperID
	, CompanyName
	, Phone
FROM
	Northwind.dbo.Shippers;
GO
/****** Object:  View [northwind].[v_stage_L1_Northwind_Suppliers]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [northwind].[v_stage_L1_Northwind_Suppliers] (
	  SupplierID
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
	  SupplierID
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
	Northwind.dbo.Suppliers;
GO
/****** Object:  View [northwind].[v_stage_L1_Northwind_Territories]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [northwind].[v_stage_L1_Northwind_Territories] (
	  TerritoryID
	, TerritoryDescription
	, RegionID
)
AS
SELECT
	  TerritoryID
	, TerritoryDescription
	, RegionID
FROM
	Northwind.dbo.Territories;
GO
/****** Object:  Table [northwind].[L2_Northwind_Categories]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [northwind].[L2_Northwind_Categories](
	[DV_Sequence_Number] [int] IDENTITY(1,1) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HK_H_Product_Category] [binary](32) NOT NULL,
	[HD_S_H_Product_Category_Northwind] [binary](32) NOT NULL,
	[CategoryID] [int] NULL,
	[CategoryName] [nvarchar](15) NULL,
	[Description] [nvarchar](max) NULL,
	[Picture] [varbinary](max) NULL,
 CONSTRAINT [PK_L2_Northwind_Categories] PRIMARY KEY CLUSTERED 
(
	[DV_Sequence_Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX] TEXTIMAGE_ON [DATA]
GO
/****** Object:  Table [northwind].[L2_Northwind_CustomerCustomerDemo]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [northwind].[L2_Northwind_CustomerCustomerDemo](
	[DV_Sequence_Number] [int] IDENTITY(1,1) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HK_H_Customer] [binary](32) NOT NULL,
	[HK_H_Customer_Type] [binary](32) NOT NULL,
	[HK_L_Customer_Type] [binary](32) NOT NULL,
	[CustomerID] [nchar](5) NULL,
	[CustomerTypeID] [nchar](10) NULL,
 CONSTRAINT [PK_L2_Northwind_CustomerCustomerDemo] PRIMARY KEY CLUSTERED 
(
	[DV_Sequence_Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  Table [northwind].[L2_Northwind_CustomerDemographics]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [northwind].[L2_Northwind_CustomerDemographics](
	[DV_Sequence_Number] [int] IDENTITY(1,1) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HK_H_Customer_Type] [binary](32) NOT NULL,
	[HD_S_H_Customer_Type_Northwind] [binary](32) NOT NULL,
	[CustomerTypeID] [nchar](10) NULL,
	[CustomerDesc] [nvarchar](max) NULL,
 CONSTRAINT [PK_L2_Northwind_CustomerDemographics] PRIMARY KEY CLUSTERED 
(
	[DV_Sequence_Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX] TEXTIMAGE_ON [DATA]
GO
/****** Object:  Table [northwind].[L2_Northwind_Customers]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [northwind].[L2_Northwind_Customers](
	[DV_Sequence_Number] [int] IDENTITY(1,1) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HK_H_Customer] [binary](32) NOT NULL,
	[HD_S_H_Customer_Northwind] [binary](32) NOT NULL,
	[CustomerID] [nchar](5) NULL,
	[CompanyName] [nvarchar](40) NULL,
	[ContactName] [nvarchar](30) NULL,
	[ContactTitle] [nvarchar](30) NULL,
	[Address] [nvarchar](60) NULL,
	[City] [nvarchar](15) NULL,
	[Region] [nvarchar](15) NULL,
	[PostalCode] [nvarchar](10) NULL,
	[Country] [nvarchar](15) NULL,
	[Phone] [nvarchar](24) NULL,
	[Fax] [nvarchar](24) NULL,
 CONSTRAINT [PK_L2_Northwind_Customers] PRIMARY KEY CLUSTERED 
(
	[DV_Sequence_Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  Table [northwind].[L2_Northwind_Employees]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [northwind].[L2_Northwind_Employees](
	[DV_Sequence_Number] [int] IDENTITY(1,1) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HK_H_Employee] [binary](32) NOT NULL,
	[HK_H_Employee__Manager] [binary](32) NOT NULL,
	[HK_L_Employee_Reporting_Line] [binary](32) NOT NULL,
	[HD_S_H_Employee_Northwind] [binary](32) NOT NULL,
	[EmployeeID] [int] NULL,
	[LastName] [nvarchar](20) NULL,
	[FirstName] [nvarchar](10) NULL,
	[Title] [nvarchar](30) NULL,
	[TitleOfCourtesy] [nvarchar](25) NULL,
	[BirthDate] [datetime] NULL,
	[HireDate] [datetime] NULL,
	[Address] [nvarchar](60) NULL,
	[City] [nvarchar](15) NULL,
	[Region] [nvarchar](15) NULL,
	[PostalCode] [nvarchar](10) NULL,
	[Country] [nvarchar](15) NULL,
	[HomePhone] [nvarchar](24) NULL,
	[Extension] [nvarchar](4) NULL,
	[Photo] [varbinary](max) NULL,
	[Notes] [nvarchar](max) NULL,
	[ReportsTo] [int] NULL,
	[PhotoPath] [nvarchar](255) NULL,
 CONSTRAINT [PK_L2_Northwind_Employees] PRIMARY KEY CLUSTERED 
(
	[DV_Sequence_Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX] TEXTIMAGE_ON [DATA]
GO
/****** Object:  Table [northwind].[L2_Northwind_EmployeeTerritories]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [northwind].[L2_Northwind_EmployeeTerritories](
	[DV_Sequence_Number] [int] IDENTITY(1,1) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HK_H_Employee] [binary](32) NOT NULL,
	[HK_H_Territory] [binary](32) NOT NULL,
	[HK_L_Employee_Territory] [binary](32) NOT NULL,
	[EmployeeID] [int] NULL,
	[TerritoryID] [nvarchar](20) NULL,
 CONSTRAINT [PK_L2_Northwind_EmployeeTerritories] PRIMARY KEY CLUSTERED 
(
	[DV_Sequence_Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  Table [northwind].[L2_Northwind_Order_Details]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [northwind].[L2_Northwind_Order_Details](
	[DV_Sequence_Number] [int] IDENTITY(1,1) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HK_H_Order] [binary](32) NOT NULL,
	[HK_H_Product] [binary](32) NOT NULL,
	[HK_L_Order_Detail] [binary](32) NOT NULL,
	[HD_S_L_Order_Detail_Northwind] [binary](32) NOT NULL,
	[OrderID] [int] NULL,
	[ProductID] [int] NULL,
	[UnitPrice] [money] NULL,
	[Quantity] [smallint] NULL,
	[Discount] [real] NULL,
 CONSTRAINT [PK_L2_Northwind_Order_Details] PRIMARY KEY CLUSTERED 
(
	[DV_Sequence_Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  Table [northwind].[L2_Northwind_Orders]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [northwind].[L2_Northwind_Orders](
	[DV_Sequence_Number] [int] IDENTITY(1,1) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HK_H_Order] [binary](32) NOT NULL,
	[HK_H_Customer] [binary](32) NOT NULL,
	[HK_H_Employee] [binary](32) NOT NULL,
	[HK_H_Shipper] [binary](32) NOT NULL,
	[HK_L_Order_Header] [binary](32) NOT NULL,
	[HD_S_H_Order_Northwind] [binary](32) NOT NULL,
	[OrderID] [int] NULL,
	[CustomerID] [nchar](5) NULL,
	[EmployeeID] [int] NULL,
	[OrderDate] [datetime] NULL,
	[RequiredDate] [datetime] NULL,
	[ShippedDate] [datetime] NULL,
	[ShipVia] [int] NULL,
	[Freight] [money] NULL,
	[ShipName] [nvarchar](40) NULL,
	[ShipAddress] [nvarchar](60) NULL,
	[ShipCity] [nvarchar](15) NULL,
	[ShipRegion] [nvarchar](15) NULL,
	[ShipPostalCode] [nvarchar](10) NULL,
	[ShipCountry] [nvarchar](15) NULL,
 CONSTRAINT [PK_L2_Northwind_Orders] PRIMARY KEY CLUSTERED 
(
	[DV_Sequence_Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  Table [northwind].[L2_Northwind_Products]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [northwind].[L2_Northwind_Products](
	[DV_Sequence_Number] [int] IDENTITY(1,1) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HK_H_Product] [binary](32) NOT NULL,
	[HK_H_Supplier] [binary](32) NOT NULL,
	[HK_H_Product_Category] [binary](32) NOT NULL,
	[HK_L_Product_Supplier] [binary](32) NOT NULL,
	[HK_L_Product_Category] [binary](32) NOT NULL,
	[HD_S_H_Product_Northwind] [binary](32) NOT NULL,
	[ProductID] [int] NULL,
	[ProductName] [nvarchar](40) NULL,
	[SupplierID] [int] NULL,
	[CategoryID] [int] NULL,
	[QuantityPerUnit] [nvarchar](20) NULL,
	[UnitPrice] [money] NULL,
	[UnitsInStock] [smallint] NULL,
	[UnitsOnOrder] [smallint] NULL,
	[ReorderLevel] [smallint] NULL,
	[Discontinued] [bit] NULL,
 CONSTRAINT [PK_L2_Northwind_Products] PRIMARY KEY CLUSTERED 
(
	[DV_Sequence_Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  Table [northwind].[L2_Northwind_Region]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [northwind].[L2_Northwind_Region](
	[DV_Sequence_Number] [int] IDENTITY(1,1) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HK_H_Region] [binary](32) NOT NULL,
	[HD_S_H_Region_Northwind] [binary](32) NOT NULL,
	[RegionID] [int] NULL,
	[RegionDescription] [nchar](50) NULL,
 CONSTRAINT [PK_L2_Northwind_Region] PRIMARY KEY CLUSTERED 
(
	[DV_Sequence_Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  Table [northwind].[L2_Northwind_Shippers]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [northwind].[L2_Northwind_Shippers](
	[DV_Sequence_Number] [int] IDENTITY(1,1) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HK_H_Shipper] [binary](32) NOT NULL,
	[HD_S_H_Shipper_Northwind] [binary](32) NOT NULL,
	[ShipperID] [int] NULL,
	[CompanyName] [nvarchar](40) NULL,
	[Phone] [nvarchar](24) NULL,
 CONSTRAINT [PK_L2_Northwind_Shippers] PRIMARY KEY CLUSTERED 
(
	[DV_Sequence_Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  Table [northwind].[L2_Northwind_Suppliers]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [northwind].[L2_Northwind_Suppliers](
	[DV_Sequence_Number] [int] IDENTITY(1,1) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HK_H_Supplier] [binary](32) NOT NULL,
	[HD_S_H_Supplier_Northwind] [binary](32) NOT NULL,
	[SupplierID] [int] NULL,
	[CompanyName] [nvarchar](40) NULL,
	[ContactName] [nvarchar](30) NULL,
	[ContactTitle] [nvarchar](30) NULL,
	[Address] [nvarchar](60) NULL,
	[City] [nvarchar](15) NULL,
	[Region] [nvarchar](15) NULL,
	[PostalCode] [nvarchar](10) NULL,
	[Country] [nvarchar](15) NULL,
	[Phone] [nvarchar](24) NULL,
	[Fax] [nvarchar](24) NULL,
	[HomePage] [nvarchar](max) NULL,
 CONSTRAINT [PK_L2_Northwind_Suppliers] PRIMARY KEY CLUSTERED 
(
	[DV_Sequence_Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX] TEXTIMAGE_ON [DATA]
GO
/****** Object:  Table [northwind].[L2_Northwind_Territories]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [northwind].[L2_Northwind_Territories](
	[DV_Sequence_Number] [int] IDENTITY(1,1) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HK_H_Territory] [binary](32) NOT NULL,
	[HK_H_Region] [binary](32) NOT NULL,
	[HK_L_Territory_Region] [binary](32) NOT NULL,
	[HD_S_H_Territory_Northwind] [binary](32) NOT NULL,
	[TerritoryID] [nvarchar](20) NULL,
	[TerritoryDescription] [nchar](50) NULL,
	[RegionID] [int] NULL,
 CONSTRAINT [PK_L2_Northwind_Territories] PRIMARY KEY CLUSTERED 
(
	[DV_Sequence_Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  StoredProcedure [northwind].[usp_insert_L1_Northwind_Categories]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [northwind].[usp_insert_L1_Northwind_Categories] 
AS
	BEGIN

		TRUNCATE TABLE northwind.L1_Northwind_Categories;

		INSERT INTO northwind.L1_Northwind_Categories (
			  CategoryID
			, CategoryName
			, [Description]
			, Picture
		)
		SELECT
			  CategoryID
			, CategoryName
			, [Description]
			, Picture
		FROM
			northwind.v_stage_L1_Northwind_Categories;

	END
GO
/****** Object:  StoredProcedure [northwind].[usp_insert_L1_Northwind_CustomerCustomerDemo]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [northwind].[usp_insert_L1_Northwind_CustomerCustomerDemo]
AS
	BEGIN

		TRUNCATE TABLE northwind.L1_Northwind_CustomerCustomerDemo;

		INSERT INTO northwind.L1_Northwind_CustomerCustomerDemo (
			  CustomerID
			, CustomerTypeID
		)
		SELECT
			  CustomerID
			, CustomerTypeID
		FROM
			northwind.v_stage_L1_Northwind_CustomerCustomerDemo;

	END
GO
/****** Object:  StoredProcedure [northwind].[usp_insert_L1_Northwind_CustomerDemographics]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [northwind].[usp_insert_L1_Northwind_CustomerDemographics]
AS
	BEGIN
		
		TRUNCATE TABLE northwind.L1_Northwind_CustomerDemographics;
		
		INSERT INTO northwind.L1_Northwind_CustomerDemographics (
			  CustomerTypeID
			, CustomerDesc
		)
		SELECT
			  CustomerTypeID
			, CustomerDesc
		FROM
			northwind.v_stage_L1_Northwind_CustomerDemographics;

	END
GO
/****** Object:  StoredProcedure [northwind].[usp_insert_L1_Northwind_Customers]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [northwind].[usp_insert_L1_Northwind_Customers]
AS
	BEGIN

		TRUNCATE TABLE northwind.L1_Northwind_Customers;

		INSERT INTO northwind.L1_Northwind_Customers (
			  CustomerID
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
			  CustomerID
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
			northwind.v_stage_L1_Northwind_Customers;

	END
GO
/****** Object:  StoredProcedure [northwind].[usp_insert_L1_Northwind_Employees]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [northwind].[usp_insert_L1_Northwind_Employees]
AS
	BEGIN
	
		TRUNCATE TABLE northwind.L1_Northwind_Employees;

		INSERT INTO northwind.L1_Northwind_Employees (
			  EmployeeID
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
		SELECT 
			  EmployeeID
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
		FROM
			northwind.v_stage_L1_Northwind_Employees;
	
	END
GO
/****** Object:  StoredProcedure [northwind].[usp_insert_L1_Northwind_EmployeeTerritories]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [northwind].[usp_insert_L1_Northwind_EmployeeTerritories]
AS
	BEGIN
	
		TRUNCATE TABLE northwind.L1_Northwind_EmployeeTerritories;

		INSERT INTO northwind.L1_Northwind_EmployeeTerritories (
			  EmployeeID
			, TerritoryID	
		)
		SELECT
			  EmployeeID
			, TerritoryID
		FROM
			northwind.v_stage_L1_Northwind_EmployeeTerritories;
	
	END
GO
/****** Object:  StoredProcedure [northwind].[usp_insert_L1_Northwind_Order_Details]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [northwind].[usp_insert_L1_Northwind_Order_Details]
AS
	BEGIN
	
		TRUNCATE TABLE northwind.L1_Northwind_Order_Details;

		INSERT INTO northwind.L1_Northwind_Order_Details (
			  OrderID
			, ProductID
			, UnitPrice
			, Quantity
			, Discount	
		)
		SELECT
			  OrderID
			, ProductID
			, UnitPrice
			, Quantity
			, Discount
		FROM
			northwind.v_stage_L1_Northwind_Order_Details;
	
	END
GO
/****** Object:  StoredProcedure [northwind].[usp_insert_L1_Northwind_Orders]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [northwind].[usp_insert_L1_Northwind_Orders]
AS
	BEGIN
	
		TRUNCATE TABLE northwind.L1_Northwind_Orders;

		INSERT INTO northwind.L1_Northwind_Orders (
			  OrderID
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
		SELECT
			  OrderID
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
		FROM
			northwind.v_stage_L1_Northwind_Orders;
	
	END
GO
/****** Object:  StoredProcedure [northwind].[usp_insert_L1_Northwind_Products]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [northwind].[usp_insert_L1_Northwind_Products]
AS
	BEGIN
	
		TRUNCATE TABLE northwind.L1_Northwind_Products;

		INSERT INTO northwind.L1_Northwind_Products (
			  ProductID
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
		SELECT 
			  ProductID
			, ProductName
			, SupplierID
			, CategoryID
			, QuantityPerUnit
			, UnitPrice
			, UnitsInStock
			, UnitsOnOrder
			, ReorderLevel
			, Discontinued
		FROM
			northwind.v_stage_L1_Northwind_Products;
	
	END
GO
/****** Object:  StoredProcedure [northwind].[usp_insert_L1_Northwind_Region]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [northwind].[usp_insert_L1_Northwind_Region]
AS
	BEGIN
	
		TRUNCATE TABLE northwind.L1_Northwind_Region;

		INSERT INTO northwind.L1_Northwind_Region (
			  RegionID
			, RegionDescription	
		)
		SELECT
			  RegionID
			, RegionDescription
		FROM
			northwind.v_stage_L1_Northwind_Region;
	
	END
GO
/****** Object:  StoredProcedure [northwind].[usp_insert_L1_Northwind_Shippers]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [northwind].[usp_insert_L1_Northwind_Shippers]
AS
	BEGIN
	
		TRUNCATE TABLE northwind.L1_Northwind_Shippers;

		INSERT INTO northwind.L1_Northwind_Shippers (
			  ShipperID
			, CompanyName
			, Phone	
		)
		SELECT
			  ShipperID
			, CompanyName
			, Phone
		FROM
			northwind.v_stage_L1_Northwind_Shippers;
	
	END
GO
/****** Object:  StoredProcedure [northwind].[usp_insert_L1_Northwind_Suppliers]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [northwind].[usp_insert_L1_Northwind_Suppliers]
AS
	BEGIN
	
		TRUNCATE TABLE northwind.L1_Northwind_Suppliers;

		INSERT INTO northwind.L1_Northwind_Suppliers (
			  SupplierID
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
			  SupplierID
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
			northwind.v_stage_L1_Northwind_Suppliers;
	
	END
GO
/****** Object:  StoredProcedure [northwind].[usp_insert_L1_Northwind_Territories]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [northwind].[usp_insert_L1_Northwind_Territories]
AS
	BEGIN
	
		TRUNCATE TABLE northwind.L1_Northwind_Territories;

		INSERT INTO northwind.L1_Northwind_Territories (
			  TerritoryID
			, TerritoryDescription
			, RegionID	
		)
		SELECT
			  TerritoryID
			, TerritoryDescription
			, RegionID
		FROM
			northwind.v_stage_L1_Northwind_Territories;
	
	END
GO
/****** Object:  StoredProcedure [northwind].[usp_insert_L2_Northwind_Categories__L1_Northwind_Categories]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [northwind].[usp_insert_L2_Northwind_Categories__L1_Northwind_Categories] 
AS
	BEGIN

		TRUNCATE TABLE northwind.L2_Northwind_Categories;

		INSERT INTO northwind.L2_Northwind_Categories (
			  DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Product_Category
			, HD_S_H_Product_Category_Northwind
			, CategoryID
			, CategoryName
			, [Description]
			, Picture
		)
		SELECT
			  DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Product_Category
			, HD_S_H_Product_Category_Northwind
			, CategoryID
			, CategoryName
			, [Description]
			, Picture
		FROM
			northwind.v_stage_L2_Northwind_Categories__L1_Northwind_Categories;

	END
GO
/****** Object:  StoredProcedure [northwind].[usp_insert_L2_Northwind_CustomerCustomerDemo__L1_Northwind_CustomerCustomerDemo]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [northwind].[usp_insert_L2_Northwind_CustomerCustomerDemo__L1_Northwind_CustomerCustomerDemo]
AS
	BEGIN

		TRUNCATE TABLE northwind.L2_Northwind_CustomerCustomerDemo;

		INSERT INTO northwind.L2_Northwind_CustomerCustomerDemo (
			  DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Customer
			, HK_H_Customer_Type
			, HK_L_Customer_Type
			, CustomerID
			, CustomerTypeID
		)
		SELECT 
			  DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Customer
			, HK_H_Customer_Type
			, HK_L_Customer_Type
			, CustomerID
			, CustomerTypeID
		FROM
			northwind.v_stage_L2_Northwind_CustomerCustomerDemo__L1_Northwind_CustomerCustomerDemo;

	END
GO
/****** Object:  StoredProcedure [northwind].[usp_insert_L2_Northwind_CustomerDemographics__L1_Northwind_CustomerDemographics]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [northwind].[usp_insert_L2_Northwind_CustomerDemographics__L1_Northwind_CustomerDemographics]
AS
	BEGIN

		TRUNCATE TABLE northwind.L2_Northwind_CustomerDemographics;

		INSERT INTO northwind.L2_Northwind_CustomerDemographics (
			  DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Customer_Type
			, HD_S_H_Customer_Type_Northwind
			, CustomerTypeID
			, CustomerDesc
		)
		SELECT 
			  DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Customer_Type
			, HD_S_H_Customer_Type_Northwind
			, CustomerTypeID
			, CustomerDesc
		FROM
			northwind.v_stage_L2_Northwind_CustomerDemographics__L1_Northwind_CustomerDemographics;

	END
GO
/****** Object:  StoredProcedure [northwind].[usp_insert_L2_Northwind_Customers__L1_Northwind_Customers]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [northwind].[usp_insert_L2_Northwind_Customers__L1_Northwind_Customers]
AS
	BEGIN

		TRUNCATE TABLE northwind.L2_Northwind_Customers;

		INSERT INTO northwind.L2_Northwind_Customers (
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
		SELECT 
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
		FROM
			northwind.v_stage_L2_Northwind_Customers__L1_Northwind_Customers;

	END
GO
/****** Object:  StoredProcedure [northwind].[usp_insert_L2_Northwind_Employees__L1_Northwind_Employees]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [northwind].[usp_insert_L2_Northwind_Employees__L1_Northwind_Employees]
AS
	BEGIN

		TRUNCATE TABLE northwind.L2_Northwind_Employees;

		INSERT INTO northwind.L2_Northwind_Employees (
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
		SELECT 
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
		FROM
			northwind.v_stage_L2_Northwind_Employees__L1_Northwind_Employees;

	END
GO
/****** Object:  StoredProcedure [northwind].[usp_insert_L2_Northwind_EmployeeTerritories__L1_Northwind_EmployeeTerritories]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [northwind].[usp_insert_L2_Northwind_EmployeeTerritories__L1_Northwind_EmployeeTerritories]
AS
	BEGIN

		TRUNCATE TABLE northwind.L2_Northwind_EmployeeTerritories;

		INSERT INTO northwind.L2_Northwind_EmployeeTerritories (
			  DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Employee
			, HK_H_Territory
			, HK_L_Employee_Territory
			, EmployeeID
			, TerritoryID
		)
		SELECT 
			  DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Employee
			, HK_H_Territory
			, HK_L_Employee_Territory
			, EmployeeID
			, TerritoryID
		FROM
			northwind.v_stage_L2_Northwind_EmployeeTerritories__L1_Northwind_EmployeeTerritories;

	END
GO
/****** Object:  StoredProcedure [northwind].[usp_insert_L2_Northwind_Order_Details__L1_Northwind_Order_Details]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [northwind].[usp_insert_L2_Northwind_Order_Details__L1_Northwind_Order_Details]
AS
	BEGIN

		TRUNCATE TABLE northwind.L2_Northwind_Order_Details;

		INSERT INTO northwind.L2_Northwind_Order_Details (
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
		SELECT 
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
		FROM
			northwind.v_stage_L2_Northwind_Order_Details__L1_Northwind_Order_Details;

	END
GO
/****** Object:  StoredProcedure [northwind].[usp_insert_L2_Northwind_Orders__L1_Northwind_Orders]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [northwind].[usp_insert_L2_Northwind_Orders__L1_Northwind_Orders]
AS
	BEGIN

		TRUNCATE TABLE northwind.L2_Northwind_Orders;

		INSERT INTO northwind.L2_Northwind_Orders (
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
		SELECT 
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
		FROM
			northwind.v_stage_L2_Northwind_Orders__L1_Northwind_Orders;

	END
GO
/****** Object:  StoredProcedure [northwind].[usp_insert_L2_Northwind_Products__L1_Northwind_Products]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [northwind].[usp_insert_L2_Northwind_Products__L1_Northwind_Products]
AS
	BEGIN

		TRUNCATE TABLE northwind.L2_Northwind_Products;

		INSERT INTO northwind.L2_Northwind_Products (
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
		SELECT 
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
		FROM
			northwind.v_stage_L2_Northwind_Products__L1_Northwind_Products;

	END
GO
/****** Object:  StoredProcedure [northwind].[usp_insert_L2_Northwind_Region__L1_Northwind_Region]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [northwind].[usp_insert_L2_Northwind_Region__L1_Northwind_Region]
AS
	BEGIN

		TRUNCATE TABLE northwind.L2_Northwind_Region;

		INSERT INTO northwind.L2_Northwind_Region (
			  DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Region
			, HD_S_H_Region_Northwind
			, RegionID
			, RegionDescription
		)
		SELECT 
			  DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Region
			, HD_S_H_Region_Northwind
			, RegionID
			, RegionDescription
		FROM
			northwind.v_stage_L2_Northwind_Region__L1_Northwind_Region;

	END
GO
/****** Object:  StoredProcedure [northwind].[usp_insert_L2_Northwind_Shippers__L1_Northwind_Shippers]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [northwind].[usp_insert_L2_Northwind_Shippers__L1_Northwind_Shippers]
AS
	BEGIN

		TRUNCATE TABLE northwind.L2_Northwind_Shippers;

		INSERT INTO northwind.L2_Northwind_Shippers (
			  DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Shipper
			, HD_S_H_Shipper_Northwind
			, ShipperID
			, CompanyName
			, Phone
		)
		SELECT 
			  DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Shipper
			, HD_S_H_Shipper_Northwind
			, ShipperID
			, CompanyName
			, Phone
		FROM
			northwind.v_stage_L2_Northwind_Shippers__L1_Northwind_Shippers;

	END
GO
/****** Object:  StoredProcedure [northwind].[usp_insert_L2_Northwind_Suppliers__L1_Northwind_Suppliers]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [northwind].[usp_insert_L2_Northwind_Suppliers__L1_Northwind_Suppliers]
AS
	BEGIN

		TRUNCATE TABLE northwind.L2_Northwind_Suppliers;

		INSERT INTO northwind.L2_Northwind_Suppliers (
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
		SELECT 
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
		FROM
			northwind.v_stage_L2_Northwind_Suppliers__L1_Northwind_Suppliers;

	END
GO
/****** Object:  StoredProcedure [northwind].[usp_insert_L2_Northwind_Territories__L1_Northwind_Territories]    Script Date: 17/10/2023 5:57:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [northwind].[usp_insert_L2_Northwind_Territories__L1_Northwind_Territories]
AS
	BEGIN

		TRUNCATE TABLE northwind.L2_Northwind_Territories;

		INSERT INTO northwind.L2_Northwind_Territories (
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
		SELECT 
			  DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Territory
			, HK_H_Region
			, HK_L_Territory_Region
			, HD_S_H_Territory_Northwind
			, TerritoryID
			, TerritoryDescription
			, RegionID
		FROM
			northwind.v_stage_L2_Northwind_Territories__L1_Northwind_Territories;

	END
GO
USE [master]
GO
ALTER DATABASE [Staging] SET  READ_WRITE 
GO
