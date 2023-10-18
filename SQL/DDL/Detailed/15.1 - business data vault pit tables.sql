/*

	Business data vault PIT tables

*/


USE Information_Mart;
GO


/* Hub PITs*/

-- PIT_Customer

DROP TABLE IF EXISTS bv.PIT_Customer;
GO

CREATE TABLE bv.PIT_Customer (
	  DV_Sequence_Number bigint identity(1,1) NOT NULL
	, DV_Snapshot_Datetime datetimeoffset(7) NOT NULL
	, HK_H_Customer binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, HK_H_Customer__S_H_Customer_Northwind binary(32) NOT NULL
	, DV_Load_Datetime__S_H_Customer_Northwind datetimeoffset(7) NOT NULL
	, HK_H_Customer__S_HDT_H_Customer_Northwind binary(32) NOT NULL
	, DV_Load_Datetime__S_HDT_H_Customer_Northwind datetimeoffset(7) NOT NULL
	, CustomerID nchar(5) NOT NULL
	, Is_Deleted_Flag bit NULL
	, CONSTRAINT PK_PIT_Customer PRIMARY KEY CLUSTERED (DV_Sequence_Number)	ON [INDEX]
	, CONSTRAINT UK_PIT_Customer UNIQUE NONCLUSTERED (DV_Snapshot_Datetime, HK_H_Customer) ON [INDEX]	
) ON [DATA];
GO




-- PIT_Customer_Type

DROP TABLE IF EXISTS Information_Mart.bv.PIT_Customer_Type;
GO

CREATE TABLE bv.PIT_Customer_Type (
	  DV_Sequence_Number bigint identity(1,1) NOT NULL
	, DV_Snapshot_Datetime datetimeoffset(7) NOT NULL
	, HK_H_Customer_Type binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, HK_H_Customer_Type__S_H_Customer_Type_Northwind binary(32) NOT NULL
	, DV_Load_Datetime__S_H_Customer_Type_Northwind datetimeoffset(7) NOT NULL
	, HK_H_Customer_Type__S_HDT_H_Customer_Type_Northwind binary(32) NOT NULL
	, DV_Load_Datetime__S_HDT_H_Customer_Type_Northwind datetimeoffset(7) NOT NULL
	, CustomerTypeID nchar(10) NOT NULL
	, Is_Deleted_Flag bit NULL
	, CONSTRAINT PK_PIT_Customer_Type PRIMARY KEY CLUSTERED (DV_Sequence_Number) ON [INDEX]	
	, CONSTRAINT UK_PIT_Customer_Type UNIQUE NONCLUSTERED (DV_Snapshot_Datetime, HK_H_Customer_Type) ON [INDEX]	
) ON [DATA];
GO




-- PIT_Employee

DROP TABLE IF EXISTS Information_Mart.bv.PIT_Employee;
GO

CREATE TABLE bv.PIT_Employee (
	  DV_Sequence_Number bigint identity(1,1) NOT NULL
	, DV_Snapshot_Datetime datetimeoffset(7) NOT NULL
	, HK_H_Employee binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, HK_H_Employee__S_H_Employee_Northwind binary(32) NOT NULL
	, DV_Load_Datetime__S_H_Employee_Northwind datetimeoffset(7) NOT NULL
	, HK_H_Employee__S_HDT_H_Employee_Northwind binary(32) NOT NULL
	, DV_Load_Datetime__S_HDT_H_Employee_Northwind datetimeoffset(7) NOT NULL
	, EmployeeID int NOT NULL
	, Employee_Name varchar(64) NULL 
	, Is_Deleted_Flag bit NULL
	, CONSTRAINT PK_PIT_Employee PRIMARY KEY CLUSTERED (DV_Sequence_Number) ON [INDEX]	
	, CONSTRAINT UK_PIT_Employee UNIQUE NONCLUSTERED (DV_Snapshot_Datetime, HK_H_Employee) ON [INDEX]	
) ON [DATA];
GO




-- PIT_Order

DROP TABLE IF EXISTS Information_Mart.bv.PIT_Order;
GO

CREATE TABLE bv.PIT_Order (
	  DV_Sequence_Number bigint identity(1,1) NOT NULL
	, DV_Snapshot_Datetime datetimeoffset(7) NOT NULL
	, HK_H_Order binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, HK_H_Order__S_H_Order_Northwind binary(32) NOT NULL
	, DV_Load_Datetime__S_H_Order_Northwind datetimeoffset(7) NOT NULL
	, HK_H_Order__S_HDT_H_Order_Northwind binary(32) NOT NULL
	, DV_Load_Datetime__S_HDT_H_Order_Northwind datetimeoffset(7) NOT NULL
	, OrderID int NOT NULL
	, Is_Deleted_Flag bit NULL
	, CONSTRAINT PK_PIT_Order PRIMARY KEY CLUSTERED (DV_Sequence_Number) ON [INDEX]	
	, CONSTRAINT UK_PIT_Order UNIQUE NONCLUSTERED (DV_Snapshot_Datetime, HK_H_Order) ON [INDEX]	
) ON [DATA];
GO




-- PIT_Product

DROP TABLE IF EXISTS Information_Mart.bv.PIT_Product;
GO

CREATE TABLE bv.PIT_Product (
	  DV_Sequence_Number bigint identity(1,1) NOT NULL
	, DV_Snapshot_Datetime datetimeoffset(7) NOT NULL
	, HK_H_Product binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, HK_H_Product__S_H_Product_Northwind binary(32) NOT NULL
	, DV_Load_Datetime__S_H_Product_Northwind datetimeoffset(7) NOT NULL
	, HK_H_Product__S_HDT_H_Product_Northwind binary(32) NOT NULL
	, DV_Load_Datetime__S_HDT_H_Product_Northwind datetimeoffset(7) NOT NULL
	, ProductID int NOT NULL
	, Is_Deleted_Flag bit NULL
	, CONSTRAINT PK_PIT_Product PRIMARY KEY CLUSTERED (DV_Sequence_Number) ON [INDEX]	
	, CONSTRAINT UK_PIT_Product UNIQUE NONCLUSTERED (DV_Snapshot_Datetime, HK_H_Product) ON [INDEX]	
) ON [DATA];
GO




-- PIT_Product_Category

DROP TABLE IF EXISTS Information_Mart.bv.PIT_Product_Category;
GO

CREATE TABLE bv.PIT_Product_Category (
	  DV_Sequence_Number bigint identity(1,1) NOT NULL
	, DV_Snapshot_Datetime datetimeoffset(7) NOT NULL
	, HK_H_Product_Category binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, HK_H_Product_Category__S_H_Product_Category_Northwind binary(32) NOT NULL
	, DV_Load_Datetime__S_H_Product_Category_Northwind datetimeoffset(7) NOT NULL
	, HK_H_Product_Category__S_HDT_H_Product_Category_Northwind binary(32) NOT NULL
	, DV_Load_Datetime__S_HDT_H_Product_Category_Northwind datetimeoffset(7) NOT NULL
	, CategoryID int NOT NULL
	, Is_Deleted_Flag bit NULL
	, CONSTRAINT PK_PIT_Product_Category PRIMARY KEY CLUSTERED (DV_Sequence_Number) ON [INDEX]
	, CONSTRAINT UK_PIT_Product_Category UNIQUE NONCLUSTERED (DV_Snapshot_Datetime, HK_H_Product_Category) ON [INDEX]	
) ON [DATA];
GO




-- PIT_Region

DROP TABLE IF EXISTS Information_Mart.bv.PIT_Region;
GO

CREATE TABLE bv.PIT_Region (
	  DV_Sequence_Number bigint identity(1,1) NOT NULL
	, DV_Snapshot_Datetime datetimeoffset(7) NOT NULL
	, HK_H_Region binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, HK_H_Region__S_H_Region_Northwind binary(32) NOT NULL
	, DV_Load_Datetime__S_H_Region_Northwind datetimeoffset(7) NOT NULL
	, HK_H_Region__S_HDT_H_Region_Northwind binary(32) NOT NULL
	, DV_Load_Datetime__S_HDT_H_Region_Northwind datetimeoffset(7) NOT NULL
	, RegionID int NOT NULL
	, Is_Deleted_Flag bit NULL
	, CONSTRAINT PK_PIT_Region PRIMARY KEY CLUSTERED (DV_Sequence_Number) ON [INDEX]	
	, CONSTRAINT UK_PIT_Region UNIQUE NONCLUSTERED (DV_Snapshot_Datetime, HK_H_Region) ON [INDEX]	
) ON [DATA];
GO




-- PIT_Shipper

DROP TABLE IF EXISTS Information_Mart.bv.PIT_Shipper;
GO

CREATE TABLE bv.PIT_Shipper (
	  DV_Sequence_Number bigint identity(1,1) NOT NULL
	, DV_Snapshot_Datetime datetimeoffset(7) NOT NULL
	, HK_H_Shipper binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, HK_H_Shipper__S_H_Shipper_Northwind binary(32) NOT NULL
	, DV_Load_Datetime__S_H_Shipper_Northwind datetimeoffset(7) NOT NULL
	, HK_H_Shipper__S_HDT_H_Shipper_Northwind binary(32) NOT NULL
	, DV_Load_Datetime__S_HDT_H_Shipper_Northwind datetimeoffset(7) NOT NULL
	, ShipperID int NOT NULL
	, Is_Deleted_Flag bit NULL
	, CONSTRAINT PK_PIT_Shipper PRIMARY KEY CLUSTERED (DV_Sequence_Number) ON [INDEX]	
	, CONSTRAINT UK_PIT_Shipper UNIQUE NONCLUSTERED (DV_Snapshot_Datetime, HK_H_Shipper) ON [INDEX]	
) ON [DATA];
GO




-- PIT_Supplier

DROP TABLE IF EXISTS Information_Mart.bv.PIT_Supplier;
GO

CREATE TABLE bv.PIT_Supplier (
	  DV_Sequence_Number bigint identity(1,1) NOT NULL
	, DV_Snapshot_Datetime datetimeoffset(7) NOT NULL
	, HK_H_Supplier binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, HK_H_Supplier__S_H_Supplier_Northwind binary(32) NOT NULL
	, DV_Load_Datetime__S_H_Supplier_Northwind datetimeoffset(7) NOT NULL
	, HK_H_Supplier__S_HDT_H_Supplier_Northwind binary(32) NOT NULL
	, DV_Load_Datetime__S_HDT_H_Supplier_Northwind datetimeoffset(7) NOT NULL
	, SupplierID int NOT NULL
	, Is_Deleted_Flag bit NULL
	, CONSTRAINT PK_PIT_Supplier PRIMARY KEY CLUSTERED (DV_Sequence_Number) ON [INDEX]	
	, CONSTRAINT UK_PIT_Supplier UNIQUE NONCLUSTERED (DV_Snapshot_Datetime, HK_H_Supplier) ON [INDEX]	
) ON [DATA];
GO




-- PIT_Territory

DROP TABLE IF EXISTS Information_Mart.bv.PIT_Territory;
GO

CREATE TABLE bv.PIT_Territory (
	  DV_Sequence_Number bigint identity(1,1) NOT NULL
	, DV_Snapshot_Datetime datetimeoffset(7) NOT NULL
	, HK_H_Territory binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, HK_H_Territory__S_H_Territory_Northwind binary(32) NOT NULL
	, DV_Load_Datetime__S_H_Territory_Northwind datetimeoffset(7) NOT NULL
	, HK_H_Territory__S_HDT_H_Territory_Northwind binary(32) NOT NULL
	, DV_Load_Datetime__S_HDT_H_Territory_Northwind datetimeoffset(7) NOT NULL
	, TerritoryID nvarchar(20) NOT NULL
	, Is_Deleted_Flag bit NULL
	, CONSTRAINT PK_PIT_Territory PRIMARY KEY CLUSTERED (DV_Sequence_Number) ON [INDEX]	
	, CONSTRAINT UK_PIT_Territory UNIQUE NONCLUSTERED (DV_Snapshot_Datetime, HK_H_Territory) ON [INDEX]	
) ON [DATA];
GO




/* Link PITs */

-- PIT_Order_Detail

DROP TABLE IF EXISTS Information_Mart.bv.PIT_Order_Detail;
GO


CREATE TABLE bv.PIT_Order_Detail (
	  DV_Sequence_Number bigint identity(1,1) NOT NULL
	, DV_Snapshot_Datetime datetimeoffset(7) NOT NULL
	, HK_L_Order_Detail binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, HK_L_Order_Detail__S_L_Order_Detail_Northwind binary(32) NOT NULL
	, DV_Load_Datetime__S_L_Order_Detail_Northwind datetimeoffset(7) NOT NULL
	, HK_L_Order_Detail__S_LDT_L_Order_Detail_Northwind binary(32) NOT NULL
	, DV_Load_Datetime__S_LDT_L_Order_Detail_Northwind datetimeoffset(7) NOT NULL
	, OrderID int NULL
	, ProductID int NULL
	, Is_Deleted_Flag bit NULL
	, CONSTRAINT PK_PIT_Order_Detail PRIMARY KEY CLUSTERED (DV_Sequence_Number) ON [INDEX]	
	, CONSTRAINT UK_PIT_Order_Detail UNIQUE NONCLUSTERED (DV_Snapshot_Datetime, HK_L_Order_Detail) ON [INDEX]	
) ON [DATA];
GO