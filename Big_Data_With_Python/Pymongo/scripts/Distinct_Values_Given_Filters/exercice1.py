import requests
from pymongo import MongoClient

# Le client se connecte à "localhost" par défaut
client = MongoClient()

print("=="*60)
print(client)

# Créer une base de données "nobel" locale à la volée
db = client["nobel"]

#========================================================================================#
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

#========================================================================================#

# Enregistrez un filtre pour les documents de prix avec trois lauréats ou plus
criteria = {"laureates.2" : {"$exists" : True}}

# Enregistrer l'ensemble des catégories de prix distinctes dans des documents répondant aux critères
triple_play_categories = set(db.prizes.distinct("category", criteria))
print(triple_play_categories)

# Define the expected categories
expected_categories = triple_play_categories.union({"literature"})
print(expected_categories)

# Confirmer que la littérature est la seule catégorie ne satisfaisant pas aux critères.
assert set(db.prizes.distinct("category")) - triple_play_categories == {"literature"}