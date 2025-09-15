from pydantic import BaseModel
from db import create_db_and_tables,get_session
from fastapi import FastAPI,Depends
from models import Conversation,DBUrls,Messages
from sqlmodel import Session
from fastapi.middleware.cors import CORSMiddleware
from typing import List
from graph import graph
from llm import model
from db_warehouse import schema_summary
from fastapi import APIRouter
app = FastAPI()
router = APIRouter()

origins = [
    "http://localhost:3000",
    "http://127.0.0.1:3000",
    "https://idpm-puce.vercel.app",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
@app.on_event("startup")
async def startup():
    create_db_and_tables()

@app.get("/")
async def root():
    return {"message": "Hello World"}
    

class ConversationCreate(BaseModel):
    dbUrls: List[str]

@router.post("/conversation")
async def create_conversation(
    conversation: ConversationCreate, 
     session: Session = Depends(get_session)
):
    conversation_model = Conversation()
    conversation_model.urls = [DBUrls(url=url, schemaDB=await schema_summary(url)) for url in conversation.dbUrls]
    conversation_model.title=model.invoke(f"Generate a short title for a conversation about databases and less than 50 chars. The title should be concise and relevant to schema generated {conversation_model.urls[0]}.").content
    session.add(conversation_model)
    session.commit()
    session.refresh(conversation_model)

    return conversation_model

@router.get("/conversation/{conversation_id}")
async def get_conversation(conversation_id: int, session: Session = Depends(get_session)):
    conversation = session.get(Conversation, conversation_id)
    if not conversation:
        return {"error": "Conversation not found"}
    
    messages = session.query(Messages).filter(Messages.conversation_id == conversation_id).all()
    
    conversation_dict = conversation.dict()
    conversation_dict["messages"] = messages
    
    return conversation_dict

@router.post("/message/{conversation_id}")
async def add_message(conversation_id: int, message: str, session: Session = Depends(get_session)):
    result = await graph.ainvoke({
        "conversation_id": conversation_id,
        "new_content": message,
        "session": session,
        "messages": [] 
    })
    return result["messages"][-1]

app.include_router(router)