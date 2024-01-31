/** ---------------------------------------------------------- **/
				-- IMPORTATION DES BDD
/** ---------------------------------------------------------- **/

use chinook;
use introduction_to_sql;


/** ---------------------------------------------------------- **/
				-- Partie I: Boîte de sélection 
/** ---------------------------------------------------------- **/

/**---------------------------------------------------------- **/
				--  I) INTERROGER NOS BDD
/**------------------------------------------------------------- **/

-- 1) Accéder à l'ensemble de nos BDD 

show databases; 

-- 2) Interrger l'ensemble des champs d'une table

use introduction_to_sql;
select * -- Permet de renvoiyer l'ensembke des champs/attributs (colonnes) de notre table
from eurovis;

-- 3) SELECTIONNER LA COLONNE DESCRITPION DE LA TABLE GRID
       -- j'utilise la base de donnée grid
SELECT description FROM grid; -- je sélectionne le champ description de la table grid

-- 4) SELECTIONNER DEUX COLONNEs ARTIST_ID et NAME de la table artist

use chinook; -- j'utilise la table chinook
ALTER TABLE artist
RENAME COLUMN ï»¿ArtistId TO ArtistId;

SELECT 
-- je sélectionne les champ artist_id et name de la table grid
	ArtistId, 
    Name    
FROM artist;


-- 5) FORMATAGE DES REQUETES 
USE grid;
SELECT 
	description,
	event_year,
    event_date
FROM grid;

-- 6)  SELECTIONNEZ AVEC  TOP() (SQL Server)  & LIMIT(MySQL) **/
-- LIMIT ET TOP ont la même fonctionnalité à la seule que l'un est adapté pour mysql et l'autre pour T-SQL

USE chinook;
SELECT NAME
FROM artist
LIMIT 10;

 -- 7) CAS avec des doublons  (WITHOUT DISTINCT)
use grid;
select nerc_region
from grid;

-- 8) CAS sans doublons (With DISTINCT) 
use grid;
select distinct nerc_region -- il élimine les doublons 
from grid;

-- 9) Recupérer l'ensemvble des champs de notre table: SELECT*
select* from grid;

-- 10) Renommer les colonnes avec AS : afin de rendre un champ d'une table pàlus significative.

SELECT
	demand_loss_mw as lost_demand,
    description as cause_of_outage
from grid;

/** -------------------------------------------------- **/
			-- I)  CAS PRATIQUE 
/** ------------------------------------------------- **/

-- EXERCICE 1

-- 1) SELECT the country column from the eurovision table
use introduction_to_sql;
SELECT 
	Country
FROM eurovis;

-- 2)  SELECT the points columns
SELECT
	Points
FROM eurovis;

-- 3) LIMIT the number of rows returned
SELECT
	Points
FROM eurovis
LIMIT 50;

-- 4)  Return unique coutries and use alias
SELECT
	DISTINCT Country AS unique_country
FROM eurovis;

-- Exercice II
-- 1) Select country and event_year from eurovision
use introduction_to_sql;
SELECT
 Country,
 EventYear as event_year
FROM
 eurovis;
 
-- 2) Amend the code to select all columns
SELECT*
FROM
 eurovis;
 
-- 3) Return all columns,restricting the percent ofrowsreturned
SELECT*
FROM
 eurovis
 LIMIT 50;


/**---------------------------------------------------------- **/
				--  II) BOITE DE SELECTION
/**------------------------------------------------------------- **/

use products;
select* from products;


-- 1) Trier par - ordre croissant (creation de BDD: products)

use products;
SELECT 
		product_id,
		year_intro
        
FROM products

-- Order in Ascending order 
ORDER BY 
	channels,
	year_intro
LIMIT 5;


-- 2) Trier par - ordre décroissant (Utiliser la BDD: products)
use products;
SELECT 
 channels,
 Year_intro
FROM products
-- Order in different directions 
ORDER BY
 Year_intro DESC,
 channels DESC;
 
-- 3) Trier par - plusieurs colonnes, différentes directions

-- 4) Utilisation de la clause:  WHERE

	-- Avec des opérateurs: <,>, <=, >=
	-- Avec des chaines de caractères
    
USE chinook; SELECT* FROM invoice;


USE eurovis; SELECT* FROM eurovis;

	-- a) Cas d'inégalité stricte: <,>
USE chinook;
SELECT 
	CustomerId, 
    Total
FROM invoice
WHERE Total > 15;

-- Utilisation de la BDD: eurovis
SELECT 
	Id, 
	points,
    Country
FROM eurovis
-- Rows with points greater than 10
WHERE points > 500;

SELECT 
	Id, 
	points
FROM eurovis
-- Rows with points less than 10
WHERE points <10;

SELECT 
	Id, 
	points
FROM eurovis
-- Rows with points greater than or equal to 10
WHERE points >=10;

SELECT 
	Id, 
	points
FROM eurovis
-- Rows with points less than or equal to 20
WHERE points <=20;



USE chinook; select* from invoice;

SELECT 
	CustomerId, 
	BillingCountry
FROM invoice
-- Character data type
WHERE BillingCountry = 'USA'
;


use grid; select* from grid;
SELECT grid_id, event_date
FROM grid
-- Date data type 
WHERE event_date = '2012-01-04';

-- 5) Test de non égalité

SELECT CustomerId, Total
FROM invoice
-- Testing for non-equality
WHERE Total<>10;


-- 6) Renvoyer des valeurs dans une plage: BETWEEN & NOT BETWEEN
	-- a) Cas avec: BETWEEN 
USE chinook;
SELECT CustomerID, Total
FROM invoice
WHERE Total BETWEEN 20 AND 30;

-- b) CAS avec: NOT BETWEEN
USE chinook;
SELECT 
	CustomerID, 
    Total
FROM invoice
WHERE Total NOT BETWEEN 20 AND 30;

-- 7) Valeurs Manquantes

	-- a) Vérifier si les d'enregistrements de nos tables ne possèdent pas de valeurs: NULL 
    -- Attention!!!! NULL: peut signifier nulle, inconnu ou manquant

SELECT
	Total,
    BillingState
FROM invoice
WHERE BillingState IS NULL
LIMIT 6;



	-- b) enregistrements où les valeurs ne sont manquantes: NOT NULL
SELECT
	Total,
    BillingState
FROM invoice
WHERE BillingState IS NOT NULL
LIMIT 6;

/** -------------------------------------------- **/
	-- II) CAS PRATIQUE
/** -------------------------------------------- **/

-- 1) COMMANDE PAR
	-- Consignes: 
		-- a) Sélectionnez description et event_date de grid. Votre requête doit renvoyer les 
		-- 5 premières lignes, classées par event_date.
    
    USE introduction_to_sql;
    SELECT
		distinct description, event_date
	FROM grid
    ORDER BY event_date
    LIMIT 5;

	-- b) Modifiez votre code en fonction des commentaires fournis à droite.
	    
	-- Select the top 20 rows from description, nerc_region andevent_date
SELECT
	description,
	nerc_region,
	event_date
FROM
	grid
 -- Order by nerc_region, affected_customers & event_date
 -- Event_date shouldbe in descendingorder
ORDER BY
	nerc_region,
	affected_customers,
	event_date DESC
LIMIT 20;

-- 2) LA CLAUSE: WHERE
	-- • Sélectionnez les colonnes description et event_year
	-- • Renvoie les lignes où description est ‘Vandalism'.
SELECT
	description,
	event_year
FROM 
	grid
WHERE 
	description = "Vandalism";
    
-- 3)  Où encore
	-- • Sélectionnez les colonnes nerc_region et demand_loss_mw,  en limitant les 
	-- résultats de affected_customers eux  sont ceux supérieur ou égal à 500 000.


-- Select nerc_region and demand_loss_mw
SELECT
 nerc_region,
 demand_loss_mw
FROM
 grid
-- Retrieve rows where affected_customersis >= 500000(500,000)
WHERE
 affected_customers >= 500000 ;


	-- • Mettez à jour votre code pour sélectionner description et affected_customers, 
	-- renvoyant les enregistrements où event_date était le 22 décembre 2013.
    
    -- Select description and affected customers
SELECT
 description,
 affected_customers
FROM
 grid
 -- Retrieve rows where the event_date was the 22nd December, 2013 
WHERE
 event_date = '2013-12-22';


-- Select description, affected_customers and event date

-- 4) Travailler avec des valeurs NULL
	-- Consignes :
		-- • Utilisez un raccourci pour sélectionner toutes les colonnes de grid. Filtrez ensuite les 
		-- résultats pour n'inclure que les lignes demand_loss_mw inconnues ou manquantes.
        
-- Retrieve all columns
USE introduction_to_sql;
SELECT* 
FROM
 grid
-- Return only rows where demand_loss_mw is missing or unknown 
WHERE
 demand_loss_mw IS NULL;
 
		-- • Adaptez votre code pour renvoyer les lignes où demand_loss_mw n'est pas inconnu 
		-- ou manquant.
-- Retrieve all columns
SELECT *
FROM
 grid
 -- Return rows where demand_loss_mw is not missing or unknown 
WHERE
 demand_loss_mw IS NOT NULL;


/**---------------------------------------------------------- **/
				--  III) ENCHIANMENT DES CONDITIONS
/**------------------------------------------------------------- **/

-- 1) Cas d'une seule conditions: WHERE
USE songlist;
SELECT song, artist 
FROM songlist 
WHERE 
 artist = 'AC/DC';
 
 -- 2) Cas de deux conditions: AND & WHERE
SELECT song, artist 
FROM songlist 
WHERE 
 artist ='AC/DC'
AND 
 release_year <1980 ;
 
-- 3) Enchianement de conditions avec ET: AND
SELECT song, artist, release_year 
FROM songlist 
WHERE release_year =1994 ;

SELECT*
FROM songlist 
WHERE 
 release_year =1994
AND 
 artist ="Green Day";
 
 -- 4) Enchainement des conditions avec: WHERE & OR
SELECT song, artist, release_year
FROM songlist 
WHERE
 release_year =1994
OR 
 release_year >2000;
 
 -- 5) Repassons en revue
 SELECT song
FROM songlist 
WHERE
 release_year =1994;

SELECT song
FROM songlist 
WHERE
 release_year > 2000;

SELECT song, artist, release_year
FROM songlist 
WHERE
 release_year =1994
OR 
 release_year >2000;
 
SELECT*
FROM songlist 
-- WHERE release_year BETWEEN 1994 AND 2000;
WHERE
release_year =1994
OR 
 release_year >2000;

-- L'idéal serait d'associer les deux conditions différentes suivantes dans une même requête: Que faire?

SELECT*
FROM songlist 
WHERE artist ='Green Day'
AND
 release_year =1994;
 
SELECT*
FROM songlist 
WHERE
 release_year > 2000;

-- 6) L'utilisation comme un moyen de combinaisons efficaces deux conditions différentes
-- a) 1er cas d'utilisation

SELECT song, release_year
FROM songlist 
WHERE artist ='Green Day'
AND (
 release_year =1994
 OR 
 release_year >2000
);

-- b) 2ème méthode 
SELECT song, artist, release_year
FROM songlist 
WHERE
(
 artist ='Green Day'
 AND release_year =1994
)
OR 
(
 artist ='Green Day'
 AND release_year >2000
);

-- 8) Filtrage Avec Condition de vérification avec: IN
	-- BETWEEN pour sélectionner une plage de  valeurs numériques. 
	-- Nous pouvons utiliser IN pour effectuer une sélection similaire pour des valeurs textuelles ou numériques
	-- similaire pour des valeurs textuelles ou numériques.
USE songlist;   
SELECT song, artist 
FROM songlist 
WHERE artist IN ('Van Halen', 'ZZ Top') 
ORDER BY song;   
  
SELECT song, release_year 
FROM songlist 
WHERE release_year IN (1985, 1991, 1992);

-- 9) Filtre avec LIKE pour effectuer  des recherches génériques sur les champs de texte
use songlist;
SELECT song 
FROM songlist 
WHERE song LIKE 'a%';

SELECT artist
FROM songlist 
WHERE artist LIKE 'f%';

SELECT artist
FROM songlist 
WHERE artist LIKE '%a';

SELECT artist
FROM songlist 
WHERE artist LIKE '%f';

SELECT artist
FROM songlist 
WHERE artist LIKE '%af%';

-- EXERCICE
-- 1) Exploration de chansons rock classiques
	-- Consignes
		-- • Récupérez les colonnes song, artist, release_year de la table songlist.
		-- • Assurez-vous qu'il n'y a pas de valeurs NULL dans la colonne release_year.
		-- • Triez les résultats par artist et release_year

-- Retrieve the song, artist and release_year columns
SELECT 
 song, 
 artist, 
 release_year
FROM
 songlist;
 
 
-- Retrieve the song, artist and release_year columns
SELECT
 song, 
 artist, 
 release_year 
FROM 
 songlist 
 -- Ensure there are no missing or unknown values in the release_year column
WHERE 
 release_year is NOT NULL;
 
 
-- Retrieve the song, artist and release_year columns
SELECT
 song,
 artist,
 release_year
FROM
 songlist
 -- Ensure there are no missing or unknown valuesin the release_year column
WHERE
release_year IS NOT NULL
 -- Arrange the results by the artist and release_year columns
ORDER BY
 artist,
 release_year;
 
 
-- 2) Exploration de chansons rock classiques - ET/OU

-- Consignes
	-- • Étendez la clause WHERE de sorte que les résultats soient ceux avec 
	-- un release_year supérieur ou égal à 1980 et inférieur ou égal à 1990.
    
SELECT 
 song, 
 artist, 
 release_year
FROM 
 songlist 
WHERE 
 -- Retrieve records greater than and including 1980
 release_year >= 1980 
 -- Also retrieve records up to and including 1990
 AND release_year <= 1990 
ORDER BY 
 artist, 
 release_year;

	-- • Mettez à jour votre requête pour utiliser un OR au lieu d'un AND. 
    
SELECT 
 song, 
 artist, 
 release_year
FROM 
 songlist 
WHERE 
 -- Retrieve records greater than and including 1980
 release_year >= 1980 
 -- Replace AND with OR
 OR release_year <= 1990 
ORDER BY 
 artist, 
 release_year;

-- 3) Utiliser des parenthèses dans vos requêtes
-- • Des instructions
	-- Sélectionnez tous les artistes commençant par B,  qui ont sorti les 
	-- titres en 1986, mais récupérez également tous les enregistrements où 
	-- le release_year est supérieur à 1990.

SELECT 
 artist, 
 release_year, 
 song 
FROM 
 songlist 
 -- Choose the correct artist and specify the release year
WHERE 
 (
 artist LIKE 'B%' 
 AND release_year = 1986
 ) 
 -- Or return all songs released after 1990
 OR release_year > 1990 
 -- Order the results
ORDER BY 
 release_year, 
 artist, 
 song;


