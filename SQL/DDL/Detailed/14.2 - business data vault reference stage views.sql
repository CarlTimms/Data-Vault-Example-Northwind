/*

	Business data vault reference stage views 

*/


USE Information_Mart;
GO


-- v_stage_R_Snapshot_Control

DROP VIEW IF EXISTS bv.v_stage_R_Snapshot_Control;
GO

CREATE VIEW bv.v_stage_R_Snapshot_Control (
	  DV_Snapshot_Datetime
	, DV_Load_Datetime
	, DV_Record_Source
	, Date_Key
	, Time_Key
)
AS
WITH 
	cte_date_and_time AS (
		SELECT
			  -- Date
			  ref_date.Date_Key
			, ref_date.[Date]
			, ref_date.Date_String
			, ref_date.Start_Datetime
			, ref_date.End_Datetime
			, ref_date.Day_Of_Month_Number
			, ref_date.Month_Number
			, ref_date.Month_Name
			, ref_date.Year_Number
			, ref_date.Day_Of_Week_Number
			, ref_date.Day_Of_Week_Name
			, ref_date.Quarter_Number
			, ref_date.Quarter_Name

			  -- Time
			, ref_time.Time_Key
			, ref_time.[Time]
			, ref_time.Time_String
			, ref_time.Hours_Of_Day
			, ref_time.Minutes_Of_Hour
			, ref_time.Seconds_Of_Minute
		FROM
			Data_Vault.rv.R_Date AS ref_date
				CROSS JOIN Data_Vault.rv.R_Time AS ref_time
		WHERE
			ref_date.[date] <= CAST(SYSDATETIME() AS date)
			AND ref_time.[time] <= CAST(SYSDATETIME() AS time)
	),

	cte_stage AS (
		
		-- Midnight, first day of the month, previous 5 years
		SELECT
			  CAST(CONCAT(Date_String, ' ', Time_String) AS datetimeoffset(7)) AT TIME ZONE 'New Zealand Standard Time' AS DV_Snapshot_Datetime
			, Date_Key
			, Time_Key
		FROM
			cte_date_and_time
		WHERE
			Time_Key = 1  -- 00:00:00
			AND Day_Of_Month_Number = 1  -- First day of each month
			AND Year_Number > (YEAR(SYSDATETIME()) - 5)  -- Last 5 years

		UNION

		-- Midnight, last 30 days
		SELECT
			  CAST(CONCAT(Date_String, ' ', Time_String) AS datetimeoffset(7)) AT TIME ZONE 'New Zealand Standard Time' AS DV_Snapshot_Datetime
			, Date_Key
			, Time_Key
		FROM
			cte_date_and_time
		WHERE
			Time_Key = 1  -- 00:00:00
			AND [Date] > DATEADD(DAY, -30, CAST(SYSDATETIME() AS date))  -- Last 30 days

		UNION

		-- Current datetime
		SELECT
			   SYSDATETIME() AT TIME ZONE 'New Zealand Standard Time' AS DV_Snapshot_Datetime
			 , CAST(CONVERT(varchar(8), SYSDATETIME() AT TIME ZONE 'New Zealand Standard Time', 112) AS int) AS Date_Key
			 , (SELECT Time_Key FROM Data_Vault.rv.R_Time WHERE [Time] = CAST(SYSDATETIME() AT TIME ZONE 'New Zealand Standard Time' AS time(0))) AS Time_Key

	)

	SELECT
		  DV_Snapshot_Datetime
		, SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
		, 'SYSTEM | Information_Mart.bv.v_stage_R_Snapshot_Control' AS DV_Record_Source
		, Date_Key
		, Time_Key
	FROM
		cte_stage AS stage;
	GO
