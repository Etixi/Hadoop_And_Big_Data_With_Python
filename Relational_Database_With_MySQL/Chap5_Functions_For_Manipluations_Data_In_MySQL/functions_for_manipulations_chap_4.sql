/***************************************************************************************/

		/*Première aperçu des BDD */
        /*===========================*/
        
        use functions_for_manipulating;
        
		select * from ratings;
		ALTER TABLE ratings CHANGE ï»¿company company text;
		describe ratings;
        
		select * from voters limit 5;
		describe voters;
        
/****************************************************/
-- EXERCICE 1 : Learning how to count and add
/*=================================================*/

SELECT 
	gender, 
	-- Count the number of voters for each group
	COUNT(total_votes) AS voters,
	-- Calculate the total number of votes per group
	SUM(total_votes) AS total_votes
FROM voters
GROUP BY gender;

/****************************************************/
-- EXERCICE 2 : MINimizing and MAXimizing some results
/****************************************************/

SELECT 
	company,
	-- Calculate the average cocoa percent
	AVG(cocoa_percent) AS avg_cocoa
FROM ratings
GROUP BY company;

SELECT 
	company,
	-- Calculate the average cocoa percent
	AVG(cocoa_percent) AS avg_cocoa,
	-- Calculate the minimum rating received by each company
	MIN(rating) AS min_rating	
FROM ratings
GROUP BY company;

SELECT 
	company,
	-- Calculate the average cocoa percent
	AVG(cocoa_percent) AS avg_cocoa,
	-- Calculate the minimum rating received by each company
	MIN(rating) AS min_rating,
	-- Calculate the maximum rating received by each company
	MAX(rating) AS max_rating
FROM ratings
GROUP BY company;

SELECT 
	company,
	-- Calculate the average cocoa percent
	AVG(cocoa_percent) AS avg_cocoa,
	-- Calculate the minimum rating received by each company
	MIN(rating) AS min_rating,
	-- Calculate the maximum rating received by each company
	MAX(rating) AS max_rating
FROM ratings
GROUP BY company
-- Order the values by the maximum rating
ORDER BY max_rating DESC;

/****************************************************/
-- EXERCICE 3: 	Acessing values from the next row
/****************************************************/

SELECT 
	first_name,
	last_name,
	total_votes AS votes,
    -- Select the number of votes of the next voter
	LEAD(total_votes) OVER (ORDER BY total_votes) AS votes_next_voter,
    -- Calculate the difference between the number of votes
	LEAD(total_votes) OVER (ORDER BY total_votes) - total_votes AS votes_diff
FROM voters
WHERE country = 'France'
ORDER BY total_votes;


/****************************************************/
-- EXERCICE 5: 	Acessing values from the previous row
/****************************************************/

SELECT 
	broad_bean_origin AS bean_origin,
	rating,
	cocoa_percent,
    -- Retrieve the cocoa % of the bar with the previous rating
	LAG(cocoa_percent) 
		OVER(PARTITION BY broad_bean_origin ORDER BY rating) AS percent_lower_rating
FROM ratings
WHERE company = 'Fruition'
ORDER BY broad_bean_origin, rating ASC;

/****************************************************/
-- EXERCICE 5: 	Getting the first and last value
/****************************************************/

SELECT 
	CONCAT(first_name,  ' ' , last_name) AS name,
	country,
	birthdate,
	-- Retrieve the birthdate of the oldest voter per country
	FIRST_VALUE(birthdate) 
	OVER (PARTITION BY country ORDER BY birthdate) AS oldest_voter,
	-- Retrieve the birthdate of the youngest voter per country
	LAST_VALUE(birthdate) 
		OVER (PARTITION BY country ORDER BY birthdate ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
				) AS youngest_voter
FROM voters
WHERE country IN ('Spain', 'USA');


/*************************************************************/
-- EXERCICE 6 : Extracting the sign and the absolute value
/*************************************************************/

SET @number1 = -5.4;
SET @number2 = 7.89;
SET @number3 = 13.2;
SET @number4 = 0.003;

SET @result = @number1 * @number2 - @number3 - @number4;

SELECT 
    @result AS result,
    -- Show the absolute value of the result
    ABS(@result) AS abs_result;
 
 SET @number1 = -5.4;
SET @number2 = 7.89;
SET @number3 = 13.2;
SET @number4 = 0.003;

SET @result = @number1 * @number2 - @number3 - @number4;

SELECT 
    @result AS result,
    -- Show the absolute value of the result
    ABS(@result) AS abs_result,
    -- Find the sign of the result (-1 for negative, 0 for zero, 1 for positive)
    SIGN(@result) AS sign_result;

/*************************************************************/
-- EXERCICE 7 : Rounding numbers
/*************************************************************/
SELECT
	rating,
	-- Round-up the rating to an integer value
	CEILING(rating) AS round_up,
    -- Round-down the rating to an integer value
	FLOOR(rating) AS round_down,
    -- Round the rating value to one decimal
	ROUND(rating, 1) AS round_onedec,
    -- Round the rating value to two decimals
	ROUND(rating, 2) AS round_twodec
FROM ratings;

/*************************************************************/
-- EXERCICE 8 : Working with exponential functions
/*************************************************************/

SET @number = 4.5;
SET @power = 4;

SELECT
    @number AS number,
    @power AS power,
    -- Raise the @number to the @power
    POW(@number, @power) AS number_to_power,
    -- Calculate the square of the @number
    POW(@number, 2) AS num_squared,
    -- Calculate the square root of the @number
    SQRT(@number) AS num_square_root;

/*************************************************************/
-- EXERCICE 9 : Manipulating with  numeric
/*************************************************************/
SELECT 
	company, 
    -- Select the number of cocoa flavors for each company
	COUNT(*) AS flavors,
    -- Select the minimum, maximum and average rating
	MIN(rating) AS lowest_score,
	MAX(rating) AS highest_score,
	AVG(rating) AS avg_score,
    -- Round the average rating to 1 decimal
    ROUND(AVG(rating), 1) AS round_avg_score,
    -- Round up and then down the aveg. rating to the next integer 
    CEILING(AVG(rating)) AS round_up_avg_score,   
	FLOOR(AVG(rating)) AS round_down_avg_score
FROM ratings
GROUP BY company
ORDER BY flavors DESC;

