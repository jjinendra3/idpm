from db import create_db_and_tables,get_session
from fastapi import FastAPI,Depends
from models import Conversation,DBUrls,Messages
from sqlmodel import Session
from typing import List
from graph import graph
app = FastAPI()
@app.on_event("startup")
async def startup():
    create_db_and_tables()

@app.get("/")
async def root():
    return {"message": "Hello World"}
    
@app.post("/conversation")
async def create_conversation(dbUrls: List[str], session: Session = Depends(get_session)):
    
    conversation = Conversation()
    conversation.urls = [DBUrls(url=url) for url in dbUrls]
    
    session.add(conversation)
    session.commit()
    session.refresh(conversation)

    return conversation

@app.get("/conversation/{conversation_id}")
async def get_conversation(conversation_id: int, session: Session = Depends(get_session)):
    conversation = session.get(Conversation, conversation_id)
    if not conversation:
        return {"error": "Conversation not found"}
    
    messages = session.query(Messages).filter(Messages.conversation_id == conversation_id).all()
    
    conversation_dict = conversation.dict()
    conversation_dict["messages"] = messages
    
    return conversation_dict

@app.post("/message/{conversation_id}")
async def add_message(conversation_id: int,  content: str, session: Session = Depends(get_session)):
    result = graph.invoke({
        "conversation_id": conversation_id,
        "new_content": content,
        "session": session,
        "messages": [] 
    })
    return result["messages"][-1].content