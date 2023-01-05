/*

	Run data warehouse loading stored procedures

	CT
	2022-08-25

*/


/* Staging */

EXEC [Stage_Area].[northwind].[usp_Load_Northwind_Categories];
EXEC [Stage_Area].[northwind].[usp_Load_Northwind_CustomerCustomerDemo];
EXEC [Stage_Area].[northwind].[usp_Load_Northwind_CustomerDemographics];
EXEC [Stage_Area].[northwind].[usp_Load_Northwind_Customers];
EXEC [Stage_Area].[northwind].[usp_Load_Northwind_Employees];
EXEC [Stage_Area].[northwind].[usp_Load_Northwind_EmployeeTerritories];
EXEC [Stage_Area].[northwind].[usp_Load_Northwind_Order_Details];
EXEC [Stage_Area].[northwind].[usp_Load_Northwind_Orders];
EXEC [Stage_Area].[northwind].[usp_Load_Northwind_Products];
EXEC [Stage_Area].[northwind].[usp_Load_Northwind_Region];
EXEC [Stage_Area].[northwind].[usp_Load_Northwind_Shippers];
EXEC [Stage_Area].[northwind].[usp_Load_Northwind_Suppliers];
EXEC [Stage_Area].[northwind].[usp_Load_Northwind_Territories];


/* Raw Data Vault - Reference */

EXEC [Data_Vault].[raw].[usp_Load_R_Date];


/* Raw Data Vault - Hub */

EXEC [Data_Vault].[raw].[usp_Load_H_Customer];
EXEC [Data_Vault].[raw].[usp_Load_H_Customer_Type];
EXEC [Data_Vault].[raw].[usp_Load_H_Employee];
EXEC [Data_Vault].[raw].[usp_Load_H_Order];
EXEC [Data_Vault].[raw].[usp_Load_H_Order_Detail];
EXEC [Data_Vault].[raw].[usp_Load_H_Product];
EXEC [Data_Vault].[raw].[usp_Load_H_Product_Category];
EXEC [Data_Vault].[raw].[usp_Load_H_Region];
EXEC [Data_Vault].[raw].[usp_Load_H_Shipper];
EXEC [Data_Vault].[raw].[usp_Load_H_Supplier];
EXEC [Data_Vault].[raw].[usp_Load_H_Territory];


/* Raw Data Vault - Link */

EXEC [Data_Vault].[raw].[usp_Load_L_Customer_Type];
EXEC [Data_Vault].[raw].[usp_Load_L_Employee_Reporting_Line];
EXEC [Data_Vault].[raw].[usp_Load_L_Employee_Territory];
EXEC [Data_Vault].[raw].[usp_Load_L_Order_Detail];
EXEC [Data_Vault].[raw].[usp_Load_L_Order_Header];
EXEC [Data_Vault].[raw].[usp_Load_L_Product_Category];
EXEC [Data_Vault].[raw].[usp_Load_L_Product_Supplier];
EXEC [Data_Vault].[raw].[usp_Load_L_Territory_Region];


/* Raw Data Vault - Satellite */

EXEC [Data_Vault].[raw].[usp_Load_S_HC_Customer_Northwind];
EXEC [Data_Vault].[raw].[usp_Load_S_HC_Customer_Type_Northwind];
EXEC [Data_Vault].[raw].[usp_Load_S_HC_Employee_Northwind];
EXEC [Data_Vault].[raw].[usp_Load_S_HC_Order_Detail_Northwind];
EXEC [Data_Vault].[raw].[usp_Load_S_HC_Order_Northwind];
EXEC [Data_Vault].[raw].[usp_Load_S_HC_Product_Category_Northwind];
EXEC [Data_Vault].[raw].[usp_Load_S_HC_Product_Northwind];
EXEC [Data_Vault].[raw].[usp_Load_S_HC_Region_Northwind];
EXEC [Data_Vault].[raw].[usp_Load_S_HC_Shipper_Northwind];
EXEC [Data_Vault].[raw].[usp_Load_S_HC_Supplier_Northwind];
EXEC [Data_Vault].[raw].[usp_Load_S_HC_Territory_Northwind];
EXEC [Data_Vault].[raw].[usp_Load_S_HT_Customer_Northwind];
EXEC [Data_Vault].[raw].[usp_Load_S_HT_Customer_Type_Northwind];
EXEC [Data_Vault].[raw].[usp_Load_S_HT_Employee_Northwind];
EXEC [Data_Vault].[raw].[usp_Load_S_HT_Order_Detail_Northwind];
EXEC [Data_Vault].[raw].[usp_Load_S_HT_Order_Northwind];
EXEC [Data_Vault].[raw].[usp_Load_S_HT_Product_Category_Northwind];
EXEC [Data_Vault].[raw].[usp_Load_S_HT_Product_Northwind];
EXEC [Data_Vault].[raw].[usp_Load_S_HT_Region_Northwind];
EXEC [Data_Vault].[raw].[usp_Load_S_HT_Shipper_Northwind];
EXEC [Data_Vault].[raw].[usp_Load_S_HT_Supplier_Northwind];
EXEC [Data_Vault].[raw].[usp_Load_S_HT_Territory_Northwind];
EXEC [Data_Vault].[raw].[usp_Load_S_LE_Employee_Reporting_Line_Northwind];
EXEC [Data_Vault].[raw].[usp_Load_S_LE_Order_Header_Northwind];
EXEC [Data_Vault].[raw].[usp_Load_S_LE_Product_Category_Northwind];
EXEC [Data_Vault].[raw].[usp_Load_S_LE_Product_Supplier_Northwind];
EXEC [Data_Vault].[raw].[usp_Load_S_LE_Territory_Region_Northwind];
EXEC [Data_Vault].[raw].[usp_Load_S_LT_Customer_Type_Northwind];
EXEC [Data_Vault].[raw].[usp_Load_S_LT_Employee_Territory_Northwind];


/* Business Vault - PIT */

EXEC [Data_Vault].[biz].[usp_Load_PIT_Customer];
EXEC [Data_Vault].[biz].[usp_Load_PIT_Customer_Type];
EXEC [Data_Vault].[biz].[usp_Load_PIT_Employee];
EXEC [Data_Vault].[biz].[usp_Load_PIT_Order];
EXEC [Data_Vault].[biz].[usp_Load_PIT_Order_Detail];
EXEC [Data_Vault].[biz].[usp_Load_PIT_Product];
EXEC [Data_Vault].[biz].[usp_Load_PIT_Product_Category];
EXEC [Data_Vault].[biz].[usp_Load_PIT_Region];
EXEC [Data_Vault].[biz].[usp_Load_PIT_Shipper];
EXEC [Data_Vault].[biz].[usp_Load_PIT_Supplier];
EXEC [Data_Vault].[biz].[usp_Load_PIT_Territory];


/* Business Vault - Bridge */

EXEC [Data_Vault].[biz].[usp_Load_B_Order];
EXEC [Data_Vault].[biz].[usp_Load_B_Order_Detail];