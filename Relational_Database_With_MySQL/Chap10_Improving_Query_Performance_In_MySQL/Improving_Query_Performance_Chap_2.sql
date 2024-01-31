/***************************************************************************************/

		/*Première aperçu des BDD */
        /*===========================*/
        
        use improving_query_performance;
        
		select * from nbaplayers limit 5;
		ALTER TABLE nbaplayers CHANGE ï»¿PlayerName PlayerName text;
		describe nbaplayers;
        
		select * from nbaplayerstatistics limit 5;
		describe nbaplayerstatistics;
        
        select * from nbateams limit 5;
        ALTER TABLE nbaplayers CHANGE ï»¿TeamCode TeamCode text;
		describe nbateams;
        
        select * from orders limit 5;
        ALTER TABLE orders CHANGE ï»¿OrderID OrderID text;
		describe orders;
        
        select * from earthquakes limit 5;
        select * from cities limit 5;
        select * from nations limit 5;
        
/****************************************************/
-- EXERCICE 1 : Column does not exist
/*=================================================*/

-- First query
/*
SELECT PlayerName, 
    Team, 
    Position,
    (DRebound+ORebound)/CAST(GamesPlayed AS numeric) AS AvgRebounds
FROM PlayerStats
WHERE AvgRebounds >= 12;
*/

-- Second query

-- Add the new column to the select statement
SELECT 
	PlayerName, 
	Team, 
	Position, 
	AvgRebounds -- Add the new column
FROM
     -- Sub-query starts here                             
	(SELECT 
      PlayerName, 
      Team, 
      Position,
      -- Calculate average total rebounds
     (OffRebound + DefRebound)/CAST(GamesPlayed AS signed) AS AvgRebounds
	 FROM nbaplayerstatistics) tr
WHERE 
	AvgRebounds >= 12; -- Filter rows


/****************************************************/
-- EXERCICE 2 : Functions in WHERE
/*=================================================*/

SELECT PlayerName, 
      Country,
      College, 
      DraftYear, 
      DraftNumber 
FROM 
	nbaplayers 
      -- No calculation or function
WHERE College LIKE 'Louisiana%';
                   -- Add the new wildcard filter

/****************************************************/
-- EXERCICE 3 : Row filtering with HAVING
/*=================================================*/

SELECT 
	Country, 
	COUNT(*) CountOfPlayers 
FROM 
	nbaplayers
GROUP BY 
	Country
HAVING 
	Country 
    IN ('Argentina','Brazil','Dominican Republic'
        ,'Puerto Rico');
        
SELECT 
	Country, 
    COUNT(*) CountOfPlayers
FROM 
	nbaplayers
-- Add the filter condition
WHERE 
	COUNTRY
-- Fill in the missing countries
	IN ('Argentina','Brazil','Dominican Republic'
        ,'Puerto Rico')
GROUP BY 
	Country;

/****************************************************/
-- EXERCICE 3 : Row filtering with HAVING
/*=================================================*/

SELECT 
	Team, 
	SUM(TotalPoints) AS TotalPFPoints
FROM 
	nbaplayerstatistics
-- Filter for only rows with power forwards
WHERE 
	Position = 'PF'
GROUP BY 
	Team
-- Filter for total points greater than 3000
HAVING 
	SUM(TotalPoints) > 3000;

/****************************************************/
-- EXERCICE 4 : Test your knowledge of HAVING
/*=================================================*/

SELECT 
	Team, 
    SUM(TotalPoints) AS TotalCPoints
FROM 
	nbaplayerstatistics
WHERE 
	Position = 'C'
GROUP BY 
	Team
HAVING 
	SUM(TotalPoints) > 2500;
    
/****************************************************/
-- EXERCICE 5 : SELECT what you need
/*==================================================*/

SELECT * -- Select all rows and columns
FROM Earthquakes;

SELECT 
	longitude, -- Y location coordinate column
	latitude, -- X location coordinate column
	magnitude, -- Earthquake strength column
	depth, -- Earthquake depth column
	NearestPop-- Nearest city column
FROM 
	Earthquakes
WHERE 
	Country = 'PG' -- Papua New Guinea country code
	OR Country = 'ID'; -- Indonesia country code

/****************************************************/
-- EXERCICE 6 : Limit the rows with TOP
/*==================================================*/

SELECT  
      Latitude,
      Longitude,
	  Magnitude,
	  Depth,
	  NearestPop
FROM 
	Earthquakes
WHERE 
	Country = 'PG' OR Country = 'ID'
    -- Order results from shallowest to deepest
ORDER BY Depth  
	-- Limit the number of rows to ten
LIMIT 10;

SELECT 
       Latitude,
       Longitude,
	   Magnitude,
	   Depth,
	   NearestPop
FROM 
	Earthquakes
WHERE 
	Country = 'PG'
	OR Country = 'ID'
ORDER BY 
	Magnitude DESC -- Order the results
LIMIT 10;

/****************************************************/
-- EXERCICE 7 : Remove duplicates with DISTINCT()
/*==================================================*/

SELECT 
	NearestPop, -- Add the closest city
	Country 
FROM 
	Earthquakes
WHERE 
	Magnitude >= 8 AND NearestPop IS NOT NULL
ORDER BY 
	NearestPop;

SELECT 
	DISTINCT(NearestPop),-- Remove duplicate city
		Country
FROM 
	Earthquakes
WHERE 
	Magnitude >= 8 -- Add filter condition 
	AND NearestPop IS NOT NULL
ORDER BY NearestPop;

SELECT 
	NearestPop, 
	Country, 
	COUNT(NearestPop) NumEarthquakes -- Number of cities
FROM 
	Earthquakes
WHERE 
	Magnitude >= 8 AND Country IS NOT NULL
GROUP BY 
	NearestPop, Country -- Group columns
ORDER BY 
	NumEarthquakes DESC;
    
/****************************************************/
-- EXERCICE 8 : UNION and UNION ALL
/*==================================================*/

SELECT 
	CityName AS NearCityName, -- City name column
	CountryCode
FROM 
	Cities

UNION -- Append queries

SELECT 
	Capital AS NearCityName, -- Nation capital column
	Code2 AS CountryCode
FROM 
	Nations;
    
SELECT CityName AS NearCityName,
	   CountryCode
FROM Cities

UNION ALL -- Append queries

SELECT 
	Capital AS NearCityName,
	Code2 AS CountryCode  -- Country code column
FROM 
	Nations;
