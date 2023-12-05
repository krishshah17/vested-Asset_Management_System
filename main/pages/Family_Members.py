import streamlit as st
from backend import *
from datetime import datetime

st.title("Your Family Members")
st.write("An example of using SQL Recursive Queries, Join Queries and Nested Queries.")
st.divider()
#st.write(f"Your User_ID is: {st.session_state.userid}")
# user_id = st.number_input("Enter User_ID: ",value=1)
user_id=st.session_state.userid

members=show_family(user_id)

if(len(members)>0):
	for i in members:
		st.write(f"User_ID: {i[0]}")
		st.write(f"Member Name: {i[2]}")
		st.divider()