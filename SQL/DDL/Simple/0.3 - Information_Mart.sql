USE [master]
GO
/****** Object:  Database [Information_Mart]    Script Date: 17/10/2023 6:38:31 pm ******/
CREATE DATABASE [Information_Mart]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'InformationMart', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.DATAWAREHOUSE\MSSQL\DATA\InformationMart.mdf' , SIZE = 87040KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [DATA] 
( NAME = N'InformationMart_data', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.DATAWAREHOUSE\MSSQL\DATA\InformationMart_data.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%), 
 FILEGROUP [INDEX] 
( NAME = N'InformationMart_index', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.DATAWAREHOUSE\MSSQL\DATA\InformationMart_index.ndf' , SIZE = 120448KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 LOG ON 
( NAME = N'InformationMart_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.DATAWAREHOUSE\MSSQL\DATA\InformationMart_log.ldf' , SIZE = 416384KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Information_Mart] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Information_Mart].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Information_Mart] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Information_Mart] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Information_Mart] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Information_Mart] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Information_Mart] SET ARITHABORT OFF 
GO
ALTER DATABASE [Information_Mart] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Information_Mart] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Information_Mart] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Information_Mart] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Information_Mart] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Information_Mart] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Information_Mart] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Information_Mart] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Information_Mart] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Information_Mart] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Information_Mart] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Information_Mart] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Information_Mart] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Information_Mart] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Information_Mart] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Information_Mart] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Information_Mart] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Information_Mart] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Information_Mart] SET  MULTI_USER 
GO
ALTER DATABASE [Information_Mart] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Information_Mart] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Information_Mart] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Information_Mart] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Information_Mart] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Information_Mart] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Information_Mart] SET QUERY_STORE = OFF
GO
USE [Information_Mart]
GO
/****** Object:  Schema [bv]    Script Date: 17/10/2023 6:38:31 pm ******/
CREATE SCHEMA [bv]
GO
/****** Object:  Schema [star]    Script Date: 17/10/2023 6:38:31 pm ******/
CREATE SCHEMA [star]
GO
/****** Object:  Table [bv].[B_Customer_Type]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[B_Customer_Type](
	[DV_Sequence_Number] [bigint] IDENTITY(1,1) NOT NULL,
	[DV_Snapshot_Datetime] [datetimeoffset](7) NOT NULL,
	[HK_L_Customer_Type] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HK_H_Customer] [binary](32) NOT NULL,
	[HK_H_Customer_Type] [binary](32) NOT NULL,
	[CustomerID] [nchar](5) NOT NULL,
	[CustomerTypeID] [nchar](10) NOT NULL,
 CONSTRAINT [PK_B_Customer_Type] PRIMARY KEY CLUSTERED 
(
	[DV_Sequence_Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX],
 CONSTRAINT [UK_B_Customer_Type] UNIQUE NONCLUSTERED 
(
	[DV_Snapshot_Datetime] ASC,
	[HK_L_Customer_Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  Table [bv].[R_Snapshot_Control]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[R_Snapshot_Control](
	[DV_Snapshot_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[Date_Key] [int] NOT NULL,
	[Time_Key] [int] NOT NULL,
 CONSTRAINT [PK_R_Snapshot_Control] PRIMARY KEY CLUSTERED 
(
	[DV_Snapshot_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  View [bv].[v_stage_B_Customer_Type]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_B_Customer_Type] (
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
/****** Object:  Table [bv].[B_Employee_Reporting_Line]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[B_Employee_Reporting_Line](
	[DV_Sequence_Number] [bigint] IDENTITY(1,1) NOT NULL,
	[DV_Snapshot_Datetime] [datetimeoffset](7) NOT NULL,
	[HK_L_Employee_Reporting_Line] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HK_H_Employee__Direct_Report] [binary](32) NOT NULL,
	[HK_H_Employee__Manager] [binary](32) NOT NULL,
	[EmployeeID__Direct_Report] [int] NOT NULL,
	[EmployeeID__Manager] [int] NOT NULL,
 CONSTRAINT [PK_B_Employee_Reporting_Line] PRIMARY KEY CLUSTERED 
(
	[DV_Sequence_Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX],
 CONSTRAINT [UK_B_Employee_Reporting_Line] UNIQUE NONCLUSTERED 
(
	[DV_Snapshot_Datetime] ASC,
	[HK_H_Employee__Direct_Report] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  View [bv].[v_stage_B_Employee_Reporting_Line]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_B_Employee_Reporting_Line] (
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
/****** Object:  Table [bv].[B_Employee_Territory]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[B_Employee_Territory](
	[DV_Sequence_Number] [bigint] IDENTITY(1,1) NOT NULL,
	[DV_Snapshot_Datetime] [datetimeoffset](7) NOT NULL,
	[HK_L_Employee_Territory] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HK_H_Employee] [binary](32) NOT NULL,
	[HK_H_Territory] [binary](32) NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[TerritoryID] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_B_Employee_Territory] PRIMARY KEY CLUSTERED 
(
	[DV_Sequence_Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX],
 CONSTRAINT [UK_B_Employee_Territory] UNIQUE NONCLUSTERED 
(
	[DV_Snapshot_Datetime] ASC,
	[HK_L_Employee_Territory] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  View [bv].[v_stage_B_Employee_Territory]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_B_Employee_Territory] (
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
/****** Object:  Table [bv].[B_Order]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[B_Order](
	[DV_Sequence_Number] [bigint] IDENTITY(1,1) NOT NULL,
	[DV_Snapshot_Datetime] [datetimeoffset](7) NOT NULL,
	[HK_L_Order_Header] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HK_H_Order] [binary](32) NOT NULL,
	[HK_H_Customer] [binary](32) NOT NULL,
	[HK_H_Employee] [binary](32) NOT NULL,
	[HK_H_Shipper] [binary](32) NOT NULL,
	[Date_Key__OrderDate] [int] NOT NULL,
	[Date_Key__RequiredDate] [int] NOT NULL,
	[Date_Key__ShippedDate] [int] NOT NULL,
	[OrderID] [int] NOT NULL,
	[Is_Deleted_Flag] [bit] NULL,
	[Freight] [decimal](19, 4) NULL,
	[Order_Count] [int] NULL,
 CONSTRAINT [PK_B_Order] PRIMARY KEY CLUSTERED 
(
	[DV_Sequence_Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX],
 CONSTRAINT [UK_B_Order] UNIQUE NONCLUSTERED 
(
	[DV_Snapshot_Datetime] ASC,
	[HK_H_Order] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  View [bv].[v_stage_B_Order]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_B_Order] (
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
/****** Object:  Table [bv].[B_Order_Detail]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[B_Order_Detail](
	[DV_Sequence_Number] [bigint] IDENTITY(1,1) NOT NULL,
	[DV_Snapshot_Datetime] [datetimeoffset](7) NOT NULL,
	[HK_L_Order_Detail] [binary](32) NOT NULL,
	[HK_L_Order_Header] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HK_H_Customer] [binary](32) NOT NULL,
	[HK_H_Employee] [binary](32) NOT NULL,
	[HK_H_Shipper] [binary](32) NOT NULL,
	[HK_H_Product] [binary](32) NOT NULL,
	[Date_Key__OrderDate] [int] NOT NULL,
	[Date_Key__RequiredDate] [int] NOT NULL,
	[Date_Key__ShippedDate] [int] NOT NULL,
	[OrderID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Is_Deleted_Flag] [bit] NULL,
	[UnitPrice] [decimal](19, 4) NULL,
	[Quantity] [smallint] NULL,
	[Discount] [real] NULL,
	[Total_Price] [decimal](19, 4) NULL,
	[Order_Detail_Count] [int] NULL,
 CONSTRAINT [PK_B_Order_Detail] PRIMARY KEY CLUSTERED 
(
	[DV_Sequence_Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX],
 CONSTRAINT [UK_B_Order_Detail] UNIQUE NONCLUSTERED 
(
	[DV_Snapshot_Datetime] ASC,
	[HK_L_Order_Detail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  View [bv].[v_stage_B_Order_Detail]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_B_Order_Detail] (
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
/****** Object:  Table [bv].[B_Product_Supplier_Category]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[B_Product_Supplier_Category](
	[DV_Sequence_Number] [bigint] IDENTITY(1,1) NOT NULL,
	[DV_Snapshot_Datetime] [datetimeoffset](7) NOT NULL,
	[HK_L_Product_Supplier] [binary](32) NOT NULL,
	[HK_L_Product_Category] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HK_H_Product] [binary](32) NOT NULL,
	[HK_H_Supplier] [binary](32) NOT NULL,
	[HK_H_Product_Category] [binary](32) NOT NULL,
	[ProductID] [int] NOT NULL,
	[SupplierID] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
 CONSTRAINT [PK_B_Product_Supplier_Category] PRIMARY KEY CLUSTERED 
(
	[DV_Sequence_Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX],
 CONSTRAINT [UK_B_Product_Supplier_Category] UNIQUE NONCLUSTERED 
(
	[DV_Snapshot_Datetime] ASC,
	[HK_H_Product] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  View [bv].[v_stage_B_Product_Supplier_Category]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_B_Product_Supplier_Category] (
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
/****** Object:  Table [bv].[B_Territory_Region]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[B_Territory_Region](
	[DV_Sequence_Number] [bigint] IDENTITY(1,1) NOT NULL,
	[DV_Snapshot_Datetime] [datetimeoffset](7) NOT NULL,
	[HK_L_Territory_Region] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HK_H_Territory] [binary](32) NOT NULL,
	[HK_H_Region] [binary](32) NOT NULL,
	[TerritoryID] [nvarchar](20) NOT NULL,
	[RegionID] [int] NOT NULL,
 CONSTRAINT [PK_B_Territory_Region] PRIMARY KEY CLUSTERED 
(
	[DV_Sequence_Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX],
 CONSTRAINT [UK_B_Territory_Region] UNIQUE NONCLUSTERED 
(
	[DV_Snapshot_Datetime] ASC,
	[HK_H_Territory] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  View [bv].[v_stage_B_Territory_Region]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_B_Territory_Region] (
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
/****** Object:  Table [bv].[PIT_Customer]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[PIT_Customer](
	[DV_Sequence_Number] [bigint] IDENTITY(1,1) NOT NULL,
	[DV_Snapshot_Datetime] [datetimeoffset](7) NOT NULL,
	[HK_H_Customer] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HK_H_Customer__S_H_Customer_Northwind] [binary](32) NOT NULL,
	[DV_Load_Datetime__S_H_Customer_Northwind] [datetimeoffset](7) NOT NULL,
	[HK_H_Customer__S_HDT_H_Customer_Northwind] [binary](32) NOT NULL,
	[DV_Load_Datetime__S_HDT_H_Customer_Northwind] [datetimeoffset](7) NOT NULL,
	[CustomerID] [nchar](5) NOT NULL,
	[Is_Deleted_Flag] [bit] NULL,
 CONSTRAINT [PK_PIT_Customer] PRIMARY KEY CLUSTERED 
(
	[DV_Sequence_Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX],
 CONSTRAINT [UK_PIT_Customer] UNIQUE NONCLUSTERED 
(
	[DV_Snapshot_Datetime] ASC,
	[HK_H_Customer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  View [star].[Dim_Customer]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [star].[Dim_Customer] (
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
/****** Object:  View [star].[Bridge_Customer_Type]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [star].[Bridge_Customer_Type] (
	  Snapshot_Datetime
	, Dim_Customer_Key
	, Dim_Customer_Type_Key
)
AS
SELECT
	  DV_Snapshot_Datetime AS Snapshot_Datetime
	, HK_H_Customer AS Dim_Customer_Key
	, HK_H_Customer_Type AS Dim_Customer_Type_Key
FROM
	Information_Mart.bv.B_Customer_Type;
GO
/****** Object:  Table [bv].[PIT_Customer_Type]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[PIT_Customer_Type](
	[DV_Sequence_Number] [bigint] IDENTITY(1,1) NOT NULL,
	[DV_Snapshot_Datetime] [datetimeoffset](7) NOT NULL,
	[HK_H_Customer_Type] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HK_H_Customer_Type__S_H_Customer_Type_Northwind] [binary](32) NOT NULL,
	[DV_Load_Datetime__S_H_Customer_Type_Northwind] [datetimeoffset](7) NOT NULL,
	[HK_H_Customer_Type__S_HDT_H_Customer_Type_Northwind] [binary](32) NOT NULL,
	[DV_Load_Datetime__S_HDT_H_Customer_Type_Northwind] [datetimeoffset](7) NOT NULL,
	[CustomerTypeID] [nchar](10) NOT NULL,
	[Is_Deleted_Flag] [bit] NULL,
 CONSTRAINT [PK_PIT_Customer_Type] PRIMARY KEY CLUSTERED 
(
	[DV_Sequence_Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX],
 CONSTRAINT [UK_PIT_Customer_Type] UNIQUE NONCLUSTERED 
(
	[DV_Snapshot_Datetime] ASC,
	[HK_H_Customer_Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  View [star].[Dim_Customer_Type]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [star].[Dim_Customer_Type] (
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
/****** Object:  View [star].[Bridge_Employee_Territory]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [star].[Bridge_Employee_Territory] (
	  Snapshot_Datetime
	, Dim_Employee_Key
	, Dim_Territory_Key
)
AS
SELECT
	  DV_Snapshot_Datetime AS Snapshot_Datetime
	, HK_H_Employee AS Dim_Employee_Key
	, HK_H_Territory AS Dim_Territory_Key
FROM
	Information_Mart.bv.B_Employee_Territory;
GO
/****** Object:  Table [bv].[PIT_Employee]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[PIT_Employee](
	[DV_Sequence_Number] [bigint] IDENTITY(1,1) NOT NULL,
	[DV_Snapshot_Datetime] [datetimeoffset](7) NOT NULL,
	[HK_H_Employee] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HK_H_Employee__S_H_Employee_Northwind] [binary](32) NOT NULL,
	[DV_Load_Datetime__S_H_Employee_Northwind] [datetimeoffset](7) NOT NULL,
	[HK_H_Employee__S_HDT_H_Employee_Northwind] [binary](32) NOT NULL,
	[DV_Load_Datetime__S_HDT_H_Employee_Northwind] [datetimeoffset](7) NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[Employee_Name] [varchar](64) NULL,
	[Is_Deleted_Flag] [bit] NULL,
 CONSTRAINT [PK_PIT_Employee] PRIMARY KEY CLUSTERED 
(
	[DV_Sequence_Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX],
 CONSTRAINT [UK_PIT_Employee] UNIQUE NONCLUSTERED 
(
	[DV_Snapshot_Datetime] ASC,
	[HK_H_Employee] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  View [star].[Dim_Employee]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [star].[Dim_Employee] (
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
/****** Object:  View [star].[Dim_Manager]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [star].[Dim_Manager] (
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
/****** Object:  Table [bv].[PIT_Product]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[PIT_Product](
	[DV_Sequence_Number] [bigint] IDENTITY(1,1) NOT NULL,
	[DV_Snapshot_Datetime] [datetimeoffset](7) NOT NULL,
	[HK_H_Product] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HK_H_Product__S_H_Product_Northwind] [binary](32) NOT NULL,
	[DV_Load_Datetime__S_H_Product_Northwind] [datetimeoffset](7) NOT NULL,
	[HK_H_Product__S_HDT_H_Product_Northwind] [binary](32) NOT NULL,
	[DV_Load_Datetime__S_HDT_H_Product_Northwind] [datetimeoffset](7) NOT NULL,
	[ProductID] [int] NOT NULL,
	[Is_Deleted_Flag] [bit] NULL,
 CONSTRAINT [PK_PIT_Product] PRIMARY KEY CLUSTERED 
(
	[DV_Sequence_Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX],
 CONSTRAINT [UK_PIT_Product] UNIQUE NONCLUSTERED 
(
	[DV_Snapshot_Datetime] ASC,
	[HK_H_Product] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  Table [bv].[PIT_Product_Category]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[PIT_Product_Category](
	[DV_Sequence_Number] [bigint] IDENTITY(1,1) NOT NULL,
	[DV_Snapshot_Datetime] [datetimeoffset](7) NOT NULL,
	[HK_H_Product_Category] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HK_H_Product_Category__S_H_Product_Category_Northwind] [binary](32) NOT NULL,
	[DV_Load_Datetime__S_H_Product_Category_Northwind] [datetimeoffset](7) NOT NULL,
	[HK_H_Product_Category__S_HDT_H_Product_Category_Northwind] [binary](32) NOT NULL,
	[DV_Load_Datetime__S_HDT_H_Product_Category_Northwind] [datetimeoffset](7) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[Is_Deleted_Flag] [bit] NULL,
 CONSTRAINT [PK_PIT_Product_Category] PRIMARY KEY CLUSTERED 
(
	[DV_Sequence_Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX],
 CONSTRAINT [UK_PIT_Product_Category] UNIQUE NONCLUSTERED 
(
	[DV_Snapshot_Datetime] ASC,
	[HK_H_Product_Category] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  Table [bv].[PIT_Supplier]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[PIT_Supplier](
	[DV_Sequence_Number] [bigint] IDENTITY(1,1) NOT NULL,
	[DV_Snapshot_Datetime] [datetimeoffset](7) NOT NULL,
	[HK_H_Supplier] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HK_H_Supplier__S_H_Supplier_Northwind] [binary](32) NOT NULL,
	[DV_Load_Datetime__S_H_Supplier_Northwind] [datetimeoffset](7) NOT NULL,
	[HK_H_Supplier__S_HDT_H_Supplier_Northwind] [binary](32) NOT NULL,
	[DV_Load_Datetime__S_HDT_H_Supplier_Northwind] [datetimeoffset](7) NOT NULL,
	[SupplierID] [int] NOT NULL,
	[Is_Deleted_Flag] [bit] NULL,
 CONSTRAINT [PK_PIT_Supplier] PRIMARY KEY CLUSTERED 
(
	[DV_Sequence_Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX],
 CONSTRAINT [UK_PIT_Supplier] UNIQUE NONCLUSTERED 
(
	[DV_Snapshot_Datetime] ASC,
	[HK_H_Supplier] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  View [star].[Dim_Product]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [star].[Dim_Product] (
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
/****** Object:  Table [bv].[PIT_Shipper]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[PIT_Shipper](
	[DV_Sequence_Number] [bigint] IDENTITY(1,1) NOT NULL,
	[DV_Snapshot_Datetime] [datetimeoffset](7) NOT NULL,
	[HK_H_Shipper] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HK_H_Shipper__S_H_Shipper_Northwind] [binary](32) NOT NULL,
	[DV_Load_Datetime__S_H_Shipper_Northwind] [datetimeoffset](7) NOT NULL,
	[HK_H_Shipper__S_HDT_H_Shipper_Northwind] [binary](32) NOT NULL,
	[DV_Load_Datetime__S_HDT_H_Shipper_Northwind] [datetimeoffset](7) NOT NULL,
	[ShipperID] [int] NOT NULL,
	[Is_Deleted_Flag] [bit] NULL,
 CONSTRAINT [PK_PIT_Shipper] PRIMARY KEY CLUSTERED 
(
	[DV_Sequence_Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX],
 CONSTRAINT [UK_PIT_Shipper] UNIQUE NONCLUSTERED 
(
	[DV_Snapshot_Datetime] ASC,
	[HK_H_Shipper] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  View [star].[Dim_Shipper]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [star].[Dim_Shipper] (
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
/****** Object:  Table [bv].[PIT_Region]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[PIT_Region](
	[DV_Sequence_Number] [bigint] IDENTITY(1,1) NOT NULL,
	[DV_Snapshot_Datetime] [datetimeoffset](7) NOT NULL,
	[HK_H_Region] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HK_H_Region__S_H_Region_Northwind] [binary](32) NOT NULL,
	[DV_Load_Datetime__S_H_Region_Northwind] [datetimeoffset](7) NOT NULL,
	[HK_H_Region__S_HDT_H_Region_Northwind] [binary](32) NOT NULL,
	[DV_Load_Datetime__S_HDT_H_Region_Northwind] [datetimeoffset](7) NOT NULL,
	[RegionID] [int] NOT NULL,
	[Is_Deleted_Flag] [bit] NULL,
 CONSTRAINT [PK_PIT_Region] PRIMARY KEY CLUSTERED 
(
	[DV_Sequence_Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX],
 CONSTRAINT [UK_PIT_Region] UNIQUE NONCLUSTERED 
(
	[DV_Snapshot_Datetime] ASC,
	[HK_H_Region] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  Table [bv].[PIT_Territory]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[PIT_Territory](
	[DV_Sequence_Number] [bigint] IDENTITY(1,1) NOT NULL,
	[DV_Snapshot_Datetime] [datetimeoffset](7) NOT NULL,
	[HK_H_Territory] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HK_H_Territory__S_H_Territory_Northwind] [binary](32) NOT NULL,
	[DV_Load_Datetime__S_H_Territory_Northwind] [datetimeoffset](7) NOT NULL,
	[HK_H_Territory__S_HDT_H_Territory_Northwind] [binary](32) NOT NULL,
	[DV_Load_Datetime__S_HDT_H_Territory_Northwind] [datetimeoffset](7) NOT NULL,
	[TerritoryID] [nvarchar](20) NOT NULL,
	[Is_Deleted_Flag] [bit] NULL,
 CONSTRAINT [PK_PIT_Territory] PRIMARY KEY CLUSTERED 
(
	[DV_Sequence_Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX],
 CONSTRAINT [UK_PIT_Territory] UNIQUE NONCLUSTERED 
(
	[DV_Snapshot_Datetime] ASC,
	[HK_H_Territory] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  View [star].[Dim_Territory]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [star].[Dim_Territory] (
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
/****** Object:  View [star].[Fact_Order]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [star].[Fact_Order] (
	  Snapshot_Datetime
	, Dim_Customer_Key
	, Dim_Employee_Key
	, Dim_Shipper
	, Dim_Order_Submitted_Date_Key
	, Dim_Order_Required_Date_Key
 	, Dim_Order_Shipped_Date_Key
	, Order_ID
	, Freight_Amount
	, Order_Count
	, Order_Is_Deleted_Flag
)
AS
SELECT
	  DV_Snapshot_Datetime AS Snapshot_Datetime
	, HK_H_Customer AS Dim_Customer_Key
	, HK_H_Employee AS Dim_Employee_Key
	, HK_H_Shipper AS Dim_Shipper_Key
	, Date_Key__OrderDate AS Dim_Order_Submitted_Date_Key
	, Date_Key__RequiredDate AS Dim_Order_Required_Date_Key
 	, Date_Key__ShippedDate AS Dim_Order_Shipped_Date_Key
	, OrderID AS Order_ID
	, Freight AS Freight_Amount
	, Order_Count
	, Is_Deleted_Flag AS Order_Is_Deleted_Flag
FROM
	Information_Mart.bv.B_Order
WHERE
	HK_L_Order_Header NOT IN (
			  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
			, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
			, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		);
GO
/****** Object:  View [star].[Fact_Order_Detail]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [star].[Fact_Order_Detail] (
	  Snapshot_Datetime
	, Dim_Customer_Key
	, Dim_Employee_Key
	, Dim_Shipper_Key
	, Dim_Product_Key
	, Dim_Order_Submitted_Date_Key
	, Dim_Order_Required_Date_Key
	, Dim_Order_Shipped_Date_Key
	, Order_ID
	, Product_ID
	, Unit_Price
	, Quantity
	, Discount
	, Total_Price
	, Order_Detail_Count
	, Order_Detail_Is_Deleted_Flag
)
AS
SELECT
	  DV_Snapshot_Datetime AS Snapshot_Datetime
	, HK_H_Customer AS Dim_Customer_Key
	, HK_H_Employee AS Dim_Employee_Key
	, HK_H_Shipper AS Dim_Shipper_Key
	, HK_H_Product AS Dim_Product_Key
	, Date_Key__OrderDate AS Dim_Order_Submitted_Date_Key
	, Date_Key__RequiredDate AS Dim_Order_Required_Date_Key
	, Date_Key__ShippedDate AS Dim_Order_Shipped_Date_Key
	, OrderID AS Order_ID
	, ProductID AS Product_ID
	, UnitPrice AS Unit_Price
	, Quantity
	, Discount
	, Total_Price
	, Order_Detail_Count
	, Is_Deleted_Flag AS Order_Detail_Is_Deleted_Flag
FROM
	Information_Mart.bv.B_Order_Detail
WHERE
	HK_L_Order_Detail NOT IN (
			  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
			, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
			, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		);
GO
/****** Object:  View [bv].[v_stage_PIT_Customer]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_PIT_Customer] (
	  DV_Snapshot_Datetime
	, HK_H_Customer
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Customer__S_H_Customer_Northwind
	, DV_Load_Datetime__S_H_Customer_Northwind
	, HK_H_Customer__S_HDT_H_Customer_Northwind
	, DV_Load_Datetime__S_HDT_H_Customer_Northwind
	, CustomerID
	, Is_Deleted_Flag
)
AS
SELECT
	  snap.DV_Snapshot_Datetime
	, hub.HK_H_Customer
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, 'SYSTEM | Information_Mart.bv.v_stage_PIT_Customer' AS DV_Record_Source
	, COALESCE(sat_h.HK_H_Customer, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Customer__S_H_Customer_Northwind
	, COALESCE(sat_h.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_H_Customer_Northwind
	, COALESCE(sat_hdt.HK_H_Customer, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Customer__S_HDT_H_Customer_Northwind
	, COALESCE(sat_hdt.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_HDT_H_Customer_Northwind
	, hub.CustomerID
	, sat_hdt.Is_Deleted_Flag
FROM
	Data_Vault.rv.H_Customer AS hub
		CROSS JOIN Information_Mart.bv.R_Snapshot_Control AS snap	
		LEFT JOIN Data_Vault.bv.v_history_S_H_Customer_Northwind AS sat_h
			ON hub.HK_H_Customer = sat_h.HK_H_Customer
			AND snap.DV_Snapshot_Datetime BETWEEN sat_h.DV_Load_Datetime_Start AND sat_h.DV_Load_Datetime_End
		LEFT JOIN Data_Vault.bv.v_history_S_HDT_H_Customer_Northwind AS sat_hdt
			ON hub.HK_H_Customer = sat_hdt.HK_H_Customer
			AND snap.DV_Snapshot_Datetime BETWEEN sat_hdt.DV_Load_Datetime_Start AND sat_hdt.DV_Load_Datetime_End
WHERE
	NOT EXISTS (
		SELECT
			1
		FROM
			Information_Mart.bv.PIT_Customer AS pit
		WHERE
			snap.DV_Snapshot_Datetime = pit.DV_Snapshot_Datetime
			AND hub.HK_H_Customer = pit.HK_H_Customer
	);
GO
/****** Object:  View [bv].[v_stage_PIT_Customer_Type]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_PIT_Customer_Type] (
	  DV_Snapshot_Datetime
	, HK_H_Customer_Type
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Customer_Type__S_H_Customer_Type_Northwind
	, DV_Load_Datetime__S_H_Customer_Type_Northwind
	, HK_H_Customer_Type__S_HDT_H_Customer_Type_Northwind
	, DV_Load_Datetime__S_HDT_H_Customer_Type_Northwind
	, CustomerTypeID
	, Is_Deleted_Flag
)
AS
SELECT
	  snap.DV_Snapshot_Datetime
	, hub.HK_H_Customer_Type
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, 'SYSTEM | Information_Mart.bv.v_stage_PIT_Customer_Type' AS DV_Record_Source
	, COALESCE(sat_h.HK_H_Customer_Type, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Customer_Type__S_H_Customer_Type_Northwind
	, COALESCE(sat_h.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_H_Customer_Type_Northwind
	, COALESCE(sat_hdt.HK_H_Customer_Type, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Customer_Type__S_HDT_H_Customer_Type_Northwind
	, COALESCE(sat_hdt.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_HDT_H_Customer_Type_Northwind
	, hub.CustomerTypeID
	, sat_hdt.Is_Deleted_Flag
FROM
	Data_Vault.rv.H_Customer_Type AS hub
		CROSS JOIN Information_Mart.bv.R_Snapshot_Control AS snap
		LEFT JOIN Data_Vault.bv.v_history_S_H_Customer_Type_Northwind AS sat_h
			ON hub.HK_H_Customer_Type = sat_h.HK_H_Customer_Type
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_h.DV_Load_Datetime_Start AND sat_h.DV_Load_Datetime_End
		LEFT JOIN Data_Vault.bv.v_history_S_HDT_H_Customer_Type_Northwind AS sat_hdt
			ON hub.HK_H_Customer_Type = sat_hdt.HK_H_Customer_Type
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_hdt.DV_Load_Datetime_Start AND sat_hdt.DV_Load_Datetime_End
WHERE
	NOT EXISTS (
		SELECT
			1
		FROM
			Information_Mart.bv.PIT_Customer_Type AS pit
		WHERE
			snap.DV_Snapshot_Datetime = pit.DV_Snapshot_Datetime
			AND hub.HK_H_Customer_Type = pit.HK_H_Customer_Type
	);
GO
/****** Object:  View [bv].[v_stage_PIT_Employee]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_PIT_Employee] (
	  DV_Snapshot_Datetime
	, HK_H_Employee
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Employee__S_H_Employee_Northwind
	, DV_Load_Datetime__S_H_Employee_Northwind
	, HK_H_Employee__S_HDT_H_Employee_Northwind
	, DV_Load_Datetime__S_HDT_H_Employee_Northwind
	, EmployeeID
	, Employee_Name
	, Is_Deleted_Flag
)
AS
SELECT
	  snap.DV_Snapshot_Datetime
	, hub.HK_H_Employee
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, 'SYSTEM | Information_Mart.bv.v_stage_PIT_Employee' AS DV_Record_Source
	, COALESCE(sat_h.HK_H_Employee, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Employee__S_H_Employee_Northwind
	, COALESCE(sat_h.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_H_Employee_Northwind
	, COALESCE(sat_hdt.HK_H_Employee, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Employee__S_HDT_H_Employee_Northwind
	, COALESCE(sat_hdt.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_HDT_H_Employee_Northwind
	, hub.EmployeeID
	, NULLIF(CONCAT_WS(' ', sat_h.TitleOfCourtesy, sat_h.FirstName, sat_h.LastName), '') AS Employee_Name
	, Is_Deleted_Flag
FROM
	Data_Vault.rv.H_Employee AS hub
		CROSS JOIN Information_Mart.bv.R_Snapshot_Control AS snap
		LEFT JOIN Data_Vault.bv.v_history_S_H_Employee_Northwind AS sat_h
			ON hub.HK_H_Employee = sat_h.HK_H_Employee
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_h.DV_Load_Datetime_Start AND sat_h.DV_Load_Datetime_End
		LEFT JOIN Data_Vault.bv.v_history_S_HDT_H_Employee_Northwind AS sat_hdt
			ON hub.HK_H_Employee = sat_hdt.HK_H_Employee
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_hdt.DV_Load_Datetime_Start AND sat_hdt.DV_Load_Datetime_End
WHERE
	NOT EXISTS (
		SELECT
			1
		FROM
			Information_Mart.bv.PIT_Employee AS pit
		WHERE
			snap.DV_Snapshot_Datetime = pit.DV_Snapshot_Datetime
			AND hub.HK_H_Employee = pit.HK_H_Employee
	);
GO
/****** Object:  Table [bv].[PIT_Order]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[PIT_Order](
	[DV_Sequence_Number] [bigint] IDENTITY(1,1) NOT NULL,
	[DV_Snapshot_Datetime] [datetimeoffset](7) NOT NULL,
	[HK_H_Order] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HK_H_Order__S_H_Order_Northwind] [binary](32) NOT NULL,
	[DV_Load_Datetime__S_H_Order_Northwind] [datetimeoffset](7) NOT NULL,
	[HK_H_Order__S_HDT_H_Order_Northwind] [binary](32) NOT NULL,
	[DV_Load_Datetime__S_HDT_H_Order_Northwind] [datetimeoffset](7) NOT NULL,
	[OrderID] [int] NOT NULL,
	[Is_Deleted_Flag] [bit] NULL,
 CONSTRAINT [PK_PIT_Order] PRIMARY KEY CLUSTERED 
(
	[DV_Sequence_Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX],
 CONSTRAINT [UK_PIT_Order] UNIQUE NONCLUSTERED 
(
	[DV_Snapshot_Datetime] ASC,
	[HK_H_Order] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  View [bv].[v_stage_PIT_Order]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_PIT_Order] (
	  DV_Snapshot_Datetime 
	, HK_H_Order 
	, DV_Load_Datetime 
	, DV_Record_Source 
	, HK_H_Order__S_H_Order_Northwind 
	, DV_Load_Datetime__S_H_Order_Northwind 
	, HK_H_Order__S_HDT_H_Order_Northwind 
	, DV_Load_Datetime__S_HDT_H_Order_Northwind 
	, OrderID 
	, Is_Deleted_Flag 
)
AS
SELECT 
	  snap.DV_Snapshot_Datetime 
	, hub.HK_H_Order 
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, 'SYSTEM | Information_Mart.bv.v_stage_PIT_Order' AS DV_Record_Source
	, COALESCE(sat_h.HK_H_Order, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Order__S_H_Order_Northwind 
	, COALESCE(sat_h.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_H_Order_Northwind 
	, COALESCE(sat_hdt.HK_H_Order, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Order__S_HDT_H_Order_Northwind 
	, COALESCE(sat_hdt.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_HDT_H_Order_Northwind 
	, hub.OrderID 
	, sat_hdt.Is_Deleted_Flag 
FROM
	Data_Vault.rv.H_Order AS hub
		CROSS JOIN Information_Mart.bv.R_Snapshot_Control AS snap
		LEFT JOIN Data_Vault.bv.v_history_S_H_Order_Northwind AS sat_h
			ON hub.HK_H_Order = sat_h.HK_H_Order
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_h.DV_Load_Datetime_Start AND sat_h.DV_Load_Datetime_End
		LEFT JOIN Data_Vault.bv.v_history_S_HDT_H_Order_Northwind AS sat_hdt
			ON hub.HK_H_Order = sat_hdt.HK_H_Order
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_hdt.DV_Load_Datetime_Start AND sat_hdt.DV_Load_Datetime_End
WHERE
	NOT EXISTS (
		SELECT
			1
		FROM
			Information_Mart.bv.PIT_Order AS pit
		WHERE
			snap.DV_Snapshot_Datetime = pit.DV_Snapshot_Datetime
			AND hub.HK_H_Order = pit.HK_H_Order
	);
GO
/****** Object:  View [bv].[v_stage_PIT_Product]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_PIT_Product] (
	  DV_Snapshot_Datetime 
	, HK_H_Product 
	, DV_Load_Datetime 
	, DV_Record_Source 
	, HK_H_Product__S_H_Product_Northwind 
	, DV_Load_Datetime__S_H_Product_Northwind 
	, HK_H_Product__S_HDT_H_Product_Northwind 
	, DV_Load_Datetime__S_HDT_H_Product_Northwind
	, ProductID 
	, Is_Deleted_Flag 
)
AS
SELECT
	  snap.DV_Snapshot_Datetime 
	, hub.HK_H_Product 
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, 'SYSTEM | Information_Mart.bv.v_stage_PIT_Product' AS DV_Record_Source
	, COALESCE(sat_h.HK_H_Product, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Product__S_H_Product_Northwind 
	, COALESCE(sat_h.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_H_Product_Northwind 
	, COALESCE(sat_hdt.HK_H_Product, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Product__S_HDT_H_Product_Northwind 
	, COALESCE(sat_hdt.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_HDT_H_Product_Northwind
	, hub.ProductID 
	, sat_hdt.Is_Deleted_Flag 
FROM
	Data_Vault.rv.H_Product AS hub
		CROSS JOIN Information_Mart.bv.R_Snapshot_Control AS snap
		LEFT JOIN Data_Vault.bv.v_history_S_H_Product_Northwind AS sat_h
			ON hub.HK_H_Product = sat_h.HK_H_Product
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_h.DV_Load_Datetime_Start AND sat_h.DV_Load_Datetime_End
		LEFT JOIN Data_Vault.bv.v_history_S_HDT_H_Product_Northwind AS sat_hdt
			ON hub.HK_H_Product = sat_hdt.HK_H_Product
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_hdt.DV_Load_Datetime_Start AND sat_hdt.DV_Load_Datetime_End
WHERE
	NOT EXISTS (
		SELECT
			1
		FROM
			Information_Mart.bv.PIT_Product AS pit
		WHERE
			snap.DV_Snapshot_Datetime = pit.DV_Snapshot_Datetime
			AND hub.HK_H_Product = pit.HK_H_Product
	);
GO
/****** Object:  View [bv].[v_stage_PIT_Product_Category]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_PIT_Product_Category] (
	  DV_Snapshot_Datetime
	, HK_H_Product_Category
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Product_Category__S_H_Product_Category_Northwind
	, DV_Load_Datetime__S_H_Product_Category_Northwind
	, HK_H_Product_Category__S_HDT_H_Product_Category_Northwind
	, DV_Load_Datetime__S_HDT_H_Product_Category_Northwind
	, CategoryID
	, Is_Deleted_Flag
)
AS
SELECT
	  snap.DV_Snapshot_Datetime
	, hub.HK_H_Product_Category
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, 'SYSTEM | Information_Mart.bv.v_stage_PIT_Product_Category' AS DV_Record_Source
	, COALESCE(sat_h.HK_H_Product_Category, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Product_Category__S_H_Product_Category_Northwind
	, COALESCE(sat_h.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_H_Product_Category_Northwind
	, COALESCE(sat_hdt.HK_H_Product_Category, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Product_Category__S_HDT_H_Product_Category_Northwind
	, COALESCE(sat_hdt.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_HDT_H_Product_Category_Northwind
	, hub.CategoryID
	, sat_hdt.Is_Deleted_Flag
FROM
	Data_Vault.rv.H_Product_Category AS hub
		CROSS JOIN Information_Mart.bv.R_Snapshot_Control AS snap
		LEFT JOIN Data_Vault.bv.v_history_S_H_Product_Category_Northwind AS sat_h
			ON hub.HK_H_Product_Category = sat_h.HK_H_Product_Category
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_h.DV_Load_Datetime_Start AND sat_h.DV_Load_Datetime_End
		LEFT JOIN Data_Vault.bv.v_history_S_HDT_H_Product_Category_Northwind AS sat_hdt
			ON hub.HK_H_Product_Category = sat_hdt.HK_H_Product_Category
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_hdt.DV_Load_Datetime_Start AND sat_hdt.DV_Load_Datetime_End
WHERE
	NOT EXISTS (
		SELECT
			1
		FROM
			Information_Mart.bv.PIT_Product_Category AS pit
		WHERE
			snap.DV_Snapshot_Datetime = pit.DV_Snapshot_Datetime
			AND hub.HK_H_Product_Category = pit.HK_H_Product_Category
	);
GO
/****** Object:  View [bv].[v_stage_PIT_Region]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_PIT_Region] (
	  DV_Snapshot_Datetime 
	, HK_H_Region 
	, DV_Load_Datetime 
	, DV_Record_Source 
	, HK_H_Region__S_H_Region_Northwind 
	, DV_Load_Datetime__S_H_Region_Northwind 
	, HK_H_Region__S_HDT_H_Region_Northwind 
	, DV_Load_Datetime__S_HDT_H_Region_Northwind 
	, RegionID 
	, Is_Deleted_Flag 
)
AS
SELECT
	  snap.DV_Snapshot_Datetime 
	, hub.HK_H_Region 
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, 'SYSTEM | Information_Mart.bv.v_stage_PIT_Region' AS DV_Record_Source
	, COALESCE(sat_h.HK_H_Region, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Region__S_H_Region_Northwind 
	, COALESCE(sat_h.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_H_Region_Northwind 
	, COALESCE(sat_hdt.HK_H_Region, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Region__S_HDT_H_Region_Northwind 
	, COALESCE(sat_hdt.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_HDT_H_Region_Northwind 
	, hub.RegionID 
	, sat_hdt.Is_Deleted_Flag
FROM
	Data_Vault.rv.H_Region AS hub
		CROSS JOIN Information_Mart.bv.R_Snapshot_Control AS snap
		LEFT JOIN Data_Vault.bv.v_history_S_H_Region_Northwind AS sat_h
			ON hub.HK_H_Region = sat_h.HK_H_Region
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_h.DV_Load_Datetime_Start AND sat_h.DV_Load_Datetime_End
		LEFT JOIN Data_Vault.bv.v_history_S_HDT_H_Region_Northwind AS sat_hdt
			ON hub.HK_H_Region = sat_hdt.HK_H_Region
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_hdt.DV_Load_Datetime_Start AND sat_hdt.DV_Load_Datetime_End
WHERE
	NOT EXISTS (
		SELECT
			1
		FROM
			Information_Mart.bv.PIT_Region AS pit
		WHERE
			snap.DV_Snapshot_Datetime = pit.DV_Snapshot_Datetime
			AND hub.HK_H_Region = pit.HK_H_Region
	);
GO
/****** Object:  View [bv].[v_stage_PIT_Shipper]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_PIT_Shipper] (
	  DV_Snapshot_Datetime 
	, HK_H_Shipper 
	, DV_Load_Datetime 
	, DV_Record_Source 
	, HK_H_Shipper__S_H_Shipper_Northwind 
	, DV_Load_Datetime__S_H_Shipper_Northwind 
	, HK_H_Shipper__S_HDT_H_Shipper_Northwind 
	, DV_Load_Datetime__S_HDT_H_Shipper_Northwind 
	, ShipperID 
	, Is_Deleted_Flag 
)
AS
SELECT
	  snap.DV_Snapshot_Datetime 
	, hub.HK_H_Shipper 
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, 'SYSTEM | Information_Mart.bv.v_stage_PIT_Shipper' AS DV_Record_Source
	, COALESCE(sat_h.HK_H_Shipper, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Shipper__S_H_Shipper_Northwind 
	, COALESCE(sat_h.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_H_Shipper_Northwind 
	, COALESCE(sat_hdt.HK_H_Shipper, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Shipper__S_HDT_H_Shipper_Northwind 
	, COALESCE(sat_hdt.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_HDT_H_Shipper_Northwind 
	, hub.ShipperID 
	, sat_hdt.Is_Deleted_Flag 
FROM
	Data_Vault.rv.H_Shipper AS hub
		CROSS JOIN Information_Mart.bv.R_Snapshot_Control AS snap
		LEFT JOIN Data_Vault.bv.v_history_S_H_Shipper_Northwind AS sat_h
			ON hub.HK_H_Shipper = sat_h.HK_H_Shipper
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_h.DV_Load_Datetime_Start AND sat_h.DV_Load_Datetime_End
		LEFT JOIN Data_Vault.bv.v_history_S_HDT_H_Shipper_Northwind AS sat_hdt
			ON hub.HK_H_Shipper = sat_hdt.HK_H_Shipper
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_hdt.DV_Load_Datetime_Start AND sat_hdt.DV_Load_Datetime_End
WHERE
	NOT EXISTS (
		SELECT
			1
		FROM
			Information_Mart.bv.PIT_Shipper AS pit
		WHERE
			snap.DV_Snapshot_Datetime = pit.DV_Snapshot_Datetime
			AND hub.HK_H_Shipper = pit.HK_H_Shipper
	);
GO
/****** Object:  View [bv].[v_stage_PIT_Supplier]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_PIT_Supplier] (
	  DV_Snapshot_Datetime
	, HK_H_Supplier
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Supplier__S_H_Supplier_Northwind
	, DV_Load_Datetime__S_H_Supplier_Northwind
	, HK_H_Supplier__S_HDT_H_Supplier_Northwind
	, DV_Load_Datetime__S_HDT_H_Supplier_Northwind
	, SupplierID
	, Is_Deleted_Flag
)
AS
SELECT
	  snap.DV_Snapshot_Datetime
	, hub.HK_H_Supplier
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, 'SYSTEM | Information_Mart.bv.v_stage_PIT_Supplier' AS DV_Record_Source
	, COALESCE(sat_h.HK_H_Supplier, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Supplier__S_H_Supplier_Northwind
	, COALESCE(sat_h.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_H_Supplier_Northwind
	, COALESCE(sat_hdt.HK_H_Supplier, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Supplier__S_HDT_H_Supplier_Northwind
	, COALESCE(sat_hdt.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_HDT_H_Supplier_Northwind
	, hub.SupplierID
	, sat_hdt.Is_Deleted_Flag
FROM
	Data_Vault.rv.H_Supplier AS hub
		CROSS JOIN Information_Mart.bv.R_Snapshot_Control AS snap
		LEFT JOIN Data_Vault.bv.v_history_S_H_Supplier_Northwind AS sat_h
			ON hub.HK_H_Supplier = sat_h.HK_H_Supplier
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_h.DV_Load_Datetime_Start AND sat_h.DV_Load_Datetime_End
		LEFT JOIN Data_Vault.bv.v_history_S_HDT_H_Supplier_Northwind AS sat_hdt
			ON hub.HK_H_Supplier = sat_hdt.HK_H_Supplier
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_hdt.DV_Load_Datetime_Start AND sat_hdt.DV_Load_Datetime_End 
WHERE
	NOT EXISTS (
		SELECT
			1
		FROM
			Information_Mart.bv.PIT_Supplier AS pit
		WHERE
			snap.DV_Snapshot_Datetime = pit.DV_Snapshot_Datetime
			AND hub.HK_H_Supplier = pit.HK_H_Supplier
	);
GO
/****** Object:  View [bv].[v_stage_PIT_Territory]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_PIT_Territory] (
	  DV_Snapshot_Datetime
	, HK_H_Territory
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Territory__S_H_Territory_Northwind
	, DV_Load_Datetime__S_H_Territory_Northwind
	, HK_H_Territory__S_HDT_H_Territory_Northwind
	, DV_Load_Datetime__S_HDT_H_Territory_Northwind
	, TerritoryID
	, Is_Deleted_Flag
)
AS
SELECT
	  snap.DV_Snapshot_Datetime
	, hub.HK_H_Territory
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, 'SYSTEM | Information_Mart.bv.v_stage_PIT_Territory' AS DV_Record_Source
	, COALESCE(sat_h.HK_H_Territory, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Territory__S_H_Territory_Northwind
	, COALESCE(sat_h.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_H_Territory_Northwind
	, COALESCE(sat_hdt.HK_H_Territory, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_H_Territory__S_HDT_H_Territory_Northwind
	, COALESCE(sat_hdt.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_HDT_H_Territory_Northwind
	, hub.TerritoryID
	, sat_hdt.Is_Deleted_Flag
FROM
	Data_Vault.rv.H_Territory AS hub
		CROSS JOIN Information_Mart.bv.R_Snapshot_Control AS snap
		LEFT JOIN Data_Vault.bv.v_history_S_H_Territory_Northwind AS sat_h
			ON hub.HK_H_Territory = sat_h.HK_H_Territory
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_h.DV_Load_Datetime_Start AND sat_h.DV_Load_Datetime_End
		LEFT JOIN Data_Vault.bv.v_history_S_HDT_H_Territory_Northwind AS sat_hdt
			ON hub.HK_H_Territory = sat_hdt.HK_H_Territory
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_hdt.DV_Load_Datetime_Start AND sat_hdt.DV_Load_Datetime_End
WHERE
	NOT EXISTS (
		SELECT
			1
		FROM
			Information_Mart.bv.PIT_Territory AS pit
		WHERE
			snap.DV_Snapshot_Datetime = pit.DV_Snapshot_Datetime
			AND hub.HK_H_Territory = pit.HK_H_Territory
	);
GO
/****** Object:  Table [bv].[PIT_Order_Detail]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bv].[PIT_Order_Detail](
	[DV_Sequence_Number] [bigint] IDENTITY(1,1) NOT NULL,
	[DV_Snapshot_Datetime] [datetimeoffset](7) NOT NULL,
	[HK_L_Order_Detail] [binary](32) NOT NULL,
	[DV_Load_Datetime] [datetimeoffset](7) NOT NULL,
	[DV_Record_Source] [varchar](255) NOT NULL,
	[HK_L_Order_Detail__S_L_Order_Detail_Northwind] [binary](32) NOT NULL,
	[DV_Load_Datetime__S_L_Order_Detail_Northwind] [datetimeoffset](7) NOT NULL,
	[HK_L_Order_Detail__S_LDT_L_Order_Detail_Northwind] [binary](32) NOT NULL,
	[DV_Load_Datetime__S_LDT_L_Order_Detail_Northwind] [datetimeoffset](7) NOT NULL,
	[OrderID] [int] NULL,
	[ProductID] [int] NULL,
	[Is_Deleted_Flag] [bit] NULL,
 CONSTRAINT [PK_PIT_Order_Detail] PRIMARY KEY CLUSTERED 
(
	[DV_Sequence_Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX],
 CONSTRAINT [UK_PIT_Order_Detail] UNIQUE NONCLUSTERED 
(
	[DV_Snapshot_Datetime] ASC,
	[HK_L_Order_Detail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  View [bv].[v_stage_PIT_Order_Detail]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_PIT_Order_Detail] (
	  DV_Snapshot_Datetime
	, HK_L_Order_Detail
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_L_Order_Detail__S_L_Order_Detail_Northwind
	, DV_Load_Datetime__S_L_Order_Detail_Northwind
	, HK_L_Order_Detail__S_LDT_L_Order_Detail_Northwind
	, DV_Load_Datetime__S_LDT_L_Order_Detail_Northwind
	, OrderID 
	, ProductID
	, Is_Deleted_Flag
)
AS
SELECT
	  snap.DV_Snapshot_Datetime
	, link.HK_L_Order_Detail
	, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
	, 'SYSTEM | Information_Mart.bv.v_stage_PIT_Order_Detail' AS DV_Record_Source
	, COALESCE(sat_l.HK_L_Order_Detail, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_L_Order_Detail__S_L_Order_Detail_Northwind
	, COALESCE(sat_l.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_L_Order_Detail_Northwind
	, COALESCE(sat_ldt.HK_L_Order_Detail, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))) AS HK_L_Order_Detail__S_LDT_L_Order_Detail_Northwind
	, COALESCE(sat_ldt.DV_Load_Datetime_Start, '1900-01-01 00:00:00.0000000 +00:00') AS DV_Load_Datetime__S_LDT_L_Order_Detail_Northwind
	, hub_order.OrderID 
	, hub_product.ProductID
	, sat_ldt.Is_Deleted_Flag
FROM
	Data_Vault.rv.L_Order_Detail AS link
		CROSS JOIN Information_Mart.bv.R_Snapshot_Control AS snap
		LEFT JOIN Data_Vault.rv.H_Order AS hub_order
			ON link.HK_H_Order = hub_order.HK_H_Order
		LEFT JOIN Data_Vault.rv.H_Product AS hub_product
			ON link.HK_H_Product = hub_product.HK_H_Product
		LEFT JOIN Data_Vault.bv.v_history_S_L_Order_Detail_Northwind AS sat_l
			ON link.HK_L_Order_Detail = sat_l.HK_L_Order_Detail
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_l.DV_Load_Datetime_Start AND sat_l.DV_Load_Datetime_End
		LEFT JOIN Data_Vault.bv.v_history_S_LDT_L_Order_Detail_Northwind AS sat_ldt
			ON link.HK_L_Order_Detail = sat_ldt.HK_L_Order_Detail
		   AND snap.DV_Snapshot_Datetime BETWEEN sat_ldt.DV_Load_Datetime_Start AND sat_ldt.DV_Load_Datetime_End
WHERE
	NOT EXISTS (
		SELECT
			1
		FROM
			Information_Mart.bv.PIT_Order_Detail AS pit
		WHERE
			snap.DV_Snapshot_Datetime = pit.DV_Snapshot_Datetime
			AND link.HK_L_Order_Detail = pit.HK_L_Order_Detail
	);
GO
/****** Object:  View [bv].[v_stage_R_Snapshot_Control]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bv].[v_stage_R_Snapshot_Control] (
	  DV_Snapshot_Datetime
	, DV_Load_Datetime
	, DV_Record_Source
	, Date_Key
	, Time_Key
)
AS
WITH 
	cte_date_and_time AS (
		SELECT
			  -- Date
			  ref_date.Date_Key
			, ref_date.[Date]
			, ref_date.Date_String
			, ref_date.Start_Datetime
			, ref_date.End_Datetime
			, ref_date.Day_Of_Month_Number
			, ref_date.Month_Number
			, ref_date.Month_Name
			, ref_date.Year_Number
			, ref_date.Day_Of_Week_Number
			, ref_date.Day_Of_Week_Name
			, ref_date.Quarter_Number
			, ref_date.Quarter_Name

			  -- Time
			, ref_time.Time_Key
			, ref_time.[Time]
			, ref_time.Time_String
			, ref_time.Hours_Of_Day
			, ref_time.Minutes_Of_Hour
			, ref_time.Seconds_Of_Minute
		FROM
			Data_Vault.rv.R_Date AS ref_date
				CROSS JOIN Data_Vault.rv.R_Time AS ref_time
		WHERE
			ref_date.[date] <= CAST(SYSDATETIME() AS date)
			AND ref_time.[time] <= CAST(SYSDATETIME() AS time)
	),

	cte_stage AS (
		
		-- Midnight, first day of the month, previous 5 years
		SELECT
			  CAST(CONCAT(Date_String, ' ', Time_String) AS datetimeoffset(7)) AT TIME ZONE 'New Zealand Standard Time' AS DV_Snapshot_Datetime
			, Date_Key
			, Time_Key
		FROM
			cte_date_and_time
		WHERE
			Time_Key = 1  -- 00:00:00
			AND Day_Of_Month_Number = 1  -- First day of each month
			AND Year_Number > (YEAR(SYSDATETIME()) - 5)  -- Last 5 years

		UNION

		-- Midnight, last 30 days
		SELECT
			  CAST(CONCAT(Date_String, ' ', Time_String) AS datetimeoffset(7)) AT TIME ZONE 'New Zealand Standard Time' AS DV_Snapshot_Datetime
			, Date_Key
			, Time_Key
		FROM
			cte_date_and_time
		WHERE
			Time_Key = 1  -- 00:00:00
			AND [Date] > DATEADD(DAY, -30, CAST(SYSDATETIME() AS date))  -- Last 30 days

		UNION

		-- Current datetime
		SELECT
			   SYSDATETIME() AT TIME ZONE 'New Zealand Standard Time' AS DV_Snapshot_Datetime
			 , CAST(CONVERT(varchar(8), SYSDATETIME() AT TIME ZONE 'New Zealand Standard Time', 112) AS int) AS Date_Key
			 , (SELECT Time_Key FROM Data_Vault.rv.R_Time WHERE [Time] = CAST(SYSDATETIME() AT TIME ZONE 'New Zealand Standard Time' AS time(0))) AS Time_Key

	)

	SELECT
		  DV_Snapshot_Datetime
		, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
		, 'SYSTEM | Information_Mart.bv.v_stage_R_Snapshot_Control' AS DV_Record_Source
		, Date_Key
		, Time_Key
	FROM
		cte_stage AS stage;
GO
/****** Object:  View [star].[Dim_Order_Required_Date]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [star].[Dim_Order_Required_Date] (
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
/****** Object:  View [star].[Dim_Order_Shipped_Date]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [star].[Dim_Order_Shipped_Date] (
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
/****** Object:  View [star].[Dim_Order_Submitted_Date]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [star].[Dim_Order_Submitted_Date] (
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
/****** Object:  StoredProcedure [bv].[usp_delete_B_Customer_Type]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_delete_B_Customer_Type]
AS
	BEGIN

		DELETE bridge
		FROM
			Information_Mart.bv.B_Customer_Type AS bridge
				LEFT JOIN Information_Mart.bv.R_Snapshot_Control AS snap
					ON bridge.DV_Snapshot_Datetime = snap.DV_Snapshot_Datetime
		WHERE
			snap.DV_Snapshot_Datetime IS NULL;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_delete_B_Employee_Reporting_Line]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_delete_B_Employee_Reporting_Line]
AS
	BEGIN

		DELETE bridge
		FROM
			Information_Mart.bv.B_Employee_Reporting_Line AS bridge
				LEFT JOIN Information_Mart.bv.R_Snapshot_Control AS snap
					ON bridge.DV_Snapshot_Datetime = snap.DV_Snapshot_Datetime
		WHERE
			snap.DV_Snapshot_Datetime IS NULL;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_delete_B_Employee_Territory]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_delete_B_Employee_Territory]
AS
	BEGIN

		DELETE bridge
		FROM
			Information_Mart.bv.B_Employee_Territory AS bridge
				LEFT JOIN Information_Mart.bv.R_Snapshot_Control AS snap
					ON bridge.DV_Snapshot_Datetime = snap.DV_Snapshot_Datetime
		WHERE
			snap.DV_Snapshot_Datetime IS NULL;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_delete_B_Order]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_delete_B_Order]
AS
	BEGIN

		DELETE bridge
		FROM
			Information_Mart.bv.B_Order AS bridge
				LEFT JOIN Information_Mart.bv.R_Snapshot_Control AS snap
					ON bridge.DV_Snapshot_Datetime = snap.DV_Snapshot_Datetime
		WHERE
			snap.DV_Snapshot_Datetime IS NULL;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_delete_B_Order_Detail]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_delete_B_Order_Detail]
AS
	BEGIN

		DELETE bridge
		FROM
			Information_Mart.bv.B_Order_Detail AS bridge
				LEFT JOIN Information_Mart.bv.R_Snapshot_Control AS snap
					ON bridge.DV_Snapshot_Datetime = snap.DV_Snapshot_Datetime
		WHERE
			snap.DV_Snapshot_Datetime IS NULL;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_delete_B_Product_Supplier_Category]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_delete_B_Product_Supplier_Category]
AS
	BEGIN

		DELETE bridge
		FROM
			Information_Mart.bv.B_Product_Supplier_Category AS bridge
				LEFT JOIN Information_Mart.bv.R_Snapshot_Control AS snap
					ON bridge.DV_Snapshot_Datetime = snap.DV_Snapshot_Datetime
		WHERE
			snap.DV_Snapshot_Datetime IS NULL;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_delete_B_Territory_Region]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_delete_B_Territory_Region]
AS
	BEGIN

		DELETE bridge
		FROM
			Information_Mart.bv.B_Territory_Region AS bridge
				LEFT JOIN Information_Mart.bv.R_Snapshot_Control AS snap
					ON bridge.DV_Snapshot_Datetime = snap.DV_Snapshot_Datetime
		WHERE
			snap.DV_Snapshot_Datetime IS NULL;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_delete_PIT_Customer]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_delete_PIT_Customer]
AS
	BEGIN

		DELETE pit
		FROM
			Information_Mart.bv.PIT_Customer AS pit
				LEFT JOIN Information_Mart.bv.R_Snapshot_Control AS snap
					ON pit.DV_Snapshot_Datetime = snap.DV_Snapshot_Datetime
		WHERE
			snap.DV_Snapshot_Datetime IS NULL;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_delete_PIT_Customer_Type]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_delete_PIT_Customer_Type]
AS
	BEGIN

		DELETE pit
		FROM
			Information_Mart.bv.PIT_Customer_Type AS pit
				LEFT JOIN Information_Mart.bv.R_Snapshot_Control AS snap
					ON pit.DV_Snapshot_Datetime = snap.DV_Snapshot_Datetime
		WHERE
			snap.DV_Snapshot_Datetime IS NULL;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_delete_PIT_Employee]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_delete_PIT_Employee]
AS
	BEGIN

		DELETE pit
		FROM
			Information_Mart.bv.PIT_Employee AS pit
				LEFT JOIN Information_Mart.bv.R_Snapshot_Control AS snap
					ON pit.DV_Snapshot_Datetime = snap.DV_Snapshot_Datetime
		WHERE
			snap.DV_Snapshot_Datetime IS NULL;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_delete_PIT_Order]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_delete_PIT_Order]
AS
	BEGIN

		DELETE pit
		FROM
			Information_Mart.bv.PIT_Order AS pit
				LEFT JOIN Information_Mart.bv.R_Snapshot_Control AS snap
					ON pit.DV_Snapshot_Datetime = snap.DV_Snapshot_Datetime
		WHERE
			snap.DV_Snapshot_Datetime IS NULL;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_delete_PIT_Order_Detail]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_delete_PIT_Order_Detail]
AS
	BEGIN

		DELETE pit
		FROM
			Information_Mart.bv.PIT_Order_Detail AS pit
				LEFT JOIN Information_Mart.bv.R_Snapshot_Control AS snap
					ON pit.DV_Snapshot_Datetime = snap.DV_Snapshot_Datetime
		WHERE
			snap.DV_Snapshot_Datetime IS NULL;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_delete_PIT_Product]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_delete_PIT_Product]
AS
	BEGIN

		DELETE pit
		FROM
			Information_Mart.bv.PIT_Product AS pit
				LEFT JOIN Information_Mart.bv.R_Snapshot_Control AS snap
					ON pit.DV_Snapshot_Datetime = snap.DV_Snapshot_Datetime
		WHERE
			snap.DV_Snapshot_Datetime IS NULL;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_delete_PIT_Product_Category]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_delete_PIT_Product_Category]
AS
	BEGIN

		DELETE pit
		FROM
			Information_Mart.bv.PIT_Product_Category AS pit
				LEFT JOIN Information_Mart.bv.R_Snapshot_Control AS snap
					ON pit.DV_Snapshot_Datetime = snap.DV_Snapshot_Datetime
		WHERE
			snap.DV_Snapshot_Datetime IS NULL;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_delete_PIT_Region]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_delete_PIT_Region]
AS
	BEGIN

		DELETE pit
		FROM
			Information_Mart.bv.PIT_Region AS pit
				LEFT JOIN Information_Mart.bv.R_Snapshot_Control AS snap
					ON pit.DV_Snapshot_Datetime = snap.DV_Snapshot_Datetime
		WHERE
			snap.DV_Snapshot_Datetime IS NULL;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_delete_PIT_Shipper]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_delete_PIT_Shipper]
AS
	BEGIN

		DELETE pit
		FROM
			Information_Mart.bv.PIT_Shipper AS pit
				LEFT JOIN Information_Mart.bv.R_Snapshot_Control AS snap
					ON pit.DV_Snapshot_Datetime = snap.DV_Snapshot_Datetime
		WHERE
			snap.DV_Snapshot_Datetime IS NULL;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_delete_PIT_Supplier]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_delete_PIT_Supplier]
AS
	BEGIN

		DELETE pit
		FROM
			Information_Mart.bv.PIT_Supplier AS pit
				LEFT JOIN Information_Mart.bv.R_Snapshot_Control AS snap
					ON pit.DV_Snapshot_Datetime = snap.DV_Snapshot_Datetime
		WHERE
			snap.DV_Snapshot_Datetime IS NULL;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_delete_PIT_Territory]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_delete_PIT_Territory]
AS
	BEGIN

		DELETE pit
		FROM
			Information_Mart.bv.PIT_Territory AS pit
				LEFT JOIN Information_Mart.bv.R_Snapshot_Control AS snap
					ON pit.DV_Snapshot_Datetime = snap.DV_Snapshot_Datetime
		WHERE
			snap.DV_Snapshot_Datetime IS NULL;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_B_Customer_Type]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_B_Customer_Type]
AS
	BEGIN

		INSERT INTO Information_Mart.bv.B_Customer_Type (
			  DV_Snapshot_Datetime
			, HK_L_Customer_Type
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Customer
			, HK_H_Customer_Type
			, CustomerID
			, CustomerTypeID
		)
		SELECT
			  DV_Snapshot_Datetime
			, HK_L_Customer_Type
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Customer
			, HK_H_Customer_Type
			, CustomerID
			, CustomerTypeID
		FROM
			Information_Mart.bv.v_stage_B_Customer_Type;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_B_Employee_Reporting_Line]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_B_Employee_Reporting_Line]
AS
	BEGIN

		INSERT INTO Information_Mart.bv.B_Employee_Reporting_Line (
			  DV_Snapshot_Datetime
			, HK_L_Employee_Reporting_Line
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Employee__Direct_Report
			, HK_H_Employee__Manager
			, EmployeeID__Direct_Report
			, EmployeeID__Manager
		)
		SELECT
			  DV_Snapshot_Datetime
			, HK_L_Employee_Reporting_Line
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Employee__Direct_Report
			, HK_H_Employee__Manager
			, EmployeeID__Direct_Report
			, EmployeeID__Manager
		FROM
			Information_Mart.bv.v_stage_B_Employee_Reporting_Line;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_B_Employee_Territory]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_B_Employee_Territory]
AS
	BEGIN

		INSERT INTO Information_Mart.bv.B_Employee_Territory (
			  DV_Snapshot_Datetime
			, HK_L_Employee_Territory
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Employee
			, HK_H_Territory
			, EmployeeID
			, TerritoryID
		)
		SELECT
			  DV_Snapshot_Datetime
			, HK_L_Employee_Territory
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Employee
			, HK_H_Territory
			, EmployeeID
			, TerritoryID
		FROM
			Information_Mart.bv.v_stage_B_Employee_Territory;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_B_Order]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_B_Order]
AS
	BEGIN

		INSERT INTO Information_Mart.bv.B_Order (
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
		SELECT
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
		FROM
			Information_Mart.bv.v_stage_B_Order;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_B_Order_Detail]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_B_Order_Detail]
AS
	BEGIN

		INSERT INTO Information_Mart.bv.B_Order_Detail (
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
		SELECT
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
		FROM
			Information_Mart.bv.v_stage_B_Order_Detail;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_B_Product]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_B_Product]
AS
	BEGIN

		INSERT INTO Information_Mart.bv.B_Product (
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
		SELECT
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
		FROM
			Information_Mart.bv.v_stage_B_Product;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_B_Product_Supplier_Category]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_B_Product_Supplier_Category]
AS
	BEGIN

		INSERT INTO Information_Mart.bv.B_Product_Supplier_Category (
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
		SELECT
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
		FROM
			Information_Mart.bv.v_stage_B_Product_Supplier_Category;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_B_Territory_Region]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_B_Territory_Region]
AS
	BEGIN

		INSERT INTO Information_Mart.bv.B_Territory_Region (
			  DV_Snapshot_Datetime
			, HK_L_Territory_Region
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Territory
			, HK_H_Region
			, TerritoryID
			, RegionID
		)
		SELECT
			  DV_Snapshot_Datetime
			, HK_L_Territory_Region
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Territory
			, HK_H_Region
			, TerritoryID
			, RegionID
		FROM
			Information_Mart.bv.v_stage_B_Territory_Region;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_PIT_Customer]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_PIT_Customer]
AS
	BEGIN

		INSERT INTO Information_Mart.bv.PIT_Customer (
			  DV_Snapshot_Datetime
			, HK_H_Customer
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Customer__S_H_Customer_Northwind
			, DV_Load_Datetime__S_H_Customer_Northwind
			, HK_H_Customer__S_HDT_H_Customer_Northwind
			, DV_Load_Datetime__S_HDT_H_Customer_Northwind
			, CustomerID
			, Is_Deleted_Flag
		)
		SELECT
			  DV_Snapshot_Datetime
			, HK_H_Customer
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Customer__S_H_Customer_Northwind
			, DV_Load_Datetime__S_H_Customer_Northwind
			, HK_H_Customer__S_HDT_H_Customer_Northwind
			, DV_Load_Datetime__S_HDT_H_Customer_Northwind
			, CustomerID
			, Is_Deleted_Flag
		FROM
			Information_Mart.bv.v_stage_PIT_Customer;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_PIT_Customer_Type]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_PIT_Customer_Type]
AS
	BEGIN

		INSERT INTO Information_Mart.bv.PIT_Customer_Type (
			  DV_Snapshot_Datetime
			, HK_H_Customer_Type
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Customer_Type__S_H_Customer_Type_Northwind
			, DV_Load_Datetime__S_H_Customer_Type_Northwind
			, HK_H_Customer_Type__S_HDT_H_Customer_Type_Northwind
			, DV_Load_Datetime__S_HDT_H_Customer_Type_Northwind
			, CustomerTypeID
			, Is_Deleted_Flag	
		)
		SELECT
			  DV_Snapshot_Datetime
			, HK_H_Customer_Type
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Customer_Type__S_H_Customer_Type_Northwind
			, DV_Load_Datetime__S_H_Customer_Type_Northwind
			, HK_H_Customer_Type__S_HDT_H_Customer_Type_Northwind
			, DV_Load_Datetime__S_HDT_H_Customer_Type_Northwind
			, CustomerTypeID
			, Is_Deleted_Flag			
		FROM
			Information_Mart.bv.v_stage_PIT_Customer_Type;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_PIT_Employee]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_PIT_Employee]
AS
	BEGIN

		INSERT INTO Information_Mart.bv.PIT_Employee (
			  DV_Snapshot_Datetime
			, HK_H_Employee
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Employee__S_H_Employee_Northwind
			, DV_Load_Datetime__S_H_Employee_Northwind
			, HK_H_Employee__S_HDT_H_Employee_Northwind
			, DV_Load_Datetime__S_HDT_H_Employee_Northwind
			, EmployeeID
			, Employee_Name
			, Is_Deleted_Flag
		)
		SELECT
			  DV_Snapshot_Datetime
			, HK_H_Employee
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Employee__S_H_Employee_Northwind
			, DV_Load_Datetime__S_H_Employee_Northwind
			, HK_H_Employee__S_HDT_H_Employee_Northwind
			, DV_Load_Datetime__S_HDT_H_Employee_Northwind
			, EmployeeID
			, Employee_Name
			, Is_Deleted_Flag			
		FROM
			Information_Mart.bv.v_stage_PIT_Employee;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_PIT_Order]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_PIT_Order]
AS
	BEGIN

		INSERT INTO Information_Mart.bv.PIT_Order (
			  DV_Snapshot_Datetime
			, HK_H_Order
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Order__S_H_Order_Northwind
			, DV_Load_Datetime__S_H_Order_Northwind
			, HK_H_Order__S_HDT_H_Order_Northwind
			, DV_Load_Datetime__S_HDT_H_Order_Northwind
			, OrderID
			, Is_Deleted_Flag
		)
		SELECT
			  DV_Snapshot_Datetime
			, HK_H_Order
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Order__S_H_Order_Northwind
			, DV_Load_Datetime__S_H_Order_Northwind
			, HK_H_Order__S_HDT_H_Order_Northwind
			, DV_Load_Datetime__S_HDT_H_Order_Northwind
			, OrderID
			, Is_Deleted_Flag			
		FROM
			Information_Mart.bv.v_stage_PIT_Order;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_PIT_Order_Detail]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_PIT_Order_Detail]
AS
	BEGIN

		INSERT INTO Information_Mart.bv.PIT_Order_Detail (
			  DV_Snapshot_Datetime 
			, HK_L_Order_Detail 
			, DV_Load_Datetime 
			, DV_Record_Source 
			, HK_L_Order_Detail__S_L_Order_Detail_Northwind 
			, DV_Load_Datetime__S_L_Order_Detail_Northwind 
			, HK_L_Order_Detail__S_LDT_L_Order_Detail_Northwind 
			, DV_Load_Datetime__S_LDT_L_Order_Detail_Northwind 
			, OrderID 
			, ProductID 
			, Is_Deleted_Flag 
		)
		SELECT
			  DV_Snapshot_Datetime 
			, HK_L_Order_Detail 
			, DV_Load_Datetime 
			, DV_Record_Source 
			, HK_L_Order_Detail__S_L_Order_Detail_Northwind 
			, DV_Load_Datetime__S_L_Order_Detail_Northwind 
			, HK_L_Order_Detail__S_LDT_L_Order_Detail_Northwind 
			, DV_Load_Datetime__S_LDT_L_Order_Detail_Northwind 
			, OrderID 
			, ProductID 
			, Is_Deleted_Flag		
		FROM
			Information_Mart.bv.v_stage_PIT_Order_Detail;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_PIT_Product]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_PIT_Product]
AS
	BEGIN

		INSERT INTO Information_Mart.bv.PIT_Product (
			  DV_Snapshot_Datetime
			, HK_H_Product
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Product__S_H_Product_Northwind
			, DV_Load_Datetime__S_H_Product_Northwind
			, HK_H_Product__S_HDT_H_Product_Northwind
			, DV_Load_Datetime__S_HDT_H_Product_Northwind
			, ProductID
			, Is_Deleted_Flag
		)
		SELECT
			  DV_Snapshot_Datetime
			, HK_H_Product
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Product__S_H_Product_Northwind
			, DV_Load_Datetime__S_H_Product_Northwind
			, HK_H_Product__S_HDT_H_Product_Northwind
			, DV_Load_Datetime__S_HDT_H_Product_Northwind
			, ProductID
			, Is_Deleted_Flag			
		FROM
			Information_Mart.bv.v_stage_PIT_Product;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_PIT_Product_Category]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_PIT_Product_Category]
AS
	BEGIN

		INSERT INTO Information_Mart.bv.PIT_Product_Category (
			  DV_Snapshot_Datetime
			, HK_H_Product_Category
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Product_Category__S_H_Product_Category_Northwind
			, DV_Load_Datetime__S_H_Product_Category_Northwind
			, HK_H_Product_Category__S_HDT_H_Product_Category_Northwind
			, DV_Load_Datetime__S_HDT_H_Product_Category_Northwind
			, CategoryID
			, Is_Deleted_Flag
		)
		SELECT
			  DV_Snapshot_Datetime
			, HK_H_Product_Category
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Product_Category__S_H_Product_Category_Northwind
			, DV_Load_Datetime__S_H_Product_Category_Northwind
			, HK_H_Product_Category__S_HDT_H_Product_Category_Northwind
			, DV_Load_Datetime__S_HDT_H_Product_Category_Northwind
			, CategoryID
			, Is_Deleted_Flag			
		FROM
			Information_Mart.bv.v_stage_PIT_Product_Category;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_PIT_Region]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_PIT_Region]
AS
	BEGIN

		INSERT INTO Information_Mart.bv.PIT_Region (
			  DV_Snapshot_Datetime
			, HK_H_Region
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Region__S_H_Region_Northwind
			, DV_Load_Datetime__S_H_Region_Northwind
			, HK_H_Region__S_HDT_H_Region_Northwind
			, DV_Load_Datetime__S_HDT_H_Region_Northwind
			, RegionID
			, Is_Deleted_Flag
		)
		SELECT
			  DV_Snapshot_Datetime
			, HK_H_Region
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Region__S_H_Region_Northwind
			, DV_Load_Datetime__S_H_Region_Northwind
			, HK_H_Region__S_HDT_H_Region_Northwind
			, DV_Load_Datetime__S_HDT_H_Region_Northwind
			, RegionID
			, Is_Deleted_Flag			
		FROM
			Information_Mart.bv.v_stage_PIT_Region;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_PIT_Shipper]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_PIT_Shipper]
AS
	BEGIN

		INSERT INTO Information_Mart.bv.PIT_Shipper (
			  DV_Snapshot_Datetime
			, HK_H_Shipper
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Shipper__S_H_Shipper_Northwind
			, DV_Load_Datetime__S_H_Shipper_Northwind
			, HK_H_Shipper__S_HDT_H_Shipper_Northwind
			, DV_Load_Datetime__S_HDT_H_Shipper_Northwind
			, ShipperID
			, Is_Deleted_Flag
		)
		SELECT
			  DV_Snapshot_Datetime
			, HK_H_Shipper
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Shipper__S_H_Shipper_Northwind
			, DV_Load_Datetime__S_H_Shipper_Northwind
			, HK_H_Shipper__S_HDT_H_Shipper_Northwind
			, DV_Load_Datetime__S_HDT_H_Shipper_Northwind
			, ShipperID
			, Is_Deleted_Flag			
		FROM
			Information_Mart.bv.v_stage_PIT_Shipper;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_PIT_Supplier]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_PIT_Supplier]
AS
	BEGIN

		INSERT INTO Information_Mart.bv.PIT_Supplier (
			  DV_Snapshot_Datetime
			, HK_H_Supplier
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Supplier__S_H_Supplier_Northwind
			, DV_Load_Datetime__S_H_Supplier_Northwind
			, HK_H_Supplier__S_HDT_H_Supplier_Northwind
			, DV_Load_Datetime__S_HDT_H_Supplier_Northwind
			, SupplierID
			, Is_Deleted_Flag
		)
		SELECT
			  DV_Snapshot_Datetime
			, HK_H_Supplier
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Supplier__S_H_Supplier_Northwind
			, DV_Load_Datetime__S_H_Supplier_Northwind
			, HK_H_Supplier__S_HDT_H_Supplier_Northwind
			, DV_Load_Datetime__S_HDT_H_Supplier_Northwind
			, SupplierID
			, Is_Deleted_Flag			
		FROM
			Information_Mart.bv.v_stage_PIT_Supplier;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_PIT_Territory]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_PIT_Territory]
AS
	BEGIN

		INSERT INTO Information_Mart.bv.PIT_Territory (
			  DV_Snapshot_Datetime
			, HK_H_Territory
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Territory__S_H_Territory_Northwind
			, DV_Load_Datetime__S_H_Territory_Northwind
			, HK_H_Territory__S_HDT_H_Territory_Northwind
			, DV_Load_Datetime__S_HDT_H_Territory_Northwind
			, TerritoryID
			, Is_Deleted_Flag
		)
		SELECT
			  DV_Snapshot_Datetime
			, HK_H_Territory
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Territory__S_H_Territory_Northwind
			, DV_Load_Datetime__S_H_Territory_Northwind
			, HK_H_Territory__S_HDT_H_Territory_Northwind
			, DV_Load_Datetime__S_HDT_H_Territory_Northwind
			, TerritoryID
			, Is_Deleted_Flag			
		FROM
			Information_Mart.bv.v_stage_PIT_Territory;

	END
GO
/****** Object:  StoredProcedure [bv].[usp_insert_R_Snapshot_Control]    Script Date: 17/10/2023 6:38:31 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bv].[usp_insert_R_Snapshot_Control]
AS
	BEGIN

		TRUNCATE TABLE Information_Mart.bv.R_Snapshot_Control;

		INSERT INTO Information_Mart.bv.R_Snapshot_Control (
			  DV_Snapshot_Datetime
			, DV_Load_Datetime
			, DV_Record_Source
			, Date_Key
			, Time_Key
		)
		SELECT
			  DV_Snapshot_Datetime
			, DV_Load_Datetime
			, DV_Record_Source
			, Date_Key
			, Time_Key
		FROM
			Information_Mart.bv.v_stage_R_Snapshot_Control;

	END
GO
USE [master]
GO
ALTER DATABASE [Information_Mart] SET  READ_WRITE 
GO
