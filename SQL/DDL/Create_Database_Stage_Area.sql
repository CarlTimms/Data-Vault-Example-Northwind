/*
	
	Create Database Stage_Area.sql

	Create database Stage_Area. 
	The raw Data Vault layer is loaded from here, rather than direct from the source system.
	Adds standard Data Vault metadata and hashes.


	CT
	2023-01-05

*/


SET NOCOUNT ON
GO


USE [master]
GO


-- Create database
DECLARE @device_directory NVARCHAR(520) = (
		SELECT
			SUBSTRING(filename, 1, CHARINDEX(N'master.mdf', LOWER(filename)) - 1)
		FROM
			[master].[dbo].[sysaltfiles]
		WHERE
			[dbid] = 1 AND [fileid] = 1
	);

EXECUTE (
		N'CREATE DATABASE [Stage_Area]
			ON PRIMARY
				  (
					  NAME = N''StageArea''
					, FILENAME = N''' + @device_directory + N'StageArea.mdf''
					, SIZE = 512KB
					, MAXSIZE = UNLIMITED
					, FILEGROWTH = 1024KB
				  )
				, FILEGROUP [DATA] (
					  NAME = N''StageArea_data''
					, FILENAME = N''' + @device_directory + N'StageArea_data.ndf''
					, SIZE = 512KB
					, MAXSIZE = UNLIMITED
					, FILEGROWTH = 10%
				  )
				, FILEGROUP [INDEX] (
					  NAME = N''StageArea_index''
					, FILENAME = N''' + @device_directory + N'StageArea_index.ndf''
					, SIZE = 512KB
					, MAXSIZE = UNLIMITED
					, FILEGROWTH = 10%)
			LOG ON 
				(
					  NAME = N''StageArea_log''
					, FILENAME = N''' + @device_directory + N'StageArea_log.ldf''
					, SIZE = 512KB
					, MAXSIZE = 2048GB
					, FILEGROWTH = 10%
				)
			WITH
				CATALOG_COLLATION = DATABASE_DEFAULT;'
	);
GO

ALTER DATABASE [Stage_Area] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Stage_Area].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Stage_Area] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Stage_Area] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Stage_Area] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Stage_Area] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Stage_Area] SET ARITHABORT OFF 
GO
ALTER DATABASE [Stage_Area] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Stage_Area] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Stage_Area] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Stage_Area] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Stage_Area] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Stage_Area] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Stage_Area] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Stage_Area] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Stage_Area] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Stage_Area] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Stage_Area] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Stage_Area] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Stage_Area] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Stage_Area] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Stage_Area] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Stage_Area] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Stage_Area] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Stage_Area] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Stage_Area] SET  MULTI_USER 
GO
ALTER DATABASE [Stage_Area] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Stage_Area] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Stage_Area] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Stage_Area] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Stage_Area] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Stage_Area] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Stage_Area] SET QUERY_STORE = OFF
GO

USE [Stage_Area]
GO
/****** Object:  Schema [northwind]    Script Date: 5/01/2023 10:15:39 am ******/
CREATE SCHEMA [northwind]
GO

/****** Object:  Table [northwind].[Categories]    Script Date: 5/01/2023 10:15:39 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [northwind].[Categories](
	[CategoryID] [int] NOT NULL,
	[CategoryName] [nvarchar](15) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[Picture] [varbinary](max) NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Deleted_Flag] [bit] NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[DV_Business_Key] [varchar](20) NOT NULL,
	[HK_H_Product_Category] [char](32) NOT NULL,
	[HD_S_HC_Product_Category_Northwind] [char](32) NOT NULL,
	[HD_S_HT_Product_Category_Northwind] [char](32) NOT NULL,
 CONSTRAINT [PK_Northwind_Categories] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX] TEXTIMAGE_ON [DATA]
GO
/****** Object:  Table [northwind].[CustomerCustomerDemo]    Script Date: 5/01/2023 10:15:39 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [northwind].[CustomerCustomerDemo](
	[CustomerID] [nchar](5) NOT NULL,
	[CustomerTypeID] [nchar](10) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Deleted_Flag] [bit] NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[DV_Business_Key] [varchar](20) NOT NULL,
	[HK_H_Customer] [char](32) NOT NULL,
	[HK_H_Customer_Type] [char](32) NOT NULL,
	[HK_L_Customer_Type] [char](32) NOT NULL,
	[HD_S_LT_Customer_Type_Northwind] [char](32) NOT NULL,
 CONSTRAINT [PK_Northwind_CustomerCustomerDemo] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC,
	[CustomerTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  Table [northwind].[CustomerDemographics]    Script Date: 5/01/2023 10:15:39 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [northwind].[CustomerDemographics](
	[CustomerTypeID] [nchar](10) NOT NULL,
	[CustomerDesc] [nvarchar](max) NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Deleted_Flag] [bit] NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[DV_Business_Key] [varchar](20) NOT NULL,
	[HK_H_Customer_Type] [char](32) NOT NULL,
	[HD_S_HC_Customer_Type_Northwind] [char](32) NOT NULL,
	[HD_S_HT_Customer_Type_Northwind] [char](32) NOT NULL,
 CONSTRAINT [PK_Northwind_CustomerDemographics] PRIMARY KEY CLUSTERED 
(
	[CustomerTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX] TEXTIMAGE_ON [DATA]
GO
/****** Object:  Table [northwind].[Customers]    Script Date: 5/01/2023 10:15:39 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [northwind].[Customers](
	[CustomerID] [nchar](5) NOT NULL,
	[CompanyName] [nvarchar](40) NOT NULL,
	[ContactName] [nvarchar](30) NULL,
	[ContactTitle] [nvarchar](30) NULL,
	[Address] [nvarchar](60) NULL,
	[City] [nvarchar](15) NULL,
	[Region] [nvarchar](15) NULL,
	[PostalCode] [nvarchar](10) NULL,
	[Country] [nvarchar](15) NULL,
	[Phone] [nvarchar](24) NULL,
	[Fax] [nvarchar](24) NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Deleted_Flag] [bit] NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[DV_Business_Key] [varchar](20) NOT NULL,
	[HK_H_Customer] [char](32) NOT NULL,
	[HD_S_HC_Customer_Northwind] [char](32) NOT NULL,
	[HD_S_HT_Customer_Northwind] [char](32) NOT NULL,
 CONSTRAINT [PK_Northwind_Customers] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  Table [northwind].[Employees]    Script Date: 5/01/2023 10:15:39 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [northwind].[Employees](
	[EmployeeID] [int] NOT NULL,
	[LastName] [nvarchar](20) NOT NULL,
	[FirstName] [nvarchar](10) NOT NULL,
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
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Deleted_Flag] [bit] NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[DV_Business_Key] [varchar](20) NOT NULL,
	[HK_H_Employee] [char](32) NOT NULL,
	[HK_H_Employee_Manager] [char](32) NOT NULL,
	[HK_L_Employee_Reporting_Line] [char](32) NOT NULL,
	[HD_S_HC_Employee_Northwind] [char](32) NOT NULL,
	[HD_S_HT_Employee_Northwind] [char](32) NOT NULL,
	[HD_S_LE_Employee_Reporting_Line_Northwind] [char](32) NOT NULL,
 CONSTRAINT [PK_Northwind_Employees] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX] TEXTIMAGE_ON [DATA]
GO
/****** Object:  Table [northwind].[EmployeeTerritories]    Script Date: 5/01/2023 10:15:39 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [northwind].[EmployeeTerritories](
	[EmployeeID] [int] NOT NULL,
	[TerritoryID] [nvarchar](20) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Deleted_Flag] [bit] NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[DV_Business_Key] [varchar](20) NOT NULL,
	[HK_H_Employee] [char](32) NOT NULL,
	[HK_H_Territory] [char](32) NOT NULL,
	[HK_L_Employee_Territory] [char](32) NOT NULL,
	[HD_S_LT_Employee_Territory_Northwind] [char](32) NOT NULL,
 CONSTRAINT [PK_Northwind_EmployeeTerritories] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC,
	[TerritoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  Table [northwind].[Order Details]    Script Date: 5/01/2023 10:15:39 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [northwind].[Order Details](
	[OrderID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[UnitPrice] [money] NOT NULL,
	[Quantity] [smallint] NOT NULL,
	[Discount] [real] NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Deleted_Flag] [bit] NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[DV_Business_Key] [varchar](20) NOT NULL,
	[HK_H_Order] [char](32) NOT NULL,
	[HK_H_Order_Detail] [char](32) NOT NULL,
	[HK_H_Product] [char](32) NOT NULL,
	[HK_L_Order_Detail] [char](32) NOT NULL,
	[HD_S_HC_Order_Detail_Northwind] [char](32) NOT NULL,
	[HD_S_HT_Order_Detail_Northwind] [char](32) NOT NULL,
 CONSTRAINT [PK_Northwind_Order_Details] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  Table [northwind].[Orders]    Script Date: 5/01/2023 10:15:39 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [northwind].[Orders](
	[OrderID] [int] NOT NULL,
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
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Deleted_Flag] [bit] NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[DV_Business_Key] [varchar](20) NOT NULL,
	[HK_H_Customer] [char](32) NOT NULL,
	[HK_H_Employee] [char](32) NOT NULL,
	[HK_H_Order] [char](32) NOT NULL,
	[HK_H_Shipper] [char](32) NOT NULL,
	[HK_L_Order_Header] [char](32) NOT NULL,
	[HD_S_HC_Order_Northwind] [char](32) NOT NULL,
	[HD_S_HT_Order_Northwind] [char](32) NOT NULL,
	[HD_S_LE_Order_Header_Northwind] [char](32) NOT NULL,
 CONSTRAINT [PK_Northwind_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  Table [northwind].[Products]    Script Date: 5/01/2023 10:15:39 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [northwind].[Products](
	[ProductID] [int] NOT NULL,
	[ProductName] [nvarchar](40) NOT NULL,
	[SupplierID] [int] NULL,
	[CategoryID] [int] NULL,
	[QuantityPerUnit] [nvarchar](20) NULL,
	[UnitPrice] [money] NULL,
	[UnitsInStock] [smallint] NULL,
	[UnitsOnOrder] [smallint] NULL,
	[ReorderLevel] [smallint] NULL,
	[Discontinued] [bit] NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Deleted_Flag] [bit] NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[DV_Business_Key] [varchar](20) NOT NULL,
	[HK_H_Product_Category] [char](32) NOT NULL,
	[HK_H_Product] [char](32) NOT NULL,
	[HK_H_Supplier] [char](32) NOT NULL,
	[HK_L_Product_Category] [char](32) NOT NULL,
	[HK_L_Product_Supplier] [char](32) NOT NULL,
	[HD_S_HC_Product_Northwind] [char](32) NOT NULL,
	[HD_S_HT_Product_Northwind] [char](32) NOT NULL,
	[HD_S_LE_Product_Category_Northwind] [char](32) NOT NULL,
	[HD_S_LE_Product_Supplier_Northwind] [char](32) NOT NULL,
 CONSTRAINT [PK_Northwind_Products] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  Table [northwind].[Region]    Script Date: 5/01/2023 10:15:39 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [northwind].[Region](
	[RegionID] [int] NOT NULL,
	[RegionDescription] [nchar](50) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Deleted_Flag] [bit] NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[DV_Business_Key] [varchar](20) NOT NULL,
	[HK_H_Region] [char](32) NOT NULL,
	[HD_S_HC_Region_Northwind] [char](32) NOT NULL,
	[HD_S_HT_Region_Northwind] [char](32) NOT NULL,
 CONSTRAINT [PK_Northwind_Region] PRIMARY KEY CLUSTERED 
(
	[RegionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  Table [northwind].[Shippers]    Script Date: 5/01/2023 10:15:39 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [northwind].[Shippers](
	[ShipperID] [int] NOT NULL,
	[CompanyName] [nvarchar](40) NOT NULL,
	[Phone] [nvarchar](24) NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Deleted_Flag] [bit] NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[DV_Business_Key] [varchar](20) NOT NULL,
	[HK_H_Shipper] [char](32) NOT NULL,
	[HD_S_HC_Shipper_Northwind] [char](32) NOT NULL,
	[HD_S_HT_Shipper_Northwind] [char](32) NOT NULL,
 CONSTRAINT [PK_Northwind_Shippers] PRIMARY KEY CLUSTERED 
(
	[ShipperID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  Table [northwind].[Suppliers]    Script Date: 5/01/2023 10:15:39 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [northwind].[Suppliers](
	[SupplierID] [int] NOT NULL,
	[CompanyName] [nvarchar](40) NOT NULL,
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
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Deleted_Flag] [bit] NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[DV_Business_Key] [varchar](20) NOT NULL,
	[HK_H_Supplier] [char](32) NOT NULL,
	[HD_S_HC_Supplier_Northwind] [char](32) NOT NULL,
	[HD_S_HT_Supplier_Northwind] [char](32) NOT NULL,
 CONSTRAINT [PK_Northwind_Suppliers] PRIMARY KEY NONCLUSTERED 
(
	[SupplierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA] TEXTIMAGE_ON [DATA]
GO
/****** Object:  Table [northwind].[Territories]    Script Date: 5/01/2023 10:15:39 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [northwind].[Territories](
	[TerritoryID] [nvarchar](20) NOT NULL,
	[TerritoryDescription] [nchar](50) NOT NULL,
	[RegionID] [int] NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Deleted_Flag] [bit] NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[DV_Business_Key] [varchar](20) NOT NULL,
	[HK_H_Region] [char](32) NOT NULL,
	[HK_H_Territory] [char](32) NOT NULL,
	[HK_L_Territory_Region] [char](32) NOT NULL,
	[HD_S_HC_Territory_Northwind] [char](32) NOT NULL,
	[HD_S_HT_Territory_Northwind] [char](32) NOT NULL,
	[HD_S_LE_Territory_Region_Northwind] [char](32) NOT NULL,
 CONSTRAINT [PK_Northwind_Territories] PRIMARY KEY CLUSTERED 
(
	[TerritoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_Northwind_Categories]    Script Date: 5/01/2023 10:15:39 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_Northwind_Categories] ON [northwind].[Categories]
(
	[HK_H_Product_Category] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_Northwind_CustomerCustomerDemo]    Script Date: 5/01/2023 10:15:39 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_Northwind_CustomerCustomerDemo] ON [northwind].[CustomerCustomerDemo]
(
	[HK_H_Customer] ASC,
	[HK_H_Customer_Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_Northwind_CustomerDemographics]    Script Date: 5/01/2023 10:15:39 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_Northwind_CustomerDemographics] ON [northwind].[CustomerDemographics]
(
	[HK_H_Customer_Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_Northwind_Customers]    Script Date: 5/01/2023 10:15:39 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_Northwind_Customers] ON [northwind].[Customers]
(
	[HK_H_Customer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_Northwind_Employees]    Script Date: 5/01/2023 10:15:39 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_Northwind_Employees] ON [northwind].[Employees]
(
	[HK_H_Employee] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_Northwind_EmployeeTerritories]    Script Date: 5/01/2023 10:15:39 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_Northwind_EmployeeTerritories] ON [northwind].[EmployeeTerritories]
(
	[HK_H_Employee] ASC,
	[HK_H_Territory] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_Northwind_Order_Details]    Script Date: 5/01/2023 10:15:39 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_Northwind_Order_Details] ON [northwind].[Order Details]
(
	[HK_H_Order_Detail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_Northwind_Orders]    Script Date: 5/01/2023 10:15:39 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_Northwind_Orders] ON [northwind].[Orders]
(
	[HK_H_Order] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_Northwind_Products]    Script Date: 5/01/2023 10:15:39 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_Northwind_Products] ON [northwind].[Products]
(
	[HK_H_Product] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_Northwind_Region]    Script Date: 5/01/2023 10:15:39 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_Northwind_Region] ON [northwind].[Region]
(
	[HK_H_Region] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_Northwind_Shippers]    Script Date: 5/01/2023 10:15:39 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_Northwind_Shippers] ON [northwind].[Shippers]
(
	[HK_H_Shipper] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_Northwind_Suppliers]    Script Date: 5/01/2023 10:15:39 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_Northwind_Suppliers] ON [northwind].[Suppliers]
(
	[HK_H_Supplier] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_Northwind_Territories]    Script Date: 5/01/2023 10:15:39 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_Northwind_Territories] ON [northwind].[Territories]
(
	[HK_H_Territory] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
/****** Object:  StoredProcedure [northwind].[usp_Load_Northwind_Categories]    Script Date: 5/01/2023 10:15:39 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [northwind].[usp_Load_Northwind_Categories] 
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			DECLARE @DV_Load_Datetime datetime2(7) = SYSDATETIME();

			/* Load incoming data into a temporary table with all hashes and metadata added */

			-- Create temporary table identical to the stage to hold the incoming records
			CREATE TABLE #TEMP_Northwind_Categories (
				  [CategoryID] int
				, [CategoryName] nvarchar(15)
				, [Description] nvarchar(max) NULL  -- ntext data type deprecated. Use nvarchar(max)
				, [Picture] varbinary(max) NULL	 -- image data type deprecated. Use varbinary(max)
				, [DV_Load_Datetime] datetime2(7)
				, [DV_Deleted_Flag] bit
				, [DV_Record_Source] varchar(100)
				, [DV_Business_Key] varchar(20)
				, [HK_H_Product_Category] char(32)
				, [HD_S_HC_Product_Category_Northwind] char(32)
				, [HD_S_HT_Product_Category_Northwind] char(32)
				, CONSTRAINT [PK_TEMP_Northwind_Categories] PRIMARY KEY CLUSTERED ([CategoryID])
			);

			-- Insert all existing records from source with metadata added
			INSERT INTO #TEMP_Northwind_Categories (
				  [CategoryID]
				, [CategoryName]
				, [Description]
				, [Picture]
				, [DV_Load_Datetime]
				, [DV_Deleted_Flag]
				, [DV_Record_Source]
				, [DV_Business_Key]
				, [HK_H_Product_Category]
				, [HD_S_HC_Product_Category_Northwind]
				, [HD_S_HT_Product_Category_Northwind]
			)
			SELECT
				  [CategoryID]
				, [CategoryName]
				, CAST([Description] AS nvarchar(max)) AS Description  -- ntext data type deprecated. Use nvarchar(max)
				, CAST([Picture] AS varbinary(max)) AS Picture -- image data type deprecated. Use varbinary(max)
				, @DV_Load_Datetime AS DV_Load_Datetime
				, 0 AS DV_Deleted_Flag
				, 'Northwind.dbo.Categories' AS DV_Record_Source
				, CONVERT(varchar(20), [CategoryID]) AS DV_Business_Key
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							  -- Business key
							, ISNULL(CONVERT(varchar(10), [CategoryID]), '')
						  )
						, 2
					)
				  ) AS HK_H_Product_Category
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							, CONCAT(
								  -- Business key
								  ISNULL([CategoryID], ''), '|'
								  -- Change detection fields
								, TRIM(ISNULL([CategoryName], '')), '|'
								, TRIM(ISNULL(CAST([Description] AS varchar(MAX)), '')), '|'  -- Argument data type ntext is invalid for argument 1 of Trim function. - cast as varchar
								, COALESCE(CAST([Picture] AS varbinary(MAX)), '')  -- Argument data type image is invalid for argument 1 of Trim function - cast as varcbinary
							  )
						  )
						, 2
					)
				  ) AS HD_S_HC_Product_Category_Northwind				
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							, CONCAT(
								  -- Business key
								  ISNULL([CategoryID], ''), '|'
								  -- Change detection fields
								, 0  -- DV_Deleted_Flag
							  )
						  )
						, 2
					)
				  ) AS HD_S_HT_Product_Category_Northwind
			FROM
				[Northwind].[dbo].[Categories];


			/* Merge existing data in the stage table with the incoming data in the temp table */

			MERGE 
				[Stage_Area].[northwind].[Categories] AS t 
			USING
				#TEMP_Northwind_Categories AS s
			ON
				s.[CategoryID] = t.[CategoryID]
			-- Insert
			WHEN NOT MATCHED BY TARGET THEN 
				INSERT (
					  [CategoryID]
					, [CategoryName]
					, [Description]
					, [Picture]
					, [DV_Load_Datetime]
					, [DV_Deleted_Flag]
					, [DV_Record_Source]
					, [DV_Business_Key]
					, [HK_H_Product_Category]
					, [HD_S_HC_Product_Category_Northwind]
					, [HD_S_HT_Product_Category_Northwind]
				) 
				VALUES (
					  s.[CategoryID]
					, s.[CategoryName]
					, s.[Description]
					, s.[Picture]
					, s.[DV_Load_Datetime]
					, s.[DV_Deleted_Flag]
					, s.[DV_Record_Source]
					, s.[DV_Business_Key]
					, s.[HK_H_Product_Category]
					, s.[HD_S_HC_Product_Category_Northwind]
					, s.[HD_S_HT_Product_Category_Northwind]
				)
			-- Update
			WHEN MATCHED THEN 
				UPDATE SET
					  t.[CategoryID] = s.[CategoryID]
					, t.[CategoryName] = s.[CategoryName]
					, t.[Description] = s.[Description]
					, t.[Picture] = s.[Picture]
					, t.[DV_Load_Datetime] = s.[DV_Load_Datetime]
					, t.[DV_Deleted_Flag] = s.[DV_Deleted_Flag]
					, t.[DV_Record_Source] = s.[DV_Record_Source]
					, t.[DV_Business_Key] = s.[DV_Business_Key]
					, t.[HK_H_Product_Category] = s.[HK_H_Product_Category]
					, t.[HD_S_HC_Product_Category_Northwind] = s.[HD_S_HC_Product_Category_Northwind]
					, t.[HD_S_HT_Product_Category_Northwind] = s.[HD_S_HT_Product_Category_Northwind]
			-- Delete
			WHEN NOT MATCHED BY SOURCE AND t.[DV_Deleted_Flag] = 0 THEN 
				UPDATE SET
					  t.[DV_Load_Datetime] = @DV_Load_Datetime
					, t.[DV_Deleted_Flag] = 1
					, t.[DV_Record_Source] = 'SYSTEM'
					, t.[HD_S_HT_Product_Category_Northwind] = UPPER(
						CONVERT(
							  char(32)
							, HASHBYTES(
								  'MD5'
								, CONCAT(
									  -- Business key
									  ISNULL(t.[CategoryID], ''), '|' 
									  -- Change detection fields
									, 1  -- DV_Deleted_Flag
								  )
							  )
							, 2
						)
					  );


			-- Drop temp table
			DROP TABLE #TEMP_Northwind_Categories;

		END TRY
		BEGIN CATCH

			-- If error caught and uncomitted transactions then roll back transaction
			IF @@TRANCOUNT > 0  
				ROLLBACK TRANSACTION; 

			-- Insert error details to the error log table
			INSERT INTO 
				[Meta_Metrics_Error_Mart].[error].[Error_Log]
			VALUES (	
				  GETDATE()
				, ERROR_PROCEDURE()
				, ERROR_NUMBER()
				, ERROR_SEVERITY()
				, ERROR_STATE()
				, ERROR_LINE()
				, ERROR_MESSAGE()
			);

		END CATCH

		-- If TRY completes successfully, commit the transaction
		IF @@TRANCOUNT > 0  
			COMMIT TRANSACTION;  

	END
GO
/****** Object:  StoredProcedure [northwind].[usp_Load_Northwind_CustomerCustomerDemo]    Script Date: 5/01/2023 10:15:39 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [northwind].[usp_Load_Northwind_CustomerCustomerDemo] 
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			DECLARE @DV_Load_Datetime datetime2(7) = SYSDATETIME();


			/* Load incoming data into a temporary table with all hashes and metadata added */

			-- Create temporary table identical to the stage to hold the incoming records
			CREATE TABLE #TEMP_Northwind_CustomerCustomerDemo (
				  [CustomerID] nchar(5) NOT NULL
				, [CustomerTypeID] nchar(10) NOT NULL
				, [DV_Load_Datetime] datetime2(7) NOT NULL
				, [DV_Deleted_Flag] bit NOT NULL
				, [DV_Record_Source] varchar(100) NOT NULL
				, [DV_Business_Key] varchar(20) NOT NULL
				, [HK_H_Customer] char(32) NOT NULL
				, [HK_H_Customer_Type] char(32) NOT NULL
				, [HK_L_Customer_Type] char(32) NOT NULL
				, [HD_S_LT_Customer_Type_Northwind] char(32) NOT NULL
				, CONSTRAINT [PK_TEMP_Northwind_CustomerCustomerDemo] PRIMARY KEY CLUSTERED (
					  [CustomerID] ASC
					, [CustomerTypeID] ASC
				  )
			);

			-- Insert all existing records from source with metadata added
			INSERT INTO #TEMP_Northwind_CustomerCustomerDemo (
				  [CustomerID]
				, [CustomerTypeID]
				, [DV_Load_Datetime]
				, [DV_Deleted_Flag]
				, [DV_Record_Source]
				, [DV_Business_Key]
				, [HK_H_Customer]
				, [HK_H_Customer_Type]
				, [HK_L_Customer_Type]
				, [HD_S_LT_Customer_Type_Northwind]
			)
			SELECT
				  [CustomerID]
				, [CustomerTypeID]
				, @DV_Load_Datetime AS DV_Load_Datetime
				, 0 AS DV_Deleted_Flag
				, 'Northwind.dbo.CustomerCustomerDemo' AS DV_Record_Source
				, CONCAT(
					  [CustomerID], '|'
					, [CustomerTypeID]
				  ) AS DV_Business_Key
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							  -- Business key
							, ISNULL([CustomerID], '')
						  )
						, 2
					)
				  ) AS HK_H_Customer
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							  -- Business key
							, ISNULL([CustomerTypeID], '')
						  )
						, 2
					)
				  ) AS HK_H_Customer_Type
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							  -- Business key
							, CONCAT(
								  ISNULL([CustomerID], ''), '|'
								, ISNULL([CustomerTypeID], '')
							  )
						  )
						, 2
					)
				  ) AS HK_L_Customer_Type
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							, CONCAT(
								  -- Business key
								  ISNULL([CustomerID], ''), '|'
								, ISNULL([CustomerTypeID], ''), '|'
								  -- Change detection fields
								, 0  -- DV_Deleted_Flag
							  )
						  )
						, 2
					)
				  ) AS HD_S_LT_Customer_Type_Northwind
			FROM
				[Northwind].[dbo].[CustomerCustomerDemo];


			/* Merge existing data in the stage table with the incoming data in the temp table */

			MERGE 
				[Stage_Area].[northwind].[CustomerCustomerDemo] AS t 
			USING
				#TEMP_Northwind_CustomerCustomerDemo AS s
			ON
				s.[CustomerID] = t.[CustomerID]
				AND s.[CustomerTypeID] = t.[CustomerTypeID]
			-- Insert
			WHEN NOT MATCHED BY TARGET THEN 
				INSERT (
					  [CustomerID]
					, [CustomerTypeID]
					, [DV_Load_Datetime]
					, [DV_Deleted_Flag]
					, [DV_Record_Source]
					, [DV_Business_Key]
					, [HK_H_Customer]
					, [HK_H_Customer_Type]
					, [HK_L_Customer_Type]
					, [HD_S_LT_Customer_Type_Northwind]
				) 
				VALUES (
					  s.[CustomerID]
					, s.[CustomerTypeID]
					, s.[DV_Load_Datetime]
					, s.[DV_Deleted_Flag]
					, s.[DV_Record_Source]
					, s.[DV_Business_Key]
					, s.[HK_H_Customer]
					, s.[HK_H_Customer_Type]
					, s.[HK_L_Customer_Type]
					, s.[HD_S_LT_Customer_Type_Northwind]
				)
			-- Update
			WHEN MATCHED THEN 
				UPDATE SET
					  t.[CustomerID] = s.[CustomerID]
					, t.[CustomerTypeID] = s.[CustomerTypeID]
					, t.[DV_Load_Datetime] = s.[DV_Load_Datetime]
					, t.[DV_Deleted_Flag] = s.[DV_Deleted_Flag]
					, t.[DV_Record_Source] = s.[DV_Record_Source]
					, t.[DV_Business_Key] = s.[DV_Business_Key]
					, t.[HK_H_Customer] = s.[HK_H_Customer]
					, t.[HK_H_Customer_Type] = s.[HK_H_Customer_Type]
					, t.[HK_L_Customer_Type] = s.[HK_L_Customer_Type]
					, t.[HD_S_LT_Customer_Type_Northwind] = s.[HD_S_LT_Customer_Type_Northwind]
			-- Delete
			WHEN NOT MATCHED BY SOURCE AND t.[DV_Deleted_Flag] = 0 THEN 
				UPDATE SET
					  t.[DV_Load_Datetime] = @DV_Load_Datetime
					, t.[DV_Deleted_Flag] = 1
					, t.[DV_Record_Source] = 'SYSTEM'
					, t.[HD_S_LT_Customer_Type_Northwind] = UPPER(
							CONVERT(
								  char(32)
								, HASHBYTES(
									  'MD5'
									, CONCAT(
										  -- Business key
										  ISNULL(t.[CustomerID], ''), '|'
										, ISNULL(t.[CustomerTypeID], ''), '|'
										  -- Change detection fields
										, 1  -- DV_Deleted_Flag
									  )
								  )
								, 2
							)
						  );


			-- Drop temp table
			DROP TABLE #TEMP_Northwind_CustomerCustomerDemo;

		END TRY
		BEGIN CATCH

			-- If error caught and uncomitted transactions then roll back transaction
			IF @@TRANCOUNT > 0  
				ROLLBACK TRANSACTION; 

			-- Insert error details to the error log table
			INSERT INTO 
				[Meta_Metrics_Error_Mart].[error].[Error_Log]
			VALUES (	
				  GETDATE()
				, ERROR_PROCEDURE()
				, ERROR_NUMBER()
				, ERROR_SEVERITY()
				, ERROR_STATE()
				, ERROR_LINE()
				, ERROR_MESSAGE()
			);

		END CATCH

		-- If TRY completes successfully, commit the transaction
		IF @@TRANCOUNT > 0  
			COMMIT TRANSACTION;  

	END
GO
/****** Object:  StoredProcedure [northwind].[usp_Load_Northwind_CustomerDemographics]    Script Date: 5/01/2023 10:15:39 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [northwind].[usp_Load_Northwind_CustomerDemographics] 
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			DECLARE @DV_Load_Datetime datetime2(7) = SYSDATETIME();


			/* Load incoming data into a temporary table with all hashes and metadata added */

			-- Create temporary table identical to the stage to hold the incoming records
			CREATE TABLE #TEMP_Northwind_CustomerDemographics (
				  [CustomerTypeID] nchar(10) NOT NULL
				, [CustomerDesc] nvarchar(max) NULL
				, [DV_Load_Datetime] datetime2(7) NOT NULL
				, [DV_Deleted_Flag] bit NOT NULL
				, [DV_Record_Source] varchar(100) NOT NULL
				, [DV_Business_Key] varchar(20) NOT NULL
				, [HK_H_Customer_Type] char(32) NOT NULL
				, [HD_S_HC_Customer_Type_Northwind] char(32) NOT NULL
				, [HD_S_HT_Customer_Type_Northwind] char(32) NOT NULL
				, CONSTRAINT [PK_TEMP_Northwind_CustomerDemographics] PRIMARY KEY CLUSTERED (
					[CustomerTypeID] ASC
				  )
			);

			-- Insert all existing records from source with metadata added
			INSERT INTO #TEMP_Northwind_CustomerDemographics (
				  [CustomerTypeID]
				, [CustomerDesc]
 				, [DV_Load_Datetime]
				, [DV_Deleted_Flag]
				, [DV_Record_Source]
				, [DV_Business_Key]
				, [HK_H_Customer_Type]
				, [HD_S_HC_Customer_Type_Northwind]
				, [HD_S_HT_Customer_Type_Northwind]
			)
			SELECT
				  [CustomerTypeID]
				, CAST([CustomerDesc] AS nvarchar(max))
				, @DV_Load_Datetime AS DV_Load_Datetime
				, 0 AS DV_Deleted_Flag
				, 'Northwind.dbo.CustomerDemographics' AS DV_Record_Source
				, [CustomerTypeID] AS DV_Business_Key
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							  -- Business key
							, ISNULL([CustomerTypeID], '')
							)
						, 2
					)
				  ) AS HK_H_Customer_Type
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							, CONCAT(
								  -- Business key
								  ISNULL([CustomerTypeID], ''), '|'
								  -- Change detection fields
								, TRIM(ISNULL(CAST([CustomerDesc] AS nvarchar(max)), ''))
							  )
						  )
						, 2
					)
				  ) AS HD_S_HC_Customer_Type_Northwind
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							, CONCAT(
								  -- Business key
								  ISNULL([CustomerTypeID], ''), '|'
								  -- Change detection fields
								, 0  -- DV_Deleted_Flag
							  )
						  )
						, 2
					)
				  ) AS HD_S_HT_Customer_Type_Northwind
			FROM
				[Northwind].[dbo].[CustomerDemographics];


			/* Merge existing data in the stage table with the incoming data in the temp table */

			MERGE 
				[Stage_Area].[northwind].[CustomerDemographics] AS t 
			USING
				#TEMP_Northwind_CustomerDemographics AS s
			ON
				s.[CustomerTypeID] = t.[CustomerTypeID]
			-- Insert
			WHEN NOT MATCHED BY TARGET THEN 
				INSERT (
					  [CustomerTypeID]
					, [CustomerDesc]
					, [DV_Load_Datetime]
					, [DV_Deleted_Flag]
					, [DV_Record_Source]
					, [DV_Business_Key]
					, [HK_H_Customer_Type]
					, [HD_S_HC_Customer_Type_Northwind]
					, [HD_S_HT_Customer_Type_Northwind]
				) 
				VALUES (
					  s.[CustomerTypeID]
					, s.[CustomerDesc]
					, s.[DV_Load_Datetime]
					, s.[DV_Deleted_Flag]
					, s.[DV_Record_Source]
					, s.[DV_Business_Key]
					, s.[HK_H_Customer_Type]
					, s.[HD_S_HC_Customer_Type_Northwind]
					, s.[HD_S_HT_Customer_Type_Northwind]
				)
			-- Update
			WHEN MATCHED THEN 
				UPDATE SET
					  t.[CustomerTypeID] = s.[CustomerTypeID]
					, t.[CustomerDesc] = s.[CustomerDesc]
					, t.[DV_Load_Datetime] = s.[DV_Load_Datetime]
					, t.[DV_Deleted_Flag] = s.[DV_Deleted_Flag]
					, t.[DV_Record_Source] = s.[DV_Record_Source]
					, t.[DV_Business_Key] = s.[DV_Business_Key]
					, t.[HK_H_Customer_Type] = s.[HK_H_Customer_Type]
					, t.[HD_S_HC_Customer_Type_Northwind] = s.[HD_S_HC_Customer_Type_Northwind]
					, t.[HD_S_HT_Customer_Type_Northwind] = s.[HD_S_HT_Customer_Type_Northwind]
			-- Delete
			WHEN NOT MATCHED BY SOURCE AND t.[DV_Deleted_Flag] = 0 THEN 
				UPDATE SET
					  t.[DV_Load_Datetime] = @DV_Load_Datetime
					, t.[DV_Deleted_Flag] = 1
					, t.[DV_Record_Source] = 'SYSTEM'
					, t.[HD_S_HT_Customer_Type_Northwind] = UPPER(
							CONVERT(
								  char(32)
								, HASHBYTES(
									  'MD5'
									, CONCAT(
										  -- Business key
										  ISNULL(t.[CustomerTypeID], ''), '|'
										  -- Change detection fields
										, 1  -- DV_Deleted_Flag
									  )
								  )
								, 2
							)
						  );


			-- Drop temp table
			DROP TABLE #TEMP_Northwind_CustomerDemographics;

		END TRY
		BEGIN CATCH

			-- If error caught and uncomitted transactions then roll back transaction
			IF @@TRANCOUNT > 0  
				ROLLBACK TRANSACTION; 

			-- Insert error details to the error log table
			INSERT INTO 
				[Meta_Metrics_Error_Mart].[error].[Error_Log]
			VALUES (	
				  GETDATE()
				, ERROR_PROCEDURE()
				, ERROR_NUMBER()
				, ERROR_SEVERITY()
				, ERROR_STATE()
				, ERROR_LINE()
				, ERROR_MESSAGE()
			);

		END CATCH

		-- If TRY completes successfully, commit the transaction
		IF @@TRANCOUNT > 0  
			COMMIT TRANSACTION;  

	END
GO
/****** Object:  StoredProcedure [northwind].[usp_Load_Northwind_Customers]    Script Date: 5/01/2023 10:15:39 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [northwind].[usp_Load_Northwind_Customers] 
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			DECLARE @DV_Load_Datetime datetime2(7) = SYSDATETIME();


			/* Load incoming data into a temporary table with all hashes and metadata added */

			-- Create temporary table identical to the stage to hold the incoming records
			CREATE TABLE #TEMP_Northwind_Customers (
				  [CustomerID] nchar(5) NOT NULL
				, [CompanyName] nvarchar(40) NOT NULL
				, [ContactName] nvarchar(30) NULL
				, [ContactTitle] nvarchar(30) NULL
				, [Address] nvarchar(60) NULL
				, [City] nvarchar(15) NULL
				, [Region] nvarchar(15) NULL
				, [PostalCode] nvarchar(10) NULL
				, [Country] nvarchar(15) NULL
				, [Phone] nvarchar(24) NULL
				, [Fax] nvarchar(24) NULL
				, [DV_Load_Datetime] datetime2(7) NOT NULL
				, [DV_Deleted_Flag] bit NOT NULL
				, [DV_Record_Source] varchar(100) NOT NULL
				, [DV_Business_Key] varchar(20) NOT NULL
				, [HK_H_Customer] char(32) NOT NULL
				, [HD_S_HC_Customer_Northwind] char(32) NOT NULL
				, [HD_S_HT_Customer_Northwind] char(32) NOT NULL
				, CONSTRAINT [PK_Northwind_Customers] PRIMARY KEY CLUSTERED ([CustomerID] ASC)
			);

			-- Insert all existing records from source with metadata added
			INSERT INTO #TEMP_Northwind_Customers (
				  [CustomerID]
				, [CompanyName]
				, [ContactName]
				, [ContactTitle]
				, [Address]
				, [City]
				, [Region]
				, [PostalCode]
				, [Country]
				, [Phone]
				, [Fax]
				, [DV_Load_Datetime]
				, [DV_Deleted_Flag]
				, [DV_Record_Source]
				, [DV_Business_Key]
				, [HK_H_Customer]
				, [HD_S_HC_Customer_Northwind]
				, [HD_S_HT_Customer_Northwind]
			)
			SELECT
				  [CustomerID]
				, [CompanyName]
				, [ContactName]
				, [ContactTitle]
				, [Address]
				, [City]
				, [Region]
				, [PostalCode]
				, [Country]
				, [Phone]
				, [Fax]
				, @DV_Load_Datetime AS DV_Load_Datetime
				, 0 AS DV_Deleted_Flag
				, 'Northwind.dbo.Customers' AS DV_Record_Source
				, [CustomerID] AS DV_Business_Key
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							  -- Business key
							, ISNULL([CustomerID], '')
							)
						, 2
					)
				  ) AS HK_H_Customer
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							, CONCAT(
								  -- Business key
								  ISNULL([CustomerID], ''), '|'
								  -- Change detection fields
								, TRIM(ISNULL([CompanyName], '')), '|'
								, TRIM(ISNULL([ContactName], '')), '|'
								, TRIM(ISNULL([ContactTitle], '')), '|'
								, TRIM(ISNULL([Address], '')), '|'
								, TRIM(ISNULL([City], '')), '|'
								, TRIM(ISNULL([Region], '')), '|'
								, TRIM(ISNULL([PostalCode], '')), '|'
								, TRIM(ISNULL([Country], '')), '|'
								, TRIM(ISNULL([Phone], '')), '|'
								, TRIM(ISNULL([Fax], ''))
							)
						  )
						, 2
					)
				  ) AS HD_S_HC_Customer_Northwind
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							, CONCAT(
								  -- Business key
								  ISNULL([CustomerID], ''), '|'
								  -- Change detection fields
								, 0  -- DV_Deleted_Flag
							  )
							)
						, 2
					)
				  ) AS HD_S_HT_Customer_Northwind
			FROM
				[Northwind].[dbo].[Customers];


			/* Merge existing data in the stage table with the incoming data in the temp table */

			MERGE
				[Stage_Area].[northwind].[Customers] AS t
			USING
				#TEMP_Northwind_Customers AS s
			ON
				s.[CustomerID] = t.[CustomerID]
			-- Insert
			WHEN NOT MATCHED BY TARGET THEN
				INSERT (
					  [CustomerID]
					, [CompanyName]
					, [ContactName]
					, [ContactTitle]
					, [Address]
					, [City]
					, [Region]
					, [PostalCode]
					, [Country]
					, [Phone]
					, [Fax]
					, [DV_Load_Datetime]
					, [DV_Deleted_Flag]
					, [DV_Record_Source]
					, [DV_Business_Key]
					, [HK_H_Customer]
					, [HD_S_HC_Customer_Northwind]
					, [HD_S_HT_Customer_Northwind]
				)
				VALUES (
					  s.[CustomerID]
					, s.[CompanyName]
					, s.[ContactName]
					, s.[ContactTitle]
					, s.[Address]
					, s.[City]
					, s.[Region]
					, s.[PostalCode]
					, s.[Country]
					, s.[Phone]
					, s.[Fax]
					, s.[DV_Load_Datetime]
					, s.[DV_Deleted_Flag]
					, s.[DV_Record_Source]
					, s.[DV_Business_Key]
					, s.[HK_H_Customer]
					, s.[HD_S_HC_Customer_Northwind]
					, s.[HD_S_HT_Customer_Northwind]
				)
			-- Update
			WHEN MATCHED THEN
				UPDATE SET
					  t.[CustomerID] = s.[CustomerID]
					, t.[CompanyName] = s.[CompanyName]
					, t.[ContactName] = s.[ContactName]
					, t.[ContactTitle] = s.[ContactTitle]
					, t.[Address] = s.[Address]
					, t.[City] = s.[City]
					, t.[Region] = s.[Region]
					, t.[PostalCode] = s.[PostalCode]
					, t.[Country] = s.[Country]
					, t.[Phone] = s.[Phone]
					, t.[Fax] = s.[Fax]
					, t.[DV_Load_Datetime] = s.[DV_Load_Datetime]
					, t.[DV_Deleted_Flag] = s.[DV_Deleted_Flag]
					, t.[DV_Record_Source] = s.[DV_Record_Source]
					, t.[DV_Business_Key] = s.[DV_Business_Key]
					, t.[HK_H_Customer] = s.[HK_H_Customer]
					, t.[HD_S_HC_Customer_Northwind] = s.[HD_S_HC_Customer_Northwind]
					, t.[HD_S_HT_Customer_Northwind] = s.[HD_S_HT_Customer_Northwind]
			-- Delete
			WHEN NOT MATCHED BY SOURCE AND t.[DV_Deleted_Flag] = 0 THEN
				UPDATE SET
					  t.[DV_Load_Datetime] = @DV_Load_Datetime
					, t.[DV_Deleted_Flag] = 1
					, t.[DV_Record_Source] = 'SYSTEM'
					, t.[HD_S_HT_Customer_Northwind] = UPPER(
							CONVERT(
								  char(32)
								, HASHBYTES(
									  'MD5'
									, CONCAT(
										  -- Business key
										  ISNULL(t.[CustomerID], ''), '|'
										  -- Change detection fields
										, 1  -- DV_Deleted_Flag
									  )
									)
								, 2
							)
						  );


			-- Drop temp table
			DROP TABLE #TEMP_Northwind_Customers;

		END TRY
		BEGIN CATCH

			-- If error caught and uncomitted transactions then roll back transaction
			IF @@TRANCOUNT > 0  
				ROLLBACK TRANSACTION; 

			-- Insert error details to the error log table
			INSERT INTO 
				[Meta_Metrics_Error_Mart].[error].[Error_Log]
			VALUES (	
				  GETDATE()
				, ERROR_PROCEDURE()
				, ERROR_NUMBER()
				, ERROR_SEVERITY()
				, ERROR_STATE()
				, ERROR_LINE()
				, ERROR_MESSAGE()
			);

		END CATCH

		-- If TRY completes successfully, commit the transaction
		IF @@TRANCOUNT > 0  
			COMMIT TRANSACTION;  
	END
GO
/****** Object:  StoredProcedure [northwind].[usp_Load_Northwind_Employees]    Script Date: 5/01/2023 10:15:39 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [northwind].[usp_Load_Northwind_Employees] 
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			DECLARE @DV_Load_Datetime datetime2(7) = SYSDATETIME();

			/* Load incoming data into a temporary table with all hashes and metadata added */

			-- Create temporary table identical to the stage to hold the incoming records
			CREATE TABLE #TEMP_Northwind_Employees (
				  [EmployeeID] int NOT NULL
				, [LastName] nvarchar(20) NOT NULL
				, [FirstName] nvarchar(10) NOT NULL
				, [Title] nvarchar(30) NULL
				, [TitleOfCourtesy] nvarchar(25) NULL
				, [BirthDate] datetime NULL
				, [HireDate] datetime NULL
				, [Address] nvarchar(60) NULL
				, [City] nvarchar(15) NULL
				, [Region] nvarchar(15) NULL
				, [PostalCode] nvarchar(10) NULL
				, [Country] nvarchar(15) NULL
				, [HomePhone] nvarchar(24) NULL
				, [Extension] nvarchar(4) NULL
				, [Photo] image NULL
				, [Notes] ntext NULL
				, [ReportsTo] int NULL
				, [PhotoPath] nvarchar(255) NULL
				, [DV_Load_Datetime] datetime2(7) NOT NULL
				, [DV_Deleted_Flag] bit NOT NULL
				, [DV_Record_Source] varchar(100) NOT NULL
				, [DV_Business_Key] varchar(20) NOT NULL
				, [HK_H_Employee] char(32) NOT NULL
				, [HK_H_Employee_Manager] char(32) NOT NULL
				, [HK_L_Employee_Reporting_Line] char(32) NOT NULL
				, [HD_S_HC_Employee_Northwind] char(32) NOT NULL
				, [HD_S_HT_Employee_Northwind] char(32) NOT NULL
				, [HD_S_LE_Employee_Reporting_Line_Northwind] char(32) NOT NULL
				, CONSTRAINT [PK_Northwind_Employees] PRIMARY KEY CLUSTERED ([EmployeeID] ASC)
			);

			-- Insert all existing records from source with metadata added
			INSERT INTO #TEMP_Northwind_Employees (
				  [EmployeeID]
				, [LastName]
				, [FirstName]
				, [Title]
				, [TitleOfCourtesy]
				, [BirthDate]
				, [HireDate]
				, [Address]
				, [City]
				, [Region]
				, [PostalCode]
				, [Country]
				, [HomePhone]
				, [Extension]
				, [Photo]
				, [Notes]
				, [ReportsTo]
				, [PhotoPath]
				, [DV_Load_Datetime]
				, [DV_Deleted_Flag]
				, [DV_Record_Source]
				, [DV_Business_Key]
				, [HK_H_Employee]
				, [HK_H_Employee_Manager]
				, [HK_L_Employee_Reporting_Line]
				, [HD_S_HC_Employee_Northwind]
				, [HD_S_HT_Employee_Northwind]
				, [HD_S_LE_Employee_Reporting_Line_Northwind]
			)
			SELECT
				  [EmployeeID]
				, [LastName]
				, [FirstName]
				, [Title]
				, [TitleOfCourtesy]
				, [BirthDate]
				, [HireDate]
				, [Address]
				, [City]
				, [Region]
				, [PostalCode]
				, [Country]
				, [HomePhone]
				, [Extension]
				, [Photo]
				, [Notes]
				, [ReportsTo]
				, [PhotoPath]
				, @DV_Load_Datetime AS [DV_Load_Datetime]
				, 0 AS [DV_Deleted_Flag]
				, 'Northwind.dbo.Employees' AS [DV_Record_Source]
				, CONVERT(varchar(20), [EmployeeID]) AS [DV_Business_Key]
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							  -- Business key
							, ISNULL(CONVERT(varchar(10), [EmployeeID]), '')
							)
						, 2
					)
				  ) AS [HK_H_Employee]
				, CASE
					WHEN [ReportsTo] IS NULL THEN REPLICATE('0', 32)  -- Use the zero key hash when FK not populated
					ELSE 
						UPPER(
							CONVERT(
								  char(32)
								, HASHBYTES(
									  'MD5'
									  -- FK to Suppliers
									, ISNULL(CONVERT(varchar(10), [ReportsTo]), '')
									)
								, 2
							)
						)
				  END AS [HK_H_Employee_Manager]
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							, CONCAT(
								  ISNULL([EmployeeID], ''), '|'
								, ISNULL([ReportsTo], '')
							  )
							)
						, 2
					)		
				  ) AS [HK_L_Employee_Reporting_Line]
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							, CONCAT(
								  -- Business key
								  ISNULL([EmployeeID], ''), '|'
								  -- Change detection fields
								, TRIM(ISNULL([LastName], '')), '|'
								, TRIM(ISNULL([FirstName], '')), '|'
								, TRIM(ISNULL([Title], '')), '|'
								, TRIM(ISNULL([TitleOfCourtesy], '')), '|'
								, ISNULL([BirthDate], ''), '|'
								, ISNULL([HireDate], ''), '|'
								, TRIM(ISNULL([Address], '')), '|'
								, TRIM(ISNULL([City], '')), '|'
								, TRIM(ISNULL([Region], '')), '|'
								, TRIM(ISNULL([PostalCode], '')), '|'
								, TRIM(ISNULL([Country], '')), '|'
								, TRIM(ISNULL([HomePhone], '')), '|'
								, TRIM(ISNULL([Extension], '')), '|'
								, COALESCE(CAST([Photo] AS varbinary(MAX)), ''), '|'
								, TRIM(ISNULL(CAST([Notes] AS nvarchar(MAX)), '')), '|'
								, TRIM(ISNULL([PhotoPath], ''))
							)
						  )
						, 2
					)
				  ) AS [HD_S_HC_Employee_Northwind]
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							, CONCAT(
								  -- Business key
								  ISNULL([EmployeeID], ''), '|'
								  -- Change detection fields
								, 0  -- DV_Deleted_Flag
							  )
							)
						, 2
					)
				  ) AS [HD_S_HT_Employee_Northwind]
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							, CONCAT(
								  ISNULL([EmployeeID], ''), '|'
								, ISNULL([ReportsTo], '')
							  )
							)
						, 2
					)		
				  ) AS [HD_S_LE_Employee_Reporting_Line_Northwind]
			FROM
				[Northwind].[dbo].[Employees];


			/* Merge existing data in the stage table with the incoming data in the temp table */

			MERGE
				[Stage_Area].[northwind].[Employees] AS t
			USING
				#TEMP_Northwind_Employees AS s
			ON
				s.[EmployeeID] = t.[EmployeeID]
			-- Insert
			WHEN NOT MATCHED BY TARGET THEN
				INSERT (
					  [EmployeeID]
					, [LastName]
					, [FirstName]
					, [Title]
					, [TitleOfCourtesy]
					, [BirthDate]
					, [HireDate]
					, [Address]
					, [City]
					, [Region]
					, [PostalCode]
					, [Country]
					, [HomePhone]
					, [Extension]
					, [Photo]
					, [Notes]
					, [ReportsTo]
					, [PhotoPath]
					, [DV_Load_Datetime]
					, [DV_Deleted_Flag]
					, [DV_Record_Source]
					, [DV_Business_Key]
					, [HK_H_Employee]
					, [HK_H_Employee_Manager]
					, [HK_L_Employee_Reporting_Line]
					, [HD_S_HC_Employee_Northwind]
					, [HD_S_HT_Employee_Northwind]
					, [HD_S_LE_Employee_Reporting_Line_Northwind]
				)
				VALUES (
					  s.[EmployeeID]
					, s.[LastName]
					, s.[FirstName]
					, s.[Title]
					, s.[TitleOfCourtesy]
					, s.[BirthDate]
					, s.[HireDate]
					, s.[Address]
					, s.[City]
					, s.[Region]
					, s.[PostalCode]
					, s.[Country]
					, s.[HomePhone]
					, s.[Extension]
					, s.[Photo]
					, s.[Notes]
					, s.[ReportsTo]
					, s.[PhotoPath]
					, s.[DV_Load_Datetime]
					, s.[DV_Deleted_Flag]
					, s.[DV_Record_Source]
					, s.[DV_Business_Key]
					, s.[HK_H_Employee]
					, s.[HK_H_Employee_Manager]
					, s.[HK_L_Employee_Reporting_Line]
					, s.[HD_S_HC_Employee_Northwind]
					, s.[HD_S_HT_Employee_Northwind]
					, s.[HD_S_LE_Employee_Reporting_Line_Northwind]
				)
			-- Update
			WHEN MATCHED THEN
				UPDATE SET
					  t.[EmployeeID] = s.[EmployeeID]
					, t.[LastName] = s.[LastName]
					, t.[FirstName] = s.[FirstName]
					, t.[Title] = s.[Title]
					, t.[TitleOfCourtesy] = s.[TitleOfCourtesy]
					, t.[BirthDate] = s.[BirthDate]
					, t.[HireDate] = s.[HireDate]
					, t.[Address] = s.[Address]
					, t.[City] = s.[City]
					, t.[Region] = s.[Region]
					, t.[PostalCode] = s.[PostalCode]
					, t.[Country] = s.[Country]
					, t.[HomePhone] = s.[HomePhone]
					, t.[Extension] = s.[Extension]
					, t.[Photo] = s.[Photo]
					, t.[Notes] = s.[Notes]
					, t.[ReportsTo] = s.[ReportsTo]
					, t.[PhotoPath] = s.[PhotoPath]
					, t.[DV_Load_Datetime] = s.[DV_Load_Datetime]
					, t.[DV_Deleted_Flag] = s.[DV_Deleted_Flag]
					, t.[DV_Record_Source] = s.[DV_Record_Source]
					, t.[DV_Business_Key] = s.[DV_Business_Key]
					, t.[HK_H_Employee] = s.[HK_H_Employee]
					, t.[HK_H_Employee_Manager] = s.[HK_H_Employee_Manager]
					, t.[HK_L_Employee_Reporting_Line] = s.[HK_L_Employee_Reporting_Line]
					, t.[HD_S_HC_Employee_Northwind] = s.[HD_S_HC_Employee_Northwind]
					, t.[HD_S_HT_Employee_Northwind] = s.[HD_S_HT_Employee_Northwind]
					, t.[HD_S_LE_Employee_Reporting_Line_Northwind] = s.[HD_S_LE_Employee_Reporting_Line_Northwind]
			-- Delete
			WHEN NOT MATCHED BY SOURCE AND t.[DV_Deleted_Flag] = 0 THEN
				UPDATE SET
					  t.[DV_Load_Datetime] = @DV_Load_Datetime
					, t.[DV_Deleted_Flag] = 1
					, t.[DV_Record_Source] = 'SYSTEM'
					, t.[HD_S_HT_Employee_Northwind] = UPPER(
						CONVERT(
							  char(32)
							, HASHBYTES(
								  'MD5'
								, CONCAT(
									  -- Business key
									  ISNULL(t.[EmployeeID], ''), '|'
									  -- Change detection fields
									, 1  -- DV_Deleted_Flag
								  )
								)
							, 2
						)
					  );


			-- Drop temp table
			DROP TABLE #TEMP_Northwind_Employees;

		END TRY
		BEGIN CATCH

			-- If error caught and uncomitted transactions then roll back transaction
			IF @@TRANCOUNT > 0  
				ROLLBACK TRANSACTION; 

			-- Insert error details to the error log table
			INSERT INTO 
				[Meta_Metrics_Error_Mart].[error].[Error_Log]
			VALUES (	
				  GETDATE()
				, ERROR_PROCEDURE()
				, ERROR_NUMBER()
				, ERROR_SEVERITY()
				, ERROR_STATE()
				, ERROR_LINE()
				, ERROR_MESSAGE()
			);

		END CATCH

		-- If TRY completes successfully, commit the transaction
		IF @@TRANCOUNT > 0  
			COMMIT TRANSACTION;  
	END
GO
/****** Object:  StoredProcedure [northwind].[usp_Load_Northwind_EmployeeTerritories]    Script Date: 5/01/2023 10:15:39 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [northwind].[usp_Load_Northwind_EmployeeTerritories] 
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			DECLARE @DV_Load_Datetime datetime2(7) = SYSDATETIME();

			/* Load incoming data into a temporary table with all hashes and metadata added */

			-- Create temporary table identical to the stage to hold the incoming records
			CREATE TABLE #TEMP_Northwind_EmployeeTerritories (
				  [EmployeeID] int NOT NULL
				, [TerritoryID] nvarchar(20) NOT NULL
				, [DV_Load_Datetime] datetime2(7) NOT NULL
				, [DV_Deleted_Flag] bit NOT NULL
				, [DV_Record_Source] varchar(100) NOT NULL
				, [DV_Business_Key] varchar(20) NOT NULL
				, [HK_H_Employee] char(32) NOT NULL
				, [HK_H_Territory] char(32) NOT NULL
				, [HK_L_Employee_Territory] char(32) NOT NULL
				, [HD_S_LT_Employee_Territory_Northwind] char(32) NOT NULL
				, CONSTRAINT [PK_TEMP_Northwind_EmployeeTerritories] PRIMARY KEY CLUSTERED (
					  [EmployeeID] ASC
					, [TerritoryID] ASC
				  )
			);

			-- Insert all existing records from source with metadata added
			INSERT INTO #TEMP_Northwind_EmployeeTerritories (
				  [EmployeeID]
				, [TerritoryID]
				, [DV_Load_Datetime]
				, [DV_Deleted_Flag]
				, [DV_Record_Source]
				, [DV_Business_Key]
				, [HK_H_Employee]
				, [HK_H_Territory]
				, [HK_L_Employee_Territory]
				, [HD_S_LT_Employee_Territory_Northwind]
			)
			SELECT
				  [EmployeeID]
				, [TerritoryID]
				, @DV_Load_Datetime AS DV_Load_Datetime
				, 0 AS DV_Deleted_Flag
				, 'Northwind.dbo.EmployeeTerritories' AS DV_Record_Source
				, CONCAT_WS(
					  '|'
					, [EmployeeID]
					, [TerritoryID]
				  ) AS DV_Business_Key
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							  -- Business key
							, ISNULL(CONVERT(varchar(10), [EmployeeID]), '')
						  )
						, 2
					)
				  ) AS HK_H_Employee
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							  -- Business key
							, ISNULL([TerritoryID], '')
						  )
						, 2
					)
				  ) AS HK_H_Territory
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							  -- Business key
							, CONCAT(
								  ISNULL([EmployeeID], ''), '|'
								, ISNULL([TerritoryID], '')
							)
						  )
						, 2
					)
				  ) AS HK_L_Employee_Territory
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							, CONCAT(
								  -- Business key
								  ISNULL([EmployeeID], ''), '|'
								, ISNULL([TerritoryID], ''), '|'
								  -- Change detection fields
								, 0  -- DV_Deleted_Flag
							  )
							)
						, 2
					)
				  ) AS HD_S_LT_Employee_Territory_Northwind
			FROM
				[Northwind].[dbo].[EmployeeTerritories];


			/* Merge existing data in the stage table with the incoming data in the temp table */

			MERGE
				[Stage_Area].[northwind].[EmployeeTerritories] AS t
			USING
				#TEMP_Northwind_EmployeeTerritories AS s
			ON
				s.[EmployeeID] = t.[EmployeeID]
				AND s.[TerritoryID] = t.[TerritoryID]
			-- Insert
			WHEN NOT MATCHED BY TARGET THEN 
				INSERT (
					  [EmployeeID]
					, [TerritoryID]
					, [DV_Load_Datetime]
					, [DV_Deleted_Flag]
					, [DV_Record_Source]
					, [DV_Business_Key]
					, [HK_H_Employee]
					, [HK_H_Territory]
					, [HK_L_Employee_Territory]
					, [HD_S_LT_Employee_Territory_Northwind]
				) 
				VALUES (
					  s.[EmployeeID]
					, s.[TerritoryID]
					, s.[DV_Load_Datetime]
					, s.[DV_Deleted_Flag]
					, s.[DV_Record_Source]
					, s.[DV_Business_Key]
					, s.[HK_H_Employee]
					, s.[HK_H_Territory]
					, s.[HK_L_Employee_Territory]
					, s.[HD_S_LT_Employee_Territory_Northwind]
				)
			-- Update
			WHEN MATCHED THEN 
				UPDATE SET
					  t.[EmployeeID] = s.[EmployeeID]
					, t.[TerritoryID] = s.[TerritoryID]
					, t.[DV_Load_Datetime] = s.[DV_Load_Datetime]
					, t.[DV_Deleted_Flag] = s.[DV_Deleted_Flag]
					, t.[DV_Record_Source] = s.[DV_Record_Source]
					, t.[DV_Business_Key] = s.[DV_Business_Key]
					, t.[HK_H_Employee] = s.[HK_H_Employee]
					, t.[HK_H_Territory] = s.[HK_H_Territory]
					, t.[HK_L_Employee_Territory] = s.[HK_L_Employee_Territory]
					, t.[HD_S_LT_Employee_Territory_Northwind] = s.[HD_S_LT_Employee_Territory_Northwind]
			-- Delete
			WHEN NOT MATCHED BY SOURCE AND t.[DV_Deleted_Flag] = 0 THEN 
				UPDATE SET
					  t.[DV_Load_Datetime] = @DV_Load_Datetime
					, t.[DV_Deleted_Flag] = 1
					, t.[DV_Record_Source] = 'SYSTEM'
					, t.[HD_S_LT_Employee_Territory_Northwind] = UPPER(
						CONVERT(
							  char(32)
							, HASHBYTES(
								  'MD5'
								, CONCAT(
									  -- Business key
									  ISNULL(t.[EmployeeID], ''), '|'
									, ISNULL(t.[TerritoryID], ''), '|'
									  -- Change detection fields
									, 1  -- DV_Deleted_Flag
								  )
								)
							, 2
						)
					  );

			-- Drop temp table
			DROP TABLE #TEMP_Northwind_EmployeeTerritories

		END TRY
		BEGIN CATCH

			-- If error caught and uncomitted transactions then roll back transaction
			IF @@TRANCOUNT > 0  
				ROLLBACK TRANSACTION; 

			-- Insert error details to the error log table
			INSERT INTO 
				[Meta_Metrics_Error_Mart].[error].[Error_Log]
			VALUES (	
				  GETDATE()
				, ERROR_PROCEDURE()
				, ERROR_NUMBER()
				, ERROR_SEVERITY()
				, ERROR_STATE()
				, ERROR_LINE()
				, ERROR_MESSAGE()
			);

		END CATCH

		-- If TRY completes successfully, commit the transaction
		IF @@TRANCOUNT > 0  
			COMMIT TRANSACTION;  

	END
GO
/****** Object:  StoredProcedure [northwind].[usp_Load_Northwind_Order_Details]    Script Date: 5/01/2023 10:15:39 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [northwind].[usp_Load_Northwind_Order_Details] 
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			DECLARE @DV_Load_Datetime datetime2(7) = SYSDATETIME();


			/* Load incoming data into a temporary table with all hashes and metadata added */

			-- Create temporary table identical to the stage to hold the incoming records
			CREATE TABLE #TEMP_Northwind_Order_Details (
				  [OrderID] int NOT NULL  -- Source PK & FK	
				, [ProductID] int NOT NULL  -- Source PK & FK	
				, [UnitPrice] money NOT NULL  	
				, [Quantity] smallint NOT NULL  	
				, [Discount] real NOT NULL  	
				, [DV_Load_Datetime] datetime2 NOT NULL  -- Datetime load procedure executed on the stage table	
				, [DV_Deleted_Flag] bit NOT NULL  -- A flag identifying records hard deleted in the source table	
				, [DV_Record_Source] varchar(100)  NOT NULL  -- Description identifying data source	
				, [DV_Business_Key] varchar(20) NOT NULL  -- Business key value	
				, [HK_H_Order] char(32) NOT NULL  -- H_Order hash key	
				, [HK_H_Order_Detail] char(32) NOT NULL  -- H_Order_Detail hash key	
				, [HK_H_Product] char(32) NOT NULL  -- H_Product hash key	
				, [HK_L_Order_Detail] char(32) NOT NULL  -- L_Order_Detail hash key	
				, [HD_S_HC_Order_Detail_Northwind] char(32) NOT NULL  -- S_HC_Order_Detail_Northwind
				, [HD_S_HT_Order_Detail_Northwind] char(32) NOT NULL  -- S_HT_Order_Detail_Northwind				
				, CONSTRAINT [PK_TEMP_Northwind_Order_Details] PRIMARY KEY CLUSTERED (
					  [OrderID] ASC
					, [ProductID] ASC
				)
			);

			-- Insert all existing records from source with metadata added
			INSERT INTO #TEMP_Northwind_Order_Details (
				  [OrderID]
				, [ProductID]
				, [UnitPrice]
				, [Quantity]
				, [Discount]
				, [DV_Load_Datetime]
				, [DV_Deleted_Flag]
				, [DV_Record_Source]
				, [DV_Business_Key]
				, [HK_H_Order]
				, [HK_H_Order_Detail]
				, [HK_H_Product]
				, [HK_L_Order_Detail]
				, [HD_S_HC_Order_Detail_Northwind]
				, [HD_S_HT_Order_Detail_Northwind]
			)
			SELECT
				  [OrderID]
				, [ProductID]
				, [UnitPrice]
				, [Quantity]
				, [Discount]
				, @DV_Load_Datetime AS DV_Load_Datetime
				, 0 AS DV_Deleted_Flag
				, 'Northwind.dbo.Order Details' AS DV_Record_Source
				, CONCAT(
					  [OrderID], '|'
					, [ProductID]
				  ) AS DV_Business_Key
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							  -- Business key
							, ISNULL(CONVERT(varchar(10), [OrderID]), '')
						  )
						, 2
					)
				  ) AS HK_H_Order
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							  -- Business key
							, CONCAT(
								  ISNULL([OrderID], ''), '|'
								, ISNULL([ProductID], '')
							  )
						  )
						, 2
					)
				  ) AS HK_H_Order_Detail
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							  -- Business key
							, ISNULL(CONVERT(varchar(10), [ProductID]), '')
						  )
						, 2
					)
				  ) AS HK_H_Product
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							  -- Business key
							, CONCAT(
								  ISNULL([OrderID], ''), '|'
								, ISNULL([ProductID], '')
							  )
						  )
						, 2
					)
				  ) AS HK_L_Order_Detail  -- Note identical to HK_H_Order_Detail
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							, CONCAT(
								  -- Business key
								  ISNULL([OrderID], ''), '|'
								, ISNULL([ProductID], ''), '|'
								  -- Change detection fields
								, ISNULL([UnitPrice], ''), '|'
								, ISNULL([Quantity], ''), '|'
								, ISNULL([Discount], '')
							  )
						  )
						, 2
					)
				  ) AS HD_S_HC_Order_Detail_Northwind
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							, CONCAT(
								  -- Business key
								  ISNULL([OrderID], ''), '|'
								, ISNULL([ProductID], ''), '|'
								  -- Change detection fields
								, 0  -- DV_Deleted_Flag
							  )
						  )
						, 2
					)
				  ) AS HD_S_HT_Order_Detail_Northwind
			FROM
				[Northwind].[dbo].[Order Details];


			/* Merge existing data in the stage table with the incoming data in the temp table */

			MERGE 
				[Stage_Area].[northwind].[Order Details] AS t 
			USING
				#TEMP_Northwind_Order_Details AS s
			ON
				s.[OrderID] = t.[OrderID]
				AND s.[ProductID] = t.[ProductID]
			-- Insert
			WHEN NOT MATCHED BY TARGET THEN 
				INSERT (
					  [OrderID]
					, [ProductID]
					, [UnitPrice]
					, [Quantity]
					, [Discount]
					, [DV_Load_Datetime]
					, [DV_Deleted_Flag]
					, [DV_Record_Source]
					, [DV_Business_Key]
					, [HK_H_Order]
					, [HK_H_Order_Detail]
					, [HK_H_Product]
					, [HK_L_Order_Detail]
					, [HD_S_HC_Order_Detail_Northwind]
					, [HD_S_HT_Order_Detail_Northwind]
				)
				VALUES (
					  s.[OrderID]
					, s.[ProductID]
					, s.[UnitPrice]
					, s.[Quantity]
					, s.[Discount]
					, s.[DV_Load_Datetime]
					, s.[DV_Deleted_Flag]
					, s.[DV_Record_Source]
					, s.[DV_Business_Key]
					, s.[HK_H_Order]
					, s.[HK_H_Order_Detail]
					, s.[HK_H_Product]
					, s.[HK_L_Order_Detail]
					, s.[HD_S_HC_Order_Detail_Northwind]
					, s.[HD_S_HT_Order_Detail_Northwind]
				)
			-- Update
			WHEN MATCHED THEN 
				UPDATE SET
					  t.[OrderID] = s.[OrderID]
					, t.[ProductID] = s.[ProductID]
					, t.[UnitPrice] = s.[UnitPrice]
					, t.[Quantity] = s.[Quantity]
					, t.[Discount] = s.[Discount]
					, t.[DV_Load_Datetime] = s.[DV_Load_Datetime]
					, t.[DV_Deleted_Flag] = s.[DV_Deleted_Flag]
					, t.[DV_Record_Source] = s.[DV_Record_Source]
					, t.[DV_Business_Key] = s.[DV_Business_Key]
					, t.[HK_H_Order] = s.[HK_H_Order]
					, t.[HK_H_Order_Detail] = s.[HK_H_Order_Detail]
					, t.[HK_H_Product] = s.[HK_H_Product]
					, t.[HK_L_Order_Detail] = s.[HK_L_Order_Detail]
					, t.[HD_S_HC_Order_Detail_Northwind] = s.[HD_S_HC_Order_Detail_Northwind]
					, t.[HD_S_HT_Order_Detail_Northwind] = s.[HD_S_HT_Order_Detail_Northwind]

			-- Delete
			WHEN NOT MATCHED BY SOURCE AND t.[DV_Deleted_Flag] = 0 THEN 
				UPDATE SET
					  t.[DV_Load_Datetime] = @DV_Load_Datetime
					, t.[DV_Deleted_Flag] = 1
					, t.[DV_Record_Source] = 'SYSTEM'
					, t.[HD_S_HT_Order_Detail_Northwind] = UPPER(
							CONVERT(
								  char(32)
								, HASHBYTES(
									  'MD5'
									, CONCAT(
										  -- Business key
										  ISNULL(t.[OrderID], ''), '|'
										, ISNULL(t.[ProductID], ''), '|'
										  -- Change detection fields
										, 1  -- DV_Deleted_Flag
									  )
								  )
								, 2
							)
						  );


			-- Drop temp table
			DROP TABLE #TEMP_Northwind_Order_Details;

		END TRY
		BEGIN CATCH

			-- If error caught and uncomitted transactions then roll back transaction
			IF @@TRANCOUNT > 0  
				ROLLBACK TRANSACTION; 

			-- Insert error details to the error log table
			INSERT INTO 
				[Meta_Metrics_Error_Mart].[error].[Error_Log]
			VALUES (	
				  GETDATE()
				, ERROR_PROCEDURE()
				, ERROR_NUMBER()
				, ERROR_SEVERITY()
				, ERROR_STATE()
				, ERROR_LINE()
				, ERROR_MESSAGE()
			);

		END CATCH

		-- If TRY completes successfully, commit the transaction
		IF @@TRANCOUNT > 0  
			COMMIT TRANSACTION;  

	END
GO
/****** Object:  StoredProcedure [northwind].[usp_Load_Northwind_Orders]    Script Date: 5/01/2023 10:15:39 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [northwind].[usp_Load_Northwind_Orders]
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			DECLARE @DV_Load_Datetime datetime2(7) = SYSDATETIME();


			/* Load incoming data into a temporary table with all hashes and metadata added */

			-- Create temporary table identical to the stage to hold the incoming records
			CREATE TABLE #TEMP_Northwind_Orders (
				  [OrderID] int NOT NULL
				, [CustomerID] nchar(5) NULL
				, [EmployeeID] int NULL
				, [OrderDate] datetime NULL
				, [RequiredDate] datetime NULL
				, [ShippedDate] datetime NULL
				, [ShipVia] int NULL
				, [Freight] money NULL
				, [ShipName] nvarchar(40) NULL
				, [ShipAddress] nvarchar(60) NULL
				, [ShipCity] nvarchar(15) NULL
				, [ShipRegion] nvarchar(15) NULL
				, [ShipPostalCode] nvarchar(10) NULL
				, [ShipCountry] nvarchar(15) NULL
				, [DV_Load_Datetime] datetime2(7) NOT NULL
				, [DV_Deleted_Flag] bit NOT NULL
				, [DV_Record_Source] varchar(100) NOT NULL
				, [DV_Business_Key] varchar(20) NOT NULL
				, [HK_H_Customer] char(32) NOT NULL
				, [HK_H_Employee] char(32) NOT NULL
				, [HK_H_Order] char(32) NOT NULL
				, [HK_H_Shipper] char(32) NOT NULL
				, [HK_L_Order_Header] char(32) NOT NULL
				, [HD_S_HC_Order_Northwind] char(32) NOT NULL
				, [HD_S_HT_Order_Northwind] char(32) NOT NULL
				, [HD_S_LE_Order_Header_Northwind] char(32) NOT NULL
				, CONSTRAINT [PK_TEMP_Northwind_Orders] PRIMARY KEY CLUSTERED ([OrderID] ASC)
			);


			-- Insert all existing records from source with metadata added
			INSERT INTO #TEMP_Northwind_Orders (
				  [OrderID]
				, [CustomerID]
				, [EmployeeID]
				, [OrderDate]
				, [RequiredDate]
				, [ShippedDate]
				, [ShipVia]
				, [Freight]
				, [ShipName]
				, [ShipAddress]
				, [ShipCity]
				, [ShipRegion]
				, [ShipPostalCode]
				, [ShipCountry]
				, [DV_Load_Datetime]
				, [DV_Deleted_Flag]
				, [DV_Record_Source]
				, [DV_Business_Key]
				, [HK_H_Customer]
				, [HK_H_Employee]
				, [HK_H_Order]
				, [HK_H_Shipper]
				, [HK_L_Order_Header]
				, [HD_S_HC_Order_Northwind]
				, [HD_S_HT_Order_Northwind]
				, [HD_S_LE_Order_Header_Northwind]
			)
			SELECT
				  [OrderID]
				, [CustomerID]
				, [EmployeeID]
				, [OrderDate]
				, [RequiredDate]
				, [ShippedDate]
				, [ShipVia]
				, [Freight]
				, [ShipName]
				, [ShipAddress]
				, [ShipCity]
				, [ShipRegion]
				, [ShipPostalCode]
				, [ShipCountry]
				, @DV_Load_Datetime AS DV_Load_Datetime
				, 0 AS DV_Deleted_Flag
				, 'Northwind.dbo.Orders' AS DV_Record_Source
				, CONVERT(varchar(20), [OrderID]) AS DV_Business_Key
				, CASE
					WHEN [CustomerID] IS NULL THEN REPLICATE('0', 32)  -- Use the zero key hash when FK not populated
					ELSE
						UPPER(
							CONVERT(
								  char(32)
								, HASHBYTES(
									  'MD5'
									  -- FK to H_Customer
									, ISNULL([CustomerID], '')
								  )
								, 2
							)
						)
				  END AS [HK_H_Customer]
				, CASE
					WHEN [EmployeeID] IS NULL THEN REPLICATE('0', 32)  -- Use the zero key hash when FK not populated
					ELSE
						UPPER(
							CONVERT(
								  char(32)
								, HASHBYTES(
									  'MD5'
									  -- FK to H_Employee
									, ISNULL(CONVERT(varchar(10), [EmployeeID]), '')
								  )
								, 2
							)
						)
				  END AS [HK_H_Employee]
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							  -- Business key
							, ISNULL(CONVERT(varchar(10), [OrderID]), '')
						  )
						, 2
					)
				  ) AS [HK_H_Order]
				, CASE
					WHEN [ShipVia] IS NULL THEN REPLICATE('0', 32)  -- Use the zero key hash when FK not populated
					ELSE
						UPPER(
							CONVERT(
								  char(32)
								, HASHBYTES(
									  'MD5'
									  -- FK to H_Shipper
									, ISNULL(CONVERT(varchar(10), [ShipVia]), '')
								  )
								, 2
							)
						)
				  END AS [HK_H_Shipper]
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							, CONCAT(
								  ISNULL([OrderID], ''), '|'
								, ISNULL([CustomerID], ''), '|'
								, ISNULL([EmployeeID], ''), '|'
								, ISNULL([ShipVia], '')
							)
						  )
						, 2
					)		
				  ) AS [HK_L_Order_Header]
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							, CONCAT(
								  -- Business key
								  ISNULL([OrderID], ''), '|'
								  -- Change detection fields
								, ISNULL([OrderDate], ''), '|'
								, ISNULL([RequiredDate], ''), '|'
								, ISNULL([ShippedDate], ''), '|'
								, ISNULL([Freight], ''), '|'
								, TRIM(ISNULL([ShipName], '')), '|'
								, TRIM(ISNULL([ShipAddress], '')), '|'
								, TRIM(ISNULL([ShipCity], '')), '|'
								, TRIM(ISNULL([ShipRegion], '')), '|'
								, TRIM(ISNULL([ShipPostalCode], '')), '|'
								, TRIM(ISNULL([ShipCountry], ''))
							  )
							)
						, 2
					)
				  ) AS [HD_S_HC_Order_Northwind]
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							, CONCAT(
								  -- Business key
								  ISNULL([OrderID], ''), '|'
								  -- Change detection fields
								, 0  -- DV_Deleted_Flag
							  )
						  )
						, 2
					)
				  ) AS [HD_S_HT_Order_Northwind]
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							, CONCAT(
								  ISNULL([OrderID], ''), '|'
								, ISNULL([CustomerID], ''), '|'
								, ISNULL([EmployeeID], ''), '|'
								, ISNULL([ShipVia], '')
							)
						  )
						, 2
					)		
				  ) AS [HD_S_LE_Order_Header_Northwind]  -- Matches Link hash key 
			FROM
				[Northwind].[dbo].[Orders];


			/* Merge existing data in the stage table with the incoming data in the temp table */

			MERGE 
				[Stage_Area].[northwind].[Orders] AS t 
			USING
				#TEMP_Northwind_Orders AS s
			ON
				t.[OrderID] = s.[OrderID]
			-- Insert
			WHEN NOT MATCHED BY TARGET THEN 
				INSERT (
					  [OrderID]
					, [CustomerID]
					, [EmployeeID]
					, [OrderDate]
					, [RequiredDate]
					, [ShippedDate]
					, [ShipVia]
					, [Freight]
					, [ShipName]
					, [ShipAddress]
					, [ShipCity]
					, [ShipRegion]
					, [ShipPostalCode]
					, [ShipCountry]
					, [DV_Load_Datetime]
					, [DV_Deleted_Flag]
					, [DV_Record_Source]
					, [DV_Business_Key]
					, [HK_H_Customer]
					, [HK_H_Employee]
					, [HK_H_Order]
					, [HK_H_Shipper]
					, [HK_L_Order_Header]
					, [HD_S_HC_Order_Northwind]
					, [HD_S_HT_Order_Northwind]
					, [HD_S_LE_Order_Header_Northwind]
				)
				VALUES (
					  s.[OrderID]
					, s.[CustomerID]
					, s.[EmployeeID]
					, s.[OrderDate]
					, s.[RequiredDate]
					, s.[ShippedDate]
					, s.[ShipVia]
					, s.[Freight]
					, s.[ShipName]
					, s.[ShipAddress]
					, s.[ShipCity]
					, s.[ShipRegion]
					, s.[ShipPostalCode]
					, s.[ShipCountry]
					, s.[DV_Load_Datetime]
					, s.[DV_Deleted_Flag]
					, s.[DV_Record_Source]
					, s.[DV_Business_Key]
					, s.[HK_H_Customer]
					, s.[HK_H_Employee]
					, s.[HK_H_Order]
					, s.[HK_H_Shipper]
					, s.[HK_L_Order_Header]
					, s.[HD_S_HC_Order_Northwind]
					, s.[HD_S_HT_Order_Northwind]
					, s.[HD_S_LE_Order_Header_Northwind]
				)
				-- Update
			WHEN MATCHED THEN 
				UPDATE SET
				  t.[OrderID] = s.[OrderID]
				, t.[CustomerID] = s.[CustomerID]
				, t.[EmployeeID] = s.[EmployeeID]
				, t.[OrderDate] = s.[OrderDate]
				, t.[RequiredDate] = s.[RequiredDate]
				, t.[ShippedDate] = s.[ShippedDate]
				, t.[ShipVia] = s.[ShipVia]
				, t.[Freight] = s.[Freight]
				, t.[ShipName] = s.[ShipName]
				, t.[ShipAddress] = s.[ShipAddress]
				, t.[ShipCity] = s.[ShipCity]
				, t.[ShipRegion] = s.[ShipRegion]
				, t.[ShipPostalCode] = s.[ShipPostalCode]
				, t.[ShipCountry] = s.[ShipCountry]
				, t.[DV_Load_Datetime] = s.[DV_Load_Datetime]
				, t.[DV_Deleted_Flag] = s.[DV_Deleted_Flag]
				, t.[DV_Record_Source] = s.[DV_Record_Source]
				, t.[DV_Business_Key] = s.[DV_Business_Key]
				, t.[HK_H_Customer] = s.[HK_H_Customer]
				, t.[HK_H_Employee] = s.[HK_H_Employee]
				, t.[HK_H_Order] = s.[HK_H_Order]
				, t.[HK_H_Shipper] = s.[HK_H_Shipper]
				, t.[HK_L_Order_Header] = s.[HK_L_Order_Header]
				, t.[HD_S_HC_Order_Northwind] = s.[HD_S_HC_Order_Northwind]
				, t.[HD_S_HT_Order_Northwind] = s.[HD_S_HT_Order_Northwind]
				, t.[HD_S_LE_Order_Header_Northwind] = s.[HD_S_LE_Order_Header_Northwind]
			-- Delete
			WHEN NOT MATCHED BY SOURCE AND t.[DV_Deleted_Flag] = 0 THEN 
				UPDATE SET
					  t.[DV_Load_Datetime] = @DV_Load_Datetime
					, t.[DV_Deleted_Flag] = 1
					, t.[DV_Record_Source] = 'SYSTEM'
					, t.[HD_S_HT_Order_Northwind] = UPPER(
						CONVERT(
							  char(32)
							, HASHBYTES(
								  'MD5'
								, CONCAT(
									  -- Business key
									  ISNULL(t.[OrderID], ''), '|'
									  -- Change detection fields
									, 1  -- DV_Deleted_Flag
								  )
							  )
							, 2
						)
					  );

			-- Drop temp table
			DROP TABLE #TEMP_Northwind_Orders;

		END TRY
		BEGIN CATCH

			-- If error caught and uncomitted transactions then roll back transaction
			IF @@TRANCOUNT > 0  
				ROLLBACK TRANSACTION; 

			-- Insert error details to the error log table
			INSERT INTO 
				[Meta_Metrics_Error_Mart].[error].[Error_Log]
			VALUES (	
				  GETDATE()
				, ERROR_PROCEDURE()
				, ERROR_NUMBER()
				, ERROR_SEVERITY()
				, ERROR_STATE()
				, ERROR_LINE()
				, ERROR_MESSAGE()
			);

		END CATCH

		-- If TRY completes successfully, commit the transaction
		IF @@TRANCOUNT > 0  
			COMMIT TRANSACTION;  

	END
GO
/****** Object:  StoredProcedure [northwind].[usp_Load_Northwind_Products]    Script Date: 5/01/2023 10:15:39 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [northwind].[usp_Load_Northwind_Products]
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			DECLARE @DV_Load_Datetime datetime2(7) = SYSDATETIME();


			/* Load incoming data into a temporary table with all hashes and metadata added */

			-- Create temporary table identical to the stage to hold the incoming records
			CREATE TABLE #TEMP_Northwind_Products (
				  [ProductID] int NOT NULL  -- Source PK	
				, [ProductName] nvarchar(40) NOT NULL  	
				, [SupplierID] int NULL  -- Source FK to Suppliers	
				, [CategoryID] int NULL  -- Source FK to Categories	
				, [QuantityPerUnit] nvarchar(20) NULL  	
				, [UnitPrice] money NULL  	
				, [UnitsInStock] smallint NULL  	
				, [UnitsOnOrder] smallint NULL  	
				, [ReorderLevel] smallint NULL  	
				, [Discontinued] bit NOT NULL  	
				, [DV_Load_Datetime] datetime2 NOT NULL  -- Datetime load procedure executed on the stage table	
				, [DV_Deleted_Flag] bit NOT NULL  -- A flag identifying records hard deleted in the source table	
				, [DV_Record_Source] varchar(100)  NOT NULL  -- Description identifying data source	
				, [DV_Business_Key] varchar(20) NOT NULL  -- Business key value
				, [HK_H_Product_Category] char(32) NOT NULL  -- H_Product_Category hash key
				, [HK_H_Product] char(32) NOT NULL  -- H_Product hash key	
				, [HK_H_Supplier] char(32) NOT NULL  -- H_Supplier hash key	
				, [HK_L_Product_Category] char(32) NOT NULL  -- L_Product_Category hash key			
				, [HK_L_Product_Supplier] char(32) NOT NULL  -- L_Product_Supplier hash key	
				, [HD_S_HC_Product_Northwind] char(32) NOT NULL  -- S_Product_Northwind hash diff	
				, [HD_S_HT_Product_Northwind] char(32) NOT NULL  -- S_HT_Product_Northwind hash diff	
				, [HD_S_LE_Product_Category_Northwind] char(32) NOT NULL  -- S_DKE_Product_Category hash key	
				, [HD_S_LE_Product_Supplier_Northwind] char(32) NOT NULL  -- S_DKE_Product_Supplier hash key	
				, CONSTRAINT [PK_TEMP_Northwind_Products] PRIMARY KEY CLUSTERED ([ProductID])
			);

			-- Insert all existing records from source with metadata added
			INSERT INTO #TEMP_Northwind_Products (
				  [ProductID]
				, [ProductName]
				, [SupplierID]
				, [CategoryID]
				, [QuantityPerUnit]
				, [UnitPrice]
				, [UnitsInStock]
				, [UnitsOnOrder]
				, [ReorderLevel]
				, [Discontinued]
				, [DV_Load_Datetime]
				, [DV_Deleted_Flag]
				, [DV_Record_Source]
				, [DV_Business_Key]
				, [HK_H_Product_Category]
				, [HK_H_Product]
				, [HK_H_Supplier]
				, [HK_L_Product_Category]
				, [HK_L_Product_Supplier]
				, [HD_S_HC_Product_Northwind]
				, [HD_S_HT_Product_Northwind]
				, [HD_S_LE_Product_Category_Northwind]
				, [HD_S_LE_Product_Supplier_Northwind]
			)
			SELECT
				  [ProductID]
				, [ProductName]
				, [SupplierID]
				, [CategoryID]
				, [QuantityPerUnit]
				, [UnitPrice]
				, [UnitsInStock]
				, [UnitsOnOrder]
				, [ReorderLevel]
				, [Discontinued]
				, @DV_Load_Datetime AS DV_Load_Datetime
				, 0 AS DV_Deleted_Flag
				, 'Northwind.dbo.Products' AS DV_Record_Source
				, CONVERT(varchar(20), [ProductID]) AS DV_Business_Key
				, CASE
					WHEN [CategoryID] IS NULL THEN REPLICATE('0', 32)  -- Use the zero key hash when FK not populated
					ELSE
						UPPER(
							CONVERT(
								  char(32)
								, HASHBYTES(
									  'MD5'
									  -- FK to Categories
									, ISNULL(CONVERT(varchar(10), [CategoryID]), '')
								)
								, 2
							)
						)
				  END AS HK_H_Product_Category
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							  -- Business key
							, ISNULL(CONVERT(varchar(10), [ProductID]), '')
						  )
						, 2
					)
				  ) AS HK_H_Product
				, CASE
					WHEN [SupplierID] IS NULL THEN REPLICATE('0', 32)  -- Use the zero key hash when FK not populated
					ELSE 
						UPPER(
							CONVERT(
								  char(32)
								, HASHBYTES(
									  'MD5'
									  -- FK to Suppliers
									, ISNULL(CONVERT(varchar(10), [SupplierID]), '')
								  )
								, 2
							)
						)
				  END AS HK_H_Supplier
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							, CONCAT(
								  ISNULL([ProductID], ''), '|'
								, ISNULL([CategoryID], '')
							  )
						  )
						, 2
					)		
				  ) AS HK_L_Product_Category
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							, CONCAT(
								  ISNULL([ProductID], ''), '|'
								, ISNULL([SupplierID], '')
							  )
						  )
						, 2
					)		
				  ) AS HK_L_Product_Supplier
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							, CONCAT(
								  -- Business key
								  ISNULL([ProductID], ''), '|'
								  -- Change detection fields
								, TRIM(ISNULL([ProductName], '')), '|'
								, TRIM(ISNULL([QuantityPerUnit], '')), '|'
								, ISNULL([UnitPrice], ''), '|'
								, ISNULL([UnitsInStock], ''), '|'
								, ISNULL([UnitsOnOrder], ''), '|'
								, ISNULL([ReorderLevel], ''), '|'
								, ISNULL([Discontinued], '')
							  )
						  )
						, 2
					)
				  ) AS HD_S_HC_Product_Northwind
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							'MD5'
							, CONCAT(
								  -- Business key
								  ISNULL([ProductID], ''), '|'
								  -- Change detection fields
								, 0  -- DV_Deleted_Flag
							  )
						  )
						, 2
					)
				  ) AS HD_S_HT_Product_Northwind
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							, CONCAT(
								  ISNULL([ProductID], ''), '|'
								, ISNULL([CategoryID], '')
							  )
						  )
						, 2
					)		
				  ) AS HD_S_LE_Product_Category_Northwind  -- Matches link hash key
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							, CONCAT(
								  ISNULL([ProductID], ''), '|'
								, ISNULL([SupplierID], '')
							  )
						  )
						, 2
					)		
				  ) AS HD_S_LE_Product_Supplier_Northwind  -- Matches link hash key
			FROM
				[Northwind].[dbo].[Products];


			/* Merge existing data in the stage table with the incoming data in the temp table */

			MERGE 
				[Stage_Area].[northwind].[Products] AS t 
			USING
				#TEMP_Northwind_Products AS s
			ON
				s.[ProductID] = t.[ProductID]
			-- Insert
			WHEN NOT MATCHED BY TARGET THEN 
				INSERT (
					  [ProductID]
					, [ProductName]
					, [SupplierID]
					, [CategoryID]
					, [QuantityPerUnit]
					, [UnitPrice]
					, [UnitsInStock]
					, [UnitsOnOrder]
					, [ReorderLevel]
					, [Discontinued]
					, [DV_Load_Datetime]
					, [DV_Deleted_Flag]
					, [DV_Record_Source]
					, [DV_Business_Key]
					, [HK_H_Product_Category]
					, [HK_H_Product]
					, [HK_H_Supplier]
					, [HK_L_Product_Category]
					, [HK_L_Product_Supplier]
					, [HD_S_HC_Product_Northwind]
					, [HD_S_HT_Product_Northwind]
					, [HD_S_LE_Product_Category_Northwind]
					, [HD_S_LE_Product_Supplier_Northwind]
				) 
				VALUES (
					  s.[ProductID]
					, s.[ProductName]
					, s.[SupplierID]
					, s.[CategoryID]
					, s.[QuantityPerUnit]
					, s.[UnitPrice]
					, s.[UnitsInStock]
					, s.[UnitsOnOrder]
					, s.[ReorderLevel]
					, s.[Discontinued]
					, s.[DV_Load_Datetime]
					, s.[DV_Deleted_Flag]
					, s.[DV_Record_Source]
					, s.[DV_Business_Key]
					, s.[HK_H_Product_Category]
					, s.[HK_H_Product]
					, s.[HK_H_Supplier]
					, s.[HK_L_Product_Category]
					, s.[HK_L_Product_Supplier]
					, s.[HD_S_HC_Product_Northwind]
					, s.[HD_S_HT_Product_Northwind]
					, s.[HD_S_LE_Product_Category_Northwind]
					, s.[HD_S_LE_Product_Supplier_Northwind]
				)
			-- Update
			WHEN MATCHED THEN 
				UPDATE SET
					  t.[ProductID] = s.[ProductID] 
					, t.[ProductName] = s.[ProductName] 
					, t.[SupplierID] = s.[SupplierID] 
					, t.[CategoryID] = s.[CategoryID] 
					, t.[QuantityPerUnit] = s.[QuantityPerUnit] 
					, t.[UnitPrice] = s.[UnitPrice] 
					, t.[UnitsInStock] = s.[UnitsInStock] 
					, t.[UnitsOnOrder] = s.[UnitsOnOrder] 
					, t.[ReorderLevel] = s.[ReorderLevel] 
					, t.[Discontinued] = s.[Discontinued] 
					, t.[DV_Load_Datetime] = s.[DV_Load_Datetime] 
					, t.[DV_Deleted_Flag] = s.[DV_Deleted_Flag] 
					, t.[DV_Record_Source] = s.[DV_Record_Source] 
					, t.[DV_Business_Key] = s.[DV_Business_Key]
					, t.[HK_H_Product_Category] = s.[HK_H_Product_Category] 
					, t.[HK_H_Product] = s.[HK_H_Product] 
					, t.[HK_H_Supplier] = s.[HK_H_Supplier]
					, t.[HK_L_Product_Category] = s.[HK_L_Product_Category] 
					, t.[HK_L_Product_Supplier] = s.[HK_L_Product_Supplier] 
					, t.[HD_S_HC_Product_Northwind] = s.[HD_S_HC_Product_Northwind] 
					, t.[HD_S_HT_Product_Northwind] = s.[HD_S_HT_Product_Northwind] 
					, t.[HD_S_LE_Product_Category_Northwind] = s.[HD_S_LE_Product_Category_Northwind] 
					, t.[HD_S_LE_Product_Supplier_Northwind] = s.[HD_S_LE_Product_Supplier_Northwind] 
			-- Delete
			WHEN NOT MATCHED BY SOURCE AND t.[DV_Deleted_Flag] = 0 THEN 
				UPDATE SET
					  t.[DV_Load_Datetime] = @DV_Load_Datetime
					, t.[DV_Deleted_Flag] = 1
					, t.[DV_Record_Source] = 'SYSTEM'
					, t.[HD_S_HT_Product_Northwind] = UPPER(
						CONVERT(
							  char(32)
							, HASHBYTES(
								  'MD5'
								, CONCAT(
									  -- Business key
									  ISNULL(t.[ProductID], ''), '|'
									  -- Change detection fields
									, 1  -- DV_Deleted_Flag
								  )
							  )
							, 2
						)
					  );


			-- Drop temp table
			DROP TABLE #TEMP_Northwind_Products;

		END TRY
		BEGIN CATCH

			-- If error caught and uncomitted transactions then roll back transaction
			IF @@TRANCOUNT > 0  
				ROLLBACK TRANSACTION; 

			-- Insert error details to the error log table
			INSERT INTO 
				[Meta_Metrics_Error_Mart].[error].[Error_Log]
			VALUES (	
				  GETDATE()
				, ERROR_PROCEDURE()
				, ERROR_NUMBER()
				, ERROR_SEVERITY()
				, ERROR_STATE()
				, ERROR_LINE()
				, ERROR_MESSAGE()
			);

		END CATCH

		-- If TRY completes successfully, commit the transaction
		IF @@TRANCOUNT > 0  
			COMMIT TRANSACTION;  

	END
GO
/****** Object:  StoredProcedure [northwind].[usp_Load_Northwind_Region]    Script Date: 5/01/2023 10:15:39 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [northwind].[usp_Load_Northwind_Region] 
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			DECLARE @DV_Load_Datetime datetime2(7) = SYSDATETIME();

			/* Load incoming data into a temporary table with all hashes and metadata added */

			-- Create temporary table identical to the stage to hold the incoming records
			CREATE TABLE #TEMP_Northwind_Region (
				  [RegionID] int NOT NULL
				, [RegionDescription] nchar(50) NOT NULL
				, [DV_Load_Datetime] datetime2(7) NOT NULL
				, [DV_Deleted_Flag] bit NOT NULL
				, [DV_Record_Source] varchar(100) NOT NULL
				, [DV_Business_Key] varchar(20) NOT NULL
				, [HK_H_Region] char(32) NOT NULL
				, [HD_S_HC_Region_Northwind] char(32) NOT NULL
				, [HD_S_HT_Region_Northwind] char(32) NOT NULL
				, CONSTRAINT [PK_TEMP_Northwind_Region] PRIMARY KEY CLUSTERED ([RegionID])
			);

			-- Insert all existing records from source with metadata added
			INSERT INTO #TEMP_Northwind_Region (
				  [RegionID]
				, [RegionDescription]
				, [DV_Load_Datetime]
				, [DV_Deleted_Flag]
				, [DV_Record_Source]
				, [DV_Business_Key]
				, [HK_H_Region]
				, [HD_S_HC_Region_Northwind]
				, [HD_S_HT_Region_Northwind]
			)
			SELECT
				  [RegionID]
				, [RegionDescription]
				, @DV_Load_Datetime AS DV_Load_Datetime
				, 0 AS DV_Deleted_Flag
				, 'Northwind.dbo.Region' AS DV_Record_Source
				, CONVERT(varchar(20), [RegionID]) AS DV_Business_Key
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							  -- Business key
							, ISNULL(CONVERT(varchar(10), [RegionID]), '')
						  )
						, 2
					)
				  ) AS HK_H_Region
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							, CONCAT(
								  -- Business key
								  ISNULL([RegionID], ''), '|'
								  -- Change detection fields
								, TRIM(ISNULL([RegionDescription], ''))
							  )
							)
						, 2
					)
				  ) AS HD_S_HC_Region_Northwind
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							, CONCAT(
								  -- Business key
								  ISNULL([RegionID], ''), '|'
								  -- Change detection fields
								, 0  -- DV_Deleted_Flag
							  )
						  )
						, 2
					)
				  ) AS HD_S_HT_Region_Northwind
			FROM
				[Northwind].[dbo].[Region];


			/* Merge existing data in the stage table with the incoming data in the temp table */

			MERGE 
				[Stage_Area].[northwind].[Region] AS t 
			USING
				#TEMP_Northwind_Region AS s
			ON
				t.[RegionID] = s.[RegionID]
			-- Insert
			WHEN NOT MATCHED BY TARGET THEN
				INSERT (
					  [RegionID]
					, [RegionDescription]
					, [DV_Load_Datetime]
					, [DV_Deleted_Flag]
					, [DV_Record_Source]
					, [DV_Business_Key]
					, [HK_H_Region]
					, [HD_S_HC_Region_Northwind]
					, [HD_S_HT_Region_Northwind]
				)
				VALUES (
					  s.[RegionID]
					, s.[RegionDescription]
					, s.[DV_Load_Datetime]
					, s.[DV_Deleted_Flag]
					, s.[DV_Record_Source]
					, s.[DV_Business_Key]
					, s.[HK_H_Region]
					, s.[HD_S_HC_Region_Northwind]
					, s.[HD_S_HT_Region_Northwind]
				)
			-- Update
			WHEN MATCHED THEN 
				UPDATE SET
					  t.[RegionID] = s.[RegionID]
					, t.[RegionDescription] = s.[RegionDescription]
					, t.[DV_Load_Datetime] = s.[DV_Load_Datetime]
					, t.[DV_Deleted_Flag] = s.[DV_Deleted_Flag]
					, t.[DV_Record_Source] = s.[DV_Record_Source]
					, t.[DV_Business_Key] = s.[DV_Business_Key]
					, t.[HK_H_Region] = s.[HK_H_Region]
					, t.[HD_S_HC_Region_Northwind] = s.[HD_S_HC_Region_Northwind]
					, t.[HD_S_HT_Region_Northwind] = s.[HD_S_HT_Region_Northwind]
			-- Delete
			WHEN NOT MATCHED BY SOURCE AND t.[DV_Deleted_Flag] = 0 THEN 
				UPDATE SET
					  t.[DV_Load_Datetime] = @DV_Load_Datetime
					, t.[DV_Deleted_Flag] = 1
					, t.[DV_Record_Source] = 'SYSTEM'
					, t.[HD_S_HT_Region_Northwind] = UPPER(
						CONVERT(
							  char(32)
							, HASHBYTES(
								  'MD5'
								, CONCAT(
									  -- Business key
									  ISNULL(t.[RegionID], ''), '|'
									  -- Change detection fields
									, 1  -- DV_Deleted_Flag
								  )
							  )
							, 2
						)
					  );

			-- Drop temp table
			DROP TABLE #TEMP_Northwind_Region;

		END TRY
		BEGIN CATCH

			-- If error caught and uncomitted transactions then roll back transaction
			IF @@TRANCOUNT > 0  
				ROLLBACK TRANSACTION; 

			-- Insert error details to the error log table
			INSERT INTO 
				[Meta_Metrics_Error_Mart].[error].[Error_Log]
			VALUES (	
				  GETDATE()
				, ERROR_PROCEDURE()
				, ERROR_NUMBER()
				, ERROR_SEVERITY()
				, ERROR_STATE()
				, ERROR_LINE()
				, ERROR_MESSAGE()
			);

		END CATCH

		-- If TRY completes successfully, commit the transaction
		IF @@TRANCOUNT > 0  
			COMMIT TRANSACTION;  
	END
GO
/****** Object:  StoredProcedure [northwind].[usp_Load_Northwind_Shippers]    Script Date: 5/01/2023 10:15:39 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [northwind].[usp_Load_Northwind_Shippers] 
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			DECLARE @DV_Load_Datetime datetime2(7) = SYSDATETIME();

			/* Load incoming data into a temporary table with all hashes and metadata added */

			-- Create temporary table identical to the stage to hold the incoming records
			CREATE TABLE #TEMP_Northwind_Shippers (
				  [ShipperID] int NOT NULL
				, [CompanyName] nvarchar(40) NOT NULL
				, [Phone] nvarchar(24) NULL
				, [DV_Load_Datetime] datetime2(7) NOT NULL
				, [DV_Deleted_Flag] bit NOT NULL
				, [DV_Record_Source] varchar(100) NOT NULL
				, [DV_Business_Key] varchar(20) NOT NULL
				, [HK_H_Shipper] char(32) NOT NULL
				, [HD_S_HC_Shipper_Northwind] char(32) NOT NULL
				, [HD_S_HT_Shipper_Northwind] char(32) NOT NULL
				, CONSTRAINT [PK_TEMP_Northwind_Shippers] PRIMARY KEY CLUSTERED ([ShipperID])
			);

			-- Insert all existing records from source with metadata added
			INSERT INTO #TEMP_Northwind_Shippers (
				  [ShipperID]
				, [CompanyName]
				, [Phone]
				, [DV_Load_Datetime]
				, [DV_Deleted_Flag]
				, [DV_Record_Source]
				, [DV_Business_Key]
				, [HK_H_Shipper]
				, [HD_S_HC_Shipper_Northwind]
				, [HD_S_HT_Shipper_Northwind]
			)
			SELECT
				  [ShipperID]
				, [CompanyName]
				, [Phone]
				, @DV_Load_Datetime AS DV_Load_Datetime
				, 0 AS DV_Deleted_Flag
				, 'Northwind.dbo.Shippers' AS DV_Record_Source
				, CONVERT(varchar(20), [ShipperID]) AS DV_Business_Key
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							  -- Business key
							, ISNULL(CONVERT(varchar(10), [ShipperID]), '')
						  )
						, 2
					)
				  ) AS HK_H_Shipper
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							, CONCAT(
								  -- Business key
								  ISNULL([ShipperID], ''), '|'
								  -- Change detection fields
								, TRIM(ISNULL([CompanyName], '')), '|'
								, TRIM(ISNULL([Phone], ''))
							  )
						  )
						, 2
					)
				  ) AS HD_S_HC_Shipper_Northwind
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							, CONCAT(
								  -- Business key
								  ISNULL([ShipperID], ''), '|'
								  -- Change detection fields
								, 0  -- DV_Deleted_Flag
							  )
						  )
						, 2
					)
				  ) AS HD_S_HT_Shipper_Northwind
			FROM
				[Northwind].[dbo].[Shippers];


			/* Merge existing data in the stage table with the incoming data in the temp table */

			MERGE 
				[Stage_Area].[northwind].[Shippers] AS t 
			USING
				#TEMP_Northwind_Shippers AS s
			ON
				s.[ShipperID] = t.[ShipperID]
			-- Insert
			WHEN NOT MATCHED BY TARGET THEN 
				INSERT (
					  [ShipperID]
					, [CompanyName]
					, [Phone]
					, [DV_Load_Datetime]
					, [DV_Deleted_Flag]
					, [DV_Record_Source]
					, [DV_Business_Key]
					, [HK_H_Shipper]
					, [HD_S_HC_Shipper_Northwind]
					, [HD_S_HT_Shipper_Northwind]
				) 
				VALUES (
					  s.[ShipperID]
					, s.[CompanyName]
					, s.[Phone]
					, s.[DV_Load_Datetime]
					, s.[DV_Deleted_Flag]
					, s.[DV_Record_Source]
					, s.[DV_Business_Key]
					, s.[HK_H_Shipper]
					, s.[HD_S_HC_Shipper_Northwind]
					, s.[HD_S_HT_Shipper_Northwind]
				)
			-- Update
			WHEN MATCHED THEN 
				UPDATE SET
					  t.[ShipperID] = s.[ShipperID]
					, t.[CompanyName] = s.[CompanyName]
					, t.[Phone] = s.[Phone]
					, t.[DV_Load_Datetime] = s.[DV_Load_Datetime]
					, t.[DV_Deleted_Flag] = s.[DV_Deleted_Flag]
					, t.[DV_Record_Source] = s.[DV_Record_Source]
					, t.[DV_Business_Key] = s.[DV_Business_Key]
					, t.[HK_H_Shipper] = s.[HK_H_Shipper]
					, t.[HD_S_HC_Shipper_Northwind] = s.[HD_S_HC_Shipper_Northwind]
					, t.[HD_S_HT_Shipper_Northwind] = s.[HD_S_HT_Shipper_Northwind]
			-- Delete
			WHEN NOT MATCHED BY SOURCE AND t.[DV_Deleted_Flag] = 0 THEN 
				UPDATE SET
					  t.[DV_Load_Datetime] = @DV_Load_Datetime
					, t.[DV_Deleted_Flag] = 1
					, t.[DV_Record_Source] = 'SYSTEM'
					, t.[HD_S_HT_Shipper_Northwind] = UPPER(
							CONVERT(
								  char(32)
								, HASHBYTES(
									  'MD5'
									, CONCAT(
										  -- Business key
										  ISNULL(t.[ShipperID], ''), '|'
										  -- Change detection fields
										, 1  -- DV_Deleted_Flag
									  )
								  )
								, 2
							)
						  );


			-- Drop temp table
			DROP TABLE #TEMP_Northwind_Shippers;

		END TRY
		BEGIN CATCH

			-- If error caught and uncomitted transactions then roll back transaction
			IF @@TRANCOUNT > 0  
				ROLLBACK TRANSACTION; 

			-- Insert error details to the error log table
			INSERT INTO 
				[Meta_Metrics_Error_Mart].[error].[Error_Log]
			VALUES (	
				  GETDATE()
				, ERROR_PROCEDURE()
				, ERROR_NUMBER()
				, ERROR_SEVERITY()
				, ERROR_STATE()
				, ERROR_LINE()
				, ERROR_MESSAGE()
			);

		END CATCH

		-- If TRY completes successfully, commit the transaction
		IF @@TRANCOUNT > 0  
			COMMIT TRANSACTION;  
	END
GO
/****** Object:  StoredProcedure [northwind].[usp_Load_Northwind_Suppliers]    Script Date: 5/01/2023 10:15:39 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [northwind].[usp_Load_Northwind_Suppliers] 
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			DECLARE @DV_Load_Datetime datetime2(7) = SYSDATETIME();


			/* Load incoming data into a temporary table with all hashes and metadata added */

			-- Create temporary table identical to the stage to hold the incoming records
			CREATE TABLE #TEMP_Northwind_Suppliers (
				  [SupplierID] int NOT NULL  -- Source PK
				, [CompanyName] nvarchar(40) NOT NULL  
				, [ContactName] nvarchar(30) NULL  
				, [ContactTitle] nvarchar(30) NULL  
				, [Address] nvarchar(60) NULL  
				, [City] nvarchar(15) NULL  
				, [Region] nvarchar(15) NULL  
				, [PostalCode] nvarchar(10) NULL  
				, [Country] nvarchar(15) NULL  
				, [Phone] nvarchar(24) NULL  
				, [Fax] nvarchar(24) NULL  
				, [HomePage] nvarchar(max) NULL  -- ntext data type deprecated. Use nvarchar(max)
				, [DV_Load_Datetime] datetime2 NOT NULL  -- Datetime load procedure executed on the stage table
				, [DV_Deleted_Flag] bit NOT NULL  -- A flag identifying records hard deleted in the source table
				, [DV_Record_Source] varchar(100) NOT NULL  -- Description identifying data source
				, [DV_Business_Key] varchar(20) NOT NULL  -- Business key value
				, [HK_H_Supplier] char(32) NOT NULL  -- H_Supplier hash key
				, [HD_S_HC_Supplier_Northwind] char(32) NOT NULL  -- S_HC_Supplier_Northwind hash diff
				, [HD_S_HT_Supplier_Northwind] char(32) NOT NULL  -- S_HT_Supplier_Northwind hash diff
				, CONSTRAINT [PK_TEMP_Northwind_Suppliers] PRIMARY KEY CLUSTERED ([SupplierID])
			);

			-- Insert all existing records from source with metadata added
			INSERT INTO #TEMP_Northwind_Suppliers (
				  [SupplierID]
				, [CompanyName]
				, [ContactName]
				, [ContactTitle]
				, [Address]
				, [City]
				, [Region]
				, [PostalCode]
				, [Country]
				, [Phone]
				, [Fax]
				, [HomePage]
				, [DV_Load_Datetime]
				, [DV_Deleted_Flag]
				, [DV_Record_Source]
				, [DV_Business_Key]
				, [HK_H_Supplier]
				, [HD_S_HC_Supplier_Northwind]
				, [HD_S_HT_Supplier_Northwind]
			)
			SELECT
				  [SupplierID]
				, [CompanyName]
				, [ContactName]
				, [ContactTitle]
				, [Address]
				, [City]
				, [Region]
				, [PostalCode]
				, [Country]
				, [Phone]
				, [Fax]
				, [HomePage]
				, @DV_Load_Datetime AS DV_Load_Datetime
				, 0 AS DV_Deleted_Flag
				, 'Northwind.dbo.Suppliers' AS DV_Record_Source
				, CONVERT(varchar(20), [SupplierID]) AS DV_Business_Key
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							  -- Business key
							, ISNULL(CONVERT(varchar(10), [SupplierID]), '')
						  )
						, 2
					)
				  ) AS HK_H_Supplier
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							, CONCAT(
								  -- Business key
								  ISNULL([SupplierID], ''), '|'
								  -- Change detection fields
								, TRIM(ISNULL([CompanyName], '')), '|'
								, TRIM(ISNULL([ContactName], '')), '|'
								, TRIM(ISNULL([ContactTitle], '')), '|'
								, TRIM(ISNULL([Address], '')), '|'
								, TRIM(ISNULL([City], '')), '|'
								, TRIM(ISNULL([Region], '')), '|'
								, TRIM(ISNULL([PostalCode], '')), '|'
								, TRIM(ISNULL([Country], '')), '|'
								, TRIM(ISNULL([Phone], '')), '|'
								, TRIM(ISNULL([Fax], '')), '|'
								, TRIM(ISNULL(CAST([HomePage] AS nvarchar(max)), ''))  -- ntext deprecated. Use nvarchar(max)
							  )
						  )
						, 2
					)
				  ) AS HD_S_HC_Supplier_Northwind
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							, CONCAT(
								  -- Business key
								  ISNULL([SupplierID], ''), '|'
								  -- Change detection fields
								, 0  -- DV_Deleted_Flag
							  )
						  )
						, 2
					)
				  ) AS HD_S_HT_Supplier_Northwind
			FROM
				[Northwind].[dbo].[Suppliers];


			/* Merge existing data in the stage table with the incoming data in the temp table */

			MERGE 
				[Stage_Area].[northwind].[Suppliers] AS t 
			USING
				#TEMP_Northwind_Suppliers AS s
			ON
				s.[SupplierID] = t.[SupplierID]
			-- Insert
			WHEN NOT MATCHED BY TARGET THEN 
				INSERT (
					  [SupplierID]
					, [CompanyName]
					, [ContactName]
					, [ContactTitle]
					, [Address]
					, [City]
					, [Region]
					, [PostalCode]
					, [Country]
					, [Phone]
					, [Fax]
					, [HomePage]
					, [DV_Load_Datetime]
					, [DV_Deleted_Flag]
					, [DV_Record_Source]
					, [DV_Business_Key]
					, [HK_H_Supplier]
					, [HD_S_HC_Supplier_Northwind]
					, [HD_S_HT_Supplier_Northwind]
				) 
				VALUES (
					  s.[SupplierID]
					, s.[CompanyName]
					, s.[ContactName]
					, s.[ContactTitle]
					, s.[Address]
					, s.[City]
					, s.[Region]
					, s.[PostalCode]
					, s.[Country]
					, s.[Phone]
					, s.[Fax]
					, s.[HomePage]
					, s.[DV_Load_Datetime]
					, s.[DV_Deleted_Flag]
					, s.[DV_Record_Source]
					, s.[DV_Business_Key]
					, s.[HK_H_Supplier]
					, s.[HD_S_HC_Supplier_Northwind]
					, s.[HD_S_HT_Supplier_Northwind]
				)
			-- Update
			WHEN MATCHED THEN 
				UPDATE SET
					  t.[SupplierID] = s.[SupplierID]
					, t.[CompanyName] = s.[CompanyName]
					, t.[ContactName] = s.[ContactName]
					, t.[ContactTitle] = s.[ContactTitle]
					, t.[Address] = s.[Address]
					, t.[City] = s.[City]
					, t.[Region] = s.[Region]
					, t.[PostalCode] = s.[PostalCode]
					, t.[Country] = s.[Country]
					, t.[Phone] = s.[Phone]
					, t.[Fax] = s.[Fax]
					, t.[HomePage] = s.[HomePage]
					, t.[DV_Load_Datetime] = s.[DV_Load_Datetime]
					, t.[DV_Deleted_Flag] = s.[DV_Deleted_Flag]
					, t.[DV_Record_Source] = s.[DV_Record_Source]
					, t.[DV_Business_Key] = s.[DV_Business_Key]
					, t.[HK_H_Supplier] = s.[HK_H_Supplier]
					, t.[HD_S_HC_Supplier_Northwind] = s.[HD_S_HC_Supplier_Northwind]
					, t.[HD_S_HT_Supplier_Northwind] = s.[HD_S_HT_Supplier_Northwind]
			-- Delete
			WHEN NOT MATCHED BY SOURCE AND t.[DV_Deleted_Flag] = 0 THEN 
				UPDATE SET
					  t.[DV_Load_Datetime] = @DV_Load_Datetime
					, t.[DV_Deleted_Flag] = 1
					, t.[DV_Record_Source] = 'SYSTEM'
					, t.[HD_S_HT_Supplier_Northwind] = UPPER(
						CONVERT(
							  char(32)
							, HASHBYTES(
								  'MD5'
								, CONCAT(
									  -- Business key
									  ISNULL(t.[SupplierID], ''), '|' 
									  -- Change detection fields
									, 1  -- DV_Deleted_Flag
								  )
							  )
							, 2
						)
					  );


			-- Drop temp table
			DROP TABLE #TEMP_Northwind_Suppliers;

		END TRY
		BEGIN CATCH

			-- If error caught and uncomitted transactions then roll back transaction
			IF @@TRANCOUNT > 0  
				ROLLBACK TRANSACTION; 

			-- Insert error details to the error log table
			INSERT INTO 
				[Meta_Metrics_Error_Mart].[error].[Error_Log]
			VALUES (	
				  GETDATE()
				, ERROR_PROCEDURE()
				, ERROR_NUMBER()
				, ERROR_SEVERITY()
				, ERROR_STATE()
				, ERROR_LINE()
				, ERROR_MESSAGE()
			);

		END CATCH

		-- If TRY completes successfully, commit the transaction
		IF @@TRANCOUNT > 0  
			COMMIT TRANSACTION;  
	END
GO
/****** Object:  StoredProcedure [northwind].[usp_Load_Northwind_Territories]    Script Date: 5/01/2023 10:15:39 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [northwind].[usp_Load_Northwind_Territories] 
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			DECLARE @DV_Load_Datetime datetime2(7) = SYSDATETIME();

			/* Load incoming data into a temporary table with all hashes and metadata added */

			-- Create temporary table identical to the stage to hold the incoming records
			CREATE TABLE #TEMP_Northwind_Territories (
				  [TerritoryID] nvarchar(20) NOT NULL
				, [TerritoryDescription] nchar(50) NOT NULL
				, [RegionID] int NOT NULL
				, [DV_Load_Datetime] datetime2(7) NOT NULL
				, [DV_Deleted_Flag] bit NOT NULL
				, [DV_Record_Source] varchar(100) NOT NULL
				, [DV_Business_Key] varchar(20) NOT NULL
				, [HK_H_Region] char(32) NOT NULL
				, [HK_H_Territory] char(32) NOT NULL
				, [HK_L_Territory_Region] char(32) NOT NULL
				, [HD_S_HC_Territory_Northwind] char(32) NOT NULL
				, [HD_S_HT_Territory_Northwind] char(32) NOT NULL
				, [HD_S_LE_Territory_Region_Northwind] char(32) NOT NULL
				, CONSTRAINT [PK_TEMP_Northwind_Territories] PRIMARY KEY CLUSTERED ([TerritoryID])
			);

			-- Insert all existing records from source with metadata added
			INSERT INTO #TEMP_Northwind_Territories (
				  [TerritoryID]
				, [TerritoryDescription]
				, [RegionID]
				, [DV_Load_Datetime]
				, [DV_Deleted_Flag]
				, [DV_Record_Source]
				, [DV_Business_Key]
				, [HK_H_Region]
				, [HK_H_Territory]
				, [HK_L_Territory_Region]
				, [HD_S_HC_Territory_Northwind]
				, [HD_S_HT_Territory_Northwind]
				, [HD_S_LE_Territory_Region_Northwind]
			)
			SELECT
				  [TerritoryID]
				, [TerritoryDescription]
				, [RegionID]
				, @DV_Load_Datetime AS DV_Load_Datetime
				, 0 AS DV_Deleted_Flag
				, 'Northwind.dbo.Territories' AS DV_Record_Source
				, [TerritoryID] AS DV_Business_Key
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							  -- Business key
							, ISNULL(CONVERT(varchar(10), [RegionID]), '')  -- FK NOT NULL
						  )
						, 2
					)
				  ) AS HK_H_Region
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							  -- Business key
							, ISNULL([TerritoryID], '')  -- PK NOT NULL
						  )
						, 2
					)
				  ) AS HK_H_Territory
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							  -- Business key
							, CONCAT(
								  ISNULL([TerritoryID], ''), '|'  -- PK NOT NULL
								, ISNULL([RegionID], '')  -- FK NOT NULL
							  )
						  )
						, 2
					)
				  ) AS HK_L_Territory_Region
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							, CONCAT(
								  -- Business key
								  ISNULL([TerritoryID], ''), '|'
								  -- Change detection fields
								, TRIM(ISNULL([TerritoryDescription], ''))
							  )
						  )
						, 2
					)
				  ) AS HD_S_HC_Territory_Northwind
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							, CONCAT(
								  -- Business key
								  ISNULL([TerritoryID], ''), '|'
								  -- Change detection fields
								, 0  -- DV_Deleted_Flag
							  )
						  )
						, 2
					)
				  ) AS HD_S_HT_Territory_Northwind
				, UPPER(
					CONVERT(
						  char(32)
						, HASHBYTES(
							  'MD5'
							  -- Business key
							, CONCAT(
								  ISNULL([TerritoryID], ''), '|'  -- PK NOT NULL
								, ISNULL([RegionID], '')  -- FK NOT NULL
							  )
						  )
						, 2
					)
				  ) AS HD_S_LE_Territory_Region_Northwind  -- Matches Link hash key 
			FROM
				[Northwind].[dbo].[Territories];


			/* Merge existing data in the stage table with the incoming data in the temp table */

			MERGE 
				[Stage_Area].[northwind].[Territories] AS t 
			USING
				#TEMP_Northwind_Territories AS s
			ON
				t.[TerritoryID] = s.[TerritoryID]
			-- Insert
			WHEN NOT MATCHED BY TARGET THEN
				INSERT (
					  [TerritoryID]
					, [TerritoryDescription]
					, [RegionID]
					, [DV_Load_Datetime]
					, [DV_Deleted_Flag]
					, [DV_Record_Source]
					, [DV_Business_Key]
					, [HK_H_Region]
					, [HK_H_Territory]
					, [HK_L_Territory_Region]
					, [HD_S_HC_Territory_Northwind]
					, [HD_S_HT_Territory_Northwind]
					, [HD_S_LE_Territory_Region_Northwind]
				)
				VALUES (
					  s.[TerritoryID]
					, s.[TerritoryDescription]
					, s.[RegionID]
					, s.[DV_Load_Datetime]
					, s.[DV_Deleted_Flag]
					, s.[DV_Record_Source]
					, s.[DV_Business_Key]
					, s.[HK_H_Region]
					, s.[HK_H_Territory]
					, s.[HK_L_Territory_Region]
					, s.[HD_S_HC_Territory_Northwind]
					, s.[HD_S_HT_Territory_Northwind]
					, s.[HD_S_LE_Territory_Region_Northwind]
				)
			-- Update
			WHEN MATCHED THEN 
				UPDATE SET
					  t.[TerritoryID] = s.[TerritoryID]
					, t.[TerritoryDescription] = s.[TerritoryDescription]
					, t.[RegionID] = s.[RegionID]
					, t.[DV_Load_Datetime] = s.[DV_Load_Datetime]
					, t.[DV_Deleted_Flag] = s.[DV_Deleted_Flag]
					, t.[DV_Record_Source] = s.[DV_Record_Source]
					, t.[DV_Business_Key] = s.[DV_Business_Key]
					, t.[HK_H_Region] = s.[HK_H_Region]
					, t.[HK_H_Territory] = s.[HK_H_Territory]
					, t.[HK_L_Territory_Region] = s.[HK_L_Territory_Region]
					, t.[HD_S_HC_Territory_Northwind] = s.[HD_S_HC_Territory_Northwind]
					, t.[HD_S_HT_Territory_Northwind] = s.[HD_S_HT_Territory_Northwind]
					, t.[HD_S_LE_Territory_Region_Northwind] = s.[HD_S_LE_Territory_Region_Northwind]
			-- Delete
			WHEN NOT MATCHED BY SOURCE AND t.[DV_Deleted_Flag] = 0 THEN 
				UPDATE SET
					  t.[DV_Load_Datetime] = @DV_Load_Datetime
					, t.[DV_Deleted_Flag] = 1
					, t.[DV_Record_Source] = 'SYSTEM'
					, t.[HD_S_HT_Territory_Northwind] = UPPER(
						CONVERT(
							  char(32)
							, HASHBYTES(
								  'MD5'
								, CONCAT(
									  -- Business key
									  ISNULL(t.[TerritoryID], ''), '|'
									  -- Change detection fields
									, 1  -- DV_Deleted_Flag
								  )
							  )
							, 2
						)
					  );

			-- Drop temp table
			DROP TABLE #TEMP_Northwind_Territories;

		END TRY
		BEGIN CATCH

			-- If error caught and uncomitted transactions then roll back transaction
			IF @@TRANCOUNT > 0  
				ROLLBACK TRANSACTION; 

			-- Insert error details to the error log table
			INSERT INTO 
				[Meta_Metrics_Error_Mart].[error].[Error_Log]
			VALUES (	
				  GETDATE()
				, ERROR_PROCEDURE()
				, ERROR_NUMBER()
				, ERROR_SEVERITY()
				, ERROR_STATE()
				, ERROR_LINE()
				, ERROR_MESSAGE()
			);

		END CATCH

		-- If TRY completes successfully, commit the transaction
		IF @@TRANCOUNT > 0  
			COMMIT TRANSACTION;  
	END
GO
USE [master]
GO
ALTER DATABASE [Stage_Area] SET  READ_WRITE 
GO
