import streamlit as st
from backend import *

st.title("Delete Assets")
st.write("An example of Delete functionality")
st.divider()

# st.write("Welcome to the Goals Page of Vested.")


# user_id = st.number_input("Enter User_ID: ",value=1)
#st.write(f"Your User_ID is: {st.session_state.userid}")
user_id=st.session_state.userid
#st.write(user_id)
#include dropdown
option=st.selectbox("Choose who's Assets are to be deleted:",("-","Individual","All"))

if option=="Individual":
	st.write("deleting individual Assets")
	del_assets(user_id)
	st.write("deleted individual Assets")
elif option=="All":
	st.write("deleting all Assets")
	del_all_assets(user_id)
	st.write("deleted all Assets")
else:
	st.write("Please choose an option")