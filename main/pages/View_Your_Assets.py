
import streamlit as st
from backend import *
from datetime import datetime

st.title("See your Individual Assets")
st.write("An example of using SQL Procedures.")
st.divider()
#st.write(f"Your User_ID is: {st.session_state.userid}")
# user_id = st.number_input("Enter User_ID: ",value=1)
user_id=st.session_state.userid

# get_data=st.button("Click to get your Assets :)")

# if get_data:
    # st.write(f"{user_id}")
asset_dict=get_assets(user_id)
if(len(asset_dict)>0):
    for i in asset_dict:
        value=float(i[4])
        tot_val=value*int(i[6])
        st.write(f"Asset Name: {i[2]}")
        st.write(f"Asset Type: {i[3]}")
        st.write(f"Purchase Amount: {value}")
        st.write(f"Purchase Date: {i[5]}")
        st.write(f"Quantity: {i[6]}")
        st.write(f"Total Value: {tot_val}")
        st.divider()
else:
    st.write("Please add some assets first to view them :)")





