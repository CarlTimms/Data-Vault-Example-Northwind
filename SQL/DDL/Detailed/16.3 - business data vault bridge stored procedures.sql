/*

	Business data vault bridge stored procedures

*/


USE Information_Mart;
GO


/* Insert */

-- usp_insert_B_Customer_Type

DROP PROCEDURE IF EXISTS bv.usp_insert_B_Customer_Type;
GO

CREATE PROCEDURE bv.usp_insert_B_Customer_Type
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




-- usp_insert_B_Employee_Reporting_Line

DROP PROCEDURE IF EXISTS bv.usp_insert_B_Employee_Reporting_Line;
GO

CREATE PROCEDURE bv.usp_insert_B_Employee_Reporting_Line
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




-- usp_insert_B_Employee_Territory

DROP PROCEDURE IF EXISTS bv.usp_insert_B_Employee_Territory;
GO

CREATE PROCEDURE bv.usp_insert_B_Employee_Territory
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




-- usp_insert_B_Order

DROP PROCEDURE IF EXISTS bv.usp_insert_B_Order;
GO

CREATE PROCEDURE bv.usp_insert_B_Order
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




-- usp_insert_B_Order_Detail

DROP PROCEDURE IF EXISTS bv.usp_insert_B_Order_Detail;
GO

CREATE PROCEDURE bv.usp_insert_B_Order_Detail
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




-- usp_insert_B_Product_Supplier_Category

DROP PROCEDURE IF EXISTS bv.usp_insert_B_Product_Supplier_Category;
GO

CREATE PROCEDURE bv.usp_insert_B_Product_Supplier_Category
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




-- usp_insert_B_Territory_Region

DROP PROCEDURE IF EXISTS bv.usp_insert_B_Territory_Region;
GO

CREATE PROCEDURE bv.usp_insert_B_Territory_Region
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




/* Delete */

-- usp_delete_B_Customer_Type

DROP PROCEDURE IF EXISTS bv.usp_delete_B_Customer_Type;
GO

CREATE PROCEDURE bv.usp_delete_B_Customer_Type
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




-- usp_delete_B_Employee_Reporting_Line

DROP PROCEDURE IF EXISTS bv.usp_delete_B_Employee_Reporting_Line;
GO

CREATE PROCEDURE bv.usp_delete_B_Employee_Reporting_Line
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




-- usp_delete_B_Employee_Territory

DROP PROCEDURE IF EXISTS bv.usp_delete_B_Employee_Territory;
GO

CREATE PROCEDURE bv.usp_delete_B_Employee_Territory
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




-- usp_delete_B_Order

DROP PROCEDURE IF EXISTS bv.usp_delete_B_Order;
GO

CREATE PROCEDURE bv.usp_delete_B_Order
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




-- usp_delete_B_Order_Detail

DROP PROCEDURE IF EXISTS bv.usp_delete_B_Order_Detail;
GO

CREATE PROCEDURE bv.usp_delete_B_Order_Detail
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




-- usp_delete_B_Product_Supplier_Category

DROP PROCEDURE IF EXISTS bv.usp_delete_B_Product_Supplier_Category;
GO

CREATE PROCEDURE bv.usp_delete_B_Product_Supplier_Category
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




-- usp_delete_B_Territory_Region

DROP PROCEDURE IF EXISTS bv.usp_delete_B_Territory_Region;
GO

CREATE PROCEDURE bv.usp_delete_B_Territory_Region
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