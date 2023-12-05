
import streamlit_authenticator as stauth
from pathlib import Path
import pickle

def gk():
    usernames,email,passwords=auth_helper()

    hashed_passwords=stauth.Hasher(passwords).generate()
    file_path=Path(__file__).parent/"hashed_pw.pkl"

    with file_path.open("wb") as file:
        pickle.dump(hashed_passwords,file)
