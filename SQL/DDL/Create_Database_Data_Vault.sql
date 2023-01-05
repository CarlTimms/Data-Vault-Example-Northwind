/*
	
	Create Database Data_Vault.sql

	Create database Data_Vault. 
	Raw and Business Vault tables and views.


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
	N'CREATE DATABASE [Data_Vault]
		ON PRIMARY 
			  (
				  NAME = N''DataVault''
				, FILENAME = N''' + @device_directory + N'DataVault.mdf''
				, SIZE = 512KB
				, MAXSIZE = UNLIMITED
				, FILEGROWTH = 1024KB
			  )
			, FILEGROUP [ARCHIVE] ( 
				  NAME = N''DataVault_archive''
				, FILENAME = N''' + @device_directory + N'DataVault_archive.ndf''
				, SIZE = 512KB
				, MAXSIZE = UNLIMITED
				, FILEGROWTH = 10%
			  )
			, FILEGROUP [BUSINESS] ( 
				  NAME = N''DataVault_business''
				, FILENAME = N''' + @device_directory + N'DataVault_business.ndf''
				, SIZE = 512KB
				, MAXSIZE = UNLIMITED
				, FILEGROWTH = 1024000KB
			  )
			, FILEGROUP [DATA] ( 
				  NAME = N''DataVault_data''
				, FILENAME = N''' + @device_directory + N'DataVault_data.ndf''
				, SIZE = 512KB
				, MAXSIZE = UNLIMITED
				, FILEGROWTH = 10240000KB
			  )
			, FILEGROUP [INDEX] (
				  NAME = N''DataVault_index''
				, FILENAME = N''' + @device_directory + N'DataVault_index.ndf''
				, SIZE = 512KB
				, MAXSIZE = UNLIMITED
				, FILEGROWTH = 10%
			  )
		LOG ON 
			(
				  NAME = N''DataVault_log''
				, FILENAME = N''' + @device_directory + N'DataVault_log.ldf''
				, SIZE = 512KB
				, MAXSIZE = 2048GB
				, FILEGROWTH = 10%
			)
		WITH
			CATALOG_COLLATION = DATABASE_DEFAULT;'
);
GO


ALTER DATABASE [Data_Vault] SET COMPATIBILITY_LEVEL = 120
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
/****** Object:  Schema [biz]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE SCHEMA [biz]
GO
/****** Object:  Schema [raw]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE SCHEMA [raw]
GO
/****** Object:  Table [raw].[R_Date]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[R_Date](
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[Date_Key] [int] NOT NULL,
	[Date] [date] NOT NULL,
	[Datetime_Start] [datetime2](7) NOT NULL,
	[Datetime_End] [datetime2](7) NOT NULL,
	[Day_Of_Month_Number] [int] NOT NULL,
	[Month_Number] [int] NOT NULL,
	[Month_Name] [varchar](9) NOT NULL,
	[Year_Number] [int] NOT NULL,
	[Day_Of_Week_Number] [int] NOT NULL,
	[Day_Of_Week_Name] [varchar](9) NOT NULL,
	[Quarter_Number] [int] NOT NULL,
	[Quarter_Name] [varchar](13) NOT NULL,
	[Sort_Order] [int] NOT NULL,
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
/****** Object:  View [biz].[v_R_PIT_Window]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [biz].[v_R_PIT_Window]
AS   
	SELECT
		  ref_date.[Date_Key]
		, ref_date.[Date]
	FROM
		( 
			SELECT
				  [Date]
				, DATEFROMPARTS([Year_Number], [Month_Number], 1 ) AS Month_Start_Date
				, DATEFROMPARTS([Year_Number], 1, 1 ) AS Year_Start_Date
			FROM
				[Data_Vault].[raw].[R_Date]
			WHERE
				CONVERT(date, SYSDATETIME()) = [Date]
		) AS ref_date_current
			CROSS JOIN [Data_Vault].[raw].[R_Date] ref_date
	WHERE
		-- All snapshots from the current month
		(
			ref_date.[Date] <= ref_date_current.[Date]
			AND ref_date.[Date] >= ref_date_current.[Month_Start_Date]
		)
		-- One snapshot per week for the current year
		OR (
			ref_date.[Date] <= ref_date_current.[Date]
			AND ref_date.[Date] >= ref_date_current.[Year_Start_Date]
			AND ref_date.[Day_Of_Week_Number] = 1  -- Monday	
		)
		-- One snapshot per month for the last five years
		OR (
			ref_date.[Date] <= ref_date_current.[Date]
			AND ref_date.[Date] >= DATEADD(YEAR, -5, ref_date_current.[Year_Start_Date])
			AND ref_date.[Day_Of_Month_Number] = 1  -- First day of each month
		)
GO
/****** Object:  Table [raw].[S_HT_Product_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[S_HT_Product_Northwind](
	[HK_H_Product] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[DV_Deleted_Flag] [bit] NOT NULL,
	[HD_S_HT_Product_Northwind] [char](32) NOT NULL,
	[ProductID] [int] NOT NULL,
 CONSTRAINT [PK_S_HT_Product_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Product] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [biz].[v_S_HT_Product_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [biz].[v_S_HT_Product_Northwind]
AS
	SELECT
		  [HK_H_Product]
		, [DV_Load_Datetime] AS DV_Load_Datetime_Start
		, LEAD(DATEADD(NS, -100, [DV_Load_Datetime]), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY [HK_H_Product] ORDER BY [DV_Load_Datetime] ASC) AS DV_Load_Datetime_End
		, [DV_Record_Source]
		, [DV_Deleted_Flag]
		, [HD_S_HT_Product_Northwind]
		, [ProductID]
	FROM
		[Data_Vault].[raw].[S_HT_Product_Northwind];
GO
/****** Object:  Table [raw].[S_HT_Product_Category_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[S_HT_Product_Category_Northwind](
	[HK_H_Product_Category] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[DV_Deleted_Flag] [bit] NOT NULL,
	[HD_S_HT_Product_Category_Northwind] [char](32) NOT NULL,
	[CategoryID] [int] NOT NULL,
 CONSTRAINT [PK_S_HT_Product_Category_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Product_Category] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [biz].[v_S_HT_Product_Category_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [biz].[v_S_HT_Product_Category_Northwind]
AS
	SELECT
		  [HK_H_Product_Category]
		, [DV_Load_Datetime] AS DV_Load_Datetime_Start
		, LEAD(DATEADD(NS, -100, [DV_Load_Datetime]), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY [HK_H_Product_Category] ORDER BY [DV_Load_Datetime] ASC) AS DV_Load_Datetime_End
		, [DV_Record_Source]
		, [DV_Deleted_Flag]
		, [HD_S_HT_Product_Category_Northwind]
		, [CategoryID]
	FROM
		[Data_Vault].[raw].[S_HT_Product_Category_Northwind];
GO
/****** Object:  Table [raw].[S_HT_Employee_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[S_HT_Employee_Northwind](
	[HK_H_Employee] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[DV_Deleted_Flag] [bit] NOT NULL,
	[HD_S_HT_Employee_Northwind] [char](32) NOT NULL,
	[EmployeeID] [int] NOT NULL,
 CONSTRAINT [PK_S_HT_Employee_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Employee] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [biz].[v_S_HT_Employee_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [biz].[v_S_HT_Employee_Northwind]
AS
	SELECT
		  [HK_H_Employee]
		, [DV_Load_Datetime] AS DV_Load_Datetime_Start
		, LEAD(DATEADD(NS, -100, [DV_Load_Datetime]), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY [HK_H_Employee] ORDER BY [DV_Load_Datetime] ASC) AS DV_Load_Datetime_End
		, [DV_Record_Source]
		, [DV_Deleted_Flag]
		, [HD_S_HT_Employee_Northwind]
		, [EmployeeID]
	FROM
		[Data_Vault].[raw].[S_HT_Employee_Northwind];
GO
/****** Object:  Table [raw].[S_HC_Order_Detail_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[S_HC_Order_Detail_Northwind](
	[HK_H_Order_Detail] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[HD_S_HC_Order_Detail_Northwind] [char](32) NOT NULL,
	[UnitPrice] [money] NOT NULL,
	[Quantity] [smallint] NOT NULL,
	[Discount] [real] NOT NULL,
 CONSTRAINT [PK_S_HC_Order_Detail_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Order_Detail] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [biz].[v_S_HC_Order_Detail_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [biz].[v_S_HC_Order_Detail_Northwind]
AS
	SELECT
		  [HK_H_Order_Detail]
		, [DV_Load_Datetime] AS DV_Load_Datetime_Start
		, LEAD(DATEADD(NS, -100, [DV_Load_Datetime]), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY [HK_H_Order_Detail] ORDER BY [DV_Load_Datetime] ASC) AS DV_Load_Datetime_End
		, [DV_Record_Source]
		, [HD_S_HC_Order_Detail_Northwind]
		, [UnitPrice]
		, [Quantity]
		, [Discount]
	FROM
		[Data_Vault].[raw].[S_HC_Order_Detail_Northwind];
GO
/****** Object:  Table [raw].[S_HC_Supplier_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[S_HC_Supplier_Northwind](
	[HK_H_Supplier] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[HD_S_HC_Supplier_Northwind] [char](32) NOT NULL,
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
 CONSTRAINT [PK_S_HC_Supplier_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Supplier] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA] TEXTIMAGE_ON [DATA]
GO
/****** Object:  View [biz].[v_S_HC_Supplier_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [biz].[v_S_HC_Supplier_Northwind]
AS
	SELECT
		  [HK_H_Supplier]
		, [DV_Load_Datetime] AS DV_Load_Datetime_Start
		, LEAD(DATEADD(NS, -100, [DV_Load_Datetime]), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY [HK_H_Supplier] ORDER BY [DV_Load_Datetime] ASC) AS DV_Load_Datetime_End
		, [DV_Record_Source]
		, [HD_S_HC_Supplier_Northwind]
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
	FROM
		[Data_Vault].[raw].[S_HC_Supplier_Northwind];






GO
/****** Object:  Table [raw].[S_HT_Order_Detail_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[S_HT_Order_Detail_Northwind](
	[HK_H_Order_Detail] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[DV_Deleted_Flag] [bit] NOT NULL,
	[HD_S_HT_Order_Detail_Northwind] [char](32) NOT NULL,
	[OrderID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
 CONSTRAINT [PK_S_HT_Order_Detail_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Order_Detail] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [biz].[v_S_HT_Order_Detail_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [biz].[v_S_HT_Order_Detail_Northwind]
AS
	SELECT
		  [HK_H_Order_Detail]
		, [DV_Load_Datetime] AS DV_Load_Datetime_Start
		, LEAD(DATEADD(NS, -100, [DV_Load_Datetime]), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY [HK_H_Order_Detail] ORDER BY [DV_Load_Datetime] ASC) AS DV_Load_Datetime_End
		, [DV_Record_Source]
		, [DV_Deleted_Flag]
		, [HD_S_HT_Order_Detail_Northwind]
		, [OrderID]
		, [ProductID]
	FROM
		[Data_Vault].[raw].[S_HT_Order_Detail_Northwind];
GO
/****** Object:  Table [raw].[L_Product_Supplier]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[L_Product_Supplier](
	[HK_L_Product_Supplier] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[HK_H_Product] [char](32) NOT NULL,
	[HK_H_Supplier] [char](32) NOT NULL,
 CONSTRAINT [PK_L_Product_Supplier] PRIMARY KEY NONCLUSTERED 
(
	[HK_L_Product_Supplier] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  Table [raw].[S_LE_Product_Supplier_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[S_LE_Product_Supplier_Northwind](
	[HK_L_Product_Supplier] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[HD_S_LE_Product_Supplier_Northwind] [char](32) NOT NULL,
	[ProductID] [int] NOT NULL,
	[SupplierID] [int] NULL,
 CONSTRAINT [PK_S_LE_Product_Supplier_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_L_Product_Supplier] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [biz].[v_S_LE_Product_Supplier_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [biz].[v_S_LE_Product_Supplier_Northwind]
AS
	SELECT
		  sat.[HK_L_Product_Supplier]
		, sat.[DV_Load_Datetime] AS DV_Load_Datetime_Start
		, LEAD(DATEADD(NS, -100, sat.[DV_Load_Datetime]), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY link.[HK_H_Product] ORDER BY sat.[DV_Load_Datetime] ASC) AS DV_Load_Datetime_End
		, sat.[DV_Record_Source]
		, sat.[HD_S_LE_Product_Supplier_Northwind]
		, sat.[ProductID]
		, sat.[SupplierID]
	FROM
		[Data_Vault].[raw].[S_LE_Product_Supplier_Northwind] AS sat
			-- Join to link to acquire driving key hash
			INNER JOIN [Data_Vault].[raw].[L_Product_Supplier] AS link
				ON sat.[HK_L_Product_Supplier] = link.[HK_L_Product_Supplier];
GO
/****** Object:  Table [raw].[L_Product_Category]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[L_Product_Category](
	[HK_L_Product_Category] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[HK_H_Product] [char](32) NOT NULL,
	[HK_H_Product_Category] [char](32) NOT NULL,
 CONSTRAINT [PK_L_Product_Category] PRIMARY KEY NONCLUSTERED 
(
	[HK_L_Product_Category] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  Table [raw].[S_LE_Product_Category_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[S_LE_Product_Category_Northwind](
	[HK_L_Product_Category] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[HD_S_LE_Product_Category_Northwind] [char](32) NOT NULL,
	[ProductID] [int] NOT NULL,
	[CategoryID] [int] NULL,
 CONSTRAINT [PK_S_LE_Product_Category_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_L_Product_Category] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [biz].[v_S_LE_Product_Category_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [biz].[v_S_LE_Product_Category_Northwind]
AS
	SELECT
		  sat.[HK_L_Product_Category]
		, sat.[DV_Load_Datetime] AS DV_Load_Datetime_Start
		, LEAD(DATEADD(NS, -100, sat.[DV_Load_Datetime]), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY link.[HK_H_Product] ORDER BY sat.[DV_Load_Datetime] ASC) AS DV_Load_Datetime_End
		, sat.[DV_Record_Source]
		, sat.[HD_S_LE_Product_Category_Northwind]
		, sat.[ProductID]
		, sat.[CategoryID]
	FROM
		[Data_Vault].[raw].[S_LE_Product_Category_Northwind] AS sat
			-- Join to Link to acquire driving key hash
			INNER JOIN [Data_Vault].[raw].[L_Product_Category] AS link
				ON sat.[HK_L_Product_Category] = link.[HK_L_Product_Category];
GO
/****** Object:  Table [raw].[L_Employee_Reporting_Line]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[L_Employee_Reporting_Line](
	[HK_L_Employee_Reporting_Line] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[HK_H_Employee] [char](32) NOT NULL,
	[HK_H_Employee_Manager] [char](32) NOT NULL,
 CONSTRAINT [PK_L_Employee_Reporting_Line] PRIMARY KEY NONCLUSTERED 
(
	[HK_L_Employee_Reporting_Line] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  Table [raw].[S_LE_Employee_Reporting_Line_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[S_LE_Employee_Reporting_Line_Northwind](
	[HK_L_Employee_Reporting_Line] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[HD_S_LE_Employee_Reporting_Line_Northwind] [char](32) NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[ReportsTo] [int] NULL,
 CONSTRAINT [PK_S_LE_Employee_Reporting_Line_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_L_Employee_Reporting_Line] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [biz].[v_S_LE_Employee_Reporting_Line_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [biz].[v_S_LE_Employee_Reporting_Line_Northwind]
AS
	SELECT
		  sat.[HK_L_Employee_Reporting_Line]
		, sat.[DV_Load_Datetime] AS DV_Load_Datetime_Start
		, LEAD(DATEADD(NS, -100, sat.[DV_Load_Datetime]), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY link.[HK_H_Employee] ORDER BY sat.[DV_Load_Datetime] ASC) AS DV_Load_Datetime_End
		, sat.[DV_Record_Source]
		, sat.[HD_S_LE_Employee_Reporting_Line_Northwind]
		, sat.[EmployeeID]
		, sat.[ReportsTo]
	FROM
		[Data_Vault].[raw].[S_LE_Employee_Reporting_Line_Northwind] AS sat
			-- Join to Link to acquire driving key hash
			INNER JOIN [Data_Vault].[raw].[L_Employee_Reporting_Line] AS link
				ON sat.[HK_L_Employee_Reporting_Line] = link.[HK_L_Employee_Reporting_Line]
GO
/****** Object:  Table [raw].[S_HT_Supplier_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[S_HT_Supplier_Northwind](
	[HK_H_Supplier] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[DV_Deleted_Flag] [bit] NOT NULL,
	[HD_S_HT_Supplier_Northwind] [char](32) NOT NULL,
	[SupplierID] [int] NOT NULL,
 CONSTRAINT [PK_S_HT_Supplier_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Supplier] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [biz].[v_S_HT_Supplier_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [biz].[v_S_HT_Supplier_Northwind]
AS
	SELECT 
		  [HK_H_Supplier]
		, [DV_Load_Datetime] AS DV_Load_Datetime_Start
		, LEAD(DATEADD(NS, -100, [DV_Load_Datetime]), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY [HK_H_Supplier] ORDER BY [DV_Load_Datetime] ASC) AS DV_Load_Datetime_End
		, [DV_Record_Source]
		, [DV_Deleted_Flag]
		, [HD_S_HT_Supplier_Northwind]
		, [SupplierID]
	FROM
		[Data_Vault].[raw].[S_HT_Supplier_Northwind];
GO
/****** Object:  Table [biz].[PIT_Order_Detail]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [biz].[PIT_Order_Detail](
	[HK_H_Order_Detail] [char](32) NOT NULL,
	[DV_Snapshot_Datetime] [datetime2](7) NOT NULL,
	[S_HC_Order_Detail_Northwind_HK_H_Order_Detail] [char](32) NOT NULL,
	[S_HC_Order_Detail_Northwind_DV_Load_Datetime] [datetime2](7) NOT NULL,
	[S_HT_Order_Detail_Northwind_HK_H_Order_Detail] [char](32) NOT NULL,
	[S_HT_Order_Detail_Northwind_DV_Load_Datetime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_PIT_Order_Detail] PRIMARY KEY NONCLUSTERED 
(
	[DV_Snapshot_Datetime] ASC,
	[HK_H_Order_Detail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [biz].[v_PIT_Order_Detail]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [biz].[v_PIT_Order_Detail]
AS
	SELECT
		  [HK_H_Order_Detail]
		, [DV_Snapshot_Datetime] AS DV_Snapshot_Datetime_Start
		, LEAD(DATEADD(NS, -100, [DV_Snapshot_Datetime]), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY [HK_H_Order_Detail] ORDER BY [DV_Snapshot_Datetime] ASC) AS DV_Snapshot_Datetime_End
		, [S_HC_Order_Detail_Northwind_HK_H_Order_Detail]
		, [S_HC_Order_Detail_Northwind_DV_Load_Datetime]
		, [S_HT_Order_Detail_Northwind_HK_H_Order_Detail]
		, [S_HT_Order_Detail_Northwind_DV_Load_Datetime]
	FROM
		[Data_Vault].[biz].[PIT_Order_Detail];
GO
/****** Object:  Table [raw].[S_HT_Shipper_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[S_HT_Shipper_Northwind](
	[HK_H_Shipper] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[DV_Deleted_Flag] [bit] NOT NULL,
	[HD_S_HT_Shipper_Northwind] [char](32) NOT NULL,
	[ShipperID] [int] NOT NULL,
 CONSTRAINT [PK_S_HT_Shipper_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Shipper] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [biz].[v_S_HT_Shipper_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [biz].[v_S_HT_Shipper_Northwind]
AS
	SELECT 
		  [HK_H_Shipper]
		, [DV_Load_Datetime] AS DV_Load_Datetime_Start
		, LEAD(DATEADD(NS, -100, [DV_Load_Datetime]), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY [HK_H_Shipper] ORDER BY [DV_Load_Datetime] ASC) AS DV_Load_Datetime_End
		, [DV_Record_Source]
		, [DV_Deleted_Flag]
		, [HD_S_HT_Shipper_Northwind]
		, [ShipperID]
	FROM
		[Data_Vault].[raw].[S_HT_Shipper_Northwind];
GO
/****** Object:  Table [raw].[S_LT_Employee_Territory_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[S_LT_Employee_Territory_Northwind](
	[HK_L_Employee_Territory] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[DV_Deleted_Flag] [bit] NOT NULL,
	[HD_S_LT_Employee_Territory_Northwind] [char](32) NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[TerritoryID] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_S_LT_Employee_Territory_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_L_Employee_Territory] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [biz].[v_S_LT_Employee_Territory_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [biz].[v_S_LT_Employee_Territory_Northwind]
AS
	SELECT
		  [HK_L_Employee_Territory]
		, [DV_Load_Datetime] AS DV_Load_Datetime_Start
		, LEAD(DATEADD(NS, -100, [DV_Load_Datetime]), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY [HK_L_Employee_Territory] ORDER BY [DV_Load_Datetime] ASC) AS DV_Load_Datetime_End
		, [DV_Record_Source]
		, [DV_Deleted_Flag]
		, [HD_S_LT_Employee_Territory_Northwind]
		, [EmployeeID]
		, [TerritoryID]
	FROM
		[Data_Vault].[raw].[S_LT_Employee_Territory_Northwind];
GO
/****** Object:  Table [raw].[L_Territory_Region]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[L_Territory_Region](
	[HK_L_Territory_Region] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[HK_H_Territory] [char](32) NOT NULL,
	[HK_H_Region] [char](32) NOT NULL,
 CONSTRAINT [PK_L_Territory_Region] PRIMARY KEY NONCLUSTERED 
(
	[HK_L_Territory_Region] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  Table [raw].[S_LE_Territory_Region_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[S_LE_Territory_Region_Northwind](
	[HK_L_Territory_Region] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[HD_S_LE_Territory_Region_Northwind] [char](32) NOT NULL,
	[TerritoryID] [nvarchar](20) NOT NULL,
	[RegionID] [int] NOT NULL,
 CONSTRAINT [PK_S_LE_Territory_Region_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_L_Territory_Region] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [biz].[v_S_LE_Territory_Region_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [biz].[v_S_LE_Territory_Region_Northwind]
AS
	SELECT
		  sat.[HK_L_Territory_Region]
		, sat.[DV_Load_Datetime] AS DV_Load_Datetime_Start
		, LEAD(DATEADD(NS, -100, sat.[DV_Load_Datetime]), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY link.[HK_H_Territory] ORDER BY sat.[DV_Load_Datetime] ASC) AS DV_Load_Datetime_End
		, sat.[DV_Record_Source]
		, sat.[HD_S_LE_Territory_Region_Northwind]
		, sat.[TerritoryID]
		, sat.[RegionID]
	FROM
		[Data_Vault].[raw].[S_LE_Territory_Region_Northwind] AS sat
			-- Join to link to acquire driving key hash
			INNER JOIN [Data_Vault].[raw].[L_Territory_Region] AS link
				ON sat.[HK_L_Territory_Region] = link.[HK_L_Territory_Region]
GO
/****** Object:  Table [raw].[S_HC_Territory_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[S_HC_Territory_Northwind](
	[HK_H_Territory] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[HD_S_HC_Territory_Northwind] [char](32) NOT NULL,
	[TerritoryDescription] [nchar](50) NOT NULL,
 CONSTRAINT [PK_S_HC_Territory_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Territory] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [biz].[v_S_HC_Territory_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [biz].[v_S_HC_Territory_Northwind]
AS
	SELECT
		  [HK_H_Territory]
		, [DV_Load_Datetime] AS DV_Load_Datetime_Start
		, LEAD(DATEADD(NS, -100, [DV_Load_Datetime]), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY [HK_H_Territory] ORDER BY [DV_Load_Datetime] ASC) AS DV_Load_Datetime_End
		, [DV_Record_Source]
		, [HD_S_HC_Territory_Northwind]
		, [TerritoryDescription]
	FROM
		[Data_Vault].[raw].[S_HC_Territory_Northwind];
GO
/****** Object:  Table [raw].[S_HT_Territory_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[S_HT_Territory_Northwind](
	[HK_H_Territory] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[DV_Deleted_Flag] [bit] NOT NULL,
	[HD_S_HT_Territory_Northwind] [char](32) NOT NULL,
	[TerritoryID] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_S_HT_Territory_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Territory] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [biz].[v_S_HT_Territory_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [biz].[v_S_HT_Territory_Northwind]
AS
	SELECT
		  [HK_H_Territory]
		, [DV_Load_Datetime] AS DV_Load_Datetime_Start
		, LEAD(DATEADD(NS, -100, [DV_Load_Datetime]), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY [HK_H_Territory] ORDER BY [DV_Load_Datetime] ASC) AS DV_Load_Datetime_End
		, [DV_Record_Source]
		, [DV_Deleted_Flag]
		, [HD_S_HT_Territory_Northwind]
		, [TerritoryID]
	FROM
		[Data_Vault].[raw].[S_HT_Territory_Northwind];
GO
/****** Object:  Table [biz].[B_Order]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [biz].[B_Order](
	[DV_Snapshot_Datetime] [datetime2](7) NOT NULL,
	[HK_H_Order] [char](32) NOT NULL,
	[HK_H_Customer] [char](32) NOT NULL,
	[HK_H_Employee] [char](32) NOT NULL,
	[HK_H_Shipper] [char](32) NOT NULL,
	[Order_Submitted_Date_Key] [int] NOT NULL,
	[Order_Required_Date_Key] [int] NOT NULL,
	[Order_Shipped_Date_Key] [int] NOT NULL,
 CONSTRAINT [PK_B_Order] PRIMARY KEY NONCLUSTERED 
(
	[DV_Snapshot_Datetime] ASC,
	[HK_H_Order] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [biz].[v_B_Order]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [biz].[v_B_Order]
AS
	SELECT
		  [DV_Snapshot_Datetime] AS DV_Snapshot_Datetime_Start
		, LEAD(DATEADD(NS, -100, [DV_Snapshot_Datetime]), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY [HK_H_Order] ORDER BY [DV_Snapshot_Datetime] ASC) AS DV_Snapshot_Datetime_End
		, [HK_H_Order]
		, [HK_H_Customer]
		, [HK_H_Employee]
		, [HK_H_Shipper]
		, [Order_Submitted_Date_Key]
		, [Order_Required_Date_Key]
		, [Order_Shipped_Date_Key]
	FROM
		[Data_Vault].[biz].[B_Order];
GO
/****** Object:  Table [biz].[PIT_Territory]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [biz].[PIT_Territory](
	[HK_H_Territory] [char](32) NOT NULL,
	[DV_Snapshot_Datetime] [datetime2](7) NOT NULL,
	[S_HC_Territory_Northwind_HK_H_Territory] [char](32) NOT NULL,
	[S_HC_Territory_Northwind_DV_Load_Datetime] [datetime2](7) NOT NULL,
	[S_HT_Territory_Northwind_HK_H_Territory] [char](32) NOT NULL,
	[S_HT_Territory_Northwind_DV_Load_Datetime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_PIT_Territory] PRIMARY KEY NONCLUSTERED 
(
	[DV_Snapshot_Datetime] ASC,
	[HK_H_Territory] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [biz].[v_PIT_Territory]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [biz].[v_PIT_Territory]
AS
	SELECT
		  [HK_H_Territory]
		, [DV_Snapshot_Datetime] AS DV_Snapshot_Datetime_Start
		, LEAD(DATEADD(NS, -100, [DV_Snapshot_Datetime]), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY [HK_H_Territory] ORDER BY [DV_Snapshot_Datetime] ASC) AS DV_Snapshot_Datetime_End
		, [S_HC_Territory_Northwind_HK_H_Territory]
		, [S_HC_Territory_Northwind_DV_Load_Datetime]
		, [S_HT_Territory_Northwind_HK_H_Territory]
		, [S_HT_Territory_Northwind_DV_Load_Datetime]
	FROM
		[Data_Vault].[biz].[PIT_Territory];
GO
/****** Object:  Table [raw].[S_HC_Region_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[S_HC_Region_Northwind](
	[HK_H_Region] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[HD_S_HC_Region_Northwind] [char](32) NOT NULL,
	[RegionDescription] [nchar](50) NOT NULL,
 CONSTRAINT [PK_S_HC_Region_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Region] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [biz].[v_S_HC_Region_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [biz].[v_S_HC_Region_Northwind]
AS
	SELECT
		  [HK_H_Region]
		, [DV_Load_Datetime] AS DV_Load_Datetime_Start
		, LEAD(DATEADD(NS, -100, [DV_Load_Datetime]), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY [HK_H_Region] ORDER BY [DV_Load_Datetime] ASC) AS DV_Load_Datetime_End
		, [DV_Record_Source]
		, [HD_S_HC_Region_Northwind]
		, [RegionDescription]
	FROM
		[Data_Vault].[raw].[S_HC_Region_Northwind];
GO
/****** Object:  Table [raw].[S_HT_Region_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[S_HT_Region_Northwind](
	[HK_H_Region] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[DV_Deleted_Flag] [bit] NOT NULL,
	[HD_S_HT_Region_Northwind] [char](32) NOT NULL,
	[RegionID] [int] NOT NULL,
 CONSTRAINT [PK_S_HT_Region_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Region] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [biz].[v_S_HT_Region_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [biz].[v_S_HT_Region_Northwind]
AS
	SELECT
		  [HK_H_Region]
		, [DV_Load_Datetime] AS DV_Load_Datetime_Start
		, LEAD(DATEADD(NS, -100, [DV_Load_Datetime]), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY [HK_H_Region] ORDER BY [DV_Load_Datetime] ASC) AS DV_Load_Datetime_End
		, [DV_Record_Source]
		, [DV_Deleted_Flag]
		, [HD_S_HT_Region_Northwind]
		, [RegionID]
	FROM
		[Data_Vault].[raw].[S_HT_Region_Northwind];
GO
/****** Object:  Table [biz].[B_Order_Detail]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [biz].[B_Order_Detail](
	[DV_Snapshot_Datetime] [datetime2](7) NOT NULL,
	[HK_H_Order_Detail] [char](32) NOT NULL,
	[HK_H_Order] [char](32) NOT NULL,
	[HK_H_Product] [char](32) NOT NULL,
	[HK_H_Customer] [char](32) NOT NULL,
	[HK_H_Employee] [char](32) NOT NULL,
	[HK_H_Shipper] [char](32) NOT NULL,
	[Order_Submitted_Date_Key] [int] NOT NULL,
	[Order_Required_Date_Key] [int] NOT NULL,
	[Order_Shipped_Date_Key] [int] NOT NULL,
 CONSTRAINT [PK_B_Order_Detail] PRIMARY KEY NONCLUSTERED 
(
	[DV_Snapshot_Datetime] ASC,
	[HK_H_Order_Detail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [biz].[v_B_Order_Detail]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [biz].[v_B_Order_Detail]
AS
	SELECT
		  [DV_Snapshot_Datetime] AS DV_Snapshot_Datetime_Start
		, LEAD(DATEADD(NS, -100, [DV_Snapshot_Datetime]), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY [HK_H_Order_Detail] ORDER BY [DV_Snapshot_Datetime] ASC) AS DV_Snapshot_Datetime_End
		, [HK_H_Order_Detail]
		, [HK_H_Order]
		, [HK_H_Product]
		, [HK_H_Customer]
		, [HK_H_Employee]
		, [HK_H_Shipper]
		, [Order_Submitted_Date_Key]
		, [Order_Required_Date_Key]
		, [Order_Shipped_Date_Key]
	FROM
		[Data_Vault].[biz].[B_Order_Detail];
GO
/****** Object:  Table [biz].[PIT_Region]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [biz].[PIT_Region](
	[HK_H_Region] [char](32) NOT NULL,
	[DV_Snapshot_Datetime] [datetime2](7) NOT NULL,
	[S_HC_Region_Northwind_HK_H_Region] [char](32) NOT NULL,
	[S_HC_Region_Northwind_DV_Load_Datetime] [datetime2](7) NOT NULL,
	[S_HT_Region_Northwind_HK_H_Region] [char](32) NOT NULL,
	[S_HT_Region_Northwind_DV_Load_Datetime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_PIT_Region] PRIMARY KEY NONCLUSTERED 
(
	[DV_Snapshot_Datetime] ASC,
	[HK_H_Region] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [biz].[v_PIT_Region]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [biz].[v_PIT_Region]
AS
	SELECT
		  [HK_H_Region]
		, [DV_Snapshot_Datetime] AS DV_Snapshot_Datetime_Start
		, LEAD(DATEADD(NS, -100, [DV_Snapshot_Datetime]), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY [HK_H_Region] ORDER BY [DV_Snapshot_Datetime] ASC) AS DV_Snapshot_Datetime_End
		, [S_HC_Region_Northwind_HK_H_Region]
		, [S_HC_Region_Northwind_DV_Load_Datetime]
		, [S_HT_Region_Northwind_HK_H_Region]
		, [S_HT_Region_Northwind_DV_Load_Datetime]
	FROM
		[Data_Vault].[biz].[PIT_Region];
GO
/****** Object:  Table [raw].[S_HT_Customer_Type_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[S_HT_Customer_Type_Northwind](
	[HK_H_Customer_Type] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[DV_Deleted_Flag] [bit] NOT NULL,
	[HD_S_HT_Customer_Type_Northwind] [char](32) NOT NULL,
	[CustomerTypeID] [nchar](10) NOT NULL,
 CONSTRAINT [PK_S_HT_Customer_Type_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Customer_Type] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [biz].[v_S_HT_Customer_Type_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [biz].[v_S_HT_Customer_Type_Northwind]
AS
	SELECT
		  [HK_H_Customer_Type]
		, [DV_Load_Datetime] AS DV_Load_Datetime_Start
		, LEAD(DATEADD(NS, -100, [DV_Load_Datetime]), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY [HK_H_Customer_Type] ORDER BY [DV_Load_Datetime] ASC) AS DV_Load_Datetime_End
		, [DV_Record_Source]
		, [DV_Deleted_Flag]
		, [HD_S_HT_Customer_Type_Northwind]
		, [CustomerTypeID]
	FROM
		[Data_Vault].[raw].[S_HT_Customer_Type_Northwind];
GO
/****** Object:  Table [raw].[S_HC_Customer_Type_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[S_HC_Customer_Type_Northwind](
	[HK_H_Customer_Type] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[HD_S_HC_Customer_Type_Northwind] [char](32) NOT NULL,
	[CustomerDesc] [nvarchar](max) NULL,
 CONSTRAINT [PK_S_HC_Customer_Type_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Customer_Type] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA] TEXTIMAGE_ON [DATA]
GO
/****** Object:  View [biz].[v_S_HC_Customer_Type_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [biz].[v_S_HC_Customer_Type_Northwind]
AS
	SELECT
		  [HK_H_Customer_Type]
		, [DV_Load_Datetime] AS DV_Load_Datetime_Start
		, LEAD(DATEADD(NS, -100, [DV_Load_Datetime]), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY [HK_H_Customer_Type] ORDER BY [DV_Load_Datetime] ASC) AS DV_Load_Datetime_End
		, [DV_Record_Source]
		, [HD_S_HC_Customer_Type_Northwind]
		, [CustomerDesc]
	FROM
		[Data_Vault].[raw].[S_HC_Customer_Type_Northwind];
GO
/****** Object:  Table [biz].[PIT_Customer_Type]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [biz].[PIT_Customer_Type](
	[HK_H_Customer_Type] [char](32) NOT NULL,
	[DV_Snapshot_Datetime] [datetime2](7) NOT NULL,
	[S_HC_Customer_Type_Northwind_HK_H_Customer_Type] [char](32) NOT NULL,
	[S_HC_Customer_Type_Northwind_DV_Load_Datetime] [datetime2](7) NOT NULL,
	[S_HT_Customer_Type_Northwind_HK_H_Customer_Type] [char](32) NOT NULL,
	[S_HT_Customer_Type_Northwind_DV_Load_Datetime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_PIT_Customer_Type] PRIMARY KEY NONCLUSTERED 
(
	[DV_Snapshot_Datetime] ASC,
	[HK_H_Customer_Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [biz].[v_PIT_Customer_Type]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [biz].[v_PIT_Customer_Type]
AS
	SELECT
		  [HK_H_Customer_Type]
		, [DV_Snapshot_Datetime] AS DV_Snapshot_Datetime_Start
		, LEAD(DATEADD(NS, -100, [DV_Snapshot_Datetime]), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY [HK_H_Customer_Type] ORDER BY [DV_Snapshot_Datetime] ASC) AS DV_Snapshot_Datetime_End
		, [S_HC_Customer_Type_Northwind_HK_H_Customer_Type]
		, [S_HC_Customer_Type_Northwind_DV_Load_Datetime]
		, [S_HT_Customer_Type_Northwind_HK_H_Customer_Type]
		, [S_HT_Customer_Type_Northwind_DV_Load_Datetime]
	FROM
		[Data_Vault].[biz].[PIT_Customer_Type];
GO
/****** Object:  Table [raw].[S_LT_Customer_Type_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[S_LT_Customer_Type_Northwind](
	[HK_L_Customer_Type] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[DV_Deleted_Flag] [bit] NOT NULL,
	[HD_S_LT_Customer_Type_Northwind] [char](32) NOT NULL,
	[CustomerID] [nchar](5) NOT NULL,
	[CustomerTypeID] [nchar](10) NOT NULL,
 CONSTRAINT [PK_S_LT_Customer_Type_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_L_Customer_Type] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [biz].[v_S_LT_Customer_Type_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [biz].[v_S_LT_Customer_Type_Northwind]
AS
	SELECT
		  [HK_L_Customer_Type]
		, [DV_Load_Datetime] AS DV_Load_Datetime_Start
		, LEAD(DATEADD(NS, -100, [DV_Load_Datetime]), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY [HK_L_Customer_Type] ORDER BY [DV_Load_Datetime] ASC) AS DV_Load_Datetime_End
		, [DV_Record_Source]
		, [DV_Deleted_Flag]
		, [HD_S_LT_Customer_Type_Northwind]
		, [CustomerID]
		, [CustomerTypeID]
	FROM
		[Data_Vault].[raw].[S_LT_Customer_Type_Northwind];





GO
/****** Object:  Table [raw].[S_HC_Customer_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[S_HC_Customer_Northwind](
	[HK_H_Customer] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[HD_S_HC_Customer_Northwind] [char](32) NOT NULL,
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
 CONSTRAINT [PK_S_HC_Customer_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Customer] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [biz].[v_S_HC_Customer_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [biz].[v_S_HC_Customer_Northwind]
AS
	SELECT
		  [HK_H_Customer]
		, [DV_Load_Datetime] AS DV_Load_Datetime_Start
		, LEAD(DATEADD(NS, -100, [DV_Load_Datetime]), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY [HK_H_Customer] ORDER BY [DV_Load_Datetime] ASC) AS DV_Load_Datetime_End
		, [DV_Record_Source]
		, [HD_S_HC_Customer_Northwind]
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
	FROM
		[Data_Vault].[raw].[S_HC_Customer_Northwind];
GO
/****** Object:  Table [raw].[S_HT_Customer_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[S_HT_Customer_Northwind](
	[HK_H_Customer] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[DV_Deleted_Flag] [bit] NOT NULL,
	[HD_S_HT_Customer_Northwind] [char](32) NOT NULL,
	[CustomerID] [nchar](5) NOT NULL,
 CONSTRAINT [PK_S_HT_Customer_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Customer] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [biz].[v_S_HT_Customer_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [biz].[v_S_HT_Customer_Northwind]
AS
	SELECT
		  [HK_H_Customer]
		, [DV_Load_Datetime] AS DV_Load_Datetime_Start
		, LEAD(DATEADD(NS, -100, [DV_Load_Datetime]), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY [HK_H_Customer] ORDER BY [DV_Load_Datetime] ASC) AS DV_Load_Datetime_End
		, [DV_Record_Source]
		, [DV_Deleted_Flag]
		, [HD_S_HT_Customer_Northwind]
		, [CustomerID]
	FROM
		[Data_Vault].[raw].[S_HT_Customer_Northwind];
GO
/****** Object:  Table [biz].[PIT_Customer]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [biz].[PIT_Customer](
	[HK_H_Customer] [char](32) NOT NULL,
	[DV_Snapshot_Datetime] [datetime2](7) NOT NULL,
	[S_HC_Customer_Northwind_HK_H_Customer] [char](32) NOT NULL,
	[S_HC_Customer_Northwind_DV_Load_Datetime] [datetime2](7) NOT NULL,
	[S_HT_Customer_Northwind_HK_H_Customer] [char](32) NOT NULL,
	[S_HT_Customer_Northwind_DV_Load_Datetime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_PIT_Customer] PRIMARY KEY NONCLUSTERED 
(
	[DV_Snapshot_Datetime] ASC,
	[HK_H_Customer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [biz].[v_PIT_Customer]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [biz].[v_PIT_Customer]
AS
	SELECT
		  [HK_H_Customer]
		, [DV_Snapshot_Datetime] AS DV_Snapshot_Datetime_Start
		, LEAD(DATEADD(NS, -100, [DV_Snapshot_Datetime]), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY [HK_H_Customer] ORDER BY [DV_Snapshot_Datetime] ASC) AS DV_Snapshot_Datetime_End
		, [S_HC_Customer_Northwind_HK_H_Customer]
		, [S_HC_Customer_Northwind_DV_Load_Datetime]
		, [S_HT_Customer_Northwind_HK_H_Customer]
		, [S_HT_Customer_Northwind_DV_Load_Datetime]
	FROM
		[Data_Vault].[biz].[PIT_Customer];
GO
/****** Object:  Table [raw].[S_HC_Order_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[S_HC_Order_Northwind](
	[HK_H_Order] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[HD_S_HC_Order_Northwind] [char](32) NOT NULL,
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
 CONSTRAINT [PK_S_HC_Order_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Order] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [biz].[v_S_HC_Order_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [biz].[v_S_HC_Order_Northwind]
AS
	SELECT
		  [HK_H_Order]
		, [DV_Load_Datetime] AS DV_Load_Datetime_Start
		, LEAD(DATEADD(NS, -100, [DV_Load_Datetime]), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY [HK_H_Order] ORDER BY [DV_Load_Datetime] ASC) AS DV_Load_Datetime_End
		, [DV_Record_Source]
		, [HD_S_HC_Order_Northwind]
		, [OrderDate]
		, [RequiredDate]
		, [ShippedDate]
		, [Freight]
		, [ShipName]
		, [ShipAddress]
		, [ShipCity]
		, [ShipRegion]
		, [ShipPostalCode]
		, [ShipCountry]
	FROM
		[Data_Vault].[raw].[S_HC_Order_Northwind];
GO
/****** Object:  Table [raw].[S_HT_Order_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[S_HT_Order_Northwind](
	[HK_H_Order] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[DV_Deleted_Flag] [bit] NOT NULL,
	[HD_S_HT_Order_Northwind] [char](32) NOT NULL,
	[OrderID] [int] NOT NULL,
 CONSTRAINT [PK_S_HT_Order_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Order] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [biz].[v_S_HT_Order_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [biz].[v_S_HT_Order_Northwind]
AS
	SELECT
		  [HK_H_Order]
		, [DV_Load_Datetime] AS DV_Load_Datetime_Start
		, LEAD(DATEADD(NS, -100, [DV_Load_Datetime]), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY [HK_H_Order] ORDER BY [DV_Load_Datetime] ASC) AS DV_Load_Datetime_End
		, [DV_Record_Source]
		, [DV_Deleted_Flag]
		, [HD_S_HT_Order_Northwind]
		, [OrderID]
	FROM
		[Data_Vault].[raw].[S_HT_Order_Northwind];
GO
/****** Object:  Table [raw].[L_Order_Header]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[L_Order_Header](
	[HK_L_Order_Header] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[HK_H_Customer] [char](32) NOT NULL,
	[HK_H_Employee] [char](32) NOT NULL,
	[HK_H_Order] [char](32) NOT NULL,
	[HK_H_Shipper] [char](32) NOT NULL,
 CONSTRAINT [PK_L_Order_Header] PRIMARY KEY NONCLUSTERED 
(
	[HK_L_Order_Header] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  Table [raw].[S_LE_Order_Header_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[S_LE_Order_Header_Northwind](
	[HK_L_Order_Header] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[HD_S_LE_Order_Header_Northwind] [char](32) NOT NULL,
	[OrderID] [int] NOT NULL,
	[CustomerID] [nchar](5) NULL,
	[EmployeeID] [int] NULL,
	[ShipVia] [int] NULL,
 CONSTRAINT [PK_S_LE_Order_Header_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_L_Order_Header] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [biz].[v_S_LE_Order_Header_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [biz].[v_S_LE_Order_Header_Northwind]
AS
	SELECT
		  sat.[HK_L_Order_Header]
		, sat.[DV_Load_Datetime] AS DV_Load_Datetime_Start
		, LEAD(DATEADD(NS, -100, sat.[DV_Load_Datetime]), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY link.[HK_H_Order] ORDER BY sat.[DV_Load_Datetime] ASC) AS DV_Load_Datetime_End
		, sat.[DV_Record_Source]
		, sat.[HD_S_LE_Order_Header_Northwind]
		, sat.[OrderID]
		, sat.[CustomerID]
		, sat.[EmployeeID]
		, sat.[ShipVia]
	  FROM
		[Data_Vault].[raw].[S_LE_Order_Header_Northwind] AS sat
			INNER JOIN [Data_Vault].[raw].[L_Order_Header] AS link
				ON sat.[HK_L_Order_Header] = link.[HK_L_Order_Header];
GO
/****** Object:  Table [raw].[S_HC_Product_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[S_HC_Product_Northwind](
	[HK_H_Product] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[HD_S_HC_Product_Northwind] [char](32) NOT NULL,
	[ProductName] [nvarchar](40) NOT NULL,
	[QuantityPerUnit] [nvarchar](20) NULL,
	[UnitPrice] [money] NULL,
	[UnitsInStock] [smallint] NULL,
	[UnitsOnOrder] [smallint] NULL,
	[ReorderLevel] [smallint] NULL,
	[Discontinued] [bit] NOT NULL,
 CONSTRAINT [PK_S_HC_Product_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Product] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [biz].[v_S_HC_Product_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [biz].[v_S_HC_Product_Northwind]
AS
	SELECT
		  [HK_H_Product]
		, [DV_Load_Datetime] AS DV_Load_Datetime_Start
		, LEAD(DATEADD(NS, -100, [DV_Load_Datetime]), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY [HK_H_Product] ORDER BY [DV_Load_Datetime] ASC) AS DV_Load_Datetime_End
		, [DV_Record_Source]
		, [HD_S_HC_Product_Northwind]
		, [ProductName]
		, [QuantityPerUnit]
		, [UnitPrice]
		, [UnitsInStock]
		, [UnitsOnOrder]
		, [ReorderLevel]
		, [Discontinued]
	FROM
		[Data_Vault].[raw].[S_HC_Product_Northwind];
GO
/****** Object:  Table [raw].[S_HC_Product_Category_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[S_HC_Product_Category_Northwind](
	[HK_H_Product_Category] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[HD_S_HC_Product_Category_Northwind] [char](32) NOT NULL,
	[CategoryName] [nvarchar](15) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[Picture] [varbinary](max) NULL,
 CONSTRAINT [PK_S_HC_Product_Category_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Product_Category] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA] TEXTIMAGE_ON [DATA]
GO
/****** Object:  View [biz].[v_S_HC_Product_Category_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [biz].[v_S_HC_Product_Category_Northwind]
AS
	SELECT
		  [HK_H_Product_Category]
		, [DV_Load_Datetime] AS DV_Load_Datetime_Start
		, LEAD(DATEADD(NS, -100, [DV_Load_Datetime]), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY [HK_H_Product_Category] ORDER BY [DV_Load_Datetime] ASC) AS DV_Load_Datetime_End
		, [DV_Record_Source]
		, [HD_S_HC_Product_Category_Northwind]
		, [CategoryName]
		, [Description]
		, [Picture]
	FROM
		[Data_Vault].[raw].[S_HC_Product_Category_Northwind];
GO
/****** Object:  Table [raw].[S_HC_Employee_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[S_HC_Employee_Northwind](
	[HK_H_Employee] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[HD_S_HC_Employee_Northwind] [char](32) NOT NULL,
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
	[PhotoPath] [nvarchar](255) NULL,
 CONSTRAINT [PK_S_HC_Employee_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Employee] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA] TEXTIMAGE_ON [DATA]
GO
/****** Object:  View [biz].[v_S_HC_Employee_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [biz].[v_S_HC_Employee_Northwind]
AS
	SELECT
		  [HK_H_Employee]
		, [DV_Load_Datetime] AS DV_Load_Datetime_Start
		, LEAD(DATEADD(NS, -100, [DV_Load_Datetime]), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY [HK_H_Employee] ORDER BY [DV_Load_Datetime] ASC) AS DV_Load_Datetime_End
		, [DV_Record_Source]
		, [HD_S_HC_Employee_Northwind]
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
		, [PhotoPath]
	FROM
		[Data_Vault].[raw].[S_HC_Employee_Northwind];
GO
/****** Object:  Table [biz].[PIT_Supplier]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [biz].[PIT_Supplier](
	[HK_H_Supplier] [char](32) NOT NULL,
	[DV_Snapshot_Datetime] [datetime2](7) NOT NULL,
	[S_HC_Supplier_Northwind_HK_H_Supplier] [char](32) NOT NULL,
	[S_HC_Supplier_Northwind_DV_Load_Datetime] [datetime2](7) NOT NULL,
	[S_HT_Supplier_Northwind_HK_H_Supplier] [char](32) NOT NULL,
	[S_HT_Supplier_Northwind_DV_Load_Datetime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_PIT_Supplier] PRIMARY KEY NONCLUSTERED 
(
	[DV_Snapshot_Datetime] ASC,
	[HK_H_Supplier] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [biz].[v_PIT_Supplier]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [biz].[v_PIT_Supplier]
AS
	SELECT
		  [HK_H_Supplier]
		, [DV_Snapshot_Datetime] AS DV_Snapshot_Datetime_Start
		, LEAD(DATEADD(NS, -100, [DV_Snapshot_Datetime]), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY [HK_H_Supplier] ORDER BY [DV_Snapshot_Datetime] ASC) AS DV_Snapshot_Datetime_End
		, [S_HC_Supplier_Northwind_HK_H_Supplier]
		, [S_HC_Supplier_Northwind_DV_Load_Datetime]
		, [S_HT_Supplier_Northwind_HK_H_Supplier]
		, [S_HT_Supplier_Northwind_DV_Load_Datetime]
	FROM
		[Data_Vault].[biz].[PIT_Supplier];
GO
/****** Object:  Table [biz].[PIT_Order]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [biz].[PIT_Order](
	[HK_H_Order] [char](32) NOT NULL,
	[DV_Snapshot_Datetime] [datetime2](7) NOT NULL,
	[S_HC_Order_Northwind_HK_H_Order] [char](32) NOT NULL,
	[S_HC_Order_Northwind_DV_Load_Datetime] [datetime2](7) NOT NULL,
	[S_HT_Order_Northwind_HK_H_Order] [char](32) NOT NULL,
	[S_HT_Order_Northwind_DV_Load_Datetime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_PIT_Order] PRIMARY KEY NONCLUSTERED 
(
	[DV_Snapshot_Datetime] ASC,
	[HK_H_Order] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [biz].[v_PIT_Order]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [biz].[v_PIT_Order]
AS
	SELECT
		  [HK_H_Order]
		, [DV_Snapshot_Datetime] AS DV_Snapshot_Datetime_Start
		, LEAD(DATEADD(NS, -100, [DV_Snapshot_Datetime]), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY [HK_H_Order] ORDER BY [DV_Snapshot_Datetime] ASC) AS DV_Snapshot_Datetime_End
		, [S_HC_Order_Northwind_HK_H_Order]
		, [S_HC_Order_Northwind_DV_Load_Datetime]
		, [S_HT_Order_Northwind_HK_H_Order]
		, [S_HT_Order_Northwind_DV_Load_Datetime]
	FROM
		[Data_Vault].[biz].[PIT_Order];
GO
/****** Object:  Table [biz].[PIT_Shipper]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [biz].[PIT_Shipper](
	[HK_H_Shipper] [char](32) NOT NULL,
	[DV_Snapshot_Datetime] [datetime2](7) NOT NULL,
	[S_HC_Shipper_Northwind_HK_H_Shipper] [char](32) NOT NULL,
	[S_HC_Shipper_Northwind_DV_Load_Datetime] [datetime2](7) NOT NULL,
	[S_HT_Shipper_Northwind_HK_H_Shipper] [char](32) NOT NULL,
	[S_HT_Shipper_Northwind_DV_Load_Datetime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_PIT_Shipper] PRIMARY KEY NONCLUSTERED 
(
	[DV_Snapshot_Datetime] ASC,
	[HK_H_Shipper] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [biz].[v_PIT_Shipper]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [biz].[v_PIT_Shipper]
AS
	SELECT
		  [HK_H_Shipper]
		, [DV_Snapshot_Datetime] AS DV_Snapshot_Datetime_Start
		, LEAD(DATEADD(NS, -100, [DV_Snapshot_Datetime]), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY [HK_H_Shipper] ORDER BY [DV_Snapshot_Datetime] ASC) AS DV_Snapshot_Datetime_End
		, [S_HC_Shipper_Northwind_HK_H_Shipper]
		, [S_HC_Shipper_Northwind_DV_Load_Datetime]
		, [S_HT_Shipper_Northwind_HK_H_Shipper]
		, [S_HT_Shipper_Northwind_DV_Load_Datetime]
	FROM
		[Data_Vault].[biz].[PIT_Shipper];
GO
/****** Object:  Table [biz].[PIT_Product_Category]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [biz].[PIT_Product_Category](
	[HK_H_Product_Category] [char](32) NOT NULL,
	[DV_Snapshot_Datetime] [datetime2](7) NOT NULL,
	[S_HC_Product_Category_Northwind_HK_H_Product_Category] [char](32) NOT NULL,
	[S_HC_Product_Category_Northwind_DV_Load_Datetime] [datetime2](7) NOT NULL,
	[S_HT_Product_Category_Northwind_HK_H_Product_Category] [char](32) NOT NULL,
	[S_HT_Product_Category_Northwind_DV_Load_Datetime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_PIT_Category] PRIMARY KEY NONCLUSTERED 
(
	[DV_Snapshot_Datetime] ASC,
	[HK_H_Product_Category] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [biz].[v_PIT_Product_Category]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [biz].[v_PIT_Product_Category]
AS
	SELECT
		  [HK_H_Product_Category]
		, [DV_Snapshot_Datetime] AS DV_Snapshot_Datetime_Start
		, LEAD(DATEADD(NS, -100, [DV_Snapshot_Datetime]), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY [HK_H_Product_Category] ORDER BY [DV_Snapshot_Datetime] ASC) AS DV_Snapshot_Datetime_End	
		, [S_HC_Product_Category_Northwind_HK_H_Product_Category]
		, [S_HC_Product_Category_Northwind_DV_Load_Datetime]
		, [S_HT_Product_Category_Northwind_HK_H_Product_Category]
		, [S_HT_Product_Category_Northwind_DV_Load_Datetime]
	FROM
		[Data_Vault].[biz].[PIT_Product_Category];
GO
/****** Object:  Table [biz].[PIT_Product]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [biz].[PIT_Product](
	[HK_H_Product] [char](32) NOT NULL,
	[DV_Snapshot_Datetime] [datetime2](7) NOT NULL,
	[S_HC_Product_Northwind_HK_H_Product] [char](32) NOT NULL,
	[S_HC_Product_Northwind_DV_Load_Datetime] [datetime2](7) NOT NULL,
	[S_HT_Product_Northwind_HK_H_Product] [char](32) NOT NULL,
	[S_HT_Product_Northwind_DV_Load_Datetime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_PIT_Product] PRIMARY KEY NONCLUSTERED 
(
	[DV_Snapshot_Datetime] ASC,
	[HK_H_Product] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [biz].[v_PIT_Product]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [biz].[v_PIT_Product]
AS
	SELECT
		  [HK_H_Product]
		, [DV_Snapshot_Datetime] AS DV_Snapshot_Datetime_Start
		, LEAD(DATEADD(NS, -100, [DV_Snapshot_Datetime]), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY [HK_H_Product] ORDER BY [DV_Snapshot_Datetime] ASC) AS DV_Snapshot_Datetime_End
		, [S_HC_Product_Northwind_HK_H_Product]
		, [S_HC_Product_Northwind_DV_Load_Datetime]
		, [S_HT_Product_Northwind_HK_H_Product]
		, [S_HT_Product_Northwind_DV_Load_Datetime]
	FROM
		[Data_Vault].[biz].[PIT_Product];
GO
/****** Object:  Table [biz].[PIT_Employee]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [biz].[PIT_Employee](
	[HK_H_Employee] [char](32) NOT NULL,
	[DV_Snapshot_Datetime] [datetime2](7) NOT NULL,
	[S_HC_Employee_Northwind_HK_H_Employee] [char](32) NOT NULL,
	[S_HC_Employee_Northwind_DV_Load_Datetime] [datetime2](7) NOT NULL,
	[S_HT_Employee_Northwind_HK_H_Employee] [char](32) NOT NULL,
	[S_HT_Employee_Northwind_DV_Load_Datetime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_PIT_Employee] PRIMARY KEY NONCLUSTERED 
(
	[DV_Snapshot_Datetime] ASC,
	[HK_H_Employee] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [biz].[v_PIT_Employee]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [biz].[v_PIT_Employee]
AS
	SELECT
		  [HK_H_Employee]
		, [DV_Snapshot_Datetime] AS DV_Snapshot_Datetime_Start
		, LEAD(DATEADD(NS, -100, [DV_Snapshot_Datetime]), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY [HK_H_Employee] ORDER BY [DV_Snapshot_Datetime] ASC) AS DV_Snapshot_Datetime_End
		, [S_HC_Employee_Northwind_HK_H_Employee]
		, [S_HC_Employee_Northwind_DV_Load_Datetime]
		, [S_HT_Employee_Northwind_HK_H_Employee]
		, [S_HT_Employee_Northwind_DV_Load_Datetime]
	FROM
		[Data_Vault].[biz].[PIT_Employee];
GO
/****** Object:  Table [raw].[S_HC_Shipper_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[S_HC_Shipper_Northwind](
	[HK_H_Shipper] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[HD_S_HC_Shipper_Northwind] [char](32) NOT NULL,
	[CompanyName] [nvarchar](40) NOT NULL,
	[Phone] [nvarchar](24) NULL,
 CONSTRAINT [PK_S_HC_Shipper_Northwind] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Shipper] ASC,
	[DV_Load_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  View [biz].[v_S_HC_Shipper_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [biz].[v_S_HC_Shipper_Northwind]
AS
	SELECT
		  [HK_H_Shipper]
		, [DV_Load_Datetime] AS DV_Load_Datetime_Start
		, LEAD(DATEADD(NS, -100, [DV_Load_Datetime]), 1, '9999-12-31 23:59:59.9999999') OVER(PARTITION BY [HK_H_Shipper] ORDER BY [DV_Load_Datetime] ASC) AS DV_Load_Datetime_End
		, [DV_Record_Source]
		, [HD_S_HC_Shipper_Northwind]
		, [CompanyName]
		, [Phone]
	FROM
		[Data_Vault].[raw].[S_HC_Shipper_Northwind];






GO
/****** Object:  Table [raw].[H_Customer]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[H_Customer](
	[HK_H_Customer] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[DV_Business_Key] [varchar](20) NOT NULL,
 CONSTRAINT [PK_H_Customer] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Customer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  Table [raw].[H_Customer_Type]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[H_Customer_Type](
	[HK_H_Customer_Type] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[DV_Business_Key] [varchar](20) NOT NULL,
 CONSTRAINT [PK_H_Customer_Type] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Customer_Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  Table [raw].[H_Employee]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[H_Employee](
	[HK_H_Employee] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[DV_Business_Key] [varchar](20) NOT NULL,
 CONSTRAINT [PK_H_Employee] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Employee] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  Table [raw].[H_Order]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[H_Order](
	[HK_H_Order] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[DV_Business_Key] [varchar](20) NOT NULL,
 CONSTRAINT [PK_H_Order] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Order] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  Table [raw].[H_Order_Detail]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[H_Order_Detail](
	[HK_H_Order_Detail] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[DV_Business_Key] [varchar](20) NOT NULL,
 CONSTRAINT [PK_H_Order_Detail] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Order_Detail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  Table [raw].[H_Product]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[H_Product](
	[HK_H_Product] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[DV_Business_Key] [varchar](20) NOT NULL,
 CONSTRAINT [PK_H_Product] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Product] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  Table [raw].[H_Product_Category]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[H_Product_Category](
	[HK_H_Product_Category] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[DV_Business_Key] [varchar](20) NOT NULL,
 CONSTRAINT [PK_H_Product_Category] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Product_Category] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  Table [raw].[H_Region]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[H_Region](
	[HK_H_Region] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[DV_Business_Key] [varchar](20) NOT NULL,
 CONSTRAINT [PK_H_Region] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Region] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  Table [raw].[H_Shipper]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[H_Shipper](
	[HK_H_Shipper] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[DV_Business_Key] [varchar](20) NOT NULL,
 CONSTRAINT [PK_H_Shipper] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Shipper] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  Table [raw].[H_Supplier]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[H_Supplier](
	[HK_H_Supplier] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[DV_Business_Key] [varchar](20) NOT NULL,
 CONSTRAINT [PK_H_Supplier] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Supplier] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  Table [raw].[H_Territory]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[H_Territory](
	[HK_H_Territory] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[DV_Business_Key] [varchar](20) NOT NULL,
 CONSTRAINT [PK_H_Territory] PRIMARY KEY NONCLUSTERED 
(
	[HK_H_Territory] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  Table [raw].[L_Customer_Type]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[L_Customer_Type](
	[HK_L_Customer_Type] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[HK_H_Customer] [char](32) NOT NULL,
	[HK_H_Customer_Type] [char](32) NOT NULL,
 CONSTRAINT [PK_L_Customer_Type] PRIMARY KEY NONCLUSTERED 
(
	[HK_L_Customer_Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  Table [raw].[L_Employee_Territory]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[L_Employee_Territory](
	[HK_L_Employee_Territory] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[HK_H_Employee] [char](32) NOT NULL,
	[HK_H_Territory] [char](32) NOT NULL,
 CONSTRAINT [PK_L_Employee_Territory] PRIMARY KEY NONCLUSTERED 
(
	[HK_L_Employee_Territory] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
/****** Object:  Table [raw].[L_Order_Detail]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[L_Order_Detail](
	[HK_L_Order_Detail] [char](32) NOT NULL,
	[DV_Load_Datetime] [datetime2](7) NOT NULL,
	[DV_Record_Source] [varchar](100) NOT NULL,
	[HK_H_Order] [char](32) NOT NULL,
	[HK_H_Order_Detail] [char](32) NOT NULL,
	[HK_H_Product] [char](32) NOT NULL,
 CONSTRAINT [PK_L_Order_Detail] PRIMARY KEY NONCLUSTERED 
(
	[HK_L_Order_Detail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [DATA]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_H_Customer]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE NONCLUSTERED INDEX [IX_H_Customer] ON [raw].[H_Customer]
(
	[HK_H_Customer] ASC
)
INCLUDE([DV_Load_Datetime]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_H_Customer]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_H_Customer] ON [raw].[H_Customer]
(
	[DV_Business_Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_H_Customer_Type]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE NONCLUSTERED INDEX [IX_H_Customer_Type] ON [raw].[H_Customer_Type]
(
	[HK_H_Customer_Type] ASC
)
INCLUDE([DV_Load_Datetime]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_H_Customer_Type]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_H_Customer_Type] ON [raw].[H_Customer_Type]
(
	[DV_Business_Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_H_Employee]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE NONCLUSTERED INDEX [IX_H_Employee] ON [raw].[H_Employee]
(
	[HK_H_Employee] ASC
)
INCLUDE([DV_Load_Datetime]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_H_Employee]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_H_Employee] ON [raw].[H_Employee]
(
	[DV_Business_Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_H_Order]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE NONCLUSTERED INDEX [IX_H_Order] ON [raw].[H_Order]
(
	[HK_H_Order] ASC
)
INCLUDE([DV_Load_Datetime]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_H_Order]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_H_Order] ON [raw].[H_Order]
(
	[DV_Business_Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_H_Order_Detail]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE NONCLUSTERED INDEX [IX_H_Order_Detail] ON [raw].[H_Order_Detail]
(
	[HK_H_Order_Detail] ASC
)
INCLUDE([DV_Load_Datetime]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_H_Order_Detail]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_H_Order_Detail] ON [raw].[H_Order_Detail]
(
	[DV_Business_Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_H_Product]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE NONCLUSTERED INDEX [IX_H_Product] ON [raw].[H_Product]
(
	[HK_H_Product] ASC
)
INCLUDE([DV_Load_Datetime]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_H_Product]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_H_Product] ON [raw].[H_Product]
(
	[DV_Business_Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_H_Product_Category]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE NONCLUSTERED INDEX [IX_H_Product_Category] ON [raw].[H_Product_Category]
(
	[HK_H_Product_Category] ASC
)
INCLUDE([DV_Load_Datetime]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_H_Product_Category]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_H_Product_Category] ON [raw].[H_Product_Category]
(
	[DV_Business_Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_H_Region]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE NONCLUSTERED INDEX [IX_H_Region] ON [raw].[H_Region]
(
	[HK_H_Region] ASC
)
INCLUDE([DV_Load_Datetime]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_H_Region]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_H_Region] ON [raw].[H_Region]
(
	[DV_Business_Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_H_Shipper]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE NONCLUSTERED INDEX [IX_H_Shipper] ON [raw].[H_Shipper]
(
	[HK_H_Shipper] ASC
)
INCLUDE([DV_Load_Datetime]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_H_Shipper]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_H_Shipper] ON [raw].[H_Shipper]
(
	[DV_Business_Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_H_Supplier]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE NONCLUSTERED INDEX [IX_H_Supplier] ON [raw].[H_Supplier]
(
	[HK_H_Supplier] ASC
)
INCLUDE([DV_Load_Datetime]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_H_Supplier]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_H_Supplier] ON [raw].[H_Supplier]
(
	[DV_Business_Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_H_Territory]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE NONCLUSTERED INDEX [IX_H_Territory] ON [raw].[H_Territory]
(
	[HK_H_Territory] ASC
)
INCLUDE([DV_Load_Datetime]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_H_Territory]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_H_Territory] ON [raw].[H_Territory]
(
	[DV_Business_Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_L_Customer_Type]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE NONCLUSTERED INDEX [IX_L_Customer_Type] ON [raw].[L_Customer_Type]
(
	[HK_L_Customer_Type] ASC
)
INCLUDE([HK_H_Customer],[HK_H_Customer_Type],[DV_Load_Datetime]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_L_Customer_Type]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_L_Customer_Type] ON [raw].[L_Customer_Type]
(
	[HK_H_Customer] ASC,
	[HK_H_Customer_Type] ASC
)
INCLUDE([HK_L_Customer_Type]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_L_Employee_Reporting_Line]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE NONCLUSTERED INDEX [IX_L_Employee_Reporting_Line] ON [raw].[L_Employee_Reporting_Line]
(
	[HK_L_Employee_Reporting_Line] ASC
)
INCLUDE([HK_H_Employee],[HK_H_Employee_Manager],[DV_Load_Datetime]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_L_Employee_Reporting_Line]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_L_Employee_Reporting_Line] ON [raw].[L_Employee_Reporting_Line]
(
	[HK_H_Employee] ASC,
	[HK_H_Employee_Manager] ASC
)
INCLUDE([HK_L_Employee_Reporting_Line]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_L_Employee_Territory]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE NONCLUSTERED INDEX [IX_L_Employee_Territory] ON [raw].[L_Employee_Territory]
(
	[HK_L_Employee_Territory] ASC
)
INCLUDE([HK_H_Employee],[HK_H_Territory],[DV_Load_Datetime]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_L_Employee_Territory]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_L_Employee_Territory] ON [raw].[L_Employee_Territory]
(
	[HK_H_Employee] ASC,
	[HK_H_Territory] ASC
)
INCLUDE([HK_L_Employee_Territory]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_L_Order_Detail]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE NONCLUSTERED INDEX [IX_L_Order_Detail] ON [raw].[L_Order_Detail]
(
	[HK_L_Order_Detail] ASC
)
INCLUDE([HK_H_Order],[HK_H_Order_Detail],[HK_H_Product],[DV_Load_Datetime]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_L_Order_Detail]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_L_Order_Detail] ON [raw].[L_Order_Detail]
(
	[HK_H_Order] ASC,
	[HK_H_Order_Detail] ASC,
	[HK_H_Product] ASC
)
INCLUDE([HK_L_Order_Detail]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_L_Order_Header]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE NONCLUSTERED INDEX [IX_L_Order_Header] ON [raw].[L_Order_Header]
(
	[HK_L_Order_Header] ASC
)
INCLUDE([HK_H_Customer],[HK_H_Employee],[HK_H_Order],[HK_H_Shipper],[DV_Load_Datetime]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_L_Order_Header]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_L_Order_Header] ON [raw].[L_Order_Header]
(
	[HK_H_Customer] ASC,
	[HK_H_Employee] ASC,
	[HK_H_Order] ASC,
	[HK_H_Shipper] ASC
)
INCLUDE([HK_L_Order_Header]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_L_Product_Category]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE NONCLUSTERED INDEX [IX_L_Product_Category] ON [raw].[L_Product_Category]
(
	[HK_L_Product_Category] ASC
)
INCLUDE([HK_H_Product],[HK_H_Product_Category],[DV_Load_Datetime]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_L_Product_Category]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_L_Product_Category] ON [raw].[L_Product_Category]
(
	[HK_H_Product] ASC,
	[HK_H_Product_Category] ASC
)
INCLUDE([HK_L_Product_Category]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_L_Product_Supplier]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE NONCLUSTERED INDEX [IX_L_Product_Supplier] ON [raw].[L_Product_Supplier]
(
	[HK_L_Product_Supplier] ASC
)
INCLUDE([HK_H_Product],[HK_H_Supplier],[DV_Load_Datetime]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_L_Product_Supplier]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_L_Product_Supplier] ON [raw].[L_Product_Supplier]
(
	[HK_H_Product] ASC,
	[HK_H_Supplier] ASC
)
INCLUDE([HK_L_Product_Supplier]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_L_Territory_Region]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE NONCLUSTERED INDEX [IX_L_Territory_Region] ON [raw].[L_Territory_Region]
(
	[HK_L_Territory_Region] ASC
)
INCLUDE([HK_H_Territory],[HK_H_Region],[DV_Load_Datetime]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_L_Territory_Region]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_L_Territory_Region] ON [raw].[L_Territory_Region]
(
	[HK_H_Territory] ASC,
	[HK_H_Region] ASC
)
INCLUDE([HK_L_Territory_Region]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UX_S_HC_Customer_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UX_S_HC_Customer_Northwind] ON [raw].[S_HC_Customer_Northwind]
(
	[HK_H_Customer] ASC,
	[DV_Load_Datetime] ASC
)
INCLUDE([HD_S_HC_Customer_Northwind]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UX_S_HC_Customer_Type_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UX_S_HC_Customer_Type_Northwind] ON [raw].[S_HC_Customer_Type_Northwind]
(
	[HK_H_Customer_Type] ASC,
	[DV_Load_Datetime] ASC
)
INCLUDE([HD_S_HC_Customer_Type_Northwind]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UX_S_HC_Employee_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UX_S_HC_Employee_Northwind] ON [raw].[S_HC_Employee_Northwind]
(
	[HK_H_Employee] ASC,
	[DV_Load_Datetime] ASC
)
INCLUDE([HD_S_HC_Employee_Northwind]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UX_S_HC_Order_Detail_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UX_S_HC_Order_Detail_Northwind] ON [raw].[S_HC_Order_Detail_Northwind]
(
	[HK_H_Order_Detail] ASC,
	[DV_Load_Datetime] ASC
)
INCLUDE([HD_S_HC_Order_Detail_Northwind]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UX_S_HC_Order_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UX_S_HC_Order_Northwind] ON [raw].[S_HC_Order_Northwind]
(
	[HK_H_Order] ASC,
	[DV_Load_Datetime] ASC
)
INCLUDE([HD_S_HC_Order_Northwind]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UX_S_HC_Product_Category_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UX_S_HC_Product_Category_Northwind] ON [raw].[S_HC_Product_Category_Northwind]
(
	[HK_H_Product_Category] ASC,
	[DV_Load_Datetime] ASC
)
INCLUDE([HD_S_HC_Product_Category_Northwind]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UX_S_HC_Product_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UX_S_HC_Product_Northwind] ON [raw].[S_HC_Product_Northwind]
(
	[HK_H_Product] ASC,
	[DV_Load_Datetime] ASC
)
INCLUDE([HD_S_HC_Product_Northwind]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UX_S_HC_Region_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UX_S_HC_Region_Northwind] ON [raw].[S_HC_Region_Northwind]
(
	[HK_H_Region] ASC,
	[DV_Load_Datetime] ASC
)
INCLUDE([HD_S_HC_Region_Northwind]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UX_S_HC_Shipper_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UX_S_HC_Shipper_Northwind] ON [raw].[S_HC_Shipper_Northwind]
(
	[HK_H_Shipper] ASC,
	[DV_Load_Datetime] ASC
)
INCLUDE([HD_S_HC_Shipper_Northwind]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UX_S_HC_Supplier_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UX_S_HC_Supplier_Northwind] ON [raw].[S_HC_Supplier_Northwind]
(
	[HK_H_Supplier] ASC,
	[DV_Load_Datetime] ASC
)
INCLUDE([HD_S_HC_Supplier_Northwind]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UX_S_HC_Territory_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UX_S_HC_Territory_Northwind] ON [raw].[S_HC_Territory_Northwind]
(
	[HK_H_Territory] ASC,
	[DV_Load_Datetime] ASC
)
INCLUDE([HD_S_HC_Territory_Northwind]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UX_S_HT_Customer_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UX_S_HT_Customer_Northwind] ON [raw].[S_HT_Customer_Northwind]
(
	[HK_H_Customer] ASC,
	[DV_Load_Datetime] ASC
)
INCLUDE([DV_Deleted_Flag],[HD_S_HT_Customer_Northwind]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UX_S_HT_Customer_Type_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UX_S_HT_Customer_Type_Northwind] ON [raw].[S_HT_Customer_Type_Northwind]
(
	[HK_H_Customer_Type] ASC,
	[DV_Load_Datetime] ASC
)
INCLUDE([DV_Deleted_Flag],[HD_S_HT_Customer_Type_Northwind]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UX_S_HT_Employee_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UX_S_HT_Employee_Northwind] ON [raw].[S_HT_Employee_Northwind]
(
	[HK_H_Employee] ASC,
	[DV_Load_Datetime] ASC
)
INCLUDE([DV_Deleted_Flag],[HD_S_HT_Employee_Northwind]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UX_S_HT_Order_Detail_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UX_S_HT_Order_Detail_Northwind] ON [raw].[S_HT_Order_Detail_Northwind]
(
	[HK_H_Order_Detail] ASC,
	[DV_Load_Datetime] ASC
)
INCLUDE([DV_Deleted_Flag],[HD_S_HT_Order_Detail_Northwind]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UX_S_HT_Order_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UX_S_HT_Order_Northwind] ON [raw].[S_HT_Order_Northwind]
(
	[HK_H_Order] ASC,
	[DV_Load_Datetime] ASC
)
INCLUDE([DV_Deleted_Flag],[HD_S_HT_Order_Northwind]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UX_S_HT_Product_Category_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UX_S_HT_Product_Category_Northwind] ON [raw].[S_HT_Product_Category_Northwind]
(
	[HK_H_Product_Category] ASC,
	[DV_Load_Datetime] ASC
)
INCLUDE([DV_Deleted_Flag],[HD_S_HT_Product_Category_Northwind]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UX_S_HT_Product_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UX_S_HT_Product_Northwind] ON [raw].[S_HT_Product_Northwind]
(
	[HK_H_Product] ASC,
	[DV_Load_Datetime] ASC
)
INCLUDE([DV_Deleted_Flag],[HD_S_HT_Product_Northwind]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UX_S_HT_Region_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UX_S_HT_Region_Northwind] ON [raw].[S_HT_Region_Northwind]
(
	[HK_H_Region] ASC,
	[DV_Load_Datetime] ASC
)
INCLUDE([DV_Deleted_Flag],[HD_S_HT_Region_Northwind]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UX_S_HT_Shipper_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UX_S_HT_Shipper_Northwind] ON [raw].[S_HT_Shipper_Northwind]
(
	[HK_H_Shipper] ASC,
	[DV_Load_Datetime] ASC
)
INCLUDE([DV_Deleted_Flag],[HD_S_HT_Shipper_Northwind]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UX_S_HT_Supplier_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UX_S_HT_Supplier_Northwind] ON [raw].[S_HT_Supplier_Northwind]
(
	[HK_H_Supplier] ASC,
	[DV_Load_Datetime] ASC
)
INCLUDE([DV_Deleted_Flag],[HD_S_HT_Supplier_Northwind]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UX_S_HT_Territory_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UX_S_HT_Territory_Northwind] ON [raw].[S_HT_Territory_Northwind]
(
	[HK_H_Territory] ASC,
	[DV_Load_Datetime] ASC
)
INCLUDE([DV_Deleted_Flag],[HD_S_HT_Territory_Northwind]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UX_S_LT_Customer_Type_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UX_S_LT_Customer_Type_Northwind] ON [raw].[S_LT_Customer_Type_Northwind]
(
	[HK_L_Customer_Type] ASC,
	[DV_Load_Datetime] ASC
)
INCLUDE([DV_Deleted_Flag],[HD_S_LT_Customer_Type_Northwind]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UX_S_LT_Employee_Territory_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [UX_S_LT_Employee_Territory_Northwind] ON [raw].[S_LT_Employee_Territory_Northwind]
(
	[HK_L_Employee_Territory] ASC,
	[DV_Load_Datetime] ASC
)
INCLUDE([DV_Deleted_Flag],[HD_S_LT_Employee_Territory_Northwind]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
GO
/****** Object:  StoredProcedure [biz].[usp_Load_B_Order]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [biz].[usp_Load_B_Order] 
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			DECLARE @DV_Snapshot_Datetime datetime2(7) = SYSDATETIME()

			/* Insert new Bridge snapshot */

			BEGIN

				-- Generate input for Bridge table
				WITH CTE_Bridge AS (
					SELECT
						  @DV_Snapshot_Datetime AS DV_Snapshot_Datetime
						, link_order_header.[HK_H_Order]
						, link_order_header.[HK_H_Customer]
						, link_order_header.[HK_H_Employee]
						, link_order_header.[HK_H_Shipper]
						, ISNULL(CAST(CONVERT(varchar(8), sat_hc_order_northwind.[OrderDate], 112) AS int), '19000101') AS Order_Submitted_Date_Key
						, ISNULL(CAST(CONVERT(varchar(8), sat_hc_order_northwind.[RequiredDate], 112) AS int), '19000101') AS Order_Required_Date_Key
						, ISNULL(CAST(CONVERT(varchar(8), sat_hc_order_northwind.[ShippedDate], 112) AS int), '19000101') AS Order_Shipped_Date_Key
					FROM
						[Data_Vault].[raw].[L_Order_Header] AS link_order_header
							INNER JOIN [Data_Vault].[biz].[v_S_LE_Order_Header_Northwind] AS sat_le_order_header_northwind
								ON link_order_header.[HK_L_Order_Header] = sat_le_order_header_northwind.[HK_L_Order_Header]
							   AND @DV_Snapshot_Datetime BETWEEN sat_le_order_header_northwind.[DV_Load_Datetime_Start] AND sat_le_order_header_northwind.[DV_Load_Datetime_End]
							INNER JOIN [Data_Vault].[biz].[v_S_HC_Order_Northwind] AS sat_hc_order_northwind
								ON link_order_header.[HK_H_Order] = sat_hc_order_northwind.[HK_H_Order]
							   AND @DV_Snapshot_Datetime BETWEEN sat_hc_order_northwind.[DV_Load_Datetime_Start] AND sat_hc_order_northwind.[DV_Load_Datetime_End]
					WHERE
						-- Omit ghost record
						link_order_header.[HK_H_Order] <> REPLICATE('0', 32)
				)

				-- Insert snapshot
				INSERT INTO [Data_Vault].[biz].[B_Order] (
					  [DV_Snapshot_Datetime]
					, [HK_H_Order]
					, [HK_H_Customer]
					, [HK_H_Employee]
					, [HK_H_Shipper]
					, [Order_Submitted_Date_Key]
					, [Order_Required_Date_Key]
					, [Order_Shipped_Date_Key]
				)
				SELECT
					  [DV_Snapshot_Datetime]
					, [HK_H_Order]
					, [HK_H_Customer]
					, [HK_H_Employee]
					, [HK_H_Shipper]
					, [Order_Submitted_Date_Key]
					, [Order_Required_Date_Key]
					, [Order_Shipped_Date_Key]
				FROM
					CTE_Bridge;

			END


			/* Delete snapshots outside the managed PIT window */

			BEGIN

				DELETE
					bridge
				FROM
					[Data_Vault].[biz].[B_Order] AS bridge
						LEFT JOIN [Data_Vault].[biz].[v_R_PIT_Window] AS ref_pit_window
							ON CAST(bridge.[DV_Snapshot_Datetime] AS date) = ref_pit_window.[Date]
				WHERE
					ref_pit_window.[Date_Key] IS NULL;

			END

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
/****** Object:  StoredProcedure [biz].[usp_Load_B_Order_Detail]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [biz].[usp_Load_B_Order_Detail] 
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			DECLARE @DV_Snapshot_Datetime datetime2(7) = DATEADD(MINUTE, -0,SYSDATETIME());

			/* Insert new Bridge snapshot */

			BEGIN

				-- Generate input for Bridge table
				WITH CTE_Bridge AS (
					SELECT
						  @DV_Snapshot_Datetime AS DV_Snapshot_Datetime
						, link_order_detail.[HK_H_Order_Detail]
						, link_order_detail.[HK_H_Order]
						, link_order_detail.[HK_H_Product]							
						, link_order_header.[HK_H_Customer]
						, link_order_header.[HK_H_Employee]
						, link_order_header.[HK_H_Shipper]
						, ISNULL(CAST(CONVERT(varchar(8), sat_hc_order_northwind.[OrderDate], 112) AS int), '19000101') AS Order_Submitted_Date_Key
						, ISNULL(CAST(CONVERT(varchar(8), sat_hc_order_northwind.[RequiredDate], 112) AS int), '19000101') AS Order_Required_Date_Key
						, ISNULL(CAST(CONVERT(varchar(8), sat_hc_order_northwind.[ShippedDate], 112) AS int), '19000101') AS Order_Shipped_Date_Key
					FROM
						[Data_Vault].[raw].[L_Order_Detail] AS link_order_detail
							INNER JOIN [Data_Vault].[biz].[v_S_HT_Order_Detail_Northwind] AS sat_ht_order_detail_northwind
								ON link_order_detail.[HK_H_Order_Detail] = sat_ht_order_detail_northwind.[HK_H_Order_Detail]
								AND @DV_Snapshot_Datetime BETWEEN sat_ht_order_detail_northwind.[DV_Load_Datetime_Start] AND sat_ht_order_detail_northwind.[DV_Load_Datetime_End]
							INNER JOIN [Data_Vault].[raw].[L_Order_Header] AS link_order_header
								ON link_order_detail.[HK_H_Order] = link_order_header.[HK_H_Order]
							INNER JOIN [Data_Vault].[biz].[v_S_LE_Order_Header_Northwind] AS link_le_order_header_northwind
								ON link_order_header.[HK_L_Order_Header] = link_le_order_header_northwind.[HK_L_Order_Header]
							   AND @DV_Snapshot_Datetime BETWEEN link_le_order_header_northwind.[DV_Load_Datetime_Start] AND link_le_order_header_northwind.[DV_Load_Datetime_End]
							INNER JOIN [Data_Vault].[biz].[v_S_HC_Order_Northwind] AS sat_hc_order_northwind
								ON link_order_header.[HK_H_Order] = sat_hc_order_northwind.[HK_H_Order]
							   AND @DV_Snapshot_Datetime BETWEEN sat_hc_order_northwind.[DV_Load_Datetime_Start] AND sat_hc_order_northwind.[DV_Load_Datetime_End]
					WHERE
						-- Omit ghost record
						link_order_detail.[HK_H_Order] <> REPLICATE('0', 32)
				)

				-- Insert snapshot
				INSERT INTO [Data_Vault].[biz].[B_Order_Detail] (
					  [DV_Snapshot_Datetime]
					, [HK_H_Order_Detail]
					, [HK_H_Order]
					, [HK_H_Product]
					, [HK_H_Customer]
					, [HK_H_Employee]
					, [HK_H_Shipper]
					, [Order_Submitted_Date_Key]
					, [Order_Required_Date_Key]
					, [Order_Shipped_Date_Key]
				)
				SELECT
					  [DV_Snapshot_Datetime]
					, [HK_H_Order_Detail]
					, [HK_H_Order]
					, [HK_H_Product]
					, [HK_H_Customer]
					, [HK_H_Employee]
					, [HK_H_Shipper]
					, [Order_Submitted_Date_Key]
					, [Order_Required_Date_Key]
					, [Order_Shipped_Date_Key]
				FROM
					CTE_Bridge

			END


			/* Delete snapshots outside the managed PIT window */

			BEGIN

				DELETE
					bridge
				FROM
					[Data_Vault].[biz].[B_Order_Detail] AS bridge
						LEFT JOIN [Data_Vault].[biz].[v_R_PIT_Window] AS ref_pit_window
							ON CAST(bridge.[DV_Snapshot_Datetime] AS date) = ref_pit_window.[Date]
				WHERE
					ref_pit_window.[Date_Key] IS NULL;

			END

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
/****** Object:  StoredProcedure [biz].[usp_Load_PIT_Customer]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [biz].[usp_Load_PIT_Customer] 
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			DECLARE @DV_Load_Datetime datetime2(7) = SYSDATETIME();

			/* Insert new PIT snapshot */

			BEGIN
				
				-- Generate input for PIT table
				WITH CTE_Point_In_Time AS (
					SELECT 
						  hub_customer.[HK_H_Customer]
						, @DV_Load_Datetime AS DV_Snapshot_Datetime
						, ISNULL(sat_hc_customer_northwind.[HK_H_Customer], REPLICATE('0', 32)) AS S_HC_Customer_Northwind_HK_H_Customer
						, ISNULL(sat_hc_customer_northwind.[DV_Load_Datetime_Start], '1900-01-01 00:00:00.0000000') AS S_HC_Customer_Northwind_DV_Load_Datetime
						, ISNULL(sat_ht_customer_northwind.[HK_H_Customer], REPLICATE('0', 32)) AS S_HT_Customer_Northwind_HK_H_Customer
						, ISNULL(sat_ht_customer_northwind.[DV_Load_Datetime_Start], '1900-01-01 00:00:00.0000000') AS S_HT_Customer_Northwind_DV_Load_Datetime
					FROM
						[Data_Vault].[raw].[H_Customer] AS hub_customer
							LEFT JOIN [Data_Vault].[biz].[v_S_HC_Customer_Northwind] AS sat_hc_customer_northwind
								ON hub_customer.[HK_H_Customer] = sat_hc_customer_northwind.[HK_H_Customer]
							   AND @DV_Load_Datetime BETWEEN sat_hc_customer_northwind.[DV_Load_Datetime_Start] AND sat_hc_customer_northwind.[DV_Load_Datetime_End]
							LEFT JOIN [Data_Vault].[biz].[v_S_HT_Customer_Northwind] AS sat_ht_customer_northwind
								ON hub_customer.[HK_H_Customer] = sat_ht_customer_northwind.[HK_H_Customer]
							   AND @DV_Load_Datetime BETWEEN sat_ht_customer_northwind.[DV_Load_Datetime_Start] AND sat_ht_customer_northwind.[DV_Load_Datetime_End]
				)

				-- Insert snapshot
				INSERT INTO [Data_Vault].[biz].[PIT_Customer] (
					  [HK_H_Customer]
					, [DV_Snapshot_Datetime]
					, [S_HC_Customer_Northwind_HK_H_Customer]
					, [S_HC_Customer_Northwind_DV_Load_Datetime]
					, [S_HT_Customer_Northwind_HK_H_Customer]
					, [S_HT_Customer_Northwind_DV_Load_Datetime]
				)
				SELECT
					  [HK_H_Customer]
					, [DV_Snapshot_Datetime]
					, [S_HC_Customer_Northwind_HK_H_Customer]
					, [S_HC_Customer_Northwind_DV_Load_Datetime]
					, [S_HT_Customer_Northwind_HK_H_Customer]
					, [S_HT_Customer_Northwind_DV_Load_Datetime]
				FROM
					CTE_Point_In_Time;

			END


			/* Delete snapshots outside the managed PIT window */

			BEGIN

				DELETE
					pit
				FROM
					[Data_Vault].[biz].[PIT_Customer] AS pit
						LEFT JOIN [Data_Vault].[biz].[v_R_PIT_Window] AS ref_pit_window
							ON CAST(pit.[DV_Snapshot_Datetime] AS date) = ref_pit_window.[Date]
				WHERE
					ref_pit_window.[Date_Key] IS NULL;

			END
			
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
/****** Object:  StoredProcedure [biz].[usp_Load_PIT_Customer_Type]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [biz].[usp_Load_PIT_Customer_Type] 
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			DECLARE @DV_Load_Datetime datetime2(7) = SYSDATETIME();

			/* Insert new PIT snapshot */

			BEGIN
				
				-- Generate input for PIT table
				WITH CTE_Point_In_Time AS (
					SELECT 
						  hub_customer_type.[HK_H_Customer_Type]
						, @DV_Load_Datetime AS DV_Snapshot_Datetime
						, ISNULL(sat_hc_customer_type_northwind.[HK_H_Customer_Type], REPLICATE('0', 32)) AS S_HC_Customer_Type_Northwind_HK_H_Customer_Type
						, ISNULL(sat_hc_customer_type_northwind.[DV_Load_Datetime_Start], '1900-01-01 00:00:00.0000000') AS S_HC_Customer_Type_Northwind_DV_Load_Datetime
						, ISNULL(sat_ht_customer_type_northwind.[HK_H_Customer_Type], REPLICATE('0', 32)) AS S_HT_Customer_Type_Northwind_HK_H_Customer_Type
						, ISNULL(sat_ht_customer_type_northwind.[DV_Load_Datetime_Start], '1900-01-01 00:00:00.0000000') AS S_HT_Customer_Type_Northwind_DV_Load_Datetime
					FROM
						[Data_Vault].[raw].[H_Customer_Type] AS hub_customer_type
							LEFT JOIN [Data_Vault].[biz].[v_S_HC_Customer_Type_Northwind] AS sat_hc_customer_type_northwind
								ON hub_customer_type.[HK_H_Customer_Type] = sat_hc_customer_type_northwind.[HK_H_Customer_Type]
							   AND @DV_Load_Datetime BETWEEN sat_hc_customer_type_northwind.[DV_Load_Datetime_Start] AND sat_hc_customer_type_northwind.[DV_Load_Datetime_End]
							LEFT JOIN [Data_Vault].[biz].[v_S_HT_Customer_Type_Northwind] AS sat_ht_customer_type_northwind
								ON hub_customer_type.[HK_H_Customer_Type] = sat_ht_customer_type_northwind.[HK_H_Customer_Type]
							   AND @DV_Load_Datetime BETWEEN sat_ht_customer_type_northwind.[DV_Load_Datetime_Start] AND sat_ht_customer_type_northwind.[DV_Load_Datetime_End]
				)

				-- Insert snapshot
				INSERT INTO [Data_Vault].[biz].[PIT_Customer_Type] (
					  [HK_H_Customer_Type]
					, [DV_Snapshot_Datetime]
					, [S_HC_Customer_Type_Northwind_HK_H_Customer_Type]
					, [S_HC_Customer_Type_Northwind_DV_Load_Datetime]
					, [S_HT_Customer_Type_Northwind_HK_H_Customer_Type]
					, [S_HT_Customer_Type_Northwind_DV_Load_Datetime]
				)
				SELECT
					  [HK_H_Customer_Type]
					, [DV_Snapshot_Datetime]
					, [S_HC_Customer_Type_Northwind_HK_H_Customer_Type]
					, [S_HC_Customer_Type_Northwind_DV_Load_Datetime]
					, [S_HT_Customer_Type_Northwind_HK_H_Customer_Type]
					, [S_HT_Customer_Type_Northwind_DV_Load_Datetime]
				FROM
					CTE_Point_In_Time;

			END


			/* Delete snapshots outside the managed PIT window */

			BEGIN

				DELETE
					pit
				FROM
					[Data_Vault].[biz].[PIT_Customer_Type] AS pit
						LEFT JOIN [Data_Vault].[biz].[v_R_PIT_Window] AS ref_pit_window
							ON CAST(pit.[DV_Snapshot_Datetime] AS date) = ref_pit_window.[Date]
				WHERE
					ref_pit_window.[Date_Key] IS NULL;

			END
			
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
/****** Object:  StoredProcedure [biz].[usp_Load_PIT_Employee]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [biz].[usp_Load_PIT_Employee] 
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			DECLARE @DV_Load_Datetime datetime2(7) = SYSDATETIME();

			/* Insert new PIT snapshot */

			BEGIN
				
				-- Generate input for PIT table
				WITH CTE_Point_In_Time AS (
					SELECT 
						  hub_employee.[HK_H_Employee]
						, @DV_Load_Datetime AS DV_Snapshot_Datetime
						, ISNULL(sat_hc_employee_northwind.[HK_H_Employee], REPLICATE('0', 32)) AS S_HC_Employee_Northwind_HK_H_Employee
						, ISNULL(sat_hc_employee_northwind.[DV_Load_Datetime_Start], '1900-01-01 00:00:00.0000000') AS S_HC_Employee_Northwind_DV_Load_Datetime
						, ISNULL(sat_ht_employee_northwind.[HK_H_Employee], REPLICATE('0', 32)) AS S_HT_Employee_Northwind_HK_H_Employee
						, ISNULL(sat_ht_employee_northwind.[DV_Load_Datetime_Start], '1900-01-01 00:00:00.0000000') AS S_HT_Employee_Northwind_DV_Load_Datetime
					FROM
						[Data_Vault].[raw].[H_Employee] AS hub_employee
							LEFT JOIN [Data_Vault].[biz].[v_S_HC_Employee_Northwind] AS sat_hc_employee_northwind
								ON hub_employee.[HK_H_Employee] = sat_hc_employee_northwind.[HK_H_Employee]
							   AND @DV_Load_Datetime BETWEEN sat_hc_employee_northwind.[DV_Load_Datetime_Start] AND sat_hc_employee_northwind.[DV_Load_Datetime_End]
							LEFT JOIN [Data_Vault].[biz].[v_S_HT_Employee_Northwind] AS sat_ht_employee_northwind
								ON hub_employee.[HK_H_Employee] = sat_ht_employee_northwind.[HK_H_Employee]
							   AND @DV_Load_Datetime BETWEEN sat_ht_employee_northwind.[DV_Load_Datetime_Start] AND sat_ht_employee_northwind.[DV_Load_Datetime_End]
				)

				-- Insert snapshot
				INSERT INTO [Data_Vault].[biz].[PIT_Employee] (
					  [HK_H_Employee]
					, [DV_Snapshot_Datetime]
					, [S_HC_Employee_Northwind_HK_H_Employee]
					, [S_HC_Employee_Northwind_DV_Load_Datetime]
					, [S_HT_Employee_Northwind_HK_H_Employee]
					, [S_HT_Employee_Northwind_DV_Load_Datetime]

				)
				SELECT
					  [HK_H_Employee]
					, [DV_Snapshot_Datetime]
					, [S_HC_Employee_Northwind_HK_H_Employee]
					, [S_HC_Employee_Northwind_DV_Load_Datetime]
					, [S_HT_Employee_Northwind_HK_H_Employee]
					, [S_HT_Employee_Northwind_DV_Load_Datetime]
				FROM
					CTE_Point_In_Time;

			END


			/* Delete snapshots outside the managed PIT window */

			BEGIN

				DELETE
					pit
				FROM
					[Data_Vault].[biz].[PIT_Employee] AS pit
						LEFT JOIN [Data_Vault].[biz].[v_R_PIT_Window] AS ref_pit_window
							ON CAST(pit.[DV_Snapshot_Datetime] AS date) = ref_pit_window.[Date]
				WHERE
					ref_pit_window.[Date_Key] IS NULL;

			END
			
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
/****** Object:  StoredProcedure [biz].[usp_Load_PIT_Order]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [biz].[usp_Load_PIT_Order] 
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			DECLARE @DV_Load_Datetime datetime2(7) = SYSDATETIME();

			/* Insert new PIT snapshot */

			BEGIN

				-- Generate input for PIT table
				WITH CTE_Point_In_Time AS (
					SELECT 
						  hub_Order.[HK_H_Order]
						, @DV_Load_Datetime AS DV_Snapshot_Datetime
						, ISNULL(sat_hc_order_northwind.[HK_H_Order], REPLICATE('0', 32)) AS S_HC_Order_Northwind_HK_H_Order
						, ISNULL(sat_hc_order_northwind.[DV_Load_Datetime_Start], '1900-01-01 00:00:00.0000000') AS S_HC_Order_Northwind_DV_Load_Datetime
						, ISNULL(sat_ht_order_northwind.[HK_H_Order], REPLICATE('0', 32)) AS S_HT_Order_Northwind_HK_H_Order
						, ISNULL(sat_ht_order_northwind.[DV_Load_Datetime_Start], '1900-01-01 00:00:00.0000000') AS S_HT_Order_Northwind_DV_Load_Datetime

					FROM
						[Data_Vault].[raw].[H_Order] AS hub_order
							LEFT JOIN [Data_Vault].[biz].[v_S_HC_Order_Northwind] AS sat_hc_order_northwind
								ON hub_order.[HK_H_Order] = sat_hc_order_northwind.[HK_H_Order]
							   AND @DV_Load_Datetime BETWEEN sat_hc_order_northwind.[DV_Load_Datetime_Start] AND sat_hc_order_northwind.[DV_Load_Datetime_End]
							LEFT JOIN [Data_Vault].[biz].[v_S_HT_Order_Northwind] AS sat_ht_order_northwind
								ON hub_order.[HK_H_Order] = sat_ht_order_northwind.[HK_H_Order]
							   AND @DV_Load_Datetime BETWEEN sat_ht_order_northwind.[DV_Load_Datetime_Start] AND sat_ht_order_northwind.[DV_Load_Datetime_End]
				)

				-- Insert snapshot
				INSERT INTO [Data_Vault].[biz].[PIT_Order] (
					  [HK_H_Order]
					, [DV_Snapshot_Datetime]
					, [S_HC_Order_Northwind_HK_H_Order]
					, [S_HC_Order_Northwind_DV_Load_Datetime]
					, [S_HT_Order_Northwind_HK_H_Order]
					, [S_HT_Order_Northwind_DV_Load_Datetime]
				)
				SELECT
					  [HK_H_Order]
					, [DV_Snapshot_Datetime]
					, [S_HC_Order_Northwind_HK_H_Order]
					, [S_HC_Order_Northwind_DV_Load_Datetime]
					, [S_HT_Order_Northwind_HK_H_Order]
					, [S_HT_Order_Northwind_DV_Load_Datetime]
				FROM
					CTE_Point_In_Time;

			END


			/* Delete snapshots outside the managed PIT window */

			BEGIN

				DELETE
					pit
				FROM
					[Data_Vault].[biz].[PIT_Order] AS pit
						LEFT JOIN [Data_Vault].[biz].[v_R_PIT_Window] AS ref_pit_window
							ON CAST(pit.[DV_Snapshot_Datetime] AS date) = ref_pit_window.[Date]
				WHERE
					ref_pit_window.[Date_Key] IS NULL;

			END

		END TRY
		BEGIN CATCH

			-- If error caught and uncomitted transactions then roll back transaction
			IF @@TRANCOUNT > 0  
				ROLLBACK TRANSACTION; 

			-- Insert error details to the error log table
			INSERT INTO 
				[Meta_Metrics_Error_Mart].[error].[Error_Log]
			VALUES (	
				  SYSDATETIME()
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
/****** Object:  StoredProcedure [biz].[usp_Load_PIT_Order_Detail]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [biz].[usp_Load_PIT_Order_Detail] 
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			DECLARE @DV_Load_Datetime datetime2(7) = SYSDATETIME();

			/* Insert new PIT snapshot */

			BEGIN

				-- Generate input for PIT table
				WITH CTE_Point_In_Time AS (
					SELECT 
						  hub_Order_Detail.[HK_H_Order_Detail]
						, @DV_Load_Datetime AS DV_Snapshot_Datetime
						, ISNULL(sat_hc_order_detail_northwind.[HK_H_Order_Detail], REPLICATE('0', 32)) AS S_HC_Order_Detail_Northwind_HK_H_Order_Detail
						, ISNULL(sat_hc_order_detail_northwind.[DV_Load_Datetime_Start], '1900-01-01 00:00:00.0000000') AS S_HC_Order_Detail_Northwind_DV_Load_Datetime
						, ISNULL(sat_ht_order_detail_northwind.[HK_H_Order_Detail], REPLICATE('0', 32)) AS S_HT_Order_Detail_Northwind_HK_H_Order_Detail
						, ISNULL(sat_ht_order_detail_northwind.[DV_Load_Datetime_Start], '1900-01-01 00:00:00.0000000') AS S_HT_Order_Detail_Northwind_DV_Load_Datetime
					FROM
						[Data_Vault].[raw].[H_Order_Detail] AS hub_order_detail
							LEFT JOIN [Data_Vault].[biz].[v_S_HC_Order_Detail_Northwind] AS sat_hc_order_detail_northwind
								ON hub_order_detail.[HK_H_Order_Detail] = sat_hc_order_detail_northwind.[HK_H_Order_Detail]
							   AND @DV_Load_Datetime BETWEEN sat_hc_order_detail_northwind.[DV_Load_Datetime_Start] AND sat_hc_order_detail_northwind.[DV_Load_Datetime_End]
							LEFT JOIN [Data_Vault].[biz].[v_S_HT_Order_Detail_Northwind] AS sat_ht_order_detail_northwind
								ON hub_order_detail.[HK_H_Order_Detail] = sat_ht_order_detail_northwind.[HK_H_Order_Detail]
							   AND @DV_Load_Datetime BETWEEN sat_ht_order_detail_northwind.[DV_Load_Datetime_Start] AND sat_ht_order_detail_northwind.[DV_Load_Datetime_End]
				)

				-- Insert snapshot
				INSERT INTO [Data_Vault].[biz].[PIT_Order_Detail] (
					  [HK_H_Order_Detail]
					, [DV_Snapshot_Datetime]
					, [S_HC_Order_Detail_Northwind_HK_H_Order_Detail]
					, [S_HC_Order_Detail_Northwind_DV_Load_Datetime]
					, [S_HT_Order_Detail_Northwind_HK_H_Order_Detail]
					, [S_HT_Order_Detail_Northwind_DV_Load_Datetime]
				)
				SELECT
					  [HK_H_Order_Detail]
					, [DV_Snapshot_Datetime]
					, [S_HC_Order_Detail_Northwind_HK_H_Order_Detail]
					, [S_HC_Order_Detail_Northwind_DV_Load_Datetime]
					, [S_HT_Order_Detail_Northwind_HK_H_Order_Detail]
					, [S_HT_Order_Detail_Northwind_DV_Load_Datetime]
				FROM
					CTE_Point_In_Time;

			END


			/* Delete snapshots outside the managed PIT window */

			BEGIN

				DELETE
					pit
				FROM
					[Data_Vault].[biz].[PIT_Order_Detail] AS pit
						LEFT JOIN [Data_Vault].[biz].[v_R_PIT_Window] AS ref_pit_window
							ON CAST(pit.[DV_Snapshot_Datetime] AS date) = ref_pit_window.[Date]
				WHERE
					ref_pit_window.[Date_Key] IS NULL;

			END

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
/****** Object:  StoredProcedure [biz].[usp_Load_PIT_Product]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [biz].[usp_Load_PIT_Product] 
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			DECLARE @DV_Load_Datetime datetime2(7) = SYSDATETIME();

			/* Insert new PIT snapshot */

			BEGIN

				-- Generate input for PIT table
				WITH CTE_Point_In_Time AS (
					SELECT 
						  hub_product.[HK_H_Product]
						, @DV_Load_Datetime AS DV_Snapshot_Datetime
						, ISNULL(sat_hc_product_northwind.[HK_H_Product], REPLICATE('0', 32)) AS S_HC_Product_Northwind_HK_H_Product
						, ISNULL(sat_hc_product_northwind.[DV_Load_Datetime_Start], '1900-01-01 00:00:00.0000000') AS S_HC_Product_Northwind_DV_Load_Datetime
						, ISNULL(sat_ht_product_northwind.[HK_H_Product], REPLICATE('0', 32)) AS S_HT_Product_Northwind_HK_H_Product
						, ISNULL(sat_ht_product_northwind.[DV_Load_Datetime_Start], '1900-01-01 00:00:00.0000000') AS S_HT_Product_Northwind_DV_Load_Datetime
					FROM
						[Data_Vault].[raw].[H_Product] AS hub_product
							LEFT JOIN [Data_Vault].[biz].[v_S_HC_Product_Northwind] AS sat_hc_product_northwind
								ON hub_product.[HK_H_Product] = sat_hc_product_northwind.[HK_H_Product]
							   AND @DV_Load_Datetime BETWEEN sat_hc_product_northwind.[DV_Load_Datetime_Start] AND sat_hc_product_northwind.[DV_Load_Datetime_End]
							LEFT JOIN [Data_Vault].[biz].[v_S_HT_Product_Northwind] AS sat_ht_product_northwind
								ON hub_product.[HK_H_Product] = sat_ht_product_northwind.[HK_H_Product]
							   AND @DV_Load_Datetime BETWEEN sat_ht_product_northwind.[DV_Load_Datetime_Start] AND sat_ht_product_northwind.[DV_Load_Datetime_End]
				)	

				-- Insert snapshot
				INSERT INTO [Data_Vault].[biz].[PIT_Product] (
					  [HK_H_Product]
					, [DV_Snapshot_Datetime]
					, [S_HC_Product_Northwind_HK_H_Product]
					, [S_HC_Product_Northwind_DV_Load_Datetime]
					, [S_HT_Product_Northwind_HK_H_Product]
					, [S_HT_Product_Northwind_DV_Load_Datetime]
				)
				SELECT
					  [HK_H_Product]
					, [DV_Snapshot_Datetime]
					, [S_HC_Product_Northwind_HK_H_Product]
					, [S_HC_Product_Northwind_DV_Load_Datetime]
					, [S_HT_Product_Northwind_HK_H_Product]
					, [S_HT_Product_Northwind_DV_Load_Datetime]
				FROM
					CTE_Point_In_Time;

			END


			/* Delete snapshots outside the managed PIT window */

			BEGIN

				DELETE
					pit
				FROM
					[Data_Vault].[biz].[PIT_Product] AS pit
						LEFT JOIN [Data_Vault].[biz].[v_R_PIT_Window] AS ref_pit_window
							ON CAST(pit.[DV_Snapshot_Datetime] AS date) = ref_pit_window.[Date]
				WHERE
					ref_pit_window.[Date_Key] IS NULL;

			END

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
/****** Object:  StoredProcedure [biz].[usp_Load_PIT_Product_Category]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [biz].[usp_Load_PIT_Product_Category] 
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			DECLARE @DV_Load_Datetime datetime2(7) = SYSDATETIME();

			/* Insert new PIT snapshot */

			BEGIN

				-- Generate input for PIT table
				WITH CTE_Point_In_Time AS (
					SELECT 
						  hub_product_category.[HK_H_Product_Category]
						, @DV_Load_Datetime AS DV_Snapshot_Datetime
						, ISNULL(sat_hc_product_category_northwind.[HK_H_Product_Category], REPLICATE('0', 32)) AS S_HC_Product_Category_Northwind_HK_H_Product_Category
						, ISNULL(sat_hc_product_category_northwind.[DV_Load_Datetime_Start], '1900-01-01 00:00:00.0000000') AS S_HC_Product_Category_Northwind_DV_Load_Datetime
						, ISNULL(sat_ht_product_category_northwind.[HK_H_Product_Category], REPLICATE('0', 32)) AS S_HT_Product_Category_Northwind_HK_H_Product_Category
						, ISNULL(sat_ht_product_category_northwind.[DV_Load_Datetime_Start], '1900-01-01 00:00:00.0000000') AS S_HT_Product_Category_Northwind_DV_Load_Datetime
					FROM
						[Data_Vault].[raw].[H_Product_Category] AS hub_product_category
							LEFT JOIN [Data_Vault].[biz].[v_S_HC_Product_Category_Northwind] AS sat_hc_product_category_northwind
								ON hub_product_category.[HK_H_Product_Category] = sat_hc_product_category_northwind.[HK_H_Product_Category]
							   AND @DV_Load_Datetime BETWEEN sat_hc_product_category_northwind.[DV_Load_Datetime_Start] AND sat_hc_product_category_northwind.[DV_Load_Datetime_End]
							LEFT JOIN [Data_Vault].[biz].[v_S_HT_Product_Category_Northwind] AS sat_ht_product_category_northwind
								ON hub_product_category.[HK_H_Product_Category] = sat_ht_product_category_northwind.[HK_H_Product_Category]
							   AND @DV_Load_Datetime BETWEEN sat_ht_product_category_northwind.[DV_Load_Datetime_Start] AND sat_ht_product_category_northwind.[DV_Load_Datetime_End]
				)

				-- Insert snapshot
				INSERT INTO [Data_Vault].[biz].[PIT_Product_Category] (
					  [HK_H_Product_Category]
					, [DV_Snapshot_Datetime]
					, [S_HC_Product_Category_Northwind_HK_H_Product_Category]
					, [S_HC_Product_Category_Northwind_DV_Load_Datetime]
					, [S_HT_Product_Category_Northwind_HK_H_Product_Category]
					, [S_HT_Product_Category_Northwind_DV_Load_Datetime]
				)
				SELECT
					  [HK_H_Product_Category]
					, [DV_Snapshot_Datetime]
					, [S_HC_Product_Category_Northwind_HK_H_Product_Category]
					, [S_HC_Product_Category_Northwind_DV_Load_Datetime]
					, [S_HT_Product_Category_Northwind_HK_H_Product_Category]
					, [S_HT_Product_Category_Northwind_DV_Load_Datetime]

				FROM
					CTE_Point_In_Time;

			END


			/* Delete snapshots outside the managed PIT window */

			BEGIN

				DELETE
					pit
				FROM
					[Data_Vault].[biz].[PIT_Product_Category] AS pit
						LEFT JOIN [Data_Vault].[biz].[v_R_PIT_Window] AS ref_pit_window
							ON CAST(pit.[DV_Snapshot_Datetime] AS date) = ref_pit_window.[Date]
				WHERE
					ref_pit_window.[Date_Key] IS NULL;

			END

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
/****** Object:  StoredProcedure [biz].[usp_Load_PIT_Region]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [biz].[usp_Load_PIT_Region] 
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			DECLARE @DV_Load_Datetime datetime2(7) = SYSDATETIME();

			/* Insert new PIT snapshot */

			BEGIN
				
				-- Generate input for PIT table
				WITH CTE_Point_In_Time AS (
					SELECT 
						  hub_region.[HK_H_Region]
						, @DV_Load_Datetime AS DV_Snapshot_Datetime
						, ISNULL(sat_hc_region_northwind.[HK_H_Region], REPLICATE('0', 32)) AS S_HC_Region_Northwind_HK_H_Region
						, ISNULL(sat_hc_region_northwind.[DV_Load_Datetime_Start], '1900-01-01 00:00:00.0000000') AS S_HC_Region_Northwind_DV_Load_Datetime
						, ISNULL(sat_ht_region_northwind.[HK_H_Region], REPLICATE('0', 32)) AS S_HT_Region_Northwind_HK_H_Region
						, ISNULL(sat_ht_region_northwind.[DV_Load_Datetime_Start], '1900-01-01 00:00:00.0000000') AS S_HT_Region_Northwind_DV_Load_Datetime
					FROM
						[Data_Vault].[raw].[H_Region] AS hub_region
							LEFT JOIN [Data_Vault].[biz].[v_S_HC_Region_Northwind] AS sat_hc_region_northwind
								ON hub_region.[HK_H_Region] = sat_hc_region_northwind.[HK_H_Region]
							   AND @DV_Load_Datetime BETWEEN sat_hc_region_northwind.[DV_Load_Datetime_Start] AND sat_hc_region_northwind.[DV_Load_Datetime_End]
							LEFT JOIN [Data_Vault].[biz].[v_S_HT_Region_Northwind] AS sat_ht_region_northwind
								ON hub_region.[HK_H_Region] = sat_ht_region_northwind.[HK_H_Region]
							   AND @DV_Load_Datetime BETWEEN sat_ht_region_northwind.[DV_Load_Datetime_Start] AND sat_ht_region_northwind.[DV_Load_Datetime_End]
				)

				-- Insert snapshot
				INSERT INTO [Data_Vault].[biz].[PIT_Region] (
					  [HK_H_Region]
					, [DV_Snapshot_Datetime]
					, [S_HC_Region_Northwind_HK_H_Region]
					, [S_HC_Region_Northwind_DV_Load_Datetime]
					, [S_HT_Region_Northwind_HK_H_Region]
					, [S_HT_Region_Northwind_DV_Load_Datetime]
				)
				SELECT
					  [HK_H_Region]
					, [DV_Snapshot_Datetime]
					, [S_HC_Region_Northwind_HK_H_Region]
					, [S_HC_Region_Northwind_DV_Load_Datetime]
					, [S_HT_Region_Northwind_HK_H_Region]
					, [S_HT_Region_Northwind_DV_Load_Datetime]
				FROM
					CTE_Point_In_Time;

			END


			/* Delete snapshots outside the managed PIT window */

			BEGIN

				DELETE
					pit
				FROM
					[Data_Vault].[biz].[PIT_Region] AS pit
						LEFT JOIN [Data_Vault].[biz].[v_R_PIT_Window] AS ref_pit_window
							ON CAST(pit.[DV_Snapshot_Datetime] AS date) = ref_pit_window.[Date]
				WHERE
					ref_pit_window.[Date_Key] IS NULL;

			END
			
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
/****** Object:  StoredProcedure [biz].[usp_Load_PIT_Shipper]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [biz].[usp_Load_PIT_Shipper]
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			DECLARE @DV_Load_Datetime datetime2(7) = SYSDATETIME();

			/* Insert new PIT snapshot */

			BEGIN
				
				-- Generate input for PIT table
				WITH CTE_Point_In_Time AS (
					SELECT 
						  hub_Shipper.[HK_H_Shipper]
						, @DV_Load_Datetime AS DV_Snapshot_Datetime
						, ISNULL(sat_hc_shipper_northwind.[HK_H_Shipper], REPLICATE('0', 32)) AS S_HC_Shipper_Northwind_HK_H_Shipper
						, ISNULL(sat_hc_shipper_northwind.[DV_Load_Datetime_Start], '1900-01-01 00:00:00.0000000') AS S_HC_Shipper_Northwind_DV_Load_Datetime
						, ISNULL(sat_ht_shipper_northwind.[HK_H_Shipper], REPLICATE('0', 32)) AS S_HT_Shipper_Northwind_HK_H_Shipper
						, ISNULL(sat_ht_shipper_northwind.[DV_Load_Datetime_Start], '1900-01-01 00:00:00.0000000') AS S_HT_Shipper_Northwind_DV_Load_Datetime
					FROM
						[Data_Vault].[raw].[H_Shipper] AS hub_shipper
							LEFT JOIN [Data_Vault].[biz].[v_S_HC_Shipper_Northwind] AS sat_hc_shipper_northwind
								ON hub_shipper.[HK_H_Shipper] = sat_hc_shipper_northwind.[HK_H_Shipper]
							   AND @DV_Load_Datetime BETWEEN sat_hc_shipper_northwind.[DV_Load_Datetime_Start] AND sat_hc_shipper_northwind.[DV_Load_Datetime_End]
							LEFT JOIN [Data_Vault].[biz].[v_S_HT_Shipper_Northwind] AS sat_ht_shipper_northwind
								ON hub_shipper.[HK_H_Shipper] = sat_ht_shipper_northwind.[HK_H_Shipper]
							   AND @DV_Load_Datetime BETWEEN sat_ht_shipper_northwind.[DV_Load_Datetime_Start] AND sat_ht_shipper_northwind.[DV_Load_Datetime_End]
				)

				-- Insert snapshot
				INSERT INTO [Data_Vault].[biz].[PIT_Shipper] (
					  [HK_H_Shipper]
					, [DV_Snapshot_Datetime]
					, [S_HC_Shipper_Northwind_HK_H_Shipper]
					, [S_HC_Shipper_Northwind_DV_Load_Datetime]
					, [S_HT_Shipper_Northwind_HK_H_Shipper]
					, [S_HT_Shipper_Northwind_DV_Load_Datetime]
				)
				SELECT
					  [HK_H_Shipper]
					, [DV_Snapshot_Datetime]
					, [S_HC_Shipper_Northwind_HK_H_Shipper]
					, [S_HC_Shipper_Northwind_DV_Load_Datetime]
					, [S_HT_Shipper_Northwind_HK_H_Shipper]
					, [S_HT_Shipper_Northwind_DV_Load_Datetime]
				FROM
					CTE_Point_In_Time;

			END


			/* Delete snapshots outside the managed PIT window */

			BEGIN

				DELETE
					pit
				FROM
					[Data_Vault].[biz].[PIT_Shipper] AS pit
						LEFT JOIN [Data_Vault].[biz].[v_R_PIT_Window] AS ref_pit_window
							ON CAST(pit.[DV_Snapshot_Datetime] AS date) = ref_pit_window.[Date]
				WHERE
					ref_pit_window.[Date_Key] IS NULL;

			END
			
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
/****** Object:  StoredProcedure [biz].[usp_Load_PIT_Supplier]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [biz].[usp_Load_PIT_Supplier] 
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			DECLARE @DV_Load_Datetime datetime2(7) = SYSDATETIME();

			/* Insert new PIT snapshot */

			BEGIN
				
				-- Generate input for PIT table
				WITH CTE_Point_In_Time AS (
					SELECT 
						  hub_supplier.[HK_H_Supplier]
						, @DV_Load_Datetime AS DV_Snapshot_Datetime
						, ISNULL(sat_hc_supplier_northwind.[HK_H_Supplier], REPLICATE('0', 32)) AS S_HC_Supplier_Northwind_HK_H_Supplier
						, ISNULL(sat_hc_supplier_northwind.[DV_Load_Datetime_Start], '1900-01-01 00:00:00.0000000') AS S_HC_Supplier_Northwind_DV_Load_Datetime
						, ISNULL(sat_ht_supplier_northwind.[HK_H_Supplier], REPLICATE('0', 32)) AS S_HT_Supplier_Northwind_HK_H_Supplier
						, ISNULL(sat_ht_supplier_northwind.[DV_Load_Datetime_Start], '1900-01-01 00:00:00.0000000') AS S_HT_Supplier_Northwind_DV_Load_Datetime

					FROM
						[Data_Vault].[raw].[H_Supplier] AS hub_supplier
							LEFT JOIN [Data_Vault].[biz].[v_S_HC_Supplier_Northwind] AS sat_hc_supplier_northwind
								ON hub_supplier.[HK_H_Supplier] = sat_hc_supplier_northwind.[HK_H_Supplier]
							   AND @DV_Load_Datetime BETWEEN sat_hc_supplier_northwind.[DV_Load_Datetime_Start] AND sat_hc_supplier_northwind.[DV_Load_Datetime_End]
							LEFT JOIN [Data_Vault].[biz].[v_S_HT_Supplier_Northwind] AS sat_ht_supplier_northwind
								ON hub_supplier.[HK_H_Supplier] = sat_ht_supplier_northwind.[HK_H_Supplier]
							   AND @DV_Load_Datetime BETWEEN sat_ht_supplier_northwind.[DV_Load_Datetime_Start] AND sat_ht_supplier_northwind.[DV_Load_Datetime_End]
				)

				-- Insert snapshot
				INSERT INTO [Data_Vault].[biz].[PIT_Supplier] (
					  [HK_H_Supplier]
					, [DV_Snapshot_Datetime]
					, [S_HC_Supplier_Northwind_HK_H_Supplier]
					, [S_HC_Supplier_Northwind_DV_Load_Datetime]
					, [S_HT_Supplier_Northwind_HK_H_Supplier]
					, [S_HT_Supplier_Northwind_DV_Load_Datetime]

				)
				SELECT
					  [HK_H_Supplier]
					, [DV_Snapshot_Datetime]
					, [S_HC_Supplier_Northwind_HK_H_Supplier]
					, [S_HC_Supplier_Northwind_DV_Load_Datetime]
					, [S_HT_Supplier_Northwind_HK_H_Supplier]
					, [S_HT_Supplier_Northwind_DV_Load_Datetime]
				FROM
					CTE_Point_In_Time;

			END


			/* Delete snapshots outside the managed PIT window */

			BEGIN

				DELETE
					pit
				FROM
					[Data_Vault].[biz].[PIT_Supplier] AS pit
						LEFT JOIN [Data_Vault].[biz].[v_R_PIT_Window] AS ref_pit_window
							ON CAST(pit.[DV_Snapshot_Datetime] AS date) = ref_pit_window.[Date]
				WHERE
					ref_pit_window.[Date_Key] IS NULL;

			END
			
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
/****** Object:  StoredProcedure [biz].[usp_Load_PIT_Territory]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [biz].[usp_Load_PIT_Territory] 
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			DECLARE @DV_Load_Datetime datetime2(7) = SYSDATETIME();

			/* Insert new PIT snapshot */

			BEGIN
				
				-- Generate input for PIT table
				WITH CTE_Point_In_Time AS (
					SELECT 
						  hub_territory.[HK_H_Territory]
						, @DV_Load_Datetime AS DV_Snapshot_Datetime
						, ISNULL(sat_hc_territory_northwind.[HK_H_Territory], REPLICATE('0', 32)) AS S_HC_Territory_Northwind_HK_H_Territory
						, ISNULL(sat_hc_territory_northwind.[DV_Load_Datetime_Start], '1900-01-01 00:00:00.0000000') AS S_HC_Territory_Northwind_DV_Load_Datetime
						, ISNULL(sat_ht_territory_northwind.[HK_H_Territory], REPLICATE('0', 32)) AS S_HT_Territory_Northwind_HK_H_Territory
						, ISNULL(sat_ht_territory_northwind.[DV_Load_Datetime_Start], '1900-01-01 00:00:00.0000000') AS S_HT_Territory_Northwind_DV_Load_Datetime
					FROM
						[Data_Vault].[raw].[H_Territory] AS hub_territory
							LEFT JOIN [Data_Vault].[biz].[v_S_HC_Territory_Northwind] AS sat_hc_territory_northwind
								ON hub_territory.[HK_H_Territory] = sat_hc_territory_northwind.[HK_H_Territory]
							   AND @DV_Load_Datetime BETWEEN sat_hc_territory_northwind.[DV_Load_Datetime_Start] AND sat_hc_territory_northwind.[DV_Load_Datetime_End]
							LEFT JOIN [Data_Vault].[biz].[v_S_HT_Territory_Northwind] AS sat_ht_territory_northwind
								ON hub_territory.[HK_H_Territory] = sat_ht_territory_northwind.[HK_H_Territory]
							   AND @DV_Load_Datetime BETWEEN sat_ht_territory_northwind.[DV_Load_Datetime_Start] AND sat_ht_territory_northwind.[DV_Load_Datetime_End]
				)

				-- Insert snapshot
				INSERT INTO [Data_Vault].[biz].[PIT_Territory] (
					  [HK_H_Territory]
					, [DV_Snapshot_Datetime]
					, [S_HC_Territory_Northwind_HK_H_Territory]
					, [S_HC_Territory_Northwind_DV_Load_Datetime]
					, [S_HT_Territory_Northwind_HK_H_Territory]
					, [S_HT_Territory_Northwind_DV_Load_Datetime]
				)
				SELECT
					  [HK_H_Territory]
					, [DV_Snapshot_Datetime]
					, [S_HC_Territory_Northwind_HK_H_Territory]
					, [S_HC_Territory_Northwind_DV_Load_Datetime]
					, [S_HT_Territory_Northwind_HK_H_Territory]
					, [S_HT_Territory_Northwind_DV_Load_Datetime]
				FROM
					CTE_Point_In_Time;

			END


			/* Delete snapshots outside the managed PIT window */

			BEGIN

				DELETE
					pit
				FROM
					[Data_Vault].[biz].[PIT_Territory] AS pit
						LEFT JOIN [Data_Vault].[biz].[v_R_PIT_Window] AS ref_pit_window
							ON CAST(pit.[DV_Snapshot_Datetime] AS date) = ref_pit_window.[Date]
				WHERE
					ref_pit_window.[Date_Key] IS NULL;

			END
			
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
/****** Object:  StoredProcedure [raw].[usp_Load_H_Customer]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_H_Customer] 
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY
	
			/* Insert ghost record */

			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[H_Customer]
				WHERE
					[HK_H_Customer] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[H_Customer] (
					  [HK_H_Customer]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [DV_Business_Key]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_H_Customer
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, '0'							-- DV_Business_Key
				)
			END


			/* Insert Hub records*/

			INSERT INTO [Data_Vault].[raw].[H_Customer] (
				  [HK_H_Customer]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [DV_Business_Key]
			)
			SELECT DISTINCT
				  [HK_H_Customer]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [DV_Business_Key]
			FROM
				[Stage_Area].[northwind].[Customers] AS stage
			WHERE
				NOT EXISTS (
					SELECT
						1
					FROM
						[Data_Vault].[raw].[H_Customer] AS hub
					WHERE
						stage.[DV_Business_Key] = hub.[DV_Business_Key]
				)

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
/****** Object:  StoredProcedure [raw].[usp_Load_H_Customer_Type]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_H_Customer_Type] 
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY
	
			/* Insert ghost record */

			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[H_Customer_Type]
				WHERE
					[HK_H_Customer_Type] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[H_Customer_Type] (
					  [HK_H_Customer_Type]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [DV_Business_Key]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_H_Customer_Type
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, '0'							-- DV_Business_Key
				)
			END


			/* Insert Hub records*/

			INSERT INTO [Data_Vault].[raw].[H_Customer_Type] (
				  [HK_H_Customer_Type]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [DV_Business_Key]
			)
			SELECT DISTINCT
				  [HK_H_Customer_Type]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [DV_Business_Key]
			FROM
				[Stage_Area].[northwind].[CustomerDemographics] AS stage
			WHERE
				NOT EXISTS (
					SELECT
						1
					FROM
						[Data_Vault].[raw].[H_Customer_Type] AS hub
					WHERE
						stage.[DV_Business_Key] = hub.[DV_Business_Key]
				)

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
/****** Object:  StoredProcedure [raw].[usp_Load_H_Employee]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_H_Employee] 
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY
	
			/* Insert ghost record */
			
			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[H_Employee] 
				WHERE
					[HK_H_Employee] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[H_Employee] (
					  [HK_H_Employee]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [DV_Business_Key]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_H_Employee
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, '0'							-- DV_Business_Key
				)
			END


			/* Insert Hub records*/

			INSERT INTO [Data_Vault].[raw].[H_Employee] (
				  [HK_H_Employee]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [DV_Business_Key]
			)
			SELECT DISTINCT
				  stage.[HK_H_Employee]
				, stage.[DV_Load_Datetime]
				, stage.[DV_Record_Source]
				, stage.[DV_Business_Key]
			FROM
				[Stage_Area].[northwind].[Employees] AS stage
			WHERE
				NOT EXISTS (
					SELECT
						1
					FROM
						[Data_Vault].[raw].[H_Employee] AS hub
					WHERE
						stage.[DV_Business_Key] = hub.[DV_Business_Key]
				)

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
/****** Object:  StoredProcedure [raw].[usp_Load_H_Order]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_H_Order] 
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY
	
			/* Insert ghost record */
			
			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[H_Order] 
				WHERE
					[HK_H_Order] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[H_Order] (
					  [HK_H_Order]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [DV_Business_Key]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_H_Order
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, '0'							-- DV_Business_Key
				)
			END


			/* Insert Hub records*/

			INSERT INTO [Data_Vault].[raw].[H_Order] (
				  [HK_H_Order]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [DV_Business_Key]
			)
			SELECT DISTINCT
				  [HK_H_Order]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [DV_Business_Key]
			FROM
				[Stage_Area].[northwind].[Orders] AS stage
			WHERE
				NOT EXISTS (
					SELECT
						1
					FROM
						[Data_Vault].[raw].[H_Order] AS hub
					WHERE
						stage.[DV_Business_Key] = hub.[DV_Business_Key]
				)

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
/****** Object:  StoredProcedure [raw].[usp_Load_H_Order_Detail]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_H_Order_Detail] 
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY
	
			/* Insert ghost record */
			
			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[H_Order_Detail] 
				WHERE
					[HK_H_Order_Detail] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[H_Order_Detail] (
					  [HK_H_Order_Detail]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [DV_Business_Key]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_H_Order_Detail
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, '0|0'							-- DV_Business_Key
				)
			END


			/* Insert Hub records*/

			INSERT INTO [Data_Vault].[raw].[H_Order_Detail] (
				  [HK_H_Order_Detail]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [DV_Business_Key]
			)
			SELECT DISTINCT
				  [HK_H_Order_Detail]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [DV_Business_Key]
			FROM
				[Stage_Area].[northwind].[Order Details] AS stage
			WHERE
				NOT EXISTS (
					SELECT
						1
					FROM
						[Data_Vault].[raw].[H_Order_Detail] AS hub
					WHERE
						stage.[DV_Business_Key] = hub.[DV_Business_Key]
				)

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
/****** Object:  StoredProcedure [raw].[usp_Load_H_Product]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_H_Product] 
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY
	
			/* Insert ghost record */
			
			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[H_Product] 
				WHERE
					[HK_H_Product] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[H_Product] (
					  [HK_H_Product]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [DV_Business_Key]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_H_Product
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, 0								-- DV_Business_Key
				)
			END


			/* Insert Hub records*/

			INSERT INTO [Data_Vault].[raw].[H_Product] (
				  [HK_H_Product]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [DV_Business_Key]
			)
			SELECT DISTINCT
				  [HK_H_Product]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [DV_Business_Key]
			FROM
				[Stage_Area].[northwind].[Products] AS stage
			WHERE
				NOT EXISTS (
					SELECT
						1
					FROM
						[Data_Vault].[raw].[H_Product] AS hub
					WHERE
						stage.[DV_Business_Key] = hub.[DV_Business_Key]
				)

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
/****** Object:  StoredProcedure [raw].[usp_Load_H_Product_Category]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_H_Product_Category] 
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY
	
			/* Insert ghost record */

			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[H_Product_Category]
				WHERE
					[HK_H_Product_Category] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[H_Product_Category] (
					  [HK_H_Product_Category]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [DV_Business_Key]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_H_Product_Category
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, 0								-- DV_Business_Key
				)
			END


			/* Insert Hub records*/

			INSERT INTO [Data_Vault].[raw].[H_Product_Category] (
				  [HK_H_Product_Category]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [DV_Business_Key]
			)
			SELECT DISTINCT
				  [HK_H_Product_Category]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [DV_Business_Key]
			FROM
				[Stage_Area].[northwind].[Categories] AS stage
			WHERE
				NOT EXISTS (
					SELECT
						1
					FROM
						[Data_Vault].[raw].[H_Product_Category] AS hub
					WHERE
						stage.[DV_Business_Key] = hub.[DV_Business_Key]
				)

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
/****** Object:  StoredProcedure [raw].[usp_Load_H_Region]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_H_Region] 
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY
	
			/* Insert ghost record */

			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[H_Region]
				WHERE
					[HK_H_Region] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[H_Region] (
					  [HK_H_Region]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [DV_Business_Key]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_H_Region
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, '0'							-- DV_Business_Key
				)
			END


			/* Insert Hub records*/

			INSERT INTO [Data_Vault].[raw].[H_Region] (
				  [HK_H_Region]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [DV_Business_Key]
			)
			SELECT DISTINCT
				  stage.[HK_H_Region]
				, stage.[DV_Load_Datetime]
				, stage.[DV_Record_Source]
				, stage.[DV_Business_Key]
			FROM
				[Stage_Area].[northwind].[Region] AS stage
			WHERE
				NOT EXISTS (
					SELECT
						1
					FROM
						[Data_Vault].[raw].[H_Region] AS hub
					WHERE
						stage.[DV_Business_Key] = hub.[DV_Business_Key]
				)

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
/****** Object:  StoredProcedure [raw].[usp_Load_H_Shipper]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_H_Shipper] 
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY
	
			/* Insert ghost record */

			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[H_Shipper]
				WHERE
					[HK_H_Shipper] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[H_Shipper] (
					  [HK_H_Shipper]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [DV_Business_Key]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_H_Shipper
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, '0'							-- DV_Business_Key
				)
			END


			/* Insert Hub records*/

			INSERT INTO [Data_Vault].[raw].[H_Shipper] (
				  [HK_H_Shipper]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [DV_Business_Key]
			)
			SELECT DISTINCT
				  [HK_H_Shipper]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [DV_Business_Key]
			FROM
				[Stage_Area].[northwind].[Shippers] AS stage
			WHERE
				NOT EXISTS (
					SELECT
						1
					FROM
						[Data_Vault].[raw].[H_Shipper] AS hub
					WHERE
						stage.[DV_Business_Key] = hub.[DV_Business_Key]
				)

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
/****** Object:  StoredProcedure [raw].[usp_Load_H_Supplier]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_H_Supplier] 
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY
	
			/* Insert ghost record */

			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[H_Supplier]
				WHERE
					[HK_H_Supplier] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[H_Supplier] (
					  [HK_H_Supplier]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [DV_Business_Key]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_H_Supplier
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, '0'							-- DV_Business_Key
				)
			END


			/* Insert Hub records*/

			INSERT INTO [Data_Vault].[raw].[H_Supplier] (
				  [HK_H_Supplier]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [DV_Business_Key]
			)
			SELECT DISTINCT
				  [HK_H_Supplier]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [DV_Business_Key]
			FROM
				[Stage_Area].[northwind].[Suppliers] AS stage
			WHERE
				NOT EXISTS (
					SELECT
						1
					FROM
						[Data_Vault].[raw].[H_Supplier] AS hub
					WHERE
						stage.[DV_Business_Key] = hub.[DV_Business_Key]
				)

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
/****** Object:  StoredProcedure [raw].[usp_Load_H_Territory]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_H_Territory] 
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY
	
			/* Insert ghost record */

			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[H_Territory]
				WHERE
					[HK_H_Territory] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[H_Territory] (
					  [HK_H_Territory]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [DV_Business_Key]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_H_Territory
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, '0'							-- DV_Business_Key
				)
			END


			/* Insert Hub records*/

			INSERT INTO [Data_Vault].[raw].[H_Territory] (
				  [HK_H_Territory]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [DV_Business_Key]
			)
			SELECT DISTINCT
				  stage.[HK_H_Territory]
				, stage.[DV_Load_Datetime]
				, stage.[DV_Record_Source]
				, stage.[DV_Business_Key]
			FROM
				[Stage_Area].[northwind].[Territories] AS stage
			WHERE
				NOT EXISTS (
					SELECT
						1
					FROM
						[Data_Vault].[raw].[H_Territory] AS hub
					WHERE
						stage.[DV_Business_Key] = hub.[DV_Business_Key]
				)

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
/****** Object:  StoredProcedure [raw].[usp_Load_L_Customer_Type]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_L_Customer_Type] 
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY
	
			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[L_Customer_Type]
				WHERE
					[HK_L_Customer_Type] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[L_Customer_Type] (
					  [HK_L_Customer_Type]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [HK_H_Customer]
					, [HK_H_Customer_Type]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_L_Customer_Type
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, REPLICATE('0', 32)			-- HK_H_Customer
					, REPLICATE('0', 32)			-- HK_H_Customer_Type
				)
			END


			/* Insert Link records*/

			INSERT INTO [Data_Vault].[raw].[L_Customer_Type] (
				  [HK_L_Customer_Type]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [HK_H_Customer]
				, [HK_H_Customer_Type]
			)
			SELECT DISTINCT
				  stage.[HK_L_Customer_Type]
				, stage.[DV_Load_Datetime]
				, stage.[DV_Record_Source]
				, stage.[HK_H_Customer]
				, stage.[HK_H_Customer_Type]
			FROM
				[Stage_Area].[northwind].[CustomerCustomerDemo] AS stage
			WHERE
				NOT EXISTS (
					SELECT
						1
					FROM
						[Data_Vault].[raw].[L_Customer_Type] AS link
					WHERE
						stage.[HK_H_Customer] = link.[HK_H_Customer]
						AND stage.[HK_H_Customer_Type] = link.[HK_H_Customer_Type]
				)

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
/****** Object:  StoredProcedure [raw].[usp_Load_L_Employee_Reporting_Line]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_L_Employee_Reporting_Line] 
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			/* Insert ghost record */

			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[L_Employee_Reporting_Line]
				WHERE
					[HK_L_Employee_Reporting_Line] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[L_Employee_Reporting_Line] (
					  [HK_L_Employee_Reporting_Line]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [HK_H_Employee]
					, [HK_H_Employee_Manager]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_L_Employee_Reporting_Line
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, REPLICATE('0', 32)			-- HK_H_Employee
					, REPLICATE('0', 32)			-- HK_H_Employee_Manager
				)
			END

	
			/* Insert Link records*/

			INSERT INTO [Data_Vault].[raw].[L_Employee_Reporting_Line] (
					  [HK_L_Employee_Reporting_Line]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [HK_H_Employee]
					, [HK_H_Employee_Manager]
			)
			SELECT DISTINCT
					  stage.[HK_L_Employee_Reporting_Line]
					, stage.[DV_Load_Datetime]
					, stage.[DV_Record_Source]
					, stage.[HK_H_Employee]
					, stage.[HK_H_Employee_Manager]
			FROM
				[Stage_Area].[northwind].[Employees] AS stage
			WHERE
				NOT EXISTS (
					SELECT
						1
					FROM
						[Data_Vault].[raw].[L_Employee_Reporting_Line] AS link
					WHERE
						stage.[HK_H_Employee] = link.[HK_H_Employee]
						AND stage.[HK_H_Employee_Manager] = link.[HK_H_Employee_Manager]
				)

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
/****** Object:  StoredProcedure [raw].[usp_Load_L_Employee_Territory]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_L_Employee_Territory] 
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			/* Insert ghost record */

			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[L_Employee_Territory]
				WHERE
					[HK_L_Employee_Territory] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[L_Employee_Territory] (
					  [HK_L_Employee_Territory]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [HK_H_Employee]
					, [HK_H_Territory]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_L_Employee_Territory
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, REPLICATE('0', 32)			-- HK_H_Employee
					, REPLICATE('0', 32)			-- HK_H_Territory
				)
			END

	
			/* Insert Link records*/

			INSERT INTO [Data_Vault].[raw].[L_Employee_Territory] (
				  [HK_L_Employee_Territory]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [HK_H_Employee]
				, [HK_H_Territory]
			)
			SELECT DISTINCT
				  stage.[HK_L_Employee_Territory]
				, stage.[DV_Load_Datetime]
				, stage.[DV_Record_Source]
				, stage.[HK_H_Employee]
				, stage.[HK_H_Territory]
			FROM
				[Stage_Area].[northwind].[EmployeeTerritories] AS stage
			WHERE
				NOT EXISTS (
					SELECT
						1
					FROM
						[Data_Vault].[raw].[L_Employee_Territory] AS link
					WHERE
						stage.[HK_H_Employee] = link.[HK_H_Employee]
						AND stage.[HK_H_Territory] = link.[HK_H_Territory]
				)

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
/****** Object:  StoredProcedure [raw].[usp_Load_L_Order_Detail]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_L_Order_Detail] 
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			/* Insert ghost record */

			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[L_Order_Detail]
				WHERE
					[HK_L_Order_Detail] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[L_Order_Detail] (
					  [HK_L_Order_Detail]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [HK_H_Order]
					, [HK_H_Order_Detail]
					, [HK_H_Product]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_L_Order_Detail
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, REPLICATE('0', 32)			-- HK_H_Order
					, REPLICATE('0', 32)			-- HK_H_Order_Detail
					, REPLICATE('0', 32)			-- HK_H_Product
				)
			END

	
			/* Insert Link records*/

			INSERT INTO [Data_Vault].[raw].[L_Order_Detail] (
					  [HK_L_Order_Detail]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [HK_H_Order]
					, [HK_H_Order_Detail]
					, [HK_H_Product]
			)
			SELECT DISTINCT
					  [HK_L_Order_Detail]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [HK_H_Order]
					, [HK_H_Order_Detail]
					, [HK_H_Product]
			FROM
				[Stage_Area].[northwind].[Order Details] AS stage
			WHERE
				NOT EXISTS (
					SELECT
						1
					FROM
						[Data_Vault].[raw].[L_Order_Detail] AS link
					WHERE
						stage.[HK_H_Order] = link.[HK_H_Order]
						AND stage.[HK_H_Order_Detail] = link.[HK_H_Order_Detail]
						AND stage.[HK_H_Product] = link.[HK_H_Product]
				)

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
/****** Object:  StoredProcedure [raw].[usp_Load_L_Order_Header]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_L_Order_Header] 
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			/* Insert ghost record */

			IF NOT EXISTS (
				SELECT 
					1
				FROM 
					[Data_Vault].[raw].[L_Order_Header]
				WHERE
					[HK_L_Order_Header] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[L_Order_Header] (
					  [HK_L_Order_Header]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [HK_H_Customer]
					, [HK_H_Employee]
					, [HK_H_Order]
					, [HK_H_Shipper]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_L_Order_Header
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, REPLICATE('0', 32)			-- HK_H_Customer
					, REPLICATE('0', 32)			-- HK_H_Employee
					, REPLICATE('0', 32)			-- HK_H_Order
					, REPLICATE('0', 32)			-- HK_H_Shipper
				)
			END

	
			/* Insert Link records*/

			INSERT INTO [Data_Vault].[raw].[L_Order_Header] (
					  [HK_L_Order_Header]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [HK_H_Customer]
					, [HK_H_Employee]
					, [HK_H_Order]
					, [HK_H_Shipper]
			)
			SELECT DISTINCT
					  stage.[HK_L_Order_Header]
					, stage.[DV_Load_Datetime]
					, stage.[DV_Record_Source]
					, stage.[HK_H_Customer]
					, stage.[HK_H_Employee]
					, stage.[HK_H_Order]
					, stage.[HK_H_Shipper]
			FROM
				[Stage_Area].[northwind].[Orders] AS stage
			WHERE
				NOT EXISTS (
					SELECT
						1
					FROM
						[Data_Vault].[raw].[L_Order_Header] AS link
					WHERE
						stage.[HK_H_Customer] = link.[HK_H_Customer]
						AND stage.[HK_H_Employee] = link.[HK_H_Employee]
						AND stage.[HK_H_Order] = link.[HK_H_Order]
						AND stage.[HK_H_Shipper] = link.[HK_H_Shipper]
				)

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
/****** Object:  StoredProcedure [raw].[usp_Load_L_Product_Category]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_L_Product_Category] 
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			/* Insert ghost record */

			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[L_Product_Category]
				WHERE
					[HK_L_Product_Category] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[L_Product_Category] (
					  [HK_L_Product_Category]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [HK_H_Product]
					, [HK_H_Product_Category]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_L_Product_Category
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, REPLICATE('0', 32)			-- HK_H_Product
					, REPLICATE('0', 32)			-- HK_H_Product_Category
				)
			END

	
			/* Insert Link records*/

			INSERT INTO [Data_Vault].[raw].[L_Product_Category] (
				  [HK_L_Product_Category]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [HK_H_Product]
				, [HK_H_Product_Category]
			)
			SELECT DISTINCT
				  [HK_L_Product_Category]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [HK_H_Product]
				, [HK_H_Product_Category]
			FROM
				[Stage_Area].[northwind].[Products] AS stage
			WHERE
				NOT EXISTS (
					SELECT
						1
					FROM
						[Data_Vault].[raw].[L_Product_Category] AS link
					WHERE
						stage.[HK_H_Product] = link.[HK_H_Product]
						AND stage.[HK_H_Product_Category] = link.[HK_H_Product_Category]
				)

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
/****** Object:  StoredProcedure [raw].[usp_Load_L_Product_Supplier]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_L_Product_Supplier] 
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY
	
			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[L_Product_Supplier]
				WHERE
					[HK_L_Product_Supplier] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[L_Product_Supplier] (
					  [HK_L_Product_Supplier]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [HK_H_Product]
					, [HK_H_Supplier]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_L_Product_Supplier
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, REPLICATE('0', 32)			-- HK_H_Product
					, REPLICATE('0', 32)			-- HK_H_Supplier
				)
			END


			/* Insert Link records*/

			INSERT INTO [Data_Vault].[raw].[L_Product_Supplier] (
				  [HK_L_Product_Supplier]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [HK_H_Product]
				, [HK_H_Supplier]
			)
			SELECT DISTINCT
				  [HK_L_Product_Supplier]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [HK_H_Product]
				, [HK_H_Supplier]
			FROM
				[Stage_Area].[northwind].[Products] AS stage
			WHERE
				NOT EXISTS (
					SELECT
						1
					FROM
						[Data_Vault].[raw].[L_Product_Supplier] AS link
					WHERE
						stage.[HK_H_Product] = link.[HK_H_Product]
						AND stage.[HK_H_Supplier] = link.[HK_H_Supplier]
				)

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
/****** Object:  StoredProcedure [raw].[usp_Load_L_Territory_Region]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_L_Territory_Region] 
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			/* Insert ghost record */

			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[L_Territory_Region]
				WHERE
					[HK_L_Territory_Region] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[L_Territory_Region] (
					  [HK_L_Territory_Region]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [HK_H_Territory]
					, [HK_H_Region]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_L_Territory_Region
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, REPLICATE('0', 32)			-- HK_H_Territory
					, REPLICATE('0', 32)			-- HK_H_Region
				)
			END

	
			/* Insert Link records*/

			INSERT INTO [Data_Vault].[raw].[L_Territory_Region] (
				  [HK_L_Territory_Region]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [HK_H_Territory]
				, [HK_H_Region]
			)
			SELECT DISTINCT
				  stage.[HK_L_Territory_Region]
				, stage.[DV_Load_Datetime]
				, stage.[DV_Record_Source]
				, stage.[HK_H_Territory]
				, stage.[HK_H_Region]
			FROM
				[Stage_Area].[northwind].[Territories] AS stage
			WHERE
				NOT EXISTS (
					SELECT
						1
					FROM
						[Data_Vault].[raw].[L_Territory_Region] AS link
					WHERE
						stage.[HK_H_Territory] = link.[HK_H_Territory]
						AND stage.[HK_H_Region] = link.[HK_H_Region]
				)

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
/****** Object:  StoredProcedure [raw].[usp_Load_R_Date]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_R_Date]
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			/* Generate source data */

			DECLARE @StartDate  date = '1900-01-01';
			DECLARE @EndDate date = '2099-12-31';

			WITH CTE_Sequence(Sequence_Number) AS (
				SELECT
					0 AS Sequence_Number
		
				UNION ALL 
  
				SELECT 
					[Sequence_Number] + 1
				FROM
					CTE_Sequence
				WHERE 
					[Sequence_Number] < DATEDIFF(DAY, @StartDate, @EndDate)
			)

			, CTE_Date(Sequence_Number, Date) AS (
				SELECT
					  [Sequence_Number] + 1 AS Sequence_Number
					, DATEADD(DAY, [Sequence_Number], @StartDate) AS Date
				FROM
					CTE_Sequence
			)

			, CTE_Source AS (
				SELECT
					  CAST(CONVERT(varchar(8), d.[Date], 112) AS int) AS Date_Key
					, CONVERT(date, d.[Date]) AS 'Date'
					, CONVERT(datetime2(7), d.[Date]) 'Datetime_Start'
					, DATEPART(DAY, d.[Date]) AS Day_Of_Month_Number
					, DATEPART(MONTH, d.[Date]) AS Month_Number
					, DATENAME(MONTH, d.[Date]) AS Month_Name
					, DATEPART(YEAR, d.[Date]) AS Year_Number
					, DATEPART(WEEKDAY, d.[Date]) AS Day_Of_Week_Number
					, DATENAME(WEEKDAY, d.[Date]) AS Day_Of_Week_Name
					, DATEPART(QUARTER, d.[Date]) AS Quarter_Number
					, CASE DATEPART(Quarter, d.[Date])
						WHEN 1 THEN 'Quarter One'
						WHEN 2 THEN 'Quarter Two'
						WHEN 3 THEN 'Quarter Three'
						WHEN 4 THEN 'Quarter Four'
					  END AS Quarter_Name
					, d.[Sequence_Number] AS Sort_Order
				FROM 
					CTE_date AS d
			)


			/* Populate reference table */

			INSERT INTO [Data_Vault].[raw].[R_Date] (
				  [DV_Load_Datetime]
				, [DV_Record_Source]
				, [Date_Key]
				, [Date]
				, [Datetime_Start]
				, [Datetime_End]
				, [Day_Of_Month_Number]
				, [Month_Number]
				, [Month_Name]
				, [Year_Number]
				, [Day_Of_Week_Number]
				, [Day_Of_Week_Name]
				, [Quarter_Number]
				, [Quarter_Name]
				, [Sort_Order]
			)
			SELECT 
				  SYSDATETIME() AS DV_Load_Datetime
				, 'SYSTEM' AS DV_Record_Source
				, source.[Date_Key]
				, source.[Date]
				, source.[Datetime_Start]
				, LEAD(DATEADD(NS, -100, source.[Datetime_Start]), 1, CONCAT(CAST(source.[Date] AS varchar(10)), ' 23:59:59.9999999')) OVER(ORDER BY source.[Datetime_Start] ASC) AS Datetime_End
				, source.[Day_Of_Month_Number]
				, source.[Month_Number]
				, source.[Month_Name]
				, source.[Year_Number]
				, source.[Day_Of_Week_Number]
				, source.[Day_Of_Week_Name]
				, source.[Quarter_Number]
				, source.[Quarter_Name]
				, source.[Sort_Order]
			FROM 
				CTE_Source AS source
			WHERE NOT EXISTS (
				SELECT
					1
				FROM
					[Data_Vault].[raw].[R_Date] AS ref_date
				WHERE
					source.[Date_Key] = ref_date.[Date_Key]
			)
			OPTION
				(MAXRECURSION 0);

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
/****** Object:  StoredProcedure [raw].[usp_Load_S_HC_Customer_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_S_HC_Customer_Northwind]
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			/* Insert ghost record */

			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[S_HC_Customer_Northwind]
				WHERE
					[HK_H_Customer] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[S_HC_Customer_Northwind] (
					  [HK_H_Customer]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [HD_S_HC_Customer_Northwind]
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
				)
				VALUES (
					  REPLICATE('0', 32)  -- HK_H_Customer
					, '1900-01-01 00:00:00.000'  -- DV_Load_Datetime
					, 'SYSTEM'  -- DV_Record_Source
					, REPLICATE('0', 32)  -- HD_S_HC_Customer_Northwind
					, 'Unknown'  -- CompanyName
					, 'Unknown'  -- ContactName
					, 'Unknown'  -- ContactTitle
					, 'Unknown'  -- Address
					, 'Unknown'  -- City
					, '?'  -- Region
					, '?'  -- PostalCode
					, 'Unknown'  -- Country
					, 'Unknown'  -- Phone
					, 'Unknown'  -- Fax
				);
			END

			
			/* Insert Satellite records */

			INSERT INTO [Data_Vault].[raw].[S_HC_Customer_Northwind] (
				  [HK_H_Customer]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [HD_S_HC_Customer_Northwind]
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
			)
			SELECT DISTINCT
				  stage.[HK_H_Customer]
				, stage.[DV_Load_Datetime]
				, stage.[DV_Record_Source]
				, stage.[HD_S_HC_Customer_Northwind]
				, stage.[CompanyName]
				, stage.[ContactName]
				, stage.[ContactTitle]
				, stage.[Address]
				, stage.[City]
				, stage.[Region]
				, stage.[PostalCode]
				, stage.[Country]
				, stage.[Phone]
				, stage.[Fax]
			FROM
				[Stage_Area].[northwind].[Customers] AS stage
					-- Join to the most recently loaded satellite for the Hub hash key
					OUTER APPLY (
						SELECT TOP 1
							  satellite.[HK_H_Customer]
							, satellite.[DV_Load_Datetime]
							, satellite.[HD_S_HC_Customer_Northwind]
						FROM
							[Data_Vault].[raw].[S_HC_Customer_Northwind] AS satellite
						WHERE
							stage.[HK_H_Customer] = satellite.[HK_H_Customer]
						ORDER BY
							satellite.[DV_Load_Datetime] DESC
					) AS top_satellite
			WHERE
				-- Insert new record if either no satellite records exist for the Hub hash key or the change hash differs
				top_satellite.[HK_H_Customer] IS NULL
				OR (
					stage.[DV_Load_Datetime] > top_satellite.[DV_Load_Datetime]
					AND stage.[HD_S_HC_Customer_Northwind] <> top_satellite.[HD_S_HC_Customer_Northwind]
				)
				
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
/****** Object:  StoredProcedure [raw].[usp_Load_S_HC_Customer_Type_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_S_HC_Customer_Type_Northwind]
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			/* Insert ghost record */

			
			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[S_HC_Customer_Type_Northwind]
				WHERE
					[HK_H_Customer_Type] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[S_HC_Customer_Type_Northwind] (
					  [HK_H_Customer_Type]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [HD_S_HC_Customer_Type_Northwind]
					, [CustomerDesc]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_H_Customer_Type
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, REPLICATE('0', 32)			-- HD_S_HC_Customer_Type_Northwind
					, 'Unknown'						-- CustomerDesc
				);
			END

			
			/* Insert Satellite records */

			INSERT INTO [Data_Vault].[raw].[S_HC_Customer_Type_Northwind] (
				  [HK_H_Customer_Type]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [HD_S_HC_Customer_Type_Northwind]
				, [CustomerDesc]
			)
			SELECT DISTINCT
				  stage.[HK_H_Customer_Type]
				, stage.[DV_Load_Datetime]
				, stage.[DV_Record_Source]
				, stage.[HD_S_HC_Customer_Type_Northwind]
				, stage.[CustomerDesc]
			FROM
				[Stage_Area].[northwind].[CustomerDemographics] AS stage
					-- Join to the most recently loaded satellite for the Hub hash key
					OUTER APPLY (
						SELECT TOP 1
							  satellite.[HK_H_Customer_Type]
							, satellite.[DV_Load_Datetime]
							, satellite.[HD_S_HC_Customer_Type_Northwind]
						FROM
							[Data_Vault].[raw].[S_HC_Customer_Type_Northwind] AS satellite
						WHERE
							stage.[HK_H_Customer_Type] = satellite.[HK_H_Customer_Type]
						ORDER BY
							satellite.[DV_Load_Datetime] DESC
					) AS top_satellite
			WHERE
				-- Insert new record if either no satellite records exist for the Hub hash key or the change hash differs
				top_satellite.[HK_H_Customer_Type] IS NULL
				OR (
					stage.[DV_Load_Datetime] > top_satellite.[DV_Load_Datetime]
					AND stage.[HD_S_HC_Customer_Type_Northwind] <> top_satellite.[HD_S_HC_Customer_Type_Northwind]
				)
				
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
/****** Object:  StoredProcedure [raw].[usp_Load_S_HC_Employee_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_S_HC_Employee_Northwind]
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			/* Insert ghost record */

			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[S_HC_Employee_Northwind]
				WHERE
					[HK_H_Employee] = REPLICATE('0', 32)
			)

			BEGIN
				INSERT INTO [Data_Vault].[raw].[S_HC_Employee_Northwind] (
					  [HK_H_Employee]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [HD_S_HC_Employee_Northwind]
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
					, [PhotoPath]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_H_Employee
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, REPLICATE('0', 32)			-- HD_S_HC_Employee_Northwind
					, 'Unknown'						-- LastName
					, 'Unknown'						-- FirstName
					, 'Unknown'						-- Title
					, 'Unknown'						-- TitleOfCourtesy
					, '1900-01-01'					-- BirthDate
					, '1900-01-01'					-- HireDate
					, 'Unknown'						-- Address
					, 'Unknown'						-- City
					, '?'							-- Region
					, '?'							-- PostalCode
					, '?'							-- Country
					, 'Unknown'						-- HomePhone
					, '?'							-- Extension
					,  CONVERT(varbinary(max), 0)	-- Photo
					, 'Unknown'						-- Notes
					, 'Unknown'						-- PhotoPath
				);
			END

			
			/* Insert Satellite records */

			INSERT INTO [Data_Vault].[raw].[S_HC_Employee_Northwind] (
				  [HK_H_Employee]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [HD_S_HC_Employee_Northwind]
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
				, [PhotoPath]
			)
			SELECT DISTINCT
				  stage.[HK_H_Employee]
				, stage.[DV_Load_Datetime]
				, stage.[DV_Record_Source]
				, stage.[HD_S_HC_Employee_Northwind]
				, stage.[LastName]
				, stage.[FirstName]
				, stage.[Title]
				, stage.[TitleOfCourtesy]
				, stage.[BirthDate]
				, stage.[HireDate]
				, stage.[Address]
				, stage.[City]
				, stage.[Region]
				, stage.[PostalCode]
				, stage.[Country]
				, stage.[HomePhone]
				, stage.[Extension]
				, stage.[Photo]
				, stage.[Notes]
				, stage.[PhotoPath]
			FROM
				[Stage_Area].[northwind].[Employees] AS stage
					-- Join to the most recently loaded satellite for the Hub hash key
					OUTER APPLY (
						SELECT TOP 1
							  satellite.[HK_H_Employee]
							, satellite.[DV_Load_Datetime]
							, satellite.[HD_S_HC_Employee_Northwind]
						FROM
							[Data_Vault].[raw].[S_HC_Employee_Northwind] AS satellite
						WHERE
							stage.[HK_H_Employee] = satellite.[HK_H_Employee]
						ORDER BY
							satellite.[DV_Load_Datetime] DESC
					) AS top_satellite
			WHERE
				-- Insert new record if either no satellite records exist for the Hub hash key or the change hash differs
				top_satellite.[HK_H_Employee] IS NULL
				OR (
					stage.[DV_Load_Datetime] > top_satellite.[DV_Load_Datetime]
					AND stage.[HD_S_HC_Employee_Northwind] <> top_satellite.[HD_S_HC_Employee_Northwind]
				)
				
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
/****** Object:  StoredProcedure [raw].[usp_Load_S_HC_Order_Detail_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_S_HC_Order_Detail_Northwind]
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			/* Insert ghost record */

			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[S_HC_Order_Detail_Northwind]
				WHERE
					[HK_H_Order_Detail] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[S_HC_Order_Detail_Northwind] (
					  [HK_H_Order_Detail]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [HD_S_HC_Order_Detail_Northwind]
					, [UnitPrice]
					, [Quantity]
					, [Discount]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_H_Order_Detail
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, REPLICATE('0', 32)			-- HD_S_HC_Order_Detail_Northwind
					, 0.00							-- UnitPrice
					, 0								-- Quantity
					, 0.00							-- Discount
				);
			END

			
			/* Insert Satellite records */

			INSERT INTO [Data_Vault].[raw].[S_HC_Order_Detail_Northwind] (
				  [HK_H_Order_Detail]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [HD_S_HC_Order_Detail_Northwind]
				, [UnitPrice]
				, [Quantity]
				, [Discount]
			)
			SELECT DISTINCT
				  stage.[HK_H_Order_Detail]
				, stage.[DV_Load_Datetime]
				, stage.[DV_Record_Source]
				, stage.[HD_S_HC_Order_Detail_Northwind]
				, stage.[UnitPrice]
				, stage.[Quantity]
				, stage.[Discount]
			FROM
				[Stage_Area].[northwind].[Order Details] AS stage
					-- Join to the most recently loaded satellite for the Hub hash key
					OUTER APPLY (
						SELECT TOP 1
							  satellite.[HK_H_Order_Detail]
							, satellite.[DV_Load_Datetime]
							, satellite.[HD_S_HC_Order_Detail_Northwind]
						FROM
							[Data_Vault].[raw].[S_HC_Order_Detail_Northwind] AS satellite
						WHERE
							stage.[HK_H_Order_Detail] = satellite.[HK_H_Order_Detail]
						ORDER BY
							satellite.[DV_Load_Datetime] DESC
					) AS top_satellite
			WHERE
				-- Insert new record if either no satellite records exist for the Hub hash key or the change hash differs
				top_satellite.[HK_H_Order_Detail] IS NULL
				OR (
					stage.[DV_Load_Datetime] > top_satellite.[DV_Load_Datetime]
					AND stage.[HD_S_HC_Order_Detail_Northwind] <> top_satellite.[HD_S_HC_Order_Detail_Northwind]
				)
				
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
/****** Object:  StoredProcedure [raw].[usp_Load_S_HC_Order_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_S_HC_Order_Northwind]
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			/* Insert ghost record */

			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[S_HC_Order_Northwind]
				WHERE
					[HK_H_Order] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[S_HC_Order_Northwind] (
					  [HK_H_Order]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [HD_S_HC_Order_Northwind]
					, [OrderDate]
					, [RequiredDate]
					, [ShippedDate]
					, [Freight]
					, [ShipName]
					, [ShipAddress]
					, [ShipCity]
					, [ShipRegion]
					, [ShipPostalCode]
					, [ShipCountry]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_H_Order
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, REPLICATE('0', 32)			-- HD_S_HC_Order_Northwind
					, '1900-01-01 00:00:00.000'		-- OrderDate
					, '1900-01-01 00:00:00.000'		-- RequiredDate
					, '1900-01-01 00:00:00.000'		-- ShippedDate
					, 0.00							-- Freight
					, 'Unknown'						-- ShipName
					, 'Unknown'						-- ShipAddress
					, 'Unknown'						-- ShipCity
					, 'Unknown'						-- ShipRegion
					, 'Unknown'						-- ShipPostalCode
					, 'Unknown'						-- ShipCountry
				);
			END

			
			/* Insert Satellite records */

			INSERT INTO [Data_Vault].[raw].[S_HC_Order_Northwind] (
					  [HK_H_Order]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [HD_S_HC_Order_Northwind]
					, [OrderDate]
					, [RequiredDate]
					, [ShippedDate]
					, [Freight]
					, [ShipName]
					, [ShipAddress]
					, [ShipCity]
					, [ShipRegion]
					, [ShipPostalCode]
					, [ShipCountry]
			)
			SELECT DISTINCT
					  stage.[HK_H_Order]
					, stage.[DV_Load_Datetime]
					, stage.[DV_Record_Source]
					, stage.[HD_S_HC_Order_Northwind]
					, stage.[OrderDate]
					, stage.[RequiredDate]
					, stage.[ShippedDate]
					, stage.[Freight]
					, stage.[ShipName]
					, stage.[ShipAddress]
					, stage.[ShipCity]
					, stage.[ShipRegion]
					, stage.[ShipPostalCode]
					, stage.[ShipCountry]
			FROM
				[Stage_Area].[northwind].[Orders] AS stage
					-- Join to the most recently loaded satellite for the Hub hash key
					OUTER APPLY (
						SELECT TOP 1
							  satellite.[HK_H_Order]
							, satellite.[DV_Load_Datetime]
							, satellite.[HD_S_HC_Order_Northwind]
						FROM
							[Data_Vault].[raw].[S_HC_Order_Northwind] AS satellite
						WHERE
							stage.[HK_H_Order] = satellite.[HK_H_Order]
						ORDER BY
							satellite.[DV_Load_Datetime] DESC
					) AS top_satellite
			WHERE
				-- Insert new record if either no satellite records exist for the Hub hash key or the change hash differs
				top_satellite.[HK_H_Order] IS NULL
				OR (
					stage.[DV_Load_Datetime] > top_satellite.[DV_Load_Datetime]
					AND stage.[HD_S_HC_Order_Northwind] <> top_satellite.[HD_S_HC_Order_Northwind]
				)
		
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
/****** Object:  StoredProcedure [raw].[usp_Load_S_HC_Product_Category_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_S_HC_Product_Category_Northwind]
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			/* Insert ghost record */

			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[S_HC_Product_Category_Northwind]
				WHERE
					[HK_H_Product_Category] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[S_HC_Product_Category_Northwind] (
					  [HK_H_Product_Category]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [HD_S_HC_Product_Category_Northwind]
					, [CategoryName]
					, [Description]
					, [Picture]
				)
				VALUES (
					  REPLICATE('0', 32)						-- HK_H_Product_Category
					, '1900-01-01 00:00:00.000'					-- DV_Load_Datetime
					, 'SYSTEM'									-- DV_Record_Source
					, REPLICATE('0', 32)						-- HD_S_HC_Product_Category_Northwind
					, 'Unknown'									-- CategoryName 
					, 'Unknown'									-- Description
					, 0x00000000								-- Picture
				);
			END

			
			/* Insert Satellite records */

			INSERT INTO [Data_Vault].[raw].[S_HC_Product_Category_Northwind] (
				  [HK_H_Product_Category]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [HD_S_HC_Product_Category_Northwind]
				, [CategoryName]
				, [Description]
				, [Picture]
			)
			SELECT DISTINCT
				  stage.[HK_H_Product_Category]
				, stage.[DV_Load_Datetime]
				, stage.[DV_Record_Source]
				, stage.[HD_S_HC_Product_Category_Northwind]
				, stage.[CategoryName]
				, stage.[Description]
				, stage.[Picture]
			FROM
				[Stage_Area].[northwind].[Categories] AS stage
					-- Join to the most recently loaded satellite for the Hub hash key
					OUTER APPLY (
						SELECT TOP 1
							  satellite.[HK_H_Product_Category]
							, satellite.[DV_Load_Datetime]
							, satellite.[HD_S_HC_Product_Category_Northwind]
						FROM
							[Data_Vault].[raw].[S_HC_Product_Category_Northwind] AS satellite
						WHERE
							stage.[HK_H_Product_Category] = satellite.[HK_H_Product_Category]
						ORDER BY
							satellite.[DV_Load_Datetime] DESC
					) AS top_satellite
			WHERE
				-- Insert new record if either no satellite records exist for the Hub hash key or the change hash differs
				top_satellite.[HK_H_Product_Category] IS NULL
				OR (
					stage.[DV_Load_Datetime] > top_satellite.[DV_Load_Datetime]
					AND stage.[HD_S_HC_Product_Category_Northwind] <> top_satellite.[HD_S_HC_Product_Category_Northwind]
				)
				
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
/****** Object:  StoredProcedure [raw].[usp_Load_S_HC_Product_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_S_HC_Product_Northwind]
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			/* Insert ghost record */

			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[S_HC_Product_Northwind]
				WHERE
					[HK_H_Product] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[S_HC_Product_Northwind] (
					  [HK_H_Product]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [HD_S_HC_Product_Northwind]
					, [ProductName]
					, [QuantityPerUnit]
					, [UnitPrice]
					, [UnitsInStock]
					, [UnitsOnOrder]
					, [ReorderLevel]
					, [Discontinued]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_H_Product
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, REPLICATE('0', 32)			-- HD_S_HC_Product_Northwind
					, 'Unknown'						-- ProductName
					, 'Unknown'						-- QuantityPerUnit
					, 0.0							-- UnitPrice
					, 0								-- UnitsInStock
					, 0								-- UnitsOnOrder
					, 0								-- ReorderLevel
					, 0								-- Discontinued
				);
			END

			
			/* Insert Satellite records */

			INSERT INTO [Data_Vault].[raw].[S_HC_Product_Northwind] (
				  [HK_H_Product]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [HD_S_HC_Product_Northwind]
				, [ProductName]
				, [QuantityPerUnit]
				, [UnitPrice]
				, [UnitsInStock]
				, [UnitsOnOrder]
				, [ReorderLevel]
				, [Discontinued]
			)
			SELECT DISTINCT
				  stage.[HK_H_Product]
				, stage.[DV_Load_Datetime]
				, stage.[DV_Record_Source]
				, stage.[HD_S_HC_Product_Northwind]
				, stage.[ProductName]
				, stage.[QuantityPerUnit]
				, stage.[UnitPrice]
				, stage.[UnitsInStock]
				, stage.[UnitsOnOrder]
				, stage.[ReorderLevel]
				, stage.[Discontinued]
			FROM
				[Stage_Area].[northwind].[Products] AS stage
					-- Join to the most recently loaded satellite for the Hub hash key
					OUTER APPLY (
						SELECT TOP 1
							  satellite.[HK_H_Product]
							, satellite.[DV_Load_Datetime]
							, satellite.[HD_S_HC_Product_Northwind]
						FROM
							[Data_Vault].[raw].[S_HC_Product_Northwind] AS satellite
						WHERE
							stage.[HK_H_Product] = satellite.[HK_H_Product]
						ORDER BY
							satellite.[DV_Load_Datetime] DESC
					) AS top_satellite
			WHERE
				-- Insert new record if either no satellite records exist for the Hub hash key or the change hash differs
				top_satellite.[HK_H_Product] IS NULL
				OR (
					stage.[DV_Load_Datetime] > top_satellite.[DV_Load_Datetime]
					AND stage.[HD_S_HC_Product_Northwind] <> top_satellite.[HD_S_HC_Product_Northwind]
				)
				
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
/****** Object:  StoredProcedure [raw].[usp_Load_S_HC_Region_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_S_HC_Region_Northwind]
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			/* Insert ghost record */
			
			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[S_HC_Region_Northwind]
				WHERE
					[HK_H_Region] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[S_HC_Region_Northwind] (
					  [HK_H_Region]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [HD_S_HC_Region_Northwind]
					, [RegionDescription]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_H_Region
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, REPLICATE('0', 32)			-- HD_S_HC_Region_Northwind
					, 'Unknown'						-- RegionDescription
				);
			END

			
			/* Insert Satellite records */

			INSERT INTO [Data_Vault].[raw].[S_HC_Region_Northwind] (
				  [HK_H_Region]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [HD_S_HC_Region_Northwind]
				, [RegionDescription]
			)
			SELECT DISTINCT
				  stage.[HK_H_Region]
				, stage.[DV_Load_Datetime]
				, stage.[DV_Record_Source]
				, stage.[HD_S_HC_Region_Northwind]
				, stage.[RegionDescription]
			FROM
				[Stage_Area].[northwind].[Region] AS stage
					-- Join to the most recently loaded satellite for the Hub hash key
					OUTER APPLY (
						SELECT TOP 1
							  satellite.[HK_H_Region]
							, satellite.[DV_Load_Datetime]
							, satellite.[HD_S_HC_Region_Northwind]
						FROM
							[Data_Vault].[raw].[S_HC_Region_Northwind] AS satellite
						WHERE
							stage.[HK_H_Region] = satellite.[HK_H_Region]
						ORDER BY
							satellite.[DV_Load_Datetime] DESC
					) AS top_satellite
			WHERE
				-- Insert new record if either no satellite records exist for the Hub hash key or the change hash differs
				top_satellite.[HK_H_Region] IS NULL
				OR (
					stage.[DV_Load_Datetime] > top_satellite.[DV_Load_Datetime]
					AND stage.[HD_S_HC_Region_Northwind] <> top_satellite.[HD_S_HC_Region_Northwind]
				)
				
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
/****** Object:  StoredProcedure [raw].[usp_Load_S_HC_Shipper_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_S_HC_Shipper_Northwind]
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			/* Insert ghost record */

			
			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[S_HC_Shipper_Northwind]
				WHERE
					[HK_H_Shipper] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[S_HC_Shipper_Northwind] (
					  [HK_H_Shipper]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [HD_S_HC_Shipper_Northwind]
					, [CompanyName]
					, [Phone]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_H_Shipper
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, REPLICATE('0', 32)			-- HD_S_HC_Shipper_Northwind
					, 'Unknown'						-- CompanyName
					, 'Unknown'						-- Phone
				);
			END

			
			/* Insert Satellite records */

			INSERT INTO [Data_Vault].[raw].[S_HC_Shipper_Northwind] (
				  [HK_H_Shipper]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [HD_S_HC_Shipper_Northwind]
				, [CompanyName]
				, [Phone]
			)
			SELECT DISTINCT
				  stage.[HK_H_Shipper]
				, stage.[DV_Load_Datetime]
				, stage.[DV_Record_Source]
				, stage.[HD_S_HC_Shipper_Northwind]
				, stage.[CompanyName]
				, stage.[Phone]
			FROM
				[Stage_Area].[northwind].[Shippers] AS stage
					-- Join to the most recently loaded satellite for the Hub hash key
					OUTER APPLY (
						SELECT TOP 1
							  satellite.[HK_H_Shipper]
							, satellite.[DV_Load_Datetime]
							, satellite.[HD_S_HC_Shipper_Northwind]
						FROM
							[Data_Vault].[raw].[S_HC_Shipper_Northwind] AS satellite
						WHERE
							stage.[HK_H_Shipper] = satellite.[HK_H_Shipper]
						ORDER BY
							satellite.[DV_Load_Datetime] DESC
					) AS top_satellite
			WHERE
				-- Insert new record if either no satellite records exist for the Hub hash key or the change hash differs
				top_satellite.[HK_H_Shipper] IS NULL
				OR (
					stage.[DV_Load_Datetime] > top_satellite.[DV_Load_Datetime]
					AND stage.[HD_S_HC_Shipper_Northwind] <> top_satellite.[HD_S_HC_Shipper_Northwind]
				)
				
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
/****** Object:  StoredProcedure [raw].[usp_Load_S_HC_Supplier_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_S_HC_Supplier_Northwind]
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			/* Insert ghost record */

			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[S_HC_Supplier_Northwind]
				WHERE
					[HK_H_Supplier] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[S_HC_Supplier_Northwind] (
					  [HK_H_Supplier]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [HD_S_HC_Supplier_Northwind]
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
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_H_Supplier
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, REPLICATE('0', 32)			-- HD_S_HC_Supplier_Northwind
					, 'Unknown'						-- CompanyName
					, 'Unknown'						-- ContactName
					, 'Unknown'							-- ContactTitle
					, 'Unknown'						-- Address
					, 'Unknown'						-- City
					, 'Unknown'						-- Region
					, '?'							-- PostalCode
					, 'Unknown'						-- Country
					, '?'							-- Phone
					, '?'							-- Fax
					, 'Unknown'						-- HomePage
				);
			END

			
			/* Insert Satellite records */

			INSERT INTO [Data_Vault].[raw].[S_HC_Supplier_Northwind] (
				  [HK_H_Supplier]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [HD_S_HC_Supplier_Northwind]
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
			)
			SELECT DISTINCT
				  stage.[HK_H_Supplier]
				, stage.[DV_Load_Datetime]
				, stage.[DV_Record_Source]
				, stage.[HD_S_HC_Supplier_Northwind]
				, stage.[CompanyName]
				, stage.[ContactName]
				, stage.[ContactTitle]
				, stage.[Address]
				, stage.[City]
				, stage.[Region]
				, stage.[PostalCode]
				, stage.[Country]
				, stage.[Phone]
				, stage.[Fax]
				, stage.[HomePage]
			FROM
				[Stage_Area].[northwind].[Suppliers] AS stage
					-- Join to the most recently loaded satellite for the Hub hash key
					OUTER APPLY (
						SELECT TOP 1
							  satellite.[HK_H_Supplier]
							, satellite.[DV_Load_Datetime]
							, satellite.[HD_S_HC_Supplier_Northwind]
						FROM
							[Data_Vault].[raw].[S_HC_Supplier_Northwind] AS satellite
						WHERE
							stage.[HK_H_Supplier] = satellite.[HK_H_Supplier]
						ORDER BY
							satellite.[DV_Load_Datetime] DESC
					) AS top_satellite
			WHERE
				-- Insert new record if either no satellite records exist for the Hub hash key or the change hash differs
				top_satellite.[HK_H_Supplier] IS NULL
				OR (
					stage.[DV_Load_Datetime] > top_satellite.[DV_Load_Datetime]
					AND stage.[HD_S_HC_Supplier_Northwind] <> top_satellite.[HD_S_HC_Supplier_Northwind]
				)
				
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
/****** Object:  StoredProcedure [raw].[usp_Load_S_HC_Territory_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_S_HC_Territory_Northwind]
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			/* Insert ghost record */

			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[S_HC_Territory_Northwind]
				WHERE
					[HK_H_Territory] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[S_HC_Territory_Northwind] (
					  [HK_H_Territory]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [HD_S_HC_Territory_Northwind]
					, [TerritoryDescription]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_H_Territory
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, REPLICATE('0', 32)			-- HD_S_HC_Territory_Northwind
					, 'Unknown'						-- TerritoryDescription
				);
			END

			
			/* Insert Satellite records */

			INSERT INTO [Data_Vault].[raw].[S_HC_Territory_Northwind] (
				  [HK_H_Territory]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [HD_S_HC_Territory_Northwind]
				, [TerritoryDescription]
			)
			SELECT DISTINCT
				  stage.[HK_H_Territory]
				, stage.[DV_Load_Datetime]
				, stage.[DV_Record_Source]
				, stage.[HD_S_HC_Territory_Northwind]
				, stage.[TerritoryDescription]
			FROM
				[Stage_Area].[northwind].[Territories] AS stage
					-- Join to the most recently loaded satellite for the Hub hash key
					OUTER APPLY (
						SELECT TOP 1
							  satellite.[HK_H_Territory]
							, satellite.[DV_Load_Datetime]
							, satellite.[HD_S_HC_Territory_Northwind]
						FROM
							[Data_Vault].[raw].[S_HC_Territory_Northwind] AS satellite
						WHERE
							stage.[HK_H_Territory] = satellite.[HK_H_Territory]
						ORDER BY
							satellite.[DV_Load_Datetime] DESC
					) AS top_satellite
			WHERE
				-- Insert new record if either no satellite records exist for the Hub hash key or the change hash differs
				top_satellite.[HK_H_Territory] IS NULL
				OR (
					stage.[DV_Load_Datetime] > top_satellite.[DV_Load_Datetime]
					AND stage.[HD_S_HC_Territory_Northwind] <> top_satellite.[HD_S_HC_Territory_Northwind]
				)
				
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
/****** Object:  StoredProcedure [raw].[usp_Load_S_HT_Customer_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_S_HT_Customer_Northwind]
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			/* Insert ghost record */

			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[S_HT_Customer_Northwind]
				WHERE
					[HK_H_Customer] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[S_HT_Customer_Northwind] (
					  [HK_H_Customer]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [DV_Deleted_Flag]
					, [HD_S_HT_Customer_Northwind]
					, [CustomerID]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_H_Customer
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, 0								-- DV_Deleted_Flag
					, REPLICATE('0', 32)			-- HD_S_HT_Customer_Northwind
					, '0'							-- CustomerID
				);
			END

			
			/* Insert Satellite records */

			INSERT INTO [Data_Vault].[raw].[S_HT_Customer_Northwind] (
				  [HK_H_Customer]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [DV_Deleted_Flag]
				, [HD_S_HT_Customer_Northwind]
				, [CustomerID]
			)
			SELECT DISTINCT
				  stage.[HK_H_Customer]
				, stage.[DV_Load_Datetime]
				, stage.[DV_Record_Source]
				, stage.[DV_Deleted_Flag]
				, stage.[HD_S_HT_Customer_Northwind]
				, stage.[CustomerID]
			FROM
				[Stage_Area].[northwind].[Customers] AS stage
					-- Join to the most recently loaded satellite for the Hub hash key
					OUTER APPLY (
						SELECT TOP 1
							  satellite.[HK_H_Customer]
							, satellite.[DV_Load_Datetime]
							, satellite.[HD_S_HT_Customer_Northwind]
						FROM
							[Data_Vault].[raw].[S_HT_Customer_Northwind] AS satellite
						WHERE
							stage.[HK_H_Customer] = satellite.[HK_H_Customer]
						ORDER BY
							satellite.[DV_Load_Datetime] DESC
					) AS top_satellite
			WHERE
				-- Insert new record if either no satellite records exist for the Hub hash key or the change hash differs
				top_satellite.[HK_H_Customer] IS NULL
				OR (
					stage.[DV_Load_Datetime] > top_satellite.[DV_Load_Datetime]
					AND stage.[HD_S_HT_Customer_Northwind] <> top_satellite.[HD_S_HT_Customer_Northwind]
				)
		
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
/****** Object:  StoredProcedure [raw].[usp_Load_S_HT_Customer_Type_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_S_HT_Customer_Type_Northwind]
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			/* Insert ghost record */

			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[S_HT_Customer_Type_Northwind]
				WHERE
					[HK_H_Customer_Type] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[S_HT_Customer_Type_Northwind] (
					  [HK_H_Customer_Type]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [DV_Deleted_Flag]
					, [HD_S_HT_Customer_Type_Northwind]
					, [CustomerTypeID]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_H_Customer_Type
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, 0								-- DV_Deleted_Flag
					, REPLICATE('0', 32)			-- HD_S_HT_Customer_Type_Northwind
					, '0'							-- CustomerTypeID
				);
			END

			
			/* Insert Satellite records */

			INSERT INTO [Data_Vault].[raw].[S_HT_Customer_Type_Northwind] (
				  [HK_H_Customer_Type]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [DV_Deleted_Flag]
				, [HD_S_HT_Customer_Type_Northwind]
				, [CustomerTypeID]
			)
			SELECT DISTINCT
				  stage.[HK_H_Customer_Type]
				, stage.[DV_Load_Datetime]
				, stage.[DV_Record_Source]
				, stage.[DV_Deleted_Flag]
				, stage.[HD_S_HT_Customer_Type_Northwind]
				, stage.[CustomerTypeID]
			FROM
				[Stage_Area].[northwind].[CustomerDemographics] AS stage
					-- Join to the most recently loaded satellite for the Hub hash key
					OUTER APPLY (
						SELECT TOP 1
							  satellite.[HK_H_Customer_Type]
							, satellite.[DV_Load_Datetime]
							, satellite.[HD_S_HT_Customer_Type_Northwind]
						FROM
							[Data_Vault].[raw].[S_HT_Customer_Type_Northwind] AS satellite
						WHERE
							stage.[HK_H_Customer_Type] = satellite.[HK_H_Customer_Type]
						ORDER BY
							satellite.[DV_Load_Datetime] DESC
					) AS top_satellite
			WHERE
				-- Insert new record if either no satellite records exist for the Hub hash key or the change hash differs
				top_satellite.[HK_H_Customer_Type] IS NULL
				OR (
					stage.[DV_Load_Datetime] > top_satellite.[DV_Load_Datetime]
					AND stage.[HD_S_HT_Customer_Type_Northwind] <> top_satellite.[HD_S_HT_Customer_Type_Northwind]
				)
		
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
/****** Object:  StoredProcedure [raw].[usp_Load_S_HT_Employee_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_S_HT_Employee_Northwind]
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			/* Insert ghost record */

			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[S_HT_Employee_Northwind]
				WHERE
					[HK_H_Employee] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[S_HT_Employee_Northwind] (
					  [HK_H_Employee]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [DV_Deleted_Flag]
					, [HD_S_HT_Employee_Northwind]
					, [EmployeeID]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_H_Employee
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, 0								-- DV_Deleted_Flag
					, REPLICATE('0', 32)			-- HD_S_HT_Employee_Northwind
					, 0								-- EmployeeID
				);
			END

			
			/* Insert Satellite records */

			INSERT INTO [Data_Vault].[raw].[S_HT_Employee_Northwind] (
				  [HK_H_Employee]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [DV_Deleted_Flag]
				, [HD_S_HT_Employee_Northwind]
				, [EmployeeID]
			)
			SELECT DISTINCT
				  stage.[HK_H_Employee]
				, stage.[DV_Load_Datetime]
				, stage.[DV_Record_Source]
				, stage.[DV_Deleted_Flag]
				, stage.[HD_S_HT_Employee_Northwind]
				, stage.[EmployeeID]
			FROM
				[Stage_Area].[northwind].[Employees] AS stage
					-- Join to the most recently loaded satellite for the Hub hash key
					OUTER APPLY (
						SELECT TOP 1
							  satellite.[HK_H_Employee]
							, satellite.[DV_Load_Datetime]
							, satellite.[HD_S_HT_Employee_Northwind]
						FROM
							[Data_Vault].[raw].[S_HT_Employee_Northwind] AS satellite
						WHERE
							stage.[HK_H_Employee] = satellite.[HK_H_Employee]
						ORDER BY
							satellite.[DV_Load_Datetime] DESC
					) AS top_satellite
			WHERE
				-- Insert new record if either no satellite records exist for the Hub hash key or the change hash differs
				top_satellite.[HK_H_Employee] IS NULL
				OR (
					stage.[DV_Load_Datetime] > top_satellite.[DV_Load_Datetime]
					AND stage.[HD_S_HT_Employee_Northwind] <> top_satellite.[HD_S_HT_Employee_Northwind]
				)
		
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
/****** Object:  StoredProcedure [raw].[usp_Load_S_HT_Order_Detail_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_S_HT_Order_Detail_Northwind]
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			/* Insert ghost record */

			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[S_HT_Order_Detail_Northwind]
				WHERE
					[HK_H_Order_Detail] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[S_HT_Order_Detail_Northwind] (
					  [HK_H_Order_Detail]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [DV_Deleted_Flag]
					, [HD_S_HT_Order_Detail_Northwind]
					, [OrderID]
					, [ProductID]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_H_Order_Detail
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, 0								-- DV_Deleted_Flag
					, REPLICATE('0', 32)			-- HD_S_HT_Order_Detail_Northwind
					, 0								-- OrderID
					, 0								-- ProductID
				);
			END

			
			/* Insert Satellite records */

			INSERT INTO [Data_Vault].[raw].[S_HT_Order_Detail_Northwind] (
				  [HK_H_Order_Detail]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [DV_Deleted_Flag]
				, [HD_S_HT_Order_Detail_Northwind]
				, [OrderID]
				, [ProductID]
			)
			SELECT DISTINCT
				  stage.[HK_H_Order_Detail]
				, stage.[DV_Load_Datetime]
				, stage.[DV_Record_Source]
				, stage.[DV_Deleted_Flag]
				, stage.[HD_S_HT_Order_Detail_Northwind]
				, stage.[OrderID]
				, stage.[ProductID]
			FROM
				[Stage_Area].[northwind].[Order Details] AS stage
					-- Join to the most recently loaded satellite for the Hub hash key
					OUTER APPLY (
						SELECT TOP 1
							  satellite.[HK_H_Order_Detail]
							, satellite.[DV_Load_Datetime]
							, satellite.[HD_S_HT_Order_Detail_Northwind]
						FROM
							[Data_Vault].[raw].[S_HT_Order_Detail_Northwind] AS satellite
						WHERE
							stage.[HK_H_Order_Detail] = satellite.[HK_H_Order_Detail]
						ORDER BY
							satellite.[DV_Load_Datetime] DESC
					) AS top_satellite
			WHERE
				-- Insert new record if either no satellite records exist for the Hub hash key or the change hash differs
				top_satellite.[HK_H_Order_Detail] IS NULL
				OR (
					stage.[DV_Load_Datetime] > top_satellite.[DV_Load_Datetime]
					AND stage.[HD_S_HT_Order_Detail_Northwind] <> top_satellite.[HD_S_HT_Order_Detail_Northwind]
				)
		
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
/****** Object:  StoredProcedure [raw].[usp_Load_S_HT_Order_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_S_HT_Order_Northwind]
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			/* Insert ghost record */

			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[S_HT_Order_Northwind]
				WHERE
					[HK_H_Order] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[S_HT_Order_Northwind] (
					  [HK_H_Order]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [DV_Deleted_Flag]
					, [HD_S_HT_Order_Northwind]
					, [OrderID]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_H_Order
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, 0								-- DV_Deleted_Flag
					, REPLICATE('0', 32)			-- HD_S_HT_Order_Northwind
					, '0'							-- OrderID
				);
			END

			
			/* Insert Satellite records */

			INSERT INTO [Data_Vault].[raw].[S_HT_Order_Northwind] (
				  [HK_H_Order]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [DV_Deleted_Flag]
				, [HD_S_HT_Order_Northwind]
				, [OrderID]
			)
			SELECT DISTINCT
				  stage.[HK_H_Order]
				, stage.[DV_Load_Datetime]
				, stage.[DV_Record_Source]
				, stage.[DV_Deleted_Flag]
				, stage.[HD_S_HT_Order_Northwind]
				, stage.[OrderID]
			FROM
				[Stage_Area].[northwind].[Orders] AS stage
					-- Join to the most recently loaded satellite for the Hub hash key
					OUTER APPLY (
						SELECT TOP 1
							  satellite.[HK_H_Order]
							, satellite.[DV_Load_Datetime]
							, satellite.[HD_S_HT_Order_Northwind]
						FROM
							[Data_Vault].[raw].[S_HT_Order_Northwind] AS satellite
						WHERE
							stage.[HK_H_Order] = satellite.[HK_H_Order]
						ORDER BY
							satellite.[DV_Load_Datetime] DESC
					) AS top_satellite
			WHERE
				-- Insert new record if either no satellite records exist for the Hub hash key or the change hash differs
				top_satellite.[HK_H_Order] IS NULL
				OR (
					stage.[DV_Load_Datetime] > top_satellite.[DV_Load_Datetime]
					AND stage.[HD_S_HT_Order_Northwind] <> top_satellite.[HD_S_HT_Order_Northwind]
				)
		
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
/****** Object:  StoredProcedure [raw].[usp_Load_S_HT_Product_Category_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_S_HT_Product_Category_Northwind]
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			/* Insert ghost record */

			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[S_HT_Product_Category_Northwind]
				WHERE
					[HK_H_Product_Category] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[S_HT_Product_Category_Northwind] (
					  [HK_H_Product_Category]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [DV_Deleted_Flag]
					, [HD_S_HT_Product_Category_Northwind]
					, [CategoryID]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_H_Product_Category
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, 0								-- DV_Deleted_Flag
					, REPLICATE('0', 32)			-- HD_S_HT_Product_Category_Northwind
					, 0								-- CategoryID
				);
			END

			
			/* Insert Satellite records */

			INSERT INTO [Data_Vault].[raw].[S_HT_Product_Category_Northwind] (
				  [HK_H_Product_Category]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [DV_Deleted_Flag]
				, [HD_S_HT_Product_Category_Northwind]
				, [CategoryID]
			)
			SELECT DISTINCT
				  stage.[HK_H_Product_Category]
				, stage.[DV_Load_Datetime]
				, stage.[DV_Record_Source]
				, stage.[DV_Deleted_Flag]
				, stage.[HD_S_HT_Product_Category_Northwind]
				, stage.[CategoryID]
			FROM
				[Stage_Area].[northwind].[Categories] AS stage
					-- Join to the most recently loaded satellite for the Hub hash key
					OUTER APPLY (
						SELECT TOP 1
							  satellite.[HK_H_Product_Category]
							, satellite.[DV_Load_Datetime]
							, satellite.[HD_S_HT_Product_Category_Northwind]
						FROM
							[Data_Vault].[raw].[S_HT_Product_Category_Northwind] AS satellite
						WHERE
							stage.[HK_H_Product_Category] = satellite.[HK_H_Product_Category]
						ORDER BY
							satellite.[DV_Load_Datetime] DESC
					) AS top_satellite
			WHERE
				-- Insert new record if either no satellite records exist for the Hub hash key or the change hash differs
				top_satellite.[HK_H_Product_Category] IS NULL
				OR (
					stage.[DV_Load_Datetime] > top_satellite.[DV_Load_Datetime]
					AND stage.[HD_S_HT_Product_Category_Northwind] <> top_satellite.[HD_S_HT_Product_Category_Northwind]
				)
		
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
/****** Object:  StoredProcedure [raw].[usp_Load_S_HT_Product_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_S_HT_Product_Northwind]
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			/* Insert ghost record */

			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[S_HT_Product_Northwind]
				WHERE
					[HK_H_Product] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[S_HT_Product_Northwind] (
					  [HK_H_Product]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [DV_Deleted_Flag]
					, [HD_S_HT_Product_Northwind]
					, [ProductID]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_H_Product
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, 0								-- DV_Deleted_Flag
					, REPLICATE('0', 32)			-- HD_S_HT_Product_Northwind
					, 0								-- ProductID
				);
			END

			
			/* Insert Satellite records */

			INSERT INTO [Data_Vault].[raw].[S_HT_Product_Northwind] (
				  [HK_H_Product]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [DV_Deleted_Flag]
				, [HD_S_HT_Product_Northwind]
				, [ProductID]
			)
			SELECT DISTINCT
				  stage.[HK_H_Product]
				, stage.[DV_Load_Datetime]
				, stage.[DV_Record_Source]
				, stage.[DV_Deleted_Flag]
				, stage.[HD_S_HT_Product_Northwind]
				, stage.[ProductID]
			FROM
				[Stage_Area].[northwind].[Products] AS stage
					-- Join to the most recently loaded satellite for the Hub hash key
					OUTER APPLY (
						SELECT TOP 1
							  satellite.[HK_H_Product]
							, satellite.[DV_Load_Datetime]
							, satellite.[HD_S_HT_Product_Northwind]
						FROM
							[Data_Vault].[raw].[S_HT_Product_Northwind] AS satellite
						WHERE
							stage.[HK_H_Product] = satellite.[HK_H_Product]
						ORDER BY
							satellite.[DV_Load_Datetime] DESC
					) AS top_satellite
			WHERE
				-- Insert new record if either no satellite records exist for the Hub hash key or the change hash differs
				top_satellite.[HK_H_Product] IS NULL
				OR (
					stage.[DV_Load_Datetime] > top_satellite.[DV_Load_Datetime]
					AND stage.[HD_S_HT_Product_Northwind] <> top_satellite.[HD_S_HT_Product_Northwind]
				)
		
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
/****** Object:  StoredProcedure [raw].[usp_Load_S_HT_Region_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_S_HT_Region_Northwind]
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			/* Insert ghost record */

			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[S_HT_Region_Northwind]
				WHERE
					[HK_H_Region] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[S_HT_Region_Northwind] (
					  [HK_H_Region]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [DV_Deleted_Flag]
					, [HD_S_HT_Region_Northwind]
					, [RegionID]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_H_Region
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, 0								-- DV_Deleted_Flag
					, REPLICATE('0', 32)			-- HD_S_HT_Region_Northwind
					, 0								-- RegionID
				);
			END

			
			/* Insert Satellite records */

			INSERT INTO [Data_Vault].[raw].[S_HT_Region_Northwind] (
				  [HK_H_Region]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [DV_Deleted_Flag]
				, [HD_S_HT_Region_Northwind]
				, [RegionID]
			)
			SELECT DISTINCT
				  stage.[HK_H_Region]
				, stage.[DV_Load_Datetime]
				, stage.[DV_Record_Source]
				, stage.[DV_Deleted_Flag]
				, stage.[HD_S_HT_Region_Northwind]
				, stage.[RegionID]
			FROM
				[Stage_Area].[northwind].[Region] AS stage
					-- Join to the most recently loaded satellite for the Hub hash key
					OUTER APPLY (
						SELECT TOP 1
							  satellite.[HK_H_Region]
							, satellite.[DV_Load_Datetime]
							, satellite.[HD_S_HT_Region_Northwind]
						FROM
							[Data_Vault].[raw].[S_HT_Region_Northwind] AS satellite
						WHERE
							stage.[HK_H_Region] = satellite.[HK_H_Region]
						ORDER BY
							satellite.[DV_Load_Datetime] DESC
					) AS top_satellite
			WHERE
				-- Insert new record if either no satellite records exist for the Hub hash key or the change hash differs
				top_satellite.[HK_H_Region] IS NULL
				OR (
					stage.[DV_Load_Datetime] > top_satellite.[DV_Load_Datetime]
					AND stage.[HD_S_HT_Region_Northwind] <> top_satellite.[HD_S_HT_Region_Northwind]
				)
		
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
/****** Object:  StoredProcedure [raw].[usp_Load_S_HT_Shipper_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_S_HT_Shipper_Northwind]
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			/* Insert ghost record */

			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[S_HT_Shipper_Northwind]
				WHERE
					[HK_H_Shipper] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[S_HT_Shipper_Northwind] (
					  [HK_H_Shipper]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [DV_Deleted_Flag]
					, [HD_S_HT_Shipper_Northwind]
					, [ShipperID]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_H_Shipper
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, 0								-- DV_Deleted_Flag
					, REPLICATE('0', 32)			-- HD_S_HT_Shipper_Northwind
					, '0'							-- ShipperID
				);
			END

			
			/* Insert Satellite records */

			INSERT INTO [Data_Vault].[raw].[S_HT_Shipper_Northwind] (
				  [HK_H_Shipper]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [DV_Deleted_Flag]
				, [HD_S_HT_Shipper_Northwind]
				, [ShipperID]
			)
			SELECT DISTINCT
				  stage.[HK_H_Shipper]
				, stage.[DV_Load_Datetime]
				, stage.[DV_Record_Source]
				, stage.[DV_Deleted_Flag]
				, stage.[HD_S_HT_Shipper_Northwind]
				, stage.[ShipperID]
			FROM
				[Stage_Area].[northwind].[Shippers] AS stage
					-- Join to the most recently loaded satellite for the Hub hash key
					OUTER APPLY (
						SELECT TOP 1
							  satellite.[HK_H_Shipper]
							, satellite.[DV_Load_Datetime]
							, satellite.[HD_S_HT_Shipper_Northwind]
						FROM
							[Data_Vault].[raw].[S_HT_Shipper_Northwind] AS satellite
						WHERE
							stage.[HK_H_Shipper] = satellite.[HK_H_Shipper]
						ORDER BY
							satellite.[DV_Load_Datetime] DESC
					) AS top_satellite
			WHERE
				-- Insert new record if either no satellite records exist for the Hub hash key or the change hash differs
				top_satellite.[HK_H_Shipper] IS NULL
				OR (
					stage.[DV_Load_Datetime] > top_satellite.[DV_Load_Datetime]
					AND stage.[HD_S_HT_Shipper_Northwind] <> top_satellite.[HD_S_HT_Shipper_Northwind]
				)
		
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
/****** Object:  StoredProcedure [raw].[usp_Load_S_HT_Supplier_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_S_HT_Supplier_Northwind]
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			/* Insert ghost record */

			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[S_HT_Supplier_Northwind]
				WHERE
					[HK_H_Supplier] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[S_HT_Supplier_Northwind] (
					  [HK_H_Supplier]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [DV_Deleted_Flag]
					, [HD_S_HT_Supplier_Northwind]
					, [SupplierID]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_H_Supplier
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, 0								-- DV_Deleted_Flag
					, REPLICATE('0', 32)			-- HD_S_HT_Supplier_Northwind
					, 0								-- SupplierID
				);
			END

			
			/* Insert Satellite records */

			INSERT INTO [Data_Vault].[raw].[S_HT_Supplier_Northwind] (
				  [HK_H_Supplier]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [DV_Deleted_Flag]
				, [HD_S_HT_Supplier_Northwind]
				, [SupplierID]
			)
			SELECT DISTINCT
				  stage.[HK_H_Supplier]
				, stage.[DV_Load_Datetime]
				, stage.[DV_Record_Source]
				, stage.[DV_Deleted_Flag]
				, stage.[HD_S_HT_Supplier_Northwind]
				, stage.[SupplierID]
			FROM
				[Stage_Area].[northwind].[Suppliers] AS stage
					-- Join to the most recently loaded satellite for the Hub hash key
					OUTER APPLY (
						SELECT TOP 1
							  satellite.[HK_H_Supplier]
							, satellite.[DV_Load_Datetime]
							, satellite.[HD_S_HT_Supplier_Northwind]
						FROM
							[Data_Vault].[raw].[S_HT_Supplier_Northwind] AS satellite
						WHERE
							stage.[HK_H_Supplier] = satellite.[HK_H_Supplier]
						ORDER BY
							satellite.[DV_Load_Datetime] DESC
					) AS top_satellite
			WHERE
				-- Insert new record if either no satellite records exist for the Hub hash key or the change hash differs
				top_satellite.[HK_H_Supplier] IS NULL
				OR (
					stage.[DV_Load_Datetime] > top_satellite.[DV_Load_Datetime]
					AND stage.[HD_S_HT_Supplier_Northwind] <> top_satellite.[HD_S_HT_Supplier_Northwind]
				)
		
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
/****** Object:  StoredProcedure [raw].[usp_Load_S_HT_Territory_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_S_HT_Territory_Northwind]
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			/* Insert ghost record */

			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[S_HT_Territory_Northwind]
				WHERE
					[HK_H_Territory] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[S_HT_Territory_Northwind] (
					  [HK_H_Territory]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [DV_Deleted_Flag]
					, [HD_S_HT_Territory_Northwind]
					, [TerritoryID]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_H_Territory
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, 0								-- DV_Deleted_Flag
					, REPLICATE('0', 32)			-- HD_S_HT_Territory_Northwind
					, '00000'						-- TerritoryID
				);
			END

			
			/* Insert Satellite records */

			INSERT INTO [Data_Vault].[raw].[S_HT_Territory_Northwind] (
				  [HK_H_Territory]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [DV_Deleted_Flag]
				, [HD_S_HT_Territory_Northwind]
				, [TerritoryID]
			)
			SELECT DISTINCT
				  stage.[HK_H_Territory]
				, stage.[DV_Load_Datetime]
				, stage.[DV_Record_Source]
				, stage.[DV_Deleted_Flag]
				, stage.[HD_S_HT_Territory_Northwind]
				, stage.[TerritoryID]
			FROM
				[Stage_Area].[northwind].[Territories] AS stage
					-- Join to the most recently loaded satellite for the Hub hash key
					OUTER APPLY (
						SELECT TOP 1
							  satellite.[HK_H_Territory]
							, satellite.[DV_Load_Datetime]
							, satellite.[HD_S_HT_Territory_Northwind]
						FROM
							[Data_Vault].[raw].[S_HT_Territory_Northwind] AS satellite
						WHERE
							stage.[HK_H_Territory] = satellite.[HK_H_Territory]
						ORDER BY
							satellite.[DV_Load_Datetime] DESC
					) AS top_satellite
			WHERE
				-- Insert new record if either no satellite records exist for the Hub hash key or the change hash differs
				top_satellite.[HK_H_Territory] IS NULL
				OR (
					stage.[DV_Load_Datetime] > top_satellite.[DV_Load_Datetime]
					AND stage.[HD_S_HT_Territory_Northwind] <> top_satellite.[HD_S_HT_Territory_Northwind]
				)
		
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
/****** Object:  StoredProcedure [raw].[usp_Load_S_LE_Employee_Reporting_Line_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_S_LE_Employee_Reporting_Line_Northwind]
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			/* Insert ghost record */

			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[S_LE_Employee_Reporting_Line_Northwind]
				WHERE
					[HK_L_Employee_Reporting_Line] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[S_LE_Employee_Reporting_Line_Northwind] (
					  [HK_L_Employee_Reporting_Line]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [HD_S_LE_Employee_Reporting_Line_Northwind]
					, [EmployeeID]
					, [ReportsTo]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_L_Employee_Reporting_Line
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, REPLICATE('0', 32)			-- HD_S_LE_Employee_Reporting_Line_Northwind
					, 0								-- EmployeeID
					, 0								-- ReportsTo
				);
			END
			
			
			/* Insert Satellite records */

			INSERT INTO [Data_Vault].[raw].[S_LE_Employee_Reporting_Line_Northwind] (
				  [HK_L_Employee_Reporting_Line]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [HD_S_LE_Employee_Reporting_Line_Northwind]
				, [EmployeeID]
				, [ReportsTo]
			)
			SELECT DISTINCT
				  stage.[HK_L_Employee_Reporting_Line]
				, stage.[DV_Load_Datetime]
				, stage.[DV_Record_Source]
				, stage.[HD_S_LE_Employee_Reporting_Line_Northwind]
				, stage.[EmployeeID]
				, stage.[ReportsTo]
			FROM
				[Stage_Area].[northwind].[Employees] AS stage
					-- Join to the most recently loaded satellite for the driving Hub hash key
					OUTER APPLY (
						SELECT TOP 1
							  link.[HK_H_Employee]
							, satellite.[DV_Load_Datetime]
							, satellite.[HD_S_LE_Employee_Reporting_Line_Northwind]
						FROM
							[Data_Vault].[raw].[S_LE_Employee_Reporting_Line_Northwind] AS satellite
								-- Join to Link to acquire driving key hash 
								INNER JOIN [Data_Vault].[raw].[L_Employee_Reporting_Line] AS link
									ON satellite.[HK_L_Employee_Reporting_Line] = link.[HK_L_Employee_Reporting_Line]
						WHERE
							stage.[HK_H_Employee] = link.[HK_H_Employee]
						ORDER BY
							satellite.[DV_Load_Datetime] DESC
					) AS top_satellite
			WHERE
				-- Insert new record if either no satellite records exist for the Hub hash key or the change hash differs
				top_satellite.[HK_H_Employee] IS NULL
				OR (
					stage.[DV_Load_Datetime] > top_satellite.[DV_Load_Datetime]
					AND stage.[HD_S_LE_Employee_Reporting_Line_Northwind] <> top_satellite.[HD_S_LE_Employee_Reporting_Line_Northwind]
				)
		
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
/****** Object:  StoredProcedure [raw].[usp_Load_S_LE_Order_Header_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_S_LE_Order_Header_Northwind]
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			/* Insert ghost record */

			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[S_LE_Order_Header_Northwind]
				WHERE
					[HK_L_Order_Header] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[S_LE_Order_Header_Northwind] (
					  [HK_L_Order_Header]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [HD_S_LE_Order_Header_Northwind]
					, [OrderID]
					, [CustomerID]
					, [EmployeeID]
					, [ShipVia]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_L_Order_Header
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, REPLICATE('0', 32)			-- HD_S_LE_Order_Header_Northwind
					, '0'							-- OrderID
					, '0'							-- CustomerID
					, '0'							-- EmployeeID
					, '0'							-- ShipVia
				);
			END
			
			
			/* Insert Satellite records */

			INSERT INTO [Data_Vault].[raw].[S_LE_Order_Header_Northwind] (
				  [HK_L_Order_Header]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [HD_S_LE_Order_Header_Northwind]
				, [OrderID]
				, [CustomerID]
				, [EmployeeID]
				, [ShipVia]
			)
			SELECT DISTINCT
				  stage.[HK_L_Order_Header]
				, stage.[DV_Load_Datetime]
				, stage.[DV_Record_Source]
				, stage.[HD_S_LE_Order_Header_Northwind]
				, stage.[OrderID]
				, stage.[CustomerID]
				, stage.[EmployeeID]
				, stage.[ShipVia]
			FROM
				[Stage_Area].[northwind].[Orders] AS stage
					-- Join to the most recently loaded satellite for the driving Hub hash key
					OUTER APPLY (
						SELECT TOP 1
							  link.[HK_H_Order]
							, satellite.[DV_Load_Datetime]
							, satellite.[HD_S_LE_Order_Header_Northwind]
						FROM
							[Data_Vault].[raw].[S_LE_Order_Header_Northwind] AS satellite
								INNER JOIN [Data_Vault].[raw].[L_Order_Header] AS link
									ON satellite.[HK_L_Order_Header] = link.[HK_L_Order_Header]
						WHERE
							stage.[HK_H_Order] = link.[HK_H_Order]
						ORDER BY
							satellite.[DV_Load_Datetime] DESC
					) AS top_satellite
			WHERE
				-- Insert new record if either no satellite records exist for the Hub hash key or the change hash differs
				top_satellite.[HK_H_Order] IS NULL
				OR (
					stage.[DV_Load_Datetime] > top_satellite.[DV_Load_Datetime]
					AND stage.[HD_S_LE_Order_Header_Northwind] <> top_satellite.[HD_S_LE_Order_Header_Northwind]
				)
		
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
/****** Object:  StoredProcedure [raw].[usp_Load_S_LE_Product_Category_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_S_LE_Product_Category_Northwind]
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			/* Insert ghost record */

			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[S_LE_Product_Category_Northwind]
				WHERE
					[HK_L_Product_Category] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[S_LE_Product_Category_Northwind] (
					  [HK_L_Product_Category]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [HD_S_LE_Product_Category_Northwind]
					, [ProductID]
					, [CategoryID]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_L_Product_Category
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, REPLICATE('0', 32)			-- HD_S_LE_Product_Category_Northwind
					, 0								-- ProductID
					, 0								-- CategoryID
				);
			END
			
			
			/* Insert Satellite records */

			INSERT INTO [Data_Vault].[raw].[S_LE_Product_Category_Northwind] (
				  [HK_L_Product_Category]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [HD_S_LE_Product_Category_Northwind]
				, [ProductID]
				, [CategoryID]
			)
			SELECT DISTINCT
				  stage.[HK_L_Product_Category]
				, stage.[DV_Load_Datetime]
				, stage.[DV_Record_Source]
				, stage.[HD_S_LE_Product_Category_Northwind]
				, stage.[ProductID]
				, stage.[CategoryID]
			FROM
				[Stage_Area].[northwind].[Products] AS stage
					-- Join to the most recently loaded satellite for the driving Hub hash key
					OUTER APPLY (
						SELECT TOP 1
							  link.[HK_H_Product]
							, satellite.[DV_Load_Datetime]
							, satellite.[HD_S_LE_Product_Category_Northwind]
						FROM
							[Data_Vault].[raw].[S_LE_Product_Category_Northwind] AS satellite
								-- Join to Link to acquire driving key hash 
								INNER JOIN [Data_Vault].[raw].[L_Product_Category] AS link
									ON satellite.[HK_L_Product_Category] = link.[HK_L_Product_Category]
						WHERE
							stage.[HK_H_Product] = link.[HK_H_Product]
						ORDER BY
							satellite.[DV_Load_Datetime] DESC
					) AS top_satellite
			WHERE
				-- Insert new record if either no satellite records exist for the Hub hash key or the change hash differs
				top_satellite.[HK_H_Product] IS NULL
				OR (
					stage.[DV_Load_Datetime] > top_satellite.[DV_Load_Datetime]
					AND stage.[HD_S_LE_Product_Category_Northwind] <> top_satellite.[HD_S_LE_Product_Category_Northwind]
				)
		
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
/****** Object:  StoredProcedure [raw].[usp_Load_S_LE_Product_Supplier_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_S_LE_Product_Supplier_Northwind]
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			/* Insert ghost record */

			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[S_LE_Product_Supplier_Northwind]
				WHERE
					[HK_L_Product_Supplier] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[S_LE_Product_Supplier_Northwind] (
					  [HK_L_Product_Supplier]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [HD_S_LE_Product_Supplier_Northwind]
					, [ProductID]
					, [SupplierID]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_L_Product_Supplier
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, REPLICATE('0', 32)			-- HD_S_DKE_Product_Supplier
					, 0								-- ProductID
					, 0								-- SupplierID
				);
			END

			
			/* Insert Satellite records */

			INSERT INTO [Data_Vault].[raw].[S_LE_Product_Supplier_Northwind] (
				  [HK_L_Product_Supplier]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [HD_S_LE_Product_Supplier_Northwind]
				, [ProductID]
				, [SupplierID]
			)
			SELECT DISTINCT
				  stage.[HK_L_Product_Supplier]
				, stage.[DV_Load_Datetime]
				, stage.[DV_Record_Source]
				, stage.[HD_S_LE_Product_Supplier_Northwind]
				, stage.[ProductID]
				, stage.[SupplierID]
				--, top_satellite.*
			FROM
				[Stage_Area].[northwind].[Products] AS stage
					-- Join to the most recently loaded satellite for the driving Hub hash key
					OUTER APPLY (
						SELECT TOP 1
							  link.[HK_H_Product]
							, satellite.[DV_Load_Datetime]
							, satellite.[HD_S_LE_Product_Supplier_Northwind]
						FROM
							[Data_Vault].[raw].[S_LE_Product_Supplier_Northwind] AS satellite
								-- Join to Link to acquire driving key hash
								INNER JOIN [Data_Vault].[raw].[L_Product_Supplier] AS link
									ON satellite.[HK_L_Product_Supplier] = link.[HK_L_Product_Supplier]
						WHERE
							stage.[HK_H_Product] = link.[HK_H_Product]
						ORDER BY
							satellite.[DV_Load_Datetime] DESC
					) AS top_satellite
			WHERE
				-- Insert new record if either no satellite records exist for the Hub hash key or the change hash differs
				top_satellite.[HK_H_Product] IS NULL
				OR (
					stage.[DV_Load_Datetime] > top_satellite.[DV_Load_Datetime]
					AND stage.[HD_S_LE_Product_Supplier_Northwind] <> top_satellite.[HD_S_LE_Product_Supplier_Northwind]
				)
		
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
/****** Object:  StoredProcedure [raw].[usp_Load_S_LE_Territory_Region_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_S_LE_Territory_Region_Northwind]
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			/* Insert ghost record */

			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[S_LE_Territory_Region_Northwind]
				WHERE
					[HK_L_Territory_Region] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[S_LE_Territory_Region_Northwind] (
					  [HK_L_Territory_Region]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [HD_S_LE_Territory_Region_Northwind]
					, [TerritoryID]
					, [RegionID]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_L_Territory_Region
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, REPLICATE('0', 32)			-- HD_S_DKE_Product_Supplier
					, '00000'					    -- TerritoryID
					, 0								-- RegionID
				);
			END

			
			/* Insert Satellite records */

			INSERT INTO [Data_Vault].[raw].[S_LE_Territory_Region_Northwind] (
				  [HK_L_Territory_Region]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [HD_S_LE_Territory_Region_Northwind]
				, [TerritoryID]
				, [RegionID]
			)
			SELECT DISTINCT
				  stage.[HK_L_Territory_Region]
				, stage.[DV_Load_Datetime]
				, stage.[DV_Record_Source]
				, stage.[HD_S_LE_Territory_Region_Northwind]
				, stage.[TerritoryID]
				, stage.[RegionID]
			FROM
				[Stage_Area].[northwind].[Territories] AS stage
					-- Join to the most recently loaded satellite for the driving Hub hash key
					OUTER APPLY (
						SELECT TOP 1
							  link.[HK_H_Territory]
							, satellite.[DV_Load_Datetime]
							, satellite.[HD_S_LE_Territory_Region_Northwind]
						FROM
							[Data_Vault].[raw].[S_LE_Territory_Region_Northwind] AS satellite
								INNER JOIN [Data_Vault].[raw].[L_Territory_Region] AS link
									ON satellite.[HK_L_Territory_Region] = link.[HK_L_Territory_Region]
						WHERE
							stage.[HK_H_Territory] = link.[HK_H_Territory]
						ORDER BY
							satellite.[DV_Load_Datetime] DESC
					) AS top_satellite
			WHERE
				-- Insert new record if either no satellite records exist for the Hub hash key or the change hash differs
				top_satellite.[HK_H_Territory] IS NULL
				OR (
					stage.[DV_Load_Datetime] > top_satellite.[DV_Load_Datetime]
					AND stage.[HD_S_LE_Territory_Region_Northwind] <> top_satellite.[HD_S_LE_Territory_Region_Northwind]
				)
		
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
/****** Object:  StoredProcedure [raw].[usp_Load_S_LST_Employee_Territory_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_S_LST_Employee_Territory_Northwind]
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			/* Insert ghost record */

			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[S_LST_Employee_Territory_Northwind]
				WHERE
					[HK_L_Employee_Territory] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[S_LST_Employee_Territory_Northwind] (
					  [HK_L_Employee_Territory]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [DV_Deleted_Flag]
					, [HD_S_LST_Employee_Territory_Northwind]
					, [EmployeeID]
					, [TerritoryID]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_L_Employee_Territory
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, 0								-- DV_Deleted_Flag
					, REPLICATE('0', 32)			-- HD_S_LST_Employee_Territory_Northwind
					, 0								-- EmployeeID
					, '00000'						-- TerritoryID
				);
			END

			
			/* Insert Satellite records */

			INSERT INTO [Data_Vault].[raw].[S_LST_Employee_Territory_Northwind] (
				  [HK_L_Employee_Territory]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [DV_Deleted_Flag]
				, [HD_S_LST_Employee_Territory_Northwind]
				, [EmployeeID]
				, [TerritoryID]
			)
			SELECT DISTINCT
				  stage.[HK_L_Employee_Territory]
				, stage.[DV_Load_Datetime]
				, stage.[DV_Record_Source]
				, stage.[DV_Deleted_Flag]
				, stage.[HD_S_LST_Employee_Territory_Northwind]
				, stage.[EmployeeID]
				, stage.[TerritoryID]
			FROM
				[Stage_Area].[nw].[EmployeeTerritories] AS stage
					-- Join to the most recently loaded satellite for the Hub hash key
					OUTER APPLY (
						SELECT TOP 1
							  satellite.[HK_L_Employee_Territory]
							, satellite.[DV_Load_Datetime]
							, satellite.[HD_S_LST_Employee_Territory_Northwind]
						FROM
							[Data_Vault].[raw].[S_LST_Employee_Territory_Northwind] AS satellite
						WHERE
							stage.[HK_L_Employee_Territory] = satellite.[HK_L_Employee_Territory]
						ORDER BY
							satellite.[DV_Load_Datetime] DESC
					) AS top_satellite
			WHERE
				-- Insert new record if either no satellite records exist for the Hub hash key or the change hash differs
				top_satellite.[HK_L_Employee_Territory] IS NULL
				OR (
					stage.[DV_Load_Datetime] > top_satellite.[DV_Load_Datetime]
					AND stage.[HD_S_LST_Employee_Territory_Northwind] <> top_satellite.[HD_S_LST_Employee_Territory_Northwind]
				)
		
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
/****** Object:  StoredProcedure [raw].[usp_Load_S_LT_Customer_Type_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_S_LT_Customer_Type_Northwind]
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			/* Insert ghost record */

			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[S_LT_Customer_Type_Northwind]
				WHERE
					[HK_L_Customer_Type] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[S_LT_Customer_Type_Northwind] (
					  [HK_L_Customer_Type]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [DV_Deleted_Flag]
					, [HD_S_LT_Customer_Type_Northwind]
					, [CustomerID]
					, [CustomerTypeID]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_L_Customer_Type
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, 0								-- DV_Deleted_Flag
					, REPLICATE('0', 32)			-- HD_S_LT_Customer_Type_Northwind
					, '0'							-- CustomerID
					, '0'							-- CustomerTypeID
				);
			END

			
			/* Insert Satellite records */

			INSERT INTO [Data_Vault].[raw].[S_LT_Customer_Type_Northwind] (
				  [HK_L_Customer_Type]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [DV_Deleted_Flag]
				, [HD_S_LT_Customer_Type_Northwind]
				, [CustomerID]
				, [CustomerTypeID]
			)
			SELECT DISTINCT
				  stage.[HK_L_Customer_Type]
				, stage.[DV_Load_Datetime]
				, stage.[DV_Record_Source]
				, stage.[DV_Deleted_Flag]
				, stage.[HD_S_LT_Customer_Type_Northwind]
				, stage.[CustomerID]
				, stage.[CustomerTypeID]
			FROM
				[Stage_Area].[northwind].[CustomerCustomerDemo] AS stage
					-- Join to the most recently loaded satellite for the Hub hash key
					OUTER APPLY (
						SELECT TOP 1
							  satellite.[HK_L_Customer_Type]
							, satellite.[DV_Load_Datetime]
							, satellite.[HD_S_LT_Customer_Type_Northwind]
						FROM
							[Data_Vault].[raw].[S_LT_Customer_Type_Northwind] AS satellite
						WHERE
							stage.[HK_L_Customer_Type] = satellite.[HK_L_Customer_Type]
						ORDER BY
							satellite.[DV_Load_Datetime] DESC
					) AS top_satellite
			WHERE
				-- Insert new record if either no satellite records exist for the Hub hash key or the change hash differs
				top_satellite.[HK_L_Customer_Type] IS NULL
				OR (
					stage.[DV_Load_Datetime] > top_satellite.[DV_Load_Datetime]
					AND stage.[HD_S_LT_Customer_Type_Northwind] <> top_satellite.[HD_S_LT_Customer_Type_Northwind]
				)
		
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
/****** Object:  StoredProcedure [raw].[usp_Load_S_LT_Employee_Territory_Northwind]    Script Date: 5/01/2023 11:40:22 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [raw].[usp_Load_S_LT_Employee_Territory_Northwind]
AS
	BEGIN

		SET NOCOUNT ON

		BEGIN TRANSACTION

		BEGIN TRY

			/* Insert ghost record */

			IF NOT EXISTS (
				SELECT 
					1 
				FROM 
					[Data_Vault].[raw].[S_LT_Employee_Territory_Northwind]
				WHERE
					[HK_L_Employee_Territory] = REPLICATE('0', 32)
			)
			BEGIN
				INSERT INTO [Data_Vault].[raw].[S_LT_Employee_Territory_Northwind] (
					  [HK_L_Employee_Territory]
					, [DV_Load_Datetime]
					, [DV_Record_Source]
					, [DV_Deleted_Flag]
					, [HD_S_LT_Employee_Territory_Northwind]
					, [EmployeeID]
					, [TerritoryID]
				)
				VALUES (
					  REPLICATE('0', 32)			-- HK_L_Employee_Territory
					, '1900-01-01 00:00:00.000'		-- DV_Load_Datetime
					, 'SYSTEM'						-- DV_Record_Source
					, 0								-- DV_Deleted_Flag
					, REPLICATE('0', 32)			-- HD_S_LT_Employee_Territory_Northwind
					, 0								-- EmployeeID
					, '00000'						-- TerritoryID
				);
			END

			
			/* Insert Satellite records */

			INSERT INTO [Data_Vault].[raw].[S_LT_Employee_Territory_Northwind] (
				  [HK_L_Employee_Territory]
				, [DV_Load_Datetime]
				, [DV_Record_Source]
				, [DV_Deleted_Flag]
				, [HD_S_LT_Employee_Territory_Northwind]
				, [EmployeeID]
				, [TerritoryID]
			)
			SELECT DISTINCT
				  stage.[HK_L_Employee_Territory]
				, stage.[DV_Load_Datetime]
				, stage.[DV_Record_Source]
				, stage.[DV_Deleted_Flag]
				, stage.[HD_S_LT_Employee_Territory_Northwind]
				, stage.[EmployeeID]
				, stage.[TerritoryID]
			FROM
				[Stage_Area].[northwind].[EmployeeTerritories] AS stage
					-- Join to the most recently loaded satellite for the Hub hash key
					OUTER APPLY (
						SELECT TOP 1
							  satellite.[HK_L_Employee_Territory]
							, satellite.[DV_Load_Datetime]
							, satellite.[HD_S_LT_Employee_Territory_Northwind]
						FROM
							[Data_Vault].[raw].[S_LT_Employee_Territory_Northwind] AS satellite
						WHERE
							stage.[HK_L_Employee_Territory] = satellite.[HK_L_Employee_Territory]
						ORDER BY
							satellite.[DV_Load_Datetime] DESC
					) AS top_satellite
			WHERE
				-- Insert new record if either no satellite records exist for the Hub hash key or the change hash differs
				top_satellite.[HK_L_Employee_Territory] IS NULL
				OR (
					stage.[DV_Load_Datetime] > top_satellite.[DV_Load_Datetime]
					AND stage.[HD_S_LT_Employee_Territory_Northwind] <> top_satellite.[HD_S_LT_Employee_Territory_Northwind]
				)
		
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
ALTER DATABASE [Data_Vault] SET  READ_WRITE 
GO
