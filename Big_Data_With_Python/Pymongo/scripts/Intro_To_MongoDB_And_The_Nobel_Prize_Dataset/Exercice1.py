import requests
from pymongo import MongoClient

# Le client se connecte à "localhost" par défaut
client = MongoClient()
print("=="*60)
print(client)

# Créer une base de données "nobel" locale à la volée
db = client["nobel"]

#================================== Accès Aux Collections ==========================================#
for collection_name in ["prizes", "laureates"]:
    # collecter les données de l'API
    response = requests.get("https://api.nobelprize.org/v1/prize.json".format(collection_name[:-1]))

    # Vérifiez si la demande a abouti
    response.raise_for_status()

    try:
        # convertir les données en JSON
        documents = response.json()[collection_name]

        # Créez des collections à la volée
        db[collection_name].insert_many(documents)
    except requests.exceptions.JSONDecodeError as e:
        print(f"Error decoding JSON for {collection_name}: {e}")
    except KeyError as e:
        print(f"KeyError for {collection_name}: {e}")
    except Exception as e:
        print(f"An unexpected error occurred for {collection_name}: {e}")

#========================== Répertorier les bases de données et les collections ====================================#
# Enregistrer une liste de noms des bases de données gérées par le client
db_names = client.list_database_names()
print("=="*60)
print(db_names)
# Sauvegarder une liste de noms des collections gérées par les bases de données "nobel"
nobel_coll_names = client.nobel.list_collection_names()
print(nobel_coll_names)