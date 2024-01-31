
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

-- EXERCICE 1 : Window functions with aggregations(I)
SELECT 
	Orderid,
    territoryName,
    -- Total price for each partition
    SUM(OrderPrice)
    -- Create the window and partitions
    OVER(PARTITION BY territoryName) AS TotalPrice
FROM orders;


-- EXERCICE 2 : Window functions with aggregations(II)
SELECT 
	Orderid,
    territoryName,
    -- Number of rows partition
    COUNT(OrderPrice)
    -- Create the window and partitions
    OVER(PARTITION BY territoryName) AS TotalPrice
FROM orders;

-- EXERCICE 3 : First value in a window
SELECT 
    territoryName,
    OrderDate,
    -- Number of rows partition
    FIRST_VALUE(OrderDate)
    -- Create the window and partitions
    OVER(PARTITION BY territoryName ORDER BY OrderDate) AS FirstOrder
FROM orders;

-- EXERCICE 4 : Previous and next values
SELECT 
    territoryName,
    OrderDate,
    -- Specify the previous OrderDate in the window
    LAG(OrderDate)
    -- Over the window, partition by territory & order by order date
    OVER(PARTITION BY territoryName ORDER BY OrderDate) AS PreviousOrder,
    -- Specify the next OrderDate in the window
    LEAD(OrderDate)
    -- Create the partitions and arrange the rows
    OVER(PARTITION BY territoryName ORDER BY OrderDate) AS NextOrder
FROM orders;

-- EXERCICE 5: Creating running totals
SELECT 
	Orderid,
    territoryName,
    -- Total price for each partition
    SUM(OrderPrice)
    -- Create the window and partitions
    OVER(PARTITION BY territoryName ORDER BY OrderDate) AS TotalPrice
FROM orders;

-- EXERCICE 6: Assigning row numbers
SELECT 
    territoryName,
    OrderDate,
    -- Assigning a row number
    ROW_NUMBER()
    -- Create the window and partitions
    OVER(PARTITION BY territoryName ORDER BY OrderDate) AS OrderCount
FROM orders;

-- EXERCICE 7: Calculating standard deviation
SELECT 
    territoryName,
    OrderDate,
    -- Calculate the standard deviation
    STDDEV(OrderPrice)
    -- Create the window and partitions
    OVER(PARTITION BY territoryName ORDER BY OrderDate) AS StdDevPrice
FROM orders;

-- EXERCICE 8: Calculating mode(I)
WITH ModePrice(OrderPrice, UnitPriceFrequency)
AS
(
SELECT
    OrderPrice,
    ROW_NUMBER()
    OVER(PARTITION BY OrderPrice ORDER BY OrderPrice) AS UnitPriceFrequency
	FROM orders
)
-- Select everything from the CTE
SELECT*
FROM ModePrice;

-- EXERCICE 8: Calculating mode(II)
WITH ModePrice(OrderPrice, UnitPriceFrequency)
AS
(
SELECT
    OrderPrice,
    ROW_NUMBER()
    OVER(PARTITION BY OrderPrice ORDER BY OrderPrice) AS UnitPriceFrequency
	FROM orders
)
-- Select everything from the CTE
SELECT OrderPrice AS ModeOrderPrice
FROM ModePrice
-- Select the maximum UnitPriceFrequency from the CTE
WHERE UnitPriceFrequency IN (SELECT MAX(UnitPriceFrequency) FROM ModePrice);