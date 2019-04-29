import requests
from bs4 import BeautifulSoup
import pandas

monsters = [
"Dark Magician", "Red-Eyes B. Dragon", "7 Colored Fish",
"Acrobat Monkey", "Aitsu", "Alexandrite Dragon", "Alien Shocktrooper",
"Alligator's Sword", "Ally of Justice Clausolas", "Alpha the Magnet Warrior",
"Amazon of the Seas", "Amphibious Bugroth"
]

collection = {}
collection["Monsters"] = []
collection["Images"] = []

for i in range(0, len(monsters)):
    cardImage = ""
    replacedMonsterString = monsters[i].replace(" ", "_")
    corePage = requests.get("https://yugioh.fandom.com/wiki/{}".format(replacedMonsterString))
    lookerPage = BeautifulSoup(corePage.text, "html.parser")
    cardImageElements = lookerPage.find_all("img")
    for images in cardImageElements:
        testAttribute = images.get("data-image-name")
        if testAttribute is not None and testAttribute.count("notice") == 0:
            cardImage = images.get("src")
            break
    collection["Monsters"].append(monsters[i])
    collection["Images"].append(cardImage)
    print("Done: {}".format(monsters[i]))
    
data = pandas.DataFrame(collection)
print(data)
data.to_csv("cards with links.csv")
