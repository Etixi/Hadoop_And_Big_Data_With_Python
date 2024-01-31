
/***************************************************************************************/

		/*Première aperçu des BDD */
        /*===========================*/
        
        use functions_for_manipulating;
		select * from ratings;
		ALTER TABLE ratings CHANGE ï»¿company company text;
		describe ratings;
        
		select * from voters limit 5;
		describe voters;
/***************************************************************************************/        
	
/*===========================================================*/
	-- EXERCICE 1 : Calculating the length of a string
/*==========================================================*/
    
SELECT 
	company, 
	broad_bean_origin,
	-- Calculate the length of the broad_bean_origin column
	LENGTH(broad_bean_origin) AS length
FROM ratings
-- Order the results based on the new column, descending
ORDER BY length DESC
LIMIT 10;

/*===========================================================*/
	-- EXERCICE 2 : Looking fir a string within a string
/*==========================================================*/
SELECT 
	first_name,
	last_name,
	email 
FROM voters
-- Look for the "dan" expression in the first_name
WHERE LOCATE('dan', first_name) > 0;

SELECT 
	first_name,
	last_name,
	email 
FROM voters
-- Look for the "dan" expression in the first_name
WHERE LOCATE('dan', first_name) > 0 
    -- Look for last_names that contain the letter "z"
	AND LOCATE('z',last_name) > 0;
    
SELECT 
	first_name,
	last_name,
	email 
FROM voters
-- Look for the "dan" expression in the first_name
WHERE LOCATE('dan', first_name) > 0 
    -- Look for last_names that do not contain the letter "z"
	AND LOCATE('z', last_name) = 0;

/*===========================================================*/
	-- EXERCICE 3 : Looking for a pattern within a string
/*==========================================================*/

SELECT 
    first_name,
    last_name,
    email
FROM voters
WHERE first_name REGEXP '.*rr.*';

SELECT 
    first_name,
    last_name,
    email
FROM voters
WHERE first_name REGEXP '^C.r';

SELECT 
    first_name,
    last_name,
    email
FROM voters
WHERE first_name REGEXP 'a.*w';

SELECT 
    first_name,
    last_name,
    email
FROM voters
WHERE first_name REGEXP '[xwq]';


/*===========================================================*/
	-- EXERCICE 3 : Changing to lowercase and uppercase
/*==========================================================*/
SELECT 
	company,
	bean_type,
	broad_bean_origin,
	CONCAT('La société ', company, ' utilise des beans de type "', bean_type, '", provenant de ', broad_bean_origin, '.')
FROM ratings
WHERE
    -- The 'broad_bean_origin' should not be unknown
	LOWER(broad_bean_origin) NOT LIKE '%unknown%'
    -- The 'bean_type' should not be unknown
    AND LOWER(bean_type) NOT LIKE '%unknown%';
    
SELECT 
	company,
	bean_type,
	broad_bean_origin,
    -- 'company' and 'broad_bean_origin' should be in uppercase
    CONCAT('La société ', UPPER(company), ' utilise des beans de type "', bean_type, '", provenant de ', UPPER(broad_bean_origin), '.')
FROM ratings
WHERE 
    -- The 'broad_bean_origin' should not be unknown
	LOWER(broad_bean_origin) NOT LIKE '%unknown%'
     -- The 'bean_type' should not be unknown
    AND LOWER(bean_type) NOT LIKE '%unknown%';
    
/*===========================================================*/
	-- EXERCICE 4 : Changing to lowercase and uppercase
/*==========================================================*/
SELECT 
	first_name,
	last_name,
	country,
    -- Select only the first 3 characters from the first name
	LEFT(first_name, 3) AS part1,
    -- Select only the last 3 characters from the last name
    RIGHT(last_name, 3) AS part2,
    -- Select only the last 2 digits from the birth date
    RIGHT(birthdate, 2) AS part3,
    -- Create the alias for each voter
    CONCAT(LEFT(first_name, 3), RIGHT(last_name, 3),  '_',  RIGHT(birthdate, 2))
FROM voters;

/*===========================================================*/
	-- EXERCICE 5 : Extracting a substring
/*==========================================================*/

SELECT 
	email,
    -- Extract 5 characters from email, starting at position 3
	SUBSTRING(email, 3, 5) AS some_letters
FROM voters;

SET 
	@sentence = 'Apples are neither oranges nor potatoes.';
SELECT
	-- Extract the word "Apples" 
	SUBSTRING(@sentence, 1, 6) AS fruit1,
    -- Extract the word "oranges"
	SUBSTRING(@sentence, 20, 7) AS fruit2;
    
/*===========================================================*/
	-- EXERCICE 5 : Replacing parts of a string
/*==========================================================*/

SELECT 
	first_name,
	last_name,
	email,
	-- Replace "yahoo.com" with "live.com"
	REPLACE(email, 'yahoo.com', 'live.com') AS new_email
FROM voters;

SELECT 
	company AS initial_name,
    -- Replace '&' with 'and'
	REPLACE(company, '&', 'and') AS new_name 
FROM ratings
WHERE LOCATE('&', company) > 0;

SELECT 
	company AS old_company,
    -- Remove the text '(Valrhona)' from the name
	REPLACE(company,'(Valrhona)', '')AS new_company,
	bean_type,
	broad_bean_origin
FROM ratings
WHERE company = 'La Maison du Chocolat (Valrhona)';

/*===========================================================*/
	-- EXERCICE 5 : Replacing parts of a string
/*==========================================================*/

SET 
	@string1  = 'Chocolate with beans from',
	@string2  = 'has a cocoa percentage of';

SELECT 
	bean_type,
	bean_origin,
	cocoa_percent,
	-- Create a message by concatenating values with "+"
	CONCAT(@string1, ' ' , bean_origin , ' ' , @string2 , ' ' , CAST(cocoa_percent AS CHAR)) AS message1
FROM ratings
WHERE 
	company = 'Ambrosia' 
	AND bean_type <> 'Unknown';

SET
	@string1 = 'Chocolate with beans from',
	@string2  = 'has a cocoa percentage of';

SELECT 
	bean_type,
	bean_origin,
	cocoa_percent,
	-- Create a message by concatenating values with "+"
	CONCAT(@string1 + ' ' + bean_origin + ' ' + @string2 + ' ' + CAST(cocoa_percent AS CHAR))
    AS message1,
	-- Create a message by concatenating values with "CONCAT()"
	CONCAT(@string1, ' ', bean_origin, ' ', @string2, ' ', CAST(cocoa_percent AS CHAR)) AS message2
FROM ratings
WHERE 
	company = 'Ambrosia' 
	AND bean_type <> 'Unknown';
    
SET
	@string1 = 'Chocolate with beans from',
	@string2  = 'has a cocoa percentage of';

SELECT 
	bean_type,
	bean_origin,
	cocoa_percent,
	-- Create a message by concatenating values with "+"
	CONCAT(@string1 + ' ' + bean_origin + ' ' + @string2 + ' ' + CAST(cocoa_percent AS char)) AS message1,
	-- Create a message by concatenating values with "CONCAT()"
	CONCAT(@string1, ' ', bean_origin, ' ', @string2, ' ', cocoa_percent) AS message2,
	-- Create a message by concatenating values with "CONCAT_WS()"
	CONCAT_WS(' ', @string1, bean_origin, @string2, cocoa_percent) AS message3
FROM ratings
WHERE 
	company = 'Ambrosia' 
	AND bean_type <> 'Unknown';
    
/*===========================================================*/
	-- EXERCICE 6 : Aggregating strings
/*==========================================================*/

SELECT
    -- Create a list with all bean origins, delimited by comma
    GROUP_CONCAT(bean_origin SEPARATOR ',') AS bean_origins
FROM ratings
WHERE company IN ('Bar Au Chocolat', 'Chocolate Con Amor', 'East Van Roasters')
GROUP BY company;

SELECT 
	company,
    -- Create a list with all bean origins
	GROUP_CONCAT(bean_origin, ',') AS bean_origins
FROM ratings
WHERE company IN ('Bar Au Chocolat', 'Chocolate Con Amor', 'East Van Roasters')
-- Specify the columns used for grouping your data
GROUP BY company;

SELECT 
    company,
    -- Create a list with all bean origins ordered alphabetically
    GROUP_CONCAT(bean_origin ORDER BY bean_origin ASC SEPARATOR ',') AS bean_origins
FROM ratings
WHERE company IN ('Bar Au Chocolat', 'Chocolate Con Amor', 'East Van Roasters')
GROUP BY company;

/*===========================================================*/
	-- EXERCICE 6 : Aggregating strings
/*==========================================================*/
SET @phrase = 'In the morning I brush my teeth. In the afternoon I take a nap. In the evening I watch TV.';

SELECT 
    REGEXP_SUBSTR(@phrase, '[^\\.]+\\.', 1, seq) AS sentence
FROM (
    SELECT 
        seq,
        ROW_NUMBER() OVER (ORDER BY seq) AS rn
    FROM (
        SELECT 
            seq,
            LENGTH(SUBSTR(@phrase, seq, LENGTH(@phrase) - seq + 1)) - LENGTH(REPLACE(SUBSTR(@phrase, seq, LENGTH(@phrase) - seq + 1), '.', '')) + 1 AS num_periods
        FROM (
            SELECT 
                seq
            FROM (
                SELECT 
                    t.seq + 1 AS seq
                FROM (
                    SELECT 
                        0 AS seq
                    UNION ALL
                    SELECT 
                        1
                    UNION ALL
                    SELECT 
                        2
                ) AS t
                -- Adjust the limit as needed for longer phrases
                HAVING seq <= LENGTH(@phrase)
            ) AS units
        ) AS tens
    ) AS seqs
    -- Adjust the limit as needed for longer phrases
    WHERE seq <= LENGTH(@phrase) AND num_periods >= 1
) AS sentence_positions;


SET @phrase = 'In the morning I brush my teeth. In the afternoon I take a nap. In the evening I watch TV.';

SELECT
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(@phrase, ' ', seq), ' ', -1)) AS word
FROM (
    SELECT
        seq,
        ROW_NUMBER() OVER (ORDER BY seq) AS rn
    FROM (
        SELECT
            seq
        FROM (
            SELECT
                t1.seq + t2.seq * 10 + t3.seq * 100 AS seq
            FROM
                (SELECT 0 AS seq UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) t1,
                (SELECT 0 AS seq UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) t2,
                (SELECT 0 AS seq UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) t3
            ORDER BY seq
        ) AS seqs
        WHERE seq <= LENGTH(@phrase)
    ) AS seqs
) AS word_positions;


/*==================================================================*/
	-- EXERCICE 7  : Applying various string functions on data
/*==================================================================*/

SELECT
    first_name,
    last_name,
    birthdate,
    email,
    country
FROM voters
WHERE CHAR_LENGTH(first_name) < 5
    AND email LIKE '%j_a%';
    
SELECT
    CONCAT('***', first_name, ' ', UPPER(last_name), '***') AS name,
    last_name,
    birthdate,
    email,
    country
FROM voters
WHERE LENGTH(first_name) < 5
    AND email LIKE 'j_a%@yahoo.com';

SELECT
    CONCAT('***', first_name, ' ', UPPER(last_name), '***') AS name,
    CONCAT('***', SUBSTRING(birthdate, 1, 6), 'XX') AS birthdate,
    email,
    country
FROM voters
WHERE LENGTH(first_name) < 5
    AND email LIKE 'j_a%@yahoo.com'      