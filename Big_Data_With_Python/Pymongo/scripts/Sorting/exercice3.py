import requests
from operator import itemgetter
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

# original categories from 1901
original_categories = db.prizes.distinct("category", {"year": "1901"})
print("=="*60)
print(original_categories)

# project year and category, and sort
docs = db.prizes.find(
        filter={},
        projection={"year":1, "category":1, "_id":0},
        sort=[("year", -1), ("category", 1)]
)

#print the documents
for doc in docs:
  print(doc)