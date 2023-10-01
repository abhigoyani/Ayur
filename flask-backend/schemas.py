from marshmallow import Schema, fields



class PlainUserSchema(Schema):
    id = fields.Integer(dump_only=True)
    mobile_number = fields.String(required=True)
    remainder_mobile = fields.String(required=False)

class PlainScheduleSchema(Schema):
    id = fields.Integer(dump_only=True)
    medicine_name = fields.String(required=True)
    description = fields.String(required=False)
    datetime = fields.DateTime(required=True)

class ScheduleSchema(PlainScheduleSchema):
    user_id = fields.Integer(required=True,dump_only=True)
    user = fields.Nested(PlainUserSchema(), dump_only=True)
    last_taken = fields.DateTime(required=False,default=None)
    
class UserSchema(PlainUserSchema):
    schedules = fields.Nested(PlainScheduleSchema(), dump_only=True)

class SendOtpSchema(Schema):
    mobile_number = fields.String(required=True,error_messages={"required": "Mobile no is required."})
    message = fields.Str(dump_only=True,default="success",)

class  VerifyOtpSchema(Schema):
    mobile_number = fields.String(required=True,error_messages={"required": "Mobile no is required."})
    otp = fields.String(required=True,load_only=True , error_messages={"required": "OTP is required."})  
    new_registered  = fields.Boolean(dump_only=True,default=False)
    token = fields.String(dump_only=True,default="success")

class UpdateLastTakenSchema(Schema):
    id = fields.Integer(required=True)
    last_taken = fields.DateTime(required=True,load_only=True)
    