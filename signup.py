import streamlit as st
import streamlit_authenticator as stauth
from pathlib import Path
import pickle
from time import sleep
from main.backend import *
import subprocess
import sys

usernames,emails,passwords=auth_helper()
sub_clicked=False
reset_clicked=False

st.set_page_config(page_title="vested",layout="wide",initial_sidebar_state="collapsed")

st.header("Welcome to vested!",divider='blue')

img_col, text_col = st.columns(2)

def update_signup_state():
	st.session_state.sub_clicked=True

def update_reset_state():
	st.session_state.reset_clicked=True


def empty():
    placeholder.empty()
    sleep(0.03)

with img_col:

   st.image("/Users/krishshah/Desktop/CODES/DBMS/Project/Docs/vested.png",width=600)

with text_col:
	if "sub_clicked" not in st.session_state:
		st.session_state.sub_clicked = False
	if "reset_clicked" not in st.session_state:
		st.session_state.reset_clicked = False

	placeholder=st.empty()

	with placeholder.container():
		st.markdown('''<h1>Manage all your assets </h1>''',unsafe_allow_html=True)
		st.markdown('''<h1> with a single click</h1><br>''',unsafe_allow_html=True)
		col1, col2, col3 = st.columns(3)
		with col1:
			st.button("Sign Up Now!   ",on_click=update_signup_state)
		with col2:
			st.button("Reset Password!",on_click=update_reset_state)
		with col3:
			login=st.button("Login!")


	if st.session_state.sub_clicked or sub_clicked:
		empty()

		with placeholder.container():
			with st.form("RegistrationForm",clear_on_submit=True):
				st.title("Registration Form")

				user_col,super_col=st.columns(2)
				username=user_col.text_input("Name:")
				# print(username)
				super_id=super_col.text_input("Enter SUser_ID:",placeholder="if applicable")

				email_col,mob_col = st.columns([3,1])
				email=email_col.text_input("Email ID:")
				mob=mob_col.text_input("Mob Number:")

				pw,pw2 = st.columns(2)
				password=pw.text_input("Password",type = "password")
				password2=pw2.text_input("Re-enter Password",type = "password")

				submitted=st.form_submit_button("Submit")
				
				if submitted:
					if(username):
						if(username in usernames):
							st.write("Username already exists, please refresh and try again.")
						elif(email in emails):
							st.write("User with this email is already registered, please login.")
							subprocess.run(["streamlit", "run", "main/Overview.py"])
						elif(password!=password2):
							st.write("Passwords donot match, please refresh and try again.")
						# if((email not in emails) and (password==password2)):
						else:
							new_id=insert_user(username,password2,email,mob,super_id)
							gen_keys()
							st.write(f"Thank you for registering your User_ID is: {new_id}")
							subprocess.run(["streamlit", "run", "main/Overview.py"])
							sys.exit()
					else:
						st.error("Please enter a username")
	elif st.session_state.reset_clicked or reset_clicked:
		empty()

		with placeholder.container():
			st.title("Password Reset")
			st.write("Enter your email to reset your password.")

			email = st.text_input("Email:")
			new_password = st.text_input("New Password:", type="password")
			confirm_password = st.text_input("Confirm Password:", type="password")
			emails=get_emails()
			#st.write(emails)

			if st.button("Reset Password"):
				if new_password != confirm_password:
					st.error("Passwords do not match. Please try again.")
				elif email not in emails:
					st.error("No user with given email")
				else:
				# Call backend function to reset the password
				# rerun function to store encrypted passwords
				# execute overview on success
					reset_password(new_password,email)
					gen_keys()
					st.write(f"Your password for account {email} has been reset, please login with your new password :)")
					subprocess.run(["streamlit", "run", "main/Overview.py"])
					sys.exit()

	elif(login):
		subprocess.run(["streamlit", "run", "main/Overview.py"])
		sys.exit()
