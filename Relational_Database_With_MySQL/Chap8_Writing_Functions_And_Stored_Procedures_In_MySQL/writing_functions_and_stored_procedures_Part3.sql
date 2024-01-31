use bikeshare;
select * from capitalbikeshare;

use tripdata;
select * from yellowtripdata;



DROP PROCEDURE IF EXISTS SumRideHrsDateRange;
DROP PROCEDURE IF EXISTS SumRideHrsSingleDay;
DROP PROCEDURE IF EXISTS GetYesterday;
DROP PROCEDURE IF EXISTS SumStationStats;


CREATE FUNCTION hello (s CHAR(20))
RETURNS CHAR(50) DETERMINISTIC
RETURN CONCAT('Hello, ',s,'!');
SELECT hello('world');
/***********************************************************/
	-- EXERCICE 1 : What was yersterday
/***********************************************************/
-- Create GetYesterday() function

DELIMITER //
-- Create a procedure named GetYesterdayDate
CREATE PROCEDURE GetYesterday()
BEGIN
    DECLARE yesterday DATE;
    SET yesterday = DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY);
    SELECT yesterday AS YesterdayDate;
END;
//

-- Reset the delimiter to the default
DELIMITER ;


CALL GetYesterday();
-- SELECT GetYesterday();

/***********************************************************/
	-- EXERCICE 2 : One is one out
/***********************************************************/
-- Change the delimiter for creating the procedure
DELIMITER //

-- Create a procedure named SumRideHrsSingleDayProc
CREATE PROCEDURE SumRideHrsSingleDay(IN DateParam DATE)
BEGIN
    -- Declare a variable to store the total ride hours
    DECLARE TotalRideHours DECIMAL(10, 2);

    -- Calculate the total ride hours for the specified date
    SELECT ROUND(SUM(TIMESTAMPDIFF(SECOND, StartDate, EndDate) / 3600), 2) INTO TotalRideHours
    FROM CapitalBikeShare
    WHERE DATE(StartDate) = DateParam;

    -- Return the total ride hours
    SELECT TotalRideHours;
END;
//

-- Reset the delimiter
DELIMITER ;


-- Call the SumRideHrsSingleDayProc procedure to get the total ride hours for a specific date
CALL SumRideHrsSingleDay('2018-09-15');





/***********************************************************/
	-- EXERCICE 3 : Multiple inputs one ouptut
/***********************************************************/
-- Change the delimiter for creating the procedure
DELIMITER //

-- Create a procedure named SumRideHrsDateRangeProc
CREATE PROCEDURE SumRideHrsDateRange(IN StartDateParam DATETIME, IN EndDateParam DATETIME)
BEGIN
    -- Declare a variable to store the total ride hours
    DECLARE TotalRideHours DECIMAL(10, 2);

    -- Calculate the total ride hours within the specified date range
    SELECT ROUND(SUM(TIMESTAMPDIFF(SECOND, StartDate, EndDate) / 3600), 2) INTO TotalRideHours
    FROM CapitalBikeShare
    WHERE StartDate >= StartDateParam AND StartDate < EndDateParam;

    -- Return the total ride hours
    SELECT TotalRideHours;
END;
//

-- Reset the delimiter to the default
DELIMITER ;

-- Call the SumRideHrsDateRangeProc procedure to get the total ride hours for a date range
-- Example usage:
-- CALL SumRideHrsDateRange('2023-09-15 00:00:00', '2023-09-16 00:00:00');



/***********************************************************/
	-- EXERCICE 4 : Inline TVF
/***********************************************************/

-- Create the stored procedure
DELIMITER //
CREATE PROCEDURE CalculateStationStats(IN StartDate DATETIME)
BEGIN
    -- Create a temporary table to hold the station stats
    CREATE TEMPORARY TABLE IF NOT EXISTS Temp_StationStats (
        StartStation VARCHAR(100),
        RideCount INT,
        TotalDuration NUMERIC
    );

    -- Insert data into the temporary table
    INSERT INTO Temp_StationStats (StartStation, RideCount, TotalDuration)
    SELECT
        StartStation,
        -- Use COUNT() to select RideCount
        COUNT(ID) as RideCount,
        -- Use SUM() to calculate TotalDuration
        SUM(DURATION) as TotalDuration
    FROM CapitalBikeShare
    WHERE DATE(StartDate) = DATE(StartDate)
    -- Group by StartStation
    GROUP BY StartStation;

    -- Select all records from the temporary table
    SELECT *
    FROM Temp_StationStats;

    -- Drop the temporary table
    -- DROP TEMPORARY TABLE IF EXISTS Temp_StationStats;
END //
DELIMITER ;







/***********************************************************/
	-- EXERCICE 5 : Multi statement TVF
/***********************************************************/
-- Create the stored procedure
DELIMITER //

CREATE PROCEDURE CountTripAvgDuration(IN MonthParam CHAR(2), IN YearParam CHAR(4))
BEGIN
    -- Create a temporary table to store the results
    CREATE TEMPORARY TABLE TempDailyTripStats (
        TripDate DATE,
        TripCount INT,
        AvgDuration DECIMAL(10, 2)
    );

    -- Insert query results into the temporary table
    INSERT INTO TempDailyTripStats
    SELECT
        DATE(StartDate) AS TripDate,
        COUNT(ID) AS TripCount,
        AVG(Duration) AS AvgDuration
    FROM CapitalBikeShare
    WHERE
        MONTH(StartDate) = MonthParam AND
        YEAR(StartDate) = YearParam
    GROUP BY DATE(StartDate);

    -- Select data from the temporary table
    SELECT * FROM TempDailyTripStats;

    -- Drop the temporary table
    DROP TEMPORARY TABLE IF EXISTS TempDailyTripStats;
END;
//

DELIMITER ;

/***********************************************************/
	-- EXERCICE 6 : Execute scalar with select
/***********************************************************/

-- Set the date range for which you want to calculate total ride hours
SET @BeginDate := '2018-03-01';
SET @EndDate := '2018-03-10';

-- Call the procedure and store the result in a user-defined variable
CALL SumRideHrsDateRange(@BeginDate, @EndDate);

-- Display the result along with the date range
SELECT 
    @BeginDate AS BeginDate,
    @EndDate AS EndDate,
    SumRideHrsDateRange(@BeginDate, @EndDate) AS Total;


/***********************************************************/
	-- EXERCICE 7 : EXEC Scalar
/***********************************************************/
-- Call the SumRideHrsSingleDay procedure and store the result in the user-defined variable
CALL SumRideHrsSingleDay('2018-03-05');


/***********************************************************/
	-- EXERCICE 8 : Execute TVF into Variable
/***********************************************************/

-- Create a temporary table to hold the station stats
CREATE TEMPORARY TABLE IF NOT EXISTS Temp_StationStats (
    StartStation VARCHAR(100),
    RideCount INT,
    TotalDuration NUMERIC
);

-- Call the stored procedure to populate the temporary table
CALL SumStationStats('2018-03-15');

-- Insert the top 10 records from the temporary table into another temporary table
CREATE TEMPORARY TABLE IF NOT EXISTS Top10_StationStats AS
SELECT *
FROM Temp_StationStats
ORDER BY RideCount DESC
LIMIT 10;

-- Select all records from the top 10 station stats
SELECT *
FROM Top10_StationStats;

-- Clean up temporary tables
DROP TEMPORARY TABLE IF EXISTS Temp_StationStats;
DROP TEMPORARY TABLE IF EXISTS Top10_StationStats;


/***********************************************************/
	-- EXERCICE 9 : CREATE OR ALTER
/***********************************************************/
DELIMITER //
CREATE PROCEDURE SumStationStats(IN EndDate DATE)
BEGIN
    SELECT
        StartStation,
        COUNT(ID) AS RideCount,
        SUM(DURATION) AS TotalDuration
    FROM CapitalBikeShare
    WHERE DATE(EndDate) = EndDate
    GROUP BY StartStation;
END //
DELIMITER ;

CALL SumStationStats('2018-03-10'); -- Replace with the desired date


