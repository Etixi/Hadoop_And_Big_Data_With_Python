/** ---------------------------------------------------------- **/
				-- Partie I:Agréger des données
/** ---------------------------------------------------------- **/

/**---------------------------------------------------------- **/
				--  1)  SOMME - colonne unique
/**------------------------------------------------------------- **/

USE grid; SELECT* FROM grid;
SELECT 
	SUM(affected_customers) AS total_affected
FROM grid;


--  2)   SOMME - deux colonnes ou plus
USE grid;
SELECT 
	SUM(demand_loss_mw) AS total_loss,
    SUM(affected_customers) AS total_affected
FROM grid;

-- 3) A ne pas faire !!!!!
SELECT 
 SUM(affected_customers) AS total_affected, 
 (demand_loss_mw) AS total_loss
FROM grid;


-- 4) Sans Aliaser 
SELECT 
    SUM(affected_customers), SUM(demand_loss_mw)
FROM
    grid;
    
-- 5) Compter avec les doublons  
use grid;
SELECT 
    COUNT(affected_customers) AS count_affected
FROM
    grid;
    
-- 6) COMPTER Sans les doublons
SELECT 
 COUNT(DISTINCT affected_customers) AS unique_count_affected
FROM grid;

-- 7) MIN
SELECT 
 MIN(affected_customers) AS min_affected_customers
FROM grid;

SELECT* FROM grid;
SELECT 
 MIN(affected_customers) AS min_affected_customers
FROM grid
WHERE affected_customers > 0;

-- 8) MAX
SELECT 
	MAX(affected_customers) AS max_affected_customers
FROM grid;

-- 9) Moyenne
SELECT 
 AVG(affected_customers) AS avg_affected_customers
FROM grid;

-- EXERCICE
-- Instructions :
	-- 1) Obtenez un total général de la colonne demand_loss_mwà l'aide de la
	-- fonction SUM et aliasez le résultat sous la forme MRO_demand_loss.
	-- 2) Récupérer uniquement les lignes où demand_loss_mwn'est pas null et  nerc_region est 'MRO'.

-- Sumthe demand_loss_mw column
use introduction_to_sql;
SELECT
 SUM(demand_loss_mw) AS MRO_demand_loss
FROM
 grid
WHERE
 -- demand_loss_mw should not contain NULL values
 demand_loss_mw is not NULL
 -- and nerc_region should be 'MRO';
 AND nerc_region = 'MRO';
    
-- II) Compte
-- Instructions:
-- 1) Renvoie le compte de la colonne grid_id, en aliasant le résultat sous la  forme grid_total.
-- 2) Rendez le décompte plus significatif en le limitant aux enregistrements  où nerc_region est 'RFC'. 
-- Nommez le résultat RFC_count.

		-- Instructions 1
-- Obtain a count of 'grid_id'


SELECT
 COUNT(grid_id) AS grid_total
FROM
 grid;
 
		-- Instructions 2
-- Obtain a count of 'grid_id'

SELECT
 COUNT(grid_id) AS RFC_count
FROM
 grid
-- Restrict to rowswhere the nerc_region is 'RFC'
WHERE
 nerc_region = 'RFC';

    
 /**
 MIN, MAX et MOY

Consignes

• Recherchez la valeur minimale dans la colonne affected_customers, mais 
uniquement pour les lignes où demand_loss_mw a une valeur. Nommez 
le résultat min_affected_customers.
• Modifiez la requête pour renvoyer la valeur maximale de la même 
colonne, cette fois en tant qu'alias max_affected_customers.
• Renvoie la valeur moyenne de la colonne affected_customers, cette fois 
en tant qu'alias avg_affected_customers.

 **/
-- SOLUTION 1

-- Find the minimum number of affected customers
SELECT 
	MIN(affected_customers) AS min_affected_customers 
FROM 
	grid
-- Only retrieve rows where demand_loss_mw has a value
WHERE
	demand_loss_mw is NOT NULL;
 
 -- SOLUTION 2
-- Find the maximum number of affected customers
SELECT 
 MAX(affected_customers) AS max_affected_customers 
FROM 
 grid
-- Only retrieve rows where demand_loss_mw has a value
WHERE 
 demand_loss_mw IS NOT NULL;
 
--  SOLUTION 3
-- Find the average number of affected customers
SELECT 
 AVG(affected_customers) AS avg_affected_customers 
FROM 
 grid
-- Only retrieve rows where demand_loss_mw has a value
WHERE 
 demand_loss_mw IS NOT NULL;

/** ---------------------------------------------------------- **/
				-- CHAINES DE CARACTERES (STRINGS)
/** ---------------------------------------------------------- **/

-- 1) Calcul de longueur de chaines de caractères: LENGTH

SELECT
	description,
	LENGTH(description) AS description_length
FROM grid;

-- 2) Extractiion de caractères à partir du début d'une chaîne: fonction LEFT.

SELECT
	description,
	LEFT(description, 20) AS first_20_left
FROM grid;

-- 3) RIGTH: Extraction du côté droit de la chaîne et revient pour extraire le nombre de caractères que nous spécifions
SELECT
	description,
	right(description, 20) AS last_20
FROM grid;



/** CREATING TABLE **/

CREATE DATABASE db_efrei;
USE db_efrei;
CREATE TABLE adress_mail (
	mail_id INT NOT NULL  PRIMARY KEY,
	mail VARCHAR (255) NOT NULL

);

-- DROP TABLE adress_mail; 

INSERT INTO adress_mail VALUES('1', 'efrei.com/courses/introduction_select_sql');
USE db_efrei;
SELECT* FROM adress_mail;

INSERT INTO adress_mail VALUES('2', 'efrei.com/courses/introduction_aggregation_sql');
INSERT INTO adress_mail VALUES('3', 'https//www.efrei.com/courses');
INSERT INTO adress_mail VALUES('4', 'efrei.com/courses/introduction_summarize_sql');
INSERT INTO adress_mail VALUES('5', 'efrei.com/courses/introduction-grouping-sql');
INSERT INTO adress_mail VALUES('6', 'efrei.com/courses/introduction-strings-sql');
INSERT INTO adress_mail VALUES('7', 'efrei.com/courses/introduction-variables-sql');
INSERT INTO adress_mail VALUES('8', 'efrei.com/courses/introduction-filter-sql');
INSERT INTO adress_mail VALUES('9', 'efrei.com/courses/introduction-joining-sql');
INSERT INTO adress_mail VALUES('10', 'efrei.com/courses/introduction-mathsfunctions-sql');
INSERT INTO adress_mail VALUES('11', 'efrei.com/courses/intermediate-windows-sql');
INSERT INTO adress_mail VALUES('12', 'efrei.com/courses/intermediate_missnigvalue-sql');
INSERT INTO adress_mail VALUES('13', 'efrei.com/courses/intermediate-datetime-sql');
INSERT INTO adress_mail VALUES('14', 'efrei.com/courses/intermediate-summarizing-sql');
INSERT INTO adress_mail VALUES('15', 'efrei.com/courses/intermediate-processing-sql');
INSERT INTO adress_mail VALUES('16', 'efrei.com/courses/intermediate-boucle-sql');
INSERT INTO adress_mail VALUES('17', 'efrei.com/courses/intermediate-derivate-sql');
INSERT INTO adress_mail VALUES('18', 'efrei.com/courses/intermediate-CTE-sql');
INSERT INTO adress_mail VALUES('19', 'efrei.com/courses/intermediate-instruction-impuation-sql');
INSERT INTO adress_mail VALUES('20', 'efrei.com/courses/intermediate_added_sql');
INSERT INTO adress_mail VALUES('21', 'efrei.com/courses/intermediate_times_ql');
INSERT INTO adress_mail VALUES('22', 'efrei.com/courses/intermediate_sql');


DESCRIBE adress_mail;

USE db_efrei;
SELECT* FROM adress_mail;

/** 5) La fonction CHARINDEX nous aide à trouver un caractère spécifique dans une 
chaîne (SQL-SERVER) | Dans MySQL, la même fonctionnalité est fournie par la fonction LOCATE ou INSTR.
**/

USE db_efrei;
SELECT
 LOCATE("-", mail) AS char_location,
 mail
FROM adress_mail;

/**
6. SUBSTRING(SOUS-CHAINE)
Parfois, nous devons extraire de la partie médiane d'une chaîne, par opposition 
aux bords gauche ou droit. C'est un travail pour SUBSTRING. La syntaxe est 
SELECT SUBSTRING, une parenthèse ouvrante, le nom de la colonne, le numéro 
du caractère de départ, puis le nombre de caractères à extraire, puis la 
parenthèse fermante. 
**/

SELECT
 SUBSTRING(mail, 12, 12) AS target_section,
 mail
FROM adress_mail;

/**
7) REPLACE (REMPLACER)
Trouver et remplacer du texte est une tâche courante, voyons donc comment 
nous pouvons le faire dans T-SQL (ou MySQL). Nous avons vu comment trouver 
en utilisant CHARINDEX, mais nous n'avons pas besoin de l'utiliser pour cette 
tâche
**/

USE db_efrei;
SELECT REPLACE(mail, "_", "-") AS replace_with_hyphen
FROM adress_mail
LIMIT 5;

/**
EXERCICE

LONGUEUR d'une chaîne

Connaître la longueur d'une chaîne est essentiel pour pouvoir la manipuler 
davantage à l'aide d'autres fonctions, alors quelle meilleure façon de 
commencer la leçon ?

INSTRUCTIONS

1) Récupérez la longueur de la colonne description, en renvoyant les 
résultats sous la forme description_length.
**/

-- SOLUTION

-- Calculate the length of the description column
USE grid;
SELECT 
	LENGTH(description) AS description_length,
    description
FROM 
 grid;
 
 /**
 Gauche et droite
 
Nous pouvons récupérer des parties d'une chaîne à partir du début de la 
chaîne, en utilisant LEFT, ou en remontant à partir de la fin de la chaîne, en 
utilisant RIGHT.

INSTRUCTIONS

1) Récupérez les premiers 25caractères de la colonne description dans le 
tableau de la grille. Nommez les résultats first_25_left

2) Modifiez la requête pour récupérer les 25 derniers caractères de la 
description. Nommez les résultats last_25_right.

**/

/** Coincé au milieu avec vous

Voyons comment utiliser RIGHT, LEN, CHARINDEXAND SUBSTRING pour extraire la 
partie intérieure d'une chaîne de texte. 

INSTRUCTIONS

1) Vous pouvez utiliser CHARINDEX pour rechercher un caractère ou un 
motif spécifique dans une colonne. Modifiez la requête pour renvoyer la 
chaîne CHARINDEX 'Weather' chaque fois qu'elle apparaît dans la 
colonne description.

2) Nous savons maintenant où 'Weather' commence dans la colonne de 
description. Mais où s'arrête-t-il ? Nous pourrions compter 
manuellement le nombre de caractères, mais, pour les chaînes plus 
longues, cela demande plus de travail, surtout lorsque nous pouvons 
également trouver la longueur avec LEN.

3) Maintenant, nous utilisons SUBSTRING pour tout renvoyer après 
Weather les dix premières lignes. L'index de départ ici est 15, car le 
CHARINDEX pour chaque ligne est 8 et le LEN de Weather est 7.
**/

-- SOLUTION

	-- 1) Complétez la requête pour trouver « Météo » dans la colonne de description
SELECT 
	description, 
	LOCATE('Weather', description) 
FROM 
	grid
WHERE 
	description LIKE '%Weather%';

	-- 2) Complete the query to find the length of `Weather'
SELECT 
	description, 
	LOCATE('Weather', description) AS start_of_string,
	LENGTH('Weather') AS length_of_string 
FROM 
	grid
WHERE description LIKE '%Weather%';

	-- 3) Complete the substring function to begin extracting from the correct  character in the description column

SELECT
	description, 
	LOCATE('Weather', description) AS start_of_string, 
	LENGTH('Weather') AS length_of_string, 
    SUBSTRING(description, 15, LENGTH(description)) AS additional_description 
 FROM 
	grid
WHERE description LIKE '%Weather%'
LIMIT 10;


