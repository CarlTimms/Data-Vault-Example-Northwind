USE [master]
GO
/****** Object:  Database [Data_Vault]    Script Date: 17/10/2023 6:16:32 pm ******/
CREATE DATABASE [Data_Vault]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DataVault', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.DATAWAREHOUSE\MSSQL\DATA\DataVault.mdf' , SIZE = 37888KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [ARCHIVE] 
( NAME = N'DataVault_archive', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.DATAWAREHOUSE\MSSQL\DATA\DataVault_archive.ndf' , SIZE = 5120000KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%), 
 FILEGROUP [BUSINESS] 
( NAME = N'DataVault_business', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.DATAWAREHOUSE\MSSQL\DATA\DataVault_business.ndf' , SIZE = 1024000KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024000KB ), 
 FILEGROUP [DATA] 
( NAME = N'DataVault_data', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.DATAWAREHOUSE\MSSQL\DATA\DataVault_data.ndf' , SIZE = 1024000KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10240000KB ), 
 FILEGROUP [INDEX] 
( NAME = N'DataVault_index', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.DATAWAREHOUSE\MSSQL\DATA\DataVault_index.ndf' , SIZE = 1024000KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 LOG ON 
( NAME = N'DataVault_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.DATAWAREHOUSE\MSSQL\DATA\DataVault_log.ldf' , SIZE = 1024000KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Data_Vault] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Data_Vault].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Data_Vault] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Data_Vault] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Data_Vault] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Data_Vault] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Data_Vault] SET ARITHABORT OFF 
GO
ALTER DATABASE [Data_Vault] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Data_Vault] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Data_Vault] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Data_Vault] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Data_Vault] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Data_Vault] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Data_Vault] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Data_Vault] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Data_Vault] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Data_Vault] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Data_Vault] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Data_Vault] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Data_Vault] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Data_Vault] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Data_Vault] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Data_Vault] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Data_Vault] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Data_Vault] SET RECOVERY BULK_LOGGED 
GO
ALTER DATABASE [Data_Vault] SET  MULTI_USER 
GO
ALTER DATABASE [Data_Vault] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Data_Vault] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Data_Vault] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Data_Vault] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Data_Vault] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Data_Vault] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Data_Vault] SET QUERY_STORE = OFF
GO
USE [Data_Vault]
GO
/****** Object:  Schema [bv]    Script Date: 17/10/2023 6:16:34 pm ******/
CREATE SCHEMA [bv]
GO
/****** Object:  Schema [rv]    Script Date: 17/10/2023 6:16:34 pm ******/
CREATE SCHEMA [rv]
GO
/****** Object:  Table [rv].[S_H_Customer_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rv].[S_H_Customer_Northwind](
	[HK_H_Customer] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HD_S_H_Customer_Northwind] [binary](32) NOT NULL,
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
 CONSTRAINT [PK_S_H_Customer_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Customer] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [bv].[v_history_S_H_Customer_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_history_S_H_Customer_Northwind] (
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
/****** Object:  Table [rv].[S_H_Customer_Type_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rv].[S_H_Customer_Type_Northwind](
	[HK_H_Customer_Type] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HD_S_H_Customer_Type_Northwind] [binary](32) NOT NULL,
	[CustomerDesc] [ntext] NULL,
 CONSTRAINT [PK_S_H_Customer_Type_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Customer_Type] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA] TEXTIMAGE_ON [DATA]
GO
/****** Object:  View [bv].[v_history_S_H_Customer_Type_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_history_S_H_Customer_Type_Northwind] (
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
/****** Object:  Table [rv].[S_H_Employee_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rv].[S_H_Employee_Northwind](
	[HK_H_Employee] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HD_S_H_Employee_Northwind] [binary](32) NOT NULL,
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
	[PhotoPath] [nvarchar](255) NULL,
 CONSTRAINT [PK_S_H_Employee_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Employee] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA] TEXTIMAGE_ON [DATA]
GO
/****** Object:  View [bv].[v_history_S_H_Employee_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_history_S_H_Employee_Northwind] (
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
/****** Object:  Table [rv].[S_H_Order_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rv].[S_H_Order_Northwind](
	[HK_H_Order] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HD_S_H_Order_Northwind] [binary](32) NOT NULL,
	[OrderDate] [datetime] NULL,
	[RequiredDate] [datetime] NULL,
	[ShippedDate] [datetime] NULL,
	[Freight] [money] NULL,
	[ShipName] [nvarchar](40) NULL,
	[ShipAddress] [nvarchar](60) NULL,
	[ShipCity] [nvarchar](15) NULL,
	[ShipRegion] [nvarchar](15) NULL,
	[ShipPostalCode] [nvarchar](10) NULL,
	[ShipCountry] [nvarchar](15) NULL,
 CONSTRAINT [PK_S_H_Order_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Order] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [bv].[v_history_S_H_Order_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_history_S_H_Order_Northwind] (
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
/****** Object:  Table [rv].[S_H_Product_Category_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rv].[S_H_Product_Category_Northwind](
	[HK_H_Product_Category] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HD_S_H_Product_Category_Northwind] [binary](32) NOT NULL,
	[CategoryName] [nvarchar](15) NULL,
	[Description] [ntext] NULL,
	[Picture] [image] NULL,
 CONSTRAINT [PK_S_H_Product_Category_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Product_Category] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA] TEXTIMAGE_ON [DATA]
GO
/****** Object:  View [bv].[v_history_S_H_Product_Category_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_history_S_H_Product_Category_Northwind] (
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
/****** Object:  Table [rv].[S_H_Product_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rv].[S_H_Product_Northwind](
	[HK_H_Product] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HD_S_H_Product_Northwind] [binary](32) NOT NULL,
	[ProductName] [nvarchar](40) NULL,
	[QuantityPerUnit] [nvarchar](20) NULL,
	[UnitPrice] [money] NULL,
	[UnitsInStock] [smallint] NULL,
	[UnitsOnOrder] [smallint] NULL,
	[ReorderLevel] [smallint] NULL,
	[Discontinued] [bit] NULL,
 CONSTRAINT [PK_S_H_Product_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Product] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [bv].[v_history_S_H_Product_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_history_S_H_Product_Northwind] (
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
/****** Object:  Table [rv].[S_H_Region_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rv].[S_H_Region_Northwind](
	[HK_H_Region] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HD_S_H_Region_Northwind] [binary](32) NOT NULL,
	[RegionDescription] [nchar](50) NULL,
 CONSTRAINT [PK_S_H_Region_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Region] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [bv].[v_history_S_H_Region_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_history_S_H_Region_Northwind] (
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
/****** Object:  Table [rv].[S_H_Shipper_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rv].[S_H_Shipper_Northwind](
	[HK_H_Shipper] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HD_S_H_Shipper_Northwind] [binary](32) NOT NULL,
	[CompanyName] [nvarchar](40) NULL,
	[Phone] [nvarchar](24) NULL,
 CONSTRAINT [PK_S_H_Shipper_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Shipper] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [bv].[v_history_S_H_Shipper_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_history_S_H_Shipper_Northwind] (
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
/****** Object:  Table [rv].[S_H_Supplier_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rv].[S_H_Supplier_Northwind](
	[HK_H_Supplier] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HD_S_H_Supplier_Northwind] [binary](32) NOT NULL,
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
	[HomePage] [ntext] NULL,
 CONSTRAINT [PK_S_H_Supplier_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Supplier] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA] TEXTIMAGE_ON [DATA]
GO
/****** Object:  View [bv].[v_history_S_H_Supplier_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_history_S_H_Supplier_Northwind] (
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
/****** Object:  Table [rv].[S_H_Territory_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rv].[S_H_Territory_Northwind](
	[HK_H_Territory] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HD_S_H_Territory_Northwind] [binary](32) NOT NULL,
	[TerritoryDescription] [nchar](50) NULL,
 CONSTRAINT [PK_S_H_Territory_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Territory] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [bv].[v_history_S_H_Territory_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_history_S_H_Territory_Northwind] (
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
/****** Object:  Table [bv].[S_HRT_H_Customer_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[S_HRT_H_Customer_Northwind](
	[HK_H_Customer] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[Appearance_Flag] [bit] NOT NULL,
	[Last_Seen_Datetime] [datetimeoffset](7) NULL,
 CONSTRAINT [PK_S_HRT_H_Customer_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Customer] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [bv].[v_history_S_HRT_H_Customer_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_history_S_HRT_H_Customer_Northwind] (
	  HK_H_Customer
	, DV_Load_Datetime_Start
	, DV_Load_Datetime_End
	, DV_Record_Source
	, Appearance_Flag
	, Last_Seen_Datetime
)
AS
SELECT
	  HK_H_Customer
	, DV_Load_Datetime AS DV_Load_Datetime_Start
	, LEAD(DATEADD(NS, -100, DV_Load_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_H_Customer ORDER BY DV_Load_Datetime ASC) AS DV_Load_Datetime_End
	, DV_Record_Source
	, Appearance_Flag
	, Last_Seen_Datetime
FROM
	Data_Vault.bv.S_HRT_H_Customer_Northwind;
GO
/****** Object:  Table [bv].[S_HDT_H_Customer_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[S_HDT_H_Customer_Northwind](
	[HK_H_Customer] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[Is_Deleted_Flag] [bit] NOT NULL,
	[Deleted_Datetime] [datetimeoffset](7) NULL,
 CONSTRAINT [PK_S_HDT_H_Customer_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Customer] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  View [bv].[v_stage_S_HDT_H_Customer_Northwind__S_HRT_H_Customer_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_S_HDT_H_Customer_Northwind__S_HRT_H_Customer_Northwind] (
	  HK_H_Customer
	, DV_Load_Datetime
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
AS
WITH 
	cte_stage AS (
		SELECT
			  HK_H_Customer
			, DV_Load_Datetime_Start
			, DV_Load_Datetime_End
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
			, CASE
				WHEN DV_Load_Datetime_Start > DATEADD(HOUR, 24, Last_Seen_Datetime) THEN 1
				ELSE 0
			  END AS Is_Deleted_Flag
			, CASE
				WHEN DV_Load_Datetime_Start > DATEADD(HOUR, 24, Last_Seen_Datetime) THEN DATEADD(HOUR, 24, Last_Seen_Datetime)
				ELSE NULL
			  END AS Deleted_Datetime
		FROM
			Data_Vault.bv.v_history_S_HRT_H_Customer_Northwind
		WHERE
			SYSUTCDATETIME() AT TIME ZONE 'UTC' BETWEEN DV_Load_Datetime_Start AND DV_Load_Datetime_End
	)

	SELECT
		  stage.HK_H_Customer
		, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
		, stage.DV_Record_Source
		, stage.Is_Deleted_Flag
		, stage.Deleted_Datetime
	FROM
		cte_stage AS stage
			LEFT JOIN Data_Vault.bv.S_HDT_H_Customer_Northwind AS sat1
				ON stage.HK_H_Customer = sat1.HK_H_Customer
			   AND sat1.DV_Load_Datetime = (
						SELECT
							MAX(sat2.DV_Load_Datetime)
						FROM
							Data_Vault.bv.S_HDT_H_Customer_Northwind AS sat2
						WHERE
							sat1.HK_H_Customer = sat2.HK_H_Customer
					)
	WHERE
		sat1.HK_H_Customer IS NULL
		OR (
			stage.HK_H_Customer = sat1.HK_H_Customer
			AND stage.Is_Deleted_Flag <> sat1.Is_Deleted_Flag
		);
GO
/****** Object:  Table [bv].[S_HRT_H_Customer_Type_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[S_HRT_H_Customer_Type_Northwind](
	[HK_H_Customer_Type] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[Appearance_Flag] [bit] NOT NULL,
	[Last_Seen_Datetime] [datetimeoffset](7) NULL,
 CONSTRAINT [PK_S_HRT_H_Customer_Type_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Customer_Type] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [bv].[v_history_S_HRT_H_Customer_Type_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_history_S_HRT_H_Customer_Type_Northwind] (
	  HK_H_Customer_Type
	, DV_Load_Datetime_Start
	, DV_Load_Datetime_End
	, DV_Record_Source
	, Appearance_Flag
	, Last_Seen_Datetime
)
AS
SELECT
	  HK_H_Customer_Type
	, DV_Load_Datetime AS DV_Load_Datetime_Start
	, LEAD(DATEADD(NS, -100, DV_Load_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_H_Customer_Type ORDER BY DV_Load_Datetime ASC) AS DV_Load_Datetime_End
	, DV_Record_Source
	, Appearance_Flag
	, Last_Seen_Datetime
FROM
	Data_Vault.bv.S_HRT_H_Customer_Type_Northwind;
GO
/****** Object:  Table [bv].[S_HDT_H_Customer_Type_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[S_HDT_H_Customer_Type_Northwind](
	[HK_H_Customer_Type] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[Is_Deleted_Flag] [bit] NOT NULL,
	[Deleted_Datetime] [datetimeoffset](7) NULL,
 CONSTRAINT [PK_S_HDT_H_Customer_Type_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Customer_Type] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  View [bv].[v_stage_S_HDT_H_Customer_Type_Northwind__S_HRT_H_Customer_Type_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_S_HDT_H_Customer_Type_Northwind__S_HRT_H_Customer_Type_Northwind] (
	  HK_H_Customer_Type
	, DV_Load_Datetime
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
AS
WITH 
	cte_stage AS (
		SELECT
			  HK_H_Customer_Type
			, DV_Load_Datetime_Start
			, DV_Load_Datetime_End
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
			, CASE
				WHEN DV_Load_Datetime_Start > DATEADD(HOUR, 24, Last_Seen_Datetime) THEN 1
				ELSE 0
			  END AS Is_Deleted_Flag
			, CASE
				WHEN DV_Load_Datetime_Start > DATEADD(HOUR, 24, Last_Seen_Datetime) THEN DATEADD(HOUR, 24, Last_Seen_Datetime)
				ELSE NULL
			  END AS Deleted_Datetime
		FROM
			Data_Vault.bv.v_history_S_HRT_H_Customer_Type_Northwind
		WHERE
			SYSUTCDATETIME() AT TIME ZONE 'UTC' BETWEEN DV_Load_Datetime_Start AND DV_Load_Datetime_End
	)

	SELECT
		  stage.HK_H_Customer_Type
		, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
		, stage.DV_Record_Source
		, stage.Is_Deleted_Flag
		, stage.Deleted_Datetime
	FROM
		cte_stage AS stage
			LEFT JOIN Data_Vault.bv.S_HDT_H_Customer_Type_Northwind AS sat1
				ON stage.HK_H_Customer_Type = sat1.HK_H_Customer_Type
			   AND sat1.DV_Load_Datetime = (
						SELECT
							MAX(sat2.DV_Load_Datetime)
						FROM
							Data_Vault.bv.S_HDT_H_Customer_Type_Northwind AS sat2
						WHERE
							sat1.HK_H_Customer_Type= sat2.HK_H_Customer_Type
					)
	WHERE
		sat1.HK_H_Customer_Type IS NULL
		OR (
			stage.HK_H_Customer_Type = sat1.HK_H_Customer_Type
			AND stage.Is_Deleted_Flag <> sat1.Is_Deleted_Flag
		);
GO
/****** Object:  Table [bv].[S_HRT_H_Employee_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[S_HRT_H_Employee_Northwind](
	[HK_H_Employee] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[Appearance_Flag] [bit] NOT NULL,
	[Last_Seen_Datetime] [datetimeoffset](7) NULL,
 CONSTRAINT [PK_S_HRT_H_Employee_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Employee] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [bv].[v_history_S_HRT_H_Employee_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_history_S_HRT_H_Employee_Northwind] (
	  HK_H_Employee
	, DV_Load_Datetime_Start
	, DV_Load_Datetime_End
	, DV_Record_Source
	, Appearance_Flag
	, Last_Seen_Datetime
)
AS
SELECT
	  HK_H_Employee
	, DV_Load_Datetime AS DV_Load_Datetime_Start
	, LEAD(DATEADD(NS, -100, DV_Load_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_H_Employee ORDER BY DV_Load_Datetime ASC) AS DV_Load_Datetime_End
	, DV_Record_Source
	, Appearance_Flag
	, Last_Seen_Datetime
FROM
	Data_Vault.bv.S_HRT_H_Employee_Northwind;
GO
/****** Object:  Table [bv].[S_HDT_H_Employee_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[S_HDT_H_Employee_Northwind](
	[HK_H_Employee] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[Is_Deleted_Flag] [bit] NOT NULL,
	[Deleted_Datetime] [datetimeoffset](7) NULL,
 CONSTRAINT [PK_S_HDT_H_Employee_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Employee] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  View [bv].[v_stage_S_HDT_H_Employee_Northwind__S_HRT_H_Employee_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_S_HDT_H_Employee_Northwind__S_HRT_H_Employee_Northwind] (
	  HK_H_Employee
	, DV_Load_Datetime
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
AS
WITH 
	cte_stage AS (
		SELECT
			  HK_H_Employee
			, DV_Load_Datetime_Start
			, DV_Load_Datetime_End
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
			, CASE
				WHEN DV_Load_Datetime_Start > DATEADD(HOUR, 24, Last_Seen_Datetime) THEN 1
				ELSE 0
			  END AS Is_Deleted_Flag
			, CASE
				WHEN DV_Load_Datetime_Start > DATEADD(HOUR, 24, Last_Seen_Datetime) THEN DATEADD(HOUR, 24, Last_Seen_Datetime)
				ELSE NULL
			  END AS Deleted_Datetime
		FROM
			Data_Vault.bv.v_history_S_HRT_H_Employee_Northwind
		WHERE
			SYSUTCDATETIME() AT TIME ZONE 'UTC' BETWEEN DV_Load_Datetime_Start AND DV_Load_Datetime_End
	)

	SELECT
		  stage.HK_H_Employee
		, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
		, stage.DV_Record_Source
		, stage.Is_Deleted_Flag
		, stage.Deleted_Datetime
	FROM
		cte_stage AS stage
			LEFT JOIN Data_Vault.bv.S_HDT_H_Employee_Northwind AS sat1
				ON stage.HK_H_Employee = sat1.HK_H_Employee
			   AND sat1.DV_Load_Datetime = (
						SELECT
							MAX(sat2.DV_Load_Datetime)
						FROM
							Data_Vault.bv.S_HDT_H_Employee_Northwind AS sat2
						WHERE
							sat1.HK_H_Employee= sat2.HK_H_Employee
					)
	WHERE
		sat1.HK_H_Employee IS NULL
		OR (
			stage.HK_H_Employee = sat1.HK_H_Employee
			AND stage.Is_Deleted_Flag <> sat1.Is_Deleted_Flag
		);
GO
/****** Object:  Table [bv].[S_LE_L_Employee_Reporting_Line_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[S_LE_L_Employee_Reporting_Line_Northwind](
	[HK_L_Employee_Reporting_Line] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HK_H_Employee__Direct_Report__DK] [binary](32) NOT NULL,
	[Start_Datetime] [datetimeoffset](7) NOT NULL,
	[HK_L_Employee_Reporting_Line__Previous] [binary](32) NULL,
	[DV_Load_Datetime__Previous] [datetimeoffset](7) NULL,
 CONSTRAINT [PK_S_LE_L_Employee_Reporting_Line_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_L_Employee_Reporting_Line] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [bv].[v_stage_S_LE_L_Employee_Reporting_Line_Northwind__L2_Northwind_Employees]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_S_LE_L_Employee_Reporting_Line_Northwind__L2_Northwind_Employees]
(  
	  HK_L_Employee_Reporting_Line
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Employee__Direct_Report__DK
	, Start_Datetime
	, HK_L_Employee_Reporting_Line__Previous
	, DV_Load_Datetime__Previous
)
AS
SELECT DISTINCT 
	  stage.HK_L_Employee_Reporting_Line
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, stage.DV_Record_Source
	, stage.HK_H_Employee AS HK_H_Employee__Direct_Report__DK
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS Start_Datetime
	, sat1.HK_L_Employee_Reporting_Line AS HK_L_Employee_Reporting_Line__Previous
	, sat1.DV_Load_Datetime AS DV_Load_Datetime__Previous
FROM
	Staging.northwind.L2_Northwind_Employees AS stage
		LEFT OUTER JOIN Data_Vault.bv.S_LE_L_Employee_Reporting_Line_Northwind AS sat1
			ON stage.HK_H_Employee = sat1.HK_H_Employee__Direct_Report__DK
		   AND sat1.DV_Load_Datetime = (
					SELECT
						MAX(sat2.DV_Load_Datetime)
					FROM
						Data_Vault.bv.S_LE_L_Employee_Reporting_Line_Northwind AS sat2
					WHERE
						sat1.HK_H_Employee__Direct_Report__DK = sat2.HK_H_Employee__Direct_Report__DK 
				)
WHERE
	sat1.HK_L_Employee_Reporting_Line IS NULL
	OR (
		stage.HK_H_Employee = sat1.HK_H_Employee__Direct_Report__DK
		AND stage.HK_L_Employee_Reporting_Line <> sat1.HK_L_Employee_Reporting_Line
	);
GO
/****** Object:  Table [bv].[S_HRT_H_Order_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[S_HRT_H_Order_Northwind](
	[HK_H_Order] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[Appearance_Flag] [bit] NOT NULL,
	[Last_Seen_Datetime] [datetimeoffset](7) NULL,
 CONSTRAINT [PK_S_HRT_H_Order_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Order] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [bv].[v_history_S_HRT_H_Order_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_history_S_HRT_H_Order_Northwind] (
	  HK_H_Order
	, DV_Load_Datetime_Start
	, DV_Load_Datetime_End
	, DV_Record_Source
	, Appearance_Flag
	, Last_Seen_Datetime
)
AS
SELECT
	  HK_H_Order
	, DV_Load_Datetime AS DV_Load_Datetime_Start
	, LEAD(DATEADD(NS, -100, DV_Load_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_H_Order ORDER BY DV_Load_Datetime ASC) AS DV_Load_Datetime_End
	, DV_Record_Source
	, Appearance_Flag
	, Last_Seen_Datetime
FROM
	Data_Vault.bv.S_HRT_H_Order_Northwind;
GO
/****** Object:  Table [bv].[S_HDT_H_Order_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[S_HDT_H_Order_Northwind](
	[HK_H_Order] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[Is_Deleted_Flag] [bit] NOT NULL,
	[Deleted_Datetime] [datetimeoffset](7) NULL,
 CONSTRAINT [PK_S_HDT_H_Order_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Order] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  View [bv].[v_stage_S_HDT_H_Order_Northwind__S_HRT_H_Order_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_S_HDT_H_Order_Northwind__S_HRT_H_Order_Northwind] (
	  HK_H_Order
	, DV_Load_Datetime
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
AS
WITH 
	cte_stage AS (
		SELECT
			  HK_H_Order
			, DV_Load_Datetime_Start
			, DV_Load_Datetime_End
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
			, CASE
				WHEN DV_Load_Datetime_Start > DATEADD(HOUR, 24, Last_Seen_Datetime) THEN 1
				ELSE 0
			  END AS Is_Deleted_Flag
			, CASE
				WHEN DV_Load_Datetime_Start > DATEADD(HOUR, 24, Last_Seen_Datetime) THEN DATEADD(HOUR, 24, Last_Seen_Datetime)
				ELSE NULL
			  END AS Deleted_Datetime
		FROM
			Data_Vault.bv.v_history_S_HRT_H_Order_Northwind
		WHERE
			SYSUTCDATETIME() AT TIME ZONE 'UTC' BETWEEN DV_Load_Datetime_Start AND DV_Load_Datetime_End
	)

	SELECT
		  stage.HK_H_Order
		, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
		, stage.DV_Record_Source
		, stage.Is_Deleted_Flag
		, stage.Deleted_Datetime
	FROM
		cte_stage AS stage
			LEFT JOIN Data_Vault.bv.S_HDT_H_Order_Northwind AS sat1
				ON stage.HK_H_Order = sat1.HK_H_Order
			   AND sat1.DV_Load_Datetime = (
						SELECT
							MAX(sat2.DV_Load_Datetime)
						FROM
							Data_Vault.bv.S_HDT_H_Order_Northwind AS sat2
						WHERE
							sat1.HK_H_Order= sat2.HK_H_Order
					)
	WHERE
		sat1.HK_H_Order IS NULL
		OR (
			stage.HK_H_Order = sat1.HK_H_Order
			AND stage.Is_Deleted_Flag <> sat1.Is_Deleted_Flag
		);
GO
/****** Object:  Table [bv].[S_LE_L_Order_Header_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[S_LE_L_Order_Header_Northwind](
	[HK_L_Order_Header] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HK_H_Order__DK] [binary](32) NOT NULL,
	[Start_Datetime] [datetimeoffset](7) NOT NULL,
	[HK_L_Order_Header__Previous] [binary](32) NULL,
	[DV_Load_Datetime__Previous] [datetimeoffset](7) NULL,
 CONSTRAINT [PK_S_LE_L_Order_Header_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_L_Order_Header] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [bv].[v_stage_S_LE_L_Order_Header_Northwind__L2_Northwind_Orders]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_S_LE_L_Order_Header_Northwind__L2_Northwind_Orders]
(  
	  HK_L_Order_Header
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Order__DK
	, Start_Datetime
	, HK_L_Order_Header__Previous
	, DV_Load_Datetime__Previous
)
AS
SELECT DISTINCT 
	  stage.HK_L_Order_Header
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, stage.DV_Record_Source
	, stage.HK_H_Order AS HK_H_Order__DK
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS Start_Datetime
	, sat1.HK_L_Order_Header AS HK_L_Order_Header__Previous
	, sat1.DV_Load_Datetime AS DV_Load_Datetime__Previous
FROM
	Staging.northwind.L2_Northwind_Orders AS stage
		LEFT OUTER JOIN Data_Vault.bv.S_LE_L_Order_Header_Northwind AS sat1
			ON stage.HK_H_Order = sat1.HK_H_Order__DK
		   AND sat1.DV_Load_Datetime = (
					SELECT
						MAX(sat2.DV_Load_Datetime)
					FROM
						Data_Vault.bv.S_LE_L_Order_Header_Northwind AS sat2
					WHERE
						sat1.HK_H_Order__DK = sat2.HK_H_Order__DK 
				)
WHERE
	sat1.HK_L_Order_Header IS NULL
	OR (
		stage.HK_H_Order = sat1.HK_H_Order__DK
		AND stage.HK_L_Order_Header <> sat1.HK_L_Order_Header
	);
GO
/****** Object:  Table [bv].[S_HRT_H_Product_Category_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[S_HRT_H_Product_Category_Northwind](
	[HK_H_Product_Category] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[Appearance_Flag] [bit] NOT NULL,
	[Last_Seen_Datetime] [datetimeoffset](7) NULL,
 CONSTRAINT [PK_S_HRT_H_Product_Category_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Product_Category] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [bv].[v_history_S_HRT_H_Product_Category_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_history_S_HRT_H_Product_Category_Northwind] (
	  HK_H_Product_Category
	, DV_Load_Datetime_Start
	, DV_Load_Datetime_End
	, DV_Record_Source
	, Appearance_Flag
	, Last_Seen_Datetime
)
AS
SELECT
	  HK_H_Product_Category
	, DV_Load_Datetime AS DV_Load_Datetime_Start
	, LEAD(DATEADD(NS, -100, DV_Load_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_H_Product_Category ORDER BY DV_Load_Datetime ASC) AS DV_Load_Datetime_End
	, DV_Record_Source
	, Appearance_Flag
	, Last_Seen_Datetime
FROM
	Data_Vault.bv.S_HRT_H_Product_Category_Northwind;
GO
/****** Object:  Table [bv].[S_HDT_H_Product_Category_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[S_HDT_H_Product_Category_Northwind](
	[HK_H_Product_Category] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[Is_Deleted_Flag] [bit] NOT NULL,
	[Deleted_Datetime] [datetimeoffset](7) NULL,
 CONSTRAINT [PK_S_HDT_H_Product_Category_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Product_Category] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  View [bv].[v_stage_S_HDT_H_Product_Category_Northwind__S_HRT_H_Product_Category_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_S_HDT_H_Product_Category_Northwind__S_HRT_H_Product_Category_Northwind] (
	  HK_H_Product_Category
	, DV_Load_Datetime
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
AS
WITH 
	cte_stage AS (
		SELECT
			  HK_H_Product_Category
			, DV_Load_Datetime_Start
			, DV_Load_Datetime_End
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
			, CASE
				WHEN DV_Load_Datetime_Start > DATEADD(HOUR, 24, Last_Seen_Datetime) THEN 1
				ELSE 0
			  END AS Is_Deleted_Flag
			, CASE
				WHEN DV_Load_Datetime_Start > DATEADD(HOUR, 24, Last_Seen_Datetime) THEN DATEADD(HOUR, 24, Last_Seen_Datetime)
				ELSE NULL
			  END AS Deleted_Datetime
		FROM
			Data_Vault.bv.v_history_S_HRT_H_Product_Category_Northwind
		WHERE
			SYSUTCDATETIME() AT TIME ZONE 'UTC' BETWEEN DV_Load_Datetime_Start AND DV_Load_Datetime_End
	)

	SELECT
		  stage.HK_H_Product_Category
		, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
		, stage.DV_Record_Source
		, stage.Is_Deleted_Flag
		, stage.Deleted_Datetime
	FROM
		cte_stage AS stage
			LEFT JOIN Data_Vault.bv.S_HDT_H_Product_Category_Northwind AS sat1
				ON stage.HK_H_Product_Category = sat1.HK_H_Product_Category
			   AND sat1.DV_Load_Datetime = (
						SELECT
							MAX(sat2.DV_Load_Datetime)
						FROM
							Data_Vault.bv.S_HDT_H_Product_Category_Northwind AS sat2
						WHERE
							sat1.HK_H_Product_Category = sat2.HK_H_Product_Category
					)
	WHERE
		sat1.HK_H_Product_Category IS NULL
		OR (
			stage.HK_H_Product_Category = sat1.HK_H_Product_Category
			AND stage.Is_Deleted_Flag <> sat1.Is_Deleted_Flag
		);
GO
/****** Object:  Table [bv].[S_LE_L_Product_Category_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[S_LE_L_Product_Category_Northwind](
	[HK_L_Product_Category] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HK_H_Product__DK] [binary](32) NOT NULL,
	[Start_Datetime] [datetimeoffset](7) NOT NULL,
	[HK_L_Product_Category__Previous] [binary](32) NULL,
	[DV_Load_Datetime__Previous] [datetimeoffset](7) NULL,
 CONSTRAINT [PK_S_LE_L_Product_Category_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_L_Product_Category] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [bv].[v_stage_S_LE_L_Product_Category_Northwind__L2_Northwind_Products]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_S_LE_L_Product_Category_Northwind__L2_Northwind_Products]
(  
	  HK_L_Product_Category
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Product__DK
	, Start_Datetime
	, HK_L_Product_Category__Previous
	, DV_Load_Datetime__Previous
)
AS
SELECT DISTINCT
	  stage.HK_L_Product_Category
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, stage.DV_Record_Source
	, stage.HK_H_Product AS HK_H_Product__DK
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS Start_Datetime
	, sat1.HK_L_Product_Category AS HK_L_Product_Category__Previous
	, sat1.DV_Load_Datetime AS DV_Load_Datetime__Previous
FROM
	Staging.northwind.L2_Northwind_Products AS stage
		LEFT OUTER JOIN Data_Vault.bv.S_LE_L_Product_Category_Northwind AS sat1
			ON stage.HK_H_Product = sat1.HK_H_Product__DK
		   AND sat1.DV_Load_Datetime = (
					SELECT
						MAX(sat2.DV_Load_Datetime)
					FROM
						Data_Vault.bv.S_LE_L_Product_Category_Northwind AS sat2
					WHERE
						sat1.HK_H_Product__DK = sat2.HK_H_Product__DK 
				)
WHERE
	sat1.HK_L_Product_Category IS NULL
	OR (
		stage.HK_H_Product = sat1.HK_H_Product__DK
		AND stage.HK_L_Product_Category <> sat1.HK_L_Product_Category
	);
GO
/****** Object:  Table [bv].[S_HDT_H_Product_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[S_HDT_H_Product_Northwind](
	[HK_H_Product] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[Is_Deleted_Flag] [bit] NOT NULL,
	[Deleted_Datetime] [datetimeoffset](7) NULL,
 CONSTRAINT [PK_S_HDT_H_Product_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Product] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  Table [bv].[S_HRT_H_Product_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[S_HRT_H_Product_Northwind](
	[HK_H_Product] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[Appearance_Flag] [bit] NOT NULL,
	[Last_Seen_Datetime] [datetimeoffset](7) NULL,
 CONSTRAINT [PK_S_HRT_H_Product_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Product] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [bv].[v_history_S_HRT_H_Product_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_history_S_HRT_H_Product_Northwind] (
	  HK_H_Product
	, DV_Load_Datetime_Start
	, DV_Load_Datetime_End
	, DV_Record_Source
	, Appearance_Flag
	, Last_Seen_Datetime
)
AS
SELECT
	  HK_H_Product
	, DV_Load_Datetime AS DV_Load_Datetime_Start
	, LEAD(DATEADD(NS, -100, DV_Load_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_H_Product ORDER BY DV_Load_Datetime ASC) AS DV_Load_Datetime_End
	, DV_Record_Source
	, Appearance_Flag
	, Last_Seen_Datetime
FROM
	Data_Vault.bv.S_HRT_H_Product_Northwind;
GO
/****** Object:  View [bv].[v_stage_S_HDT_H_Product_Northwind__S_HRT_H_Product_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_S_HDT_H_Product_Northwind__S_HRT_H_Product_Northwind] (
	  HK_H_Product
	, DV_Load_Datetime
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
AS
WITH 
	cte_stage AS (
		SELECT
			  HK_H_Product
			, DV_Load_Datetime_Start
			, DV_Load_Datetime_End
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
			, CASE
				WHEN DV_Load_Datetime_Start > DATEADD(HOUR, 24, Last_Seen_Datetime) THEN 1
				ELSE 0
			  END AS Is_Deleted_Flag
			, CASE
				WHEN DV_Load_Datetime_Start > DATEADD(HOUR, 24, Last_Seen_Datetime) THEN DATEADD(HOUR, 24, Last_Seen_Datetime)
				ELSE NULL
			  END AS Deleted_Datetime
		FROM
			Data_Vault.bv.v_history_S_HRT_H_Product_Northwind
		WHERE
			SYSUTCDATETIME() AT TIME ZONE 'UTC' BETWEEN DV_Load_Datetime_Start AND DV_Load_Datetime_End
	)

	SELECT
		  stage.HK_H_Product
		, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
		, stage.DV_Record_Source
		, stage.Is_Deleted_Flag
		, stage.Deleted_Datetime
	FROM
		cte_stage AS stage
			LEFT JOIN Data_Vault.bv.S_HDT_H_Product_Northwind AS sat1
				ON stage.HK_H_Product = sat1.HK_H_Product
			   AND sat1.DV_Load_Datetime = (
						SELECT
							MAX(sat2.DV_Load_Datetime)
						FROM
							Data_Vault.bv.S_HDT_H_Product_Northwind AS sat2
						WHERE
							sat1.HK_H_Product = sat2.HK_H_Product
					)
	WHERE
		sat1.HK_H_Product IS NULL
		OR (
			stage.HK_H_Product = sat1.HK_H_Product
			AND stage.Is_Deleted_Flag <> sat1.Is_Deleted_Flag
		);
GO
/****** Object:  Table [bv].[S_LE_L_Product_Supplier_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[S_LE_L_Product_Supplier_Northwind](
	[HK_L_Product_Supplier] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HK_H_Product__DK] [binary](32) NOT NULL,
	[Start_Datetime] [datetimeoffset](7) NOT NULL,
	[HK_L_Product_Supplier__Previous] [binary](32) NULL,
	[DV_Load_Datetime__Previous] [datetimeoffset](7) NULL,
 CONSTRAINT [PK_S_LE_L_Product_Supplier_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_L_Product_Supplier] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [bv].[v_stage_S_LE_L_Product_Supplier_Northwind__L2_Northwind_Products]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_S_LE_L_Product_Supplier_Northwind__L2_Northwind_Products]
(  
	  HK_L_Product_Supplier
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Product__DK
	, Start_Datetime
	, HK_L_Product_Supplier__Previous
	, DV_Load_Datetime__Previous
)
AS
SELECT DISTINCT
	  stage.HK_L_Product_Supplier
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, stage.DV_Record_Source
	, stage.HK_H_Product AS HK_H_Product__DK
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS Start_Datetime
	, sat1.HK_L_Product_Supplier AS HK_L_Product_Supplier__Previous
	, sat1.DV_Load_Datetime AS DV_Load_Datetime__Previous
FROM
	Staging.northwind.L2_Northwind_Products AS stage
		LEFT OUTER JOIN Data_Vault.bv.S_LE_L_Product_Supplier_Northwind AS sat1
			ON stage.HK_H_Product = sat1.HK_H_Product__DK
		   AND sat1.DV_Load_Datetime = (
					SELECT
						MAX(sat2.DV_Load_Datetime)
					FROM
						Data_Vault.bv.S_LE_L_Product_Supplier_Northwind AS sat2
					WHERE
						sat1.HK_H_Product__DK = sat2.HK_H_Product__DK 
				)
WHERE
	sat1.HK_L_Product_Supplier IS NULL
	OR (
		stage.HK_H_Product = sat1.HK_H_Product__DK
		AND stage.HK_L_Product_Supplier <> sat1.HK_L_Product_Supplier
	);
GO
/****** Object:  Table [rv].[L_Customer_Type]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rv].[L_Customer_Type](
	[HK_L_Customer_Type] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](55) NOT NULL,
	[HK_H_Customer] [binary](32) NOT NULL,
	[HK_H_Customer_Type] [binary](32) NOT NULL,
 CONSTRAINT [PK_L_Customer_Type] PRIMARY KEY NONCLUSTERED 
(
	[HK_L_Customer_Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [rv].[v_stage_L_Customer_Type__L2_Northwind_CustomerCustomerDemo]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_L_Customer_Type__L2_Northwind_CustomerCustomerDemo] (
	  HK_L_Customer_Type
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Customer
	, HK_H_Customer_Type
)
AS
SELECT DISTINCT 
	  HK_L_Customer_Type
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Customer
	, HK_H_Customer_Type
FROM
	Staging.northwind.L2_Northwind_CustomerCustomerDemo AS stage
WHERE
	NOT EXISTS (
		SELECT
			link.HK_L_Customer_Type
		FROM
			rv.L_Customer_Type AS link
		WHERE
			stage.HK_L_Customer_Type = link.HK_L_Customer_Type
	);
GO
/****** Object:  Table [bv].[S_HDT_H_Region_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[S_HDT_H_Region_Northwind](
	[HK_H_Region] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[Is_Deleted_Flag] [bit] NOT NULL,
	[Deleted_Datetime] [datetimeoffset](7) NULL,
 CONSTRAINT [PK_S_HDT_H_Region_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Region] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  Table [bv].[S_HRT_H_Region_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[S_HRT_H_Region_Northwind](
	[HK_H_Region] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[Appearance_Flag] [bit] NOT NULL,
	[Last_Seen_Datetime] [datetimeoffset](7) NULL,
 CONSTRAINT [PK_S_HRT_H_Region_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Region] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [bv].[v_history_S_HRT_H_Region_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_history_S_HRT_H_Region_Northwind] (
	  HK_H_Region
	, DV_Load_Datetime_Start
	, DV_Load_Datetime_End
	, DV_Record_Source
	, Appearance_Flag
	, Last_Seen_Datetime
)
AS
SELECT
	  HK_H_Region
	, DV_Load_Datetime AS DV_Load_Datetime_Start
	, LEAD(DATEADD(NS, -100, DV_Load_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_H_Region ORDER BY DV_Load_Datetime ASC) AS DV_Load_Datetime_End
	, DV_Record_Source
	, Appearance_Flag
	, Last_Seen_Datetime
FROM
	Data_Vault.bv.S_HRT_H_Region_Northwind;
GO
/****** Object:  View [bv].[v_stage_S_HDT_H_Region_Northwind__S_HRT_H_Region_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_S_HDT_H_Region_Northwind__S_HRT_H_Region_Northwind] (
	  HK_H_Region
	, DV_Load_Datetime
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
AS
WITH 
	cte_stage AS (
		SELECT
			  HK_H_Region
			, DV_Load_Datetime_Start
			, DV_Load_Datetime_End
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
			, CASE
				WHEN DV_Load_Datetime_Start > DATEADD(HOUR, 24, Last_Seen_Datetime) THEN 1
				ELSE 0
			  END AS Is_Deleted_Flag
			, CASE
				WHEN DV_Load_Datetime_Start > DATEADD(HOUR, 24, Last_Seen_Datetime) THEN DATEADD(HOUR, 24, Last_Seen_Datetime)
				ELSE NULL
			  END AS Deleted_Datetime
		FROM
			Data_Vault.bv.v_history_S_HRT_H_Region_Northwind
		WHERE
			SYSUTCDATETIME() AT TIME ZONE 'UTC' BETWEEN DV_Load_Datetime_Start AND DV_Load_Datetime_End
	)

	SELECT
		  stage.HK_H_Region
		, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
		, stage.DV_Record_Source
		, stage.Is_Deleted_Flag
		, stage.Deleted_Datetime
	FROM
		cte_stage AS stage
			LEFT JOIN Data_Vault.bv.S_HDT_H_Region_Northwind AS sat1
				ON stage.HK_H_Region = sat1.HK_H_Region
			   AND sat1.DV_Load_Datetime = (
						SELECT
							MAX(sat2.DV_Load_Datetime)
						FROM
							Data_Vault.bv.S_HDT_H_Region_Northwind AS sat2
						WHERE
							sat1.HK_H_Region = sat2.HK_H_Region
					)
	WHERE
		sat1.HK_H_Region IS NULL
		OR (
			stage.HK_H_Region = sat1.HK_H_Region
			AND stage.Is_Deleted_Flag <> sat1.Is_Deleted_Flag
		);
GO
/****** Object:  Table [bv].[S_LE_L_Territory_Region_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[S_LE_L_Territory_Region_Northwind](
	[HK_L_Territory_Region] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HK_H_Territory__DK] [binary](32) NOT NULL,
	[Start_Datetime] [datetimeoffset](7) NOT NULL,
	[HK_L_Territory_Region__Previous] [binary](32) NULL,
	[DV_Load_Datetime__Previous] [datetimeoffset](7) NULL,
 CONSTRAINT [PK_S_LE_L_Territory_Region_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_L_Territory_Region] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [bv].[v_stage_S_LE_L_Territory_Region_Northwind__L2_Northwind_Territories]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_S_LE_L_Territory_Region_Northwind__L2_Northwind_Territories]
(  
	  HK_L_Territory_Region
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Territory__DK
	, Start_Datetime
	, HK_L_Territory_Region__Previous
	, DV_Load_Datetime__Previous
)
AS
SELECT DISTINCT 
	  stage.HK_L_Territory_Region
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, stage.DV_Record_Source
	, stage.HK_H_Territory AS HK_H_Territory__DK
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS Start_Datetime
	, sat1.HK_L_Territory_Region AS HK_L_Territory_Region__Previous
	, sat1.DV_Load_Datetime AS DV_Load_Datetime__Previous
FROM
	Staging.northwind.L2_Northwind_Territories AS stage
		LEFT OUTER JOIN Data_Vault.bv.S_LE_L_Territory_Region_Northwind AS sat1
			ON stage.HK_H_Territory = sat1.HK_H_Territory__DK
		   AND sat1.DV_Load_Datetime = (
					SELECT
						MAX(sat2.DV_Load_Datetime)
					FROM
						Data_Vault.bv.S_LE_L_Territory_Region_Northwind AS sat2
					WHERE
						sat1.HK_H_Territory__DK = sat2.HK_H_Territory__DK 
				)
WHERE
	sat1.HK_L_Territory_Region IS NULL
	OR (
		stage.HK_H_Territory = sat1.HK_H_Territory__DK
		AND stage.HK_L_Territory_Region <> sat1.HK_L_Territory_Region
	);
GO
/****** Object:  Table [rv].[L_Employee_Reporting_Line]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rv].[L_Employee_Reporting_Line](
	[HK_L_Employee_Reporting_Line] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](55) NOT NULL,
	[HK_H_Employee__Direct_Report__DK] [binary](32) NOT NULL,
	[HK_H_Employee__Manager] [binary](32) NOT NULL,
 CONSTRAINT [PK_L_Employee_Reporting_Line] PRIMARY KEY NONCLUSTERED 
(
	[HK_L_Employee_Reporting_Line] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [rv].[v_stage_L_Employee_Reporting_Line__L2_Northwind_Employees]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_L_Employee_Reporting_Line__L2_Northwind_Employees] (
	  HK_L_Employee_Reporting_Line
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Employee__Direct_Report__DK
	, HK_H_Employee__Manager
)
AS
SELECT DISTINCT 
	  HK_L_Employee_Reporting_Line
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Employee AS HK_H_Employee__Direct_Report__DK
	, HK_H_Employee__Manager
FROM
	Staging.northwind.L2_Northwind_Employees AS stage
WHERE
	NOT EXISTS (
		SELECT
			link.HK_L_Employee_Reporting_Line
		FROM
			rv.L_Employee_Reporting_Line AS link
		WHERE
			stage.HK_L_Employee_Reporting_Line = link.HK_L_Employee_Reporting_Line
	);
GO
/****** Object:  Table [bv].[S_HDT_H_Shipper_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[S_HDT_H_Shipper_Northwind](
	[HK_H_Shipper] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[Is_Deleted_Flag] [bit] NOT NULL,
	[Deleted_Datetime] [datetimeoffset](7) NULL,
 CONSTRAINT [PK_S_HDT_H_Shipper_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Shipper] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  Table [bv].[S_HRT_H_Shipper_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[S_HRT_H_Shipper_Northwind](
	[HK_H_Shipper] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[Appearance_Flag] [bit] NOT NULL,
	[Last_Seen_Datetime] [datetimeoffset](7) NULL,
 CONSTRAINT [PK_S_HRT_H_Shipper_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Shipper] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [bv].[v_history_S_HRT_H_Shipper_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_history_S_HRT_H_Shipper_Northwind] (
	  HK_H_Shipper
	, DV_Load_Datetime_Start
	, DV_Load_Datetime_End
	, DV_Record_Source
	, Appearance_Flag
	, Last_Seen_Datetime
)
AS
SELECT
	  HK_H_Shipper
	, DV_Load_Datetime AS DV_Load_Datetime_Start
	, LEAD(DATEADD(NS, -100, DV_Load_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_H_Shipper ORDER BY DV_Load_Datetime ASC) AS DV_Load_Datetime_End
	, DV_Record_Source
	, Appearance_Flag
	, Last_Seen_Datetime
FROM
	Data_Vault.bv.S_HRT_H_Shipper_Northwind;
GO
/****** Object:  View [bv].[v_stage_S_HDT_H_Shipper_Northwind__S_HRT_H_Shipper_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_S_HDT_H_Shipper_Northwind__S_HRT_H_Shipper_Northwind] (
	  HK_H_Shipper
	, DV_Load_Datetime
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
AS
WITH 
	cte_stage AS (
		SELECT
			  HK_H_Shipper
			, DV_Load_Datetime_Start
			, DV_Load_Datetime_End
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
			, CASE
				WHEN DV_Load_Datetime_Start > DATEADD(HOUR, 24, Last_Seen_Datetime) THEN 1
				ELSE 0
			  END AS Is_Deleted_Flag
			, CASE
				WHEN DV_Load_Datetime_Start > DATEADD(HOUR, 24, Last_Seen_Datetime) THEN DATEADD(HOUR, 24, Last_Seen_Datetime)
				ELSE NULL
			  END AS Deleted_Datetime
		FROM
			Data_Vault.bv.v_history_S_HRT_H_Shipper_Northwind
		WHERE
			SYSUTCDATETIME() AT TIME ZONE 'UTC' BETWEEN DV_Load_Datetime_Start AND DV_Load_Datetime_End
	)

	SELECT
		  stage.HK_H_Shipper
		, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
		, stage.DV_Record_Source
		, stage.Is_Deleted_Flag
		, stage.Deleted_Datetime
	FROM
		cte_stage AS stage
			LEFT JOIN Data_Vault.bv.S_HDT_H_Shipper_Northwind AS sat1
				ON stage.HK_H_Shipper = sat1.HK_H_Shipper
			   AND sat1.DV_Load_Datetime = (
						SELECT
							MAX(sat2.DV_Load_Datetime)
						FROM
							Data_Vault.bv.S_HDT_H_Shipper_Northwind AS sat2
						WHERE
							sat1.HK_H_Shipper= sat2.HK_H_Shipper
					)
	WHERE
		sat1.HK_H_Shipper IS NULL
		OR (
			stage.HK_H_Shipper = sat1.HK_H_Shipper
			AND stage.Is_Deleted_Flag <> sat1.Is_Deleted_Flag
		);
GO
/****** Object:  Table [rv].[L_Employee_Territory]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rv].[L_Employee_Territory](
	[HK_L_Employee_Territory] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](55) NOT NULL,
	[HK_H_Employee] [binary](32) NOT NULL,
	[HK_H_Territory] [binary](32) NOT NULL,
 CONSTRAINT [PK_L_Employee_Territory] PRIMARY KEY NONCLUSTERED 
(
	[HK_L_Employee_Territory] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [rv].[v_stage_L_Employee_Territory__L2_Northwind_EmployeeTerritories]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_L_Employee_Territory__L2_Northwind_EmployeeTerritories] (
	  HK_L_Employee_Territory
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Employee
	, HK_H_Territory
)
AS
SELECT DISTINCT 
	  HK_L_Employee_Territory
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Employee
	, HK_H_Territory
FROM
	Staging.northwind.L2_Northwind_EmployeeTerritories AS stage
WHERE
	NOT EXISTS (
		SELECT
			link.HK_L_Employee_Territory
		FROM
			rv.L_Employee_Territory AS link
		WHERE
			stage.HK_L_Employee_Territory = link.HK_L_Employee_Territory
	);
GO
/****** Object:  Table [bv].[S_HDT_H_Supplier_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[S_HDT_H_Supplier_Northwind](
	[HK_H_Supplier] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[Is_Deleted_Flag] [bit] NOT NULL,
	[Deleted_Datetime] [datetimeoffset](7) NULL,
 CONSTRAINT [PK_S_HDT_H_Supplier_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Supplier] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  Table [bv].[S_HRT_H_Supplier_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[S_HRT_H_Supplier_Northwind](
	[HK_H_Supplier] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[Appearance_Flag] [bit] NOT NULL,
	[Last_Seen_Datetime] [datetimeoffset](7) NULL,
 CONSTRAINT [PK_S_HRT_H_Supplier_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Supplier] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [bv].[v_history_S_HRT_H_Supplier_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_history_S_HRT_H_Supplier_Northwind] (
	  HK_H_Supplier
	, DV_Load_Datetime_Start
	, DV_Load_Datetime_End
	, DV_Record_Source
	, Appearance_Flag
	, Last_Seen_Datetime
)
AS
SELECT
	  HK_H_Supplier
	, DV_Load_Datetime AS DV_Load_Datetime_Start
	, LEAD(DATEADD(NS, -100, DV_Load_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_H_Supplier ORDER BY DV_Load_Datetime ASC) AS DV_Load_Datetime_End
	, DV_Record_Source
	, Appearance_Flag
	, Last_Seen_Datetime
FROM
	Data_Vault.bv.S_HRT_H_Supplier_Northwind;
GO
/****** Object:  View [bv].[v_stage_S_HDT_H_Supplier_Northwind__S_HRT_H_Supplier_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_S_HDT_H_Supplier_Northwind__S_HRT_H_Supplier_Northwind] (
	  HK_H_Supplier
	, DV_Load_Datetime
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
AS
WITH 
	cte_stage AS (
		SELECT
			  HK_H_Supplier
			, DV_Load_Datetime_Start
			, DV_Load_Datetime_End
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
			, CASE
				WHEN DV_Load_Datetime_Start > DATEADD(HOUR, 24, Last_Seen_Datetime) THEN 1
				ELSE 0
			  END AS Is_Deleted_Flag
			, CASE
				WHEN DV_Load_Datetime_Start > DATEADD(HOUR, 24, Last_Seen_Datetime) THEN DATEADD(HOUR, 24, Last_Seen_Datetime)
				ELSE NULL
			  END AS Deleted_Datetime
		FROM
			Data_Vault.bv.v_history_S_HRT_H_Supplier_Northwind
		WHERE
			SYSUTCDATETIME() AT TIME ZONE 'UTC' BETWEEN DV_Load_Datetime_Start AND DV_Load_Datetime_End
	)

	SELECT
		  stage.HK_H_Supplier
		, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
		, stage.DV_Record_Source
		, stage.Is_Deleted_Flag
		, stage.Deleted_Datetime
	FROM
		cte_stage AS stage
			LEFT JOIN Data_Vault.bv.S_HDT_H_Supplier_Northwind AS sat1
				ON stage.HK_H_Supplier = sat1.HK_H_Supplier
			   AND sat1.DV_Load_Datetime = (
						SELECT
							MAX(sat2.DV_Load_Datetime)
						FROM
							Data_Vault.bv.S_HDT_H_Supplier_Northwind AS sat2
						WHERE
							sat1.HK_H_Supplier = sat2.HK_H_Supplier
					)
	WHERE
		sat1.HK_H_Supplier IS NULL
		OR (
			stage.HK_H_Supplier = sat1.HK_H_Supplier
			AND stage.Is_Deleted_Flag <> sat1.Is_Deleted_Flag
		);
GO
/****** Object:  Table [rv].[L_Order_Detail]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rv].[L_Order_Detail](
	[HK_L_Order_Detail] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](55) NOT NULL,
	[HK_H_Order] [binary](32) NOT NULL,
	[HK_H_Product] [binary](32) NOT NULL,
 CONSTRAINT [PK_L_Order_Detail] PRIMARY KEY NONCLUSTERED 
(
	[HK_L_Order_Detail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [rv].[v_stage_L_Order_Detail__L2_Northwind_Order_Details]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_L_Order_Detail__L2_Northwind_Order_Details] (
	  HK_L_Order_Detail
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Order
	, HK_H_Product
)
AS
SELECT DISTINCT 
	  HK_L_Order_Detail
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Order
	, HK_H_Product
FROM
	Staging.northwind.L2_Northwind_Order_Details AS stage
WHERE
	NOT EXISTS (
		SELECT
			link.HK_L_Order_Detail
		FROM
			rv.L_Order_Detail AS link
		WHERE
			stage.HK_L_Order_Detail = link.HK_L_Order_Detail
	);
GO
/****** Object:  Table [bv].[S_HDT_H_Territory_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[S_HDT_H_Territory_Northwind](
	[HK_H_Territory] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[Is_Deleted_Flag] [bit] NOT NULL,
	[Deleted_Datetime] [datetimeoffset](7) NULL,
 CONSTRAINT [PK_S_HDT_H_Territory_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Territory] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  Table [bv].[S_HRT_H_Territory_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[S_HRT_H_Territory_Northwind](
	[HK_H_Territory] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[Appearance_Flag] [bit] NOT NULL,
	[Last_Seen_Datetime] [datetimeoffset](7) NULL,
 CONSTRAINT [PK_S_HRT_H_Territory_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Territory] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [bv].[v_history_S_HRT_H_Territory_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_history_S_HRT_H_Territory_Northwind] (
	  HK_H_Territory
	, DV_Load_Datetime_Start
	, DV_Load_Datetime_End
	, DV_Record_Source
	, Appearance_Flag
	, Last_Seen_Datetime
)
AS
SELECT
	  HK_H_Territory
	, DV_Load_Datetime AS DV_Load_Datetime_Start
	, LEAD(DATEADD(NS, -100, DV_Load_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_H_Territory ORDER BY DV_Load_Datetime ASC) AS DV_Load_Datetime_End
	, DV_Record_Source
	, Appearance_Flag
	, Last_Seen_Datetime
FROM
	Data_Vault.bv.S_HRT_H_Territory_Northwind;
GO
/****** Object:  View [bv].[v_stage_S_HDT_H_Territory_Northwind__S_HRT_H_Territory_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_S_HDT_H_Territory_Northwind__S_HRT_H_Territory_Northwind] (
	  HK_H_Territory
	, DV_Load_Datetime
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
AS
WITH 
	cte_stage AS (
		SELECT
			  HK_H_Territory
			, DV_Load_Datetime_Start
			, DV_Load_Datetime_End
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
			, CASE
				WHEN DV_Load_Datetime_Start > DATEADD(HOUR, 24, Last_Seen_Datetime) THEN 1
				ELSE 0
			  END AS Is_Deleted_Flag
			, CASE
				WHEN DV_Load_Datetime_Start > DATEADD(HOUR, 24, Last_Seen_Datetime) THEN DATEADD(HOUR, 24, Last_Seen_Datetime)
				ELSE NULL
			  END AS Deleted_Datetime
		FROM
			Data_Vault.bv.v_history_S_HRT_H_Territory_Northwind
		WHERE
			SYSUTCDATETIME() AT TIME ZONE 'UTC' BETWEEN DV_Load_Datetime_Start AND DV_Load_Datetime_End
	)

	SELECT
		  stage.HK_H_Territory
		, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
		, stage.DV_Record_Source
		, stage.Is_Deleted_Flag
		, stage.Deleted_Datetime
	FROM
		cte_stage AS stage
			LEFT JOIN Data_Vault.bv.S_HDT_H_Territory_Northwind AS sat1
				ON stage.HK_H_Territory = sat1.HK_H_Territory
			   AND sat1.DV_Load_Datetime = (
						SELECT
							MAX(sat2.DV_Load_Datetime)
						FROM
							Data_Vault.bv.S_HDT_H_Territory_Northwind AS sat2
						WHERE
							sat1.HK_H_Territory= sat2.HK_H_Territory
					)
	WHERE
		sat1.HK_H_Territory IS NULL
		OR (
			stage.HK_H_Territory = sat1.HK_H_Territory
			AND stage.Is_Deleted_Flag <> sat1.Is_Deleted_Flag
		);
GO
/****** Object:  Table [rv].[L_Order_Header]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rv].[L_Order_Header](
	[HK_L_Order_Header] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](55) NOT NULL,
	[HK_H_Order__DK] [binary](32) NOT NULL,
	[HK_H_Customer] [binary](32) NOT NULL,
	[HK_H_Employee] [binary](32) NOT NULL,
	[HK_H_Shipper] [binary](32) NOT NULL,
 CONSTRAINT [PK_L_Order_Header] PRIMARY KEY NONCLUSTERED 
(
	[HK_L_Order_Header] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [rv].[v_stage_L_Order_Header__L2_Northwind_Orders]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_L_Order_Header__L2_Northwind_Orders] (
	  HK_L_Order_Header
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Order__DK
	, HK_H_Customer
	, HK_H_Employee
	, HK_H_Shipper
)
AS
SELECT DISTINCT 
	  HK_L_Order_Header
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Order AS HK_H_Order__DK
	, HK_H_Customer
	, HK_H_Employee
	, HK_H_Shipper
FROM
	Staging.northwind.L2_Northwind_Orders AS stage
WHERE
	NOT EXISTS (
		SELECT
			link.HK_L_Order_Header
		FROM
			rv.L_Order_Header AS link
		WHERE
			stage.HK_L_Order_Header = link.HK_L_Order_Header
	);
GO
/****** Object:  Table [rv].[L_Product_Category]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rv].[L_Product_Category](
	[HK_L_Product_Category] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](55) NOT NULL,
	[HK_H_Product__DK] [binary](32) NOT NULL,
	[HK_H_Product_Category] [binary](32) NOT NULL,
 CONSTRAINT [PK_L_Product_Category] PRIMARY KEY NONCLUSTERED 
(
	[HK_L_Product_Category] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [rv].[v_stage_L_Product_Category__L2_Northwind_Products]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_L_Product_Category__L2_Northwind_Products] (
	  HK_L_Product_Category
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Product__DK
	, HK_H_Product_Category
)
AS
SELECT DISTINCT 
	  HK_L_Product_Category
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Product AS HK_H_Product__DK
	, HK_H_Product_Category
FROM
	Staging.northwind.L2_Northwind_Products AS stage
WHERE
	NOT EXISTS (
		SELECT
			link.HK_L_Product_Category
		FROM
			rv.L_Product_Category AS link
		WHERE
			stage.HK_L_Product_Category = link.HK_L_Product_Category
	);
GO
/****** Object:  Table [rv].[L_Product_Supplier]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rv].[L_Product_Supplier](
	[HK_L_Product_Supplier] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](55) NOT NULL,
	[HK_H_Product__DK] [binary](32) NOT NULL,
	[HK_H_Supplier] [binary](32) NOT NULL,
 CONSTRAINT [PK_L_Product_Supplier] PRIMARY KEY NONCLUSTERED 
(
	[HK_L_Product_Supplier] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [rv].[v_stage_L_Product_Supplier__L2_Northwind_Products]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_L_Product_Supplier__L2_Northwind_Products] (
	  HK_L_Product_Supplier
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Product__DK
	, HK_H_Supplier
)
AS
SELECT DISTINCT 
	  HK_L_Product_Supplier
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Product AS HK_H_Product__DK
	, HK_H_Supplier
FROM
	Staging.northwind.L2_Northwind_Products AS stage
WHERE
	NOT EXISTS (
		SELECT
			link.HK_L_Product_Supplier
		FROM
			rv.L_Product_Supplier AS link
		WHERE
			stage.HK_L_Product_Supplier = link.HK_L_Product_Supplier
	);
GO
/****** Object:  Table [rv].[L_Territory_Region]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rv].[L_Territory_Region](
	[HK_L_Territory_Region] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](55) NOT NULL,
	[HK_H_Territory__DK] [binary](32) NOT NULL,
	[HK_H_Region] [binary](32) NOT NULL,
 CONSTRAINT [PK_L_Territory_Region] PRIMARY KEY NONCLUSTERED 
(
	[HK_L_Territory_Region] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [rv].[v_stage_L_Territory_Region__L2_Northwind_Territories]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_L_Territory_Region__L2_Northwind_Territories] (
	  HK_L_Territory_Region
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Territory__DK
	, HK_H_Region
)
AS
SELECT DISTINCT 
	  HK_L_Territory_Region
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Territory AS HK_H_Territory__DK
	, HK_H_Region
FROM
	Staging.northwind.L2_Northwind_Territories AS stage
WHERE
	NOT EXISTS (
		SELECT
			link.HK_L_Territory_Region
		FROM
			rv.L_Territory_Region AS link
		WHERE
			stage.HK_L_Territory_Region = link.HK_L_Territory_Region
	);
GO
/****** Object:  Table [rv].[R_Date]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rv].[R_Date](
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[Date_Key] [int] NOT NULL,
	[Date] [date] NOT NULL,
	[Date_String] [varchar](16) NOT NULL,
	[Start_Datetime] [datetime2](7) NOT NULL,
	[End_Datetime] [datetime2](7) NOT NULL,
	[Day_Of_Month_Number] [int] NOT NULL,
	[Month_Number] [int] NOT NULL,
	[Month_Name] [varchar](16) NOT NULL,
	[Year_Number] [int] NOT NULL,
	[Day_Of_Week_Number] [int] NOT NULL,
	[Day_Of_Week_Name] [varchar](16) NOT NULL,
	[Quarter_Number] [int] NOT NULL,
	[Quarter_Name] [varchar](16) NOT NULL,
 CONSTRAINT [PK_R_Date] PRIMARY KEY CLUSTERED 
(
	[Date_Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX],
 CONSTRAINT [UK_R_Date] UNIQUE NONCLUSTERED 
(
	[Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  View [rv].[v_stage_R_Date]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_R_Date]
AS
	WITH
	
		-- Define start and end date parameters
		cte_parameters AS (
			SELECT
				  CAST('1900-01-01' AS date) AS date_start
				, DATEFROMPARTS(
					  YEAR(SYSUTCDATETIME() AT TIME ZONE 'UTC') + 100
					, 12
					, 31
				  ) AS date_end  -- 100 years in the future
		),

		-- Generate sequence numbers
		cte_sequence(sequence_number) AS (
			SELECT
				0 AS sequence_number
		
			UNION ALL 
  
			SELECT 
				s.sequence_number + 1
			FROM
				cte_sequence AS s
					CROSS JOIN cte_parameters AS p
			WHERE 
				s.sequence_number < DATEDIFF(DAY, p.date_start, p.date_end)
		),

		-- Generate dates
		cte_date(sequence_number, [Date]) AS (
			SELECT
				  s.sequence_number + 1 AS sequence_number
				, DATEADD(DAY, s.sequence_number, p.date_start) AS [Date]
			FROM
				cte_sequence AS s
					CROSS JOIN cte_parameters AS p
		),

		-- Calculate column values
		cte_columns AS (
			SELECT
				  CAST(CONVERT(varchar(8), [Date], 112) AS int) AS Date_Key
				, CONVERT(date, [Date]) AS 'date'
				, CONVERT(varchar(10), [Date], 120) AS Date_String
				, CONVERT(datetime2(7), [Date]) 'Start_Datetime'
				, DATEPART(DAY, [Date]) AS Day_Of_Month_Number
				, DATEPART(MONTH, [Date]) AS Month_Number
				, DATENAME(MONTH, [Date]) AS Month_Name
				, DATEPART(YEAR, [Date]) AS Year_Number
				, DATEDIFF(day, '1753-01-01', [Date]) % 7 + 1 AS Day_Of_Week_Number
				, DATENAME(WEEKDAY, [Date]) AS Day_Of_Week_Name
				, DATEPART(QUARTER, [Date]) AS Quarter_Number
				, CASE DATEPART(Quarter, [Date])
					WHEN 1 THEN 'Quarter One'
					WHEN 2 THEN 'Quarter Two'
					WHEN 3 THEN 'Quarter Three'
					WHEN 4 THEN 'Quarter Four'
					END AS Quarter_Name
			FROM 
				cte_date
		),

		-- Generate date end datetime values
		cte_end_date AS (
			SELECT 
				  s.Date_Key
				, s.[Date]
				, s.Date_String
				, s.Start_Datetime
				, LEAD(DATEADD(NS, -100, s.Start_Datetime), 1, CONCAT(CAST(s.Date AS varchar(10)), ' 23:59:59.9999999')) OVER(ORDER BY s.Start_Datetime ASC) AS End_Datetime
				, s.Day_Of_Month_Number
				, s.Month_Number
				, s.Month_Name
				, s.Year_Number
				, s.Day_Of_Week_Number
				, s.Day_Of_Week_Name
				, s.Quarter_Number
				, s.Quarter_Name
			FROM 
				cte_columns AS s
		)

		-- Identify dates not yet loaded in R_Date
		SELECT 
			  SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
			, 'SYSTEM' AS DV_Record_Source
			, CAST(stage.Date_Key AS int) AS Date_Key
			, CAST(stage.[Date] AS date) AS [Date]
			, CAST(stage.Date_String AS varchar(16)) AS Date_String
			, CAST(stage.Start_Datetime AS datetime2(7)) AS Start_Datetime
			, CAST(stage.End_Datetime AS datetime2(7)) AS End_Datetime
			, CAST(stage.Day_Of_Month_Number AS int) AS Day_Of_Month_Number
			, CAST(stage.Month_Number AS int) AS Month_Number
			, CAST(stage.Month_Name AS varchar(16)) AS Month_Name
			, CAST(stage.Year_Number AS int) AS Year_Number
			, CAST(stage.Day_Of_Week_Number AS int) AS Day_Of_Week_Number
			, CAST(stage.Day_Of_Week_Name AS varchar(16)) AS Day_Of_Week_Name
			, CAST(stage.Quarter_Number AS int) AS Quarter_Number
			, CAST(stage.Quarter_Name AS varchar(16)) AS Quarter_Name
		FROM 
			cte_end_date AS stage
		WHERE 
			NOT EXISTS (
				SELECT
					1
				FROM
					Data_Vault.rv.R_Date AS ref
				WHERE
					stage.Date_Key = ref.Date_Key
			);
GO
/****** Object:  Table [rv].[R_Time]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rv].[R_Time](
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[Time_Key] [int] NOT NULL,
	[Time] [time](0) NOT NULL,
	[Time_String] [varchar](8) NOT NULL,
	[Hours_Of_Day] [int] NOT NULL,
	[Minutes_Of_Hour] [int] NOT NULL,
	[Seconds_Of_Minute] [int] NOT NULL,
 CONSTRAINT [PK_R_Time] PRIMARY KEY CLUSTERED 
(
	[Time_Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX],
 CONSTRAINT [UK_R_Time] UNIQUE NONCLUSTERED 
(
	[Time] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  View [rv].[v_stage_R_Time]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_R_Time]
AS
	WITH

		cte_parameters AS (
			SELECT
				  CAST('00:00:00' AS time(0)) start_time  -- first second of the day
				, CAST('23:59:59' AS time(0)) AS end_time  -- last second of the day
		),

		-- Generate sequence numbers
		cte_sequence(sequence_number) AS (
			SELECT
				0 AS sequence_number
		
			UNION ALL 
  
			SELECT 
				s.sequence_number + 1
			FROM
				cte_sequence AS s
					CROSS JOIN cte_parameters AS p	
			WHERE 
				s.sequence_number < DATEDIFF(SECOND, p.start_time, p.end_time)
		),

		-- Generate times
		cte_time AS (
			SELECT
				  s.sequence_number + 1 AS sequence_number
				, DATEADD(SECOND, s.sequence_number, p.start_time) AS [Time]
			FROM
				cte_sequence AS s
					CROSS JOIN cte_parameters AS p
		),

		-- Calculate column values
		cte_columns AS (
			SELECT
				  sequence_number AS Time_Key
				, [Time]
				, CONVERT(varchar(8), [Time]) AS Time_String
				, DATENAME(HOUR, [Time]) AS Hours_Of_Day
				, DATENAME(MINUTE, [Time]) AS Minutes_Of_Hour
				, DATENAME(SECOND, [Time]) AS Seconds_Of_Minute
			FROM 
				cte_time
		)

		-- Identify times not yet loaded in R_Time. Should be zero records. Table only need be loaded once)
		SELECT
			  SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
			, 'SYSTEM' AS DV_Record_Source
			, CAST(Time_Key AS int) AS Time_Key
			, CAST([Time] AS time(0)) AS [Time]
			, CAST(Time_String AS varchar(8)) AS Time_String
			, CAST(Hours_Of_Day AS int) AS Hours_Of_Day
			, CAST(Minutes_Of_Hour AS int) AS Minutes_Of_Hour
			, CAST(Seconds_Of_Minute AS int) AS Seconds_Of_Minute
		FROM
			cte_columns AS stage
		WHERE 
			NOT EXISTS (
				SELECT
					1
				FROM
					Data_Vault.rv.R_Time AS ref
				WHERE
					stage.Time_Key = ref.Time_Key
			);
GO
/****** Object:  View [bv].[v_history_S_LE_L_Employee_Reporting_Line_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_history_S_LE_L_Employee_Reporting_Line_Northwind] (
	  HK_L_Employee_Reporting_Line
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Employee__Direct_Report__DK
	, Start_Datetime
	, End_Datetime
	, HK_L_Employee_Reporting_Line__Previous
	, DV_Load_Datetime__Previous
)
AS
SELECT
	  HK_L_Employee_Reporting_Line
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Employee__Direct_Report__DK
	, Start_Datetime
	, LEAD(DATEADD(NS, -100, Start_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_H_Employee__Direct_Report__DK ORDER BY Start_Datetime ASC) AS End_Datetime
	, HK_L_Employee_Reporting_Line__Previous
	, DV_Load_Datetime__Previous
FROM
	Data_Vault.bv.S_LE_L_Employee_Reporting_Line_Northwind;
GO
/****** Object:  View [bv].[v_history_S_LE_L_Order_Header_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_history_S_LE_L_Order_Header_Northwind] (
	  HK_L_Order_Header
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Order__DK
	, Start_Datetime
	, End_Datetime
	, HK_L_Order_Header__Previous
	, DV_Load_Datetime__Previous
)
AS
SELECT
	  HK_L_Order_Header
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Order__DK
	, Start_Datetime
	, LEAD(DATEADD(NS, -100, Start_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_H_Order__DK ORDER BY Start_Datetime ASC) AS End_Datetime
	, HK_L_Order_Header__Previous
	, DV_Load_Datetime__Previous
FROM 
	Data_Vault.bv.S_LE_L_Order_Header_Northwind;
GO
/****** Object:  View [bv].[v_history_S_LE_L_Product_Category_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_history_S_LE_L_Product_Category_Northwind] (
	  HK_L_Product_Category
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Product__DK
	, Start_Datetime
	, End_Datetime
	, HK_L_Product_Category__Previous
	, DV_Load_Datetime__Previous
)
AS
SELECT
	  HK_L_Product_Category
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Product__DK
	, Start_Datetime
	, LEAD(DATEADD(NS, -100, Start_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_H_Product__DK ORDER BY Start_Datetime ASC) AS End_Datetime
	, HK_L_Product_Category__Previous
	, DV_Load_Datetime__Previous
FROM
	Data_Vault.bv.S_LE_L_Product_Category_Northwind;
GO
/****** Object:  View [bv].[v_history_S_HDT_H_Customer_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_history_S_HDT_H_Customer_Northwind] (
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
/****** Object:  View [bv].[v_history_S_LE_L_Product_Supplier_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_history_S_LE_L_Product_Supplier_Northwind] (
	  HK_L_Product_Supplier
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Product__DK
	, Start_Datetime
	, End_Datetime
	, HK_L_Product_Supplier__Previous
	, DV_Load_Datetime__Previous
)
AS
SELECT
	  HK_L_Product_Supplier
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Product__DK
	, Start_Datetime
	, LEAD(DATEADD(NS, -100, Start_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_H_Product__DK ORDER BY Start_Datetime ASC) AS End_Datetime
	, HK_L_Product_Supplier__Previous
	, DV_Load_Datetime__Previous
FROM
	Data_Vault.bv.S_LE_L_Product_Supplier_Northwind;
GO
/****** Object:  View [bv].[v_history_S_HDT_H_Customer_Type_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_history_S_HDT_H_Customer_Type_Northwind] (
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
/****** Object:  View [bv].[v_history_S_LE_L_Territory_Region_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_history_S_LE_L_Territory_Region_Northwind] (
	  HK_L_Territory_Region
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Territory__DK
	, Start_Datetime
	, End_Datetime
	, HK_L_Territory_Region__Previous
	, DV_Load_Datetime__Previous
)
AS
SELECT
	  HK_L_Territory_Region
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Territory__DK
	, Start_Datetime
	, LEAD(DATEADD(NS, -100, Start_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_H_Territory__DK ORDER BY Start_Datetime ASC) AS End_Datetime
	, HK_L_Territory_Region__Previous
	, DV_Load_Datetime__Previous
FROM
	Data_Vault.bv.S_LE_L_Territory_Region_Northwind;
GO
/****** Object:  View [bv].[v_history_S_HDT_H_Employee_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_history_S_HDT_H_Employee_Northwind] (
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
/****** Object:  View [bv].[v_history_S_HDT_H_Order_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_history_S_HDT_H_Order_Northwind] (
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
/****** Object:  View [bv].[v_history_S_HDT_H_Product_Category_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_history_S_HDT_H_Product_Category_Northwind] (
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
/****** Object:  Table [bv].[S_LRT_L_Customer_Type_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[S_LRT_L_Customer_Type_Northwind](
	[HK_L_Customer_Type] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[Appearance_Flag] [bit] NOT NULL,
	[Last_Seen_Datetime] [datetimeoffset](7) NULL,
 CONSTRAINT [PK_S_LRT_L_Customer_Type_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_L_Customer_Type] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [bv].[v_stage_S_LRT_L_Customer_Type_Northwind__L2_Northwind_CustomerCustomerDemo]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_S_LRT_L_Customer_Type_Northwind__L2_Northwind_CustomerCustomerDemo] (
	  HK_L_Customer_Type
	, DV_Load_Datetime
	, DV_Record_Source
	, Appearance_Flag
	, Last_Seen_Datetime
)
AS
SELECT DISTINCT
	  key_set.HK_L_Customer_Type
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, COALESCE(stage.DV_Record_Source, 'SYSTEM') AS DV_Record_Source
	, CASE
		WHEN stage.HK_L_Customer_Type IS NOT NULL THEN 1
		ELSE 0
	  END AS Appearance_Flag
	, COALESCE(stage.DV_Load_Datetime, sat1.Last_Seen_Datetime) AS Last_Seen_Datetime
FROM
	(
		SELECT
			HK_L_Customer_Type
		FROM
			Staging.northwind.L2_Northwind_CustomerCustomerDemo
		UNION
		SELECT
			HK_L_Customer_Type
		FROM
			Data_Vault.rv.L_Customer_Type
	) AS key_set
		LEFT JOIN Staging.northwind.L2_Northwind_CustomerCustomerDemo AS stage
			ON key_set.HK_L_Customer_Type = stage.HK_L_Customer_Type
		LEFT JOIN bv.S_LRT_L_Customer_Type_Northwind AS sat1 
			ON key_set.HK_L_Customer_Type = sat1.HK_L_Customer_Type
		   AND sat1.DV_Load_Datetime = (
					SELECT
						MAX(sat2.DV_Load_Datetime)
					FROM
						bv.S_LRT_L_Customer_Type_Northwind AS sat2
					WHERE
						sat1.HK_L_Customer_Type = sat2.HK_L_Customer_Type
				)
WHERE
	key_set.HK_L_Customer_Type NOT IN (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
	);
GO
/****** Object:  View [bv].[v_history_S_HDT_H_Product_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_history_S_HDT_H_Product_Northwind] (
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
/****** Object:  Table [bv].[S_LRT_L_Employee_Territory_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[S_LRT_L_Employee_Territory_Northwind](
	[HK_L_Employee_Territory] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[Appearance_Flag] [bit] NOT NULL,
	[Last_Seen_Datetime] [datetimeoffset](7) NULL,
 CONSTRAINT [PK_S_LRT_L_Employee_Territory_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_L_Employee_Territory] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [bv].[v_stage_S_LRT_L_Employee_Territory_Northwind__L2_Northwind_EmployeeTerritories]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_S_LRT_L_Employee_Territory_Northwind__L2_Northwind_EmployeeTerritories] (
	  HK_L_Employee_Territory
	, DV_Load_Datetime
	, DV_Record_Source
	, Appearance_Flag
	, Last_Seen_Datetime
)
AS
SELECT DISTINCT
	  key_set.HK_L_Employee_Territory
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, COALESCE(stage.DV_Record_Source, 'SYSTEM') AS DV_Record_Source
	, CASE
		WHEN stage.HK_L_Employee_Territory IS NOT NULL THEN 1
		ELSE 0
	  END AS Appearance_Flag
	, COALESCE(stage.DV_Load_Datetime, sat1.Last_Seen_Datetime) AS Last_Seen_Datetime
FROM
	(
		SELECT
			HK_L_Employee_Territory
		FROM
			Staging.northwind.L2_Northwind_EmployeeTerritories
		UNION
		SELECT
			HK_L_Employee_Territory
		FROM
			Data_Vault.rv.L_Employee_Territory
	) AS key_set
		LEFT JOIN Staging.northwind.L2_Northwind_EmployeeTerritories AS stage
			ON key_set.HK_L_Employee_Territory = stage.HK_L_Employee_Territory
		LEFT JOIN bv.S_LRT_L_Employee_Territory_Northwind AS sat1 
			ON key_set.HK_L_Employee_Territory = sat1.HK_L_Employee_Territory
		   AND sat1.DV_Load_Datetime = (
					SELECT
						MAX(sat2.DV_Load_Datetime)
					FROM
						bv.S_LRT_L_Employee_Territory_Northwind AS sat2
					WHERE
						sat1.HK_L_Employee_Territory = sat2.HK_L_Employee_Territory
				)
WHERE
	key_set.HK_L_Employee_Territory NOT IN (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
	);
GO
/****** Object:  View [bv].[v_history_S_HDT_H_Region_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_history_S_HDT_H_Region_Northwind] (
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
/****** Object:  Table [bv].[S_LRT_L_Order_Detail_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[S_LRT_L_Order_Detail_Northwind](
	[HK_L_Order_Detail] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[Appearance_Flag] [bit] NOT NULL,
	[Last_Seen_Datetime] [datetimeoffset](7) NULL,
 CONSTRAINT [PK_S_LRT_L_Order_Detail_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_L_Order_Detail] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [bv].[v_stage_S_LRT_L_Order_Detail_Northwind__L2_Northwind_Order_Details]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_S_LRT_L_Order_Detail_Northwind__L2_Northwind_Order_Details] (
	  HK_L_Order_Detail
	, DV_Load_Datetime
	, DV_Record_Source
	, Appearance_Flag
	, Last_Seen_Datetime
)
AS
SELECT DISTINCT
	  key_set.HK_L_Order_Detail
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, COALESCE(stage.DV_Record_Source, 'SYSTEM') AS DV_Record_Source
	, CASE
		WHEN stage.HK_L_Order_Detail IS NOT NULL THEN 1
		ELSE 0
	  END AS Appearance_Flag
	, COALESCE(stage.DV_Load_Datetime, sat1.Last_Seen_Datetime) AS Last_Seen_Datetime
FROM
	(
		SELECT
			HK_L_Order_Detail
		FROM
			Staging.northwind.L2_Northwind_Order_Details
		UNION
		SELECT
			HK_L_Order_Detail
		FROM
			Data_Vault.rv.L_Order_Detail
	) AS key_set
		LEFT JOIN Staging.northwind.L2_Northwind_Order_Details AS stage
			ON key_set.HK_L_Order_Detail = stage.HK_L_Order_Detail
		LEFT JOIN bv.S_LRT_L_Order_Detail_Northwind AS sat1 
			ON key_set.HK_L_Order_Detail = sat1.HK_L_Order_Detail
		   AND sat1.DV_Load_Datetime = (
					SELECT
						MAX(sat2.DV_Load_Datetime)
					FROM
						bv.S_LRT_L_Order_Detail_Northwind AS sat2
					WHERE
						sat1.HK_L_Order_Detail = sat2.HK_L_Order_Detail
				)
WHERE
	key_set.HK_L_Order_Detail NOT IN (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
	);
GO
/****** Object:  View [bv].[v_history_S_HDT_H_Shipper_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_history_S_HDT_H_Shipper_Northwind] (
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
/****** Object:  View [bv].[v_history_S_HDT_H_Supplier_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_history_S_HDT_H_Supplier_Northwind] (
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
/****** Object:  View [bv].[v_history_S_HDT_H_Territory_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_history_S_HDT_H_Territory_Northwind] (
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
/****** Object:  Table [bv].[S_LDT_L_Customer_Type_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[S_LDT_L_Customer_Type_Northwind](
	[HK_L_Customer_Type] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[Is_Deleted_Flag] [bit] NOT NULL,
	[Deleted_Datetime] [datetimeoffset](7) NULL,
 CONSTRAINT [PK_S_LDT_L_Customer_Type_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_L_Customer_Type] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [bv].[v_history_S_LRT_L_Customer_Type_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_history_S_LRT_L_Customer_Type_Northwind] (
	  HK_L_Customer_Type
	, DV_Load_Datetime_Start
	, DV_Load_Datetime_End
	, DV_Record_Source
	, Appearance_Flag
	, Last_Seen_Datetime
)
AS
SELECT
	  HK_L_Customer_Type
	, DV_Load_Datetime AS DV_Load_Datetime_Start
	, LEAD(DATEADD(NS, -100, DV_Load_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_L_Customer_Type ORDER BY DV_Load_Datetime ASC) AS DV_Load_Datetime_End
	, DV_Record_Source
	, Appearance_Flag
	, Last_Seen_Datetime
FROM
	Data_Vault.bv.S_LRT_L_Customer_Type_Northwind;
GO
/****** Object:  View [bv].[v_stage_S_LDT_L_Customer_Type_Northwind__S_LRT_L_Customer_Type_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_S_LDT_L_Customer_Type_Northwind__S_LRT_L_Customer_Type_Northwind] (
	  HK_L_Customer_Type
	, DV_Load_Datetime
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
AS
WITH
	cte_stage AS (
		SELECT 
			  HK_L_Customer_Type
			, DV_Load_Datetime_Start
			, DV_Load_Datetime_End
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
			, CASE
				WHEN DV_Load_Datetime_Start > DATEADD(HOUR, 24, Last_Seen_Datetime) THEN 1
				ELSE 0
				END AS Is_Deleted_Flag
			, CASE
				WHEN DV_Load_Datetime_Start > DATEADD(HOUR, 24, Last_Seen_Datetime) THEN DATEADD(HOUR, 24, Last_Seen_Datetime)
				ELSE NULL
				END AS Deleted_Datetime
		FROM
			Data_Vault.bv.v_history_S_LRT_L_Customer_Type_Northwind
		WHERE
			SYSUTCDATETIME() AT TIME ZONE 'UTC' BETWEEN DV_Load_Datetime_Start AND DV_Load_Datetime_End
	)

	SELECT
		  stage.HK_L_Customer_Type
		, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
		, stage.DV_Record_Source
		, stage.Is_Deleted_Flag
		, stage.Deleted_Datetime
	FROM
		cte_stage AS stage
			LEFT JOIN Data_Vault.bv.S_LDT_L_Customer_Type_Northwind AS sat1
				ON stage.HK_L_Customer_Type = sat1.HK_L_Customer_Type
			   AND sat1.DV_Load_Datetime = (
						SELECT
							MAX(sat2.DV_Load_Datetime)
						FROM
							Data_Vault.bv.S_LDT_L_Customer_Type_Northwind AS sat2
						WHERE
							sat1.HK_L_Customer_Type = sat2.HK_L_Customer_Type
						
					)
		WHERE
			sat1.HK_L_Customer_Type IS NULL
			OR (
				stage.HK_L_Customer_Type = sat1.HK_L_Customer_Type
				AND stage.Is_Deleted_Flag <> sat1.Is_Deleted_Flag
			);
GO
/****** Object:  Table [bv].[S_LDT_L_Employee_Territory_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[S_LDT_L_Employee_Territory_Northwind](
	[HK_L_Employee_Territory] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[Is_Deleted_Flag] [bit] NOT NULL,
	[Deleted_Datetime] [datetimeoffset](7) NULL,
 CONSTRAINT [PK_S_LDT_L_Employee_Territory_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_L_Employee_Territory] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [bv].[v_history_S_LRT_L_Employee_Territory_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_history_S_LRT_L_Employee_Territory_Northwind] (
	  HK_L_Employee_Territory
	, DV_Load_Datetime_Start
	, DV_Load_Datetime_End
	, DV_Record_Source
	, Appearance_Flag
	, Last_Seen_Datetime
)
AS
SELECT
	  HK_L_Employee_Territory
	, DV_Load_Datetime AS DV_Load_Datetime_Start
	, LEAD(DATEADD(NS, -100, DV_Load_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_L_Employee_Territory ORDER BY DV_Load_Datetime ASC) AS DV_Load_Datetime_End
	, DV_Record_Source
	, Appearance_Flag
	, Last_Seen_Datetime
FROM
	Data_Vault.bv.S_LRT_L_Employee_Territory_Northwind;
GO
/****** Object:  View [bv].[v_stage_S_LDT_L_Employee_Territory_Northwind__S_LRT_L_Employee_Territory_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_S_LDT_L_Employee_Territory_Northwind__S_LRT_L_Employee_Territory_Northwind] (
	  HK_L_Employee_Territory
	, DV_Load_Datetime
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
AS
WITH
	cte_stage AS (
		SELECT 
			  HK_L_Employee_Territory
			, DV_Load_Datetime_Start
			, DV_Load_Datetime_End
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
			, CASE
				WHEN DV_Load_Datetime_Start > DATEADD(HOUR, 24, Last_Seen_Datetime) THEN 1
				ELSE 0
				END AS Is_Deleted_Flag
			, CASE
				WHEN DV_Load_Datetime_Start > DATEADD(HOUR, 24, Last_Seen_Datetime) THEN DATEADD(HOUR, 24, Last_Seen_Datetime)
				ELSE NULL
				END AS Deleted_Datetime
		FROM
			Data_Vault.bv.v_history_S_LRT_L_Employee_Territory_Northwind
		WHERE
			SYSUTCDATETIME() AT TIME ZONE 'UTC' BETWEEN DV_Load_Datetime_Start AND DV_Load_Datetime_End
	)

	SELECT
		  stage.HK_L_Employee_Territory
		, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
		, stage.DV_Record_Source
		, stage.Is_Deleted_Flag
		, stage.Deleted_Datetime
	FROM
		cte_stage AS stage
			LEFT JOIN Data_Vault.bv.S_LDT_L_Employee_Territory_Northwind AS sat1
				ON stage.HK_L_Employee_Territory = sat1.HK_L_Employee_Territory
			   AND sat1.DV_Load_Datetime = (
						SELECT
							MAX(sat2.DV_Load_Datetime)
						FROM
							Data_Vault.bv.S_LDT_L_Employee_Territory_Northwind AS sat2
						WHERE
							sat1.HK_L_Employee_Territory = sat2.HK_L_Employee_Territory	
					)
		WHERE
			sat1.HK_L_Employee_Territory IS NULL
			OR (
				stage.HK_L_Employee_Territory = sat1.HK_L_Employee_Territory
				AND stage.Is_Deleted_Flag <> sat1.Is_Deleted_Flag
			);
GO
/****** Object:  Table [bv].[S_LDT_L_Order_Detail_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[S_LDT_L_Order_Detail_Northwind](
	[HK_L_Order_Detail] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[Is_Deleted_Flag] [bit] NOT NULL,
	[Deleted_Datetime] [datetimeoffset](7) NULL,
 CONSTRAINT [PK_S_LDT_L_Order_Detail_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_L_Order_Detail] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [bv].[v_history_S_LRT_L_Order_Detail_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_history_S_LRT_L_Order_Detail_Northwind] (
	  HK_L_Order_Detail
	, DV_Load_Datetime_Start
	, DV_Load_Datetime_End
	, DV_Record_Source
	, Appearance_Flag
	, Last_Seen_Datetime
)
AS
SELECT
	  HK_L_Order_Detail
	, DV_Load_Datetime AS DV_Load_Datetime_Start
	, LEAD(DATEADD(NS, -100, DV_Load_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_L_Order_Detail ORDER BY DV_Load_Datetime ASC) AS DV_Load_Datetime_End
	, DV_Record_Source
	, Appearance_Flag
	, Last_Seen_Datetime
FROM
	Data_Vault.bv.S_LRT_L_Order_Detail_Northwind;
GO
/****** Object:  View [bv].[v_stage_S_LDT_L_Order_Detail_Northwind__S_LRT_L_Order_Detail_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_S_LDT_L_Order_Detail_Northwind__S_LRT_L_Order_Detail_Northwind] (
	  HK_L_Order_Detail
	, DV_Load_Datetime
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
AS
WITH
	cte_stage AS (
		SELECT 
			  HK_L_Order_Detail
			, DV_Load_Datetime_Start
			, DV_Load_Datetime_End
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
			, CASE
				WHEN DV_Load_Datetime_Start > DATEADD(HOUR, 24, Last_Seen_Datetime) THEN 1
				ELSE 0
				END AS Is_Deleted_Flag
			, CASE
				WHEN DV_Load_Datetime_Start > DATEADD(HOUR, 24, Last_Seen_Datetime) THEN DATEADD(HOUR, 24, Last_Seen_Datetime)
				ELSE NULL
				END AS Deleted_Datetime
		FROM
			Data_Vault.bv.v_history_S_LRT_L_Order_Detail_Northwind
		WHERE
			SYSUTCDATETIME() AT TIME ZONE 'UTC' BETWEEN DV_Load_Datetime_Start AND DV_Load_Datetime_End
	)

	SELECT
		  stage.HK_L_Order_Detail
		, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
		, stage.DV_Record_Source
		, stage.Is_Deleted_Flag
		, stage.Deleted_Datetime
	FROM
		cte_stage AS stage
			LEFT JOIN Data_Vault.bv.S_LDT_L_Order_Detail_Northwind AS sat1
				ON stage.HK_L_Order_Detail = sat1.HK_L_Order_Detail
			   AND sat1.DV_Load_Datetime = (
						SELECT
							MAX(sat2.DV_Load_Datetime)
						FROM
							Data_Vault.bv.S_LDT_L_Order_Detail_Northwind AS sat2
						WHERE
							sat1.HK_L_Order_Detail = sat2.HK_L_Order_Detail
						
					)
		WHERE
			sat1.HK_L_Order_Detail IS NULL
			OR (
				stage.HK_L_Order_Detail = sat1.HK_L_Order_Detail
				AND stage.Is_Deleted_Flag <> sat1.Is_Deleted_Flag
			);
GO
/****** Object:  Table [rv].[H_Customer]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rv].[H_Customer](
	[HK_H_Customer] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[CustomerID] [nchar](5) NULL,
 CONSTRAINT [PK_H_Customer] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Customer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX],
 CONSTRAINT [UK_H_Customer] UNIQUE NONCLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [bv].[v_stage_S_HRT_H_Customer_Northwind__L2_Northwind_Customers]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_S_HRT_H_Customer_Northwind__L2_Northwind_Customers] (
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
/****** Object:  Table [rv].[H_Customer_Type]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rv].[H_Customer_Type](
	[HK_H_Customer_Type] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[CustomerTypeID] [nchar](10) NULL,
 CONSTRAINT [PK_H_Customer_Type] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Customer_Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX],
 CONSTRAINT [UK_H_Customer_Type] UNIQUE NONCLUSTERED 
(
	[CustomerTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [bv].[v_stage_S_HRT_H_Customer_Type_Northwind__L2_Northwind_CustomerDemographics]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_S_HRT_H_Customer_Type_Northwind__L2_Northwind_CustomerDemographics] (
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
/****** Object:  Table [rv].[H_Employee]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rv].[H_Employee](
	[HK_H_Employee] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[EmployeeID] [int] NOT NULL,
 CONSTRAINT [PK_H_Employee] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Employee] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX],
 CONSTRAINT [UK_H_Employee] UNIQUE NONCLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [bv].[v_stage_S_HRT_H_Employee_Northwind__L2_Northwind_Employees]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_S_HRT_H_Employee_Northwind__L2_Northwind_Employees] (
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
/****** Object:  Table [rv].[H_Order]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rv].[H_Order](
	[HK_H_Order] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[OrderID] [int] NOT NULL,
 CONSTRAINT [PK_H_Order] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Order] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX],
 CONSTRAINT [UK_H_Order] UNIQUE NONCLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [bv].[v_stage_S_HRT_H_Order_Northwind__L2_Northwind_Orders]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_S_HRT_H_Order_Northwind__L2_Northwind_Orders] (
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
/****** Object:  Table [rv].[H_Product_Category]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rv].[H_Product_Category](
	[HK_H_Product_Category] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[CategoryID] [int] NOT NULL,
 CONSTRAINT [PK_H_Product_Category] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Product_Category] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX],
 CONSTRAINT [UK_H_Product_Category] UNIQUE NONCLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [bv].[v_stage_S_HRT_H_Product_Category_Northwind__L2_Northwind_Categories]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_S_HRT_H_Product_Category_Northwind__L2_Northwind_Categories] (
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
/****** Object:  Table [rv].[H_Product]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rv].[H_Product](
	[HK_H_Product] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[ProductID] [int] NOT NULL,
 CONSTRAINT [PK_H_Product] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Product] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX],
 CONSTRAINT [UK_H_Product] UNIQUE NONCLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [bv].[v_stage_S_HRT_H_Product_Northwind__L2_Northwind_Products]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_S_HRT_H_Product_Northwind__L2_Northwind_Products] (
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
/****** Object:  View [bv].[v_history_S_LDT_L_Customer_Type_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_history_S_LDT_L_Customer_Type_Northwind] (
	  HK_L_Customer_Type
	, DV_Load_Datetime_Start
	, DV_Load_Datetime_End
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
AS
SELECT
	  HK_L_Customer_Type
	, DV_Load_Datetime AS DV_Load_Datetime_Start
	, LEAD(DATEADD(NS, -100, DV_Load_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_L_Customer_Type ORDER BY DV_Load_Datetime ASC) AS DV_Load_Datetime_End
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
FROM
	Data_Vault.bv.S_LDT_L_Customer_Type_Northwind;
GO
/****** Object:  Table [rv].[H_Region]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rv].[H_Region](
	[HK_H_Region] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[RegionID] [int] NOT NULL,
 CONSTRAINT [PK_H_Region] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Region] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX],
 CONSTRAINT [UK_H_Region] UNIQUE NONCLUSTERED 
(
	[RegionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [bv].[v_stage_S_HRT_H_Region_Northwind__L2_Northwind_Region]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_S_HRT_H_Region_Northwind__L2_Northwind_Region] (
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
/****** Object:  View [bv].[v_history_S_LDT_L_Employee_Territory_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_history_S_LDT_L_Employee_Territory_Northwind] (
	  HK_L_Employee_Territory
	, DV_Load_Datetime_Start
	, DV_Load_Datetime_End
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
AS
SELECT
	  HK_L_Employee_Territory
	, DV_Load_Datetime AS DV_Load_Datetime_Start
	, LEAD(DATEADD(NS, -100, DV_Load_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_L_Employee_Territory ORDER BY DV_Load_Datetime ASC) AS DV_Load_Datetime_End
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
FROM
	Data_Vault.bv.S_LDT_L_Employee_Territory_Northwind;
GO
/****** Object:  Table [rv].[H_Shipper]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rv].[H_Shipper](
	[HK_H_Shipper] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[ShipperID] [int] NOT NULL,
 CONSTRAINT [PK_H_Shipper] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Shipper] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX],
 CONSTRAINT [UK_H_Shipper] UNIQUE NONCLUSTERED 
(
	[ShipperID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [bv].[v_stage_S_HRT_H_Shipper_Northwind__L2_Northwind_Shippers]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_S_HRT_H_Shipper_Northwind__L2_Northwind_Shippers] (
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
/****** Object:  View [rv].[v_stage_S_H_Customer_Northwind__L2_Northwind_Customers]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_S_H_Customer_Northwind__L2_Northwind_Customers] (
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
/****** Object:  View [bv].[v_history_S_LDT_L_Order_Detail_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_history_S_LDT_L_Order_Detail_Northwind] (
	  HK_L_Order_Detail
	, DV_Load_Datetime_Start
	, DV_Load_Datetime_End
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
AS
SELECT
	  HK_L_Order_Detail
	, DV_Load_Datetime AS DV_Load_Datetime_Start
	, LEAD(DATEADD(NS, -100, DV_Load_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_L_Order_Detail ORDER BY DV_Load_Datetime ASC) AS DV_Load_Datetime_End
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
FROM
	Data_Vault.bv.S_LDT_L_Order_Detail_Northwind;
GO
/****** Object:  Table [rv].[H_Supplier]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rv].[H_Supplier](
	[HK_H_Supplier] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[SupplierID] [int] NOT NULL,
 CONSTRAINT [PK_H_Supplier] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Supplier] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX],
 CONSTRAINT [UK_H_Supplier] UNIQUE NONCLUSTERED 
(
	[SupplierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [bv].[v_stage_S_HRT_H_Supplier_Northwind__L2_Northwind_Suppliers]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_S_HRT_H_Supplier_Northwind__L2_Northwind_Suppliers] (
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
/****** Object:  View [rv].[v_stage_S_H_Customer_Type_Northwind__L2_Northwind_CustomerDemographics]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_S_H_Customer_Type_Northwind__L2_Northwind_CustomerDemographics] (
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
/****** Object:  Table [rv].[H_Territory]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rv].[H_Territory](
	[HK_H_Territory] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[TerritoryID] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_H_Territory] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Territory] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX],
 CONSTRAINT [UK_H_Territory] UNIQUE NONCLUSTERED 
(
	[TerritoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [bv].[v_stage_S_HRT_H_Territory_Northwind__L2_Northwind_Territories]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_S_HRT_H_Territory_Northwind__L2_Northwind_Territories] (
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
/****** Object:  View [rv].[v_stage_S_H_Employee_Northwind__L2_Northwind_Employees]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_S_H_Employee_Northwind__L2_Northwind_Employees] (
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
/****** Object:  View [rv].[v_stage_S_H_Order_Northwind__L2_Northwind_Orders]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_S_H_Order_Northwind__L2_Northwind_Orders] (
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
/****** Object:  View [rv].[v_stage_S_H_Product_Category_Northwind__L2_Northwind_Categories]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_S_H_Product_Category_Northwind__L2_Northwind_Categories] (
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
/****** Object:  View [rv].[v_stage_S_H_Product_Northwind__L2_Northwind_Products]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_S_H_Product_Northwind__L2_Northwind_Products] (
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
/****** Object:  View [rv].[v_stage_S_H_Region_Northwind__L2_Northwind_Region]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_S_H_Region_Northwind__L2_Northwind_Region] (
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
/****** Object:  View [rv].[v_stage_S_H_Shipper_Northwind__L2_Northwind_Shippers]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_S_H_Shipper_Northwind__L2_Northwind_Shippers] (
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
/****** Object:  View [rv].[v_stage_S_H_Supplier_Northwind__L2_Northwind_Suppliers]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_S_H_Supplier_Northwind__L2_Northwind_Suppliers] (
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
/****** Object:  View [rv].[v_stage_S_H_Territory_Northwind__L2_Northwind_Territories]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_S_H_Territory_Northwind__L2_Northwind_Territories] (
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
/****** Object:  View [rv].[v_stage_H_Customer__L2_Northwind_CustomerCustomerDemo]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_H_Customer__L2_Northwind_CustomerCustomerDemo] (
	  HK_H_Customer
	, DV_Load_Datetime
	, DV_Record_Source
	, CustomerID
)
AS
SELECT DISTINCT
	  HK_H_Customer
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, CustomerID
FROM
	Staging.northwind.L2_Northwind_CustomerCustomerDemo AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Customer
		FROM
			Data_Vault.rv.H_Customer AS hub
		WHERE
			stage.HK_H_Customer = hub.HK_H_Customer
	);
GO
/****** Object:  View [rv].[v_stage_H_Customer__L2_Northwind_Customers]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_H_Customer__L2_Northwind_Customers] (
	  HK_H_Customer
	, DV_Load_Datetime
	, DV_Record_Source
	, CustomerID
)
AS
SELECT DISTINCT
	  HK_H_Customer
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, CustomerID
FROM
	Staging.northwind.L2_Northwind_Customers AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Customer
		FROM
			Data_Vault.rv.H_Customer AS hub
		WHERE
			stage.HK_H_Customer = hub.HK_H_Customer
	);
GO
/****** Object:  View [rv].[v_stage_H_Customer__L2_Northwind_Orders]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_H_Customer__L2_Northwind_Orders] (
	  HK_H_Customer
	, DV_Load_Datetime
	, DV_Record_Source
	, CustomerID
)
AS
SELECT DISTINCT
	  HK_H_Customer
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, CustomerID
FROM
	Staging.northwind.L2_Northwind_Orders AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Customer
		FROM
			Data_Vault.rv.H_Customer AS hub
		WHERE
			stage.HK_H_Customer = hub.HK_H_Customer
	);
GO
/****** Object:  View [rv].[v_stage_H_Customer_Type__L2_Northwind_CustomerCustomerDemo]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_H_Customer_Type__L2_Northwind_CustomerCustomerDemo] (
	  HK_H_Customer_Type
	, DV_Load_Datetime
	, DV_Record_Source
	, CustomerTypeID
)
AS
SELECT DISTINCT
	  HK_H_Customer_Type
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, CustomerTypeID
FROM
	Staging.northwind.L2_Northwind_CustomerCustomerDemo AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Customer_Type
		FROM
			Data_Vault.rv.H_Customer_Type AS hub
		WHERE
			stage.HK_H_Customer_Type = hub.HK_H_Customer_Type
	);
GO
/****** Object:  View [rv].[v_stage_H_Customer_Type__L2_Northwind_CustomerDemographics]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_H_Customer_Type__L2_Northwind_CustomerDemographics] (
	  HK_H_Customer_Type
	, DV_Load_Datetime
	, DV_Record_Source
	, CustomerTypeID
)
AS
SELECT DISTINCT
	  HK_H_Customer_Type
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, CustomerTypeID
FROM
	Staging.northwind.L2_Northwind_CustomerDemographics AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Customer_Type
		FROM
			Data_Vault.rv.H_Customer_Type AS hub
		WHERE
			stage.HK_H_Customer_Type= hub.HK_H_Customer_Type
	);
GO
/****** Object:  View [rv].[v_stage_H_Employee__L2_Northwind_Employees__EmployeeID]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_H_Employee__L2_Northwind_Employees__EmployeeID] (
	  HK_H_Employee
	, DV_Load_Datetime
	, DV_Record_Source
	, EmployeeID
)
AS
SELECT DISTINCT
	  HK_H_Employee
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, EmployeeID
FROM
	Staging.northwind.L2_Northwind_Employees AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Employee
		FROM
			Data_Vault.rv.H_Employee AS hub
		WHERE
			stage.HK_H_Employee = hub.HK_H_Employee
	);
GO
/****** Object:  View [rv].[v_stage_H_Employee__L2_Northwind_Employees__ReportsTo]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_H_Employee__L2_Northwind_Employees__ReportsTo] (
	  HK_H_Employee
	, DV_Load_Datetime
	, DV_Record_Source
	, EmployeeID
)
AS
SELECT DISTINCT
	  HK_H_Employee__Manager AS HK_H_Employee
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, ReportsTo AS EmployeeID
FROM
	Staging.northwind.L2_Northwind_Employees AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Employee
		FROM
			Data_Vault.rv.H_Employee AS hub
		WHERE
			stage.HK_H_Employee__Manager = hub.HK_H_Employee
	);
GO
/****** Object:  View [rv].[v_stage_H_Employee__L2_Northwind_EmployeeTerritories]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_H_Employee__L2_Northwind_EmployeeTerritories] (
	  HK_H_Employee
	, DV_Load_Datetime
	, DV_Record_Source
	, EmployeeID
)
AS
SELECT DISTINCT
	  HK_H_Employee
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, EmployeeID
FROM
	Staging.northwind.L2_Northwind_EmployeeTerritories AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Employee
		FROM
			Data_Vault.rv.H_Employee AS hub
		WHERE
			stage.HK_H_Employee = hub.HK_H_Employee
	);
GO
/****** Object:  View [rv].[v_stage_H_Employee__L2_Northwind_Orders]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_H_Employee__L2_Northwind_Orders] (
	  HK_H_Employee
	, DV_Load_Datetime
	, DV_Record_Source
	, EmployeeID
)
AS
SELECT DISTINCT
	  HK_H_Employee
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, EmployeeID
FROM
	Staging.northwind.L2_Northwind_Orders AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Employee
		FROM
			Data_Vault.rv.H_Employee AS hub
		WHERE
			stage.HK_H_Employee = hub.HK_H_Employee
	);
GO
/****** Object:  View [rv].[v_stage_H_Order__L2_Northwind_Order_Details]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_H_Order__L2_Northwind_Order_Details] (
	  HK_H_Order
	, DV_Load_Datetime
	, DV_Record_Source
	, OrderID
)
AS
SELECT DISTINCT
	  HK_H_Order
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, OrderID
FROM
	Staging.northwind.L2_Northwind_Order_Details AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Order
		FROM
			Data_Vault.rv.H_Order AS hub
		WHERE
			stage.HK_H_Order = hub.HK_H_Order
	);
GO
/****** Object:  View [rv].[v_stage_H_Order__L2_Northwind_Orders]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_H_Order__L2_Northwind_Orders] (
	  HK_H_Order
	, DV_Load_Datetime
	, DV_Record_Source
	, OrderID
)
AS
SELECT DISTINCT
	  HK_H_Order
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, OrderID
FROM
	Staging.northwind.L2_Northwind_Orders AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Order
		FROM
			Data_Vault.rv.H_Order AS hub
		WHERE
			stage.HK_H_Order = hub.HK_H_Order
	);
GO
/****** Object:  View [rv].[v_stage_H_Product__L2_Northwind_Order_Details]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_H_Product__L2_Northwind_Order_Details] (
	  HK_H_Product
	, DV_Load_Datetime
	, DV_Record_Source
	, ProductID
)
AS
SELECT DISTINCT
	  HK_H_Product
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, ProductID
FROM
	Staging.northwind.L2_Northwind_Order_Details AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Product
		FROM
			Data_Vault.rv.H_Product AS hub
		WHERE
			stage.HK_H_Product = hub.HK_H_Product
	);
GO
/****** Object:  View [rv].[v_stage_H_Product__L2_Northwind_Products]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_H_Product__L2_Northwind_Products] (
	  HK_H_Product
	, DV_Load_Datetime
	, DV_Record_Source
	, ProductID
)
AS
SELECT DISTINCT
	  HK_H_Product
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, ProductID
FROM
	Staging.northwind.L2_Northwind_Products AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Product
		FROM
			Data_Vault.rv.H_Product AS hub
		WHERE
			stage.HK_H_Product = hub.HK_H_Product
	);
GO
/****** Object:  View [rv].[v_stage_H_Product_Category__L2_Northwind_Categories]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_H_Product_Category__L2_Northwind_Categories] (
	  HK_H_Product_Category
	, DV_Load_Datetime
	, DV_Record_Source
	, CategoryID
)
AS
SELECT DISTINCT
	  HK_H_Product_Category
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, CategoryID
FROM
	Staging.northwind.L2_Northwind_Categories AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Product_Category
		FROM
			Data_Vault.rv.H_Product_Category AS hub
		WHERE
			stage.HK_H_Product_Category = hub.HK_H_Product_Category
	);
GO
/****** Object:  View [rv].[v_stage_H_Product_Category__L2_Northwind_Products]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_H_Product_Category__L2_Northwind_Products] (
	  HK_H_Product_Category
	, DV_Load_Datetime
	, DV_Record_Source
	, CategoryID
)
AS
SELECT DISTINCT
	  HK_H_Product_Category
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, CategoryID
FROM
	Staging.northwind.L2_Northwind_Products AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Product_Category
		FROM
			Data_Vault.rv.H_Product_Category AS hub
		WHERE
			stage.HK_H_Product_Category = hub.HK_H_Product_Category
	);
GO
/****** Object:  View [rv].[v_stage_H_Region__L2_Northwind_Region]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_H_Region__L2_Northwind_Region] (
	  HK_H_Region
	, DV_Load_Datetime
	, DV_Record_Source
	, RegionID
)
AS
SELECT DISTINCT
	  HK_H_Region
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, RegionID
FROM
	Staging.northwind.L2_Northwind_Region AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Region
		FROM
			Data_Vault.rv.H_Region AS hub
		WHERE
			stage.HK_H_Region = hub.HK_H_Region
	);
GO
/****** Object:  View [rv].[v_stage_H_Region__L2_Northwind_Territories]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_H_Region__L2_Northwind_Territories] (
	  HK_H_Region
	, DV_Load_Datetime
	, DV_Record_Source
	, RegionID
)
AS
SELECT DISTINCT
	  HK_H_Region
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, RegionID
FROM
	Staging.northwind.L2_Northwind_Territories AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Region
		FROM
			Data_Vault.rv.H_Region AS hub
		WHERE
			stage.HK_H_Region = hub.HK_H_Region
	);
GO
/****** Object:  View [rv].[v_stage_H_Shipper__L2_Northwind_Orders]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_H_Shipper__L2_Northwind_Orders] (
	  HK_H_Shipper
	, DV_Load_Datetime
	, DV_Record_Source
	, ShipperID
)
AS
SELECT DISTINCT
	  HK_H_Shipper
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, ShipVia AS ShipperID
FROM
	Staging.northwind.L2_Northwind_Orders AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Shipper
		FROM
			Data_Vault.rv.H_Shipper AS hub
		WHERE
			stage.HK_H_Shipper = hub.HK_H_Shipper
	);
GO
/****** Object:  View [rv].[v_stage_H_Shipper__L2_Northwind_Shippers]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_H_Shipper__L2_Northwind_Shippers] (
	  HK_H_Shipper
	, DV_Load_Datetime
	, DV_Record_Source
	, ShipperID
)
AS
SELECT DISTINCT
	  HK_H_Shipper
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, ShipperID
FROM
	Staging.northwind.L2_Northwind_Shippers AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Shipper
		FROM
			Data_Vault.rv.H_Shipper AS hub
		WHERE
			stage.HK_H_Shipper = hub.HK_H_Shipper
	);
GO
/****** Object:  View [rv].[v_stage_H_Supplier__L2_Northwind_Products]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_H_Supplier__L2_Northwind_Products] (
	  HK_H_Supplier
	, DV_Load_Datetime
	, DV_Record_Source
	, SupplierID
)
AS
SELECT DISTINCT
	  HK_H_Supplier
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, SupplierID
FROM
	Staging.northwind.L2_Northwind_Products AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Supplier
		FROM
			Data_Vault.rv.H_Supplier AS hub
		WHERE
			stage.HK_H_Supplier = hub.HK_H_Supplier
	);
GO
/****** Object:  View [rv].[v_stage_H_Supplier__L2_Northwind_Suppliers]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_H_Supplier__L2_Northwind_Suppliers] (
	  HK_H_Supplier
	, DV_Load_Datetime
	, DV_Record_Source
	, SupplierID
)
AS
SELECT DISTINCT
	  HK_H_Supplier
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, SupplierID
FROM
	Staging.northwind.L2_Northwind_Suppliers AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Supplier
		FROM
			Data_Vault.rv.H_Supplier AS hub
		WHERE
			stage.HK_H_Supplier = hub.HK_H_Supplier
	);
GO
/****** Object:  View [rv].[v_stage_H_Territory__L2_Northwind_EmployeeTerritories]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_H_Territory__L2_Northwind_EmployeeTerritories] (
	  HK_H_Territory
	, DV_Load_Datetime
	, DV_Record_Source
	, TerritoryID
)
AS
SELECT DISTINCT
	  HK_H_Territory
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, TerritoryID
FROM
	Staging.northwind.L2_Northwind_EmployeeTerritories AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Territory
		FROM
			Data_Vault.rv.H_Territory AS hub
		WHERE
			stage.HK_H_Territory = hub.HK_H_Territory
	);
GO
/****** Object:  View [rv].[v_stage_H_Territory__L2_Northwind_Territories]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_H_Territory__L2_Northwind_Territories] (
	  HK_H_Territory
	, DV_Load_Datetime
	, DV_Record_Source
	, TerritoryID
)
AS
SELECT DISTINCT
	  HK_H_Territory
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, DV_Record_Source
	, TerritoryID
FROM
	Staging.northwind.L2_Northwind_Territories AS stage
WHERE
	NOT EXISTS (
		SELECT
			hub.HK_H_Territory
		FROM
			Data_Vault.rv.H_Territory AS hub
		WHERE
			stage.HK_H_Territory = hub.HK_H_Territory
	);
GO
/****** Object:  Table [rv].[S_L_Order_Detail_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rv].[S_L_Order_Detail_Northwind](
	[HK_L_Order_Detail] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HD_S_L_Order_Detail_Northwind] [binary](32) NOT NULL,
	[UnitPrice] [money] NULL,
	[Quantity] [smallint] NULL,
	[Discount] [real] NULL,
 CONSTRAINT [PK_S_L_Order_Detail_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_L_Order_Detail] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [rv].[v_stage_S_L_Order_Detail_Northwind__L2_Northwind_Order_Details]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [rv].[v_stage_S_L_Order_Detail_Northwind__L2_Northwind_Order_Details] (
	  HK_L_Order_Detail
	, DV_Load_Datetime
	, DV_Record_Source
	, HD_S_L_Order_Detail_Northwind
	, UnitPrice
	, Quantity
	, Discount
)
AS
SELECT DISTINCT
	  stage.HK_L_Order_Detail
	, stage.DV_Load_Datetime
	, stage.DV_Record_Source
	, stage.HD_S_L_Order_Detail_Northwind
	, stage.UnitPrice
	, stage.Quantity
	, stage.Discount
FROM
	Staging.northwind.L2_Northwind_Order_Details AS stage
		LEFT OUTER JOIN Data_Vault.rv.S_L_Order_Detail_Northwind AS sat1
			ON stage.HK_L_Order_Detail = sat1.HK_L_Order_Detail
		   AND sat1.DV_Load_Datetime = (
					SELECT
						MAX(sat2.DV_Load_Datetime)
					FROM
						Data_Vault.rv.S_L_Order_Detail_Northwind AS sat2
					WHERE
						sat1.HK_L_Order_Detail = sat2.HK_L_Order_Detail
				)
WHERE
	sat1.HK_L_Order_Detail IS NULL
	OR (
		stage.HK_L_Order_Detail = sat1.HK_L_Order_Detail
		AND stage.HD_S_L_Order_Detail_Northwind <> sat1.HD_S_L_Order_Detail_Northwind
	);
GO
/****** Object:  View [bv].[v_history_S_L_Order_Detail_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_history_S_L_Order_Detail_Northwind] (
	  HK_L_Order_Detail
	, DV_Load_Datetime_Start
	, DV_Load_Datetime_End
	, DV_Record_Source
	, HD_S_L_Order_Detail_Northwind
	, UnitPrice
	, Quantity
	, Discount
)
AS
SELECT
	  HK_L_Order_Detail
	, DV_Load_Datetime AS DV_Load_Datetime_Start
	, LEAD(DATEADD(NS, -100, DV_Load_Datetime), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY HK_L_Order_Detail ORDER BY DV_Load_Datetime ASC) AS DV_Load_Datetime_End
	, DV_Record_Source
	, HD_S_L_Order_Detail_Northwind
	, UnitPrice
	, Quantity
	, Discount
FROM
	Data_Vault.rv.S_L_Order_Detail_Northwind;
GO
/****** Object:  StoredProcedure [bv].[usp_delete_S_HRT_H_Customer_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_delete_S_HRT_H_Customer_Northwind] 
AS
	BEGIN

		DELETE FROM
			Data_Vault.bv.S_HRT_H_Customer_Northwind
		WHERE
			S_HRT_H_Customer_Northwind.DV_Load_Datetime <> (
				select
					MAX(sat2.DV_Load_Datetime)
				FROM
					Data_Vault.bv.S_HRT_H_Customer_Northwind AS sat2
				WHERE
					S_HRT_H_Customer_Northwind.HK_H_Customer = sat2.HK_H_Customer
			)
			AND DATEDIFF(DAY, S_HRT_H_Customer_Northwind.DV_Load_Datetime, SYSUTCDATETIME() AT TIME ZONE 'UTC') > 7;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_delete_S_HRT_H_Customer_Type_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_delete_S_HRT_H_Customer_Type_Northwind]
AS
	BEGIN

		DELETE FROM
			Data_Vault.bv.S_HRT_H_Customer_Type_Northwind
		WHERE
			S_HRT_H_Customer_Type_Northwind.DV_Load_Datetime <> (
				select
					MAX(sat2.DV_Load_Datetime)
				FROM
					Data_Vault.bv.S_HRT_H_Customer_Type_Northwind AS sat2
				WHERE
					S_HRT_H_Customer_Type_Northwind.HK_H_Customer_Type = sat2.HK_H_Customer_Type
			)
			AND DATEDIFF(DAY, S_HRT_H_Customer_Type_Northwind.DV_Load_Datetime, SYSUTCDATETIME() AT TIME ZONE 'UTC') > 7;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_delete_S_HRT_H_Employee_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_delete_S_HRT_H_Employee_Northwind]
AS
	BEGIN

		DELETE FROM
			Data_Vault.bv.S_HRT_H_Employee_Northwind
		WHERE
			S_HRT_H_Employee_Northwind.DV_Load_Datetime <> (
				select
					MAX(sat2.DV_Load_Datetime)
				FROM
					Data_Vault.bv.S_HRT_H_Employee_Northwind AS sat2
				WHERE
					S_HRT_H_Employee_Northwind.HK_H_Employee = sat2.HK_H_Employee
			)
			AND DATEDIFF(DAY, S_HRT_H_Employee_Northwind.DV_Load_Datetime, SYSUTCDATETIME() AT TIME ZONE 'UTC') > 7;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_delete_S_HRT_H_Order_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_delete_S_HRT_H_Order_Northwind]
AS
	BEGIN

		DELETE FROM
			Data_Vault.bv.S_HRT_H_Order_Northwind
		WHERE
			S_HRT_H_Order_Northwind.DV_Load_Datetime <> (
				select
					MAX(sat2.DV_Load_Datetime)
				FROM
					Data_Vault.bv.S_HRT_H_Order_Northwind AS sat2
				WHERE
					S_HRT_H_Order_Northwind.HK_H_Order = sat2.HK_H_Order
			)
			AND DATEDIFF(DAY, S_HRT_H_Order_Northwind.DV_Load_Datetime, SYSUTCDATETIME() AT TIME ZONE 'UTC') > 7;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_delete_S_HRT_H_Product_Category_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_delete_S_HRT_H_Product_Category_Northwind]
AS
	BEGIN

		DELETE FROM
			Data_Vault.bv.S_HRT_H_Product_Category_Northwind
		WHERE
			S_HRT_H_Product_Category_Northwind.DV_Load_Datetime <> (
				select
					MAX(sat2.DV_Load_Datetime)
				FROM
					Data_Vault.bv.S_HRT_H_Product_Category_Northwind AS sat2
				WHERE
					S_HRT_H_Product_Category_Northwind.HK_H_Product_Category = sat2.HK_H_Product_Category
			)
			AND DATEDIFF(DAY, S_HRT_H_Product_Category_Northwind.DV_Load_Datetime, SYSUTCDATETIME() AT TIME ZONE 'UTC') > 7;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_delete_S_HRT_H_Product_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_delete_S_HRT_H_Product_Northwind]
AS
	BEGIN

		DELETE FROM
			Data_Vault.bv.S_HRT_H_Product_Northwind
		WHERE
			S_HRT_H_Product_Northwind.DV_Load_Datetime <> (
				select
					MAX(sat2.DV_Load_Datetime)
				FROM
					Data_Vault.bv.S_HRT_H_Product_Northwind AS sat2
				WHERE
					S_HRT_H_Product_Northwind.HK_H_Product = sat2.HK_H_Product
			)
			AND DATEDIFF(DAY, S_HRT_H_Product_Northwind.DV_Load_Datetime, SYSUTCDATETIME() AT TIME ZONE 'UTC') > 7;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_delete_S_HRT_H_Region_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_delete_S_HRT_H_Region_Northwind]
AS
	BEGIN

		DELETE FROM
			Data_Vault.bv.S_HRT_H_Region_Northwind
		WHERE
			S_HRT_H_Region_Northwind.DV_Load_Datetime <> (
				select
					MAX(sat2.DV_Load_Datetime)
				FROM
					Data_Vault.bv.S_HRT_H_Region_Northwind AS sat2
				WHERE
					S_HRT_H_Region_Northwind.HK_H_Region = sat2.HK_H_Region
			)
			AND DATEDIFF(DAY, S_HRT_H_Region_Northwind.DV_Load_Datetime, SYSUTCDATETIME() AT TIME ZONE 'UTC') > 7;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_delete_S_HRT_H_Shipper_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_delete_S_HRT_H_Shipper_Northwind]
AS
	BEGIN

		DELETE FROM
			Data_Vault.bv.S_HRT_H_Shipper_Northwind
		WHERE
			S_HRT_H_Shipper_Northwind.DV_Load_Datetime <> (
				select
					MAX(sat2.DV_Load_Datetime)
				FROM
					Data_Vault.bv.S_HRT_H_Shipper_Northwind AS sat2
				WHERE
					S_HRT_H_Shipper_Northwind.HK_H_Shipper = sat2.HK_H_Shipper
			)
			AND DATEDIFF(DAY, S_HRT_H_Shipper_Northwind.DV_Load_Datetime, SYSUTCDATETIME() AT TIME ZONE 'UTC') > 7;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_delete_S_HRT_H_Supplier_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_delete_S_HRT_H_Supplier_Northwind]
AS
	BEGIN

		DELETE FROM
			Data_Vault.bv.S_HRT_H_Supplier_Northwind
		WHERE
			S_HRT_H_Supplier_Northwind.DV_Load_Datetime <> (
				select
					MAX(sat2.DV_Load_Datetime)
				FROM
					Data_Vault.bv.S_HRT_H_Supplier_Northwind AS sat2
				WHERE
					S_HRT_H_Supplier_Northwind.HK_H_Supplier = sat2.HK_H_Supplier
			)
			AND DATEDIFF(DAY, S_HRT_H_Supplier_Northwind.DV_Load_Datetime, SYSUTCDATETIME() AT TIME ZONE 'UTC') > 7;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_delete_S_HRT_H_Territory_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_delete_S_HRT_H_Territory_Northwind]
AS
	BEGIN

		DELETE FROM
			Data_Vault.bv.S_HRT_H_Territory_Northwind
		WHERE
			S_HRT_H_Territory_Northwind.DV_Load_Datetime <> (
				select
					MAX(sat2.DV_Load_Datetime)
				FROM
					Data_Vault.bv.S_HRT_H_Territory_Northwind AS sat2
				WHERE
					S_HRT_H_Territory_Northwind.HK_H_Territory = sat2.HK_H_Territory
			)
			AND DATEDIFF(DAY, S_HRT_H_Territory_Northwind.DV_Load_Datetime, SYSUTCDATETIME() AT TIME ZONE 'UTC') > 7;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_delete_S_LRT_L_Customer_Type_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_delete_S_LRT_L_Customer_Type_Northwind]
AS
	BEGIN

		DELETE FROM
			Data_Vault.bv.S_LRT_L_Customer_Type_Northwind
		WHERE
			S_LRT_L_Customer_Type_Northwind.DV_Load_Datetime <> (
				select
					MAX(sat2.DV_Load_Datetime)
				FROM
					Data_Vault.bv.S_LRT_L_Customer_Type_Northwind AS sat2
				WHERE
					S_LRT_L_Customer_Type_Northwind.HK_L_Customer_Type = sat2.HK_L_Customer_Type
			)
			AND DATEDIFF(DAY, S_LRT_L_Customer_Type_Northwind.DV_Load_Datetime, SYSUTCDATETIME() AT TIME ZONE 'UTC') > 7
			;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_delete_S_LRT_L_Employee_Territory_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_delete_S_LRT_L_Employee_Territory_Northwind]
AS
	BEGIN

		DELETE FROM
			Data_Vault.bv.S_LRT_L_Employee_Territory_Northwind
		WHERE
			S_LRT_L_Employee_Territory_Northwind.DV_Load_Datetime <> (
				select
					MAX(sat2.DV_Load_Datetime)
				FROM
					Data_Vault.bv.S_LRT_L_Employee_Territory_Northwind AS sat2
				WHERE
					S_LRT_L_Employee_Territory_Northwind.HK_L_Employee_Territory = sat2.HK_L_Employee_Territory
			)
			AND DATEDIFF(DAY, S_LRT_L_Employee_Territory_Northwind.DV_Load_Datetime, SYSUTCDATETIME() AT TIME ZONE 'UTC') > 7;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_delete_S_LRT_L_Order_Detail_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_delete_S_LRT_L_Order_Detail_Northwind]
AS
	BEGIN

		DELETE FROM
			Data_Vault.bv.S_LRT_L_Order_Detail_Northwind
		WHERE
			S_LRT_L_Order_Detail_Northwind.DV_Load_Datetime <> (
				select
					MAX(sat2.DV_Load_Datetime)
				FROM
					Data_Vault.bv.S_LRT_L_Order_Detail_Northwind AS sat2
				WHERE
					S_LRT_L_Order_Detail_Northwind.HK_L_Order_Detail = sat2.HK_L_Order_Detail
			)
			AND DATEDIFF(DAY, S_LRT_L_Order_Detail_Northwind.DV_Load_Datetime, SYSUTCDATETIME() AT TIME ZONE 'UTC') > 7;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_S_HDT_H_Customer_Northwind__S_HRT_H_Customer_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_S_HDT_H_Customer_Northwind__S_HRT_H_Customer_Northwind]
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_HDT_H_Customer_Northwind (
			  HK_H_Customer
			, DV_Load_Datetime
			, DV_Record_Source
			, Is_Deleted_Flag
			, Deleted_Datetime
		)
		SELECT
			  HK_H_Customer
			, DV_Load_Datetime
			, DV_Record_Source
			, Is_Deleted_Flag
			, Deleted_Datetime
		FROM
			Data_Vault.bv.v_stage_S_HDT_H_Customer_Northwind__S_HRT_H_Customer_Northwind;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_S_HDT_H_Customer_Type_Northwind__S_HRT_H_Customer_Type_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_S_HDT_H_Customer_Type_Northwind__S_HRT_H_Customer_Type_Northwind]
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_HDT_H_Customer_Type_Northwind (
			  [HK_H_Customer_Type]
			, [DV_Load_Datetime]
			, [DV_Record_Source]
			, [Is_Deleted_Flag]
			, [Deleted_Datetime]
		)
		SELECT
			  [HK_H_Customer_Type]
			, [DV_Load_Datetime]
			, [DV_Record_Source]
			, [Is_Deleted_Flag]
			, [Deleted_Datetime]
		FROM
			Data_Vault.bv.v_stage_S_HDT_H_Customer_Type_Northwind__S_HRT_H_Customer_Type_Northwind;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_S_HDT_H_Employee_Northwind__S_HRT_H_Employee_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_S_HDT_H_Employee_Northwind__S_HRT_H_Employee_Northwind]
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_HDT_H_Employee_Northwind (
			  [HK_H_Employee]
			, [DV_Load_Datetime]
			, [DV_Record_Source]
			, [Is_Deleted_Flag]
			, [Deleted_Datetime]
		)
		SELECT
			  [HK_H_Employee]
			, [DV_Load_Datetime]
			, [DV_Record_Source]
			, [Is_Deleted_Flag]
			, [Deleted_Datetime]
		FROM
			Data_Vault.bv.v_stage_S_HDT_H_Employee_Northwind__S_HRT_H_Employee_Northwind;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_S_HDT_H_Order_Northwind__S_HRT_H_Order_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_S_HDT_H_Order_Northwind__S_HRT_H_Order_Northwind]
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_HDT_H_Order_Northwind (
			  [HK_H_Order]
			, [DV_Load_Datetime]
			, [DV_Record_Source]
			, [Is_Deleted_Flag]
			, [Deleted_Datetime]
		)
		SELECT
			  [HK_H_Order]
			, [DV_Load_Datetime]
			, [DV_Record_Source]
			, [Is_Deleted_Flag]
			, [Deleted_Datetime]
		FROM
			Data_Vault.bv.v_stage_S_HDT_H_Order_Northwind__S_HRT_H_Order_Northwind;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_S_HDT_H_Product_Category_Northwind__S_HRT_H_Product_Category_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_S_HDT_H_Product_Category_Northwind__S_HRT_H_Product_Category_Northwind]
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_HDT_H_Product_Category_Northwind (
			  [HK_H_Product_Category]
			, [DV_Load_Datetime]
			, [DV_Record_Source]
			, [Is_Deleted_Flag]
			, [Deleted_Datetime]
		)
		SELECT
			  [HK_H_Product_Category]
			, [DV_Load_Datetime]
			, [DV_Record_Source]
			, [Is_Deleted_Flag]
			, [Deleted_Datetime]			  
		FROM
			Data_Vault.bv.v_stage_S_HDT_H_Product_Category_Northwind__S_HRT_H_Product_Category_Northwind;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_S_HDT_H_Product_Northwind__S_HRT_H_Product_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_S_HDT_H_Product_Northwind__S_HRT_H_Product_Northwind]
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_HDT_H_Product_Northwind (
			  [HK_H_Product]
			, [DV_Load_Datetime]
			, [DV_Record_Source]
			, [Is_Deleted_Flag]
			, [Deleted_Datetime]
		)
		SELECT
			  [HK_H_Product]
			, [DV_Load_Datetime]
			, [DV_Record_Source]
			, [Is_Deleted_Flag]
			, [Deleted_Datetime]			  
		FROM
			Data_Vault.bv.v_stage_S_HDT_H_Product_Northwind__S_HRT_H_Product_Northwind;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_S_HDT_H_Region_Northwind__S_HRT_H_Region_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_S_HDT_H_Region_Northwind__S_HRT_H_Region_Northwind]
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_HDT_H_Region_Northwind (
			  [HK_H_Region]
			, [DV_Load_Datetime]
			, [DV_Record_Source]
			, [Is_Deleted_Flag]
			, [Deleted_Datetime]  
		)
		SELECT
			  [HK_H_Region]
			, [DV_Load_Datetime]
			, [DV_Record_Source]
			, [Is_Deleted_Flag]
			, [Deleted_Datetime]			  
		FROM
			Data_Vault.bv.v_stage_S_HDT_H_Region_Northwind__S_HRT_H_Region_Northwind;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_S_HDT_H_Shipper_Northwind__S_HRT_H_Shipper_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_S_HDT_H_Shipper_Northwind__S_HRT_H_Shipper_Northwind]
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_HDT_H_Shipper_Northwind (
			  [HK_H_Shipper]
			, [DV_Load_Datetime]
			, [DV_Record_Source]
			, [Is_Deleted_Flag]
			, [Deleted_Datetime]
		)
		SELECT
			  [HK_H_Shipper]
			, [DV_Load_Datetime]
			, [DV_Record_Source]
			, [Is_Deleted_Flag]
			, [Deleted_Datetime]			  
		FROM
			Data_Vault.bv.v_stage_S_HDT_H_Shipper_Northwind__S_HRT_H_Shipper_Northwind;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_S_HDT_H_Supplier_Northwind__S_HRT_H_Supplier_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_S_HDT_H_Supplier_Northwind__S_HRT_H_Supplier_Northwind]
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_HDT_H_Supplier_Northwind (
			  [HK_H_Supplier]
			, [DV_Load_Datetime]
			, [DV_Record_Source]
			, [Is_Deleted_Flag]
			, [Deleted_Datetime]
		)
		SELECT
			  [HK_H_Supplier]
			, [DV_Load_Datetime]
			, [DV_Record_Source]
			, [Is_Deleted_Flag]
			, [Deleted_Datetime]			  
		FROM
			Data_Vault.bv.v_stage_S_HDT_H_Supplier_Northwind__S_HRT_H_Supplier_Northwind;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_S_HDT_H_Territory_Northwind__S_HRT_H_Territory_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_S_HDT_H_Territory_Northwind__S_HRT_H_Territory_Northwind]
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_HDT_H_Territory_Northwind (
			  [HK_H_Territory]
			, [DV_Load_Datetime]
			, [DV_Record_Source]
			, [Is_Deleted_Flag]
			, [Deleted_Datetime]  
		)
		SELECT
			  [HK_H_Territory]
			, [DV_Load_Datetime]
			, [DV_Record_Source]
			, [Is_Deleted_Flag]
			, [Deleted_Datetime] 			  
		FROM
			Data_Vault.bv.v_stage_S_HDT_H_Territory_Northwind__S_HRT_H_Territory_Northwind;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_S_HRT_H_Customer_Northwind__L2_Northwind_Customers]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_S_HRT_H_Customer_Northwind__L2_Northwind_Customers] 
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_HRT_H_Customer_Northwind (
			  HK_H_Customer
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		)
		SELECT
			  HK_H_Customer
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		FROM
			Data_Vault.bv.v_stage_S_HRT_H_Customer_Northwind__L2_Northwind_Customers;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_S_HRT_H_Customer_Type_Northwind__L2_Northwind_CustomerDemographics]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_S_HRT_H_Customer_Type_Northwind__L2_Northwind_CustomerDemographics] 
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_HRT_H_Customer_Type_Northwind (
			  HK_H_Customer_Type
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		)
		SELECT
			  HK_H_Customer_Type
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		FROM
			Data_Vault.bv.v_stage_S_HRT_H_Customer_Type_Northwind__L2_Northwind_CustomerDemographics;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_S_HRT_H_Employee_Northwind__L2_Northwind_Employees]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_S_HRT_H_Employee_Northwind__L2_Northwind_Employees] 
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_HRT_H_Employee_Northwind (
			  HK_H_Employee
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		)
		SELECT
			  HK_H_Employee
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		FROM
			Data_Vault.bv.v_stage_S_HRT_H_Employee_Northwind__L2_Northwind_Employees;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_S_HRT_H_Order_Northwind__L2_Northwind_Orders]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_S_HRT_H_Order_Northwind__L2_Northwind_Orders] 
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_HRT_H_Order_Northwind (
			  HK_H_Order
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		)
		SELECT
			  HK_H_Order
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		FROM
			Data_Vault.bv.v_stage_S_HRT_H_Order_Northwind__L2_Northwind_Orders;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_S_HRT_H_Product_Category_Northwind__L2_Northwind_Categories]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_S_HRT_H_Product_Category_Northwind__L2_Northwind_Categories] 
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_HRT_H_Product_Category_Northwind (
			  HK_H_Product_Category
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		)
		SELECT
			  HK_H_Product_Category
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		FROM
			Data_Vault.bv.v_stage_S_HRT_H_Product_Category_Northwind__L2_Northwind_Categories;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_S_HRT_H_Product_Northwind__L2_Northwind_Products]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_S_HRT_H_Product_Northwind__L2_Northwind_Products] 
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_HRT_H_Product_Northwind (
			  HK_H_Product
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		)
		SELECT
			  HK_H_Product
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		FROM
			Data_Vault.bv.v_stage_S_HRT_H_Product_Northwind__L2_Northwind_Products;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_S_HRT_H_Region_Northwind__L2_Northwind_Region]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_S_HRT_H_Region_Northwind__L2_Northwind_Region] 
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_HRT_H_Region_Northwind (
			  HK_H_Region
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		)
		SELECT
			  HK_H_Region
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		FROM
			Data_Vault.bv.v_stage_S_HRT_H_Region_Northwind__L2_Northwind_Region;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_S_HRT_H_Shipper_Northwind__L2_Northwind_Shippers]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_S_HRT_H_Shipper_Northwind__L2_Northwind_Shippers] 
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_HRT_H_Shipper_Northwind (
			  HK_H_Shipper
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		)
		SELECT
			  HK_H_Shipper
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		FROM
			Data_Vault.bv.v_stage_S_HRT_H_Shipper_Northwind__L2_Northwind_Shippers;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_S_HRT_H_Supplier_Northwind__L2_Northwind_Suppliers]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_S_HRT_H_Supplier_Northwind__L2_Northwind_Suppliers] 
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_HRT_H_Supplier_Northwind (
			  HK_H_Supplier
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		)
		SELECT
			  HK_H_Supplier
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		FROM
			Data_Vault.bv.v_stage_S_HRT_H_Supplier_Northwind__L2_Northwind_Suppliers;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_S_HRT_H_Territory_Northwind__L2_Northwind_Territories]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_S_HRT_H_Territory_Northwind__L2_Northwind_Territories] 
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_HRT_H_Territory_Northwind (
			  HK_H_Territory
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		)
		SELECT
			  HK_H_Territory
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		FROM
			Data_Vault.bv.v_stage_S_HRT_H_Territory_Northwind__L2_Northwind_Territories;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_S_LDT_L_Customer_Type_Northwind__S_LRT_L_Customer_Type_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_S_LDT_L_Customer_Type_Northwind__S_LRT_L_Customer_Type_Northwind]
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_LDT_L_Customer_Type_Northwind (
			  HK_L_Customer_Type
			, DV_Load_Datetime
			, DV_Record_Source
			, Is_Deleted_Flag
			, Deleted_Datetime
		)
		SELECT
			  HK_L_Customer_Type
			, DV_Load_Datetime
			, DV_Record_Source
			, Is_Deleted_Flag
			, Deleted_Datetime			 
		FROM
			Data_Vault.bv.v_stage_S_LDT_L_Customer_Type_Northwind__S_LRT_L_Customer_Type_Northwind;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_S_LDT_L_Employee_Territory_Northwind__S_LRT_L_Employee_Territory_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_S_LDT_L_Employee_Territory_Northwind__S_LRT_L_Employee_Territory_Northwind]
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_LDT_L_Employee_Territory_Northwind (
			  HK_L_Employee_Territory
			, DV_Load_Datetime
			, DV_Record_Source
			, Is_Deleted_Flag
			, Deleted_Datetime
		)
		SELECT
			  HK_L_Employee_Territory
			, DV_Load_Datetime
			, DV_Record_Source
			, Is_Deleted_Flag
			, Deleted_Datetime
		FROM
			Data_Vault.bv.v_stage_S_LDT_L_Employee_Territory_Northwind__S_LRT_L_Employee_Territory_Northwind;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_S_LDT_L_Order_Detail_Northwind__S_LRT_L_Order_Detail_Northwind]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_S_LDT_L_Order_Detail_Northwind__S_LRT_L_Order_Detail_Northwind]
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_LDT_L_Order_Detail_Northwind (
			  HK_L_Order_Detail
			, DV_Load_Datetime
			, DV_Record_Source
			, Is_Deleted_Flag
			, Deleted_Datetime
		)
		SELECT
			  HK_L_Order_Detail
			, DV_Load_Datetime
			, DV_Record_Source
			, Is_Deleted_Flag
			, Deleted_Datetime
		FROM
			Data_Vault.bv.v_stage_S_LDT_L_Order_Detail_Northwind__S_LRT_L_Order_Detail_Northwind;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_S_LE_L_Employee_Reporting_Line_Northwind__L2_Northwind_Employees]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_S_LE_L_Employee_Reporting_Line_Northwind__L2_Northwind_Employees]
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_LE_L_Employee_Reporting_Line_Northwind (  
			  HK_L_Employee_Reporting_Line
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Employee__Direct_Report__DK
			, Start_Datetime
			, HK_L_Employee_Reporting_Line__Previous
			, DV_Load_Datetime__Previous
		)
		SELECT
			  HK_L_Employee_Reporting_Line
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Employee__Direct_Report__DK
			, Start_Datetime
			, HK_L_Employee_Reporting_Line__Previous
			, DV_Load_Datetime__Previous
		FROM
			Data_Vault.bv.v_stage_S_LE_L_Employee_Reporting_Line_Northwind__L2_Northwind_Employees;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_S_LE_L_Order_Header_Northwind__L2_Northwind_Orders]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_S_LE_L_Order_Header_Northwind__L2_Northwind_Orders]
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_LE_L_Order_Header_Northwind (  
			  HK_L_Order_Header
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Order__DK
			, Start_Datetime
			, HK_L_Order_Header__Previous
			, DV_Load_Datetime__Previous
		)
		SELECT
			  HK_L_Order_Header
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Order__DK
			, Start_Datetime
			, HK_L_Order_Header__Previous
			, DV_Load_Datetime__Previous
		FROM
			Data_Vault.bv.v_stage_S_LE_L_Order_Header_Northwind__L2_Northwind_Orders;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_S_LE_L_Product_Category_Northwind__L2_Northwind_Products]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_S_LE_L_Product_Category_Northwind__L2_Northwind_Products]
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_LE_L_Product_Category_Northwind (  
			  HK_L_Product_Category
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Product__DK
			, Start_Datetime
			, HK_L_Product_Category__Previous
			, DV_Load_Datetime__Previous
		)
		SELECT
			  HK_L_Product_Category
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Product__DK
			, Start_Datetime
			, HK_L_Product_Category__Previous
			, DV_Load_Datetime__Previous
		FROM
			Data_Vault.bv.v_stage_S_LE_L_Product_Category_Northwind__L2_Northwind_Products;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_S_LE_L_Product_Supplier_Northwind__L2_Northwind_Products]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_S_LE_L_Product_Supplier_Northwind__L2_Northwind_Products]
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_LE_L_Product_Supplier_Northwind (  
			  HK_L_Product_Supplier
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Product__DK
			, Start_Datetime
			, HK_L_Product_Supplier__Previous
			, DV_Load_Datetime__Previous
		)
		SELECT
			  HK_L_Product_Supplier
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Product__DK
			, Start_Datetime
			, HK_L_Product_Supplier__Previous
			, DV_Load_Datetime__Previous
		FROM
			Data_Vault.bv.v_stage_S_LE_L_Product_Supplier_Northwind__L2_Northwind_Products;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_S_LE_L_Territory_Region_Northwind__L2_Northwind_Territories]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_S_LE_L_Territory_Region_Northwind__L2_Northwind_Territories]
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_LE_L_Territory_Region_Northwind (  
			  HK_L_Territory_Region
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Territory__DK
			, Start_Datetime
			, HK_L_Territory_Region__Previous
			, DV_Load_Datetime__Previous
		)
		SELECT
			  HK_L_Territory_Region
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Territory__DK
			, Start_Datetime
			, HK_L_Territory_Region__Previous
			, DV_Load_Datetime__Previous
		FROM
			Data_Vault.bv.v_stage_S_LE_L_Territory_Region_Northwind__L2_Northwind_Territories;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_S_LRT_L_Customer_Type_Northwind__L2_Northwind_CustomerCustomerDemo]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_S_LRT_L_Customer_Type_Northwind__L2_Northwind_CustomerCustomerDemo]
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_LRT_L_Customer_Type_Northwind (
			  HK_L_Customer_Type
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		)
		SELECT
			  HK_L_Customer_Type
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		FROM
			Data_Vault.bv.v_stage_S_LRT_L_Customer_Type_Northwind__L2_Northwind_CustomerCustomerDemo;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_S_LRT_L_Employee_Territory_Northwind__L2_Northwind_EmployeeTerritories]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_S_LRT_L_Employee_Territory_Northwind__L2_Northwind_EmployeeTerritories]
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_LRT_L_Employee_Territory_Northwind (
			  HK_L_Employee_Territory
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		)
		SELECT
			  HK_L_Employee_Territory
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		FROM
			Data_Vault.bv.v_stage_S_LRT_L_Employee_Territory_Northwind__L2_Northwind_EmployeeTerritories;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_S_LRT_L_Order_Detail_Northwind__L2_Northwind_Order_Details]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_S_LRT_L_Order_Detail_Northwind__L2_Northwind_Order_Details]
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_LRT_L_Order_Detail_Northwind (
			  HK_L_Order_Detail
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		)
		SELECT
			  HK_L_Order_Detail
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		FROM
			Data_Vault.bv.v_stage_S_LRT_L_Order_Detail_Northwind__L2_Northwind_Order_Details;

	END
GO
/****** Object:  StoredProcedure [rv].[usp_insert_H_Customer__L2_Northwind_CustomerCustomerDemo]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_H_Customer__L2_Northwind_CustomerCustomerDemo]
AS
	BEGIN

		INSERT INTO rv.H_Customer (
			  HK_H_Customer
			, DV_Load_Datetime
			, DV_Record_Source
			, CustomerID
		)
		SELECT
			  HK_H_Customer
			, DV_Load_Datetime
			, DV_Record_Source
			, CustomerID
		FROM
			rv.v_stage_H_Customer__L2_Northwind_CustomerCustomerDemo;

	END
GO
/****** Object:  StoredProcedure [rv].[usp_insert_H_Customer__L2_Northwind_Customers]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_H_Customer__L2_Northwind_Customers]
AS
	BEGIN

		INSERT INTO rv.H_Customer (
			  HK_H_Customer
			, DV_Load_Datetime
			, DV_Record_Source
			, CustomerID
		)
		SELECT
			  HK_H_Customer
			, DV_Load_Datetime
			, DV_Record_Source
			, CustomerID
		FROM
			rv.v_stage_H_Customer__L2_Northwind_Customers;

	END
GO
/****** Object:  StoredProcedure [rv].[usp_insert_H_Customer__L2_Northwind_Orders]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_H_Customer__L2_Northwind_Orders]
AS
	BEGIN

		INSERT INTO rv.H_Customer (
			  HK_H_Customer
			, DV_Load_Datetime
			, DV_Record_Source
			, CustomerID
		)
		SELECT
			  HK_H_Customer
			, DV_Load_Datetime
			, DV_Record_Source
			, CustomerID
		FROM
			rv.v_stage_H_Customer__L2_Northwind_Orders;

	END
GO
/****** Object:  StoredProcedure [rv].[usp_insert_H_Customer_Type__L2_Northwind_CustomerCustomerDemo]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_H_Customer_Type__L2_Northwind_CustomerCustomerDemo]
AS
	BEGIN

		INSERT INTO rv.H_Customer_Type (
			  HK_H_Customer_Type
			, DV_Load_Datetime
			, DV_Record_Source
			, CustomerTypeID
		)
		SELECT
			  HK_H_Customer_Type
			, DV_Load_Datetime
			, DV_Record_Source
			, CustomerTypeID
		FROM
			rv.v_stage_H_Customer_Type__L2_Northwind_CustomerCustomerDemo;

	END
GO
/****** Object:  StoredProcedure [rv].[usp_insert_H_Customer_Type__L2_Northwind_CustomerDemographics]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_H_Customer_Type__L2_Northwind_CustomerDemographics]
AS
	BEGIN

		INSERT INTO rv.H_Customer_Type (
			  HK_H_Customer_Type
			, DV_Load_Datetime
			, DV_Record_Source
			, CustomerTypeID
		)
		SELECT
			  HK_H_Customer_Type
			, DV_Load_Datetime
			, DV_Record_Source
			, CustomerTypeID
		FROM
			rv.v_stage_H_Customer_Type__L2_Northwind_CustomerDemographics;

	END
GO
/****** Object:  StoredProcedure [rv].[usp_insert_H_Employee__L2_Northwind_Employees__EmployeeID]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_H_Employee__L2_Northwind_Employees__EmployeeID]
AS
	BEGIN

		INSERT INTO rv.H_Employee (
			  HK_H_Employee
			, DV_Load_Datetime
			, DV_Record_Source
			, EmployeeID
		)
		SELECT
			  HK_H_Employee
			, DV_Load_Datetime
			, DV_Record_Source
			, EmployeeID
		FROM
			rv.v_stage_H_Employee__L2_Northwind_Employees__EmployeeID;

	END
GO
/****** Object:  StoredProcedure [rv].[usp_insert_H_Employee__L2_Northwind_Employees__ReportsTo]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_H_Employee__L2_Northwind_Employees__ReportsTo]
AS
	BEGIN

		INSERT INTO rv.H_Employee (
			  HK_H_Employee
			, DV_Load_Datetime
			, DV_Record_Source
			, EmployeeID
		)
		SELECT
			  HK_H_Employee
			, DV_Load_Datetime
			, DV_Record_Source
			, EmployeeID
		FROM
			rv.v_stage_H_Employee__L2_Northwind_Employees__ReportsTo;

	END
GO
/****** Object:  StoredProcedure [rv].[usp_insert_H_Employee__L2_Northwind_EmployeeTerritories]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_H_Employee__L2_Northwind_EmployeeTerritories]
AS
	BEGIN

		INSERT INTO rv.H_Employee (
			  HK_H_Employee
			, DV_Load_Datetime
			, DV_Record_Source
			, EmployeeID
		)
		SELECT
			  HK_H_Employee
			, DV_Load_Datetime
			, DV_Record_Source
			, EmployeeID
		FROM
			rv.v_stage_H_Employee__L2_Northwind_EmployeeTerritories;

	END
GO
/****** Object:  StoredProcedure [rv].[usp_insert_H_Employee__L2_Northwind_Orders]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_H_Employee__L2_Northwind_Orders]
AS
	BEGIN

		INSERT INTO rv.H_Employee (
			  HK_H_Employee
			, DV_Load_Datetime
			, DV_Record_Source
			, EmployeeID
		)
		SELECT
			  HK_H_Employee
			, DV_Load_Datetime
			, DV_Record_Source
			, EmployeeID
		FROM
			rv.v_stage_H_Employee__L2_Northwind_Orders;

	END
GO
/****** Object:  StoredProcedure [rv].[usp_insert_H_Order__L2_Northwind_Order_Details]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_H_Order__L2_Northwind_Order_Details]
AS
	BEGIN

		INSERT INTO rv.H_Order (
			  HK_H_Order
			, DV_Load_Datetime
			, DV_Record_Source
			, OrderID
		)
		SELECT
			  HK_H_Order
			, DV_Load_Datetime
			, DV_Record_Source
			, OrderID
		FROM
			rv.v_stage_H_Order__L2_Northwind_Order_Details;

	END
GO
/****** Object:  StoredProcedure [rv].[usp_insert_H_Order__L2_Northwind_Orders]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_H_Order__L2_Northwind_Orders]
AS
	BEGIN

		INSERT INTO rv.H_Order (
			  HK_H_Order
			, DV_Load_Datetime
			, DV_Record_Source
			, OrderID
		)
		SELECT
			  HK_H_Order
			, DV_Load_Datetime
			, DV_Record_Source
			, OrderID
		FROM
			rv.v_stage_H_Order__L2_Northwind_Orders;

	END
GO
/****** Object:  StoredProcedure [rv].[usp_insert_H_Product__L2_Northwind_Order_Details]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_H_Product__L2_Northwind_Order_Details]
AS
	BEGIN

		INSERT INTO rv.H_Product (
			  HK_H_Product
			, DV_Load_Datetime
			, DV_Record_Source
			, ProductID
		)
		SELECT
			  HK_H_Product
			, DV_Load_Datetime
			, DV_Record_Source
			, ProductID
		FROM
			rv.v_stage_H_Product__L2_Northwind_Order_Details;

	END
GO
/****** Object:  StoredProcedure [rv].[usp_insert_H_Product__L2_Northwind_Products]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_H_Product__L2_Northwind_Products]
AS
	BEGIN

		INSERT INTO rv.H_Product (
			  HK_H_Product
			, DV_Load_Datetime
			, DV_Record_Source
			, ProductID
		)
		SELECT
			  HK_H_Product
			, DV_Load_Datetime
			, DV_Record_Source
			, ProductID
		FROM
			rv.v_stage_H_Product__L2_Northwind_Products;

	END
GO
/****** Object:  StoredProcedure [rv].[usp_insert_H_Product_Category__L2_Northwind_Categories]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_H_Product_Category__L2_Northwind_Categories]
AS
	BEGIN

		INSERT INTO rv.H_Product_Category (
			  HK_H_Product_Category
			, DV_Load_Datetime
			, DV_Record_Source
			, CategoryID
		)
		SELECT
			  HK_H_Product_Category
			, DV_Load_Datetime
			, DV_Record_Source
			, CategoryID
		FROM
			rv.v_stage_H_Product_Category__L2_Northwind_Categories;

	END
GO
/****** Object:  StoredProcedure [rv].[usp_insert_H_Product_Category__L2_Northwind_Products]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_H_Product_Category__L2_Northwind_Products]
AS
	BEGIN

		INSERT INTO rv.H_Product_Category (
			  HK_H_Product_Category
			, DV_Load_Datetime
			, DV_Record_Source
			, CategoryID
		)
		SELECT
			  HK_H_Product_Category
			, DV_Load_Datetime
			, DV_Record_Source
			, CategoryID
		FROM
			rv.v_stage_H_Product_Category__L2_Northwind_Products;

	END
GO
/****** Object:  StoredProcedure [rv].[usp_insert_H_Region__L2_Northwind_Region]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_H_Region__L2_Northwind_Region]
AS
	BEGIN

		INSERT INTO rv.H_Region (
			  HK_H_Region
			, DV_Load_Datetime
			, DV_Record_Source
			, RegionID
		)
		SELECT
			  HK_H_Region
			, DV_Load_Datetime
			, DV_Record_Source
			, RegionID
		FROM
			rv.v_stage_H_Region__L2_Northwind_Region;

	END
GO
/****** Object:  StoredProcedure [rv].[usp_insert_H_Region__L2_Northwind_Territories]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_H_Region__L2_Northwind_Territories]
AS
	BEGIN

		INSERT INTO rv.H_Region (
			  HK_H_Region
			, DV_Load_Datetime
			, DV_Record_Source
			, RegionID
		)
		SELECT
			  HK_H_Region
			, DV_Load_Datetime
			, DV_Record_Source
			, RegionID
		FROM
			rv.v_stage_H_Region__L2_Northwind_Territories;

	END
GO
/****** Object:  StoredProcedure [rv].[usp_insert_H_Shipper__L2_Northwind_Orders]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_H_Shipper__L2_Northwind_Orders]
AS
	BEGIN

		INSERT INTO rv.H_Shipper (
			  HK_H_Shipper
			, DV_Load_Datetime
			, DV_Record_Source
			, ShipperID
		)
		SELECT
			  HK_H_Shipper
			, DV_Load_Datetime
			, DV_Record_Source
			, ShipperID
		FROM
			rv.v_stage_H_Shipper__L2_Northwind_Orders;

	END
GO
/****** Object:  StoredProcedure [rv].[usp_insert_H_Shipper__L2_Northwind_Shippers]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_H_Shipper__L2_Northwind_Shippers]
AS
	BEGIN

		INSERT INTO rv.H_Shipper (
			  HK_H_Shipper
			, DV_Load_Datetime
			, DV_Record_Source
			, ShipperID
		)
		SELECT
			  HK_H_Shipper
			, DV_Load_Datetime
			, DV_Record_Source
			, ShipperID
		FROM
			rv.v_stage_H_Shipper__L2_Northwind_Shippers;

	END
GO
/****** Object:  StoredProcedure [rv].[usp_insert_H_Supplier__L2_Northwind_Products]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_H_Supplier__L2_Northwind_Products]
AS
	BEGIN

		INSERT INTO rv.H_Supplier (
			  HK_H_Supplier
			, DV_Load_Datetime
			, DV_Record_Source
			, SupplierID
		)
		SELECT
			  HK_H_Supplier
			, DV_Load_Datetime
			, DV_Record_Source
			, SupplierID
		FROM
			rv.v_stage_H_Supplier__L2_Northwind_Products;

	END
GO
/****** Object:  StoredProcedure [rv].[usp_insert_H_Supplier__L2_Northwind_Suppliers]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_H_Supplier__L2_Northwind_Suppliers]
AS
	BEGIN

		INSERT INTO rv.H_Supplier (
			  HK_H_Supplier
			, DV_Load_Datetime
			, DV_Record_Source
			, SupplierID
		)
		SELECT
			  HK_H_Supplier
			, DV_Load_Datetime
			, DV_Record_Source
			, SupplierID
		FROM
			rv.v_stage_H_Supplier__L2_Northwind_Suppliers;

	END
GO
/****** Object:  StoredProcedure [rv].[usp_insert_H_Territory__L2_Northwind_EmployeeTerritories]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_H_Territory__L2_Northwind_EmployeeTerritories]
AS
	BEGIN

		INSERT INTO rv.H_Territory (
			  HK_H_Territory
			, DV_Load_Datetime
			, DV_Record_Source
			, TerritoryID
		)
		SELECT
			  HK_H_Territory
			, DV_Load_Datetime
			, DV_Record_Source
			, TerritoryID
		FROM
			rv.v_stage_H_Territory__L2_Northwind_EmployeeTerritories;

	END
GO
/****** Object:  StoredProcedure [rv].[usp_insert_H_Territory__L2_Northwind_Territories]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_H_Territory__L2_Northwind_Territories]
AS
	BEGIN

		INSERT INTO rv.H_Territory (
			  HK_H_Territory
			, DV_Load_Datetime
			, DV_Record_Source
			, TerritoryID
		)
		SELECT
			  HK_H_Territory
			, DV_Load_Datetime
			, DV_Record_Source
			, TerritoryID
		FROM
			rv.v_stage_H_Territory__L2_Northwind_Territories;

	END
GO
/****** Object:  StoredProcedure [rv].[usp_insert_L_Customer_Type__L2_Northwind_CustomerCustomerDemo]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_L_Customer_Type__L2_Northwind_CustomerCustomerDemo] 
AS
	BEGIN

		INSERT INTO rv.L_Customer_Type (
			  HK_L_Customer_Type
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Customer
			, HK_H_Customer_Type
		)
		SELECT
			  HK_L_Customer_Type
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Customer
			, HK_H_Customer_Type
		FROM
			rv.v_stage_L_Customer_Type__L2_Northwind_CustomerCustomerDemo;

	END
GO
/****** Object:  StoredProcedure [rv].[usp_insert_L_Employee_Reporting_Line__L2_Northwind_Employees]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_L_Employee_Reporting_Line__L2_Northwind_Employees] 
AS
	BEGIN

		INSERT INTO rv.L_Employee_Reporting_Line (
			  HK_L_Employee_Reporting_Line
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Employee__Direct_Report__DK
			, HK_H_Employee__Manager
		)
		SELECT
			  HK_L_Employee_Reporting_Line
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Employee__Direct_Report__DK
			, HK_H_Employee__Manager
		FROM
			rv.v_stage_L_Employee_Reporting_Line__L2_Northwind_Employees;

	END
GO
/****** Object:  StoredProcedure [rv].[usp_insert_L_Employee_Territory__L2_Northwind_EmployeeTerritories]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_L_Employee_Territory__L2_Northwind_EmployeeTerritories] 
AS
	BEGIN

		INSERT INTO rv.L_Employee_Territory (
			  HK_L_Employee_Territory
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Employee
			, HK_H_Territory
		)
		SELECT
			  HK_L_Employee_Territory
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Employee
			, HK_H_Territory
		FROM
			rv.v_stage_L_Employee_Territory__L2_Northwind_EmployeeTerritories;

	END
GO
/****** Object:  StoredProcedure [rv].[usp_insert_L_Order_Detail__L2_Northwind_Order_Details]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_L_Order_Detail__L2_Northwind_Order_Details] 
AS
	BEGIN

		INSERT INTO rv.L_Order_Detail (
			  HK_L_Order_Detail
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Order
			, HK_H_Product
		)
		SELECT
			  HK_L_Order_Detail
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Order
			, HK_H_Product
		FROM
			rv.v_stage_L_Order_Detail__L2_Northwind_Order_Details;

	END
GO
/****** Object:  StoredProcedure [rv].[usp_insert_L_Order_Header__L2_Northwind_Orders]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_L_Order_Header__L2_Northwind_Orders] 
AS
	BEGIN

		INSERT INTO rv.L_Order_Header (
			  HK_L_Order_Header
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Order__DK
			, HK_H_Customer
			, HK_H_Employee
			, HK_H_Shipper
		)
		SELECT
			  HK_L_Order_Header
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Order__DK
			, HK_H_Customer
			, HK_H_Employee
			, HK_H_Shipper
		FROM
			rv.v_stage_L_Order_Header__L2_Northwind_Orders;

	END
GO
/****** Object:  StoredProcedure [rv].[usp_insert_L_Product_Category__L2_Northwind_Products]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_L_Product_Category__L2_Northwind_Products] 
AS
	BEGIN

		INSERT INTO rv.L_Product_Category (
			  HK_L_Product_Category
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Product__DK
			, HK_H_Product_Category
		)
		SELECT
			  HK_L_Product_Category
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Product__DK
			, HK_H_Product_Category
		FROM
			rv.v_stage_L_Product_Category__L2_Northwind_Products;

	END
GO
/****** Object:  StoredProcedure [rv].[usp_insert_L_Product_Supplier__L2_Northwind_Products]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_L_Product_Supplier__L2_Northwind_Products] 
AS
	BEGIN

		INSERT INTO rv.L_Product_Supplier (
			  HK_L_Product_Supplier
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Product__DK
			, HK_H_Supplier
		)
		SELECT
			  HK_L_Product_Supplier
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Product__DK
			, HK_H_Supplier
		FROM
			rv.v_stage_L_Product_Supplier__L2_Northwind_Products;

	END
GO
/****** Object:  StoredProcedure [rv].[usp_insert_L_Territory_Region__L2_Northwind_Territories]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_L_Territory_Region__L2_Northwind_Territories]
AS
	BEGIN

		INSERT INTO rv.L_Territory_Region (
			  HK_L_Territory_Region
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Territory__DK
			, HK_H_Region
		)
		SELECT
			  HK_L_Territory_Region
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Territory__DK
			, HK_H_Region
		FROM
			rv.v_stage_L_Territory_Region__L2_Northwind_Territories;

	END
GO
/****** Object:  StoredProcedure [rv].[usp_insert_R_Date]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_R_Date] 
AS
	BEGIN

		INSERT INTO Data_Vault.rv.R_Date (
			  DV_Load_Datetime
			, DV_Record_Source
			, Date_Key
			, [Date]
			, Date_String
			, Start_Datetime
			, End_Datetime
			, Day_Of_Month_Number
			, Month_Number
			, Month_Name
			, Year_Number
			, Day_Of_Week_Number
			, Day_Of_Week_Name
			, Quarter_Number
			, Quarter_Name
		)
		SELECT
			  DV_Load_Datetime
			, DV_Record_Source
			, Date_Key
			, [Date]
			, Date_String
			, Start_Datetime
			, End_Datetime
			, Day_Of_Month_Number
			, Month_Number
			, Month_Name
			, Year_Number
			, Day_Of_Week_Number
			, Day_Of_Week_Name
			, Quarter_Number
			, Quarter_Name
		FROM
			Data_Vault.rv.v_stage_R_Date
		OPTION
			(MAXRECURSION 0);

	END
GO
/****** Object:  StoredProcedure [rv].[usp_insert_R_Time]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_R_Time] 
AS
	BEGIN

		INSERT INTO Data_Vault.rv.R_Time (
			  DV_Load_Datetime
			, DV_Record_Source
			, Time_Key
			, [Time]
			, Time_String
			, Hours_Of_Day
			, Minutes_Of_Hour
			, Seconds_Of_Minute 
		)
		SELECT
			  DV_Load_Datetime
			, DV_Record_Source
			, Time_Key
			, [Time]
			, Time_String
			, Hours_Of_Day
			, Minutes_Of_Hour
			, Seconds_Of_Minute 
		FROM
			Data_Vault.rv.v_stage_R_Time
		OPTION
			(MAXRECURSION 0);

	END
GO
/****** Object:  StoredProcedure [rv].[usp_insert_S_H_Customer_Northwind__L2_Northwind_Customers]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_S_H_Customer_Northwind__L2_Northwind_Customers] 
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
/****** Object:  StoredProcedure [rv].[usp_insert_S_H_Customer_Type_Northwind__L2_Northwind_CustomerDemographics]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_S_H_Customer_Type_Northwind__L2_Northwind_CustomerDemographics]
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
/****** Object:  StoredProcedure [rv].[usp_insert_S_H_Employee_Northwind__L2_Northwind_Employees]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_S_H_Employee_Northwind__L2_Northwind_Employees] 
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
/****** Object:  StoredProcedure [rv].[usp_insert_S_H_Order_Northwind__L2_Northwind_Orders]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_S_H_Order_Northwind__L2_Northwind_Orders]
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
/****** Object:  StoredProcedure [rv].[usp_insert_S_H_Product_Category_Northwind__L2_Northwind_Categories]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_S_H_Product_Category_Northwind__L2_Northwind_Categories]
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
/****** Object:  StoredProcedure [rv].[usp_insert_S_H_Product_Northwind__L2_Northwind_Products]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_S_H_Product_Northwind__L2_Northwind_Products]
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
/****** Object:  StoredProcedure [rv].[usp_insert_S_H_Region_Northwind__L2_Northwind_Region]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_S_H_Region_Northwind__L2_Northwind_Region]
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
/****** Object:  StoredProcedure [rv].[usp_insert_S_H_Shipper_Northwind__L2_Northwind_Shippers]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_S_H_Shipper_Northwind__L2_Northwind_Shippers]
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
/****** Object:  StoredProcedure [rv].[usp_insert_S_H_Supplier_Northwind__L2_Northwind_Suppliers]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_S_H_Supplier_Northwind__L2_Northwind_Suppliers]
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
/****** Object:  StoredProcedure [rv].[usp_insert_S_H_Territory_Northwind__L2_Northwind_Territories]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_S_H_Territory_Northwind__L2_Northwind_Territories]
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
/****** Object:  StoredProcedure [rv].[usp_insert_S_L_Order_Detail_Northwind__L2_Northwind_Order_Details]    Script Date: 17/10/2023 6:16:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [rv].[usp_insert_S_L_Order_Detail_Northwind__L2_Northwind_Order_Details] 
AS
	BEGIN

		INSERT INTO Data_Vault.rv.S_L_Order_Detail_Northwind (
			  HK_L_Order_Detail
			, DV_Load_Datetime
			, DV_Record_Source
			, HD_S_L_Order_Detail_Northwind
			, UnitPrice
			, Quantity
			, Discount
		)
		SELECT 
			  HK_L_Order_Detail
			, DV_Load_Datetime
			, DV_Record_Source
			, HD_S_L_Order_Detail_Northwind
			, UnitPrice
			, Quantity
			, Discount
		FROM
			Data_Vault.rv.v_stage_S_L_Order_Detail_Northwind__L2_Northwind_Order_Details;

	END
GO
USE [master]
GO
ALTER DATABASE [Data_Vault] SET  READ_WRITE 
GO
