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

def all_laureates(prize):
    # Check if "laureates" is present in the prize document
    if "laureates" in prize:
        # Filter out laureates without a surname
        valid_laureates = [laureate for laureate in prize["laureates"] if "surname" in laureate]

        # Sort the valid laureates by surname
        sorted_laureates = sorted(valid_laureates, key=lambda x: x.get("surname", ""))

        # Extract surnames
        surnames = [laureate.get("surname", "") for laureate in sorted_laureates]

        # Concatenate surnames separated with " and "
        all_names = " and ".join(surnames)

        return all_names
    else:
        return "No laureates"


# Test the function on the provided sample prize document
sample_prize = {
    'year': '1903',
    'category': 'physics',
    'laureates': [
        {'id': '4', 'firstname': 'Antoine Henri', 'surname': 'Becquerel', 'motivation': '"in recognition of the extraordinary services he has rendered by his discovery of spontaneous radioactivity"', 'share': '2'},
        {'id': '5', 'firstname': 'Pierre', 'surname': 'Curie', 'motivation': '"in recognition of the extraordinary services they have rendered by their joint researches on the radiation phenomena discovered by Professor Henri Becquerel"', 'share': '4'},
        {'id': '6', 'firstname': 'Marie', 'surname': 'Curie, née Sklodowska', 'motivation': '"in recognition of the extraordinary services they have rendered by their joint researches on the radiation phenomena discovered by Professor Henri Becquerel"', 'share': '4'}
    ]
}
# tester la fonction sur un exemple de doc
print("=="*60)
print(all_laureates(sample_prize))


# find physics prizes, project year and first and last name, and sort by year
docs = db.prizes.find(
    filter = {'category' : 'physics'},
    projection = ["year", "laureates"],
    sort = [("year", 1)]
)

# print the year and laureates names (from all_laureates)
print("=="*60)
for doc in docs:
    print("{year} : {names}".format(year=doc["year"], names=all_laureates(doc)))
