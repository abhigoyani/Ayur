from flask_smorest import Blueprint,abort
from flask.views import MethodView
from models import Schedule,User
from schemas import ScheduleSchema,UpdateLastTakenSchema
from flask_jwt_extended import jwt_required, current_user


schedules_bp = Blueprint('Schedules','schedule',description='Schedule related operations')

@schedules_bp.route('/add-schedule')
class AddSchedules(MethodView):

    @schedules_bp.arguments(ScheduleSchema)
    @schedules_bp.response(200,ScheduleSchema)
    @jwt_required()
    def post(self,schedule_data):
        if not current_user:
            abort(401, message='Invalid user')
        schedule = Schedule(**schedule_data,user_id= current_user.id)
        schedule.save_to_db()
        return schedule

@schedules_bp.route('/update-last-taken')
class UpdateLastTake(MethodView):
    @schedules_bp.arguments(UpdateLastTakenSchema)
    @schedules_bp.response(200,ScheduleSchema)
    @jwt_required()
    def post(self,updatedDateTime):
        id = updatedDateTime.get('id')
        last_taken_date = updatedDateTime.get('last_taken')
        print(last_taken_date)
        print(id)
        schedule = Schedule.find_by_id(schedule_id=id)
        print(schedule.medicine_name)
        if schedule != None:
            schedule.update_last_taken(last_taken_date)
            print(schedule)
            # schedule.update_last_taken(last_taken_date)
            return schedule
        else:
            abort(404, message='Schedule not found')

        
@schedules_bp.route('/usersss/<string:mobile_no>/schedules')
class ScheduleList(MethodView):
    @jwt_required()
    @schedules_bp.response(200,ScheduleSchema(many=True))
    def get(self,mobile_no):
        print(current_user)
        if current_user:
            # print(current_user)
            # print(current_user.schedules.all())
            return current_user.schedules
        else:
            abort(401, message='Invalid user')
