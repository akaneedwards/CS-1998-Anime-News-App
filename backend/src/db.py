from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

association_table_favs = db.Table(
    'association_table_favs',
    db.Model.metadata,
    db.Column('anime_id', db.Integer, db.ForeignKey('anime.id')),
    db.Column('user_id', db.Integer, db.ForeignKey('user.id'))
)


class Anime(db.Model):
    __tablename__ = 'anime'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String, nullable=False)
    description = db.Column(db.String, nullable=True)
    fans = db.relationship('User', secondary=association_table_favs, back_populates='favorites')

    def __init__(self, **kwargs):
        self.name = kwargs.get('name', '')
        self.description= kwargs.get('description', '')

    def serialize(self):
        return {
            'id': self.id, 
            'name': self.name,
            'description': self.description,
            'fans': self.fans
        }

class User(db.Model):
    __tablename__ = 'user'
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String, nullable=False)
    favorites = db.relationship('Anime', secondary=association_table_favs, back_populates='fans')

    def __init__(self, **kwargs):
        self.username = kwargs.get('username', '')

    def serialize(self):
        return {
            'id': self.id, 
            'username': self.username,
            'favorites': self.favorites
        }