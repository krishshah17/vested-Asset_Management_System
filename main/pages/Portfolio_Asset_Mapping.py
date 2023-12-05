import streamlit as st
import streamlit_authenticator as stauth
from pathlib import Path
import pickle
from components import *
from backend import *
from time import *


st.title("Portfolio Asset Mapping for your Family :)")
st.write("An example of Join Query.")
st.divider()
user_id=st.session_state.userid


pamap_dict=port_ass_map(user_id)
if(pamap_dict):
    # for maps in pamap_dict.keys():
    # 	st.divider()
    # 	st.write(f"Portfolio: {maps}")
    # 	for i in pamap_dict.get(maps):
	#         # uname=get_username(i[1])
	#         value=float(i[2])
	#         qty=int(i[4])
	#         tot_val=value*qty
	#         # st.write(f"Belongs to: {uname}")
	#         st.write(f"Asset Name: {i[0]}")
	#         st.write(f"Asset Type: {i[1]}")
	#         st.write(f"Purchase Amount: {value}")
	#         st.write(f"Purchase Date: {i[3]}")
	#         st.write(f"Quantity: {qty}")
	#         st.write(f"Total Value: {tot_val}")
	#         st.divider()
	for portfolio_id, pamap_list in pamap_dict.items():
		st.write(f"Portfolio: {portfolio_id}")

		# Creating a list of dictionaries for the data
		data_for_table = [
			{
				"Asset Name": asset[0],
				"Asset Type": asset[1],
				"Purchase Amount": float(asset[2]),
				"Purchase Date": asset[3],
				"Quantity": int(asset[4]),
				"Total Value": float(asset[2]) * int(asset[4])
			}
		    for asset in pamap_list
		]

		# Displaying the data in a table
		st.dataframe(data_for_table)
		st.divider()
else:
    st.write("Please add some assets to portfolio first to view them :)")