/*

	Ghost records

*/


USE Data_Vault;
GO


/* Hub deletion tracking satellites  */

-- S_HDT_H_Customer_Northwind

INSERT INTO bv.S_HDT_H_Customer_Northwind (
	  HK_H_Customer
	, DV_Load_Datetime
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
VALUES 
	  (
		    HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		  , '1900-01-01 00:00:00.0000000 +00:00'
		  , 'SYSTEM | GHOST RECORD'
		  , 0
		  , NULL
	  )
	, (
		    HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		  , '1900-01-01 00:00:00.0000000 +00:00'
		  , 'SYSTEM | NULL KEY - REQUIRED'
		  , 0
		  , NULL
	  )
	, (
		    HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		  , '1900-01-01 00:00:00.0000000 +00:00'
		  , 'SYSTEM | NULL KEY - OPTIONAL'
		  , 0
		  , NULL
	  );
GO




-- S_HDT_H_Customer_Type_Northwind

INSERT INTO bv.S_HDT_H_Customer_Type_Northwind (
	  HK_H_Customer_Type
	, DV_Load_Datetime
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
VALUES 
	  (
		    HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		  , '1900-01-01 00:00:00.0000000 +00:00'
		  , 'SYSTEM | GHOST RECORD'
		  , 0
		  , NULL
	  )
	, (
		    HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		  , '1900-01-01 00:00:00.0000000 +00:00'
		  , 'SYSTEM | NULL KEY - REQUIRED'
		  , 0
		  , NULL
	  )
	, (
		    HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		  , '1900-01-01 00:00:00.0000000 +00:00'
		  , 'SYSTEM | NULL KEY - OPTIONAL'
		  , 0
		  , NULL
	  );
GO




-- S_HDT_H_Employee_Northwind

INSERT INTO bv.S_HDT_H_Employee_Northwind (
	  HK_H_Employee
	, DV_Load_Datetime
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
VALUES 
	  (
		    HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		  , '1900-01-01 00:00:00.0000000 +00:00'
		  , 'SYSTEM | GHOST RECORD'
		  , 0
		  , NULL
	  )
	, (
		    HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		  , '1900-01-01 00:00:00.0000000 +00:00'
		  , 'SYSTEM | NULL KEY - REQUIRED'
		  , 0
		  , NULL
	  )
	, (
		    HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		  , '1900-01-01 00:00:00.0000000 +00:00'
		  , 'SYSTEM | NULL KEY - OPTIONAL'
		  , 0
		  , NULL
	  );
GO




-- S_HDT_H_Order_Northwind

INSERT INTO bv.S_HDT_H_Order_Northwind (
	  HK_H_Order
	, DV_Load_Datetime
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
VALUES 
	  (
		    HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		  , '1900-01-01 00:00:00.0000000 +00:00'
		  , 'SYSTEM | GHOST RECORD'
		  , 0
		  , NULL
	  )
	, (
		    HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		  , '1900-01-01 00:00:00.0000000 +00:00'
		  , 'SYSTEM | NULL KEY - REQUIRED'
		  , 0
		  , NULL
	  )
	, (
		    HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		  , '1900-01-01 00:00:00.0000000 +00:00'
		  , 'SYSTEM | NULL KEY - OPTIONAL'
		  , 0
		  , NULL
	  );
GO




-- S_HDT_H_Product_Category_Northwind

INSERT INTO bv.S_HDT_H_Product_Category_Northwind (
	  HK_H_Product_Category
	, DV_Load_Datetime
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
VALUES 
	  (
		    HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		  , '1900-01-01 00:00:00.0000000 +00:00'
		  , 'SYSTEM | GHOST RECORD'
		  , 0
		  , NULL
	  )
	, (
		    HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		  , '1900-01-01 00:00:00.0000000 +00:00'
		  , 'SYSTEM | NULL KEY - REQUIRED'
		  , 0
		  , NULL
	  )
	, (
		    HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		  , '1900-01-01 00:00:00.0000000 +00:00'
		  , 'SYSTEM | NULL KEY - OPTIONAL'
		  , 0
		  , NULL
	  );
GO




-- S_HDT_H_Product_Northwind

INSERT INTO bv.S_HDT_H_Product_Northwind (
	  HK_H_Product
	, DV_Load_Datetime
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
VALUES 
	  (
		    HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		  , '1900-01-01 00:00:00.0000000 +00:00'
		  , 'SYSTEM | GHOST RECORD'
		  , 0
		  , NULL
	  )
	, (
		    HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		  , '1900-01-01 00:00:00.0000000 +00:00'
		  , 'SYSTEM | NULL KEY - REQUIRED'
		  , 0
		  , NULL
	  )
	, (
		    HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		  , '1900-01-01 00:00:00.0000000 +00:00'
		  , 'SYSTEM | NULL KEY - OPTIONAL'
		  , 0
		  , NULL
	  );
GO




-- S_HDT_H_Region_Northwind

INSERT INTO bv.S_HDT_H_Region_Northwind (
	  HK_H_Region
	, DV_Load_Datetime
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
VALUES 
	  (
		    HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		  , '1900-01-01 00:00:00.0000000 +00:00'
		  , 'SYSTEM | GHOST RECORD'
		  , 0
		  , NULL
	  )
	, (
		    HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		  , '1900-01-01 00:00:00.0000000 +00:00'
		  , 'SYSTEM | NULL KEY - REQUIRED'
		  , 0
		  , NULL
	  )
	, (
		    HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		  , '1900-01-01 00:00:00.0000000 +00:00'
		  , 'SYSTEM | NULL KEY - OPTIONAL'
		  , 0
		  , NULL
	  );
GO




-- S_HDT_H_Shipper_Northwind

INSERT INTO bv.S_HDT_H_Shipper_Northwind (
	  HK_H_Shipper
	, DV_Load_Datetime
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
VALUES 
	  (
		    HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		  , '1900-01-01 00:00:00.0000000 +00:00'
		  , 'SYSTEM | GHOST RECORD'
		  , 0
		  , NULL
	  )
	, (
		    HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		  , '1900-01-01 00:00:00.0000000 +00:00'
		  , 'SYSTEM | NULL KEY - REQUIRED'
		  , 0
		  , NULL
	  )
	, (
		    HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		  , '1900-01-01 00:00:00.0000000 +00:00'
		  , 'SYSTEM | NULL KEY - OPTIONAL'
		  , 0
		  , NULL
	  );
GO




-- S_HDT_H_Supplier_Northwind

INSERT INTO bv.S_HDT_H_Supplier_Northwind (
	  HK_H_Supplier
	, DV_Load_Datetime
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
VALUES 
	  (
		    HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		  , '1900-01-01 00:00:00.0000000 +00:00'
		  , 'SYSTEM | GHOST RECORD'
		  , 0
		  , NULL
	  )
	, (
		    HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		  , '1900-01-01 00:00:00.0000000 +00:00'
		  , 'SYSTEM | NULL KEY - REQUIRED'
		  , 0
		  , NULL
	  )
	, (
		    HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		  , '1900-01-01 00:00:00.0000000 +00:00'
		  , 'SYSTEM | NULL KEY - OPTIONAL'
		  , 0
		  , NULL
	  );
GO




-- S_HDT_H_Territory_Northwind

INSERT INTO bv.S_HDT_H_Territory_Northwind (
	  HK_H_Territory
	, DV_Load_Datetime
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
VALUES 
	  (
		    HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		  , '1900-01-01 00:00:00.0000000 +00:00'
		  , 'SYSTEM | GHOST RECORD'
		  , 0
		  , NULL
	  )
	, (
		    HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		  , '1900-01-01 00:00:00.0000000 +00:00'
		  , 'SYSTEM | NULL KEY - REQUIRED'
		  , 0
		  , NULL
	  )
	, (
		    HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		  , '1900-01-01 00:00:00.0000000 +00:00'
		  , 'SYSTEM | NULL KEY - OPTIONAL'
		  , 0
		  , NULL
	  );
GO




/* Hub record tracking satellites */

-- No reason to add to this type of satellite




/* Link deletion tracking */

-- S_LDT_L_Customer_Type_Northwind

INSERT INTO bv.S_LDT_L_Customer_Type_Northwind (
	  HK_L_Customer_Type
	, DV_Load_Datetime
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
VALUES
	  (
		    HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		  , '1900-01-01 00:00:00.0000000 +00:00'
		  , 'SYSTEM | GHOST RECORD'
		  , 0
		  , NULL
	  )
	, (
		    HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		  , '1900-01-01 00:00:00.0000000 +00:00'
		  , 'SYSTEM | NULL KEY - REQUIRED'
		  , 0
		  , NULL
	  )
	, (
		    HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		  , '1900-01-01 00:00:00.0000000 +00:00'
		  , 'SYSTEM | NULL KEY - OPTIONAL'
		  , 0
		  , NULL
	  );
GO




-- S_LDT_L_Employee_Territory_Northwind

INSERT INTO bv.S_LDT_L_Employee_Territory_Northwind (
	  HK_L_Employee_Territory
	, DV_Load_Datetime
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
VALUES
	  (
		    HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		  , '1900-01-01 00:00:00.0000000 +00:00'
		  , 'SYSTEM | GHOST RECORD'
		  , 0
		  , NULL
	  )
	, (
		    HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		  , '1900-01-01 00:00:00.0000000 +00:00'
		  , 'SYSTEM | NULL KEY - REQUIRED'
		  , 0
		  , NULL
	  )
	, (
		    HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		  , '1900-01-01 00:00:00.0000000 +00:00'
		  , 'SYSTEM | NULL KEY - OPTIONAL'
		  , 0
		  , NULL
	  );
GO




-- S_LDT_L_Order_Detail_Northwind

INSERT INTO bv.S_LDT_L_Order_Detail_Northwind (
	  HK_L_Order_Detail
	, DV_Load_Datetime
	, DV_Record_Source
	, Is_Deleted_Flag
	, Deleted_Datetime
)
VALUES
	  (
		    HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		  , '1900-01-01 00:00:00.0000000 +00:00'
		  , 'SYSTEM | GHOST RECORD'
		  , 0
		  , NULL
	  )
	, (
		    HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		  , '1900-01-01 00:00:00.0000000 +00:00'
		  , 'SYSTEM | NULL KEY - REQUIRED'
		  , 0
		  , NULL
	  )
	, (
		    HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		  , '1900-01-01 00:00:00.0000000 +00:00'
		  , 'SYSTEM | NULL KEY - OPTIONAL'
		  , 0
		  , NULL
	  );
GO




/* Link effectivity satellites */

-- S_LE_L_Employee_Reporting_Line_Northwind

INSERT INTO bv.S_LE_L_Employee_Reporting_Line_Northwind (
	  HK_L_Employee_Reporting_Line
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Employee__Direct_Report__DK
	, Start_Datetime
	, HK_L_Employee_Reporting_Line__Previous
	, DV_Load_Datetime__Previous
)
VALUES
	  (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | GHOST RECORD'
		, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, NULL
		, NULL
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - REQUIRED'
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, NULL
		, NULL
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - OPTIONAL'
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, NULL
		, NULL
	  );
GO




-- S_LE_L_Order_Header_Northwind

INSERT INTO bv.S_LE_L_Order_Header_Northwind (
	  HK_L_Order_Header
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Order__DK
	, Start_Datetime
	, HK_L_Order_Header__Previous
	, DV_Load_Datetime__Previous
)
VALUES
	  (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | GHOST RECORD'
		, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, NULL
		, NULL
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - REQUIRED'
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, NULL
		, NULL
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - OPTIONAL'
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, NULL
		, NULL
	  );
GO




-- S_LE_L_Product_Category_Northwind

INSERT INTO bv.S_LE_L_Product_Category_Northwind (
	  HK_L_Product_Category
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Product__DK
	, Start_Datetime
	, HK_L_Product_Category__Previous
	, DV_Load_Datetime__Previous
)
VALUES
	  (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | GHOST RECORD'
		, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, NULL
		, NULL
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - REQUIRED'
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, NULL
		, NULL
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - OPTIONAL'
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, NULL
		, NULL
	  );
GO




-- S_LE_L_Product_Supplier_Northwind

INSERT INTO bv.S_LE_L_Product_Supplier_Northwind (
	  HK_L_Product_Supplier
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Product__DK
	, Start_Datetime
	, HK_L_Product_Supplier__Previous
	, DV_Load_Datetime__Previous
)
VALUES
	  (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | GHOST RECORD'
		, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, NULL
		, NULL
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - REQUIRED'
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, NULL
		, NULL
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - OPTIONAL'
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, NULL
		, NULL
	  );
GO




-- S_LE_L_Territory_Region_Northwind

INSERT INTO bv.S_LE_L_Territory_Region_Northwind (
	  HK_L_Territory_Region
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Territory__DK
	, Start_Datetime
	, HK_L_Territory_Region__Previous
	, DV_Load_Datetime__Previous
)
VALUES
	  (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | GHOST RECORD'
		, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, NULL
		, NULL
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - REQUIRED'
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, NULL
		, NULL
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - OPTIONAL'
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, NULL
		, NULL
	  );
GO




/* Link record tracking satellites */

-- No reason to add to this type of satellite




/* Hubs*/

-- H_Customer

INSERT INTO rv.H_Customer(
	  HK_H_Customer
	, DV_Load_Datetime
	, DV_Record_Source
	, CustomerID
)
VALUES
	  (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | GHOST RECORD'
		, '0'
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - REQUIRED'
		, '-1'
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - OPTIONAL'
		, '-2'
	  );
GO




-- H_Customer_Type

INSERT INTO rv.H_Customer_Type (
	  HK_H_Customer_Type
	, DV_Load_Datetime
	, DV_Record_Source
	, CustomerTypeID
)
VALUES
	  (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | GHOST RECORD'
		, '0'
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - REQUIRED'
		, '-1'
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - OPTIONAL'
		, '-2'
	  );
GO




-- H_Employee

INSERT INTO rv.H_Employee (
	  HK_H_Employee
	, DV_Load_Datetime
	, DV_Record_Source
	, EmployeeID
)
VALUES
	  (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | GHOST RECORD'
		, 0
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - REQUIRED'
		, -1
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - OPTIONAL'
		, -2
	  );
GO




-- H_Order

INSERT INTO rv.H_Order (
	  HK_H_Order
	, DV_Load_Datetime
	, DV_Record_Source
	, OrderID
)
VALUES
	  (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | GHOST RECORD'
		, 0
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - REQUIRED'
		, -1
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - OPTIONAL'
		, -2
	  );
GO




-- H_Product

INSERT INTO rv.H_Product (
	  HK_H_Product
	, DV_Load_Datetime
	, DV_Record_Source
	, ProductID
)
VALUES
	  (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | GHOST RECORD'
		, 0
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - REQUIRED'
		, -1
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - OPTIONAL'
		, -2
	  );
GO




-- H_Product_Category

INSERT INTO rv.H_Product_Category (
	  HK_H_Product_Category
	, DV_Load_Datetime
	, DV_Record_Source
	, CategoryID
)
VALUES
	  (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | GHOST RECORD'
		, 0
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - REQUIRED'
		, -1
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - OPTIONAL'
		, -2
	  );
GO




-- H_Region

INSERT INTO rv.H_Region (
	  HK_H_Region
	, DV_Load_Datetime
	, DV_Record_Source
	, RegionID
)
VALUES
	  (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | GHOST RECORD'
		, 0
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - REQUIRED'
		, -1
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - OPTIONAL'
		, -2
	  );
GO




-- H_Shipper

INSERT INTO rv.H_Shipper (
	  HK_H_Shipper
	, DV_Load_Datetime
	, DV_Record_Source
	, ShipperID
)
VALUES
	  (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | GHOST RECORD'
		, 0
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - REQUIRED'
		, -1
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - OPTIONAL'
		, -2
	  );
GO




-- H_Supplier

INSERT INTO rv.H_Supplier (
	  HK_H_Supplier
	, DV_Load_Datetime
	, DV_Record_Source
	, SupplierID
)
VALUES
	  (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | GHOST RECORD'
		, 0
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - REQUIRED'
		, -1
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - OPTIONAL'
		, -2
	  );
GO




-- H_Territory

INSERT INTO rv.H_Territory (
	  HK_H_Territory
	, DV_Load_Datetime
	, DV_Record_Source
	, TerritoryID
)
VALUES
	  (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | GHOST RECORD'
		, '0'
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - REQUIRED'
		, '-1'
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - OPTIONAL'
		, '-2'
	  );
GO




-- L_Customer_Type

INSERT INTO rv.L_Customer_Type (
	  HK_L_Customer_Type
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Customer
	, HK_H_Customer_Type
)
VALUES
	  (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1))) 
		, '1900-01-01 00:00:00.0000000 +00:00' 
		, 'SYSTEM | GHOST RECORD'
		, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-1' AS nchar(2))) 
		, '1900-01-01 00:00:00.0000000 +00:00' 
		, 'SYSTEM | NULL KEY - REQUIRED'
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-2' AS nchar(2))) 
		, '1900-01-01 00:00:00.0000000 +00:00' 
		, 'SYSTEM | NULL KEY - OPTIONAL'
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
	  );




-- L_Employee_Reporting_Line

INSERT INTO rv.L_Employee_Reporting_Line (
	  HK_L_Employee_Reporting_Line
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Employee__Direct_Report__DK
	, HK_H_Employee__Manager
)
VALUES
	  (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1))) 
		, '1900-01-01 00:00:00.0000000 +00:00' 
		, 'SYSTEM | GHOST RECORD'
		, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-1' AS nchar(2))) 
		, '1900-01-01 00:00:00.0000000 +00:00' 
		, 'SYSTEM | NULL KEY - REQUIRED'
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-2' AS nchar(2))) 
		, '1900-01-01 00:00:00.0000000 +00:00' 
		, 'SYSTEM | NULL KEY - OPTIONAL'
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
	  );




-- L_Employee_Territory

INSERT INTO rv.L_Employee_Territory (
	  HK_L_Employee_Territory
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Employee
	, HK_H_Territory
)
VALUES
	  (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1))) 
		, '1900-01-01 00:00:00.0000000 +00:00' 
		, 'SYSTEM | GHOST RECORD'
		, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-1' AS nchar(2))) 
		, '1900-01-01 00:00:00.0000000 +00:00' 
		, 'SYSTEM | NULL KEY - REQUIRED'
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-2' AS nchar(2))) 
		, '1900-01-01 00:00:00.0000000 +00:00' 
		, 'SYSTEM | NULL KEY - OPTIONAL'
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
	  );




-- L_Order_Detail

INSERT INTO rv.L_Order_Detail (
	  HK_L_Order_Detail
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Order
	, HK_H_Product
)
VALUES
	  (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1))) 
		, '1900-01-01 00:00:00.0000000 +00:00' 
		, 'SYSTEM | GHOST RECORD'
		, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-1' AS nchar(2))) 
		, '1900-01-01 00:00:00.0000000 +00:00' 
		, 'SYSTEM | NULL KEY - REQUIRED'
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-2' AS nchar(2))) 
		, '1900-01-01 00:00:00.0000000 +00:00' 
		, 'SYSTEM | NULL KEY - OPTIONAL'
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
	  );




-- L_Order_Header

INSERT INTO rv.L_Order_Header (
	  HK_L_Order_Header
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Order__DK
	, HK_H_Customer
	, HK_H_Employee
	, HK_H_Shipper
)
VALUES
	  (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1))) 
		, '1900-01-01 00:00:00.0000000 +00:00' 
		, 'SYSTEM | GHOST RECORD'
		, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-1' AS nchar(2))) 
		, '1900-01-01 00:00:00.0000000 +00:00' 
		, 'SYSTEM | NULL KEY - REQUIRED'
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-2' AS nchar(2))) 
		, '1900-01-01 00:00:00.0000000 +00:00' 
		, 'SYSTEM | NULL KEY - OPTIONAL'
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
	  );




-- L_Product_Category

INSERT INTO rv.L_Product_Category (
	  HK_L_Product_Category
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Product__DK
	, HK_H_Product_Category
)
VALUES
	  (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1))) 
		, '1900-01-01 00:00:00.0000000 +00:00' 
		, 'SYSTEM | GHOST RECORD'
		, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-1' AS nchar(2))) 
		, '1900-01-01 00:00:00.0000000 +00:00' 
		, 'SYSTEM | NULL KEY - REQUIRED'
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-2' AS nchar(2))) 
		, '1900-01-01 00:00:00.0000000 +00:00' 
		, 'SYSTEM | NULL KEY - OPTIONAL'
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
	  );




-- L_Product_Supplier

INSERT INTO rv.L_Product_Supplier (
	  HK_L_Product_Supplier
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Product__DK
	, HK_H_Supplier
)
VALUES
	  (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1))) 
		, '1900-01-01 00:00:00.0000000 +00:00' 
		, 'SYSTEM | GHOST RECORD'
		, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-1' AS nchar(2))) 
		, '1900-01-01 00:00:00.0000000 +00:00' 
		, 'SYSTEM | NULL KEY - REQUIRED'
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-2' AS nchar(2))) 
		, '1900-01-01 00:00:00.0000000 +00:00' 
		, 'SYSTEM | NULL KEY - OPTIONAL'
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
	  );




-- L_Territory_Region

INSERT INTO rv.L_Territory_Region (
	  HK_L_Territory_Region
	, DV_Load_Datetime
	, DV_Record_Source
	, HK_H_Territory__DK
	, HK_H_Region
)
VALUES
	  (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1))) 
		, '1900-01-01 00:00:00.0000000 +00:00' 
		, 'SYSTEM | GHOST RECORD'
		, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-1' AS nchar(2))) 
		, '1900-01-01 00:00:00.0000000 +00:00' 
		, 'SYSTEM | NULL KEY - REQUIRED'
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2)))
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-2' AS nchar(2))) 
		, '1900-01-01 00:00:00.0000000 +00:00' 
		, 'SYSTEM | NULL KEY - OPTIONAL'
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
	  );




/* Hub standard satellites */

-- S_H_Customer_Northwind

INSERT INTO rv.S_H_Customer_Northwind (
	  HK_H_Customer
	, DV_Load_Datetime
	, DV_Record_Source
	, HD_S_H_Customer_Northwind
	, CompanyName
	, ContactName
	, ContactTitle
	, Address
	, City
	, Region
	, PostalCode
	, Country
	, Phone
	, Fax
)
VALUES
	  (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | GHOST RECORD'
		, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-1' AS nchar(2))) 
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - REQUIRED'
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2))) 
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - OPTIONAL'
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
	  );
GO




-- S_H_Customer_Type_Northwind

INSERT INTO rv.S_H_Customer_Type_Northwind (
	  HK_H_Customer_Type
	, DV_Load_Datetime
	, DV_Record_Source
	, HD_S_H_Customer_Type_Northwind
	, CustomerDesc
)
VALUES
	  (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | GHOST RECORD'
		, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, NULL
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-1' AS nchar(2))) 
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - REQUIRED'
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2))) 
		, NULL
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - OPTIONAL'
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, NULL
	  );
GO




-- S_H_Employee_Northwind

INSERT INTO rv.S_H_Employee_Northwind (
	  HK_H_Employee
	, DV_Load_Datetime
	, DV_Record_Source
	, HD_S_H_Employee_Northwind
	, LastName
	, FirstName
	, Title
	, TitleOfCourtesy
	, BirthDate
	, HireDate
	, [Address]
	, City
	, Region
	, PostalCode
	, Country
	, HomePhone
	, Extension
	, Photo
	, Notes
	, PhotoPath
)
VALUES
	  (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | GHOST RECORD'
		, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-1' AS nchar(2))) 
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - REQUIRED'
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2))) 
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - OPTIONAL'
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
	  );
GO




-- S_H_Order_Northwind

INSERT INTO rv.S_H_Order_Northwind (
	  HK_H_Order
	, DV_Load_Datetime
	, DV_Record_Source
	, HD_S_H_Order_Northwind
	, OrderDate
	, RequiredDate
	, ShippedDate
	, Freight
	, ShipName
	, ShipAddress
	, ShipCity
	, ShipRegion
	, ShipPostalCode
	, ShipCountry
)
VALUES
	  (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | GHOST RECORD'
		, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-1' AS nchar(2))) 
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - REQUIRED'
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2))) 
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - OPTIONAL'
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
	  );
GO




-- S_H_Product_Category_Northwind

INSERT INTO rv.S_H_Product_Category_Northwind (
	  HK_H_Product_Category
	, DV_Load_Datetime
	, DV_Record_Source
	, HD_S_H_Product_Category_Northwind
	, CategoryName
	, [Description]
	, Picture
)
VALUES
	  (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | GHOST RECORD'
		, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, NULL
		, NULL
		, NULL
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-1' AS nchar(2))) 
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - REQUIRED'
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2))) 
		, NULL
		, NULL
		, NULL
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - OPTIONAL'
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, NULL
		, NULL
		, NULL
	  );
GO




-- S_H_Product_Northwind

INSERT INTO rv.S_H_Product_Northwind (
	  HK_H_Product
	, DV_Load_Datetime
	, DV_Record_Source
	, HD_S_H_Product_Northwind
	, ProductName
	, QuantityPerUnit
	, UnitPrice
	, UnitsInStock
	, UnitsOnOrder
	, ReorderLevel
	, Discontinued
)
VALUES
	  (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | GHOST RECORD'
		, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-1' AS nchar(2))) 
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - REQUIRED'
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2))) 
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - OPTIONAL'
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
	  );
GO




-- S_H_Region_Northwind

INSERT INTO rv.S_H_Region_Northwind (
	  HK_H_Region
	, DV_Load_Datetime
	, DV_Record_Source
	, HD_S_H_Region_Northwind
	, RegionDescription
)
VALUES
	  (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | GHOST RECORD'
		, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, NULL
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-1' AS nchar(2))) 
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - REQUIRED'
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2))) 
		, NULL
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - OPTIONAL'
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, NULL
	  );
GO




-- S_H_Shipper_Northwind

INSERT INTO rv.S_H_Shipper_Northwind (
	  HK_H_Shipper
	, DV_Load_Datetime
	, DV_Record_Source
	, HD_S_H_Shipper_Northwind
	, CompanyName
	, Phone
)
VALUES
	  (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | GHOST RECORD'
		, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, NULL
		, NULL
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-1' AS nchar(2))) 
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - REQUIRED'
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2))) 
		, NULL
		, NULL
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - OPTIONAL'
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, NULL
		, NULL
	  );
GO




-- S_H_Supplier_Northwind

INSERT INTO rv.S_H_Supplier_Northwind (
	  HK_H_Supplier
	, DV_Load_Datetime
	, DV_Record_Source
	, HD_S_H_Supplier_Northwind
	, CompanyName
	, ContactName
	, ContactTitle
	, [Address]
	, City
	, Region
	, PostalCode
	, Country
	, Phone
	, Fax
	, HomePage
)
VALUES
	  (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | GHOST RECORD'
		, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-1' AS nchar(2))) 
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - REQUIRED'
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2))) 
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - OPTIONAL'
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
	  );
GO




-- S_H_Territory_Northwind

INSERT INTO rv.S_H_Territory_Northwind (
	  HK_H_Territory
	, DV_Load_Datetime
	, DV_Record_Source
	, HD_S_H_Territory_Northwind
	, TerritoryDescription
)
VALUES
	  (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | GHOST RECORD'
		, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, NULL
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-1' AS nchar(2))) 
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - REQUIRED'
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2))) 
		, NULL
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - OPTIONAL'
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, NULL
	  );
GO




/* Link standard satellites */

-- S_L_Order_Detail_Northwind

INSERT INTO rv.S_L_Order_Detail_Northwind (
	  HK_L_Order_Detail
	, DV_Load_Datetime
	, DV_Record_Source
	, HD_S_L_Order_Detail_Northwind
	, UnitPrice
	, Quantity
	, Discount
)
VALUES
	  (
		  HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | GHOST RECORD'
		, HASHBYTES('SHA2_256', CAST('0' AS nchar(1)))
		, NULL
		, NULL
		, NULL
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-1' AS nchar(2))) 
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - REQUIRED'
		, HASHBYTES('SHA2_256', CAST('-1' AS nchar(2))) 
		, NULL
		, NULL
		, NULL
	  )
	, (
		  HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, '1900-01-01 00:00:00.0000000 +00:00'
		, 'SYSTEM | NULL KEY - OPTIONAL'
		, HASHBYTES('SHA2_256', CAST('-2' AS nchar(2)))
		, NULL
		, NULL
		, NULL
	  );
GO