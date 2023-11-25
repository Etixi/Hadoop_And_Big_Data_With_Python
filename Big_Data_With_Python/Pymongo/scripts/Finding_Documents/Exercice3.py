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

#===========================================================================================#

# Enregistrez un filtre pour les lauréats nés aux États-Unis, au CANADA ou au Mexique
criteria = {"bornCountry" :
                {"$in" : ["USA", "Canada", "Mexico"]}
            }
# Comptez-les et enregistrez le décompte
count = db.laureates.count_documents(criteria)
print("=="*60)
print(count)

# Enregistrez un filtre pour les lauréats décédés aux États-Unis et qui n'y sont pas nés
criteria = {"diedCountry" : "USA",
            "bornCountry" : {"$ne" : "USA"},
            }

# Compte les
count = db.laureates.count_documents(criteria)
print(count)