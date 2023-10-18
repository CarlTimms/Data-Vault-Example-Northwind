/*

	Raw data vault reference source views

*/


USE Data_Vault
GO


SET DATEFIRST 1;  -- Monday
SET DATEFORMAT dmy; 
SET LANGUAGE British;
GO


-- v_stage_R_Date

DROP VIEW IF EXISTS rv.v_stage_R_Date;
GO

CREATE VIEW rv.v_stage_R_Date
AS
	WITH
	
		-- Define start and end date parameters
		cte_parameters AS (
			SELECT
				  CAST('1900-01-01' AS date) AS date_start
				, DATEFROMPARTS(
					  YEAR(SYSUTCDATETIME() AT TIME ZONE 'UTC') + 100
					, 12
					, 31
				  ) AS date_end  -- 100 years in the future
		),

		-- Generate sequence numbers
		cte_sequence(sequence_number) AS (
			SELECT
				0 AS sequence_number
		
			UNION ALL 
  
			SELECT 
				s.sequence_number + 1
			FROM
				cte_sequence AS s
					CROSS JOIN cte_parameters AS p
			WHERE 
				s.sequence_number < DATEDIFF(DAY, p.date_start, p.date_end)
		),

		-- Generate dates
		cte_date(sequence_number, [Date]) AS (
			SELECT
				  s.sequence_number + 1 AS sequence_number
				, DATEADD(DAY, s.sequence_number, p.date_start) AS [Date]
			FROM
				cte_sequence AS s
					CROSS JOIN cte_parameters AS p
		),

		-- Calculate column values
		cte_columns AS (
			SELECT
				  CAST(CONVERT(varchar(8), [Date], 112) AS int) AS Date_Key
				, CONVERT(date, [Date]) AS 'date'
				, CONVERT(varchar(10), [Date], 120) AS Date_String
				, CONVERT(datetime2(7), [Date]) 'Start_Datetime'
				, DATEPART(DAY, [Date]) AS Day_Of_Month_Number
				, DATEPART(MONTH, [Date]) AS Month_Number
				, DATENAME(MONTH, [Date]) AS Month_Name
				, DATEPART(YEAR, [Date]) AS Year_Number
				, DATEDIFF(day, '1753-01-01', [Date]) % 7 + 1 AS Day_Of_Week_Number
				, DATENAME(WEEKDAY, [Date]) AS Day_Of_Week_Name
				, DATEPART(QUARTER, [Date]) AS Quarter_Number
				, CASE DATEPART(Quarter, [Date])
					WHEN 1 THEN 'Quarter One'
					WHEN 2 THEN 'Quarter Two'
					WHEN 3 THEN 'Quarter Three'
					WHEN 4 THEN 'Quarter Four'
					END AS Quarter_Name
			FROM 
				cte_date
		),

		-- Generate date end datetime values
		cte_end_date AS (
			SELECT 
				  s.Date_Key
				, s.[Date]
				, s.Date_String
				, s.Start_Datetime
				, LEAD(DATEADD(NS, -100, s.Start_Datetime), 1, CONCAT(CAST(s.Date AS varchar(10)), ' 23:59:59.9999999')) OVER(ORDER BY s.Start_Datetime ASC) AS End_Datetime
				, s.Day_Of_Month_Number
				, s.Month_Number
				, s.Month_Name
				, s.Year_Number
				, s.Day_Of_Week_Number
				, s.Day_Of_Week_Name
				, s.Quarter_Number
				, s.Quarter_Name
			FROM 
				cte_columns AS s
		)

		-- Identify dates not yet loaded in R_Date
		SELECT 
			  SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
			, 'SYSTEM' AS DV_Record_Source
			, CAST(stage.Date_Key AS int) AS Date_Key
			, CAST(stage.[Date] AS date) AS [Date]
			, CAST(stage.Date_String AS varchar(16)) AS Date_String
			, CAST(stage.Start_Datetime AS datetime2(7)) AS Start_Datetime
			, CAST(stage.End_Datetime AS datetime2(7)) AS End_Datetime
			, CAST(stage.Day_Of_Month_Number AS int) AS Day_Of_Month_Number
			, CAST(stage.Month_Number AS int) AS Month_Number
			, CAST(stage.Month_Name AS varchar(16)) AS Month_Name
			, CAST(stage.Year_Number AS int) AS Year_Number
			, CAST(stage.Day_Of_Week_Number AS int) AS Day_Of_Week_Number
			, CAST(stage.Day_Of_Week_Name AS varchar(16)) AS Day_Of_Week_Name
			, CAST(stage.Quarter_Number AS int) AS Quarter_Number
			, CAST(stage.Quarter_Name AS varchar(16)) AS Quarter_Name
		FROM 
			cte_end_date AS stage
		WHERE 
			NOT EXISTS (
				SELECT
					1
				FROM
					Data_Vault.rv.R_Date AS ref
				WHERE
					stage.Date_Key = ref.Date_Key
			);
GO




-- v_stage_R_Time

DROP VIEW IF EXISTS rv.v_stage_R_Time;
GO

CREATE VIEW rv.v_stage_R_Time
AS
	WITH

		cte_parameters AS (
			SELECT
				  CAST('00:00:00' AS time(0)) start_time  -- first second of the day
				, CAST('23:59:59' AS time(0)) AS end_time  -- last second of the day
		),

		-- Generate sequence numbers
		cte_sequence(sequence_number) AS (
			SELECT
				0 AS sequence_number
		
			UNION ALL 
  
			SELECT 
				s.sequence_number + 1
			FROM
				cte_sequence AS s
					CROSS JOIN cte_parameters AS p	
			WHERE 
				s.sequence_number < DATEDIFF(SECOND, p.start_time, p.end_time)
		),

		-- Generate times
		cte_time AS (
			SELECT
				  s.sequence_number + 1 AS sequence_number
				, DATEADD(SECOND, s.sequence_number, p.start_time) AS [Time]
			FROM
				cte_sequence AS s
					CROSS JOIN cte_parameters AS p
		),

		-- Calculate column values
		cte_columns AS (
			SELECT
				  sequence_number AS Time_Key
				, [Time]
				, CONVERT(varchar(8), [Time]) AS Time_String
				, DATENAME(HOUR, [Time]) AS Hours_Of_Day
				, DATENAME(MINUTE, [Time]) AS Minutes_Of_Hour
				, DATENAME(SECOND, [Time]) AS Seconds_Of_Minute
			FROM 
				cte_time
		)

		-- Identify times not yet loaded in R_Time. Should be zero records. Table only need be loaded once)
		SELECT
			  SYSUTCDATETIME() AT TIME ZONE 'UTC' AS DV_Load_Datetime
			, 'SYSTEM' AS DV_Record_Source
			, CAST(Time_Key AS int) AS Time_Key
			, CAST([Time] AS time(0)) AS [Time]
			, CAST(Time_String AS varchar(8)) AS Time_String
			, CAST(Hours_Of_Day AS int) AS Hours_Of_Day
			, CAST(Minutes_Of_Hour AS int) AS Minutes_Of_Hour
			, CAST(Seconds_Of_Minute AS int) AS Seconds_Of_Minute
		FROM
			cte_columns AS stage
		WHERE 
			NOT EXISTS (
				SELECT
					1
				FROM
					Data_Vault.rv.R_Time AS ref
				WHERE
					stage.Time_Key = ref.Time_Key
			);
GO


