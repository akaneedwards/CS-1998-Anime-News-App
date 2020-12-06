import json

from time import sleep
from db import db
from db import Anime
from flask import Flask
from flask import request

app = Flask(__name__)
db_filename = "anime.db"

app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///%s" % db_filename
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = True

db.init_app(app)
with app.app_context():
    db.create_all()


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
def create_course():
    body = json.loads(request.data)
    new_anime = Anime(code=body.get('code'), name=body.get('name'))
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
    app.run(host="0.0.0.0", port=5000, debug=True)
