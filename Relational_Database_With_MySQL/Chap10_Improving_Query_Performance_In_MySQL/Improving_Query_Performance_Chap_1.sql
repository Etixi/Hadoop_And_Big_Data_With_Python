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
/****************************************************/
-- EXERCICE 1 : Working with different types of data
/*=================================================*/

select 
	PlayerName, 
    Country,
	round(Weight_kg/((Height_cm * Height_cm)/100),2) AS BMI
from 
	nbaplayers
Where 
	Country = 'USA'	Or Country = 'Canada'
order by 
	BMI;

SELECT 
	PlayerName, 
    Country,
	round(Weight_kg/((Height_cm * Height_cm)/100),2) AS BMI
FROM 
	nbaplayers
Where 
	Country = 'USA'OR Country = 'Canada'
ORDER BY BMI;


/****************************************************/
-- EXERCICE 2 : Commenting - Player BMI
/*===================================================*/

/*
Returns the Body Mass Index (BMI) for all North American players 
from the 2017-2018 NBA season
*/

SELECT 
	PlayerName, 
    Country,
    round(Weight_kg/((Height_cm * Height_cm)/100),2) AS BMI
FROM 
	nbaplayers
WHERE 
	Country = 'USA' OR Country = 'Canada';
-- ORDER BY BMI; Order by not required

/****************************************************/
-- EXERCICE 3 : Commenting - how many Kiwis in the NBA?
/*===================================================*/

-- Your friend's query
-- First attempt, contains errors and inconsistent formatting
/*
SELECT p.PlayerName, p.Country,
		SUM(ps.TotalPoints) AS TotalPoints  
FROM PlayerStats ps 
INNER JOIN Players p
	ON ps.PlayerName = p.PlayerName
WHERE p.Country = 'New Zealand'
GROUP BY p.PlayerName, p.Country;
*/
SELECT 
	p.PlayerName, 
	p.Country,
	sum(ps.TotalPoints) AS TotalPoints  
-- Second attempt - errors corrected and formatting fixed
FROM 
	nbaplayerstatistics ps 
INNER JOIN  
	nbaplayers p
    ON ps.PlayerName = p.PlayerName
WHERE 
	p.Country = 'New Zealand'
GROUP BY 
	p.PlayerName, 
	p.Country
ORDER BY p.Country;

/****************************************************/
-- EXERCICE 4 : Ambiguous column names
/*===================================================*/

SELECT 
	p.PlayerName, 
    p.Country,
	SUM(ps.TotalPoints) AS TotalPoints  
FROM 
	nbaplayerstatistics ps
INNER JOIN 
	nbaplayers p
   ON ps.PlayerName = p.PlayerName
WHERE 
	p.Country = 'Australia'
GROUP BY 
	p.PlayerName, p.Country;

/****************************************************/
-- EXERCICE 5 : Aliasing - team BMI
/*===================================================*/

SELECT 
	Team, 
	ROUND(AVG(BMI),2) AS AvgTeamBMI -- Alias the new column
FROM 
	nbaplayerstatistics ps -- Alias PlayerStats table
INNER JOIN
		(SELECT 
			PlayerName, 
			Country,
			Weight_kg/((Height_cm * Height_cm)/100) BMI
		 FROM 
			nbaplayers) AS p		-- Alias the sub-query
								-- Alias the joining columns
	ON 
		ps.PlayerName = p.PlayerName
GROUP BY Team
HAVING 
	AVG(BMI)*100 > 25;
    
    
/****************************************************/
-- EXERCICE 6 : Processing order
/*===================================================*/

SELECT 
	Date, 
    Country, 
    place, 
    depth, 
    magnitude
FROM 
	earthquakes
WHERE 
	magnitude > 8 AND depth > 500
ORDER BY depth DESC;

/****************************************************/
-- EXERCICE 6 : Processing order
/*===================================================*/

/*
Returns earthquakes in New Zealand with a magnitude of 7.5 or more
*/
select * from earthquakes limit 5;
/*
Returns earthquakes in New Zealand with a magnitude of 7.5 or more
*/

SELECT 
	Date, 
    Place, 
    NearestPop, 
    Magnitude
FROM Earthquakes
WHERE Country = 'NZ'
	AND Magnitude >= 7.5
ORDER BY Magnitude DESC;

/****************************************************/
-- EXERCICE 7 : Syntax order - Japan earthquakes
/*===================================================*/

-- Your query
SELECT Date, 
    Place, 
    NearestPop, 
    Magnitude
FROM Earthquakes
WHERE Country = 'JP' 
	AND Magnitude >= 8
ORDER BY Magnitude DESC;

/****************************************************/
-- EXERCICE 8 : Syntax order - very large earthquakes
/*===================================================*/

/*
Returns the location of the epicenter of earthquakes with a 9+ magnitude
*/

-- Replace Countries with the correct table name
SELECT n.CountryName AS Country
	,e.NearestPop AS ClosestCity
    ,e.Date
    ,e.Magnitude
FROM Nations AS n
INNER JOIN Earthquakes AS e
	ON n.Code2 = e.Country
WHERE e.Magnitude >= 9
ORDER BY e.Magnitude DESC;

/*
Returns the location of the epicenter of earthquakes with a 9+ magnitude
*/

-- Replace Magnatud with the correct column name
SELECT n.CountryName AS Country
	,e.NearestPop AS ClosestCity
    ,e.Date
    ,e.Magnitude
FROM Nations AS n
INNER JOIN Earthquakes AS e
	ON n.Code2 = e.Country
WHERE e.Magnitude >= 9
ORDER BY e.Magnitude DESC;

/*
Location of the epicenter of earthquakes with a 9+ magnitude
*/

-- Replace City with the correct column name
SELECT n.CountryName AS Country
	,e.NearestPop AS ClosestCity
    ,e.Date
    ,e.Magnitude
FROM Nations AS n
INNER JOIN Earthquakes AS e
	ON n.Code2 = e.Country
WHERE e.Magnitude >= 9
ORDER BY e.Magnitude DESC;