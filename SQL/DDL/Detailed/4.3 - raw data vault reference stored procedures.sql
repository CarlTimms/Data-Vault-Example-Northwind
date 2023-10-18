/*

	Raw data vault reference stored procedures

*/


USE Data_Vault;
GO


-- usp_insert_R_Date

DROP PROCEDURE IF EXISTS rv.usp_insert_R_Date;
GO

CREATE PROCEDURE rv.usp_insert_R_Date 
AS
	BEGIN

		INSERT INTO Data_Vault.rv.R_Date (
			  DV_Load_Datetime
			, DV_Record_Source
			, Date_Key
			, [Date]
			, Date_String
			, Start_Datetime
			, End_Datetime
			, Day_Of_Month_Number
			, Month_Number
			, Month_Name
			, Year_Number
			, Day_Of_Week_Number
			, Day_Of_Week_Name
			, Quarter_Number
			, Quarter_Name
		)
		SELECT
			  DV_Load_Datetime
			, DV_Record_Source
			, Date_Key
			, [Date]
			, Date_String
			, Start_Datetime
			, End_Datetime
			, Day_Of_Month_Number
			, Month_Number
			, Month_Name
			, Year_Number
			, Day_Of_Week_Number
			, Day_Of_Week_Name
			, Quarter_Number
			, Quarter_Name
		FROM
			Data_Vault.rv.v_stage_R_Date
		OPTION
			(MAXRECURSION 0);

	END
GO




-- usp_insert_R_Time

DROP PROCEDURE IF EXISTS rv.usp_insert_R_Time;
GO

CREATE PROCEDURE rv.usp_insert_R_Time 
AS
	BEGIN

		INSERT INTO Data_Vault.rv.R_Time (
			  DV_Load_Datetime
			, DV_Record_Source
			, Time_Key
			, [Time]
			, Time_String
			, Hours_Of_Day
			, Minutes_Of_Hour
			, Seconds_Of_Minute 
		)
		SELECT
			  DV_Load_Datetime
			, DV_Record_Source
			, Time_Key
			, [Time]
			, Time_String
			, Hours_Of_Day
			, Minutes_Of_Hour
			, Seconds_Of_Minute 
		FROM
			Data_Vault.rv.v_stage_R_Time
		OPTION
			(MAXRECURSION 0);

	END
GO