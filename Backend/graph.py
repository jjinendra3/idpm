from typing import Annotated
from typing_extensions import TypedDict
from llm import model
from langgraph.graph import StateGraph, START, END
from langgraph.graph.message import add_messages
from langchain_core.messages import HumanMessage, AIMessage

from sqlalchemy.orm import Session
from models import Messages


class State(TypedDict):
    conversation_id: int
    new_content: str
    messages: Annotated[list, add_messages]
    session: Session


graph_builder = StateGraph(State)

def load_messages(state: State):
    session = state["session"]
    conversation_id = state["conversation_id"]

    messages = session.query(Messages).filter(Messages.conversation_id == conversation_id).all()

    messages_chain = [
        AIMessage(msg.content) if msg.sentBy == "ai" else HumanMessage(msg.content)
        for msg in messages
    ]

    messages_chain.append(HumanMessage(state["new_content"]))

    return {"messages": messages_chain}

def run_model(state: State):
    response = model.invoke(state["messages"])
    return {"messages": [response]} 


def save_messages(state: State):
    session = state["session"]
    conversation_id = state["conversation_id"]

    human_message = Messages(
        sentBy="human", content=state["new_content"], conversation_id=conversation_id
    )
    ai_message = Messages(
        sentBy="ai", content=state["messages"][-1].content, conversation_id=conversation_id
    )

    session.add(human_message)
    session.add(ai_message)
    session.commit()
    session.refresh(ai_message)

    return {} 

graph_builder.add_node("load_messages", load_messages)
graph_builder.add_node("run_model", run_model)
graph_builder.add_node("save_messages", save_messages)

graph_builder.add_edge(START, "load_messages")
graph_builder.add_edge("load_messages", "run_model")
graph_builder.add_edge("run_model", "save_messages")
graph_builder.add_edge("save_messages", END)

graph = graph_builder.compile()
