use bikeshare;
select * from capitalbikeshare;

use tripdata;
select * from yellowtripdata;

DROP PROCEDURE IF EXISTS SumRideHrsDateRange;
DROP PROCEDURE IF EXISTS SumRideHrsSingleDay;
DROP PROCEDURE IF EXISTS GetYesterday;
DROP PROCEDURE IF EXISTS SumStationStats;

/***********************************************************/
	-- EXERCICE 1 : CREATE PROCEDURE with OUTPUT
/***********************************************************/
DELIMITER //
CREATE PROCEDURE cusp_RideSummaryCreate (
    IN DateParm DATE,
    IN RideHrsParm DECIMAL(10, 2)
)
BEGIN
    -- Declare a variable to store the ID of the inserted row
    DECLARE inserted_id INT;

    -- Insert into the Date and RideHours columns
    INSERT INTO RideSummary (Date, RideHours)
    VALUES (DateParm, RideHrsParm);

    -- Get the last inserted ID
    SET inserted_id = LAST_INSERT_ID();

    -- Select the record that was just inserted
    SELECT
        Date,
        RideHours
    FROM RideSummary
    WHERE id = inserted_id;
END //
DELIMITER ;

/***********************************************************/
	-- EXERCICE 2 : Use SP to UPDATE
/***********************************************************/

DELIMITER //
CREATE PROCEDURE cusp_RideSummaryCreate (
    IN DateParm DATE,
    IN RideHrsParm DECIMAL(10, 2)
)
BEGIN
    -- Declare a variable to store the ID of the inserted row
    DECLARE inserted_id INT;

    -- Insert into the Date and RideHours columns
    INSERT INTO RideSummary (Date, RideHours)
    VALUES (DateParm, RideHrsParm);

    -- Get the last inserted ID
    SET inserted_id = LAST_INSERT_ID();

    -- Select the record that was just inserted
    SELECT
        Date,
        RideHours
    FROM RideSummary
    WHERE id = inserted_id;
END //
DELIMITER ;
