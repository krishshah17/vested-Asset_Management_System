
import streamlit as st
from backend import *

st.title("See your Individual Goals")
st.write("An example of using SQL Procedures.")
st.divider()

# st.write("Welcome to the Goals Page of Vested.")


# user_id = st.number_input("Enter User_ID: ",value=1)
#st.write(f"Your User_ID is: {st.session_state.userid}")
user_id=st.session_state.userid

# get_data=st.button("Click to get your goals :)")

# if get_data:
    # st.write(f"{user_id}")
goal_dict=get_goals(user_id)
if(len(goal_dict)>0):
    for key,value in goal_dict.items():
        value=float(value)
        st.write(f"Goal: {key}")
        st.write(f"Amount: {value}")
        st.divider()

else:
    st.write("Please add some goals first to view them :)")


