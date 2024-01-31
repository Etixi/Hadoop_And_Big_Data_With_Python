
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

-- EXERCICE 1 : CREATION D'AGGREGATIONS
-- 1) Calcul de la moyenne, minimum et maximum
SELECT 
	AVG(DurationSeconds) AS Average,
    MIN(DurationSeconds) AS Minimum,
    MAX(DurationSeconds) AS Maximum
FROM incidents;

-- EXERCICE 2 : CREATION D'AGGREGATIONS GROUPES
-- 1) Calcul d'aggrégations par shape
SELECT 
	shape,
	AVG(DurationSeconds) AS Average,
    MIN(DurationSeconds) AS Minimum,
    MAX(DurationSeconds) AS Maximum
FROM incidents
GROUP BY Shape
-- 2) Retourner les enregistrements dont le minimum de DurationSeconds est supérieur à 1
HAVING MIN(DurationSeconds) > 1;

-- EXERCICE 3 : SUPRESSION DES VALEURS MANQUANTES
-- 1) Renvoie les colonnes spécifiées
SELECT IncidentDateTime, IncidentState
FROM incidents
-- 2) Exclure toutes les valeurs manquantes d'IncidentState
WHERE TRIM(IncidentState) != '' AND IncidentState IS NOT NULL;

-- EXERCICE 4 : IMPUTATION DES VALEURS MANQUANTES
-- 1) Verifiez la colonne IncidentState por les valeurs manquantes et remplacez-les par la colonne City
SELECT 
	IncidentState, 
    -- SQL SERVER: ISNULL()
    -- ISNULL(IncidentState, City) AS Location
    COALESCE(IncidentState,  City) AS Location
FROM 
	incidents
-- 2) Filtre pour renvoyer uniquement les valeurs manquantes d'IncidentState7
WHERE 
	-- trim(IncidentState) =  '';
	IncidentState IS NULL;

-- EXERCICE 5 : IMPUTATION DES VALEURS MANQUANTES(II)
-- Remplacer les valeurs manquantes
SELECT
	Country,
    COALESCE(Country, IncidentState, City) AS Location
FROM 
	incidents
WHERE 
	-- trim(Country) != '';
	Country IS NULL;
    
-- EXERCICE 6 : Utilisation des instructions CASE
SELECT Country,
		CASE WHEN Country = 'us' THEN 'USA'
        ELSE 'International'
        END AS SourceCountry
FROM incidents;

-- EXERCICE 7 : Créer plusieurs groupes avec CASE
-- Complete the syntax for cutting the duration into different cases
SELECT DurationSeconds, 
-- Start with the 2 TSQL keywords, and after the condition a TSQL word and a value
      CASE WHEN  (DurationSeconds <= 120) THEN 1
-- The pattern repeats with the same keyword and after the condition the same word and next value          
       WHEN (DurationSeconds > 120 AND DurationSeconds <= 600) THEN  2
-- Use the same syntax here             
       WHEN (DurationSeconds > 601 AND DurationSeconds <= 1200) THEN 3
-- Use the same syntax here               
       WHEN (DurationSeconds > 1201 AND DurationSeconds <= 5000) THEN 4
-- Specify a value      
       ELSE 5 
       END AS SecondGroup   
FROM Incidents





