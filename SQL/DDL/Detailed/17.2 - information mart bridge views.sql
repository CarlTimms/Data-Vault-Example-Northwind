/* 

	Information mart bridge views

*/


USE Information_Mart;
GO


-- Bridge_Customer_Type

DROP VIEW IF EXISTS star.Bridge_Customer_Type;
GO

CREATE VIEW star.Bridge_Customer_Type (
	  Snapshot_Datetime
	, Dim_Customer_Key
	, Dim_Customer_Type_Key
)
AS
SELECT
	  DV_Snapshot_Datetime AS Snapshot_Datetime
	, HK_H_Customer AS Dim_Customer_Key
	, HK_H_Customer_Type AS Dim_Customer_Type_Key
FROM
	Information_Mart.bv.B_Customer_Type;
GO




-- Bridge_Employee_Territory

DROP VIEW IF EXISTS star.Bridge_Employee_Territory;
GO

CREATE VIEW star.Bridge_Employee_Territory (
	  Snapshot_Datetime
	, Dim_Employee_Key
	, Dim_Territory_Key
)
AS
SELECT
	  DV_Snapshot_Datetime AS Snapshot_Datetime
	, HK_H_Employee AS Dim_Employee_Key
	, HK_H_Territory AS Dim_Territory_Key
FROM
	Information_Mart.bv.B_Employee_Territory;
GO