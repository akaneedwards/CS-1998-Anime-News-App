import json
import os
import requests
import csv
import xml.etree.ElementTree as ET 



from time import sleep
from db import db
from db import Anime
from flask import Flask
from flask import request

url = "https://www.animenewsnetwork.com/encyclopedia/reports.xml?id=155&type=anime&nlist=50"
initresponse = requests.get(url)
with open('animereports.xml', 'wb') as f:
    f.write(initresponse.content)
desc = """In the land north of Britannia, there is a forest where humans are not allowed to go, and it is known as the "Fairy King's Forest." The one known as the Fairy King, Harlequin, has not been seen for 700 years. His younger sister Elaine guards the Fountain of Youth from human greed by herself. After many partings and 700 years of isolation, her tears are about to dry up. Then, a young man appears seeking the Fountain of Youth. That young man's name is Ban. Over the course of seven days with Ban, Elaine's heart is healed."""

def parseXML(xmlfile):
    tree = ET.parse(xmlfile)
    root = tree.getroot()
    animeitems = []
    for child in root:
        anime = {}
        name = child.find('name').text
        anime['name'] = name
        anime['description'] = desc
        animeitems.append(anime)

    return animeitems

animes = parseXML('animereports.xml')

app = Flask(__name__)
db_filename = "anime.db"

app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///%s" % db_filename
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = True

db.init_app(app)
with app.app_context():
    db.create_all()
    for a in animes:
        if a['name']:
            new_anime = Anime(name=a['name'], description=a['description'])
            db.session.add(new_anime)
            db.session.commit()
            new_anime.serialize()


# your routes here
# generalized response formats
def success_response(data, code=200):
    return json.dumps({"success": True, "data": data}), code


def failure_response(message, code=404):
    return json.dumps({"success": False, "error": message}), code


# -- ANIME ROUTES ------------------------------------------------------


@app.route("/")
@app.route("/api/animes/")
def get_animes():
    return success_response([a.serialize() for a in Anime.query.all()])


@app.route("/api/animes/", methods=["POST"])
def create_anime():
    body = json.loads(request.data)
    new_anime = Anime(name=body.get('name'), description=body.get('description'))
    db.session.add(new_anime)
    db.session.commit()
    return success_response(new_anime.serialize(), 201)



@app.route("/api/animes/<int:anime_id>/", methods=["DELETE"])
def delete_anime(anime_id):
    anime = Anime.query.filter_by(id=anime_id).first()
    if anime is None:
        return failure_response('Anime not found!')
    db.session.delete(anime)
    db.session.commit()
    return success_response(anime.serialize())



if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host="0.0.0.0", port=port)
