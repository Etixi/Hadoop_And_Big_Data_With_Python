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

# Recher des laureats dont le prenom commence par "G" et le nom commence par "S"
print("=="*60)
docs = db.laureates.find(
    filter = {
        "firstname" : {"$regex" : "^G"},
        "surname" : {"$regex" : "^S"}}
)
# Imprime le premier document
print(docs[0])


# Utilise la projection pour sélectioner uniquement le prenom et le nom
print("=="*60)
docs = db.laureates.find(
    filter = {
        "firstname" : {"$regex" : "^G"},
        "surname" : {"$regex" : "^S"}},
    projection = ["firstname", "surname"]
)
# imprime le premier document
print(docs[0])

# Utilisez la projection pour sélectionner uniquement le prenom et le nom
print("=="*60)
docs = db.laureates.find(
    filter = {
        "firstname" : {"$regex" : "^G"},
        "surname" : {"$regex" : "^S"}},
    projection = ["firstname", "surname"]
)
# Parcourez les documents et concaténez le prenom et le nom
full_names = [doc["firstname"] + " " + doc["surname"] for doc in docs]
# Imprimer les noms complets
print(full_names)