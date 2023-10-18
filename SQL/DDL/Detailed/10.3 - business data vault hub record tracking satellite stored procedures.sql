/*

	Business data vault hub record tracking satellite stored procedures

*/


USE Data_Vault;
GO

 
/* 
	Insert
*/

-- usp_insert_S_HRT_H_Customer_Northwind__L2_Northwind_Customers

DROP PROCEDURE IF EXISTS bv.usp_insert_S_HRT_H_Customer_Northwind__L2_Northwind_Customers;
GO

CREATE PROCEDURE bv.usp_insert_S_HRT_H_Customer_Northwind__L2_Northwind_Customers 
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_HRT_H_Customer_Northwind (
			  HK_H_Customer
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		)
		SELECT
			  HK_H_Customer
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		FROM
			Data_Vault.bv.v_stage_S_HRT_H_Customer_Northwind__L2_Northwind_Customers;

	END
GO





-- usp_insert_S_HRT_H_Customer_Type_Northwind__L2_Northwind_CustomerDemographics

DROP PROCEDURE IF EXISTS bv.usp_insert_S_HRT_H_Customer_Type_Northwind__L2_Northwind_CustomerDemographics;
GO

CREATE PROCEDURE bv.usp_insert_S_HRT_H_Customer_Type_Northwind__L2_Northwind_CustomerDemographics 
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_HRT_H_Customer_Type_Northwind (
			  HK_H_Customer_Type
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		)
		SELECT
			  HK_H_Customer_Type
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		FROM
			Data_Vault.bv.v_stage_S_HRT_H_Customer_Type_Northwind__L2_Northwind_CustomerDemographics;

	END
GO




-- usp_insert_S_HRT_H_Employee_Northwind__L2_Northwind_Employees

DROP PROCEDURE IF EXISTS bv.usp_insert_S_HRT_H_Employee_Northwind__L2_Northwind_Employees;
GO

CREATE PROCEDURE bv.usp_insert_S_HRT_H_Employee_Northwind__L2_Northwind_Employees 
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_HRT_H_Employee_Northwind (
			  HK_H_Employee
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		)
		SELECT
			  HK_H_Employee
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		FROM
			Data_Vault.bv.v_stage_S_HRT_H_Employee_Northwind__L2_Northwind_Employees;

	END
GO



-- usp_insert_S_HRT_H_Order_Northwind__L2_Northwind_Orders

DROP PROCEDURE IF EXISTS bv.usp_insert_S_HRT_H_Order_Northwind__L2_Northwind_Orders;
GO

CREATE PROCEDURE bv.usp_insert_S_HRT_H_Order_Northwind__L2_Northwind_Orders 
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_HRT_H_Order_Northwind (
			  HK_H_Order
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		)
		SELECT
			  HK_H_Order
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		FROM
			Data_Vault.bv.v_stage_S_HRT_H_Order_Northwind__L2_Northwind_Orders;

	END
GO




-- usp_insert_S_HRT_H_Product_Category_Northwind__L2_Northwind_Categories

DROP PROCEDURE IF EXISTS bv.usp_insert_S_HRT_H_Product_Category_Northwind__L2_Northwind_Categories;
GO

CREATE PROCEDURE bv.usp_insert_S_HRT_H_Product_Category_Northwind__L2_Northwind_Categories 
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_HRT_H_Product_Category_Northwind (
			  HK_H_Product_Category
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		)
		SELECT
			  HK_H_Product_Category
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		FROM
			Data_Vault.bv.v_stage_S_HRT_H_Product_Category_Northwind__L2_Northwind_Categories;

	END
GO





-- usp_insert_S_HRT_H_Product_Northwind__L2_Northwind_Products

DROP PROCEDURE IF EXISTS bv.usp_insert_S_HRT_H_Product_Northwind__L2_Northwind_Products;
GO

CREATE PROCEDURE bv.usp_insert_S_HRT_H_Product_Northwind__L2_Northwind_Products 
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_HRT_H_Product_Northwind (
			  HK_H_Product
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		)
		SELECT
			  HK_H_Product
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		FROM
			Data_Vault.bv.v_stage_S_HRT_H_Product_Northwind__L2_Northwind_Products;

	END
GO




-- usp_insert_S_HRT_H_Region_Northwind__L2_Northwind_Region

DROP PROCEDURE IF EXISTS bv.usp_insert_S_HRT_H_Region_Northwind__L2_Northwind_Region;
GO

CREATE PROCEDURE bv.usp_insert_S_HRT_H_Region_Northwind__L2_Northwind_Region 
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_HRT_H_Region_Northwind (
			  HK_H_Region
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		)
		SELECT
			  HK_H_Region
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		FROM
			Data_Vault.bv.v_stage_S_HRT_H_Region_Northwind__L2_Northwind_Region;

	END
GO



-- usp_insert_S_HRT_H_Shipper_Northwind__L2_Northwind_Shippers

DROP PROCEDURE IF EXISTS bv.usp_insert_S_HRT_H_Shipper_Northwind__L2_Northwind_Shippers;
GO

CREATE PROCEDURE bv.usp_insert_S_HRT_H_Shipper_Northwind__L2_Northwind_Shippers 
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_HRT_H_Shipper_Northwind (
			  HK_H_Shipper
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		)
		SELECT
			  HK_H_Shipper
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		FROM
			Data_Vault.bv.v_stage_S_HRT_H_Shipper_Northwind__L2_Northwind_Shippers;

	END
GO




-- usp_insert_S_HRT_H_Supplier_Northwind__L2_Northwind_Suppliers

DROP PROCEDURE IF EXISTS bv.usp_insert_S_HRT_H_Supplier_Northwind__L2_Northwind_Suppliers;
GO

CREATE PROCEDURE bv.usp_insert_S_HRT_H_Supplier_Northwind__L2_Northwind_Suppliers 
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_HRT_H_Supplier_Northwind (
			  HK_H_Supplier
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		)
		SELECT
			  HK_H_Supplier
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		FROM
			Data_Vault.bv.v_stage_S_HRT_H_Supplier_Northwind__L2_Northwind_Suppliers;

	END
GO




-- usp_insert_S_HRT_H_Territory_Northwind__L2_Northwind_Territories

DROP PROCEDURE IF EXISTS bv.usp_insert_S_HRT_H_Territory_Northwind__L2_Northwind_Territories;
GO

CREATE PROCEDURE bv.usp_insert_S_HRT_H_Territory_Northwind__L2_Northwind_Territories 
AS
	BEGIN

		INSERT INTO Data_Vault.bv.S_HRT_H_Territory_Northwind (
			  HK_H_Territory
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		)
		SELECT
			  HK_H_Territory
			, DV_Load_Datetime
			, DV_Record_Source
			, Appearance_Flag
			, Last_Seen_Datetime
		FROM
			Data_Vault.bv.v_stage_S_HRT_H_Territory_Northwind__L2_Northwind_Territories;

	END
GO




/* 
	Delete history 
	
	Keep a 7 day load window and ensure the latest loaded record for a given key is always retained regardless of age 	
*/

-- usp_delete_S_HRT_H_Customer_Northwind

DROP PROCEDURE IF EXISTS bv.usp_delete_S_HRT_H_Customer_Northwind;
GO

CREATE PROCEDURE bv.usp_delete_S_HRT_H_Customer_Northwind 
AS
	BEGIN

		DELETE FROM
			Data_Vault.bv.S_HRT_H_Customer_Northwind
		WHERE
			S_HRT_H_Customer_Northwind.DV_Load_Datetime <> (
				select
					MAX(sat2.DV_Load_Datetime)
				FROM
					Data_Vault.bv.S_HRT_H_Customer_Northwind AS sat2
				WHERE
					S_HRT_H_Customer_Northwind.HK_H_Customer = sat2.HK_H_Customer
			)
			AND DATEDIFF(DAY, S_HRT_H_Customer_Northwind.DV_Load_Datetime, SYSUTCDATETIME() AT TIME ZONE 'UTC') > 7;

	END
GO




-- usp_delete_S_HRT_H_Customer_Type_Northwind

DROP PROCEDURE IF EXISTS bv.usp_delete_S_HRT_H_Customer_Type_Northwind;
GO

CREATE PROCEDURE bv.usp_delete_S_HRT_H_Customer_Type_Northwind
AS
	BEGIN

		DELETE FROM
			Data_Vault.bv.S_HRT_H_Customer_Type_Northwind
		WHERE
			S_HRT_H_Customer_Type_Northwind.DV_Load_Datetime <> (
				select
					MAX(sat2.DV_Load_Datetime)
				FROM
					Data_Vault.bv.S_HRT_H_Customer_Type_Northwind AS sat2
				WHERE
					S_HRT_H_Customer_Type_Northwind.HK_H_Customer_Type = sat2.HK_H_Customer_Type
			)
			AND DATEDIFF(DAY, S_HRT_H_Customer_Type_Northwind.DV_Load_Datetime, SYSUTCDATETIME() AT TIME ZONE 'UTC') > 7;

	END
GO




-- usp_delete_S_HRT_H_Employee_Northwind

DROP PROCEDURE IF EXISTS bv.usp_delete_S_HRT_H_Employee_Northwind;
GO

CREATE PROCEDURE bv.usp_delete_S_HRT_H_Employee_Northwind
AS
	BEGIN

		DELETE FROM
			Data_Vault.bv.S_HRT_H_Employee_Northwind
		WHERE
			S_HRT_H_Employee_Northwind.DV_Load_Datetime <> (
				select
					MAX(sat2.DV_Load_Datetime)
				FROM
					Data_Vault.bv.S_HRT_H_Employee_Northwind AS sat2
				WHERE
					S_HRT_H_Employee_Northwind.HK_H_Employee = sat2.HK_H_Employee
			)
			AND DATEDIFF(DAY, S_HRT_H_Employee_Northwind.DV_Load_Datetime, SYSUTCDATETIME() AT TIME ZONE 'UTC') > 7;

	END
GO




-- usp_delete_S_HRT_H_Order_Northwind

DROP PROCEDURE IF EXISTS bv.usp_delete_S_HRT_H_Order_Northwind;
GO

CREATE PROCEDURE bv.usp_delete_S_HRT_H_Order_Northwind
AS
	BEGIN

		DELETE FROM
			Data_Vault.bv.S_HRT_H_Order_Northwind
		WHERE
			S_HRT_H_Order_Northwind.DV_Load_Datetime <> (
				select
					MAX(sat2.DV_Load_Datetime)
				FROM
					Data_Vault.bv.S_HRT_H_Order_Northwind AS sat2
				WHERE
					S_HRT_H_Order_Northwind.HK_H_Order = sat2.HK_H_Order
			)
			AND DATEDIFF(DAY, S_HRT_H_Order_Northwind.DV_Load_Datetime, SYSUTCDATETIME() AT TIME ZONE 'UTC') > 7;

	END
GO




-- usp_delete_S_HRT_H_Product_Category_Northwind

DROP PROCEDURE IF EXISTS bv.usp_delete_S_HRT_H_Product_Category_Northwind;
GO

CREATE PROCEDURE bv.usp_delete_S_HRT_H_Product_Category_Northwind
AS
	BEGIN

		DELETE FROM
			Data_Vault.bv.S_HRT_H_Product_Category_Northwind
		WHERE
			S_HRT_H_Product_Category_Northwind.DV_Load_Datetime <> (
				select
					MAX(sat2.DV_Load_Datetime)
				FROM
					Data_Vault.bv.S_HRT_H_Product_Category_Northwind AS sat2
				WHERE
					S_HRT_H_Product_Category_Northwind.HK_H_Product_Category = sat2.HK_H_Product_Category
			)
			AND DATEDIFF(DAY, S_HRT_H_Product_Category_Northwind.DV_Load_Datetime, SYSUTCDATETIME() AT TIME ZONE 'UTC') > 7;

	END
GO




-- usp_delete_S_HRT_H_Product_Northwind

DROP PROCEDURE IF EXISTS bv.usp_delete_S_HRT_H_Product_Northwind;
GO

CREATE PROCEDURE bv.usp_delete_S_HRT_H_Product_Northwind
AS
	BEGIN

		DELETE FROM
			Data_Vault.bv.S_HRT_H_Product_Northwind
		WHERE
			S_HRT_H_Product_Northwind.DV_Load_Datetime <> (
				select
					MAX(sat2.DV_Load_Datetime)
				FROM
					Data_Vault.bv.S_HRT_H_Product_Northwind AS sat2
				WHERE
					S_HRT_H_Product_Northwind.HK_H_Product = sat2.HK_H_Product
			)
			AND DATEDIFF(DAY, S_HRT_H_Product_Northwind.DV_Load_Datetime, SYSUTCDATETIME() AT TIME ZONE 'UTC') > 7;

	END
GO




-- usp_delete_S_HRT_H_Region_Northwind

DROP PROCEDURE IF EXISTS bv.usp_delete_S_HRT_H_Region_Northwind;
GO

CREATE PROCEDURE bv.usp_delete_S_HRT_H_Region_Northwind
AS
	BEGIN

		DELETE FROM
			Data_Vault.bv.S_HRT_H_Region_Northwind
		WHERE
			S_HRT_H_Region_Northwind.DV_Load_Datetime <> (
				select
					MAX(sat2.DV_Load_Datetime)
				FROM
					Data_Vault.bv.S_HRT_H_Region_Northwind AS sat2
				WHERE
					S_HRT_H_Region_Northwind.HK_H_Region = sat2.HK_H_Region
			)
			AND DATEDIFF(DAY, S_HRT_H_Region_Northwind.DV_Load_Datetime, SYSUTCDATETIME() AT TIME ZONE 'UTC') > 7;

	END
GO




-- usp_delete_S_HRT_H_Shipper_Northwind

DROP PROCEDURE IF EXISTS bv.usp_delete_S_HRT_H_Shipper_Northwind;
GO

CREATE PROCEDURE bv.usp_delete_S_HRT_H_Shipper_Northwind
AS
	BEGIN

		DELETE FROM
			Data_Vault.bv.S_HRT_H_Shipper_Northwind
		WHERE
			S_HRT_H_Shipper_Northwind.DV_Load_Datetime <> (
				select
					MAX(sat2.DV_Load_Datetime)
				FROM
					Data_Vault.bv.S_HRT_H_Shipper_Northwind AS sat2
				WHERE
					S_HRT_H_Shipper_Northwind.HK_H_Shipper = sat2.HK_H_Shipper
			)
			AND DATEDIFF(DAY, S_HRT_H_Shipper_Northwind.DV_Load_Datetime, SYSUTCDATETIME() AT TIME ZONE 'UTC') > 7;

	END
GO




-- usp_delete_S_HRT_H_Supplier_Northwind

DROP PROCEDURE IF EXISTS bv.usp_delete_S_HRT_H_Supplier_Northwind;
GO

CREATE PROCEDURE bv.usp_delete_S_HRT_H_Supplier_Northwind
AS
	BEGIN

		DELETE FROM
			Data_Vault.bv.S_HRT_H_Supplier_Northwind
		WHERE
			S_HRT_H_Supplier_Northwind.DV_Load_Datetime <> (
				select
					MAX(sat2.DV_Load_Datetime)
				FROM
					Data_Vault.bv.S_HRT_H_Supplier_Northwind AS sat2
				WHERE
					S_HRT_H_Supplier_Northwind.HK_H_Supplier = sat2.HK_H_Supplier
			)
			AND DATEDIFF(DAY, S_HRT_H_Supplier_Northwind.DV_Load_Datetime, SYSUTCDATETIME() AT TIME ZONE 'UTC') > 7;

	END
GO




-- usp_delete_S_HRT_H_Territory_Northwind

DROP PROCEDURE IF EXISTS bv.usp_delete_S_HRT_H_Territory_Northwind;
GO

CREATE PROCEDURE bv.usp_delete_S_HRT_H_Territory_Northwind
AS
	BEGIN

		DELETE FROM
			Data_Vault.bv.S_HRT_H_Territory_Northwind
		WHERE
			S_HRT_H_Territory_Northwind.DV_Load_Datetime <> (
				select
					MAX(sat2.DV_Load_Datetime)
				FROM
					Data_Vault.bv.S_HRT_H_Territory_Northwind AS sat2
				WHERE
					S_HRT_H_Territory_Northwind.HK_H_Territory = sat2.HK_H_Territory
			)
			AND DATEDIFF(DAY, S_HRT_H_Territory_Northwind.DV_Load_Datetime, SYSUTCDATETIME() AT TIME ZONE 'UTC') > 7;

	END
GO