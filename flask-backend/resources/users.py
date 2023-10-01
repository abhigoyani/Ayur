from flask_smorest import Blueprint,abort
from flask.views import MethodView
from models import User
from schemas import SendOtpSchema,VerifyOtpSchema
from util.auth import Verify
from twilio.base.exceptions import TwilioRestException
from flask_jwt_extended import create_access_token
from flask_jwt_extended import jwt_required,current_user

users_bp = Blueprint('Users','user',description='User related operations')

verify = Verify()

@users_bp.route('/sendotp')
class UserSendOtp(MethodView):
    @users_bp.arguments(SendOtpSchema)
    @users_bp.response(200,SendOtpSchema)
    def post(self,user_data):
        mobile = user_data.get("mobile_number")
        try:
            return {"message":verify.sendOtp(mobile)}
        except TwilioRestException as e:
                print(e.__str__())
                abort(403,message="error in otp send"+e.__str__())



@users_bp.route('/verifyotp')
class UserVerifyOtp(MethodView):

    @users_bp.arguments(VerifyOtpSchema)
    @users_bp.response(200,VerifyOtpSchema)
    def post(self,userData):
        mobile = userData.get("mobile_number")
        otp = userData.get("otp")
        try:
            status = verify.verifyOtp(mobile,otp)
            if status == "approved":
                user = User.find_by_mobile_number(mobile)
                token = create_access_token(identity=mobile)
                if user:
                     user.token = token
                     return user
                else:
                    user = User(mobile_number=mobile,token=token)
                    user.save_to_db()
                    response = {'mobile_number':user.mobile_number, 'token':user.token, 'new_registered':True}
                    
                    return response
            else:
                abort(403,message="OTP is not valid")
        except TwilioRestException as e:
                print(e.__str__())
                abort(403,message="error in otp verify"+e.__str__())





# def register_user():
#     user_schema = UserSchema()

#     data = request.get_json()
#     errors = user_schema.validate(data)

#     if errors:
#         return jsonify({'message': 'Validation errors', 'errors': errors}), 400

#     mobile_number = data.get('mobile_number')
#     remainder_mobile = data.get('remainder_mobile')

#     existing_user = User.find_by_mobile_number(mobile_number)

#     if existing_user:
#         return jsonify({'message': 'User already exists.'}), 400

#     user = User(mobile_number=mobile_number, remainder_mobile=remainder_mobile)
#     user.save_to_db()

#     return jsonify({'message': 'User created successfully.', 'user': user_schema.dump(user)}), 201