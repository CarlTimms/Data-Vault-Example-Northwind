/*

	Run data warehouse stored procedures

*/


-- Staging level one
EXEC Staging.northwind.usp_insert_L1_Northwind_Categories;
EXEC Staging.northwind.usp_insert_L1_Northwind_CustomerCustomerDemo;
EXEC Staging.northwind.usp_insert_L1_Northwind_CustomerDemographics;
EXEC Staging.northwind.usp_insert_L1_Northwind_Customers;
EXEC Staging.northwind.usp_insert_L1_Northwind_Employees;
EXEC Staging.northwind.usp_insert_L1_Northwind_EmployeeTerritories;
EXEC Staging.northwind.usp_insert_L1_Northwind_Order_Details;
EXEC Staging.northwind.usp_insert_L1_Northwind_Orders;
EXEC Staging.northwind.usp_insert_L1_Northwind_Products;
EXEC Staging.northwind.usp_insert_L1_Northwind_Region;
EXEC Staging.northwind.usp_insert_L1_Northwind_Shippers;
EXEC Staging.northwind.usp_insert_L1_Northwind_Suppliers;
EXEC Staging.northwind.usp_insert_L1_Northwind_Territories;


-- Staging level two
EXEC Staging.northwind.usp_insert_L2_Northwind_Categories__L1_Northwind_Categories;
EXEC Staging.northwind.usp_insert_L2_Northwind_CustomerCustomerDemo__L1_Northwind_CustomerCustomerDemo;
EXEC Staging.northwind.usp_insert_L2_Northwind_CustomerDemographics__L1_Northwind_CustomerDemographics;
EXEC Staging.northwind.usp_insert_L2_Northwind_Customers__L1_Northwind_Customers;
EXEC Staging.northwind.usp_insert_L2_Northwind_Employees__L1_Northwind_Employees;
EXEC Staging.northwind.usp_insert_L2_Northwind_EmployeeTerritories__L1_Northwind_EmployeeTerritories;
EXEC Staging.northwind.usp_insert_L2_Northwind_Order_Details__L1_Northwind_Order_Details;
EXEC Staging.northwind.usp_insert_L2_Northwind_Orders__L1_Northwind_Orders;
EXEC Staging.northwind.usp_insert_L2_Northwind_Products__L1_Northwind_Products;
EXEC Staging.northwind.usp_insert_L2_Northwind_Region__L1_Northwind_Region;
EXEC Staging.northwind.usp_insert_L2_Northwind_Shippers__L1_Northwind_Shippers;
EXEC Staging.northwind.usp_insert_L2_Northwind_Suppliers__L1_Northwind_Suppliers;
EXEC Staging.northwind.usp_insert_L2_Northwind_Territories__L1_Northwind_Territories;


-- Raw data vault reference
EXEC Data_Vault.rv.usp_insert_R_Date;
EXEC Data_Vault.rv.usp_insert_R_Time;


-- Raw data vault hubs
EXEC Data_Vault.rv.usp_insert_H_Customer__L2_Northwind_CustomerCustomerDemo;
EXEC Data_Vault.rv.usp_insert_H_Customer__L2_Northwind_Customers;
EXEC Data_Vault.rv.usp_insert_H_Customer__L2_Northwind_Orders;
EXEC Data_Vault.rv.usp_insert_H_Customer_Type__L2_Northwind_CustomerCustomerDemo;
EXEC Data_Vault.rv.usp_insert_H_Customer_Type__L2_Northwind_CustomerDemographics;
EXEC Data_Vault.rv.usp_insert_H_Employee__L2_Northwind_Employees__EmployeeID;
EXEC Data_Vault.rv.usp_insert_H_Employee__L2_Northwind_Employees__ReportsTo;
EXEC Data_Vault.rv.usp_insert_H_Employee__L2_Northwind_EmployeeTerritories;
EXEC Data_Vault.rv.usp_insert_H_Employee__L2_Northwind_Orders;
EXEC Data_Vault.rv.usp_insert_H_Order__L2_Northwind_Order_Details;
EXEC Data_Vault.rv.usp_insert_H_Order__L2_Northwind_Orders;
EXEC Data_Vault.rv.usp_insert_H_Product__L2_Northwind_Order_Details;
EXEC Data_Vault.rv.usp_insert_H_Product__L2_Northwind_Products;
EXEC Data_Vault.rv.usp_insert_H_Product_Category__L2_Northwind_Categories;
EXEC Data_Vault.rv.usp_insert_H_Product_Category__L2_Northwind_Products;
EXEC Data_Vault.rv.usp_insert_H_Region__L2_Northwind_Region;
EXEC Data_Vault.rv.usp_insert_H_Region__L2_Northwind_Territories;
EXEC Data_Vault.rv.usp_insert_H_Shipper__L2_Northwind_Orders;
EXEC Data_Vault.rv.usp_insert_H_Shipper__L2_Northwind_Shippers;
EXEC Data_Vault.rv.usp_insert_H_Supplier__L2_Northwind_Products;
EXEC Data_Vault.rv.usp_insert_H_Supplier__L2_Northwind_Suppliers;
EXEC Data_Vault.rv.usp_insert_H_Territory__L2_Northwind_EmployeeTerritories;
EXEC Data_Vault.rv.usp_insert_H_Territory__L2_Northwind_Territories;


-- Raw data vault links
EXEC Data_Vault.rv.usp_insert_L_Customer_Type__L2_Northwind_CustomerCustomerDemo;
EXEC Data_Vault.rv.usp_insert_L_Employee_Reporting_Line__L2_Northwind_Employees;
EXEC Data_Vault.rv.usp_insert_L_Employee_Territory__L2_Northwind_EmployeeTerritories;
EXEC Data_Vault.rv.usp_insert_L_Order_Detail__L2_Northwind_Order_Details;
EXEC Data_Vault.rv.usp_insert_L_Order_Header__L2_Northwind_Orders;
EXEC Data_Vault.rv.usp_insert_L_Product_Category__L2_Northwind_Products;
EXEC Data_Vault.rv.usp_insert_L_Product_Supplier__L2_Northwind_Products;
EXEC Data_Vault.rv.usp_insert_L_Territory_Region__L2_Northwind_Territories;


-- Raw data vault hub standard satellites
EXEC Data_Vault.rv.usp_insert_S_H_Customer_Northwind__L2_Northwind_Customers;
EXEC Data_Vault.rv.usp_insert_S_H_Customer_Type_Northwind__L2_Northwind_CustomerDemographics;
EXEC Data_Vault.rv.usp_insert_S_H_Employee_Northwind__L2_Northwind_Employees;
EXEC Data_Vault.rv.usp_insert_S_H_Order_Northwind__L2_Northwind_Orders;
EXEC Data_Vault.rv.usp_insert_S_H_Product_Category_Northwind__L2_Northwind_Categories;
EXEC Data_Vault.rv.usp_insert_S_H_Product_Northwind__L2_Northwind_Products;
EXEC Data_Vault.rv.usp_insert_S_H_Region_Northwind__L2_Northwind_Region;
EXEC Data_Vault.rv.usp_insert_S_H_Shipper_Northwind__L2_Northwind_Shippers;
EXEC Data_Vault.rv.usp_insert_S_H_Supplier_Northwind__L2_Northwind_Suppliers;
EXEC Data_Vault.rv.usp_insert_S_H_Territory_Northwind__L2_Northwind_Territories;


-- Raw data vault link standard satellites
EXEC Data_Vault.rv.usp_insert_S_L_Order_Detail_Northwind__L2_Northwind_Order_Details;


-- Business data vault link effectivity satellites
EXEC Data_Vault.bv.usp_insert_S_LE_L_Employee_Reporting_Line_Northwind__L2_Northwind_Employees;
EXEC Data_Vault.bv.usp_insert_S_LE_L_Order_Header_Northwind__L2_Northwind_Orders;
EXEC Data_Vault.bv.usp_insert_S_LE_L_Product_Category_Northwind__L2_Northwind_Products;
EXEC Data_Vault.bv.usp_insert_S_LE_L_Product_Supplier_Northwind__L2_Northwind_Products;
EXEC Data_Vault.bv.usp_insert_S_LE_L_Territory_Region_Northwind__L2_Northwind_Territories;


-- Business data vault hub record tracking satellites 
EXEC Data_Vault.bv.usp_insert_S_HRT_H_Customer_Northwind__L2_Northwind_Customers;
EXEC Data_Vault.bv.usp_insert_S_HRT_H_Customer_Type_Northwind__L2_Northwind_CustomerDemographics;
EXEC Data_Vault.bv.usp_insert_S_HRT_H_Employee_Northwind__L2_Northwind_Employees;
EXEC Data_Vault.bv.usp_insert_S_HRT_H_Order_Northwind__L2_Northwind_Orders;
EXEC Data_Vault.bv.usp_insert_S_HRT_H_Product_Category_Northwind__L2_Northwind_Categories;
EXEC Data_Vault.bv.usp_insert_S_HRT_H_Product_Northwind__L2_Northwind_Products;
EXEC Data_Vault.bv.usp_insert_S_HRT_H_Region_Northwind__L2_Northwind_Region;
EXEC Data_Vault.bv.usp_insert_S_HRT_H_Shipper_Northwind__L2_Northwind_Shippers;
EXEC Data_Vault.bv.usp_insert_S_HRT_H_Supplier_Northwind__L2_Northwind_Suppliers;
EXEC Data_Vault.bv.usp_insert_S_HRT_H_Territory_Northwind__L2_Northwind_Territories;
EXEC Data_Vault.bv.usp_delete_S_HRT_H_Customer_Northwind;
EXEC Data_Vault.bv.usp_delete_S_HRT_H_Customer_Type_Northwind;
EXEC Data_Vault.bv.usp_delete_S_HRT_H_Employee_Northwind;
EXEC Data_Vault.bv.usp_delete_S_HRT_H_Order_Northwind;
EXEC Data_Vault.bv.usp_delete_S_HRT_H_Product_Category_Northwind;
EXEC Data_Vault.bv.usp_delete_S_HRT_H_Product_Northwind;
EXEC Data_Vault.bv.usp_delete_S_HRT_H_Region_Northwind;
EXEC Data_Vault.bv.usp_delete_S_HRT_H_Shipper_Northwind;
EXEC Data_Vault.bv.usp_delete_S_HRT_H_Supplier_Northwind;
EXEC Data_Vault.bv.usp_delete_S_HRT_H_Territory_Northwind;


-- Business data vault link record tracking satellites
EXEC Data_Vault.bv.usp_delete_S_LRT_L_Customer_Type_Northwind;
EXEC Data_Vault.bv.usp_delete_S_LRT_L_Employee_Territory_Northwind;
EXEC Data_Vault.bv.usp_delete_S_LRT_L_Order_Detail_Northwind;
EXEC Data_Vault.bv.usp_insert_S_LRT_L_Customer_Type_Northwind__L2_Northwind_CustomerCustomerDemo;
EXEC Data_Vault.bv.usp_insert_S_LRT_L_Employee_Territory_Northwind__L2_Northwind_EmployeeTerritories;
EXEC Data_Vault.bv.usp_insert_S_LRT_L_Order_Detail_Northwind__L2_Northwind_Order_Details;


-- Business data vault hub deletion tracking satellites
EXEC Data_Vault.bv.usp_insert_S_HDT_H_Customer_Northwind__S_HRT_H_Customer_Northwind;
EXEC Data_Vault.bv.usp_insert_S_HDT_H_Customer_Type_Northwind__S_HRT_H_Customer_Type_Northwind;
EXEC Data_Vault.bv.usp_insert_S_HDT_H_Employee_Northwind__S_HRT_H_Employee_Northwind;
EXEC Data_Vault.bv.usp_insert_S_HDT_H_Order_Northwind__S_HRT_H_Order_Northwind;
EXEC Data_Vault.bv.usp_insert_S_HDT_H_Product_Category_Northwind__S_HRT_H_Product_Category_Northwind;
EXEC Data_Vault.bv.usp_insert_S_HDT_H_Product_Northwind__S_HRT_H_Product_Northwind;
EXEC Data_Vault.bv.usp_insert_S_HDT_H_Region_Northwind__S_HRT_H_Region_Northwind;
EXEC Data_Vault.bv.usp_insert_S_HDT_H_Shipper_Northwind__S_HRT_H_Shipper_Northwind;
EXEC Data_Vault.bv.usp_insert_S_HDT_H_Supplier_Northwind__S_HRT_H_Supplier_Northwind;
EXEC Data_Vault.bv.usp_insert_S_HDT_H_Territory_Northwind__S_HRT_H_Territory_Northwind;


-- Business data vault link deletion tracking satellites
EXEC Data_Vault.bv.usp_insert_S_LDT_L_Customer_Type_Northwind__S_LRT_L_Customer_Type_Northwind;
EXEC Data_Vault.bv.usp_insert_S_LDT_L_Employee_Territory_Northwind__S_LRT_L_Employee_Territory_Northwind;
EXEC Data_Vault.bv.usp_insert_S_LDT_L_Order_Detail_Northwind__S_LRT_L_Order_Detail_Northwind;


-- Business data vault reference tables
EXEC Information_Mart.bv.usp_insert_R_Snapshot_Control;


-- Business data vault PIT tables
EXEC Information_Mart.bv.usp_delete_PIT_Customer;
EXEC Information_Mart.bv.usp_delete_PIT_Customer_Type;
EXEC Information_Mart.bv.usp_delete_PIT_Employee;
EXEC Information_Mart.bv.usp_delete_PIT_Order;
EXEC Information_Mart.bv.usp_delete_PIT_Order_Detail;
EXEC Information_Mart.bv.usp_delete_PIT_Product;
EXEC Information_Mart.bv.usp_delete_PIT_Product_Category;
EXEC Information_Mart.bv.usp_delete_PIT_Region;
EXEC Information_Mart.bv.usp_delete_PIT_Shipper;
EXEC Information_Mart.bv.usp_delete_PIT_Supplier;
EXEC Information_Mart.bv.usp_delete_PIT_Territory;
EXEC Information_Mart.bv.usp_insert_PIT_Customer;
EXEC Information_Mart.bv.usp_insert_PIT_Customer_Type;
EXEC Information_Mart.bv.usp_insert_PIT_Employee;
EXEC Information_Mart.bv.usp_insert_PIT_Order;
EXEC Information_Mart.bv.usp_insert_PIT_Order_Detail;
EXEC Information_Mart.bv.usp_insert_PIT_Product;
EXEC Information_Mart.bv.usp_insert_PIT_Product_Category;
EXEC Information_Mart.bv.usp_insert_PIT_Region;
EXEC Information_Mart.bv.usp_insert_PIT_Shipper;
EXEC Information_Mart.bv.usp_insert_PIT_Supplier;
EXEC Information_Mart.bv.usp_insert_PIT_Territory;


-- Business data vault bridge tables
EXEC Information_Mart.bv.usp_delete_B_Customer_Type;
EXEC Information_Mart.bv.usp_delete_B_Employee_Reporting_Line;
EXEC Information_Mart.bv.usp_delete_B_Employee_Territory;
EXEC Information_Mart.bv.usp_delete_B_Order;
EXEC Information_Mart.bv.usp_delete_B_Order_Detail;
EXEC Information_Mart.bv.usp_delete_B_Product_Supplier_Category;
EXEC Information_Mart.bv.usp_delete_B_Territory_Region;
EXEC Information_Mart.bv.usp_insert_B_Customer_Type;
EXEC Information_Mart.bv.usp_insert_B_Employee_Reporting_Line;
EXEC Information_Mart.bv.usp_insert_B_Employee_Territory;
EXEC Information_Mart.bv.usp_insert_B_Order;
EXEC Information_Mart.bv.usp_insert_B_Order_Detail;
EXEC Information_Mart.bv.usp_insert_B_Product_Supplier_Category;
EXEC Information_Mart.bv.usp_insert_B_Territory_Region;