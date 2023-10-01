from flask import Flask
from flask_smorest import Api
import urllib.parse 
from db import db
from dotenv import load_dotenv
from resources.users import users_bp
from resources.schedule import schedules_bp
from resources.symptoms import symptoms_bp
import os
from flask_jwt_extended import JWTManager
from flask_jwt_extended import create_access_token
import datetime
from models.user import User
from flask_cors import CORS


def create_app(db_url=None):
    app = Flask(__name__)
    CORS(app)
    load_dotenv()
    app.config["API_TITLE"] = "Stores REST API"
    app.config["API_VERSION"] = "v1"
    app.config["OPENAPI_VERSION"] = "3.0.3"
    app.config["OPENAPI_URL_PREFIX"] = "/"
    app.config["OPENAPI_SWAGGER_UI_PATH"] = "/docs"
    app.config[
        "OPENAPI_SWAGGER_UI_URL"
    ] = "https://cdn.jsdelivr.net/npm/swagger-ui-dist/"
    app.config['SQLALCHEMY_DATABASE_URI'] = db_url or os.getenv("DATABASE_URL")
    app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
    db.init_app(app)
    api = Api(app)

    app.config["JWT_SECRET_KEY"] = os.getenv('JWT_SECRET')
    app.config['JWT_ACCESS_TOKEN_EXPIRES'] = datetime.timedelta(days=5)
    jwt = JWTManager(app)

    @jwt.user_identity_loader
    def user_identity_lookup(user):
        return user    
    @jwt.user_lookup_loader
    def user_lookup_callback(_jwt_header, jwt_data):
        identity = jwt_data["sub"]
        return User.find_by_mobile_number(identity)


    with app.app_context():
        db.create_all()

    api.register_blueprint(users_bp)
    api.register_blueprint(schedules_bp)
    api.register_blueprint(symptoms_bp)

    return app

if __name__ == "__main__":
    app = create_app()
    app.run(host='0.0.0.0',port=5000, debug=True)