/***************************************************************************************/

		/*Première aperçu des BDD */
        /*===========================*/
        
        use functions_for_manipulating;
        
		select * from ratings;
		ALTER TABLE ratings CHANGE ï»¿company company text;
		describe ratings;
        
		select * from voters limit 5;
		describe voters;
        
	-- Concepts de base sur les fonctions de date
    /*=============================================*/
    -- 1. CURRENT_DATE / CURDATE() : Ces fonctions renvoient la date actuelle au format 'AAAA-MM-JJ'.
    SELECT 
		CURRENT_DATE(),  -- Returns: 'yyyy-mm-dd'
		CURDATE();       -- Returns: 'yyyy-mm-dd'
    
    -- 2. CURRENT_TIME / CURTIME() : Ces fonctions renvoient l'heure actuelle au format 'HH:MM:SS'.
	SELECT 
		CURRENT_TIME(),   -- Returns: 'hh:mm:ss'
		CURTIME();        -- Returns: 'hh:mm:ss'
        
	-- 3. NOW() / CURRENT_TIMESTAMP / SYSDATE() : ces fonctions renvoient la date et l'heure actuelles avec une grande précision, y compris les fractions de seconde si elles sont prises en charge.
	SELECT 
		NOW(),                   -- Returns: 'yyyy-mm-dd hh:mm:ss.ffffff'
		CURRENT_TIMESTAMP(),     -- Returns: 'yyyy-mm-dd hh:mm:ss.ffffff'
		SYSDATE();               -- Returns: 'yyyy-mm-dd hh:mm:ss.ffffff'
        


/***************************************************************************************/

/*=============================================================*/
-- EXERCICE 1 : Get the known the system date and time functions
/*============================================================*/

SELECT
	-- sysdatetime() AS CurrentDate;
    -- Get the current date and time using sysdatetime()
    
    
    -- Higher Precision UTC Functions:
     NOW() AS UTC_HigerPrecision_1,
     UTC_TIMESTAMP() as UTC_LowerPrecision_2,
     
     -- Lower Precision UTC Functions:
     CURDATE() AS UTC_LowerPrecision_1, 
     UTC_DATE() as UTC_LowerPrecision_3,
     CURTIME() AS UTC_LowerPrecision_2,
     UTC_TIME() as UTC_LowerPrecision_4;
	
    
/*======================================================*/
-- EXERCICE 2 : Selecting parts of system's date and time
/*======================================================*/
-- Convert current date and time to different formats
SELECT 
    DATE_FORMAT(NOW(), '%a %b %d, %Y %h:%i:%s %p') AS HighPrecision,
    DATE_FORMAT(CURRENT_TIMESTAMP(), '%Y-%m-%d %H:%i:%s') AS LowPrecision;
    
SELECT
	CAST(NOW() AS time) AS HighPrecision,
    CAST(CURRENT_TIMESTAMP() AS time) LowPrecision;


/*======================================================*/
-- EXERCICE 3 : Extracting parts from a date
/*======================================================*/
SELECT
	first_name,
    last_name,
    -- Extract the year of the first vote
	YEAR(first_vote_date) AS first_vote_year,
	MONTH(first_vote_date) AS first_vote_month,
	DAY(first_vote_date) AS first_vote_day
FROM
	voters
-- The year of the first vote should be greather than 2015
WHERE 
	YEAR(first_vote_date) > 2015
-- The day should not be the first day of the month 
	AND DAY(first_vote_date) <> 1; 


/*======================================================*/
-- EXERCICE 4 : Generating descriptive date parts 
/*======================================================*/

-- Select first_name, last_name, first_vote_date, and the name of the month of the first vote
SELECT
    first_name,
    last_name,
    first_vote_date,
    -- Select the name of te month of the first vote
    MONTHNAME(first_vote_date) AS first_vote_month,
    -- Select the number of the day within the year
	DAYOFYEAR(first_vote_date) AS first_vote_dayofyear,
    -- Select the day of week from the first vote date
	DAYOFWEEK(first_vote_date) AS first_vote_dayofweek
FROM
    voters;


/*======================================================*/
-- EXERCICE 5 : Presenting parts of a date
/*======================================================*/

SELECT 
    first_name,
    last_name,
    -- Extract the month number of the first vote
    MONTH(first_vote_date) AS first_vote_month1,
    -- Extract the month name of the first vote
    DATE_FORMAT(first_vote_date, '%M') AS first_vote_month2,
    -- Extract the weekday number of the first vote (Sunday is 1, Monday is 2, etc.)
    DAYOFWEEK(first_vote_date) AS first_vote_weekday1,
    -- Extract the weekday name of the first vote
    DATE_FORMAT(first_vote_date, '%W') AS first_vote_weekday2
FROM voters;


/*======================================================*/
-- EXERCICE 6 : Creating a date from parts
/*======================================================*/
SELECT 
	first_name,
	last_name,
    -- Select the year of the first vote
   	YEAR(first_vote_date) AS first_vote_year, 
    -- Select the month of the first vote
	MONTH(first_vote_date) AS first_vote_month,
    -- Create a date as the start of the month of the first vote
	DATE(CONCAT(YEAR(first_vote_date), '-', MONTH(first_vote_date), '-01')) AS first_vote_starting_month
FROM voters;

/*======================================================*/
-- EXERCICE 7 : MODIFYING THE VALUE OF A DATE
/*======================================================*/

SELECT
	first_name,
    first_vote_date,
    birthdate,
    -- Add 18 years to the birthdate
    DATE_ADD(birthdate, INTERVAL 18 YEAR) AS eighteenth_birthday,
    -- Add 5 days to the first voting date
    DATE_ADD(first_vote_date, INTERVAL 5 DAY) AS processing_vote_date
FROM
	voters;
   
SELECT
-- Substract 476 days from the current date
    DATE_ADD(CURRENT_TIMESTAMP(), INTERVAL -476 DAY) AS date_476days_ago;

/*======================================================*/
-- EXERCICE 8 : Calculating the difference between dates
/*======================================================*/

SELECT
    first_name,
    birthdate,
    first_vote_date,
    -- Calculate the age at the time of the first vote
    TIMESTAMPDIFF(YEAR, DATE_ADD(birthdate, INTERVAL 18 YEAR), first_vote_date) AS adult_years_until_vote
FROM
    voters;
    
SELECT
	-- Get the difference in weeks from 2019-01-01 until now
    TIMESTAMPDIFF(WEEK, '2019-01-01', NOW()) AS weeks_passed;

/*======================================================*/
-- EXERCICE 8 : Changing the date format
/*======================================================*/


SET @date1 = '2018-30-12';

-- Check if the variable is a valid date in the format 'dd/yyyy/m'
SELECT
	CASE
        WHEN STR_TO_DATE(@date1, '%Y-%d-%m') IS NOT NULL THEN 1
        ELSE 0
    END AS result;
    
SET @date1 = '15/2019/4';

-- Check if the variable is a valid date in the format 'dd/yyyy/m'
SELECT
    CASE
        WHEN STR_TO_DATE(@date1, '%d/%Y/%m') IS NOT NULL THEN 1
        ELSE 0
    END AS result;


SET @date1 = '10.13.2019';

-- Check if the variable is a valid date in the format 'dd/yyyy/m'
SELECT
    CASE
        WHEN STR_TO_DATE(@date1, '%m.%d.%Y') IS NOT NULL THEN 1
        ELSE 0
    END AS result;


SET @date1 = '18.4.2019';

-- Check if the variable is a valid date in the format 'dd/yyyy/m'
SELECT
    CASE
        WHEN STR_TO_DATE(@date1, '%d.%m.%Y') IS NOT NULL THEN 1
        ELSE 0
    END AS result;
    
/*======================================================*/
-- EXERCICE 9 : Changing the default language
/*======================================================*/

SET @date1 = '30.03.2019';

-- Set the locale to Dutch for month names
SET lc_time_names = 'nl_NL';

SELECT
    @date1 AS initial_date,
    -- Check if the date is valid
    IF(STR_TO_DATE(@date1, '%d.%m.%Y') IS NOT NULL, 1, 0) AS is_valid,
    -- Select the name of the month
    DATE_FORMAT(STR_TO_DATE(@date1, '%d.%m.%Y'), '%M') AS month_name;

    
SET @date1 = '32/12/13';

-- Set the locale to Croatian for month names
SET lc_time_names = 'hr_HR';

SELECT
    @date1 AS initial_date,
    -- Check if the date is valid
    IF(STR_TO_DATE(@date1, '%d/%m/%y') IS NOT NULL, 1, 0) AS is_valid,
    -- Select the name of the month
    DATE_FORMAT(STR_TO_DATE(@date1, '%d/%m/%y'), '%M') AS month_name,
    -- Extract the year from the date
    DATE_FORMAT(STR_TO_DATE(@date1, '%d/%m/%y'), '%Y') AS year_name;

    
SET @date1 = '12/18/55';

-- Set the locale to English for weekday names
SET lc_time_names = 'en_US';

SELECT
    @date1 AS initial_date,
    -- Check if the date is valid
    IF(STR_TO_DATE(@date1, '%m/%d/%y') IS NOT NULL, 1, 0) AS is_valid,
    -- Select the weekday name
    DATE_FORMAT(STR_TO_DATE(@date1, '%m/%d/%y'), '%W') AS week_day,
    -- Extract the year from the date
    DATE_FORMAT(STR_TO_DATE(@date1, '%m/%d/%y'), '%Y') AS year_name;
    
/*======================================================*/
-- EXERCICE 10 : Calculating 
/*======================================================*/

SELECT
	first_name,
    last_name,
    birthdate,
	first_vote_date,
	-- Find out on which day of the week each participant voted 
	DAYNAME(first_vote_date) AS first_vote_weekday,
	-- Find out the year of the first vote
	YEAR(first_vote_date) AS first_vote_year,
	-- Discover the participants' age when they joined the contest
	TIMESTAMPDIFF(YEAR, birthdate, first_vote_date) AS age_at_first_vote,	
	-- Calculate the current age of each voter
	TIMESTAMPDIFF(YEAR, birthdate, NOW()) AS current_age
FROM voters;
