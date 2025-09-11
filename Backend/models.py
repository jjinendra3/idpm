from sqlmodel import Field, SQLModel, Relationship

class Conversation(SQLModel, table=True):
    id: int | None = Field(default=None, primary_key=True)
    urls: list["DBUrls"] = Relationship(back_populates="conversation")
    messages: list["Messages"] = Relationship(back_populates="conversation")

class DBUrls(SQLModel, table=True):
    id: int | None = Field(default=None, primary_key=True)
    url: str = Field(unique=True, index=True)
    conversation_id: int | None = Field(default=None, foreign_key="conversation.id")
    conversation: Conversation | None = Relationship(back_populates="urls")

class Messages(SQLModel, table=True):
    id: int | None = Field(default=None, primary_key=True)
    content: str | None = Field(default=None, index=True)
    conversation_id: int | None = Field(default=None, foreign_key="conversation.id")
    conversation: Conversation | None = Relationship(back_populates="messages")
