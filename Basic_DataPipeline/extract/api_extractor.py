import requests

from config.config import API_URL

def extract_data():
    response = requests.get(API_URL)
    response.raise_for_status()
    return response.json()