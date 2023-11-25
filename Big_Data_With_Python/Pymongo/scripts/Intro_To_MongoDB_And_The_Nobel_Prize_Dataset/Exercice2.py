import requests
from pymongo import MongoClient

# Le client se connecte à "localhost" par défaut
client = MongoClient()
print("=="*60)
print(client)

# Créer une base de données "nobel" locale à la volée
db = client["nobel"]

#================================== Accès Aux Collections ==========================================#
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

# Retireve sample prize and laureate documents
prize = db.prizes.find_one()
laureate = db.laureates.find_one()

# Print the sample prize and laureate documents
print("=="*60)
print(prize)
print(laureate)
print(type(prize))
print(type(laureate))

# Get the fields in each type of documents
prize_fields = list(prize.keys())
laureate_fields = list(laureate.keys())
print("=="*60)
print(prize_fields)
print(laureate_fields)

# Get the values in each type of documents
prize_values = list(prize.values())
laureate_values = list(laureate.values())
print("=="*60)
print(prize_values)
print(laureate_values)
