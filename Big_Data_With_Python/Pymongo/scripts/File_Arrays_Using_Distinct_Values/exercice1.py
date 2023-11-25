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

print(db.laureates.count_documents({
    "prizes" : {"$elemMatch": {
        "category" : "physics",
        "share" : {"$ne" : "1"},
        "year" : {"$lt" : "1945"}
    }}
}))

# Comptez le nombre de lauréats qui ont remporté un prix non partagé en physique après la Seconde Guerre mondiale

unshared_after_ww2 = db.laureates.count_documents({
    "prizes": {"$elemMatch": {
        "category": "physics",
        "share": "1",
        "year": {"$gte": "1945"}}}
})

# Comptez le nombre de lauréats qui ont remporté un prix partagé en physique après la Seconde Guerre mondiale

shared_after_ww2 = db.laureates.count_documents({
    "prizes": {"$elemMatch": {
        "category": "physics",
        "share": {"$ne": "1"},
        "year": {"$gte": "1945"}}}
})

# Calculer le rapport approximatif
approximate_ratio = unshared_after_ww2 / shared_after_ww2

# Imprimer les résultats
print(f"Nombre de lauréats ayant remporté un prix non partagé en physique après la Seconde Guerre mondiale : {unshared_after_ww2}")
print(f"Nombre de lauréats ayant remporté un prix partagé en physique après la Seconde Guerre mondiale : {shared_after_ww2}")
print(f"Rapport approximatif: {approximate_ratio:.2f}")
