/******************************************************************************/
				-- IMPORTATION DES BDD
/******************************************************************************/

CREATE DATABASE chinook;
CREATE DATABASE  grid;
CREATE DATABASE eurovis;
CREATE DATABASE songlist;
CREATE DATABASE products;

/**
Grouping and Having

Dans cette leçon, nous allons apprendre à accélérer nos requêtes agrégées à 
l'aide de GROUP BY et à appliquer des filtres supplémentaires à nos résultats 
avec HAVING.

**/

-- 1) A simple SELECT

USE grid;
SELECT 
	SUM(demand_loss_mw) AS lost_demand
FROM grid;

-- 2)  Add A GROUP BY clause

SELECT 
	SUM(demand_loss_mw) AS lost_demand,
	description
FROM 
	grid
GROUP BY description;

-- 3) Tidying up the GROUP BY query

SELECT 
	SUM(demand_loss_mw) AS lost_demand,
	description
FROM grid
WHERE
 description LIKE "%storm"
 AND demand_loss_mw IS NOT NULL
GROUP BY description;

-- 4)  HAVING

SELECT 
 SUM(demand_loss_mw) AS lost_demand,
 description
FROM grid
WHERE
 description LIKE "%storm"
 AND demand_loss_mw IS NOT NULL
GROUP BY description
HAVING SUM(demand_loss_mw)>1000;

/**
EXERCICE

PAR GROUPE

Des instructions
• Sélectionnez nerc_region et la somme de demand_loss_mw pour chaque 
région.
• Exclure les valeurs où demand_loss_mw est NULL.
• Regroupez les résultats par nerc_region.
• Classer par ordre décroissant de demand_loss
**/

-- Select the region column
USE introduction_to_sql;
SELECT 
 nerc_region,
 -- Sum the demand_loss_mw column
 SUM(demand_loss_mw) AS demand_loss
FROM 
	grid
-- Exclude NULL values of demand_loss
WHERE 
 demand_loss_mw IS NOT NULL
 -- Group the results by nerc_region
GROUP BY 
 nerc_region
 -- Order the results in descending order of demand_loss
ORDER BY 
 demand_loss DESC;

/**
HAVING

Instructions

• Modifiez la requête fournie pour supprimer la clause WHERE.
• Remplacez-la par une clause HAVING afin que seuls les résultats dont le 
total est demand_loss_mw supérieur à 10000 soient renvoyés
**/

SELECT 
	nerc_region, 
	SUM(demand_loss_mw) AS demand_loss 
FROM 
	grid 
 -- Remove the WHERE clause
WHERE demand_loss_mw IS NOT NULL
GROUP BY 
	nerc_region 
 -- Enter a new HAVING clause so that the sum of demand_loss_mw is greater than 10000
HAVING 
	SUM(demand_loss_mw) > 10000 
ORDER BY 
	demand_loss DESC;


/**
							Regrouper

Consignes

• Utilisez MIN et MAX pour récupérer les valeurs minimum et maximum 
pour les colonnes place et respectivement points.

• Obtenons plus d'informations à partir de nos résultats en ajoutant une 
clause GROUP BY. Regroupez les résultats par country.

• Les résultats de la requête précédente n'identifiaient pas le pays. 
Modifions la requête en renvoyant le nombre d'entrées par pays et la 
colonne de pays. Complétez la section agrégée en trouvant la moyenne 
de « place » pour chaque pays.

• Enfin, nos résultats sont faussés par les pays qui n'ont qu'une seule 
entrée. Appliquez un filtre afin de ne renvoyer que les lignes où le 
country_count est supérieur à 5. Ensuite, organisez avg_place par ordre 
croissant et avg_points par ordre décroissant

**/

USE introduction_to_sql;
-- Retrieve the minimum and maximum place values
SELECT 
	-- the lower the value the higher the place, so MIN = the highest placing
	MIN(place) AS hi_place, 
	MAX(place) AS lo_place, 
	-- Retrieve the minimum and maximum points values
	MIN(points) AS min_points, 
	MAX(points) AS max_points 
FROM 
	eurovis;
 
 
-- Retrieve the minimum and maximum place values
SELECT 
	-- the lower the value the higher the place, so MIN = the highest placing
	MIN(place) AS hi_place, 
	MAX(place) AS lo_place, 
	-- Retrieve the minimum and maximum points values
	MIN(points) AS min_points, 
	MAX(points) AS max_points 
FROM 
	eurovis
-- Group by country
GROUP BY
	country;
 
 
-- Obtain a count for each country
SELECT 
	COUNT(country) AS country_count, 
	-- Retrieve the country column
	country, 
	-- Return the average of the Place column 
	AVG(place) AS average_place, 
	AVG(points) AS avg_points, 
	MIN(points) AS min_points, 
	MAX(points) AS max_points 
FROM 
	eurovis 
GROUP BY 
	country;
 
 
SELECT 
	country, 
	COUNT(country) AS country_count, 
	AVG(place) AS avg_place, 
	AVG(points) AS avg_points, 
	MIN(points) AS min_points, 
	MAX(points) AS max_points 
FROM 
 eurovis
GROUP BY 
	country 
 -- The country column should only contain those with a count greater than 5
HAVING 
	COUNT(country) > 5 
 -- Arrange columns in the correct order
ORDER BY 
	avg_place, 
	avg_points DESC;

/**
						JOIGNING TABLES

1. Joindre des tables

Dans ce chapitre, nous examinerons certaines des manières les plus courantes 
de joindre des tables pour créer des requêtes plus étendues.

2. Bases de données relationnelles
SQL Server est un système de gestion de bases de données relationnelles. L'un 
des principes clés d'une base de données relationnelle est que les données sont 
stockées sur plusieurs tables. Nous devrons pouvoir joindre des tables 
ensemble afin d'extraire les données dont nous avons besoin.

3. Clés primaires

Nous utilisons les clés PRIMARY et FOREIGN pour joindre les tables. Une clé 
primaire est une colonne utilisée pour identifier de manière unique chaque 
ligne d'une table. Cette unicité peut être obtenue en utilisant un entier 
séquentiel comme colonne d'identité. Ou, parfois, les colonnes existantes 
contiennent naturellement des valeurs uniques et elles peuvent être utilisées.

8. JOINT INTERNE
**/

USE chinook;
SELECT* FROM track;
SELECT* FROM album;
SELECT* FROM artist;

USE chinook;
SELECT
	album.AlbumId,
	album.Title,
	album.ArtistId,
	artist.Name AS artist_name
FROM album
INNER JOIN artist ON artist.ArtistId = album.ArtistId
WHERE album.ArtistId = 1;

/**
 INNER JOIN - Pas de clause WHERE
**/

SELECT 
	album.AlbumId,
	album.Title,
	album.ArtistId,
	artist.Name AS artist_name
FROM album 
INNER JOIN artist ON album.ArtistId = artist.ArtistId;



/**
					EXERCICE 

Jointures internes - une correspondance parfaite

Utilisons la base de données Chinook, qui se compose de tables liées à une 
boutique en ligne, pour comprendre le fonctionnement des jointures 
internes. 

Le tableau album répertorie les albums de plusieurs artistes. 

Le tableau track répertorie les chansons individuelles, chacune avec un identifiant 
unique, mais aussi, une colonne album_id qui relie chaque piste à un album.
Trouvons les pistes qui appartiennent à chaque album.

Des instructions

• Effectuez une jointure interne entre album et track à l'aide de la colonne
album_id.

SOLUTION

**/

SELECT
 track.TrackId,
 Name AS track_name,
 album.Title AS album_title
FROM track
 -- Complete the join type and the common joining column
INNER JOIN album on track.AlbumId = album.AlbumId;


/**
						Jointures internes (II)

Ici, vous continuerez à pratiquer vos compétences INNER JOIN. Nous utiliserons 
le tableau album comme la dernière fois, mais le joindrons à un nouveau 
tableau - artist- qui se compose de deux colonnes : artist_id et name.

Des instructions

• Sélectionnez les colonnes album_id title d’album(le nom de la table 
source principale).
• Sélectionnez la colonne name de artist et attribuez-lui un alias artist. 
• Identifiez une colonne commune entre les tables album et artist et 
effectuez une jointure interne.
**/
-- Select album_id and title fromalbum, and name fromartist

SELECT* FROM artist;
SELECT* FROM album;
SELECT
	album.AlbumId,
	album.Title,
	artist.Name AS artist_name
 -- Enter the main source table name
FROM album
 -- Performthe inner join
INNER JOIN artist ON artist.ArtisId = album.ArtisId;

/**
				Jointure interne (III) - Joindre 3 tables

Nous avons vu comment joindre 2 tables ensemble

– album avec track et album avec artist. D

ans cet exercice, vous allez joindre  les trois tables pour rassembler 
un ensemble de résultats plus complet. 

Vous  continuerez à utiliser INNER JOIN, mais vous devez en spécifier plusieurs.

Ici, notez que parce que les deux track et artist contiennent une colonne name, 
vous devez sélectionner qualify l'endroit où vous sélectionnez les colonnes en 
préfixant le nom de la colonne avec le nom de la table appropriée.

Des instructions

• Qualifiez la colonne name en spécifiant le préfixe de table correct dans 
les deux cas.

• Complétez les deux clauses INNER JOIN pour joindre album avec track
et artist avec album.
**/

USE chinook;
SELECT* FROM track;
SELECT* FROM album;
SELECT* FROM artist;



SELECT 
	track.TrackId,
	-- Enter the correct table name prefix when retrieving the name column from the track table
	track.Name AS track_name,
	album.Title as album_title,
	-- Enter the correct table name prefix when retrieving the name column from the artist table
	artist.Name AS artist_name
    
FROM track
 -- Complete the matching columns to join album with track, and artist with album
INNER JOIN album on album.AlbumId = track.AlbumId 
INNER JOIN artist on artist.ArtistId = album.ArtistId;


/*************************************************************************************/
							-- LEFT & RIGHT JOIN
/**************************************************************************************/

USE db_efrei;
CREATE TABLE admitted(
	Patient_ID INT NOT NULL  PRIMARY KEY,
	Admitted INT NOT NULL    
);
INSERT INTO admitted VALUES('1', '1');
INSERT INTO admitted VALUES('2', '1');
INSERT INTO admitted VALUES('3', '1');
INSERT INTO admitted VALUES('4', '1');
INSERT INTO admitted VALUES('5', '1');



DESCRIBE admitted;

USE db_efrei;
SELECT* FROM admitted;

CREATE TABLE Discharged(
	Patient_ID INT NOT NULL,
	Discharged INT NOT NULL,
    FOREIGN KEY (Patient_ID)
    REFERENCES admitted(Patient_ID)
);

INSERT INTO Discharged VALUES('1', '1');
INSERT INTO Discharged VALUES('3', '1');
INSERT INTO Discharged VALUES('4', '1');

-- DROP TABLE Discharged; 
DESCRIBE Discharged; 

USE db_efrei;
SELECT* FROM Discharged;

SELECT 
	Admitted.Patient_ID, 
	Admitted, 
	Discharged.Discharged 
FROM Admitted 
LEFT JOIN Discharged ON Discharged.Patient_ID = Admitted.Patient_ID;


/**
					9. Résumé

Récapitulons ce que nous avons couvert: 

• La différence entre les jointures INNER et les jointures LEFT ou RIGHT est 
que INNER JOINS ne renvoie que les lignes correspondantes des deux 
tables.

• Les jointures LEFT ou RIGHT renvoient TOUTES les lignes de la table de 
requête principale, ainsi que toutes les correspondances de la table de 
jointure.

• Si une ligne de la table principale n'a pas de correspondance dans la 
table de jointure, une valeur NULL apparaîtra dans toutes les colonnes 
que vous sélectionnez dans la table de jointure.

• Les jointures GAUCHE et DROITE peuvent être interchangeables - nous 
pouvons réécrire une GAUCHE vers une DROITE et une DROITE vers une 
GAUCHE.

• Les jointures LEFT sont plus courantes, mais nous devons être conscients 
des jointures RIGHT car elles sont souvent utiles lorsque plusieurs tables 
doivent être jointes.

RESUME 

• INNER JOIN : renvoie uniquement les lignes correspondantes.
• LEFT JOIN (ou RIGHT JOIN) : Toutes les lignes de la table principale plus 
les correspondances de la table de jonction.
• NULL : Affiché si aucune correspondance n'est trouvée
• LEFT JOIN et RIGHT JOIN peuvent être interchangeables.

/**
EXERCICE

					Joint à  gauche

Un INNER JOIN vous montre les correspondances exactes. Qu'en est-il lorsque 
vous souhaitez comparer toutes les valeurs d'une table avec une autre, pour 
voir quelles lignes correspondent ? C'est alors que vous pouvez utiliser un LEFT 
JOIN. A LEFT JOIN renverra TOUTES les lignes de la première table et toutes les lignes 
correspondantes de la table de droite. S'il n'y a pas de correspondance dans la 
bonne table pour une ligne particulière, alors un NULL est retourné. Cela vous 
permet d'évaluer rapidement les lacunes dans vos données et leur nombre.

Des instructions
• Complétez le LEFT JOIN, renvoyant toutes les lignes des colonnes 
spécifiées de invoiceline et toutes les correspondances de invoice. SOLUTION

**/

/********************************************************************************/
-- CONSULTONS NOS BDD, pour vivre en paix
USE chinook;
SELECT* FROM invoiceline;
SELECT* FROM invoice;
/*******************************************************************************/

SELECT
 invoiceline.InvoiceLineId,
 invoiceline.UnitPrice,
 invoiceline.Quantity,
 invoice.BillingState
 -- Specify the source table
FROM invoiceline
 -- Complete the join to the invoice table
LEFT JOIN invoice
ON invoice.InvoiceId = invoiceline.InvoiceId;



/**
				JOINDRE À DROITE
Essayons maintenant quelques jointures RIGHT. Une jointure DROITE renverra 
toutes les lignes de la table de droite, ainsi que toutes les correspondances de 
la table de gauche.
En plus d'effectuer une jointure RIGHT, vous apprendrez également à éviter les 
problèmes lorsque différentes tables ont les mêmes noms de colonne, en 
qualifiant entièrement la colonne dans votre instruction select. N'oubliez pas 
que nous faisons cela en préfixant le nom de la colonne avec le nom de la table.
Pour cet exercice, nous reviendrons à la base de données Chinook du début du 
chapitre.
Consignes
• SELECT les noms de colonne complets album_id from album et name
from artist. Ensuite, joignez les tables afin que seules les lignes 
correspondantes soient renvoyées (les non-correspondances doivent 
être ignorées).
• Pour terminer la requête, joignez la table album à la table track à l'aide 
de la colonne qualifiée album_id complète appropriée. La table de 
l'album se trouve sur le côté gauche de la jointure, et la jointure 
supplémentaire doit renvoyer toutes les correspondances ou NULL.
SOLUTION
/*******************************************************************************************************/

-- SELECT the fully qualified album_id column fromthe album table

SELECT

	album.AlbumId,
	album.Title,
	album.ArtistId,
	-- SELECT the fully qualified name column fromthe artist table
	artist.Name as artist
    
FROM album

-- Performa join to return only rowsthat match fromboth tables

INNER JOIN artist ON  artist.ArtistId = album.ArtistId
WHERE album.AlbumId IN (213,214);

/*****************************************************************************/
SELECT 
	album.AlbumId,
	album.Title,
	album.ArtistId,
	artist.Name as artist
FROM album
INNER JOIN artist ON artist.ArtistId = album.ArtistId
-- Perform the correct join type to return matches or NULLS from the track  table
LEFT JOIN track on track.AlbumId = album.AlbumId
WHERE album.AlbumId IN (213,214);

/**************************************************************************************/
							-- UNION & UNION ALL
/**************************************************************************************/

-- 1) . Deux requêtes

SELECT 
	AlbumId, 
	Title, 
	ArtistId
FROM album 
WHERE ArtistId IN (1, 3);

SELECT 
	AlbumId, 
	Title, 
	ArtistId
FROM album 
WHERE ArtistId IN (1, 4, 5);


-- 2) Combiner les résultats

SELECT 
	AlbumId, 
	Title, 
	ArtistId
    
FROM album 

WHERE ArtistId IN (1, 3) 
UNION 
SELECT 
	AlbumId, 
	Title, 
	ArtistId
FROM album 
WHERE ArtistId IN (1, 4, 5);

-- 3) UNION TOUS
SELECT 
	AlbumId AS ALBUM_ID, 
	Title AS ALBUM_TITLE, 
	ArtistId AS ARTIST_ID 
    
FROM album 
WHERE ArtistId  IN(1, 3) 
UNION ALL 
SELECT 
	AlbumId AS ALBUM_ID,
	Title AS ALBUM_TITLE, 
	ArtistId AS ARTIST_ID 
FROM album 
WHERE ArtistId IN(1, 4, 5);

/** 
					EXERCICE
Rejoignez l'UNION

Vous pouvez écrire 2 déclarations SELECT ou plus et combiner les résultats en 
utilisant UNION. Par exemple, vous pouvez avoir deux tables différentes avec 
des types de colonnes similaires. Si vous vouliez les combiner en un seul 
ensemble de résultats, vous utiliseriez UNION. Vous verrez comment procéder 
à l'aide des tables artist et album. Dans cet exercice, vous allez ajouter SELECT
deux colonnes communes, description, puis une colonne Source afin de savoir 
de quelle table proviennent les colonnes.

Des instructions

Effectuez la première sélection dans le tableau album. Joignez ensuite les 
résultats en fournissant le mot-clé pertinent et en sélectionnant dans le
tableau artist.
**/

SELECT* FROM album;
SELECT* FROM artist;

SELECT
	AlbumId AS ID,
	Title AS description,
	'Album' AS Source
 -- Complete the FROM statement
FROM album
-- Combine the resultset using the relevant keyword
UNION
SELECT
	ArtistId AS ID,
	Name AS description,
	'Artist' AS Source
 -- Complete the FROM statement
FROM artist;

/**
				-- Creator

		ATTENTION !!! : NE PAS CLIQUER SUCCINTEMENT, ICI NOUS SUIVONS LES QUESTIONS, MAIS SI VOUS
        VOULEZ VISUALIUSER LA TABLE, CLIQUER SUR LA DERNIERE CREATION DE TABLE
**/

-- Create the table
DROP TABLE results;
USE db_efrei;
CREATE TABLE results (
	-- Create track column
	track varchar(200),
	-- Create artist column
	artist varchar(120),
	-- Create album column
	album varchar(160)
);
-- Create the table
CREATE TABLE results (
	-- Create track column
	track VARCHAR(200),
	-- Create artist column
	artist VARCHAR(120),
	-- Create album column
	album VARCHAR(160),
	-- Create track_length_mins
	track_length_mins INT
);

-- Create the table
CREATE TABLE results (
	-- Create track column
	track VARCHAR(200),
	-- Create artist column
	artist VARCHAR(120),
	-- Create album column
	album VARCHAR(160),
	-- Create track_length_mins
	track_length_mins INT
);
-- Select all columns from the table
SELECT 
	track, 
	artist, 
	album, 
	track_length_mins 
FROM 
	results;
    
/*****************************************************************************************/
					-- Insert, Update, Delete
                    
   /**                 EXERCICE
   
					 -- Insérer
                     
Cet exercice se compose de deux parties : Dans la première, vous allez créer un 
nouveau tableau très similaire à celui que vous avez créé dans l'exercice 
interactif précédent. Après cela, vous allez insérer des données et les 
récupérer.

Vous continuerez à travailler avec la base de données Chinook ici.

Consignes

• Créez une table appelée tracks avec 2 colonnes VARCHAR
nommées track et album, et une colonne entière 
nommée track_length_mins. 

• Sélectionnez ensuite toutes les colonnes de votre nouvelle table à l'aide 
du * raccourci pour vérifier la structure de la table.

• Insérez la piste 'Basket Case', de l'album 'Dookie', avec une longueur de 
piste de 3, dans les colonnes appropriées. 

• Effectuez ensuite la SELECT* une fois de plus pour afficher votre ligne nouvellement insérée.

**/
/****************************************************************************************/

-- Create the table
USE db_efrei;
CREATE TABLE tracks(
	-- Create track column
	track VARCHAR(200),
	-- Create album column
	album VARCHAR(160),
	-- Create track_length_mins column
	track_length_mins INT
    );

-- Select all columnsfrom the new table
SELECT*
FROM
	tracks;
    
    
	-- Create the table
	CREATE TABLE tracks(
	-- Create track column
	track VARCHAR(200),
	-- Create album column
	album VARCHAR(160),
	-- Create track_length_mins column
	track_length_mins INT
);

-- Complete the statement to enter the data to the table 
INSERT INTO tracks
-- Specify the destination columns
(track, album, track_length_mins)
-- Insert the appropriate valuesfor track, album and track length
VALUES
 ('Basket Case', 'Dookie', 3);
 
-- Select all columnsfrom the new table
SELECT*
FROM
	tracks;
    
/**
			-- EXERCICE
			-- Mise à jour
            4
Il se peut que vous deviez parfois mettre à jour les lignes d'un tableau. Par 
exemple, dans le tableau album, il y a une ligne avec un très long titre d'album, 
et vous voudrez peut-être le raccourcir.

Vous ne souhaitez pas supprimer l'enregistrement, vous souhaitez simplement 
le mettre à jour sur place. Pour ce faire, vous devez spécifier l’album_id pour 
vous assurer que seule la ligne souhaitée est mise à jour et que toutes les 
autres ne sont pas modifiées.

Consignes

• Sélectionnez la colonne title de la table album où album_id est 213. 

• C'est un très long titre d'album, n'est-ce pas ? Utilisez une instruction 
UPDATE pour modifier le title to 'Pure Cult: The Best Of The Cult'.

• Appuyezsur "Soumettre la réponse" pour voir si le titre de l'album a été 
raccourci ou non !

**/  

USE chinook;
SELECT* FROM album;
SELECT* FROM track;
SELECT* FROM artist;

  
-- Select the album
SELECT
	Title
FROM
	album
WHERE
	AlbumId = 213;
 
 
-- Run the query
SELECT
	Title
FROM
	album
WHERE
	AlbumId = 213;
-- UPDATE the album table
UPDATE
	album
-- SET the new title 
SET
	Title = 'Pure Cult: The Best Of The Cult'
WHERE AlbumId = 213;


-- Select the album
SELECT
	Title
FROM
	album
WHERE
	AlbumId = 213;
-- UPDATE the title of the album
UPDATE
	album
SET
	Title = 'Pure Cult: The Best Of The Cult'
WHERE
	AlbumId = 213;
    
-- Run the query again
SELECT
	Title
FROM
	album
WHERE
	AlbumId = 213;
    

/*********************************************************************************/
			-- EXERCICE
			-- Effacer
/**            
Vous n'êtes peut-être pas autorisé à supprimer de votre base de données, mais 
vous pouvez vous entraîner en toute sécurité ici dans ce cours !
Rappelez-vous 

- il n'y a pas de confirmation avant la suppression. 

Lorsque vous  exécutez l'instruction, le ou les enregistrements sont immédiatement 
supprimés. Assurez-vous toujours de tester avec un SELECT et WHERE dans une 
requête distincte pour vous assurer que vous sélectionnez et supprimez les 
enregistrements corrects. Si vous oubliez de spécifier une condition WHERE, 
vous supprimerez TOUTES les lignes de la table.

Consignes

• Appuyez sur "Soumettre la réponse" pour exécuter la requête et afficher 
les données existantes.

• DELETE l'enregistrement d'album où album_id égale 1, puis cliquez sur 
"Soumettre la réponse".

**/
/***************************************************************************************/

-- Run the query
SELECT * 
FROM 
	album;
    
    
-- Run the query
SELECT *
FROM
	album;
    
 -- DELETE the record
DELETE 
FROM
	album
WHERE
 AlbumId = 1;
 
 -- Run the query again
SELECT *
FROM
	album;
    

/*****************************************************************************************/
					-- Declare yourself
/****************************************************************************************/

-- 1) Variables
-- !!!! NOUS VENOS DE SUPPRIMER LA 1ère ligne, il faut une mise à jour pour traiter cette partie
UPDATE
	artist
 SET
	AlbumId = 1;
    
SELECT*
FROM 
	artist
WHERE Name = 'AC/DC';

-- Maintenant, changez la requête pour un autre artiste :
SELECT*
FROM 
	artist
WHERE 
	Name = 'U2';
    
-- Pour éviter les répétitions, créez une variable :
SELECT *
FROM 
	artist
WHERE Name = @my_artist; -- Nous créeons seulement une variable, donc il est normal que nous rien 

-- 2)  DÉCLARER
/** 
N'OUBLIONS PAS NOTRE BUT APPREHENDER SQL SERVER, MAIS PRATIQUER AVEC MySQL
- DECLARE: VALABLE POUR SQL SERVER
- SET: UNIQUEMENT VALABLE AVEC MySQL
**/
-- DECLARE @
-- • Integer variable: 
SET @test_int = 5;
-- • Varchar variable
SET @my_artist  = 'AC/DC';


SET @my_artist = 'AC/DC'; 
SET @my_album = 'Let There Be Rock'; 
SELECT –
FROM –
WHERE artist = @my_artist  AND album = @my_album; 


SET @my_artist = 'U2'; 
SET @my_album = 'Pop'; 
SELECT –
FROM –
WHERE artist = @my_artist 
AND album = @my_album;

/**
			-- EXERCICE
			-- DECLARE et SET une variable
            
L'utilisation de variables facilite l'exécution d'une requête plusieurs fois, avec 
des valeurs différentes, sans avoir à faire défiler vers le bas et à modifier la
clause WHERE à chaque fois. 

Vous pouvez mettre à jour rapidement la variable en haut de la requête à la place. 

Cela permet également d'assurer une plus grande sécurité, mais cela n'entre pas dans 
le cadre de ce cours.

Revenons à la table grid maintenant très familière pour cet exercice et 
utilisons-la pour pratiquer l'extraction de données en fonction de votre variable 
nouvellement définie.

Consignes

• DECLARE la variable @region, dont le type de données VARCHAR et la 
longueur sont 10. 

• SET votre variable nouvellement définie à 'RFC'.

• Cliquez sur "Soumettre la réponse" pour voir les résultats !
**/
-- Declare the variable @region, and specify the data type of the variable

USE grid;
SET @region = 'RFC';

SELECT 
	description,
	nerc_region,
	demand_loss_mw,
	affected_customers
FROM 
	grid
WHERE 
	nerc_region = @region;
    

/**
			-- EXERCICE
			-- Déclarer plusieurs variables
            
Vous avez vu comment définir une variableDECLARE et SET définir 1 variable. 
Maintenant, vous allez définir DECLARE et SET pour plusieurs variables. Il y a 
déjà une variable déclarée, mais vous devez la remplacer et en déclarer 3 
nouvelles. 

La clause WHERE devra également être modifiée pour renvoyer des 
résultats entre une plage de dates.

Consignes

• Déclarez une nouvelle variable appelée @start de type DATE

• Déclarez une nouvelle variable appelée @stop de type DATE.

• Déclarez une nouvelle variable appelée @affected de type INT.

• Récupère toutes les lignes où event_date entre @start et @stop et 
	affected_customers est supérieur ou égal à @affected
**/
-- Declare @start
SET @start = '2014-01-24';

-- Declare @stop
SET @start = '2014-01-24';

-- Declare @affected

-- Set @affected to 5000
SET @affected = 5000;

SELECT* FROM grid;
-- Declare your variables
SET @start = '2014-01-24';
SET @stop = '2014-07-02';
SET @affected = 5000 ;
SELECT
	description,
	nerc_region,
	demand_loss_mw,
	affected_customers,
    event_date  -- Je rajoute cette colonne pour voir, si notre variable est prise en compte
FROM
	grid
-- Specify the date range of the event_date and the value for @affected
WHERE 
	event_date BETWEEN @start AND @stop
AND 
	affected_customers >= @affected;
    

/**
			-- EXERCICE
            
			-- Pouvoir ultime
            
Parfois, vous souhaiterez peut-être "enregistrer" les résultats d'une requête 
afin de pouvoir travailler davantage avec les données. Vous pouvez le faire en 
créant une table temporaire qui reste dans la base de données jusqu'au 
redémarrage de SQL Server. 

Dans ce dernier exercice, vous sélectionnerez la  piste la plus longue de chaque album et 
l'ajouterez dans une table temporaire que vous créerez dans le cadre de la requête.

Des instructions

• Insérez des données via une instruction SELECT dans une table 
temporaire appelée #maxtracks. 

• Joindre album à artist utilisé artist_id, et track à album utilisé album_id. 

• Exécutez l'instruction SELECT finale pour récupérer toutes les colonnes 
de votre nouvelle table.
**/


 CREATE TABLE maxtracks(
 
 );
 
SELECT 
	album.title AS album_title,
	artist.name as artist,
	MAX(track.milliseconds / (1000 * 60) % 60 ) AS max_track_length_mins
    
-- Name the temp table #maxtracks 

INTO 
	maxtracks
FROM 
	album
-- Join album to artist using artist_id

INNER JOIN artist ON album.artist_id = artist.artist_id

-- Join track to album using album_id

INNER JOIN track ON track.album_id = album.album_id
GROUP BY artist.artist_id, album.title, artist.name,album.album_id;

-- Run the final SELECT query to retrieve the results from the temporary table
SELECT 
	album_title, 
	artist, 
	max_track_length_mins
    
FROM 
	maxtracks
ORDER BY 
	max_track_length_mins DESC, 
    artist;
