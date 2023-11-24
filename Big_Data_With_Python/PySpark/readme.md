### **Opérations RDD (ensemble de données distribuées résilientes)**

| Operations         | Descriptions                                                                    |
|--------------------|---------------------------------------------------------------------------------|
| **`parallelize()`** | Créez un `RDD`.                                                                   |
| **`map()`**        | Transforme chaque élément du `RDD`                                                |
| **`filter()`**      | renvoie un nouveau `RDD` avec uniquement les éléments qui satisfont un condition. |
| **`reduce()`**       | Agréger les éléments `RDD` à l'aide d'une fonction.                               |
| **`collect()`**      | Renvoie tous les éléments du `RDD`.                                               |
| **`count()`**        | compte les éléments du `RDD`.                                                     |
| **`first()`**        | renvoie le premier élément du `RDD`.                                              |
| **`take()`**         | renvoie les `n` premiers éléments du `RDD`.                                       |
| **`foreach()`**      | applique une fonction à chaque élément du `RDD`.                                  |
| **`groupByKey()`**   | regroupe les valeurs avec la même clé.                                          |
| **`reduceByKey()`**  | Réduire les valeurs avec la même clé à l'aide d'une fonction.                   |
| **`sortBy()`**       |  Trie le `RDD`.                                                                   |
| **`join()`**         | joignez deux `RDD`.|
| **`union()`**        | renvoie un nouveau `RDD` contenant l'union des éléments dans le RDD source et un autre RDD.|

### **Opérations DataFrame:**


| Operations                                                | Descriptions                                         |
|-----------------------------------------------------------|------------------------------------------------------|
| `createDataFrame()`                                       | crée un DataFrame à partir d'un RDD ou d'une liste.  |
| `select()`                                                | sélectionne des colonnes spécifiques d'un DataFrame. |
| `filter() ou where()`| filtre les lignes dans un DataFrame.                 |
| `groupBy()`| regrouper par une ou plusieurs colonnes.             |
| `orderBy() ou sort()` |  trier sur une ou plusieurs colonnes.                |
| `drop()`                                                  | supprime une colonne.                                |
| `withColumn()`                                            | ajoute ou remplace une colonne.                      |
| `withColumnRenamed()`                                     | renomme une colonne.                                 |
| `join()`                                                  | joignez deux DataFrames.                             |
| `describe()`                                              | calcule des statistiques récapitulatives.            |
| `dropna()`                                                | supprime les lignes avec des valeurs nulles.         |
| `fillna()`                                                | remplit les valeurs nulles.           |               
| `agg()`                                                | agréger les données après le regroupement.           |
|`distinct() `| renvoie des lignes distinctes.|
|`limit()` | limite le nombre de lignes.|

### **Opérations SparkSQL:**


| Operations         | Descriptions                                                                    |
|--------------------|---------------------------------------------------------------------------------|
|`spark.sql()` | exécute des requêtes `SQL`.|
|`createOrReplaceTempView()` | crée une vue temporaire.|
|`createGlobalTempView()` | crée une vue temporaire globale.|

### **Sources de données et écriture de données**

| Operations         | Descriptions                                                                    |
|--------------------|---------------------------------------------------------------------------------|
|`read.csv()` | lit les données d'un fichier CSV.|
| `write.csv()` | écriture des données dans un fichier CSV.|
|`read.json()` | lit les données d'un fichier JSON.|
| `write.json()` | écriture de données dans un fichier JSON.|
|`read.parquet()` | lit les données d'un fichier Parquet.|
|`write.parquet()` | écriture de données dans un fichier Parquet.|
|`read.jdbc()` | lit les données d'une source JDBC.|
|`write.jdbc()` | écriture de données dans une source JDBC.|


### **MLlib - Bibliothèque d'apprentissage automatique**

| Operations                                                                       | Descriptions                                              |
|----------------------------------------------------------------------------------|-----------------------------------------------------------|
| `VectorAssembler()`                                                              | Assemble des vecteurs de caractéristiques.                |
| `StringIndexer()`                                                                | convertit les colonnes de chaînes en valeurs numériques.  |
| `OneHotEncoder()`                                                                | fonctionnalités catégorielles d'encodage à chaud.         |
| `StandardScaler()`                                                               | fonctionnalités de mise à l'échelle.                      |
| `LinearRegression()`                                                             | modèle de régression linéaire.                            |
| `DecisionTreeClassifier()`                                                       | modèle de classification d'arbre de décision.             |
| `KMeans()`                                                                       | clustering K-means.                                       |
| `CrossValidator()`                                                               | Validation croisée pour la sélection du modèle.           |
| `TrainValidationSplit()`|  validation de train pour le réglage des hyperparamètres. |

### **Graph() : crée un graphique.**

| Operations      | Descriptions                                 |
|-----------------|----------------------------------------------|
| `Graph()`       | accédez aux sommets d'un graphe.             |
| `vertices`      | accédez aux bords d'un graphe.               |
| `edges`         | accédez aux bords d'un graphe.               |
| `triplets`      | Accédez aux triplets d'un graphe.            |
| `inDegrees`     | calcule le degré en de chaque sommet.        |
| `outDegrees`    | calcule le degré de sortie de chaque sommet. |
| `subgraph()`    | génère un sous-graphe.                       |
| `mapVertices()` | Transforme les sommets d'un graphe.          |
| `mapEdges()`    | Transforme les bords d'un graphique          |

### **Streaming:**

| Operations         | Descriptions                                                 |
|--------------------|--------------------------------------------------------------|
| `StreamingContext()` | crée un contexte de streaming.                               |
| `updateStateByKey()` | conserve les informations avec état.                         |
| `window()`           | renvoie un nouveau DStream calculé sur la base de lots fenêtrés. |
| `reduceByKeyAndWindow()` |  Réduire par clé sur une fenêtre.                            |


### **Performances et optimisation:**

| Operations             | Descriptions                                                     |
|------------------------|------------------------------------------------------------------|
| `cache() ou persist()`  | cache un RDD ou un DataFrame.|
| `unpersist()`            | supprime les données de la mémoire.|
| `Broadcast()`            | diffuse une variable en lecture seule.|
| `repartition()`          | Répartitionne les données.|
| `coalesce()`             | diminue le nombre de partitions.|


### ***Fonctions utilitaires:**

| Operations         | Descriptions                                                     |
|--------------------|------------------------------------------------------------------|
|`udf()` | crée une fonction définie par l'utilisateur.|
|`lit()` | crée une colonne de valeur littérale.|
|`when()` | évalue une condition.|


### **Statistiques et algèbre linéaire (MLlib):**

| Operations         | Descriptions                                                     |
|--------------------|------------------------------------------------------------------|
|`Statistics.colStats()` | statistiques de colonnes.|
|`Statistics.corr()` | Corrélation entre deux séries.|
|`DenseVector()` | crée un vecteur dense.|
|`SparseVector()` | crée un vecteur clairsemé.|
|`RowMatrix()` | crée une matrice de lignes.|

### **Fonctionnalités avancées**

| Operations       | Descriptions                                                     |
|------------------|------------------------------------------------------------------|
|`windowSpec()` | définit une spécification de fenêtre.|
|`over()` | applique une spécification de fenêtre.|
|`lead() et lag()` | fonctions d'avance et de retard dans les opérations de fenêtre.|
|`pivot()` | données pivot.|
|`explode()`| Transforme un tableau ou une colonne de carte en plusieurs lignes.|


### **Autres fonctions et méthodes**

| Operations                              | Descriptions                                                                                                  |
|-----------------------------------------|---------------------------------------------------------------------------------------------------------------|
| `function.concat()`                     | concatène deux colonnes ou plus.                                                                              |
| `function.substring()`                  | extrait une sous-chaîne.                                                                                      |
| `functions.year() et Functions.month()` | Extrayez l'année et le mois.                                                                                  |
| `functions.dayofyear() et Functions.dayofmonth()` | extraire le jour.                                                                                             |
|`function.round()` | nombres ronds.                                                                                                |
|`function.length()` | calcule la longueur d'une chaîne.                                                                             |
| `function.size()`| calcule la taille d'une liste ou d'une carte.                                                                 |
|`function.isnan()` | vérifie les valeurs NaN.                                                                                      |
| `function.isnull()`| recherche les valeurs NULL.                                                                                   |
|`function.rand()`| génère des valeurs aléatoires.                                                                                |
| `function.split()`| divise une chaîne.                                                                                            |
|`function.array()`| crée un tableau.                                                                                              |
|`function.array_contains()`| vérifie si un tableau contient une valeur.                                                                    |
|`function.map()` | crée une carte.                                                                                               |
|`functions.map_keys() et functions.map_values()`| clés d'accès et leurs d'une carte.                                                                            |
|`functions.struct()`| crée une structure.                                                                                           |
|`functions.from_json() et Functions.to_json()`| travaillez avec JSON.                                                               |                          |
| `functions.current_date() et Functions.current_timestamp()`| obtenezdate et heure actuelles.                                                                               |
|`functions.date_add() et Functions.date_sub()`| ajouter ou soustraire des joursà partir d'un rendez-vous.                                                     |
|`functions.date_diff()`| calcule la différence entre deux dates.                                                                       |
|`SparkContext.addFile() et SparkFiles.get()`| auxiliaire de distributionfichiers (par exemple, fichiers Python, fichiers de données) requis par les tâches. |