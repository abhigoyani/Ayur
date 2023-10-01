import os
from twilio.rest import Client
import psycopg2



account_sid = os.getenv('TWILIO_ACCOUNT_SID')
auth_token = os.getenv('TWILIO_AUTH_TOKEN')

client = Client(account_sid, auth_token)

def makeReminderCall(phone_number,medicine_name):
    call = client.calls.create(
                        twiml='<Response><Say>Hi, this is a reminder for '+medicine_name+' </Say></Response>',
                        to=phone_number,
                        from_=os.getenv('TWILIO_PHONE_NUMBER')
                    )

    print('function called for '+phone_number+' '+medicine_name)
    # return call.sid

def send_reminders():
    # Define the connection string
    conn_string = "postgresql://futqmtbq:G_owzxqyeBOpcRcQTFxdVvgVFyv-gQzA@peanut.db.elephantsql.com/futqmtbq"

    # Connect to the database
    conn = psycopg2.connect(conn_string)

    # Open a cursor to perform database operations
    cur = conn.cursor()

    # Define the SQL query
    query = """
    SELECT DISTINCT u.mobile_number, s.medicine_name
    FROM schedules s
    JOIN users u ON s.user_id = u.id
    WHERE s.last_taken::date != CURRENT_DATE
      AND abs(EXTRACT(epoch FROM (s.last_taken - s.datetime)) / 60) > 10;
    """

    # Execute the SQL query
    cur.execute(query)

    # Fetch all rows from the result set
    rows = cur.fetchall()
 
    # Iterate over the rows and call makeReminderCall for each record
    for row in rows:
        mobile_number, medicine_name = row
        makeReminderCall(mobile_number, medicine_name)

    # Close the cursor and connection
    cur.close()
    conn.close()

# timer_trigger
send_reminders()