from datetime import date, datetime, timedelta
import maskpass
import mysql.connector
from pathlib import Path
import pickle
import streamlit_authenticator as stauth

mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password="shaH2003",
  database="newAMS"
)

mycursor = mydb.cursor()

#queries
add_mainuser_command = ("INSERT INTO User(username, password, email_ID, phone_no) VALUES (%(username)s, %(password)s, %(email_ID)s, %(phone_no)s)")
add_user_command=("INSERT INTO User(username, password, email_ID, phone_no,SUser_ID) VALUES (%(username)s, %(password)s, %(email_ID)s, %(phone_no)s,%(SUser_ID)s)")
add_goal_query=("INSERT INTO Goals (User_ID, Goal_Desc, Goal_Amount) VALUES (%(User_ID)s, %(Goal_Desc)s, %(Goal_Amount)s)")
add_portfolio_query=("INSERT INTO Portfolio (User_ID, Portfolio_Name) VALUES (%(User_ID)s, %(Portfolio_Name)s)")
add_asset_query=("INSERT INTO Asset (User_ID, Asset_Name, Asset_Type, Purchase_Amount, Purchase_Date,Quantity) VALUES (%(User_ID)s, %(Asset_Name)s, %(Asset_Type)s, %(Purchase_Amount)s, %(Purchase_Date)s,%(Quantity)s)")

get_last_user_id=("SELECT LAST_INSERT_ID()")
get_username_query=("SELECT username FROM User WHERE User_ID=%s")
get_suser_query="SELECT SUser_ID FROM User WHERE User_ID=%s"
get_portid_query="SELECT Portfolio_ID FROM Portfolio WHERE User_ID=%s"

del_goals_query="DELETE FROM Goals WHERE User_ID = %s"
del_all_goals_query="DELETE FROM Goals WHERE User_ID in (SELECT User_ID FROM User WHERE User_ID=%s OR SUser_ID = %s)"
del_assets_query="DELETE FROM Asset WHERE User_ID = %s"
del_all_assets_query="DELETE FROM Asset WHERE User_ID in (SELECT User_ID FROM User WHERE User_ID=%s OR SUser_ID = %s)"


auth_query = "SELECT User_ID FROM User WHERE email_ID = %s AND password = %s"
main_auth_query="SELECT User_ID,username,password FROM User"
email_query="SELECT email_ID FROM User"

update_password_query="UPDATE User SET password= %s WHERE email_id=%s;"

#join query
port_ass_map_join_query="SELECT p.Portfolio_ID, p.Portfolio_Name, a.Asset_ID, a.Asset_Name, a.Asset_Type, a.Purchase_Amount, a.Purchase_Date, a.Quantity FROM Portfolio p JOIN Portfolio_Assets ON p.Portfolio_ID = Portfolio_Assets.Portfolio_ID JOIN Asset a ON Portfolio_Assets.Asset_ID = a.Asset_ID WHERE p.Portfolio_ID in (SELECT Portfolio_ID FROM Portfolio WHERE User_ID in (SELECT User_ID FROM User WHERE User_ID=%s OR SUser_ID = %s))"

#procedures
user_goals= "GetGoalsByUser"
user_assets= "GetAssetByUser"
sum_assets="CalculateTotalAssets"
all_goals="GetAllGoals"
all_assets="GetAllAssets"
user_all_assets="CalculateAndReturnAssetValues"

#rec query
rec_query="WITH RECURSIVE UserHierarchy AS (SELECT User_ID, SUser_ID, username FROM User WHERE SUser_ID IS NULL UNION SELECT u.User_ID, u.SUser_ID, u.username FROM UserHierarchy h JOIN User u ON h.User_ID = u.SUser_ID )SELECT * FROM UserHierarchy WHERE SUser_ID = %s"

def auth_helper():
  usernames=[]
  email=[]
  password=[]
  mycursor.execute(main_auth_query)
  for x in mycursor:
    #print(x,type(x))
    usernames.append(x[0])
    email.append(x[1])
    password.append(x[2])

  return usernames,email,password

def get_emails():
  email=[]
  mycursor.execute(email_query)
  for x in mycursor:
    #print(x,type(x))
    email.append(x[0])

  return email

def insert_user(username,password,email_ID,phone_no,super_id):
  if(super_id):
    user_data = {
    "username": username,
    "password": password,
    "email_ID": email_ID,
    "phone_no": phone_no,
    "SUser_ID": super_id
    }
    mycursor.execute(add_user_command, user_data)
  else:
    user_data = {
    "username": username,
    "password": password,
    "email_ID": email_ID,
    "phone_no": phone_no,
    }
    mycursor.execute(add_mainuser_command, user_data)
  
  mydb.commit()
  mycursor.execute(get_last_user_id)
  new_id=mycursor.fetchone()[0]
  
  return new_id

def auth_user(email,password):
  mycursor.execute(auth_query,(email,password))
  new_id=mycursor.fetchone()
  if(new_id):
    return new_id[0]
  else:
    return False

def gen_keys():
  usernames,email,passwords=auth_helper()

  hashed_passwords=stauth.Hasher(passwords).generate()
  file_path=Path(__file__).parent/"hashed_pw.pkl"

  with file_path.open("wb") as file:
    pickle.dump(hashed_passwords,file)

def get_goals(user_id):
  mycursor.callproc(user_goals,[user_id,])
  goal_dict=dict()
  for x in mycursor.stored_results():
    for i in x.fetchall():
      goal_dict[i[2]]=i[3]
  return goal_dict

def get_assets(user_id):
  mycursor.callproc(user_assets,[user_id,])
  asset_dict=[]
  for x in mycursor.stored_results():
    for i in x.fetchall():
      asset_dict.append(i)
  return asset_dict

def get_superuser_id(u_id):
  mycursor.execute(get_suser_query,(u_id,))
  su_id=mycursor.fetchone()[0];
  return su_id

def get_username(user_id):
  mycursor.execute(get_username_query,(user_id,))
  uname=mycursor.fetchone()[0];
  return uname

def check_portfolio(user_id):
  mycursor.execute(get_portid_query,(user_id,))
  ports=mycursor.fetchone()
  if ports:
    return ports[0]
  else:
    return 0

def add_portfolio(user_id,portfolio_name):
  portfolio_data={
  "User_ID":user_id,
  "Portfolio_Name":portfolio_name
  }
  mycursor.execute(add_portfolio_query ,portfolio_data)
  mydb.commit()
  return

def add_asset(user_id,a_name,a_type,p_amount,quantity):
  date=datetime.now()
  asset_data={
  "User_ID":int(user_id),
  "Asset_Name":a_name,
  "Asset_Type":a_type,
  "Purchase_Amount":p_amount,
  "Purchase_Date":date,
  "Quantity":quantity
  }
  mycursor.execute(add_asset_query ,asset_data)
  mydb.commit()
  return 

def add_goal(user_id,goal_desc,goal_amount):
  goal_data = {
        'User_ID': user_id,
        'Goal_Desc': goal_desc,
        'Goal_Amount': goal_amount
    }
  mycursor.execute(add_goal_query,goal_data)
  mydb.commit()
  return 

def get_total_sum_asset(user_id):
  mycursor.callproc(sum_assets,[user_id,])
  for x in mycursor.stored_results():
    if x:
      return (x.fetchall()[0][0])
    else:
      return 0

def get_all_goals(user_id):
  mycursor.callproc(all_goals,[user_id,])
  goal_dict=dict()
  for x in mycursor.stored_results():
    for i in x.fetchall():
      goal_dict[i[2]]=[i[3],i[1]]
  return goal_dict

def get_all_assets(user_id):
  mycursor.callproc(all_assets,[user_id,])
  asset_dict=[]
  for x in mycursor.stored_results():
    for i in x.fetchall():
      asset_dict.append(i)
  return asset_dict

def del_goals(user_id):
  #print(f"Deleting goals for User_ID: {user_id}")
  mycursor.execute(del_goals_query,(user_id,))
  mydb.commit()
  #print(f"Goals deleted successfully")
  return

def del_all_goals(user_id):
  mycursor.execute(del_all_goals_query,(user_id,user_id,))
  mydb.commit()
  return

def del_assets(user_id):
  mycursor.execute(del_assets_query,(user_id,))
  mydb.commit()
  return

def del_all_assets(user_id):
  mycursor.execute(del_all_assets_query,(user_id,user_id,))
  mydb.commit()
  return

def get_user_all_assets(user_id):
  mycursor.callproc(user_all_assets,[user_id,])
  for x in mycursor.stored_results():
    for i in x.fetchall():
      return(i)


def port_ass_map(user_id):
  mycursor.execute(port_ass_map_join_query,(user_id,user_id,))
  pamap_dict=dict()
  for x in mycursor:
    data=[x[3],x[4],x[5],x[6],x[7]]
    if(x[1] not in pamap_dict.keys()):
      pamap_dict[x[1]]=list()
    pamap_dict[x[1]].append(data)

  return pamap_dict

def reset_password(new_passsword,email_ID):
  mycursor.execute(update_password_query,(new_passsword,email_ID))
  mydb.commit()








def show_family(user_id):
  mycursor.execute(rec_query, (user_id,))
  members=[]
  for i in mycursor.fetchall():
    members.append(i)

  return members
