/*
	
	Create Database Meta_Metrics_Error_Mart.sql

	Create database Meta_Metrics_Error_Mart. 
	Combined database for data warehouse metadata, metrics, and error data.


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

EXECUTE(
		N'CREATE DATABASE [Meta_Metrics_Error_Mart]
			ON PRIMARY 
				(
					  NAME = N''MetaMetricsErrorMart''
					, FILENAME = N''' + @device_directory + N'MetaMetricsErrorMart.mdf''
					, SIZE = 512KB 
					, MAXSIZE = UNLIMITED
					, FILEGROWTH = 1024KB 
				  )
				, FILEGROUP [DATA] (
					  NAME = N''MetaMetricsErrorMart_data''
					, FILENAME = N''' + @device_directory + N'MetaMetricsErrorMart_data.ndf'' 
					, SIZE = 512KB 
					, MAXSIZE = UNLIMITED
					, FILEGROWTH = 10%
				  )
				, FILEGROUP [INDEX] (
					  NAME = N''MetaMetricsErrorMart_index''
					, FILENAME = N''' + @device_directory + N'MetaMetricsErrorMart_index.ndf''
					, SIZE = 512KB
					, MAXSIZE = UNLIMITED
					, FILEGROWTH = 10%
				  )
			LOG ON (
				  NAME = N''MetaMetricsErrorMart_log''
				, FILENAME = N''' + @device_directory + N'MetaMetricsErrorMart_log.ldf'' 
				, SIZE = 512KB 
				, MAXSIZE = 2048GB 
				, FILEGROWTH = 10%
			)
			WITH
				CATALOG_COLLATION = DATABASE_DEFAULT;'
	);
GO

ALTER DATABASE [Meta_Metrics_Error_Mart] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Meta_Metrics_Error_Mart].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Meta_Metrics_Error_Mart] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Meta_Metrics_Error_Mart] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Meta_Metrics_Error_Mart] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Meta_Metrics_Error_Mart] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Meta_Metrics_Error_Mart] SET ARITHABORT OFF 
GO
ALTER DATABASE [Meta_Metrics_Error_Mart] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Meta_Metrics_Error_Mart] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Meta_Metrics_Error_Mart] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Meta_Metrics_Error_Mart] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Meta_Metrics_Error_Mart] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Meta_Metrics_Error_Mart] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Meta_Metrics_Error_Mart] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Meta_Metrics_Error_Mart] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Meta_Metrics_Error_Mart] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Meta_Metrics_Error_Mart] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Meta_Metrics_Error_Mart] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Meta_Metrics_Error_Mart] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Meta_Metrics_Error_Mart] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Meta_Metrics_Error_Mart] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Meta_Metrics_Error_Mart] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Meta_Metrics_Error_Mart] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Meta_Metrics_Error_Mart] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Meta_Metrics_Error_Mart] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Meta_Metrics_Error_Mart] SET  MULTI_USER 
GO
ALTER DATABASE [Meta_Metrics_Error_Mart] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Meta_Metrics_Error_Mart] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Meta_Metrics_Error_Mart] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Meta_Metrics_Error_Mart] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Meta_Metrics_Error_Mart] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Meta_Metrics_Error_Mart] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Meta_Metrics_Error_Mart] SET QUERY_STORE = OFF
GO
USE [Meta_Metrics_Error_Mart]
GO
/****** Object:  Schema [error]    Script Date: 5/01/2023 1:18:27 pm ******/
CREATE SCHEMA [error]
GO
/****** Object:  Schema [meta]    Script Date: 5/01/2023 1:18:27 pm ******/
CREATE SCHEMA [meta]
GO
/****** Object:  Schema [metrics]    Script Date: 5/01/2023 1:18:27 pm ******/
CREATE SCHEMA [metrics]
GO
/****** Object:  UserDefinedFunction [meta].[Get_Information_Mart_Load_Effective_Datetime]    Script Date: 5/01/2023 1:18:27 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [meta].[Get_Information_Mart_Load_Effective_Datetime]() 
RETURNS datetime2 
AS 
BEGIN 

    DECLARE @Information_Mart_Load_Effective_Datetime datetime2 

    SET @Information_Mart_Load_Effective_Datetime = (
		SELECT 
			IIF(
				  [Value] = ''
				, SYSDATETIME()
				, COALESCE(TRY_CAST([Value] AS datetime2(7)), '0001-01-01 00:00:00.0000000')
			) AS Information_Mart_Load_Effective_Datetime
		FROM
			[Meta_Metrics_Error_Mart].[meta].[Parameter]
		WHERE
			[ID] = 1  -- 1 = Information_Mart_Load_Effective_Datetime 
		)

    RETURN @Information_Mart_Load_Effective_Datetime 
END


GO
/****** Object:  Table [error].[Error_Log]    Script Date: 5/01/2023 1:18:27 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [error].[Error_Log](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Error_Datetime] [datetime2](7) NULL,
	[Error_Procedure] [nvarchar](128) NULL,
	[Error_Number] [int] NULL,
	[Error_Severity] [int] NULL,
	[Error_State] [int] NULL,
	[Error_Line] [int] NULL,
	[Error_Message] [nvarchar](4000) NULL,
 CONSTRAINT [PK_Error_Log] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO
/****** Object:  Table [meta].[Parameter]    Script Date: 5/01/2023 1:18:27 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [meta].[Parameter](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Description] [varchar](500) NOT NULL,
	[Value] [varchar](100) NULL,
 CONSTRAINT [PK_DV_Parameters] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [INDEX]
) ON [INDEX]
GO

SET IDENTITY_INSERT [meta].[Parameter] ON 
GO
INSERT [meta].[Parameter] ([ID], [Name], [Description], [Value]) VALUES (1, N'Information_Mart_Load_Effective_Datetime', N'Datetime value used to set the "as at" effective datetime for Information Mart tables. A blank value will return the most up to date data in Facts and Dimensions.', N'')
GO
SET IDENTITY_INSERT [meta].[Parameter] OFF
GO
USE [master]
GO
ALTER DATABASE [Meta_Metrics_Error_Mart] SET  READ_WRITE 
GO
