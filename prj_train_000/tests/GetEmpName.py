# Open command window as administrator
# Execute "pip --ugrade snowflake-connector-python"
# Replace account id and username

import snowflake.connector
import getpass
import os

ACCT = os.environ.get('snowacc')

USR = 'Murali'

print ("Snowflake Account: " + ACCT)
print ("Connect as user: " + USR)
PWD = os.environ.get('snowpass')
print ("-------------------------")
print ("Connecting and Displaying Records")
print ("-------------------------")

conn = snowflake.connector.connect(user='Murali',password=PWD,account=ACCT)

cur = conn.cursor()

cur.execute("use warehouse compute_wh")

cur.execute("use mkmotors_dev.staging")

cur.execute("select * from stg_employees")

allrows=cur.fetchall()

for row in allrows:
	print ("Employee Name: " , row[1])
	print ("City Name: ", row[4], "\n")


