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
-- EXERCICE 1 : STATISTICS TIME in queries
/*==================================================*/
SET STATISTICS TIME ON -- Turn the time command on

-- Query 1
SELECT * 
FROM 
	nbateams
-- Sub-query 1
WHERE City IN -- Sub-query filter operator
      (SELECT CityName 
       FROM Cities) -- Table from Earthquakes database
-- Sub-query 2
   AND City IN -- Sub-query filter operator
	   (SELECT CityName 
	    FROM Cities
		WHERE CountryCode IN ('US','CA'))
-- Sub-query 3
    AND City IN -- Sub-query filter operator
        (SELECT CityName 
         FROM Cities
	     WHERE Pop2017 >2000000);

-- Query 2
SELECT * 
FROM nbateams AS t
WHERE EXISTS -- Sub-query filter operator
	(SELECT 1 
     FROM Cities AS c
     WHERE t.City = c.CityName -- Columns being compared
        AND c.CountryCode IN ('US','CA')
          AND c.Pop2017 > 2000000);

SET STATISTICS TIME OFF -- Turn the time command off

/****************************************************/
-- EXERCICE 2 : STATISTICS IO: Example 1
/*==================================================*/

SET STATISTICS IO ON  -- Turn the IO command on
-- Example 1
SELECT CustomerID,
       CompanyName,
       (SELECT COUNT(*) 
	    FROM Orders AS o -- Add table
		WHERE c.CustomerID = o.CustomerID) CountOrders
FROM Customers AS c
WHERE CustomerID IN -- Add filter operator
       (SELECT CustomerID 
	    FROM Orders 
		WHERE ShipCity IN
            ('Berlin','Bern','Bruxelles','Helsinki',
			'Lisboa','Madrid','Paris','London'));
            
/****************************************************/
-- EXERCICE 2 : STATISTICS IO: Example 2
/*==================================================*/

-- Example 2
SELECT c.CustomerID,
       c.CompanyName,
       COUNT(o.CustomerID)
FROM Customers AS c
INNER JOIN Orders AS o -- Join operator
    ON c.CustomerID = o.CustomerID
WHERE o.ShipCity IN -- Shipping destination column
     ('Berlin','Bern','Bruxelles','Helsinki',
	 'Lisboa','Madrid','Paris','London')
GROUP BY c.CustomerID,
         c.CompanyName;

SET STATISTICS IO OFF -- Turn the IO command off

/****************************************************/
-- EXERCICE 3 : Clustered index
/*==================================================*/

-- Query 1
SELECT *
FROM Cities
WHERE CountryCode = 'RU' -- Country code
		OR CountryCode = 'CN' -- Country code
        
-- Query 2
SELECT *
FROM Cities
WHERE CountryCode IN ('JM','NZ') -- Country codes

/****************************************************/
-- EXERCICE 4 : Sort operator in execution plans
/*==================================================*/

SELECT CityName AS NearCityName,
	   CountryCode
FROM Cities

UNION  -- Append queries

SELECT Capital AS NearCityName,
       Code2 AS CountryCode
FROM Nations;