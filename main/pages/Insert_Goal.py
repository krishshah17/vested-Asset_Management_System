import streamlit as st
import streamlit_authenticator as stauth
from pathlib import Path
import pickle
from components import *
from backend import *
from time import *
from datetime import datetime

st.title("Insert your Goal")
st.write("An example of Create functionality")
st.divider()
user_id=st.session_state.userid

with st.form("AssetForm",clear_on_submit=True):
	Goal_Desc=st.text_input("Enter Goal Description")
	goal_amount=st.number_input("Enter goal amount")
	submitted=st.form_submit_button()
	if submitted:

		if(len(Goal_Desc)>50 or len(Goal_Desc)<1):
			st.error("Goal Description should be less than 50 chars and more than or 1 chars")
		elif(len(str(goal_amount))>13):
			st.error("aap bhaut rich ho, please reduce amount to less than 9999999999.99")
		else:
			add_goal(user_id,Goal_Desc,goal_amount)
			st.write(f"Congratulations your goal: {Goal_Desc} has been added")