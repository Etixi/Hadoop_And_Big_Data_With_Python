import requests
from bson.regex import Regex
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

print("=="*60)
#========================================================================================#

# filtre pour les lauréats avec "Allemagne" dans leur valeur "bornCountry"
criteria = {"bornCountry" : Regex('Germany', 0)}
print(set(db.laureates.distinct("bornCountry", criteria)))

# filtre pour les lauréats avec une valeur "bornCountry" commençant par "Allemagne"
criteria = {"bornCountry" : Regex("^Germany")}
print(set(db.laureates.distinct("bornCountry", criteria)))

# filtre pour les lauréats avec une valeur "bornCountry" commençant par "^Germany" et "now"
criteria = {"bornCountry" : Regex("^Germany " + "\(" + "now")}
print(set(db.laureates.distinct("bornCountry", criteria)))

# remplissez une valeur de chaîne à prendre en sandwich entre les chaînes "now" et "$"
criteria = {"bornCountry" : Regex("now" + " Germany\)" + "$")}
print(set(db.laureates.distinct("bornCountry", criteria)))



