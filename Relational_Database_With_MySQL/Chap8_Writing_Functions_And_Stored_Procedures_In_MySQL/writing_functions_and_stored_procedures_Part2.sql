use bikeshare;
select * from capitalbikeshare;

use tripdata;
select * from yellowtripdata;

/***********************************************************/
	-- EXERCICE 1 : Transactions per day
/***********************************************************/

SELECT
-- Select the date portion of StartDate
CONVERT(STARTDATE, DATE) as STARDATE,
-- Measure how many records exist for each StarDate
COUNT(ID) as CountOfRows
FROM Capitalbikeshare
-- Group By the date portion of StartDate
GROUP BY CONVERT(StartDate, DATE)
-- Sort the results by the date portion portion of StartDate
ORDER BY CONVERT(StartDate, DATE);

/***********************************************************/
	-- EXERCICE 2 : Seconds or no Seconds
/***********************************************************/

/************************** MYSQL *********************************/
SELECT
    -- Count the number of IDs
    COUNT(ID) AS Count,
    -- Use the SECOND() function to extract the second component of StartDate
    CASE WHEN SECOND(StartDate) = 0 THEN 'SECONDS=0'
         ELSE 'SECONDS>0'
    END AS SecondComponent
FROM
    capitalbikeshare
GROUP BY
    SecondComponent;
    
/************************** SQL Server *********************************/
SELECT
	-- Count the number of IDs
    COUNT(ID) AS Count,
    -- USE DATEPART() to evaluate the SECOND of StartDate
    "StartDate" = CASE WHEN DATEPART(SECOND, StarDate) = 0 THEN 'SECONDS=0'
					   WHEN DATEPART(SECOND, StarDate) > 0 THEN 'SECONDS>0' END
FROM
	capitalbikeshare
GROUP BY
	-- Use the DATEPART() to Group By the CASE Statement
    CASE WHEN DATEPART(SECOND, StarDate) = 0 THEN 'SECONDS=0'
		 WHEN DATEPART(SECOND, StarDate) > 0 THEN 'SECONDS>0' END;
         

/***********************************************************/
	-- EXERCICE 3 : Which day of week is busiest
/***********************************************************/

/************************** MYSQL *********************************/
SELECT
	-- SELECT the day of week value for StartDate
    WEEKDAY(StartDate) AS DayOfWeek,
    -- Calculate TotalTripHours
    -- Calculate TotalTripHours in hours (rounded to two decimal places)
    ROUND(SUM(TIMESTAMPDIFF(SECOND, StartDate, EndDate) / 3600), 2) AS TotalTripHours
FROM
    capitalbikeshare
GROUP BY
    DayOfWeek;

/************************** SQL Server *********************************/
SELECT
	-- SELECT the day of week value for StartDate
    DATENAME(weekday, StartDate) AS DayOfWeek,
    SUM(DATEDIFF(SECOND, StarDate, EndDate))/3600 AS TotalTripHours
FROM
	capitalbikeshare
-- Group by the day of week
GROUP BY
	DATENAME(weekday, StartDate)
-- Order TotalTripHours in descending order by
ORDER BY TotalTripHours DESC;

/***********************************************************/
	-- EXERCICE 4 : Find the outliers
/***********************************************************/



SELECT
    -- Calculate TotalTripHours in hours (rounded to two decimal places)
    ROUND(SUM(TIMESTAMPDIFF(SECOND, StartDate, EndDate) / 3600), 2) AS TotalTripHours,
    -- Select the DATE portion of StartDate
     DATE_FORMAT(StartDate, '%Y-%m-%d') AS DateOnly,
    -- Select the weekday
    DAYNAME(StartDate) AS DayOfWeek
FROM
    capitalbikeshare
-- Only include Saturday
WHERE DAYNAME(StartDate) = 'Saturday'
GROUP BY DateOnly;



SELECT
    -- Calculate TotalTripHours in hours (rounded to two decimal places)
    ROUND(SUM(TIMESTAMPDIFF(SECOND, StartDate, EndDate) / 3600), 2) AS TotalTripHours,
    -- Select the formatted date portion of StartDate
    DATE_FORMAT(StartDate, '%Y-%m-%d') AS DateOnly
    -- Select the weekday
    -- DATENAME(WEEKYDAY, CONVERT(DATE, StartDate)) AS DayOfWeek
    -- DATE_FORMAT(StartDate, '%a') AS DayOfWeek
    -- DATE_FORMAT(StartDate, '%W') AS DayOfWeek
FROM
    CapitalBikeShare
-- Only include Saturday
WHERE DAYNAME(StartDate) = 'Saturday'
GROUP BY DateOnly;

/***********************************************************/
	-- EXERCICE 5 : DECLARE & CAST
/***********************************************************/

-- Create @ShiftStartTime
DECLARE @ShiftStartTime AS time = '08:00 AM'

-- Create @StartDate
DECLARE @StartDate AS date

-- Set StartDate to the first StartDate from CapitalBikeShare

-- Declare and set the shift start time
SET @ShiftStartTime = '08:00:00';

-- Create @StartDate and set it to the latest StartDate from CapitalBikeShare
SET @StartDate = (
    SELECT StartDate
    FROM capitalbikeshare
    ORDER BY StartDate ASC
    LIMIT 1
);

-- Create ShiftStartDateTime by combining StartDate and ShiftStartTime
SET @ShiftStartDateTime = DATE_ADD(@StartDate, INTERVAL TIME_TO_SEC(@ShiftStartTime) SECOND);

-- Select the calculated ShiftStartDateTime
SELECT @ShiftStartDateTime;



/***********************************************************/
	-- EXERCICE 6 : DECLARE a TABLE
/***********************************************************/


-- Create a temporary table for shifts
CREATE TEMPORARY TABLE Shifts (
    StartDateTime DATETIME,
    EndDateTime DATETIME
);

-- Populate the temporary table with data
INSERT INTO Shifts (StartDateTime, EndDateTime)
VALUES ('2018-03-01 08:00:00', '2018-03-01 16:00:00');

-- Query the data from the temporary table
SELECT *
FROM Shifts;

/***********************************************************/
	-- EXERCICE 7 : INSERT INTO @TABLE 
/***********************************************************/

-- Create a temporary table for RideDates
CREATE TEMPORARY TABLE RideDates (
    RideStart DATE,
    RideEnd DATE
);

-- Populate the temporary table with data
INSERT INTO RideDates (RideStart, RideEnd)
SELECT DISTINCT
    CAST(StartDate AS DATE) AS RideStart,
    CAST(EndDate AS DATE) AS RideEnd
FROM capitalbikeshare;

-- Query the data from the temporary table
SELECT * FROM RideDates;


/***********************************************************/
	-- EXERCICE 8 : First day of month 
/***********************************************************/
-- Find the first day of the current month
-- SELECT DATEADD(month, DATEDIFF(month, 0, GETDATE()),0);
SELECT 
	STR_TO_DATE(
		CONCAT(YEAR(CURRENT_DATE()), 
        '-', 
        MONTH(CURRENT_DATE()), '-01'), 
        '%Y-%m-%d'
        ) AS FirstDayOfMonth;






