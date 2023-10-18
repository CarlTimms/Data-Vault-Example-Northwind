/*

	Information mart fact views

*/


USE Information_Mart;
GO


-- Fact_Order

DROP VIEW IF EXISTS star.Fact_Order;
GO

CREATE VIEW star.Fact_Order (
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




-- Fact_Order_Detail

DROP VIEW IF EXISTS star.Fact_Order_Detail;
GO

CREATE VIEW star.Fact_Order_Detail (
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