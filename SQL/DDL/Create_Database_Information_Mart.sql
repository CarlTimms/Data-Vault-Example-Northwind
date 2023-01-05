/*
	
	Create Database Information_Mart.sql

	Create database Information_Mart. 
	Data provided for analysis. 'Replica' and star schema tables with business rules, renamings, etc applied.


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
	N'CREATE DATABASE [Information_Mart]
		ON PRIMARY 
			  (
				  NAME = N''InformationMart''
				, FILENAME = N''' + @device_directory + N'InformationMart.mdf''
				, SIZE = 512KB
				, MAXSIZE = UNLIMITED
				, FILEGROWTH = 1024KB
			  )
			, FILEGROUP [DATA] (
				  NAME = N''InformationMart_data''
				, FILENAME = N''' + @device_directory + N'InformationMart_data.ndf''
				, SIZE = 512KB
				, MAXSIZE = UNLIMITED
				, FILEGROWTH = 10%
			  )
			, FILEGROUP [INDEX] (
				  NAME = N''InformationMart_index''
				, FILENAME = N''' + @device_directory + N'InformationMart_index.ndf'' 
				, SIZE = 512KB 
				, MAXSIZE = UNLIMITED
				, FILEGROWTH = 10%
			  )
		LOG ON 
			(
				  NAME = N''InformationMart_log''
				, FILENAME = N''' + @device_directory + N'InformationMart_log.ldf'' 
				, SIZE = 512KB 
				, MAXSIZE = 2048GB 
				, FILEGROWTH = 10%
			)
		WITH
			CATALOG_COLLATION = DATABASE_DEFAULT;'
);
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
/****** Object:  Schema [replica]    Script Date: 5/01/2023 12:21:39 pm ******/
CREATE SCHEMA [replica]
GO
/****** Object:  Schema [star]    Script Date: 5/01/2023 12:21:39 pm ******/
CREATE SCHEMA [star]
GO
/****** Object:  View [replica].[Northwind_Categories]    Script Date: 5/01/2023 12:21:39 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [replica].[Northwind_Categories]
AS   
	SELECT
		  sat_ht_product_category_northwind.[CategoryID]
		, sat_hc_product_category_northwind.[CategoryName]
		, sat_hc_product_category_northwind.[Description]
		, sat_hc_product_category_northwind.[Picture]
	FROM
		[Data_Vault].[biz].[v_PIT_Product_Category] AS pit_product_category
			INNER JOIN [Data_Vault].[raw].[S_HC_Product_Category_Northwind] AS sat_hc_product_category_northwind
				ON pit_product_category.[S_HC_Product_Category_Northwind_HK_H_Product_Category] = sat_hc_product_category_northwind.[HK_H_Product_Category]
			   AND pit_product_category.[S_HC_Product_Category_Northwind_DV_Load_Datetime] = sat_hc_product_category_northwind.[DV_Load_Datetime]
			INNER JOIN [Data_Vault].[raw].[S_HT_Product_Category_Northwind] AS sat_ht_product_category_northwind
				ON pit_product_category.[S_HT_Product_Category_Northwind_HK_H_Product_Category] = sat_ht_product_category_northwind.[HK_H_Product_Category]
			   AND pit_product_category.[S_HT_Product_Category_Northwind_DV_Load_Datetime] = sat_ht_product_category_northwind.[DV_Load_Datetime]
	WHERE
		[Meta_Metrics_Error_Mart].[meta].[Get_Information_Mart_Load_Effective_Datetime]() BETWEEN pit_product_category.[DV_Snapshot_Datetime_Start] AND [DV_Snapshot_Datetime_End]
		AND pit_product_category.[HK_H_Product_Category] <> REPLICATE('0', 32)  -- Omit ghost record
		AND sat_ht_product_category_northwind.[DV_Deleted_Flag] = 0;  -- Omit deleted records
GO
/****** Object:  View [replica].[Northwind_CustomerCustomerDemo]    Script Date: 5/01/2023 12:21:39 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [replica].[Northwind_CustomerCustomerDemo]
AS   
	SELECT
		  sat_lt_customer_type_northwind.[CustomerID]
		, sat_lt_customer_type_northwind.[CustomerTypeID]
	FROM
		[Data_Vault].[biz].[v_S_LT_Customer_Type_Northwind] AS sat_lt_customer_type_northwind
	WHERE
		[Meta_Metrics_Error_Mart].[meta].[Get_Information_Mart_Load_Effective_Datetime]() BETWEEN sat_lt_customer_type_northwind.[DV_Load_Datetime_Start] AND sat_lt_customer_type_northwind.[DV_Load_Datetime_End]
		AND sat_lt_customer_type_northwind.[HK_L_Customer_Type] <> REPLICATE('0', 32)  -- Omit ghost record
		AND sat_lt_customer_type_northwind.[DV_Deleted_Flag] = 0;  -- Omit deleted records
GO
/****** Object:  View [replica].[Northwind_CustomerDemographics]    Script Date: 5/01/2023 12:21:39 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [replica].[Northwind_CustomerDemographics]
AS   
	SELECT
		  sat_ht_customer_type_northwind.[CustomerTypeID]
		, sat_hc_customer_type_northwind.[CustomerDesc]
	FROM
		[Data_Vault].[biz].[v_PIT_Customer_Type] AS pit_customer_type
			INNER JOIN [Data_Vault].[raw].[S_HC_Customer_Type_Northwind] AS sat_hc_customer_type_northwind
				ON pit_customer_type.[S_HC_Customer_Type_Northwind_HK_H_Customer_Type] = sat_hc_customer_type_northwind.[HK_H_Customer_Type]
			   AND pit_customer_type.[S_HC_Customer_Type_Northwind_DV_Load_Datetime] = sat_hc_customer_type_northwind.[DV_Load_Datetime]
			INNER JOIN [Data_Vault].[raw].[S_HT_Customer_Type_Northwind] AS sat_ht_customer_type_northwind
				ON pit_customer_type.[S_HT_Customer_Type_Northwind_HK_H_Customer_Type] = sat_ht_customer_type_northwind.[HK_H_Customer_Type]
			   AND pit_customer_type.[S_HT_Customer_Type_Northwind_DV_Load_Datetime] = sat_ht_customer_type_northwind.[DV_Load_Datetime]
	WHERE
		[Meta_Metrics_Error_Mart].[meta].[Get_Information_Mart_Load_Effective_Datetime]() BETWEEN pit_customer_type.[DV_Snapshot_Datetime_Start] AND pit_customer_type.[DV_Snapshot_Datetime_End]
		AND pit_customer_type.[HK_H_Customer_Type] <> REPLICATE('0', 32)  -- Omit ghost record
		AND sat_ht_customer_type_northwind.[DV_Deleted_Flag] = 0;  -- Omit deleted records
GO
/****** Object:  View [replica].[Northwind_Customers]    Script Date: 5/01/2023 12:21:39 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [replica].[Northwind_Customers]
AS   
	SELECT
		  sat_ht_customer_northwind.[CustomerID]
		, sat_hc_customer_northwind.[CompanyName]
		, sat_hc_customer_northwind.[ContactName]
		, sat_hc_customer_northwind.[ContactTitle]
		, sat_hc_customer_northwind.[Address]
		, sat_hc_customer_northwind.[City]
		, sat_hc_customer_northwind.[Region]
		, sat_hc_customer_northwind.[PostalCode]
		, sat_hc_customer_northwind.[Country]
		, sat_hc_customer_northwind.[Phone]
		, sat_hc_customer_northwind.[Fax]
	FROM
		[Data_Vault].[biz].[v_PIT_Customer] AS pit_customer
			INNER JOIN [Data_Vault].[raw].[S_HC_Customer_Northwind] AS sat_hc_customer_northwind
				ON pit_customer.[S_HC_Customer_Northwind_HK_H_Customer] = sat_hc_customer_northwind.[HK_H_Customer]
			   AND pit_customer.[S_HC_Customer_Northwind_DV_Load_Datetime] = sat_hc_customer_northwind.[DV_Load_Datetime]
			INNER JOIN [Data_Vault].[raw].[S_HT_Customer_Northwind] AS sat_ht_customer_northwind
				ON pit_customer.[S_HT_Customer_Northwind_HK_H_Customer] = sat_ht_customer_northwind.[HK_H_Customer]
			   AND pit_customer.[S_HT_Customer_Northwind_DV_Load_Datetime] = sat_ht_customer_northwind.[DV_Load_Datetime]
	WHERE
		[Meta_Metrics_Error_Mart].[meta].[Get_Information_Mart_Load_Effective_Datetime]() BETWEEN pit_customer.[DV_Snapshot_Datetime_Start] AND pit_customer.[DV_Snapshot_Datetime_End]
		AND pit_customer.[HK_H_Customer] <> REPLICATE('0', 32)  -- Omit ghost record
		AND sat_ht_customer_northwind.[DV_Deleted_Flag] = 0;  -- Omit deleted records
GO
/****** Object:  View [replica].[Northwind_Employees]    Script Date: 5/01/2023 12:21:39 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [replica].[Northwind_Employees]
AS   
	SELECT
		  sat_ht_employee_northwind.[EmployeeID]
		, sat_hc_employee_northwind.[LastName]
		, sat_hc_employee_northwind.[FirstName]
		, sat_hc_employee_northwind.[Title]
		, sat_hc_employee_northwind.[TitleOfCourtesy]
		, sat_hc_employee_northwind.[BirthDate]
		, sat_hc_employee_northwind.[HireDate]
		, sat_hc_employee_northwind.[Address]
		, sat_hc_employee_northwind.[City]
		, sat_hc_employee_northwind.[Region]
		, sat_hc_employee_northwind.[PostalCode]
		, sat_hc_employee_northwind.[Country]
		, sat_hc_employee_northwind.[HomePhone]
		, sat_hc_employee_northwind.[Extension]
		, sat_hc_employee_northwind.[Photo]
		, sat_hc_employee_northwind.[Notes]
		, sat_le_employee_reporting_line_northwind.[ReportsTo]
		, sat_hc_employee_northwind.[PhotoPath]
	FROM
		[Data_Vault].[biz].[v_PIT_Employee] AS pit_employee
			INNER JOIN [Data_Vault].[raw].[S_HC_Employee_Northwind] AS sat_hc_employee_northwind
				ON pit_employee.[S_HC_Employee_Northwind_HK_H_Employee] = sat_hc_employee_northwind.[HK_H_Employee]
			   AND pit_employee.[S_HC_Employee_Northwind_DV_Load_Datetime] = sat_hc_employee_northwind.[DV_Load_Datetime]
			INNER JOIN [Data_Vault].[raw].[S_HT_Employee_Northwind] AS sat_ht_employee_northwind
				ON pit_employee.[S_HT_Employee_Northwind_HK_H_Employee] = sat_ht_employee_northwind.[HK_H_Employee]
			   AND pit_employee.[S_HT_Employee_Northwind_DV_Load_Datetime] = sat_ht_employee_northwind.[DV_Load_Datetime]
			INNER JOIN [Data_Vault].[raw].[L_Employee_Reporting_Line] AS link_employee_reporting_line
				ON pit_employee.[HK_H_Employee] = link_employee_reporting_line.[HK_H_Employee]
			INNER JOIN [Data_Vault].[biz].[v_S_LE_Employee_Reporting_Line_Northwind] AS sat_le_employee_reporting_line_northwind
				ON link_employee_reporting_line.[HK_L_Employee_Reporting_Line] = sat_le_employee_reporting_line_northwind.[HK_L_Employee_Reporting_Line]
	WHERE
		[Meta_Metrics_Error_Mart].[meta].[Get_Information_Mart_Load_Effective_Datetime]() BETWEEN pit_employee.[DV_Snapshot_Datetime_Start] AND pit_employee.[DV_Snapshot_Datetime_End]
		AND [Meta_Metrics_Error_Mart].[meta].[Get_Information_Mart_Load_Effective_Datetime]() BETWEEN sat_le_employee_reporting_line_northwind.[DV_Load_Datetime_Start] AND sat_le_employee_reporting_line_northwind.[DV_Load_Datetime_End]
		AND pit_employee.[HK_H_Employee] <> REPLICATE('0', 32)  -- Omit ghost record
		AND sat_ht_employee_northwind.[DV_Deleted_Flag] = 0;  -- Omit deleted records
GO
/****** Object:  View [replica].[Northwind_EmployeeTerritories]    Script Date: 5/01/2023 12:21:39 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [replica].[Northwind_EmployeeTerritories]
AS   
	SELECT
		  sat_lt_employee_territory_northwind.[EmployeeID]
		, sat_lt_employee_territory_northwind.[TerritoryID]
	FROM
		[Data_Vault].[biz].[v_S_LT_Employee_Territory_Northwind] AS sat_lt_employee_territory_northwind
	WHERE
		[Meta_Metrics_Error_Mart].[meta].[Get_Information_Mart_Load_Effective_Datetime]() BETWEEN sat_lt_employee_territory_northwind.[DV_Load_Datetime_Start] AND sat_lt_employee_territory_northwind.[DV_Load_Datetime_End]
		AND sat_lt_employee_territory_northwind.[HK_L_Employee_Territory] <> REPLICATE('0', 32)  -- Omit ghost record
		AND sat_lt_employee_territory_northwind.[DV_Deleted_Flag] = 0;  -- Omit deleted records
GO
/****** Object:  View [replica].[Northwind_Order_Details]    Script Date: 5/01/2023 12:21:39 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [replica].[Northwind_Order_Details]
AS   
	SELECT
		  sat_ht_order_detail_northwind.[OrderID]
		, sat_ht_order_detail_northwind.[ProductID]
		, sat_hc_order_detail_northwind.[UnitPrice]
		, sat_hc_order_detail_northwind.[Quantity]
		, sat_hc_order_detail_northwind.[Discount]
	FROM
		[Data_Vault].[biz].[v_PIT_Order_Detail] AS pit_order_detail
			INNER JOIN [Data_Vault].[raw].[S_HC_Order_Detail_Northwind] AS sat_hc_order_detail_northwind
				ON pit_order_detail.[S_HC_Order_Detail_Northwind_HK_H_Order_Detail] = sat_hc_order_detail_northwind.[HK_H_Order_Detail]
			   AND pit_order_detail.[S_HC_Order_Detail_Northwind_DV_Load_Datetime] = sat_hc_order_detail_northwind.[DV_Load_Datetime]
			INNER JOIN [Data_Vault].[raw].[S_HT_Order_Detail_Northwind] AS sat_ht_order_detail_northwind
				ON pit_order_detail.[S_HT_Order_Detail_Northwind_HK_H_Order_Detail] = sat_ht_order_detail_northwind.[HK_H_Order_Detail]
			   AND pit_order_detail.[S_HT_Order_Detail_Northwind_DV_Load_Datetime] = sat_ht_order_detail_northwind.[DV_Load_Datetime]
	WHERE
		[Meta_Metrics_Error_Mart].[meta].[Get_Information_Mart_Load_Effective_Datetime]() BETWEEN pit_order_detail.[DV_Snapshot_Datetime_Start] AND pit_order_detail.[DV_Snapshot_Datetime_End]
		AND pit_order_detail.[HK_H_Order_Detail] <> REPLICATE('0', 32)  -- Omit ghost record
		AND sat_ht_order_detail_northwind.[DV_Deleted_Flag] = 0;  -- Omit deleted records
GO
/****** Object:  View [replica].[Northwind_Orders]    Script Date: 5/01/2023 12:21:39 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [replica].[Northwind_Orders]
AS   
	SELECT
		  sat_ht_order_northwind.[OrderID]
		, sat_le_order_header_northwind.[CustomerID]
		, sat_le_order_header_northwind.[EmployeeID]
		, sat_hc_order_northwind.[OrderDate]
		, sat_hc_order_northwind.[RequiredDate]
		, sat_hc_order_northwind.[ShippedDate]
		, sat_le_order_header_northwind.[ShipVia]
		, sat_hc_order_northwind.[Freight]
		, sat_hc_order_northwind.[ShipName]
		, sat_hc_order_northwind.[ShipAddress]
		, sat_hc_order_northwind.[ShipCity]
		, sat_hc_order_northwind.[ShipRegion]
		, sat_hc_order_northwind.[ShipPostalCode]
		, sat_hc_order_northwind.[ShipCountry]
	FROM
		[Data_Vault].[biz].[v_PIT_Order] AS pit_order
			INNER JOIN [Data_Vault].[raw].[S_HC_Order_Northwind] AS sat_hc_order_northwind
				ON pit_order.[S_HC_Order_Northwind_HK_H_Order] = sat_hc_order_northwind.[HK_H_Order]
			   AND pit_order.[S_HC_Order_Northwind_DV_Load_Datetime] = sat_hc_order_northwind.[DV_Load_Datetime]
			INNER JOIN [Data_Vault].[raw].[S_HT_Order_Northwind] AS sat_ht_order_northwind
				ON pit_order.[S_HT_Order_Northwind_HK_H_Order] = sat_ht_order_northwind.[HK_H_Order]
			   AND pit_order.[S_HT_Order_Northwind_DV_Load_Datetime] = sat_ht_order_northwind.[DV_Load_Datetime]
			INNER JOIN [Data_Vault].[raw].[L_Order_Header] AS link_order_header
				ON pit_order.[HK_H_Order] = link_order_header.[HK_H_Order]
			INNER JOIN [Data_Vault].[biz].[v_S_LE_Order_Header_Northwind] AS sat_le_order_header_northwind
				ON link_order_header.[HK_L_Order_Header] = sat_le_order_header_northwind.[HK_L_Order_Header]
	WHERE
		[Meta_Metrics_Error_Mart].[meta].[Get_Information_Mart_Load_Effective_Datetime]() BETWEEN pit_order.[DV_Snapshot_Datetime_Start] AND pit_order.[DV_Snapshot_Datetime_End]
		AND [Meta_Metrics_Error_Mart].[meta].[Get_Information_Mart_Load_Effective_Datetime]() BETWEEN sat_le_order_header_northwind.[DV_Load_Datetime_Start] AND sat_le_order_header_northwind.[DV_Load_Datetime_End]
		AND pit_order.[HK_H_Order] <> REPLICATE('0', 32)  -- Omit ghost record
		AND sat_ht_order_northwind.[DV_Deleted_Flag] = 0;  -- Omit deleted records
GO
/****** Object:  View [replica].[Northwind_Products]    Script Date: 5/01/2023 12:21:39 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [replica].[Northwind_Products]
AS   
	SELECT
		  sat_ht_product_northwind.[ProductID]
		, sat_hc_product_northwind.[ProductName]
		, sat_le_product_supplier_northwind.[SupplierID]
		, sat_le_product_category_northwind.[CategoryID]
		, sat_hc_product_northwind.[QuantityPerUnit]
		, sat_hc_product_northwind.[UnitPrice]
		, sat_hc_product_northwind.[UnitsInStock]
		, sat_hc_product_northwind.[UnitsOnOrder]
		, sat_hc_product_northwind.[ReorderLevel]
		, sat_hc_product_northwind.[Discontinued]
	FROM
		[Data_Vault].[biz].[v_PIT_Product] AS pit_product
			INNER JOIN [Data_Vault].[raw].[S_HC_Product_Northwind] AS sat_hc_product_northwind 
				ON pit_product.[S_HC_Product_Northwind_HK_H_Product] = sat_hc_product_northwind.[HK_H_Product]
			   AND pit_product.[S_HC_Product_Northwind_DV_Load_Datetime] = sat_hc_product_northwind.[DV_Load_Datetime]	
			INNER JOIN [Data_Vault].[raw].[S_HT_Product_Northwind] AS sat_ht_product_northwind
				ON pit_product.[S_HT_Product_Northwind_HK_H_Product] = sat_ht_product_northwind.[HK_H_Product]
			   AND pit_product.[S_HT_Product_Northwind_DV_Load_Datetime] = sat_ht_product_northwind.[DV_Load_Datetime]
			INNER JOIN [Data_Vault].[raw].[L_Product_Category] AS link_product_category
				ON pit_product.[HK_H_Product] = link_product_category.[HK_H_Product]
			INNER JOIN [Data_Vault].[biz].[v_S_LE_Product_Category_Northwind] AS sat_le_product_category_northwind
				ON link_product_category.[HK_L_Product_Category] = sat_le_product_category_northwind.[HK_L_Product_Category]
			INNER JOIN [Data_Vault].[raw].[L_Product_Supplier] AS link_product_supplier
				ON pit_product.[HK_H_Product] = link_product_supplier.[HK_H_Product]
			INNER JOIN [Data_Vault].[biz].[v_S_LE_Product_Supplier_Northwind] AS sat_le_product_supplier_northwind
				ON link_product_supplier.[HK_L_Product_Supplier] = sat_le_product_supplier_northwind.[HK_L_Product_Supplier]
	WHERE
		[Meta_Metrics_Error_Mart].[meta].[Get_Information_Mart_Load_Effective_Datetime]() BETWEEN pit_product.[DV_Snapshot_Datetime_Start] AND pit_product.[DV_Snapshot_Datetime_End]
		AND [Meta_Metrics_Error_Mart].[meta].[Get_Information_Mart_Load_Effective_Datetime]() BETWEEN sat_le_product_category_northwind.[DV_Load_Datetime_Start] AND sat_le_product_category_northwind.[DV_Load_Datetime_End]
		AND [Meta_Metrics_Error_Mart].[meta].[Get_Information_Mart_Load_Effective_Datetime]() BETWEEN sat_le_product_supplier_northwind.[DV_Load_Datetime_Start] AND sat_le_product_supplier_northwind.[DV_Load_Datetime_End]
		AND pit_product.[HK_H_Product] <> REPLICATE('0', 32)  -- Omit ghost record
		AND sat_ht_product_northwind.[DV_Deleted_Flag] = 0;  -- Omit deleted records
GO
/****** Object:  View [replica].[Northwind_Region]    Script Date: 5/01/2023 12:21:39 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [replica].[Northwind_Region]
AS   
	
	/* Identify the load effective datetime at which to query the data */

	WITH CTE_Parameter AS (
		SELECT 
			  [ID]
			, [Name]
			, [Description]
			, [Value]
			  -- Use current datetime if Value blank, otherwise attempt to cast as datetime2, falling back on '0001-01-01 00:00:00.0000000' if invalid value specified
			, IIF(
				  [Value] = ''
				, SYSDATETIME()
				, COALESCE(TRY_CAST([Value] AS datetime2(7)), '0001-01-01 00:00:00.0000000')
			  ) AS Information_Mart_Load_Effective_Datetime
		FROM
			[Meta_Metrics_Error_Mart].[meta].[Parameter]
		WHERE
			[ID] = 1  -- 1 = Information_Mart_Load_Effective_Datetime
	)


	/* Select Dimension columns from Data Vault tables */

	SELECT
		  sat_ht_region_northwind.[RegionID]
		, sat_hc_region_northwind.[RegionDescription]
	FROM
		CTE_Parameter AS parameter
			INNER JOIN [Data_Vault].[biz].[v_PIT_Region] AS pit_region
				ON parameter.[Information_Mart_Load_Effective_Datetime] BETWEEN pit_region.[DV_Snapshot_Datetime_Start] AND pit_region.[DV_Snapshot_Datetime_End]
			INNER JOIN [Data_Vault].[raw].[S_HC_Region_Northwind] AS sat_hc_region_northwind
				ON pit_region.[S_HC_Region_Northwind_HK_H_Region] = sat_hc_region_northwind.[HK_H_Region]
			   AND pit_region.[S_HC_Region_Northwind_DV_Load_Datetime] = sat_hc_region_northwind.[DV_Load_Datetime]
			INNER JOIN [Data_Vault].[raw].[S_HT_Region_Northwind] AS sat_ht_region_northwind
				ON pit_region.[S_HT_Region_Northwind_HK_H_Region] = sat_ht_region_northwind.[HK_H_Region]
			   AND pit_region.[S_HT_Region_Northwind_DV_Load_Datetime] = sat_ht_region_northwind.[DV_Load_Datetime]
	WHERE
		pit_region.[HK_H_Region] <> REPLICATE('0', 32)  -- Omit ghost record
		AND sat_ht_region_northwind.[DV_Deleted_Flag] = 0;  -- Omit deleted records
GO
/****** Object:  View [replica].[Northwind_Shippers]    Script Date: 5/01/2023 12:21:39 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [replica].[Northwind_Shippers]
AS   
	SELECT
		  sat_ht_shipper_northwind.[ShipperID]
		, sat_hc_shipper_northwind.[CompanyName]
		, sat_hc_shipper_northwind.[Phone]
	FROM
		[Data_Vault].[biz].[v_PIT_Shipper] AS pit_shipper
			INNER JOIN [Data_Vault].[raw].[S_HC_Shipper_Northwind] AS sat_hc_shipper_northwind
				ON pit_shipper.[S_HC_Shipper_Northwind_HK_H_Shipper] = sat_hc_shipper_northwind.[HK_H_Shipper]
			   AND pit_shipper.[S_HC_Shipper_Northwind_DV_Load_Datetime] = sat_hc_shipper_northwind.[DV_Load_Datetime]
			INNER JOIN [Data_Vault].[raw].[S_HT_Shipper_Northwind] AS sat_ht_shipper_northwind
				ON pit_shipper.[S_HT_Shipper_Northwind_HK_H_Shipper] = sat_ht_shipper_northwind.[HK_H_Shipper]
			   AND pit_shipper.[S_HT_Shipper_Northwind_DV_Load_Datetime] = sat_ht_shipper_northwind.[DV_Load_Datetime]
	WHERE
		[Meta_Metrics_Error_Mart].[meta].[Get_Information_Mart_Load_Effective_Datetime]() BETWEEN pit_shipper.[DV_Snapshot_Datetime_Start] AND pit_shipper.[DV_Snapshot_Datetime_End]
		AND pit_shipper.[HK_H_Shipper] <> REPLICATE('0', 32)  -- Omit ghost record
		AND sat_ht_shipper_northwind.[DV_Deleted_Flag] = 0;  -- Omit deleted records
GO
/****** Object:  View [replica].[Northwind_Suppliers]    Script Date: 5/01/2023 12:21:39 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [replica].[Northwind_Suppliers]
AS   
	SELECT
		  sat_ht_supplier_northwind.[SupplierID]
		, sat_hc_supplier_northwind.[CompanyName]
		, sat_hc_supplier_northwind.[ContactName]
		, sat_hc_supplier_northwind.[ContactTitle]
		, sat_hc_supplier_northwind.[Address]
		, sat_hc_supplier_northwind.[City]
		, sat_hc_supplier_northwind.[Region]
		, sat_hc_supplier_northwind.[PostalCode]
		, sat_hc_supplier_northwind.[Country]
		, sat_hc_supplier_northwind.[Phone]
		, sat_hc_supplier_northwind.[Fax]
		, sat_hc_supplier_northwind.[HomePage]
	FROM
		[Data_Vault].[biz].[v_PIT_Supplier] AS pit_supplier
			INNER JOIN [Data_Vault].[raw].[S_HC_Supplier_Northwind] AS sat_hc_supplier_northwind
				ON pit_supplier.[S_HC_Supplier_Northwind_HK_H_Supplier] = sat_hc_supplier_northwind.[HK_H_Supplier]
			   AND pit_supplier.[S_HC_Supplier_Northwind_DV_Load_Datetime] = sat_hc_supplier_northwind.[DV_Load_Datetime]
			INNER JOIN [Data_Vault].[raw].[S_HT_Supplier_Northwind] AS sat_ht_supplier_northwind
				ON pit_supplier.[S_HT_Supplier_Northwind_HK_H_Supplier] = sat_ht_supplier_northwind.[HK_H_Supplier]
			   AND pit_supplier.[S_HT_Supplier_Northwind_DV_Load_Datetime] = sat_ht_supplier_northwind.[DV_Load_Datetime]
	WHERE
		[Meta_Metrics_Error_Mart].[meta].[Get_Information_Mart_Load_Effective_Datetime]() BETWEEN pit_supplier.[DV_Snapshot_Datetime_Start] AND pit_supplier.[DV_Snapshot_Datetime_End]
		AND pit_supplier.[HK_H_Supplier] <> REPLICATE('0', 32)  -- Omit ghost record
		AND sat_ht_supplier_northwind.[DV_Deleted_Flag] = 0;  -- Omit deleted records
GO
/****** Object:  View [replica].[Northwind_Territories]    Script Date: 5/01/2023 12:21:39 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [replica].[Northwind_Territories]
AS   
	SELECT
		  sat_ht_territory_northwind.[TerritoryID]
		, sat_hc_territory_northwind.[TerritoryDescription]
		, sat_le_territory_region_northwind.[RegionID]
	FROM
		[Data_Vault].[biz].[v_PIT_Territory] AS pit_territory
			INNER JOIN [Data_Vault].[raw].[S_HC_Territory_Northwind] AS sat_hc_territory_northwind
				ON pit_territory.[S_HC_Territory_Northwind_HK_H_Territory] = sat_hc_territory_northwind.[HK_H_Territory]
			   AND pit_territory.[S_HC_Territory_Northwind_DV_Load_Datetime] = sat_hc_territory_northwind.[DV_Load_Datetime]
			INNER JOIN [Data_Vault].[raw].[S_HT_Territory_Northwind] AS sat_ht_territory_northwind
				ON pit_territory.[S_HT_Territory_Northwind_HK_H_Territory] = sat_ht_territory_northwind.[HK_H_Territory] 
			   AND pit_territory.[S_HT_Territory_Northwind_DV_Load_Datetime] = sat_ht_territory_northwind.[DV_Load_Datetime]
			INNER JOIN [Data_Vault].[raw].[L_Territory_Region] AS link_territory_region
				ON pit_territory.[HK_H_Territory] = link_territory_region.[HK_H_Territory]
			INNER JOIN [Data_Vault].[biz].[v_S_LE_Territory_Region_Northwind] AS sat_le_territory_region_northwind
				ON link_territory_region.[HK_L_Territory_Region] = sat_le_territory_region_northwind.[HK_L_Territory_Region]
	WHERE
		[Meta_Metrics_Error_Mart].[meta].[Get_Information_Mart_Load_Effective_Datetime]() BETWEEN pit_territory.[DV_Snapshot_Datetime_Start] AND pit_territory.[DV_Snapshot_Datetime_End]
		AND [Meta_Metrics_Error_Mart].[meta].[Get_Information_Mart_Load_Effective_Datetime]() BETWEEN sat_le_territory_region_northwind.[DV_Load_Datetime_Start] AND sat_le_territory_region_northwind.[DV_Load_Datetime_End]
		AND pit_territory.[HK_H_Territory] <> REPLICATE('0', 32)  -- Omit ghost record
		AND sat_ht_territory_northwind.[DV_Deleted_Flag] = 0;  -- Omit deleted records
GO
/****** Object:  View [star].[Bridge_Customer_Type]    Script Date: 5/01/2023 12:21:39 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [star].[Bridge_Customer_Type]
AS 
	WITH CTE_Customer_Type AS (
		SELECT 
			  link_customer_type.[HK_H_Customer]
			, link_customer_type.[HK_H_Customer_Type]
		FROM
			[Data_Vault].[raw].[L_Customer_Type] AS link_customer_type
				INNER JOIN [Data_Vault].[biz].[v_S_LT_Customer_Type_Northwind] AS sat_lt_customer_type_northwind
					ON link_customer_type.[HK_L_Customer_Type] = sat_lt_customer_type_northwind.[HK_L_Customer_Type]
		WHERE
			[Meta_Metrics_Error_Mart].[meta].[Get_Information_Mart_Load_Effective_Datetime]() BETWEEN sat_lt_customer_type_northwind.[DV_Load_Datetime_Start] AND sat_lt_customer_type_northwind.[DV_Load_Datetime_End]
			-- Filter out inactive link records
			AND sat_lt_customer_type_northwind.[DV_Deleted_Flag] = 0
	)


	SELECT 
		  [HK_H_Customer] AS Dim_Customer_Key
		, [HK_H_Customer_Type] AS Dim_Customer_Type_Key
	FROM
		CTE_Customer_Type

	UNION

	-- Add links to Dim_Customer_Type zero key record for customers without any active customer type mappings
	SELECT 
		  hub_customer.[HK_H_Customer] AS Dim_Customer_Key
		, REPLICATE('0', 32) AS Dim_Customer_Type_Key
	FROM
		[Data_Vault].[raw].[H_Customer] AS hub_customer
	WHERE
		NOT EXISTS (
			SELECT
				1
			FROM
				CTE_Customer_Type AS customer_type
			WHERE
				hub_customer.[HK_H_Customer] = customer_type.[HK_H_Customer]
		)
GO
/****** Object:  View [star].[Bridge_Employee_Territory]    Script Date: 5/01/2023 12:21:39 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [star].[Bridge_Employee_Territory]
AS 
	WITH CTE_Employee_Territory AS (
		SELECT
			  link_employee_territory.[HK_H_Employee]
			, link_employee_territory.[HK_H_Territory]
		FROM
			[Data_Vault].[raw].[L_Employee_Territory] AS link_employee_territory
				INNER JOIN [Data_Vault].[biz].[v_S_LT_Employee_Territory_Northwind] AS sat_lt_employee_territory_northwind
					ON link_employee_territory.[HK_L_Employee_Territory] = sat_lt_employee_territory_northwind.[HK_L_Employee_Territory]
		WHERE
			[Meta_Metrics_Error_Mart].[meta].[Get_Information_Mart_Load_Effective_Datetime]() BETWEEN sat_lt_employee_territory_northwind.[DV_Load_Datetime_Start] AND sat_lt_employee_territory_northwind.[DV_Load_Datetime_End]
			-- Filter out inactive link records
			AND sat_lt_employee_territory_northwind.[DV_Deleted_Flag] = 0
	)


	SELECT 
		  [HK_H_Employee] AS Dim_Employee_Key
		, [HK_H_Territory] AS Dim_Territory_Key
	FROM
		CTE_Employee_Territory

	UNION

	-- Add links to Dim_Territory zero key record for employees without any active territory mappings
	SELECT 
		  hub_employee.[HK_H_Employee] AS Dim_Employee_Key
		, REPLICATE('0', 32) AS Dim_Territory_Key
	FROM
		[Data_Vault].[raw].[H_Employee] AS hub_employee
	WHERE
		NOT EXISTS (
			SELECT
				1
			FROM
				CTE_Employee_Territory AS employee_territory
			WHERE
				hub_employee.[HK_H_Employee] = employee_territory.[HK_H_Employee]
		)
GO
/****** Object:  View [star].[Dim_Customer]    Script Date: 5/01/2023 12:21:39 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [star].[Dim_Customer]
AS   
	SELECT
		  pit_customer.[HK_H_Customer] AS Dim_Customer_Key
		, sat_ht_customer_northwind.[CustomerID] AS Customer_ID
		, ISNULL(sat_hc_customer_northwind.[CompanyName], 'Unknown') AS Customer_Company_Name
		, ISNULL(sat_hc_customer_northwind.[ContactName],'Unknown') AS Customer_Contact_Name
		, ISNULL(sat_hc_customer_northwind.[ContactTitle],'Unknown') AS Customer_Contact_Job_Title
		--, sat_hc_customer_northwind.[Address]
		, ISNULL(sat_hc_customer_northwind.[PostalCode],'?') AS Customer_Postal_Code
		, ISNULL(sat_hc_customer_northwind.[City],'Unknown') AS Customer_City
		, ISNULL(sat_hc_customer_northwind.[Region],'?') AS Customer_Region_Code
		, ISNULL(sat_hc_customer_northwind.[Country],'Unknown') Customer_Country
		--, sat_hc_customer_northwind.[Phone]
		--, sat_hc_customer_northwind.[Fax]
		, sat_ht_customer_northwind.[DV_Deleted_Flag] AS Customer_Deleted_Flag
	FROM
		[Data_Vault].[biz].[v_PIT_Customer] AS pit_customer
			INNER JOIN [Data_Vault].[raw].[S_HC_Customer_Northwind] AS sat_hc_customer_northwind
				ON pit_customer.[S_HC_Customer_Northwind_HK_H_Customer] = sat_hc_customer_northwind.[HK_H_Customer]
			   AND pit_customer.[S_HC_Customer_Northwind_DV_Load_Datetime] = sat_hc_customer_northwind.[DV_Load_Datetime]
			INNER JOIN [Data_Vault].[raw].[S_HT_Customer_Northwind] AS sat_ht_customer_northwind
				ON pit_customer.[S_HT_Customer_Northwind_HK_H_Customer] = sat_ht_customer_northwind.[HK_H_Customer]
			   AND pit_customer.[S_HT_Customer_Northwind_DV_Load_Datetime] = sat_ht_customer_northwind.[DV_Load_Datetime]
	WHERE
		[Meta_Metrics_Error_Mart].[meta].[Get_Information_Mart_Load_Effective_Datetime]() BETWEEN pit_customer.[DV_Snapshot_Datetime_Start] AND pit_customer.[DV_Snapshot_Datetime_End]
GO
/****** Object:  View [star].[Dim_Customer_Type]    Script Date: 5/01/2023 12:21:39 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [star].[Dim_Customer_Type]
AS   
	SELECT
			pit_customer_type.[HK_H_Customer_Type] AS Dim_Customer_Type_Key
		  , [CustomerTypeID] AS Customer_Type_ID
		  , ISNULL([CustomerDesc], 'Unknown') AS Customer_Type_Description
		  , [DV_Deleted_Flag] AS Customer_Type_Deleted_Flag
	FROM
		[Data_Vault].[biz].[v_PIT_Customer_Type] AS pit_customer_type
			INNER JOIN [Data_Vault].[raw].[S_HC_Customer_Type_Northwind] AS sat_hc_customer_type_northwind
				ON pit_customer_type.[S_HC_Customer_Type_Northwind_HK_H_Customer_Type] = sat_hc_customer_type_northwind.[HK_H_Customer_Type]
			   AND pit_customer_type.[S_HC_Customer_Type_Northwind_DV_Load_Datetime] = sat_hc_customer_type_northwind.[DV_Load_Datetime]
			INNER JOIN [Data_Vault].[raw].[S_HT_Customer_Type_Northwind] AS sat_ht_customer_type_northwind
				ON pit_customer_type.[S_HT_Customer_Type_Northwind_HK_H_Customer_Type] = sat_ht_customer_type_northwind.[HK_H_Customer_Type]
			   AND pit_customer_type.[S_HT_Customer_Type_Northwind_DV_Load_Datetime] = sat_ht_customer_type_northwind.[DV_Load_Datetime]
	WHERE
		[Meta_Metrics_Error_Mart].[meta].[Get_Information_Mart_Load_Effective_Datetime]() BETWEEN pit_customer_type.[DV_Snapshot_Datetime_Start] AND pit_customer_type.[DV_Snapshot_Datetime_End];
GO
/****** Object:  View [star].[Dim_Date]    Script Date: 5/01/2023 12:21:39 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [star].[Dim_Date]
AS   
	SELECT 
		  [Date_Key]
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
	FROM
		[Data_Vault].[raw].[R_Date];
GO
/****** Object:  View [star].[Dim_Employee]    Script Date: 5/01/2023 12:21:39 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [star].[Dim_Employee]
AS   
	SELECT
		  pit_employee.[HK_H_Employee] AS Dim_Employee_Key
		, link_employee_reporting_line.[HK_H_Employee_Manager] AS Dim_Manager_Key
		, sat_ht_employee_northwind.[EmployeeID] AS Employee_ID
		, CASE pit_employee.[HK_H_Employee]
			WHEN REPLICATE('0', 32) THEN 'Unknown'
			ELSE CONCAT_WS(
					  ' '
					, sat_gc_employee_northwind.[TitleOfCourtesy]
					, sat_gc_employee_northwind.[FirstName]
					, sat_gc_employee_northwind.[LastName]
				)
		  END AS Employee_Name
		, ISNULL(sat_gc_employee_northwind.[BirthDate], '1900-01-01') AS Employee_Birth_Date
		, ISNULL(sat_gc_employee_northwind.[HireDate], '1900-01-01') AS Employee_Hire_Date
		, ISNULL(sat_gc_employee_northwind.[Title], 'Unknown') AS Employee_Job_Title
		--, sat_gc_employee_northwind.[Address]
		, ISNULL(sat_gc_employee_northwind.[PostalCode], '?') AS Employee_Postal_Code
		, ISNULL(sat_gc_employee_northwind.[City], 'Unknown') AS Employee_City
		, ISNULL(sat_gc_employee_northwind.[Region], '?')  AS Employee_Region_Code
		, ISNULL(sat_gc_employee_northwind.[Country], 'Unknown') AS Employee_Country_Code
		--, sat_gc_employee_northwind.[HomePhone]
		--, sat_gc_employee_northwind.[Extension]
		--, sat_gc_employee_northwind.[Photo]
		--, sat_gc_employee_northwind.[Notes]
		--, sat_gc_employee_northwind.[PhotoPath]
		, sat_ht_employee_northwind.[DV_Deleted_Flag] AS Employee_Deleted_Flag
	FROM
		[Data_Vault].[biz].[v_PIT_Employee] AS pit_employee
			INNER JOIN [Data_Vault].[raw].[S_HC_Employee_Northwind] AS sat_gc_employee_northwind
				ON pit_employee.[S_HC_Employee_Northwind_HK_H_Employee] = sat_gc_employee_northwind.[HK_H_Employee]
			   AND pit_employee.[S_HC_Employee_Northwind_DV_Load_Datetime] = sat_gc_employee_northwind.[DV_Load_Datetime]
			INNER JOIN [Data_Vault].[raw].[S_HT_Employee_Northwind] AS sat_ht_employee_northwind
				ON pit_employee.[S_HT_Employee_Northwind_HK_H_Employee] = sat_ht_employee_northwind.[HK_H_Employee]
			   AND pit_employee.[S_HT_Employee_Northwind_DV_Load_Datetime] = sat_ht_employee_northwind.[DV_Load_Datetime]
			INNER JOIN [Data_Vault].[raw].[L_Employee_Reporting_Line] AS link_employee_reporting_line
				ON pit_employee.[HK_H_Employee] = link_employee_reporting_line.[HK_H_Employee]
			INNER JOIN [Data_Vault].[biz].[v_S_LE_Employee_Reporting_Line_Northwind] AS sat_le_employee_reporting_line_northwind
				ON link_employee_reporting_line.[HK_L_Employee_Reporting_Line] = sat_le_employee_reporting_line_northwind.[HK_L_Employee_Reporting_Line]
	WHERE
		[Meta_Metrics_Error_Mart].[meta].[Get_Information_Mart_Load_Effective_Datetime]() BETWEEN pit_employee.[DV_Snapshot_Datetime_Start] AND pit_employee.[DV_Snapshot_Datetime_End]
		AND [Meta_Metrics_Error_Mart].[meta].[Get_Information_Mart_Load_Effective_Datetime]() BETWEEN sat_le_employee_reporting_line_northwind.[DV_Load_Datetime_Start] AND sat_le_employee_reporting_line_northwind.[DV_Load_Datetime_End]

GO
/****** Object:  View [star].[Dim_Manager]    Script Date: 5/01/2023 12:21:39 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [star].[Dim_Manager]
AS   
	-- Select a distinct list of all manager keys
	WITH CTE_Managers AS (
		SELECT DISTINCT
			link_employee_reporting_line.[HK_H_Employee_Manager]
		FROM
			[Data_Vault].[raw].[L_Employee_Reporting_Line] AS link_employee_reporting_line
				INNER JOIN [Data_Vault].[biz].[v_S_LE_Employee_Reporting_Line_Northwind] AS sat_le_employee_reporting_line_northwind
					ON link_employee_reporting_line.[HK_L_Employee_Reporting_Line] = sat_le_employee_reporting_line_northwind.[HK_L_Employee_Reporting_Line]
		WHERE
			[Meta_Metrics_Error_Mart].[meta].[Get_Information_Mart_Load_Effective_Datetime]() BETWEEN sat_le_employee_reporting_line_northwind.[DV_Load_Datetime_Start] AND sat_le_employee_reporting_line_northwind.[DV_Load_Datetime_End]
	)

	SELECT
			pit_employee.[HK_H_Employee] AS Dim_Manager_Key
		, sat_ht_employee_northwind.[EmployeeID] AS Manager_ID
		, CASE pit_employee.[HK_H_Employee]
			WHEN REPLICATE('0', 32) THEN 'Unknown'
			ELSE CONCAT_WS(
						' '
					, sat_gc_employee_northwind.[TitleOfCourtesy]
					, sat_gc_employee_northwind.[FirstName]
					, sat_gc_employee_northwind.[LastName]
				)
			END AS Manager_Name
		, ISNULL(sat_gc_employee_northwind.[BirthDate], '1900-01-01') AS Manager_Birth_Date
		, ISNULL(sat_gc_employee_northwind.[HireDate], '1900-01-01') AS Manager_Hire_Date
		, ISNULL(sat_gc_employee_northwind.[Title], 'Unknown') AS Manager_Job_Title
		--, sat_gc_employee_northwind.[Address]
		, ISNULL(sat_gc_employee_northwind.[City], 'Unknown') AS Manager_City
		, ISNULL(sat_gc_employee_northwind.[Region], '?')  AS Manager_Region_Code
		, ISNULL(sat_gc_employee_northwind.[PostalCode], '?') AS Manager_Postal_Code
		, ISNULL(sat_gc_employee_northwind.[Country], 'Unknown') AS Manager_Country_Code
		--, sat_gc_employee_northwind.[HomePhone]
		--, sat_gc_employee_northwind.[Extension]
		--, sat_gc_employee_northwind.[Photo]
		--, sat_gc_employee_northwind.[Notes]
		--, sat_gc_employee_northwind.[PhotoPath]
		, sat_ht_employee_northwind.[DV_Deleted_Flag] AS Manager_Deleted_Flag
	FROM
		[Data_Vault].[biz].[v_PIT_Employee] AS pit_employee
			INNER JOIN [Data_Vault].[raw].[S_HC_Employee_Northwind] AS sat_gc_employee_northwind
				ON pit_employee.[S_HC_Employee_Northwind_HK_H_Employee] = sat_gc_employee_northwind.[HK_H_Employee]
				AND pit_employee.[S_HC_Employee_Northwind_DV_Load_Datetime] = sat_gc_employee_northwind.[DV_Load_Datetime]
			INNER JOIN [Data_Vault].[raw].[S_HT_Employee_Northwind] AS sat_ht_employee_northwind
				ON pit_employee.[S_HT_Employee_Northwind_HK_H_Employee] = sat_ht_employee_northwind.[HK_H_Employee]
				AND pit_employee.[S_HT_Employee_Northwind_DV_Load_Datetime] = sat_ht_employee_northwind.[DV_Load_Datetime]
			LEFT JOIN CTE_Managers AS cte_managers
				ON pit_employee.[HK_H_Employee] = cte_managers.[HK_H_Employee_Manager]
	WHERE
		[Meta_Metrics_Error_Mart].[meta].[Get_Information_Mart_Load_Effective_Datetime]() BETWEEN pit_employee.[DV_Snapshot_Datetime_Start] AND pit_employee.[DV_Snapshot_Datetime_End]
		-- Limit to only ghost record or employees who are managers
		AND (
			cte_managers.[HK_H_Employee_Manager] = REPLICATE('0', 32)
			OR cte_managers.[HK_H_Employee_Manager] IS NOT NULL
		)
GO
/****** Object:  View [star].[Dim_Order_Required_Date]    Script Date: 5/01/2023 12:21:39 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [star].[Dim_Order_Required_Date]
AS   
	SELECT 
		  [Date_Key] AS Dim_Order_Required_Date_Key
		, [Date] AS Order_Required_Date
		, [Datetime_Start] AS Order_Required_Date_Datetime_Start
		, [Datetime_End] AS Order_Required_Date_Datetime_End
		, [Day_Of_Month_Number] AS Order_Required_Date_Day_Of_Month_Number
		, [Month_Number] AS Order_Required_Date_Month_Number
		, [Month_Name] AS Order_Required_Date_Month_Name
		, [Year_Number] AS Order_Required_Date_Year_Number
		, [Day_Of_Week_Number] AS Order_Required_Date_Day_Of_Week_Number
		, [Day_Of_Week_Name] AS Order_Required_Date_Day_Of_Week_Name
		, [Quarter_Number] AS Order_Required_Date_Quarter_Number
		, [Quarter_Name] AS Order_Required_Date_Quarter_Name
		, [Sort_Order] AS Order_Required_Date_Sort_Order
	FROM
		[Data_Vault].[raw].[R_Date];
GO
/****** Object:  View [star].[Dim_Order_Shipped_Date]    Script Date: 5/01/2023 12:21:39 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [star].[Dim_Order_Shipped_Date]
AS   
	SELECT 
		  [Date_Key] AS Dim_Order_Shipped_Date_Key
		, [Date] AS Order_Shipped_Date
		, [Datetime_Start] AS Order_Shipped_Date_Datetime_Start
		, [Datetime_End] AS Order_Shipped_Date_Datetime_End
		, [Day_Of_Month_Number] AS Order_Shipped_Date_Day_Of_Month_Number
		, [Month_Number] AS Order_Shipped_Date_Month_Number
		, [Month_Name] AS Order_Shipped_Date_Month_Name
		, [Year_Number] AS Order_Shipped_Date_Year_Number
		, [Day_Of_Week_Number] AS Order_Shipped_Date_Day_Of_Week_Number
		, [Day_Of_Week_Name] AS Order_Shipped_Date_Day_Of_Week_Name
		, [Quarter_Number] AS Order_Shipped_Date_Quarter_Number
		, [Quarter_Name] AS Order_Shipped_Date_Quarter_Name
		, [Sort_Order] AS Order_Shipped_Date_Sort_Order
	FROM
		[Data_Vault].[raw].[R_Date];
GO
/****** Object:  View [star].[Dim_Order_Submitted_Date]    Script Date: 5/01/2023 12:21:39 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [star].[Dim_Order_Submitted_Date]
AS   
	SELECT 
		  [Date_Key] AS Dim_Order_Submitted_Date_Key
		, [Date] AS Order_Submitted_Date
		, [Datetime_Start] AS Order_Submitted_Date_Datetime_Start
		, [Datetime_End] AS Order_Submitted_Date_Datetime_End
		, [Day_Of_Month_Number] AS Order_Submitted_Date_Day_Of_Month_Number
		, [Month_Number] AS Order_Submitted_Date_Month_Number
		, [Month_Name] AS Order_Submitted_Date_Month_Name
		, [Year_Number] AS Order_Submitted_Date_Year_Number
		, [Day_Of_Week_Number] AS Order_Submitted_Date_Day_Of_Week_Number
		, [Day_Of_Week_Name] AS Order_Submitted_Date_Day_Of_Week_Name
		, [Quarter_Number] AS Order_Submitted_Date_Quarter_Number
		, [Quarter_Name] AS Order_Submitted_Date_Quarter_Name
		, [Sort_Order] AS Order_Submitted_Date_Sort_Order
	FROM
		[Data_Vault].[raw].[R_Date];
GO
/****** Object:  View [star].[Dim_Product]    Script Date: 5/01/2023 12:21:39 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [star].[Dim_Product]
AS   
	SELECT
		/* Product */
		  pit_product.[HK_H_Product] AS Dim_Product_Key
		, sat_ht_product_northwind.[ProductID] AS Product_ID
		, ISNULL(sat_hc_product_northwind.[ProductName], 'Unknown') AS Product_Name
		, ISNULL(sat_hc_product_northwind.[QuantityPerUnit], 'Unknown') AS Product_Quantity_Per_Unit
		, ISNULL(sat_hc_product_northwind.[UnitPrice], 0) AS Product_Unit_Price
		, ISNULL(sat_hc_product_northwind.[UnitsInStock], 0) AS Product_Units_In_Stock
		, ISNULL(sat_hc_product_northwind.[UnitsOnOrder], 0) AS Product_Units_On_Order
		, ISNULL(sat_hc_product_northwind.[ReorderLevel], 0) AS Product_Reorder_Level
		, ISNULL(sat_hc_product_northwind.[Discontinued], 0) AS Product_Discontinued_Flag
		, sat_ht_product_northwind.[DV_Deleted_Flag] AS Product_Deleted_Flag

		/* Supplier */
		--, pit_supplier.[HK_H_Supplier]
		, sat_ht_supplier_northwind.[SupplierID] AS Supplier_ID
		, ISNULL(sat_hc_supplier_northwind.[CompanyName], 'Unknown') AS Supplier_Name
		--, ISNULL(sat_hc_supplier_northwind.[ContactName], 'Unknown') AS Supplier_Contact_Name
		--, ISNULL(sat_hc_supplier_northwind.[ContactTitle], 'Unknown') AS Supplier_Contact_Title
		--, ISNULL(sat_hc_supplier_northwind.[Address], 'Unknown') AS Supplier_Address
		--, ISNULL(sat_hc_supplier_northwind.[City], 'Unknown') AS Supplier_City
		--, ISNULL(sat_hc_supplier_northwind.[Region], 'Unknown') AS Supplier_Region
		--, ISNULL(sat_hc_supplier_northwind.[PostalCode], '?') AS Supplier_Postal_Code
		, ISNULL(sat_hc_supplier_northwind.[Country], 'Unknown') AS Suppplier_Country
		--, ISNULL(sat_hc_supplier_northwind.[Phone], '?') AS Supplier_Phone
		--, ISNULL(sat_hc_supplier_northwind.[Fax], '?') AS Supplier_Fax
		--, ISNULL(sat_hc_supplier_northwind.[HomePage], 'Unknown') AS Supplier_Home_Page
		, sat_ht_supplier_northwind.[DV_Deleted_Flag] AS Supplier_Deleted_Flag

		/* Category */
		--, pit_product.[HK_H_Category]
		, sat_ht_product_category_northwind.[CategoryID] AS Category_ID
		, ISNULL(sat_hc_product_category_northwind.[CategoryName], 'Unknown') AS Category_Name
		, ISNULL(sat_hc_product_category_northwind.[Description], 'Unknown') AS Category_Description
		--, ISNULL(sat_hc_product_category_northwind.[Picture], 0x00000000) AS Category_Picture
		, sat_ht_product_category_northwind.[DV_Deleted_Flag] AS Category_Deleted_Flag
	FROM
		-- Product
		[Data_Vault].[biz].[v_PIT_Product] AS pit_product		 	  
			INNER JOIN [Data_Vault].[raw].[S_HC_Product_Northwind] AS sat_hc_product_northwind 
				ON pit_product.[S_HC_Product_Northwind_HK_H_Product] = sat_hc_product_northwind.[HK_H_Product]
			   AND pit_product.[S_HC_Product_Northwind_DV_Load_Datetime] = sat_hc_product_northwind.[DV_Load_Datetime]
			INNER JOIN [Data_Vault].[raw].[S_HT_Product_Northwind] AS sat_ht_product_northwind
				ON pit_product.[S_HT_Product_Northwind_HK_H_Product] = sat_ht_product_northwind.[HK_H_Product]
			   AND pit_product.[S_HT_Product_Northwind_DV_Load_Datetime] = sat_ht_product_northwind.[DV_Load_Datetime]

			-- Supplier
			INNER JOIN [Data_Vault].[raw].[L_Product_Supplier] AS link_product_supplier
				ON pit_product.[HK_H_Product] = link_product_supplier.[HK_H_Product]
			INNER JOIN [Data_Vault].[biz].[v_S_LE_Product_Supplier_Northwind] AS sat_le_product_supplier_northwind
				ON link_product_supplier.[HK_L_Product_Supplier] = sat_le_product_supplier_northwind.[HK_L_Product_Supplier]
			INNER JOIN [Data_Vault].[biz].[v_PIT_Supplier] AS pit_supplier
				ON link_product_supplier.[HK_H_Supplier] = pit_supplier.[HK_H_Supplier]
			INNER JOIN [Data_Vault].[raw].[S_HC_Supplier_Northwind] AS sat_hc_supplier_northwind
				ON pit_supplier.[S_HC_Supplier_Northwind_HK_H_Supplier] = sat_hc_supplier_northwind.[HK_H_Supplier]
			   AND pit_supplier.[S_HC_Supplier_Northwind_DV_Load_Datetime] = sat_hc_supplier_northwind.[DV_Load_Datetime]
			INNER JOIN [Data_Vault].[raw].[S_HT_Supplier_Northwind] AS sat_ht_supplier_northwind
				ON pit_supplier.[S_HT_Supplier_Northwind_HK_H_Supplier] = sat_ht_supplier_northwind.[HK_H_Supplier]
			   AND pit_supplier.[S_HT_Supplier_Northwind_DV_Load_Datetime] = sat_ht_supplier_northwind.[DV_Load_Datetime]

			-- Product Category
			INNER JOIN [Data_Vault].[raw].[L_Product_Category] AS link_product_category
				ON pit_product.[HK_H_Product] = link_product_category.[HK_H_Product]
			INNER JOIN [Data_Vault].[biz].[v_S_LE_Product_Category_Northwind] AS sat_le_product_category_northwind
				ON link_product_category.[HK_L_Product_Category] = sat_le_product_category_northwind.[HK_L_Product_Category]
			INNER JOIN [Data_Vault].[biz].[v_PIT_Product_Category] AS pit_product_category
				ON link_product_category.[HK_H_Product_Category] = pit_product_category.[HK_H_Product_Category]
			INNER JOIN [Data_Vault].[raw].[S_HC_Product_Category_Northwind] AS sat_hc_product_category_northwind
				ON pit_product_category.[S_HC_Product_Category_Northwind_HK_H_Product_Category] = sat_hc_product_category_northwind.[HK_H_Product_Category]
			   AND pit_product_category.[S_HC_Product_Category_Northwind_DV_Load_Datetime] = sat_hc_product_category_northwind.[DV_Load_Datetime]
			INNER JOIN [Data_Vault].[raw].[S_HT_Product_Category_Northwind] AS sat_ht_product_category_northwind
				ON pit_product_category.[S_HT_Product_Category_Northwind_HK_H_Product_Category] = sat_ht_product_category_northwind.[HK_H_Product_Category]
			   AND pit_product_category.[S_HT_Product_Category_Northwind_DV_Load_Datetime] = sat_ht_product_category_northwind.[DV_Load_Datetime]
	WHERE
		[Meta_Metrics_Error_Mart].[meta].[Get_Information_Mart_Load_Effective_Datetime]() BETWEEN pit_product.[DV_Snapshot_Datetime_Start] AND pit_product.[DV_Snapshot_Datetime_End]
		AND [Meta_Metrics_Error_Mart].[meta].[Get_Information_Mart_Load_Effective_Datetime]() BETWEEN sat_le_product_supplier_northwind.[DV_Load_Datetime_Start] AND sat_le_product_supplier_northwind.[DV_Load_Datetime_End]
		AND [Meta_Metrics_Error_Mart].[meta].[Get_Information_Mart_Load_Effective_Datetime]() BETWEEN pit_supplier.[DV_Snapshot_Datetime_Start] AND pit_supplier.[DV_Snapshot_Datetime_End]
		AND [Meta_Metrics_Error_Mart].[meta].[Get_Information_Mart_Load_Effective_Datetime]() BETWEEN sat_le_product_category_northwind.[DV_Load_Datetime_Start] AND sat_le_product_category_northwind.[DV_Load_Datetime_End]	
		AND [Meta_Metrics_Error_Mart].[meta].[Get_Information_Mart_Load_Effective_Datetime]() BETWEEN pit_product_category.[DV_Snapshot_Datetime_Start] AND pit_product_category.[DV_Snapshot_Datetime_End]
GO
/****** Object:  View [star].[Dim_Shipper]    Script Date: 5/01/2023 12:21:39 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [star].[Dim_Shipper]
AS   
	SELECT 
		  pit_shipper.[HK_H_Shipper] AS Dim_Shipper_Key
		, sat_ht_shipper_northwind.[ShipperID] AS Shipper_ID
		, ISNULL(sat_hc_shipper_northwind.[CompanyName], 'Unknown') AS Shipper_Name
		--, sat_hc_shipper_northwind.[Phone] AS Shipper_Phone
		, sat_ht_shipper_northwind.[DV_Deleted_Flag] AS Shipper_Deleted_Flag
	FROM
		[Data_Vault].[biz].[v_PIT_Shipper] AS pit_shipper
			INNER JOIN [Data_Vault].[raw].[S_HC_Shipper_Northwind] AS sat_hc_shipper_northwind
				ON pit_shipper.[S_HC_Shipper_Northwind_HK_H_Shipper] = sat_hc_shipper_northwind.[HK_H_Shipper]
			   AND pit_shipper.[S_HC_Shipper_Northwind_DV_Load_Datetime] = sat_hc_shipper_northwind.[DV_Load_Datetime]
			INNER JOIN [Data_Vault].[raw].[S_HT_Shipper_Northwind] AS sat_ht_shipper_northwind
				ON pit_shipper.[S_HT_Shipper_Northwind_HK_H_Shipper] = sat_ht_shipper_northwind.[HK_H_Shipper]
			   AND pit_shipper.[S_HT_Shipper_Northwind_DV_Load_Datetime] = sat_ht_shipper_northwind.[DV_Load_Datetime]
	WHERE
		[Meta_Metrics_Error_Mart].[meta].[Get_Information_Mart_Load_Effective_Datetime]() BETWEEN pit_shipper.[DV_Snapshot_Datetime_Start] AND pit_shipper.[DV_Snapshot_Datetime_End]

GO
/****** Object:  View [star].[Dim_Territory]    Script Date: 5/01/2023 12:21:39 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [star].[Dim_Territory]
AS   
	SELECT
		  pit_territory.[HK_H_Territory] AS Dim_Territory_Key
		, sat_ht_territory_northwind.[TerritoryID] AS Territory_ID
		, ISNULL(sat_hc_territory_northwind.[TerritoryDescription], 'Unknown') AS Territory_Description
		, sat_ht_territory_northwind.[DV_Deleted_Flag] AS Territory_Deleted_Flag
		, sat_ht_region_northwind.[RegionID] AS [Region_ID]
		, ISNULL(sat_hc_region_northwind.[RegionDescription], 'Unknown') AS Region_Description
		, sat_ht_region_northwind.[DV_Deleted_Flag] AS Region_Deleted_Flag
	FROM
		-- Territory
		[Data_Vault].[biz].[v_PIT_Territory] AS pit_territory
			INNER JOIN [Data_Vault].[raw].[S_HC_Territory_Northwind] AS sat_hc_territory_northwind
				ON pit_territory.[S_HC_Territory_Northwind_HK_H_Territory] = sat_hc_territory_northwind.[HK_H_Territory]
			   AND pit_territory.[S_HC_Territory_Northwind_DV_Load_Datetime] = sat_hc_territory_northwind.[DV_Load_Datetime]
			INNER JOIN [Data_Vault].[raw].[S_HT_Territory_Northwind] AS sat_ht_territory_northwind
				ON pit_territory.[S_HT_Territory_Northwind_HK_H_Territory] = sat_ht_territory_northwind.[HK_H_Territory]
			   AND pit_territory.[S_HT_Territory_Northwind_DV_Load_Datetime] = sat_ht_territory_northwind.[DV_Load_Datetime]

			-- Region
			INNER JOIN [Data_Vault].[raw].[L_Territory_Region] AS link_territory_region
				ON pit_territory.[HK_H_Territory] = link_territory_region.[HK_H_Territory]
			INNER JOIN [Data_Vault].[biz].[v_S_LE_Territory_Region_Northwind] AS sat_lke_territory_region_northwind
				ON link_territory_region.[HK_L_Territory_Region] = sat_lke_territory_region_northwind.[HK_L_Territory_Region]
			INNER JOIN [Data_Vault].[biz].[v_PIT_Region] AS pit_region
				ON link_territory_region.[HK_H_Region] = pit_region.[HK_H_Region]
			INNER JOIN [Data_Vault].[raw].[S_HC_Region_Northwind] AS sat_hc_region_northwind
				ON pit_region.[S_HC_Region_Northwind_HK_H_Region] = sat_hc_region_northwind.[HK_H_Region]
			   AND pit_region.[S_HC_Region_Northwind_DV_Load_Datetime] = sat_hc_region_northwind.[DV_Load_Datetime]			
			INNER JOIN [Data_Vault].[raw].[S_HT_Region_Northwind] AS sat_ht_region_northwind
				ON pit_region.[S_HT_Region_Northwind_HK_H_Region] = sat_ht_region_northwind.[HK_H_Region]
			   AND pit_region.[S_HT_Region_Northwind_DV_Load_Datetime] = sat_ht_region_northwind.[DV_Load_Datetime]
	WHERE
		[Meta_Metrics_Error_Mart].[meta].[Get_Information_Mart_Load_Effective_Datetime]() BETWEEN pit_territory.[DV_Snapshot_Datetime_Start] AND pit_territory.[DV_Snapshot_Datetime_End]
		AND [Meta_Metrics_Error_Mart].[meta].[Get_Information_Mart_Load_Effective_Datetime]() BETWEEN sat_lke_territory_region_northwind.[DV_Load_Datetime_Start] AND sat_lke_territory_region_northwind.[DV_Load_Datetime_End]
		AND [Meta_Metrics_Error_Mart].[meta].[Get_Information_Mart_Load_Effective_Datetime]() BETWEEN pit_region.[DV_Snapshot_Datetime_Start] AND pit_region.[DV_Snapshot_Datetime_End]
GO
/****** Object:  View [star].[Fact_Order]    Script Date: 5/01/2023 12:21:39 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [star].[Fact_Order]
AS
	SELECT 
		  bridge_order.[HK_H_Customer] AS Dim_Customer_Key
		, bridge_order.[HK_H_Employee] AS Dim_Employee_Key
		, bridge_order.[HK_H_Shipper] AS Dim_Shipper_Key
		, bridge_order.[Order_Submitted_Date_Key] AS Dim_Order_Submitted_Date_Key
		, bridge_order.[Order_Required_Date_Key] AS Dim_Order_Required_Date_Key
		, bridge_order.[Order_Shipped_Date_Key] AS Dim_Order_Shipped_Date_Key
		, hub_order.[DV_Business_Key] AS Order_ID
		, sat_hc_order_northwind.[Freight] AS Freight_Price
		, 1 AS Order_Count
		, sat_ht_order_northwind.[DV_Deleted_Flag] AS Order_Deleted_Flag
	FROM
		[Data_Vault].[biz].[v_B_Order] AS bridge_order
			INNER JOIN [Data_Vault].[raw].[H_Order] AS hub_order
				ON bridge_order.[HK_H_Order] = hub_order.[HK_H_Order]
			INNER JOIN [Data_Vault].[biz].[v_PIT_Order] AS pit_order
				ON bridge_order.[HK_H_Order] = pit_order.[HK_H_Order]
			INNER JOIN [Data_Vault].[raw].[S_HC_Order_Northwind] AS sat_hc_order_northwind
				ON pit_order.[S_HC_Order_Northwind_HK_H_Order] = sat_hc_order_northwind.[HK_H_Order]
			   AND pit_order.[S_HC_Order_Northwind_DV_Load_Datetime] = sat_hc_order_northwind.[DV_Load_Datetime]
			INNER JOIN [Data_Vault].[raw].[S_HT_Order_Northwind] AS sat_ht_order_northwind
				ON pit_order.[S_HT_Order_Northwind_HK_H_Order] = sat_ht_order_northwind.[HK_H_Order]
			   AND pit_order.[S_HT_Order_Northwind_DV_Load_Datetime] = sat_ht_order_northwind.[DV_Load_Datetime]
	WHERE
		[Meta_Metrics_Error_Mart].[meta].[Get_Information_Mart_Load_Effective_Datetime]() BETWEEN bridge_order.[DV_Snapshot_Datetime_Start] AND bridge_order.[DV_Snapshot_Datetime_End]
		AND [Meta_Metrics_Error_Mart].[meta].[Get_Information_Mart_Load_Effective_Datetime]() BETWEEN pit_order.[DV_Snapshot_Datetime_Start] AND pit_order.[DV_Snapshot_Datetime_End];
GO
/****** Object:  View [star].[Fact_Order_Detail]    Script Date: 5/01/2023 12:21:39 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [star].[Fact_Order_Detail]
AS
	SELECT
		  bridge_order_detail.[HK_H_Product] AS Dim_Product_Key
		, bridge_order_detail.[HK_H_Customer] AS Dim_Customer_Key
		, bridge_order_detail.[HK_H_Employee] AS Dim_Employee_Key
		, bridge_order_detail.[HK_H_Shipper] AS Dim_Shipper_Key
		, bridge_order_detail.[Order_Submitted_Date_Key] AS Dim_Order_Submitted_Date_Key
		, bridge_order_detail.[Order_Required_Date_Key] AS Dim_Order_Required_Date_Key
		, bridge_order_detail.[Order_Shipped_Date_Key] AS Dim_Order_Shipped_Date_Key
		, sat_ht_order_detail_northwind.[OrderID] AS Order_ID
		, sat_ht_order_detail_northwind.[ProductID] AS Product_ID
		, sat_hc_order_detail_northwind.[UnitPrice] AS Unit_Price
		, sat_hc_order_detail_northwind.[Quantity] AS Quantity
		, sat_hc_order_detail_northwind.[Discount] AS Discount
		, CAST((sat_hc_order_detail_northwind.[UnitPrice] * sat_hc_order_detail_northwind.[Quantity]) * (1 - sat_hc_order_detail_northwind.[Discount]) AS numeric(10, 2)) AS Total_Price
		, 1 AS Order_Detail_Count
		, sat_ht_order_detail_northwind.[DV_Deleted_Flag] AS Order_Detail_Deleted_Flag
	FROM
		[Data_Vault].[biz].[v_B_Order_Detail] AS bridge_order_detail
			INNER JOIN [Data_Vault].[raw].[H_Order_Detail] AS hub_order_detail
				ON bridge_order_detail.[HK_H_Order_Detail] = hub_order_detail.[HK_H_Order_Detail]
			INNER JOIN [Data_Vault].[biz].[v_PIT_Order_Detail] AS pit_order_detail
				ON bridge_order_detail.[HK_H_Order_Detail] = pit_order_detail.[HK_H_Order_Detail]
			INNER JOIN [Data_Vault].[raw].[S_HC_Order_Detail_Northwind] AS sat_hc_order_detail_northwind
				ON pit_order_detail.[S_HC_Order_Detail_Northwind_HK_H_Order_Detail] = sat_hc_order_detail_northwind.[HK_H_Order_Detail]
			   AND pit_order_detail.[S_HC_Order_Detail_Northwind_DV_Load_Datetime] = sat_hc_order_detail_northwind.[DV_Load_Datetime]	
			INNER JOIN [Data_Vault].[raw].[S_HT_Order_Detail_Northwind] AS sat_ht_order_detail_northwind
				ON pit_order_detail.[S_HT_Order_Detail_Northwind_HK_H_Order_Detail] = sat_ht_order_detail_northwind.[HK_H_Order_Detail]
			   AND pit_order_detail.[S_HT_Order_Detail_Northwind_DV_Load_Datetime] = sat_ht_order_detail_northwind.[DV_Load_Datetime]
	WHERE
		[Meta_Metrics_Error_Mart].[meta].[Get_Information_Mart_Load_Effective_Datetime]() BETWEEN bridge_order_detail.[DV_Snapshot_Datetime_Start] AND bridge_order_detail.[DV_Snapshot_Datetime_End]
		AND [Meta_Metrics_Error_Mart].[meta].[Get_Information_Mart_Load_Effective_Datetime]() BETWEEN pit_order_detail.[DV_Snapshot_Datetime_Start] AND pit_order_detail.[DV_Snapshot_Datetime_End];
GO
USE [master]
GO
ALTER DATABASE [Information_Mart] SET  READ_WRITE 
GO
