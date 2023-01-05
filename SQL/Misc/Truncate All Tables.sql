/*

	Truncate data from Data Vault tables.

	CT
	2023-01-05

*/


--SELECT
--	CONCAT(
--		  'TRUNCATE TABLE ['
--		, [TABLE_CATALOG]
--		, '].['
--		, [TABLE_SCHEMA]
--		, '].['
--		, [TABLE_NAME]
--		, '];'
--	) AS Truncate_Statement
--FROM
--	INFORMATION_SCHEMA.TABLES
--WHERE
--	[TABLE_TYPE] = 'BASE TABLE'
--ORDER BY
--	  [TABLE_SCHEMA]
--	, [TABLE_NAME]


TRUNCATE TABLE [Stage_Area].[northwind].[Categories];
TRUNCATE TABLE [Stage_Area].[northwind].[CustomerCustomerDemo];
TRUNCATE TABLE [Stage_Area].[northwind].[CustomerDemographics];
TRUNCATE TABLE [Stage_Area].[northwind].[Customers];
TRUNCATE TABLE [Stage_Area].[northwind].[Employees];
TRUNCATE TABLE [Stage_Area].[northwind].[EmployeeTerritories];
TRUNCATE TABLE [Stage_Area].[northwind].[Order Details];
TRUNCATE TABLE [Stage_Area].[northwind].[Orders];
TRUNCATE TABLE [Stage_Area].[northwind].[Products];
TRUNCATE TABLE [Stage_Area].[northwind].[Region];
TRUNCATE TABLE [Stage_Area].[northwind].[Shippers];
TRUNCATE TABLE [Stage_Area].[northwind].[Suppliers];
TRUNCATE TABLE [Stage_Area].[northwind].[Territories];

TRUNCATE TABLE [Data_Vault].[biz].[B_Order];
TRUNCATE TABLE [Data_Vault].[biz].[B_Order_Detail];
TRUNCATE TABLE [Data_Vault].[biz].[PIT_Customer];
TRUNCATE TABLE [Data_Vault].[biz].[PIT_Customer_Type];
TRUNCATE TABLE [Data_Vault].[biz].[PIT_Employee];
TRUNCATE TABLE [Data_Vault].[biz].[PIT_Order];
TRUNCATE TABLE [Data_Vault].[biz].[PIT_Order_Detail];
TRUNCATE TABLE [Data_Vault].[biz].[PIT_Product];
TRUNCATE TABLE [Data_Vault].[biz].[PIT_Product_Category];
TRUNCATE TABLE [Data_Vault].[biz].[PIT_Region];
TRUNCATE TABLE [Data_Vault].[biz].[PIT_Shipper];
TRUNCATE TABLE [Data_Vault].[biz].[PIT_Supplier];
TRUNCATE TABLE [Data_Vault].[biz].[PIT_Territory];
TRUNCATE TABLE [Data_Vault].[raw].[H_Customer];
TRUNCATE TABLE [Data_Vault].[raw].[H_Customer_Type];
TRUNCATE TABLE [Data_Vault].[raw].[H_Employee];
TRUNCATE TABLE [Data_Vault].[raw].[H_Order];
TRUNCATE TABLE [Data_Vault].[raw].[H_Order_Detail];
TRUNCATE TABLE [Data_Vault].[raw].[H_Product];
TRUNCATE TABLE [Data_Vault].[raw].[H_Product_Category];
TRUNCATE TABLE [Data_Vault].[raw].[H_Region];
TRUNCATE TABLE [Data_Vault].[raw].[H_Shipper];
TRUNCATE TABLE [Data_Vault].[raw].[H_Supplier];
TRUNCATE TABLE [Data_Vault].[raw].[H_Territory];
TRUNCATE TABLE [Data_Vault].[raw].[L_Customer_Type];
TRUNCATE TABLE [Data_Vault].[raw].[L_Employee_Reporting_Line];
TRUNCATE TABLE [Data_Vault].[raw].[L_Employee_Territory];
TRUNCATE TABLE [Data_Vault].[raw].[L_Order_Detail];
TRUNCATE TABLE [Data_Vault].[raw].[L_Order_Header];
TRUNCATE TABLE [Data_Vault].[raw].[L_Product_Category];
TRUNCATE TABLE [Data_Vault].[raw].[L_Product_Supplier];
TRUNCATE TABLE [Data_Vault].[raw].[L_Territory_Region];
TRUNCATE TABLE [Data_Vault].[raw].[R_Date];
TRUNCATE TABLE [Data_Vault].[raw].[S_HC_Customer_Northwind];
TRUNCATE TABLE [Data_Vault].[raw].[S_HC_Customer_Type_Northwind];
TRUNCATE TABLE [Data_Vault].[raw].[S_HC_Employee_Northwind];
TRUNCATE TABLE [Data_Vault].[raw].[S_HC_Order_Detail_Northwind];
TRUNCATE TABLE [Data_Vault].[raw].[S_HC_Order_Northwind];
TRUNCATE TABLE [Data_Vault].[raw].[S_HC_Product_Category_Northwind];
TRUNCATE TABLE [Data_Vault].[raw].[S_HC_Product_Northwind];
TRUNCATE TABLE [Data_Vault].[raw].[S_HC_Region_Northwind];
TRUNCATE TABLE [Data_Vault].[raw].[S_HC_Shipper_Northwind];
TRUNCATE TABLE [Data_Vault].[raw].[S_HC_Supplier_Northwind];
TRUNCATE TABLE [Data_Vault].[raw].[S_HC_Territory_Northwind];
TRUNCATE TABLE [Data_Vault].[raw].[S_HT_Customer_Northwind];
TRUNCATE TABLE [Data_Vault].[raw].[S_HT_Customer_Type_Northwind];
TRUNCATE TABLE [Data_Vault].[raw].[S_HT_Employee_Northwind];
TRUNCATE TABLE [Data_Vault].[raw].[S_HT_Order_Detail_Northwind];
TRUNCATE TABLE [Data_Vault].[raw].[S_HT_Order_Northwind];
TRUNCATE TABLE [Data_Vault].[raw].[S_HT_Product_Category_Northwind];
TRUNCATE TABLE [Data_Vault].[raw].[S_HT_Product_Northwind];
TRUNCATE TABLE [Data_Vault].[raw].[S_HT_Region_Northwind];
TRUNCATE TABLE [Data_Vault].[raw].[S_HT_Shipper_Northwind];
TRUNCATE TABLE [Data_Vault].[raw].[S_HT_Supplier_Northwind];
TRUNCATE TABLE [Data_Vault].[raw].[S_HT_Territory_Northwind];
TRUNCATE TABLE [Data_Vault].[raw].[S_LE_Employee_Reporting_Line_Northwind];
TRUNCATE TABLE [Data_Vault].[raw].[S_LE_Order_Header_Northwind];
TRUNCATE TABLE [Data_Vault].[raw].[S_LE_Product_Category_Northwind];
TRUNCATE TABLE [Data_Vault].[raw].[S_LE_Product_Supplier_Northwind];
TRUNCATE TABLE [Data_Vault].[raw].[S_LE_Territory_Region_Northwind];
TRUNCATE TABLE [Data_Vault].[raw].[S_LT_Customer_Type_Northwind];
TRUNCATE TABLE [Data_Vault].[raw].[S_LT_Employee_Territory_Northwind];