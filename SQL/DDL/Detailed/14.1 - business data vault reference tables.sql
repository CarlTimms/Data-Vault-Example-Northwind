/*

	Business data vault reference tables

*/


USE Information_Mart;
GO


-- R_Snapshot_Control

DROP TABLE IF EXISTS bv.R_Snapshot_Control;
GO

CREATE TABLE bv.R_Snapshot_Control (
	  DV_Snapshot_Datetime datetimeoffset(7) NOT NULL
	, DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, Date_Key int NOT NULL
	, Time_Key int NOT NULL
	, CONSTRAINT PK_R_Snapshot_Control PRIMARY KEY (DV_Snapshot_Datetime) ON [INDEX]
) ON [DATA];
GO