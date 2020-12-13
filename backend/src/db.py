from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class Anime(db.Model):
    __tablename__ = 'anime'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String, nullable=False)
    description = db.Column(db.String, nullable=True)


    def __init__(self, **kwargs):
        self.name = kwargs.get('name', '')
        self.description= kwargs.get('description', '')

    def serialize(self):
        return {
            'id': self.id, 
            'name': self.name,
            'description': self.description
        }

