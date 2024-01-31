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
        ALTER TABLE nbateams CHANGE ï»¿TeamCode TeamCode text;
		describe nbateams;
        
        select * from orders limit 5;
        ALTER TABLE orders CHANGE ï»¿OrderID OrderID text;
		describe orders;
        
        select * from earthquakes limit 5;
        select * from cities limit 5;
        select * from nations limit 5;
	
/****************************************************/
-- EXERCICE 1 : Uncorrelated sub-query
/*==================================================*/

SELECT 
	UNStatisticalRegion,
	CountryName 
FROM 
	Nations
WHERE 
	Code2 -- Country code for outer query 
	IN (SELECT Country -- Country code for sub-query
		FROM Earthquakes
		WHERE Depth >= 400) -- Depth filter
ORDER BY 
	UNStatisticalRegion;

/****************************************************/
-- EXERCICE 2 : Correlated sub-query
/*==================================================*/

SELECT 
	UNContinentRegion,
	CountryName, 
	(SELECT AVG(magnitude) -- Add average magnitude
FROM 
	Earthquakes e 
	-- Add country code reference
	WHERE n.Code2 = e.Country) AS AverageMagnitude 
FROM 
	Nations n
ORDER BY 
	UNContinentRegion DESC, 
	AverageMagnitude DESC;

/****************************************************/
-- EXERCICE 3 : Sub-query vs INNER JOIN
/*==================================================*/

SELECT
	n.CountryName,
	 (SELECT MAX(c.Pop2017) -- Add 2017 population column
	 FROM Cities AS c 
                       -- Outer query country code column
	 WHERE c.CountryCode = n.Code2) AS BiggestCity
FROM Nations AS n; -- Outer query table

SELECT n.CountryName, 
       c.BiggestCity 
FROM Nations AS n
INNER JOIN -- Join the Nations table and sub-query
    (SELECT CountryCode, 
     MAX(Pop2017) AS BiggestCity 
     FROM Cities
     GROUP BY CountryCode) AS c
ON n.Code2 = c.CountryCode; -- Add the joining columns

/****************************************************/
-- EXERCICE 4 : INTERSECT
/*==================================================*/

SELECT Capital
FROM Nations -- Table with capital cities

INTERSECT; -- Add the operator to compare the two queries

SELECT NearestPop -- Add the city name column
FROM Earthquakes;

SELECT Nations.Capital, Earthquakes.NearestPop
FROM Nations
INNER JOIN Earthquakes ON Nations.Capital = Earthquakes.NearestPop;

/****************************************************/
-- EXERCICE 5 : EXCEPT
/*==================================================*/
SELECT Code2 -- Add the country code column
FROM Nations

EXCEPT -- Add the operator to compare the two queries

SELECT Country 
FROM Earthquakes; -- Table with country codes

SELECT Code2
FROM Nations
WHERE Code2 NOT IN (SELECT Country FROM Earthquakes);

/****************************************************/
-- EXERCICE 6 : Interrogating with INTERSECT
/*==================================================*/

SELECT CountryName 
FROM Nations -- Table from Earthquakes database

INTERSECT -- Operator for the intersect between tables

SELECT Country
FROM Players; -- Table from NBA Season 2017-2018 database

/****************************************************/
-- EXERCICE 7 : IN and EXISTS
/*==================================================*/

SELECT * 
FROM Nations
WHERE CountryName LIKE 'U%';
SELECT *
FROM nbaplayers
WHERE Country LIKE 'U%';

-- First attempt
SELECT CountryName,
       	Pop2017, -- 2017 country population
	Capital, -- Capital city	   
       WorldBankRegion
FROM Nations
WHERE Capital IN -- Add the operator to compare queries
        (SELECT NearestPop 
	     FROM Earthquakes);

/****************************************************/
-- EXERCICE 8 : NOT IN and NOT EXISTS
/*==================================================*/

-- Second attempt
SELECT CountryName,   
	   Capital,
    	Pop2016, -- 2016 country population
       WorldBankRegion
FROM Nations AS n
WHERE EXISTS -- Add the operator to compare queries
	  (SELECT 1
	   FROM Earthquakes AS e
	   WHERE n.Capital = e.NearestPop); -- Columns being compared
       
SELECT WorldBankRegion,
       CountryName,
	   Code2,
       Capital, -- Country capital column
	   Pop2017
FROM Nations AS n
WHERE NOT EXISTS -- Add the operator to compare queries
	(SELECT 1
	 FROM Cities AS c
	 WHERE n.	Code2 = c.CountryCode); -- Columns being compared
     
/****************************************************/
-- EXERCICE 9 : INNER JOIN
/*==================================================*/

-- Initial query
SELECT TeamName,
       TeamCode,
	   City
FROM nbateams AS t -- Add table
WHERE EXISTS -- Operator to compare queries
      (SELECT 1 
	  FROM earthquakes AS e -- Add table
	  WHERE t.City = e.NearestPop);
      
-- Second query
SELECT t.TeamName,
       t.TeamCode,
	   t.City,
	   e.Date,
	   e.Place, -- Place description
	   e.Country -- Country code
FROM nbateams AS t
INNER JOIN Earthquakes AS e -- Operator to compare tables
	  ON t.City = e.NearestPop;

/****************************************************/
-- EXERCICE 10 : Exclusive LEFT OUTER JOIN
/*==================================================*/

-- First attempt
SELECT c.CustomerID,
       c.CompanyName,
	   c.ContactName,
	   c.ContactTitle,
	   c.Phone 
FROM Customers c
LEFT OUTER JOIN Orders o -- Joining operator
	ON c.CustomerID = o.CustomerID -- Joining columns
WHERE c.Country = 'France';

-- Second attempt
SELECT c.CustomerID,
       c.CompanyName,
	   c.ContactName,
	   c.ContactTitle,
	   c.Phone 
FROM Customers c
LEFT OUTER JOIN Orders o
	ON c.CustomerID = o.CustomerID
WHERE c.Country = 'France'
	AND o.CustomerID IS NULL; -- Filter condition
    
