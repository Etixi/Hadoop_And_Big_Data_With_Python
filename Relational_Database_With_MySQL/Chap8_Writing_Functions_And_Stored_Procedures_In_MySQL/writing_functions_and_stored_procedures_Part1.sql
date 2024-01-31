
/*==================================================================================*/
	-- CREATE DATABASE: BikeShare & CREATE TABLE : CapitalBikeShare  & RideSummary
/*==================================================================================*/

-- Create the BikeShare database
CREATE DATABASE IF NOT EXISTS BikeShare;
USE BikeShare;

-- Create the CapitalBikeShare table
CREATE TABLE IF NOT EXISTS CapitalBikeShare (
    ID INT,
    Duration INT,
    StartDate DATETIME,
    EndDate DATETIME,
    StartStationNumber INT,
    StartStation VARCHAR(100),
    EndStationNumber INT,
    EndStation VARCHAR(100),
    BikeNumber VARCHAR(50),
    MemberType VARCHAR(50)
);

-- Load data into the CapitalBikeShare table from a CSV file
LOAD DATA LOCAL INFILE '"C:\Users\Caplogy_Data_002\Documents\Data_Science\SQL\Datacamp_SQL_Server_Developer\Courses_and_Datasets\Writing_Functions_and_Stored_Procedures_in_SQL_Server\Datasets\CapitalBikeShare.csv"' 
INTO TABLE CapitalBikeShare 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES;  -- Skip the header row

-- Create the RideSummary table
CREATE TABLE IF NOT EXISTS RideSummary (
    Date DATE NOT NULL,
    RideHours DECIMAL(18, 0) NOT NULL
);

-- Insert data into the RideSummary table
INSERT INTO RideSummary (Date, RideHours)
VALUES ('2018-03-01', 388);  -- Use the ISO date format 'YYYY-MM-DD' for date


/*==================================================================================*/
	-- CREATE DATABASE: tripdata & CREATE TABLE : YellowTripData
/*==================================================================================*/

-- Create the tripdata database if it doesn't exist
CREATE DATABASE IF NOT EXISTS tripdata;
USE tripdata;

-- Create the YellowTripData table
CREATE TABLE IF NOT EXISTS YellowTripData (
    ID INT,
    VendorID INT,
    PickupDate DATETIME,
    DropoffDate DATETIME,
    PassengerCount INT,
    TripDistance FLOAT,
    RateCodeID INT,
    StoreFwdFlag CHAR(1),
    PULocationID INT,
    DOLocationID INT,
    PaymentType INT,
    FareAmount FLOAT,
    FareExtra FLOAT,
    MTATax FLOAT,
    TipAmount FLOAT,
    TollAmount FLOAT,
    ImproveSurcharge FLOAT,
    TotalAmount FLOAT
);

-- Load data into the YellowTripData table from a CSV file
LOAD DATA LOCAL INFILE 'C:\Users\Caplogy_Data_002\Documents\Data_Science\SQL\Datacamp_SQL_Server_Developer\Courses_and_Datasets\Writing_Functions_and_Stored_Procedures_in_SQL_Server\Datasets\YellowTripData.csv'
INTO TABLE YellowTripData
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '\\'
LINES TERMINATED BY '\n' IGNORE 1 ROWS;

-- Optionally, you can specify additional options as needed, such as CHARACTER SET and COLUMN NAMES.


/*==================================================================================*/
	-- Information table
/*==================================================================================*/

use bikeshare;
select * from capitalbikeshare;
ALTER TABLE capitalbikeshare DROP COLUMN MyUnknownColumn;
select * from capitalbikeshare;
select * from ridesummary;

use tripdata;
select * from yellowtripdata;
ALTER TABLE yellowtripdata DROP COLUMN MyUnknownColumn;
select * from yellowtripdata;

