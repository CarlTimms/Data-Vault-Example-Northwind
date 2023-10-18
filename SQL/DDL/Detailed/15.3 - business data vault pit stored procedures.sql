/*

	Business data vault PIT stored procedures

*/


USE Information_Mart;
GO


/* Insert - hub PITs */

-- usp_insert_PIT_Customer

DROP PROCEDURE IF EXISTS bv.usp_insert_PIT_Customer;
GO

CREATE PROCEDURE bv.usp_insert_PIT_Customer
AS
	BEGIN

		INSERT INTO Information_Mart.bv.PIT_Customer (
			  DV_Snapshot_Datetime
			, HK_H_Customer
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Customer__S_H_Customer_Northwind
			, DV_Load_Datetime__S_H_Customer_Northwind
			, HK_H_Customer__S_HDT_H_Customer_Northwind
			, DV_Load_Datetime__S_HDT_H_Customer_Northwind
			, CustomerID
			, Is_Deleted_Flag
		)
		SELECT
			  DV_Snapshot_Datetime
			, HK_H_Customer
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Customer__S_H_Customer_Northwind
			, DV_Load_Datetime__S_H_Customer_Northwind
			, HK_H_Customer__S_HDT_H_Customer_Northwind
			, DV_Load_Datetime__S_HDT_H_Customer_Northwind
			, CustomerID
			, Is_Deleted_Flag
		FROM
			Information_Mart.bv.v_stage_PIT_Customer;

	END
GO




-- usp_insert_PIT_Customer_Type

DROP PROCEDURE IF EXISTS bv.usp_insert_PIT_Customer_Type;
GO

CREATE PROCEDURE bv.usp_insert_PIT_Customer_Type
AS
	BEGIN

		INSERT INTO Information_Mart.bv.PIT_Customer_Type (
			  DV_Snapshot_Datetime
			, HK_H_Customer_Type
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Customer_Type__S_H_Customer_Type_Northwind
			, DV_Load_Datetime__S_H_Customer_Type_Northwind
			, HK_H_Customer_Type__S_HDT_H_Customer_Type_Northwind
			, DV_Load_Datetime__S_HDT_H_Customer_Type_Northwind
			, CustomerTypeID
			, Is_Deleted_Flag	
		)
		SELECT
			  DV_Snapshot_Datetime
			, HK_H_Customer_Type
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Customer_Type__S_H_Customer_Type_Northwind
			, DV_Load_Datetime__S_H_Customer_Type_Northwind
			, HK_H_Customer_Type__S_HDT_H_Customer_Type_Northwind
			, DV_Load_Datetime__S_HDT_H_Customer_Type_Northwind
			, CustomerTypeID
			, Is_Deleted_Flag			
		FROM
			Information_Mart.bv.v_stage_PIT_Customer_Type;

	END
GO




-- usp_insert_PIT_Employee

DROP PROCEDURE IF EXISTS bv.usp_insert_PIT_Employee;
GO

CREATE PROCEDURE bv.usp_insert_PIT_Employee
AS
	BEGIN

		INSERT INTO Information_Mart.bv.PIT_Employee (
			  DV_Snapshot_Datetime
			, HK_H_Employee
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Employee__S_H_Employee_Northwind
			, DV_Load_Datetime__S_H_Employee_Northwind
			, HK_H_Employee__S_HDT_H_Employee_Northwind
			, DV_Load_Datetime__S_HDT_H_Employee_Northwind
			, EmployeeID
			, Employee_Name
			, Is_Deleted_Flag
		)
		SELECT
			  DV_Snapshot_Datetime
			, HK_H_Employee
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Employee__S_H_Employee_Northwind
			, DV_Load_Datetime__S_H_Employee_Northwind
			, HK_H_Employee__S_HDT_H_Employee_Northwind
			, DV_Load_Datetime__S_HDT_H_Employee_Northwind
			, EmployeeID
			, Employee_Name
			, Is_Deleted_Flag			
		FROM
			Information_Mart.bv.v_stage_PIT_Employee;

	END
GO




-- usp_insert_PIT_Order

DROP PROCEDURE IF EXISTS bv.usp_insert_PIT_Order;
GO

CREATE PROCEDURE bv.usp_insert_PIT_Order
AS
	BEGIN

		INSERT INTO Information_Mart.bv.PIT_Order (
			  DV_Snapshot_Datetime
			, HK_H_Order
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Order__S_H_Order_Northwind
			, DV_Load_Datetime__S_H_Order_Northwind
			, HK_H_Order__S_HDT_H_Order_Northwind
			, DV_Load_Datetime__S_HDT_H_Order_Northwind
			, OrderID
			, Is_Deleted_Flag
		)
		SELECT
			  DV_Snapshot_Datetime
			, HK_H_Order
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Order__S_H_Order_Northwind
			, DV_Load_Datetime__S_H_Order_Northwind
			, HK_H_Order__S_HDT_H_Order_Northwind
			, DV_Load_Datetime__S_HDT_H_Order_Northwind
			, OrderID
			, Is_Deleted_Flag			
		FROM
			Information_Mart.bv.v_stage_PIT_Order;

	END
GO




-- usp_insert_PIT_Product

DROP PROCEDURE IF EXISTS bv.usp_insert_PIT_Product;
GO

CREATE PROCEDURE bv.usp_insert_PIT_Product
AS
	BEGIN

		INSERT INTO Information_Mart.bv.PIT_Product (
			  DV_Snapshot_Datetime
			, HK_H_Product
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Product__S_H_Product_Northwind
			, DV_Load_Datetime__S_H_Product_Northwind
			, HK_H_Product__S_HDT_H_Product_Northwind
			, DV_Load_Datetime__S_HDT_H_Product_Northwind
			, ProductID
			, Is_Deleted_Flag
		)
		SELECT
			  DV_Snapshot_Datetime
			, HK_H_Product
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Product__S_H_Product_Northwind
			, DV_Load_Datetime__S_H_Product_Northwind
			, HK_H_Product__S_HDT_H_Product_Northwind
			, DV_Load_Datetime__S_HDT_H_Product_Northwind
			, ProductID
			, Is_Deleted_Flag			
		FROM
			Information_Mart.bv.v_stage_PIT_Product;

	END
GO




-- usp_insert_PIT_Product_Category

DROP PROCEDURE IF EXISTS bv.usp_insert_PIT_Product_Category;
GO

CREATE PROCEDURE bv.usp_insert_PIT_Product_Category
AS
	BEGIN

		INSERT INTO Information_Mart.bv.PIT_Product_Category (
			  DV_Snapshot_Datetime
			, HK_H_Product_Category
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Product_Category__S_H_Product_Category_Northwind
			, DV_Load_Datetime__S_H_Product_Category_Northwind
			, HK_H_Product_Category__S_HDT_H_Product_Category_Northwind
			, DV_Load_Datetime__S_HDT_H_Product_Category_Northwind
			, CategoryID
			, Is_Deleted_Flag
		)
		SELECT
			  DV_Snapshot_Datetime
			, HK_H_Product_Category
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Product_Category__S_H_Product_Category_Northwind
			, DV_Load_Datetime__S_H_Product_Category_Northwind
			, HK_H_Product_Category__S_HDT_H_Product_Category_Northwind
			, DV_Load_Datetime__S_HDT_H_Product_Category_Northwind
			, CategoryID
			, Is_Deleted_Flag			
		FROM
			Information_Mart.bv.v_stage_PIT_Product_Category;

	END
GO




-- usp_insert_PIT_Region

DROP PROCEDURE IF EXISTS bv.usp_insert_PIT_Region;
GO

CREATE PROCEDURE bv.usp_insert_PIT_Region
AS
	BEGIN

		INSERT INTO Information_Mart.bv.PIT_Region (
			  DV_Snapshot_Datetime
			, HK_H_Region
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Region__S_H_Region_Northwind
			, DV_Load_Datetime__S_H_Region_Northwind
			, HK_H_Region__S_HDT_H_Region_Northwind
			, DV_Load_Datetime__S_HDT_H_Region_Northwind
			, RegionID
			, Is_Deleted_Flag
		)
		SELECT
			  DV_Snapshot_Datetime
			, HK_H_Region
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Region__S_H_Region_Northwind
			, DV_Load_Datetime__S_H_Region_Northwind
			, HK_H_Region__S_HDT_H_Region_Northwind
			, DV_Load_Datetime__S_HDT_H_Region_Northwind
			, RegionID
			, Is_Deleted_Flag			
		FROM
			Information_Mart.bv.v_stage_PIT_Region;

	END
GO




-- usp_insert_PIT_Shipper

DROP PROCEDURE IF EXISTS bv.usp_insert_PIT_Shipper;
GO

CREATE PROCEDURE bv.usp_insert_PIT_Shipper
AS
	BEGIN

		INSERT INTO Information_Mart.bv.PIT_Shipper (
			  DV_Snapshot_Datetime
			, HK_H_Shipper
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Shipper__S_H_Shipper_Northwind
			, DV_Load_Datetime__S_H_Shipper_Northwind
			, HK_H_Shipper__S_HDT_H_Shipper_Northwind
			, DV_Load_Datetime__S_HDT_H_Shipper_Northwind
			, ShipperID
			, Is_Deleted_Flag
		)
		SELECT
			  DV_Snapshot_Datetime
			, HK_H_Shipper
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Shipper__S_H_Shipper_Northwind
			, DV_Load_Datetime__S_H_Shipper_Northwind
			, HK_H_Shipper__S_HDT_H_Shipper_Northwind
			, DV_Load_Datetime__S_HDT_H_Shipper_Northwind
			, ShipperID
			, Is_Deleted_Flag			
		FROM
			Information_Mart.bv.v_stage_PIT_Shipper;

	END
GO




-- usp_insert_PIT_Supplier

DROP PROCEDURE IF EXISTS bv.usp_insert_PIT_Supplier;
GO

CREATE PROCEDURE bv.usp_insert_PIT_Supplier
AS
	BEGIN

		INSERT INTO Information_Mart.bv.PIT_Supplier (
			  DV_Snapshot_Datetime
			, HK_H_Supplier
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Supplier__S_H_Supplier_Northwind
			, DV_Load_Datetime__S_H_Supplier_Northwind
			, HK_H_Supplier__S_HDT_H_Supplier_Northwind
			, DV_Load_Datetime__S_HDT_H_Supplier_Northwind
			, SupplierID
			, Is_Deleted_Flag
		)
		SELECT
			  DV_Snapshot_Datetime
			, HK_H_Supplier
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Supplier__S_H_Supplier_Northwind
			, DV_Load_Datetime__S_H_Supplier_Northwind
			, HK_H_Supplier__S_HDT_H_Supplier_Northwind
			, DV_Load_Datetime__S_HDT_H_Supplier_Northwind
			, SupplierID
			, Is_Deleted_Flag			
		FROM
			Information_Mart.bv.v_stage_PIT_Supplier;

	END
GO




-- usp_insert_PIT_Territory

DROP PROCEDURE IF EXISTS bv.usp_insert_PIT_Territory;
GO

CREATE PROCEDURE bv.usp_insert_PIT_Territory
AS
	BEGIN

		INSERT INTO Information_Mart.bv.PIT_Territory (
			  DV_Snapshot_Datetime
			, HK_H_Territory
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Territory__S_H_Territory_Northwind
			, DV_Load_Datetime__S_H_Territory_Northwind
			, HK_H_Territory__S_HDT_H_Territory_Northwind
			, DV_Load_Datetime__S_HDT_H_Territory_Northwind
			, TerritoryID
			, Is_Deleted_Flag
		)
		SELECT
			  DV_Snapshot_Datetime
			, HK_H_Territory
			, DV_Load_Datetime
			, DV_Record_Source
			, HK_H_Territory__S_H_Territory_Northwind
			, DV_Load_Datetime__S_H_Territory_Northwind
			, HK_H_Territory__S_HDT_H_Territory_Northwind
			, DV_Load_Datetime__S_HDT_H_Territory_Northwind
			, TerritoryID
			, Is_Deleted_Flag			
		FROM
			Information_Mart.bv.v_stage_PIT_Territory;

	END
GO




/* Insert - link PITs */

-- usp_insert_PIT_Order_Detail

DROP PROCEDURE IF EXISTS bv.usp_insert_PIT_Order_Detail;
GO

CREATE PROCEDURE bv.usp_insert_PIT_Order_Detail
AS
	BEGIN

		INSERT INTO Information_Mart.bv.PIT_Order_Detail (
			  DV_Snapshot_Datetime 
			, HK_L_Order_Detail 
			, DV_Load_Datetime 
			, DV_Record_Source 
			, HK_L_Order_Detail__S_L_Order_Detail_Northwind 
			, DV_Load_Datetime__S_L_Order_Detail_Northwind 
			, HK_L_Order_Detail__S_LDT_L_Order_Detail_Northwind 
			, DV_Load_Datetime__S_LDT_L_Order_Detail_Northwind 
			, OrderID 
			, ProductID 
			, Is_Deleted_Flag 
		)
		SELECT
			  DV_Snapshot_Datetime 
			, HK_L_Order_Detail 
			, DV_Load_Datetime 
			, DV_Record_Source 
			, HK_L_Order_Detail__S_L_Order_Detail_Northwind 
			, DV_Load_Datetime__S_L_Order_Detail_Northwind 
			, HK_L_Order_Detail__S_LDT_L_Order_Detail_Northwind 
			, DV_Load_Datetime__S_LDT_L_Order_Detail_Northwind 
			, OrderID 
			, ProductID 
			, Is_Deleted_Flag		
		FROM
			Information_Mart.bv.v_stage_PIT_Order_Detail;

	END
GO




/* Delete - hub PITs */

-- usp_delete_PIT_Customer

DROP PROCEDURE IF EXISTS bv.usp_delete_PIT_Customer;
GO

CREATE PROCEDURE bv.usp_delete_PIT_Customer
AS
	BEGIN

		DELETE pit
		FROM
			Information_Mart.bv.PIT_Customer AS pit
				LEFT JOIN Information_Mart.bv.R_Snapshot_Control AS snap
					ON pit.DV_Snapshot_Datetime = snap.DV_Snapshot_Datetime
		WHERE
			snap.DV_Snapshot_Datetime IS NULL;

	END
GO




-- usp_delete_PIT_Customer_Type

DROP PROCEDURE IF EXISTS bv.usp_delete_PIT_Customer_Type;
GO

CREATE PROCEDURE bv.usp_delete_PIT_Customer_Type
AS
	BEGIN

		DELETE pit
		FROM
			Information_Mart.bv.PIT_Customer_Type AS pit
				LEFT JOIN Information_Mart.bv.R_Snapshot_Control AS snap
					ON pit.DV_Snapshot_Datetime = snap.DV_Snapshot_Datetime
		WHERE
			snap.DV_Snapshot_Datetime IS NULL;

	END
GO




-- usp_delete_PIT_Employee

DROP PROCEDURE IF EXISTS bv.usp_delete_PIT_Employee;
GO

CREATE PROCEDURE bv.usp_delete_PIT_Employee
AS
	BEGIN

		DELETE pit
		FROM
			Information_Mart.bv.PIT_Employee AS pit
				LEFT JOIN Information_Mart.bv.R_Snapshot_Control AS snap
					ON pit.DV_Snapshot_Datetime = snap.DV_Snapshot_Datetime
		WHERE
			snap.DV_Snapshot_Datetime IS NULL;

	END
GO




-- usp_delete_PIT_Order

DROP PROCEDURE IF EXISTS bv.usp_delete_PIT_Order;
GO

CREATE PROCEDURE bv.usp_delete_PIT_Order
AS
	BEGIN

		DELETE pit
		FROM
			Information_Mart.bv.PIT_Order AS pit
				LEFT JOIN Information_Mart.bv.R_Snapshot_Control AS snap
					ON pit.DV_Snapshot_Datetime = snap.DV_Snapshot_Datetime
		WHERE
			snap.DV_Snapshot_Datetime IS NULL;

	END
GO




-- usp_delete_PIT_Product

DROP PROCEDURE IF EXISTS bv.usp_delete_PIT_Product;
GO

CREATE PROCEDURE bv.usp_delete_PIT_Product
AS
	BEGIN

		DELETE pit
		FROM
			Information_Mart.bv.PIT_Product AS pit
				LEFT JOIN Information_Mart.bv.R_Snapshot_Control AS snap
					ON pit.DV_Snapshot_Datetime = snap.DV_Snapshot_Datetime
		WHERE
			snap.DV_Snapshot_Datetime IS NULL;

	END
GO




-- usp_delete_PIT_Product_Category

DROP PROCEDURE IF EXISTS bv.usp_delete_PIT_Product_Category;
GO

CREATE PROCEDURE bv.usp_delete_PIT_Product_Category
AS
	BEGIN

		DELETE pit
		FROM
			Information_Mart.bv.PIT_Product_Category AS pit
				LEFT JOIN Information_Mart.bv.R_Snapshot_Control AS snap
					ON pit.DV_Snapshot_Datetime = snap.DV_Snapshot_Datetime
		WHERE
			snap.DV_Snapshot_Datetime IS NULL;

	END
GO




-- usp_delete_PIT_Region

DROP PROCEDURE IF EXISTS bv.usp_delete_PIT_Region;
GO

CREATE PROCEDURE bv.usp_delete_PIT_Region
AS
	BEGIN

		DELETE pit
		FROM
			Information_Mart.bv.PIT_Region AS pit
				LEFT JOIN Information_Mart.bv.R_Snapshot_Control AS snap
					ON pit.DV_Snapshot_Datetime = snap.DV_Snapshot_Datetime
		WHERE
			snap.DV_Snapshot_Datetime IS NULL;

	END
GO




-- usp_delete_PIT_Shipper

DROP PROCEDURE IF EXISTS bv.usp_delete_PIT_Shipper;
GO

CREATE PROCEDURE bv.usp_delete_PIT_Shipper
AS
	BEGIN

		DELETE pit
		FROM
			Information_Mart.bv.PIT_Shipper AS pit
				LEFT JOIN Information_Mart.bv.R_Snapshot_Control AS snap
					ON pit.DV_Snapshot_Datetime = snap.DV_Snapshot_Datetime
		WHERE
			snap.DV_Snapshot_Datetime IS NULL;

	END
GO




-- usp_delete_PIT_Supplier

DROP PROCEDURE IF EXISTS bv.usp_delete_PIT_Supplier;
GO

CREATE PROCEDURE bv.usp_delete_PIT_Supplier
AS
	BEGIN

		DELETE pit
		FROM
			Information_Mart.bv.PIT_Supplier AS pit
				LEFT JOIN Information_Mart.bv.R_Snapshot_Control AS snap
					ON pit.DV_Snapshot_Datetime = snap.DV_Snapshot_Datetime
		WHERE
			snap.DV_Snapshot_Datetime IS NULL;

	END
GO




-- usp_delete_PIT_Territory

DROP PROCEDURE IF EXISTS bv.usp_delete_PIT_Territory;
GO

CREATE PROCEDURE bv.usp_delete_PIT_Territory
AS
	BEGIN

		DELETE pit
		FROM
			Information_Mart.bv.PIT_Territory AS pit
				LEFT JOIN Information_Mart.bv.R_Snapshot_Control AS snap
					ON pit.DV_Snapshot_Datetime = snap.DV_Snapshot_Datetime
		WHERE
			snap.DV_Snapshot_Datetime IS NULL;

	END
GO




/* Delete - link PITs */

-- usp_delete_PIT_Order_Detail

DROP PROCEDURE IF EXISTS bv.usp_delete_PIT_Order_Detail;
GO

CREATE PROCEDURE bv.usp_delete_PIT_Order_Detail
AS
	BEGIN

		DELETE pit
		FROM
			Information_Mart.bv.PIT_Order_Detail AS pit
				LEFT JOIN Information_Mart.bv.R_Snapshot_Control AS snap
					ON pit.DV_Snapshot_Datetime = snap.DV_Snapshot_Datetime
		WHERE
			snap.DV_Snapshot_Datetime IS NULL;

	END
GO