from twilio.rest import Client
from twilio.base.exceptions import TwilioRestException
import os

class Verify:
    account_sid = os.environ.get('TWILIO_SID')
    auth_token = os.environ.get('TWILIO_AUTH_TOKEN')
    client = Client(
        account_sid, auth_token
    )
    service = os.environ.get('TWILIO_VERIFY_SERVICE_SID')
    def sendOtp(self, moNo):
        try:
            verification = self.client.verify.v2.services(self.service).verifications.create(
                to=moNo, channel="sms"
            )
            # print(verification.__dict__)
            return verification.status
        except TwilioRestException as e:
            print(e.__str__(),"hello")
            raise TwilioRestException(
                401, e
            )
    
    def verifyOtp(self, moNo, code):
        try:
            verification_check = self.client.verify.services(
                self.service
            ).verification_checks.create(to=moNo, code=code)
            print(verification_check.status)
            return verification_check.status
        except TwilioRestException as e:
            raise TwilioRestException(
                401, e
            )