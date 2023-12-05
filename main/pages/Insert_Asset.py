import streamlit as st
import streamlit_authenticator as stauth
from pathlib import Path
import pickle
from components import *
from backend import *
from time import *


st.title("Enter your Assets")
st.write("An example of Create functionality and Triggers.")
st.divider()
user_id=st.session_state.userid

with st.form("AssetForm",clear_on_submit=True):
	# st.write(user_id)
	asset_name=st.text_input("Enter Asset Name")
	asset_type=st.selectbox('Choose Asset Type',('Stock','Mutual Fund','Gold','Bonds','Fixed Deposits'))
	purchase_amount=st.number_input("Enter purchase amount per unit")
	quantity=st.number_input("Enter quantity",value=1)
	portfolio_name=st.text_input("Enter Portfolio Name, only applicable if you have no existing portfolio ")
	submitted=st.form_submit_button()
	if submitted:
		if(len(asset_name)>50):
			st.error("Asset Name should be less than 50 chars")
		if(len(portfolio_name)>20):
			st.error("Portfolio Name should be less than 20 chars")
		if((len(asset_name)<51) and (len(portfolio_name)<21)):
			portfolio_id=check_portfolio(user_id)
			if(portfolio_id):
				add_asset(user_id,asset_name,asset_type,purchase_amount,quantity)
				# call add_asset function after this
				# add to portfolio, create a trigger for this
			else:
				add_portfolio(user_id,portfolio_name)
				add_asset(user_id,asset_name,asset_type,purchase_amount,quantity)
				# create a new portfolio with name entered by user
				# call add_asset function after this
				# add to portfolio create a trigger for this
			st.write(f"Congratulations your Asset: {asset_name} has been added to Portfolio: {portfolio_name}")
			
			