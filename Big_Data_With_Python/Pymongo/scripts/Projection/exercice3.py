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

print("=="*60)
# Enregistrer les documents, projeter le partage des laureats
prizes = db.prizes.find({}, {"laureates": 1, "_id": 0})

# Itérer sur les prix
for prize in prizes:
    # Initialiser la part totale
    total_share = 0
    # Parcourez les laureats du prix
    for laureate in prize.get("laureates", []):
        # Ajouter la part du laureat à total_share
        total_share += 1 / float(laureate.get("share", 1))  # Use 1 as default share if share is not present
    # Imprimer la part totale
    print(total_share)


