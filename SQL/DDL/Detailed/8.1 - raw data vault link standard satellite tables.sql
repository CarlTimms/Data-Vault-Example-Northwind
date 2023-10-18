/*

	Raw data vault link standard satellite tables

*/


USE Data_Vault;
GO


-- S_L_Order_Detail_Northwind

DROP TABLE IF EXISTS rv.S_L_Order_Detail_Northwind;
GO

CREATE TABLE rv.S_L_Order_Detail_Northwind (
	  HK_L_Order_Detail binary(32) NOT NULL
	, DV_Load_Datetime datetimeoffset NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, HD_S_L_Order_Detail_Northwind binary(32) NOT NULL
	, UnitPrice money NULL
	, Quantity smallint NULL
	, Discount real NULL
	, CONSTRAINT PK_S_L_Order_Detail_Northwind PRIMARY KEY NONCLUSTERED (HK_L_Order_Detail, DV_Load_Datetime) ON [INDEX]
) ON [DATA];
GO