/*

	Truncate all tables

*/


--SELECT
--	CONCAT(
--		  'TRUNCATE TABLE '
--		, TABLE_CATALOG
--		, '.'
--		, TABLE_SCHEMA
--		, '.'
--		, TABLE_NAME
--		, ';'
--	) AS Truncate_Statement
--FROM
--	INFORMATION_SCHEMA.TABLES
--WHERE
--	TABLE_TYPE = 'BASE TABLE'
--ORDER BY
--	  TABLE_SCHEMA
--	, TABLE_NAME;


-- Staging
TRUNCATE TABLE Staging.northwind.L1_Northwind_Categories;
TRUNCATE TABLE Staging.northwind.L1_Northwind_CustomerCustomerDemo;
TRUNCATE TABLE Staging.northwind.L1_Northwind_CustomerDemographics;
TRUNCATE TABLE Staging.northwind.L1_Northwind_Customers;
TRUNCATE TABLE Staging.northwind.L1_Northwind_Employees;
TRUNCATE TABLE Staging.northwind.L1_Northwind_EmployeeTerritories;
TRUNCATE TABLE Staging.northwind.L1_Northwind_Order_Details;
TRUNCATE TABLE Staging.northwind.L1_Northwind_Orders;
TRUNCATE TABLE Staging.northwind.L1_Northwind_Products;
TRUNCATE TABLE Staging.northwind.L1_Northwind_Region;
TRUNCATE TABLE Staging.northwind.L1_Northwind_Shippers;
TRUNCATE TABLE Staging.northwind.L1_Northwind_Suppliers;
TRUNCATE TABLE Staging.northwind.L1_Northwind_Territories;
TRUNCATE TABLE Staging.northwind.L2_Northwind_Categories;
TRUNCATE TABLE Staging.northwind.L2_Northwind_CustomerCustomerDemo;
TRUNCATE TABLE Staging.northwind.L2_Northwind_CustomerDemographics;
TRUNCATE TABLE Staging.northwind.L2_Northwind_Customers;
TRUNCATE TABLE Staging.northwind.L2_Northwind_Employees;
TRUNCATE TABLE Staging.northwind.L2_Northwind_EmployeeTerritories;
TRUNCATE TABLE Staging.northwind.L2_Northwind_Order_Details;
TRUNCATE TABLE Staging.northwind.L2_Northwind_Orders;
TRUNCATE TABLE Staging.northwind.L2_Northwind_Products;
TRUNCATE TABLE Staging.northwind.L2_Northwind_Region;
TRUNCATE TABLE Staging.northwind.L2_Northwind_Shippers;
TRUNCATE TABLE Staging.northwind.L2_Northwind_Suppliers;
TRUNCATE TABLE Staging.northwind.L2_Northwind_Territories;

-- Data Vault
TRUNCATE TABLE Data_Vault.bv.S_HDT_H_Customer_Northwind;
TRUNCATE TABLE Data_Vault.bv.S_HDT_H_Customer_Type_Northwind;
TRUNCATE TABLE Data_Vault.bv.S_HDT_H_Employee_Northwind;
TRUNCATE TABLE Data_Vault.bv.S_HDT_H_Order_Northwind;
TRUNCATE TABLE Data_Vault.bv.S_HDT_H_Product_Category_Northwind;
TRUNCATE TABLE Data_Vault.bv.S_HDT_H_Product_Northwind;
TRUNCATE TABLE Data_Vault.bv.S_HDT_H_Region_Northwind;
TRUNCATE TABLE Data_Vault.bv.S_HDT_H_Shipper_Northwind;
TRUNCATE TABLE Data_Vault.bv.S_HDT_H_Supplier_Northwind;
TRUNCATE TABLE Data_Vault.bv.S_HDT_H_Territory_Northwind;
TRUNCATE TABLE Data_Vault.bv.S_HRT_H_Customer_Northwind;
TRUNCATE TABLE Data_Vault.bv.S_HRT_H_Customer_Type_Northwind;
TRUNCATE TABLE Data_Vault.bv.S_HRT_H_Employee_Northwind;
TRUNCATE TABLE Data_Vault.bv.S_HRT_H_Order_Northwind;
TRUNCATE TABLE Data_Vault.bv.S_HRT_H_Product_Category_Northwind;
TRUNCATE TABLE Data_Vault.bv.S_HRT_H_Product_Northwind;
TRUNCATE TABLE Data_Vault.bv.S_HRT_H_Region_Northwind;
TRUNCATE TABLE Data_Vault.bv.S_HRT_H_Shipper_Northwind;
TRUNCATE TABLE Data_Vault.bv.S_HRT_H_Supplier_Northwind;
TRUNCATE TABLE Data_Vault.bv.S_HRT_H_Territory_Northwind;
TRUNCATE TABLE Data_Vault.bv.S_LDT_L_Customer_Type_Northwind;
TRUNCATE TABLE Data_Vault.bv.S_LDT_L_Employee_Territory_Northwind;
TRUNCATE TABLE Data_Vault.bv.S_LDT_L_Order_Detail_Northwind;
TRUNCATE TABLE Data_Vault.bv.S_LE_L_Employee_Reporting_Line_Northwind;
TRUNCATE TABLE Data_Vault.bv.S_LE_L_Order_Header_Northwind;
TRUNCATE TABLE Data_Vault.bv.S_LE_L_Product_Category_Northwind;
TRUNCATE TABLE Data_Vault.bv.S_LE_L_Product_Supplier_Northwind;
TRUNCATE TABLE Data_Vault.bv.S_LE_L_Territory_Region_Northwind;
TRUNCATE TABLE Data_Vault.bv.S_LRT_L_Customer_Type_Northwind;
TRUNCATE TABLE Data_Vault.bv.S_LRT_L_Employee_Territory_Northwind;
TRUNCATE TABLE Data_Vault.bv.S_LRT_L_Order_Detail_Northwind;
TRUNCATE TABLE Data_Vault.rv.H_Customer;
TRUNCATE TABLE Data_Vault.rv.H_Customer_Type;
TRUNCATE TABLE Data_Vault.rv.H_Employee;
TRUNCATE TABLE Data_Vault.rv.H_Order;
TRUNCATE TABLE Data_Vault.rv.H_Product;
TRUNCATE TABLE Data_Vault.rv.H_Product_Category;
TRUNCATE TABLE Data_Vault.rv.H_Region;
TRUNCATE TABLE Data_Vault.rv.H_Shipper;
TRUNCATE TABLE Data_Vault.rv.H_Supplier;
TRUNCATE TABLE Data_Vault.rv.H_Territory;
TRUNCATE TABLE Data_Vault.rv.L_Customer_Type;
TRUNCATE TABLE Data_Vault.rv.L_Employee_Reporting_Line;
TRUNCATE TABLE Data_Vault.rv.L_Employee_Territory;
TRUNCATE TABLE Data_Vault.rv.L_Order_Detail;
TRUNCATE TABLE Data_Vault.rv.L_Order_Header;
TRUNCATE TABLE Data_Vault.rv.L_Product_Category;
TRUNCATE TABLE Data_Vault.rv.L_Product_Supplier;
TRUNCATE TABLE Data_Vault.rv.L_Territory_Region;
TRUNCATE TABLE Data_Vault.rv.R_Date;
TRUNCATE TABLE Data_Vault.rv.R_Time;
TRUNCATE TABLE Data_Vault.rv.S_H_Customer_Northwind;
TRUNCATE TABLE Data_Vault.rv.S_H_Customer_Type_Northwind;
TRUNCATE TABLE Data_Vault.rv.S_H_Employee_Northwind;
TRUNCATE TABLE Data_Vault.rv.S_H_Order_Northwind;
TRUNCATE TABLE Data_Vault.rv.S_H_Product_Category_Northwind;
TRUNCATE TABLE Data_Vault.rv.S_H_Product_Northwind;
TRUNCATE TABLE Data_Vault.rv.S_H_Region_Northwind;
TRUNCATE TABLE Data_Vault.rv.S_H_Shipper_Northwind;
TRUNCATE TABLE Data_Vault.rv.S_H_Supplier_Northwind;
TRUNCATE TABLE Data_Vault.rv.S_H_Territory_Northwind;
TRUNCATE TABLE Data_Vault.rv.S_L_Order_Detail_Northwind;

-- Information_Mart
TRUNCATE TABLE Information_Mart.bv.B_Customer_Type;
TRUNCATE TABLE Information_Mart.bv.B_Employee_Reporting_Line;
TRUNCATE TABLE Information_Mart.bv.B_Employee_Territory;
TRUNCATE TABLE Information_Mart.bv.B_Order;
TRUNCATE TABLE Information_Mart.bv.B_Order_Detail;
TRUNCATE TABLE Information_Mart.bv.B_Product_Supplier_Category;
TRUNCATE TABLE Information_Mart.bv.B_Territory_Region;
TRUNCATE TABLE Information_Mart.bv.PIT_Customer;
TRUNCATE TABLE Information_Mart.bv.PIT_Customer_Type;
TRUNCATE TABLE Information_Mart.bv.PIT_Employee;
TRUNCATE TABLE Information_Mart.bv.PIT_Order;
TRUNCATE TABLE Information_Mart.bv.PIT_Order_Detail;
TRUNCATE TABLE Information_Mart.bv.PIT_Product;
TRUNCATE TABLE Information_Mart.bv.PIT_Product_Category;
TRUNCATE TABLE Information_Mart.bv.PIT_Region;
TRUNCATE TABLE Information_Mart.bv.PIT_Shipper;
TRUNCATE TABLE Information_Mart.bv.PIT_Supplier;
TRUNCATE TABLE Information_Mart.bv.PIT_Territory;
TRUNCATE TABLE Information_Mart.bv.R_Snapshot_Control;
