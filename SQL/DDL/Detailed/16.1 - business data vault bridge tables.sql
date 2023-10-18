/*

	Business data vault bridge tables

*/


USE Information_Mart;
GO


-- B_Customer_Type

DROP TABLE IF EXISTS bv.B_Customer_Type;
GO

CREATE TABLE bv.B_Customer_Type (
	  DV_Sequence_Number bigint identity(1,1) NOT NULL 
	, DV_Snapshot_Datetime datetimeoffset(7) NOT NULL
	, HK_L_Customer_Type binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, HK_H_Customer binary(32) NOT NULL
	, HK_H_Customer_Type binary(32) NOT NULL
	, CustomerID nchar(5) NOT NULL
	, CustomerTypeID nchar(10) NOT NULL
	, CONSTRAINT PK_B_Customer_Type  PRIMARY KEY CLUSTERED (DV_Sequence_Number) ON [INDEX]
	, CONSTRAINT UK_B_Customer_Type UNIQUE NONCLUSTERED (DV_Snapshot_Datetime, HK_L_Customer_Type) ON [INDEX]
) ON [DATA];
GO




-- B_Employee_Reporting_Line

DROP TABLE IF EXISTS bv.B_Employee_Reporting_Line;
GO

CREATE TABLE bv.B_Employee_Reporting_Line (
	  DV_Sequence_Number bigint identity(1,1) NOT NULL 
	, DV_Snapshot_Datetime datetimeoffset(7) NOT NULL
	, HK_L_Employee_Reporting_Line binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, HK_H_Employee__Direct_Report binary(32) NOT NULL
	, HK_H_Employee__Manager binary(32) NOT NULL
	, EmployeeID__Direct_Report int NOT NULL
	, EmployeeID__Manager int NOT NULL
	, CONSTRAINT PK_B_Employee_Reporting_Line PRIMARY KEY CLUSTERED (DV_Sequence_Number) ON [INDEX]
	, CONSTRAINT UK_B_Employee_Reporting_Line UNIQUE NONCLUSTERED (DV_Snapshot_Datetime, HK_H_Employee__Direct_Report) ON [INDEX]
) ON [DATA];
GO




-- B_Employee_Territory

DROP TABLE IF EXISTS bv.B_Employee_Territory;
GO
CREATE TABLE bv.B_Employee_Territory (
	  DV_Sequence_Number bigint identity(1,1) NOT NULL 
	, DV_Snapshot_Datetime datetimeoffset(7) NOT NULL
	, HK_L_Employee_Territory binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, HK_H_Employee binary(32) NOT NULL
	, HK_H_Territory binary(32) NOT NULL
	, EmployeeID int NOT NULL
	, TerritoryID nvarchar(20) NOT NULL
	, CONSTRAINT PK_B_Employee_Territory PRIMARY KEY CLUSTERED (DV_Sequence_Number) ON [INDEX]
	, CONSTRAINT UK_B_Employee_Territory UNIQUE NONCLUSTERED (DV_Snapshot_Datetime, HK_L_Employee_Territory) ON [INDEX]
) ON [DATA];
GO




-- B_Order

DROP TABLE IF EXISTS bv.B_Order;
GO

CREATE TABLE bv.B_Order (
	  DV_Sequence_Number bigint identity(1,1) NOT NULL 
	, DV_Snapshot_Datetime datetimeoffset(7) NOT NULL
	, HK_L_Order_Header binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, HK_H_Order binary(32) NOT NULL
	, HK_H_Customer binary(32) NOT NULL
	, HK_H_Employee binary(32) NOT NULL
	, HK_H_Shipper binary(32) NOT NULL
	, Date_Key__OrderDate int NOT NULL
	, Date_Key__RequiredDate int NOT NULL
	, Date_Key__ShippedDate int NOT NULL
	, OrderID int NOT NULL
	, Is_Deleted_Flag bit NULL
	, Freight decimal(19,4) NULL  -- money -> decimal
	, Order_Count int NULL
	, CONSTRAINT PK_B_Order PRIMARY KEY CLUSTERED (DV_Sequence_Number) ON [INDEX]
	, CONSTRAINT UK_B_Order UNIQUE NONCLUSTERED (DV_Snapshot_Datetime, HK_H_Order) ON [INDEX]
) ON [DATA];




-- B_Order_Detail

DROP TABLE IF EXISTS bv.B_Order_Detail;
GO

CREATE TABLE bv.B_Order_Detail (
	  DV_Sequence_Number bigint identity(1,1) NOT NULL 
	, DV_Snapshot_Datetime datetimeoffset(7) NOT NULL
	, HK_L_Order_Detail binary(32) NOT NULL
	, HK_L_Order_Header binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, HK_H_Customer binary(32) NOT NULL
	, HK_H_Employee binary(32) NOT NULL
	, HK_H_Shipper binary(32) NOT NULL
	, HK_H_Product binary(32) NOT NULL
	, Date_Key__OrderDate int NOT NULL
	, Date_Key__RequiredDate int NOT NULL
	, Date_Key__ShippedDate int NOT NULL
	, OrderID int NOT NULL
	, ProductID int NOT NULL
	, Is_Deleted_Flag bit NULL
	, UnitPrice decimal(19,4) NULL  -- money -> decimal
	, Quantity smallint NULL
	, Discount real NULL
	, Total_Price decimal(19,4) NULL
	, Order_Detail_Count int NULL
	, CONSTRAINT PK_B_Order_Detail PRIMARY KEY CLUSTERED (DV_Sequence_Number) ON [INDEX]
	, CONSTRAINT UK_B_Order_Detail UNIQUE NONCLUSTERED (DV_Snapshot_Datetime, HK_L_Order_Detail) ON [INDEX]
) ON [DATA];
GO




-- B_Product_Supplier_Category

DROP TABLE IF EXISTS bv.B_Product_Supplier_Category;
GO

CREATE TABLE bv.B_Product_Supplier_Category (
	  DV_Sequence_Number bigint identity(1,1) NOT NULL 
	, DV_Snapshot_Datetime datetimeoffset(7) NOT NULL
	, HK_L_Product_Supplier binary(32) NOT NULL
	, HK_L_Product_Category binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, HK_H_Product binary(32) NOT NULL
	, HK_H_Supplier binary(32) NOT NULL
	, HK_H_Product_Category binary(32) NOT NULL
	, ProductID int NOT NULL
	, SupplierID int NOT NULL
	, CategoryID int NOT NULL
	, CONSTRAINT PK_B_Product_Supplier_Category PRIMARY KEY CLUSTERED (DV_Sequence_Number) ON [INDEX]
	, CONSTRAINT UK_B_Product_Supplier_Category UNIQUE NONCLUSTERED (DV_Snapshot_Datetime, HK_H_Product) ON [INDEX]
) ON [DATA];
GO




-- B_Territory_Region

DROP TABLE IF EXISTS bv.B_Territory_Region;
GO

CREATE TABLE bv.B_Territory_Region (
	  DV_Sequence_Number bigint identity(1,1) NOT NULL
	, DV_Snapshot_Datetime datetimeoffset(7) NOT NULL
	, HK_L_Territory_Region binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, HK_H_Territory binary(32) NOT NULL
	, HK_H_Region binary(32) NOT NULL
	, TerritoryID nvarchar(20) NOT NULL
	, RegionID int NOT NULL
	, CONSTRAINT PK_B_Territory_Region PRIMARY KEY CLUSTERED (DV_Sequence_Number) ON [INDEX]
	, CONSTRAINT UK_B_Territory_Region UNIQUE NONCLUSTERED (DV_Snapshot_Datetime, HK_H_Territory) ON [INDEX]
) ON [DATA];
GO