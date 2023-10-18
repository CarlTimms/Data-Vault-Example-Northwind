/*

	Business data vault reference stored procedures

*/


USE Information_Mart;
GO


-- usp_insert_R_Snapshot_Control

DROP PROCEDURE IF EXISTS bv.usp_insert_R_Snapshot_Control;
GO

CREATE PROCEDURE bv.usp_insert_R_Snapshot_Control
AS
	BEGIN

		TRUNCATE TABLE Information_Mart.bv.R_Snapshot_Control;

		INSERT INTO Information_Mart.bv.R_Snapshot_Control (
			  DV_Snapshot_Datetime
			, DV_Load_Datetime
			, DV_Record_Source
			, Date_Key
			, Time_Key
		)
		SELECT
			  DV_Snapshot_Datetime
			, DV_Load_Datetime
			, DV_Record_Source
			, Date_Key
			, Time_Key
		FROM
			Information_Mart.bv.v_stage_R_Snapshot_Control;

	END
GO