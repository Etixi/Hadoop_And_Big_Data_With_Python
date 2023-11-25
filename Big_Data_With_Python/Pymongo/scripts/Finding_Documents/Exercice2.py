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

# Créer un filtre pour les lauréats décédés aux USA
criteria = {"diedCountry" : "USA"}
# Enregistrez le nombre de ces lauréats
count = db.laureates.count_documents(criteria)
print("=="*60)
print(count)

#===========================================================================================#
# Créer un filtre pour les lauréats décédés aux États-Unis dans la HES mais nés en Allemagne
criteria = {"diedCountry": 'USA',
            "bornCountry": "Germany"}
# Enregistrez le décompte
count = db.laureates.count_documents(criteria)
print(count)

#===========================================================================================#
# Créez un filtre pour les lauréats nés en Allemagne décédés aux États-Unis et portant le prénom "Albert"
criteria = {"diedCountry": 'USA',
            "bornCountry": "Germany",
            "firstname": "Albert"}
# Enregistrez le décompte
count = db.laureates.count_documents(criteria)
print(count)
