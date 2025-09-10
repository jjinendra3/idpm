import os
from langchain.chat_models import init_chat_model
from envs import GOOGLE_API_KEY
os.environ["GOOGLE_API_KEY"] = GOOGLE_API_KEY

model = init_chat_model("gemini-2.5-flash", model_provider="google_genai")