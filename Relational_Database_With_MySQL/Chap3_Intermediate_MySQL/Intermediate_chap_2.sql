/***************************************************************************************/

		/*Première aperçu des BDD */
        /*===========================*/
        
        use intermediate_sql;
		select * from chronickidneydisease limit 5;
		describe chronickidneydisease;
        
		select * from incidents limit 5;
		describe incidents;
        
		select * from mixdata limit 5;
		describe mixdata;
        
		select * from orders limit 5;
		describe orders;
        
/***************************************************************************************/

-- EXERCICE 1 : Calculating the total
-- Write a query that returns an aggregation
SELECT MixDesc, SUM(Quantity) AS Total
FROM mixdata
-- Group by the relevant column
GROUP BY MixDesc;

-- EXERCICE 2: Countung the number of rows
-- Count the number of rows by MixDesc
SELECT MixDesc, COUNT(MixDesc)
FROM MixData
GROUP BY MixDesc;

-- EXERCICE 3 : Counting the number of days between dates
SELECT 
	OrderDate, 
    ShipDate, 
    datediff(DD, OrderDate, ShipDate) AS Duration
FROM MixData;

-- EXERCICE 4 : Adding days to date
-- Adding days to date
SELECT
    OrderDate,
    DATE_ADD(ShipDate, INTERVAL 5 DAY) AS DeliveryDate
FROM
    MixData;
    
-- EXERCICE 5 : Rounding Numbers
-- Round Cost to the nearest dollar
SELECT 
	Cost,
    ROUND(Cost, 0) AS RoundedCost
FROM 
	MixData;
    
-- EXERCICE 6 : Truncating Numbers
-- Truncate cost to whole number
SELECT
	Cost,
    truncate(Cost, 0) AS TruncateCost
FROM
	MixData;
    
-- EXERCICE 7 : Calculating the absolute value
-- Return the absolute value of DeliveryWeight
SELECT 
	DeliveryWeight,
    ABS(DeliveryWeight) AS AbsoluteValue
FROM 
	MixData;
    
-- EXERCICE 8 : Calculating squares and square roots
-- Return the square and square root of WeightValue
SELECT
    WeightValue,
    WeightValue * WeightValue AS WeightSquare,  -- Calculate the square of WeightValue
    SQRT(WeightValue) AS WeightSqrt              -- Calculate the square root of WeightValue
FROM 
    MixData;
    



    

