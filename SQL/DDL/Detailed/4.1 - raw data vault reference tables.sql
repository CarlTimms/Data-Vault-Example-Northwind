 /*
 
	Raw data vault reference tables
 
 */


 USE Data_Vault;
 GO


-- R_Date

DROP TABLE IF EXISTS rv.R_Date;
GO

CREATE TABLE rv.R_Date (
	  DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, Date_Key int NOT NULL
	, [Date] date NOT NULL
	, Date_String varchar(16) NOT NULL
	, Start_Datetime datetime2(7) NOT NULL
	, End_Datetime datetime2(7) NOT NULL
	, Day_Of_Month_Number int NOT NULL
	, Month_Number int NOT NULL
	, Month_Name varchar(16) NOT NULL
	, Year_Number int NOT NULL
	, Day_Of_Week_Number int NOT NULL
	, Day_Of_Week_Name varchar(16) NOT NULL
	, Quarter_Number int NOT NULL
	, Quarter_Name varchar(16) NOT NULL
	, CONSTRAINT PK_R_Date PRIMARY KEY CLUSTERED (Date_Key ASC) ON [INDEX]
	, CONSTRAINT UK_R_Date UNIQUE NONCLUSTERED ([Date] ASC) ON [INDEX]
) ON [DATA];




-- R_Time

DROP TABLE IF EXISTS rv.R_Time;
GO

 CREATE TABLE rv.R_Time (
	  DV_Load_Datetime datetimeoffset(7) NOT NULL
	, DV_Record_Source varchar(255) NOT NULL
	, Time_Key int NOT NULL
	, [Time] time(0) NOT NULL
	, Time_String varchar(8) NOT NULL
	, Hours_Of_Day int NOT NULL
	, Minutes_Of_Hour int NOT NULL
	, Seconds_Of_Minute int NOT NULL
	, CONSTRAINT PK_R_Time PRIMARY KEY CLUSTERED (Time_Key ASC) ON [INDEX]
	, CONSTRAINT UK_R_Time UNIQUE NONCLUSTERED ([Time] ASC) ON [INDEX]
) ON [DATA];
GO