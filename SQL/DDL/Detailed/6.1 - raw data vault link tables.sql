/*

	Raw data vault link tables

*/


USE Data_Vault;
GO


-- L_Customer_Type

DROP TABLE IF EXISTS rv.L_Customer_Type;
GO

CREATE TABLE rv.L_Customer_Type (
	  HK_L_Customer_Type binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(55) NOT NULL
	, HK_H_Customer binary(32) NOT NULL
	, HK_H_Customer_Type binary(32) NOT NULL
	, CONSTRAINT PK_L_Customer_Type PRIMARY KEY NONCLUSTERED (HK_L_Customer_Type) ON [INDEX]
) ON [DATA];
GO




-- L_Employee_Reporting_Line

DROP TABLE IF EXISTS rv.L_Employee_Reporting_Line;
GO

CREATE TABLE rv.L_Employee_Reporting_Line (
	  HK_L_Employee_Reporting_Line binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(55) NOT NULL
	, HK_H_Employee__Direct_Report__DK binary(32) NOT NULL
	, HK_H_Employee__Manager binary(32) NOT NULL
	, CONSTRAINT PK_L_Employee_Reporting_Line PRIMARY KEY NONCLUSTERED (HK_L_Employee_Reporting_Line) ON [INDEX]
) ON [DATA];
GO




-- L_Employee_Territory

DROP TABLE IF EXISTS rv.L_Employee_Territory;
GO

CREATE TABLE rv.L_Employee_Territory (
	  HK_L_Employee_Territory binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(55) NOT NULL
	, HK_H_Employee binary(32) NOT NULL
	, HK_H_Territory binary(32) NOT NULL
	, CONSTRAINT PK_L_Employee_Territory PRIMARY KEY NONCLUSTERED (HK_L_Employee_Territory) ON [INDEX]
) ON [DATA];
GO




-- L_Order_Detail

DROP TABLE IF EXISTS rv.L_Order_Detail;
GO

CREATE TABLE rv.L_Order_Detail (
	  HK_L_Order_Detail binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(55) NOT NULL
	, HK_H_Order binary(32) NOT NULL
	, HK_H_Product binary(32) NOT NULL
	, CONSTRAINT PK_L_Order_Detail PRIMARY KEY NONCLUSTERED (HK_L_Order_Detail) ON [INDEX]
) ON [DATA];
GO




-- L_Order_Header

DROP TABLE IF EXISTS rv.L_Order_Header;
GO

CREATE TABLE rv.L_Order_Header (
	  HK_L_Order_Header binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(55) NOT NULL
	, HK_H_Order__DK binary(32) NOT NULL
	, HK_H_Customer binary(32) NOT NULL
	, HK_H_Employee binary(32) NOT NULL
	, HK_H_Shipper binary(32) NOT NULL
	, CONSTRAINT PK_L_Order_Header PRIMARY KEY NONCLUSTERED (HK_L_Order_Header) ON [INDEX]
) ON [DATA];
GO




-- L_Product_Category

DROP TABLE IF EXISTS rv.L_Product_Category;
GO

CREATE TABLE rv.L_Product_Category (
	  HK_L_Product_Category binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(55) NOT NULL
	, HK_H_Product__DK binary(32) NOT NULL
	, HK_H_Product_Category binary(32) NOT NULL
	, CONSTRAINT PK_L_Product_Category PRIMARY KEY NONCLUSTERED (HK_L_Product_Category) ON [INDEX]
) ON [DATA];
GO




-- L_Product_Supplier

DROP TABLE IF EXISTS rv.L_Product_Supplier;
GO

CREATE TABLE rv.L_Product_Supplier (
	  HK_L_Product_Supplier binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(55) NOT NULL
	, HK_H_Product__DK binary(32) NOT NULL
	, HK_H_Supplier binary(32) NOT NULL
	, CONSTRAINT PK_L_Product_Supplier PRIMARY KEY NONCLUSTERED (HK_L_Product_Supplier) ON [INDEX]
) ON [DATA];
GO




-- L_Territory_Region

DROP TABLE IF EXISTS rv.L_Territory_Region;
GO

CREATE TABLE rv.L_Territory_Region (
	  HK_L_Territory_Region binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(55) NOT NULL
	, HK_H_Territory__DK binary(32) NOT NULL
	, HK_H_Region binary(32) NOT NULL
	, CONSTRAINT PK_L_Territory_Region PRIMARY KEY NONCLUSTERED (HK_L_Territory_Region) ON [INDEX]
) ON [DATA];
GO