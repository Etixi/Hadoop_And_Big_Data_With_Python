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

# Enregistrez un filtre pour les lauréats des organisations dont les prix ont été remportés avant 1945
before = {
    "gender" : "org",
    "prizes.year" : {"$lt" : "1945"}
}
# Enregistrez un filtre pour les lauréats d'organisations ayant remporté des prix en 1945 ou après

in_or_after = {
    "gender" : "org",
    "prizes.year" : {"$gte" : "1945"}
}

n_before = db.laureates.count_documents(before)
n_in_or_after = db.laureates.count_documents(in_or_after)
ratio = n_in_or_after / (n_in_or_after + n_before)


# Imprimer les résultats
print(f"Nombre de lauréats des organisations dont les prix ont été remportés avant 1945: {n_before}")
print(f"Nombre de lauréats d'organisations ayant remporté des prix en 1945 ou après: {n_in_or_after}")
print(f"Rapport approximatif: {ratio:.2f}")