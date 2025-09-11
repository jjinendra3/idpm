from db import create_db_and_tables
from fastapi import FastAPI

app = FastAPI()
@app.on_event("startup")
async def startup():
    create_db_and_tables()

@app.get("/")
async def root():
    return {"message": "Hello World"}
