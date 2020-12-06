from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class Anime(db.Model):
    __tablename__ = 'anime'
    id = db.Column(db.Integer, primary_key=True)
    code = db.Column(db.String, nullable=False)
    name = db.Column(db.String, nullable=False)


    def __init__(self, **kwargs):
        self.code = kwargs.get('code', '')
        self.name= kwargs.get('name', '')

    def serialize(self):
        return {
            'id': self.id, 
            'code': self.code,
            'name': self.name
        }

