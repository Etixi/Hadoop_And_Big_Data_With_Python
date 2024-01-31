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
-- EXERCICE 1 : Working with different types of data
/*=================================================*/

SELECT
	company,
    company_location,
    bean_origin,
    cocoa_percent,
    rating
FROM
	ratings
-- Location should be Belguium and the rating should exceed 3.5
WHERE
	company_location = 'Belgium'
    AND rating > 3.5;
    
SELECT
	first_name,
    last_name,
    birthdate,
    gender,
    email,
    country,
    total_votes
FROM
	voters
-- Birthdate > 1990-01-01, total_votes > 100 but < 200
WHERE
	birthdate > '1990-01-01'
    AND total_votes > 100
    AND total_votes < 200;
 
/*=============================================*/
-- EXERCICE 2 : Storing dates in a database
/*=============================================*/

ALTER TABLE voters ADD last_vote_date date;
describe voters;

ALTER TABLE voters ADD last_vote_time time;
describe voters;

ALTER TABLE voters ADD last_login datetime;
describe voters;

/*====================================================*/
-- EXERCICE 3 : Implicit conversion between data types
/*====================================================*/
SELECT
	first_name,
    last_name,
    total_votes
FROM
	voters
WHERE
	total_votes > '120';

/*===============================================*/
-- EXERCICE 4 : Data type precedence
/*=============================================*/

SELECT 
	bean_type,
    rating
FROM
	ratings
WHERE
	rating > '3';

/*===============================================*/
-- EXERCICE 5 : Casting data
/*=============================================*/
SELECT
    CONCAT(
        first_name, ' ', last_name, ' was born in ',
        CAST(YEAR(birthdate) AS CHAR), '.'
    ) AS birth_statement
FROM
    voters;
    
SELECT
	-- Trabnsform to int the division of total_votes to 5.5
    CAST(total_votes/5.5 AS signed) AS DividedVotes
FROM voters;

SELECT 
	first_name,
    last_name,
    total_votes
FROM
	voters
-- Transform the total_votes to char of length 10
WHERE CAST(total_votes AS CHAR(5)) LIKE '5%';

/*====================================================*/
-- EXERCICE 6 : Converting data
/*====================================================*/

SELECT
    email,
    DATE_FORMAT(birthdate, '%b %d, %Y') AS birthdate
FROM
    voters;
    
SELECT 
    company,
    bean_origin,
    -- Convert the rating column to an integer
    CAST(rating AS SIGNED) AS rating
FROM
    ratings;
    
SELECT 
    company,
    bean_origin,
    rating
FROM
    ratings
WHERE
    CONVERT(rating, SIGNED) = 3;





    
