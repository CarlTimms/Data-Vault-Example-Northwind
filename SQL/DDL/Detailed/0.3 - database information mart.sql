/*

	Create database Information_Mart

*/


USE [master]
GO

/****** Object:  Database [Information_Mart]    Script Date: 21/09/2023 8:42:11 pm ******/
CREATE DATABASE [Information_Mart]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'InformationMart', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.DATAWAREHOUSE\MSSQL\DATA\InformationMart.mdf' , SIZE = 87040KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [DATA] 
( NAME = N'InformationMart_data', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.DATAWAREHOUSE\MSSQL\DATA\InformationMart_data.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%), 
 FILEGROUP [INDEX] 
( NAME = N'InformationMart_index', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.DATAWAREHOUSE\MSSQL\DATA\InformationMart_index.ndf' , SIZE = 90432KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 LOG ON 
( NAME = N'InformationMart_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.DATAWAREHOUSE\MSSQL\DATA\InformationMart_log.ldf' , SIZE = 213568KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
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

ALTER DATABASE [Information_Mart] SET  READ_WRITE 
GO