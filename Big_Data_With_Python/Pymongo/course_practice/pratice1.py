import requests
from pymongo import MongoClient

# Le client se connecte à "localhost" par défaut
client = MongoClient()
print("=="*60)
print(client)

# Créer une base de données "nobel" locale à la volée
db = client["nobel"]

#========================================================================================#
for collection_name in ["prizes", "laureats"]:
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

#===========================================================================================#
print("=="*60)
# Accéder aux base de données et collections: utiliser []
        # client is a dictionary of databases
db = client["nobel"]
print(db)
        # la base de données est un dictionnaire de collection
prizes_collection = db["prizes"]
print(prizes_collection)

#===============================================================================================#
# Accéder aux base de données et collections: utiliser .
    # la base de données sont les attributs d'un client
db = client.nobel
    # les collections sont des attributs de bases de données
prizes_collection = db.prizes

#==================================== Count documents in Collection ===============================#
# Use empty document{} as a filter
filter = {}
# Count documents in a collection
n_prizes = db.prizes.count_documents(filter)
n_laureats = db.laureates.count_documents(filter)
print("=="*60)
print(n_prizes)
print(n_laureats)

# find one document to inspect
print("=="*60)
doc = db.prizes.find_one(filter)
print(doc)

