
import streamlit as st
from backend import *

st.title("See your Family Goals")
st.write("An example of using SQL Procedures and Nested Queries.")
st.divider()

# st.write("Welcome to the Goals Page of Vested.")


# user_id = st.number_input("Enter User_ID: ",value=1)
#st.write(f"Your User_ID is: {st.session_state.userid}")
user_id=st.session_state.userid



# get_data=st.button("Click to get all goals :)")

# if get_data:
    # st.write(f"{user_id}")
goal_dict=get_all_goals(user_id)
if(len(goal_dict)>0):
    for key,value in goal_dict.items():
        val=value[0]
        uname=get_username(value[1])
        val=float(val)
        st.write(f"{uname}'s goal")
        st.write(f"Goal: {key}")
        st.write(f"Amount: {val}")
        st.divider()
        
else:
    st.write("Please add some goals first to view them :)")


