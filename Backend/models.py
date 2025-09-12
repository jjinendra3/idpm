from sqlalchemy import Column
from sqlmodel import Field, SQLModel, Relationship,JSON
from sqlalchemy.dialects.postgresql import JSONB
from typing import Any, Optional

class Conversation(SQLModel, table=True):
    id: int | None = Field(default=None, primary_key=True)
    title: str = Field(default="New Conversation")
    urls: list["DBUrls"] = Relationship(back_populates="conversation")
    messages: list["Messages"] = Relationship(back_populates="conversation")

class DBUrls(SQLModel, table=True):
    id: int | None = Field(default=None, primary_key=True)
    url: str = Field()
    schemaDB: Optional[Any] = Field(
        sa_column=Column(JSONB) 
    )   
    conversation_id: int | None = Field(default=None, foreign_key="conversation.id")
    conversation: Conversation | None = Relationship(back_populates="urls")

class Messages(SQLModel, table=True):
    id: int | None = Field(default=None, primary_key=True)
    sentBy: str = Field(index=True)  # 'user' or 'ai'
    content: str | None = Field(default=None, index=True)
    conversation_id: int | None = Field(default=None, foreign_key="conversation.id")
    conversation: Conversation | None = Relationship(back_populates="messages")
