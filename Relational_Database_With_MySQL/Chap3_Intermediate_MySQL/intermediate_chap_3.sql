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

-- EXERCICE 1 : Creating Using Variables
-- Declare the variable(a SQL Command, the var name, the datatype)
-- Declare a variable
-- DECLARE counter INT;

-- Set the variable to 20
SET @counter = 20;

-- SELECT the variable
SELECT @counter;

/*=============================================================*/

-- Set the variable to 20
SET @counter = 20;

-- Increment the counter by one
SET @counter = @counter + 1;

-- Print the variable
SELECT @counter;


-- EXERCICE 2 : Creating a While loop
-- Set the variable to 20
DELIMITER $$
CREATE PROCEDURE dowhile(
)
BEGIN
  -- Declare and initialize the counter variable
  DECLARE counter INT DEFAULT 20;
  
  -- Start of the DO WHILE loop
  WHILE counter < 30 DO
    -- Increment the counter by one
    SET counter = counter + 1;
  END WHILE;
  -- End of the DO WHILE loop

  -- Display the final value of the counter
  SELECT counter;
END;
$$
DELIMITER ;

CALL dowhile();

	
-- EXERCICE 3 : Queries with dervived tables(I)
Select 
	a.RecordID, 
	a.Age, 
    a.BloodGlucoseRandom,
    -- Select maximum glucose value (use colname from derived table)
    b.MaxGlucose
FROM
	chronickidneydisease a
    -- Join to derived table
    JOIN(SELECT Age, MAX(BloodGlucoseRandom) AS MaxGlucose FROM chronickidneydisease GROUP BY Age) b
    -- Join on Age
    ON a.Age = b.Age;
    

-- EXERCICE 4 : Queries with dervived tables(II)
Select *
FROM
	chronickidneydisease a
    -- Create derived table : select age, max, max blood pressure from kidney grouped by age 
    JOIN(SELECT Age, MAX(BloodPressure) AS MaxBloodPressure FROM chronickidneydisease GROUP BY Age) b
    -- Join on Bloodpressure equal to MaxbloodPressure
    ON a.BloodPressure = b.MaxBloodPressure
    -- Join on Age
    AND a.Age = b.Age;
    
-- EXERCICE : Creating CTEs(I)
-- Specify the keywords to create the CTE
WITH BloodGlucoseRandom (MaxGlucose)
AS (SELECT MAX(BloodGlucoseRandom) AS MaxGlucose FROM chronickidneydisease)

SELECT a.Age, b.MaxGlucose
FROM chronickidneydisease a
-- JOIN the CTE on blood glucose equal to max blood glucose
JOIN BloodGlucoseRandom b
ON a.BloodGlucoseRandom = b.MaxGlucose;

-- EXERCICE : Creating CTEs(I)
-- Specify the keywords to create the CTE
WITH BloodPressure (MaxBloodPressure)
AS (SELECT MAX(BloodPressure) AS MaxBloodPressure FROM chronickidneydisease)

SELECT *
FROM chronickidneydisease a
-- JOIN the CTE on blood glucose equal to max blood glucose
JOIN BloodPressure b
ON a.BloodPressure = b.MaxBloodPressure;