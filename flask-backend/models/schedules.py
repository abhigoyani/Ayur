from db import db

class Schedule(db.Model):
    __tablename__ = 'schedules'

    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)
    medicine_name = db.Column(db.String(50), nullable=False)
    datetime = db.Column(db.DateTime, nullable=False)
    description = db.Column(db.Text, nullable=True)
    usage = db.Column(db.String, nullable=True) 
    last_taken = db.Column(db.DateTime, nullable=True)  # new column

    user = db.relationship('User', back_populates='schedules')

    def __init__(self, medicine_name, datetime, user_id,description=None, usage=None,):
        self.medicine_name = medicine_name
        self.datetime = datetime
        self.description = description
        self.usage = usage
        self.user_id = user_id  

    def save_to_db(self):
        db.session.add(self)
        db.session.commit()

    def delete_from_db(self):
        db.session.delete(self)
        db.session.commit()

    @classmethod
    def find_by_id(cls, schedule_id):
        return cls.query.filter_by(id=schedule_id).first()

    @classmethod
    def find_by_user_id(cls, user_id):
        return cls.query.filter_by(user_id=user_id).all()

    def update_last_taken(self, last_taken):
        self.last_taken = last_taken
        print(self)
        db.session.commit()
    
    def add_usage(self, usage):
        self.usage = usage
        db.session.commit()