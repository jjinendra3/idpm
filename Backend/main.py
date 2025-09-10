from fastapi import FastAPI
from llm import model
app = FastAPI()

@app.get("/")
async def root():
    return {"message": "Hello World"}

@app.get("/generate")
async def generate_response():
    response = model.invoke("Hello, how are you?")
    return {"response":response.content}