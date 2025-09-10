
from dotenv import load_dotenv
load_dotenv()
import os

DB_URL = os.getenv("DB_URL")
GOOGLE_API_KEY = os.getenv("GOOGLE_API_KEY")    