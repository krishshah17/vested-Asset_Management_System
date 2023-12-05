import streamlit as st
import streamlit_authenticator as stauth
from pathlib import Path
import pickle
from components import *
from backend import *
from time import *
#for user auth
#i should get this data using SQL query
# names=["krish shah"]
# usernames=["krish"]
# # loading hashed passwords
# file_path=Path(__file__).parent/"hashed_pw.pkl"

if 'sidebar_state' not in st.session_state:
    st.session_state.sidebar_state = 'collapsed'
if 'userid' not in st.session_state:
	st.session_state.userid=False
st.set_page_config(page_title="vested",layout="wide",initial_sidebar_state=st.session_state.sidebar_state)
st.empty()
sleep(0.03)


file_path=Path(__file__).parent/"hashed_pw.pkl"
with file_path.open("rb") as file:
    hashed_passwords=pickle.load(file)

usernames,email,password=auth_helper()
authenticator=stauth.Authenticate(usernames,email,hashed_passwords,"vested","vested",cookie_expiry_days=-1)
name,authentication_status,username=authenticator.login("Welcome to Vested","main")

if authentication_status or st.session_state.userid:
	sleep(0.03)
	st.session_state.sidebar_state = 'expanded'
	st.session_state.userid = name
	st.title(f"Welcome {username}")
	#get values from backend for this
	sum_assets=float(get_total_sum_asset(name))
	assets=get_user_all_assets(name)
	st.markdown(create_square_row("Total Investments", "Equity", "FD's",sum_assets,assets[0],assets[4]), unsafe_allow_html=True)
	st.markdown(create_square_row("Mutual Funds", "Gold", "Bonds",assets[1],assets[2],assets[3]), unsafe_allow_html=True)
	authenticator.logout("Logout","main")

if authentication_status==False:
	st.error("Please enter correct emailID/password")
	st.rerun()