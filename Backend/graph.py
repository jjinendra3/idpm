from typing import Annotated
from typing_extensions import TypedDict
from llm import model
from langgraph.graph import StateGraph, START, END
from langgraph.graph.message import add_messages
from langchain_core.messages import HumanMessage, AIMessage
from prompt import CONVERT_TO_SQL_QUERY
from models import DBUrls
import json
from db_warehouse import run_query

from sqlalchemy.orm import Session
from models import Messages
from langchain_core.messages import SystemMessage


class State(TypedDict):
    conversation_id: int
    new_content: str
    messages: Annotated[list, add_messages]
    session: Session
    sql_query: str
    sql_response: list


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
    dbSchema = state["session"].query(DBUrls).filter(DBUrls.conversation_id == state["conversation_id"]).all()
    dbSchema = [db.schemaDB for db in dbSchema if db.schemaDB]
    messages_with_system = [SystemMessage(CONVERT_TO_SQL_QUERY + json.dumps(dbSchema))] + state["messages"]
    response = model.invoke(messages_with_system)
    return {"sql_query": response.content, "messages": state["messages"], "sql_query": response.content}

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

async def run_sql_query(state: State):
    dbSchema = state["session"].query(DBUrls).filter(DBUrls.conversation_id == state["conversation_id"]).all()
    dbUrl=[db.url for db in dbSchema if db.schemaDB][0]
    response=await run_query(dbUrl, state["sql_query"])

    return {"sql_response": response}

def convert_sql_response_to_human_readable(state: State):
    response=None
    if not state["sql_response"]:
        response = "The SQL query returned no results."
    else:
        messages_with_system = state["messages"] + [HumanMessage(f"Based on the chat above, the answer returned by the SQL query is {state['sql_response']}. Please summarize it in a human-readable format.")]
        response = model.invoke(messages_with_system)

    ai_message = AIMessage(response.content)
    return {"messages": state["messages"] + [ai_message]}

graph_builder.add_node("load_messages", load_messages)
graph_builder.add_node("run_model", run_model)
graph_builder.add_node("convert_sql_response_to_human_readable", convert_sql_response_to_human_readable)
graph_builder.add_node("run_sql_query", run_sql_query)
graph_builder.add_node("save_messages", save_messages)

graph_builder.add_edge(START, "load_messages")
graph_builder.add_edge("load_messages", "run_model")
graph_builder.add_edge("run_model", "run_sql_query")
graph_builder.add_edge("run_sql_query", "convert_sql_response_to_human_readable")
graph_builder.add_edge("convert_sql_response_to_human_readable", "save_messages")
graph_builder.add_edge("save_messages", END)

graph = graph_builder.compile()
