from flask_smorest import Blueprint,abort
from flask.views import MethodView
from flask_jwt_extended import jwt_required, current_user
from util.symptom_find import symptomsDetails

symptoms_bp = Blueprint('Symptoms','symptoms',description='Symptoms related operations')

@symptoms_bp.route('/symptoms/<string:symptom>/find')
class SymptomsList(MethodView):
    @symptoms_bp.response(200)
    def get(self,symptom):
        print(symptom)
        
        return symptomsDetails(symptom),200