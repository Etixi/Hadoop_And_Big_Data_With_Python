##  **Introduction à MongoDB en Python**


### **Description du cours**

+ ***`MongoDB` est un outil pour explorer les données structurées comme bon vous semble. En tant que base de données `NoSQL`, elle ne suit pas le format relationnel strict imposé par SQL. En fournissant des fonctionnalités qui nécessitent généralement l'ajout de couches à `SQL`, il réduit la complexité. Avec un schéma dynamique, vous pouvez gérer ensemble des données très différentes et consolider les analyses. La flexibilité de `MongoDB` vous permet de continuer à vous améliorer et à résoudre les problèmes à mesure que vos besoins évoluent. Dans ce cours, vous apprendrez le langage `MongoDB` et l'appliquerez à la recherche et à l'analyse. En travaillant avec des données non traitées de l'API officielle `nobelprize.org`, vous explorerez et répondrez aux questions sur les lauréats et les prix Nobel.***

<img src="https://www.datacamp.com/statement-of-accomplishment/badge/course/abbdf08fdc5095d4b97e86167eab42543510efde.png"/>

### **1) Données structurées de manière flexible**


+ **Ce chapitre vise à avoir une vue d'ensemble de la structure des données du prix Nobel. Vous relierez les documents, collections et bases de données MongoDB aux types JSON et Python.**
+ **Vous utiliserez ensuite des filtres, des opérateurs et la notation par points pour explorer la sous-structure.**

| Objectifs                                                       |
|-----------------------------------------------------------------|
| Introduction à MongoDB et à l'ensemble de données du prix Nobel |
| Compter les documents dans une collection                       |
| Répertorier les bases de données et les collections             |
| Liste des champs d'un document                                  |
| Recherche de documents                                          |
|approximation "née"|
|Composer des filtres|
|Nous avons des options|
|Notation par points : atteindre la sous-structure|
|Choisir des outils|
|Commencer notre ascension|
|Notre approximation 'née' et un lauréat spécial|



### **2) Travailler avec des valeurs et des ensembles distincts**

+ **Vous avez maintenant une idée de la structure des données. Ce chapitre consiste à plonger vos orteils dans les pools de valeurs pour divers champs. Vous collecterez des valeurs distinctes, testerez l’appartenance à des ensembles et ferez correspondre les valeurs aux modèles.**

| Objectifs |
|-----------|
|Valeurs distinctes de l'enquête|
|Validation des données catégorielles|
|Jamais de là, mais parfois enfin là|
|Pays d'affiliation|
|Valeurs distinctes données par les filtres|
|Je suis né ici, j'y suis allé|
|Triple jeux (principalement) partout|
|Filtrer les tableaux à l'aide de valeurs distinctes|
|Partage en physique après la Seconde Guerre mondiale|
|Pendant ce temps, dans d'autres catégories...|
|Organisations et prix au fil du temps|
|Distinct comme vous l'aimez|
|Glenn, George et d'autres membres de l'équipe britannique|
|L'Allemagne, hier et aujourd'hui|
|Le précieux transistor|


### **Obtenez uniquement ce dont vous avez besoin, et rapidement**

+ **Vous pouvez désormais interroger facilement des collections et collecter des documents à examiner et à analyser avec Python. Mais ce processus est parfois lent et onéreux pour les collections et documents volumineux. Ce chapitre traite des différentes manières d'accélérer et de simplifier ce processus.**

| Objectifs |
|-----------|
|Projection|
|Actions du Prix 1903 de Physique|
|Rassemblement de l'équipage GS|
|Faire notre part de validation des données|
|Tri|
|Quel genre de chose ?|
|Trier ensemble : MongoDB + Python|
|Années de transition|
|Que sont les index ?|
|Catégories à part élevée|
|Récemment célibataire ?|
|Né et affilié|
|Limites|
|Fixer une nouvelle limite ?|
|Les cinq premiers prix avec quart de parts|
|Pages de personnes primées par les particules|


### **IV) Pipelines d'agrégation : laissez le serveur le faire à votre place**

+ **Vous avez utilisé la projection, le tri, l'indexation et les limites pour accélérer la récupération des données. Mais il existe encore des goulots d’étranglement gênants en termes de performances dans vos pipelines d’analyse. Vous devez encore récupérer une tonne de données. Ainsi, la bande passante du réseau, le traitement en aval et la capacité de mémoire ont toujours un impact sur les performances. Ce chapitre concerne l'utilisation de MongoDB pour effectuer des agrégations pour vous sur le serveur.**

| Objectifs |
|-----------|
|Introduction à l'agrégation|
|Étapes de séquençage|
|Agrégation des données nationales de quelques individus|
|Passer le relais de l'agrégation à Python|
|Opérateurs d'agrégation et regroupement|
|Chemins et ensembles de champs|
|Organisation de prix|
|Années sabbatiques, cumulées|
|Zoomer sur les champs du tableau|
|Incorporation d'expressions d'agrégation|
|Ici et ailleurs|
|Pays de naissance par catégorie de prix|
|Quelque chose de plus : $addFields pour faciliter l'analyse|
|"...c'est la vie de tes années"|
|Combien de prix ont été décernés aux immigrants ?|
|Raffinement : filtrer les personnes "non affiliées"|
|Conclure|