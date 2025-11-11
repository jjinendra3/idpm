import base64
from typing import Annotated
from pydantic import Field, BaseModel
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
from upload import upload


class State(TypedDict):
    conversation_id: int
    new_content: str
    messages: Annotated[list, add_messages]
    session: Session
    sql_query: str
    sql_response: list
    image: bool
    image_type: str
    python_code: str

class ConversationOutput(BaseModel):
    query: str = Field(..., description="The SQL query or synthetic query string to execute or visualize.")
    image: bool = Field(False, description="Set to true if user requested a data visualization (chart, plot, etc.)")
    image_type: str = Field("", description="The type of visualization requested, e.g., 'bar chart', 'line graph', etc.")

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
    structured_llm = model.with_structured_output(ConversationOutput)
    response = structured_llm.invoke(messages_with_system)
    return {"sql_query": response.query, "messages": state["messages"], "image": response.image, "image_type": response.image_type}

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
       messages_with_system = state["messages"] + [
    HumanMessage(
        f"""Based on the chat above, the answer returned by the SQL query is {state['sql_response']}. 
Please convert it into a human-readable response following these rules:

1. If the SQL query returns a single string value (from a fallback query like SELECT '...' AS response), return that string exactly as it is, with no modification.  
2. If the SQL query returns tabular data that directly answers the question, summarize it concisely in natural language (e.g., counts, averages, names with values).  
3. If the SQL query returns related but not final data (because the answer required data inspection beyond SQL), try to take out the exact answer to the query if possible using the dataset or provide a helpful and concise summary of that dataset so the user can understand the key information.  
4. Do not repeat the SQL response verbatim, only give the natural-language summary.  
5. Do not mention SQL, queries, databases, or that you are an AI model. Just provide the answer in plain human language."""
    )
]

    response = model.invoke(messages_with_system)

    ai_message = AIMessage(response.content)
    return {"messages": state["messages"] + [ai_message]}

def sql_to_image(state: State):
    if not state.get("sql_query"):
        return {"messages": state["messages"] + [AIMessage("The SQL query returned no results.")]}

    user_message = state["messages"][-1] if state["messages"] else HumanMessage("Visualize SQL output.")

    messages_with_system = [
        user_message,
        HumanMessage(
            f"""
            Based on the message above, the SQL query output is:

            {state['sql_response']}

            Using this data, create a **{state['image_type']}** visualization in Python.
            Use any library (e.g., seaborn, matplotlib, pandas).
            - The generated image **must be saved as 'output.png'** in the current directory.
            - Output **only the Python code** — no explanations, comments, or text.
            - Generate exactly one plot and save it as 'output.png'.
            """
        ),
    ]

    response = model.invoke(messages_with_system)
    return {"python_code": response.content}

def run_python_code(state: State):
    
    exec_locals = {}
    safe_globals = {
        "__builtins__": {
            "print": print,
            "len": len,
            "range": range,
            "__import__": __import__,
            "open": open,
            "str": str,
            "int": int,
            "float": float,
            "list": list,
            "dict": dict,
        }
    }
    code = state["python_code"]
    code = code.strip()
    if code.startswith("```"):
        code = code.strip("`")
        code = code.replace("python", "", 1).strip()
        if code.endswith("```"):
            code = code[:-3].strip()
    exec_locals = {}
    try:
        exec(code, safe_globals, exec_locals)
    except Exception as e:
        print(f"Error executing code: {e}") 
    try:
        with open("output.png", "rb") as file:
            encoded_bytes = base64.b64encode(file.read())
        b64_str = encoded_bytes.decode("utf-8")
        image_url = upload(b64_str)
        markdown_image = None
        if image_url.get("error"):
           markdown_image= f"![Generated Image]({b64_str})"
        else:
            markdown_image = f"![Generated Image]({image_url['data']['url']})"
        return {"messages": state["messages"] + [AIMessage(markdown_image+"Here is the image you requested.")]}

    except FileNotFoundError:
        return {"messages": state["messages"] + [AIMessage("⚠️ No image was generated. Please try again later.")]} 

def checkState(state: dict):
    return bool(state.get("image", False))


graph_builder.add_node("load_messages", load_messages)
graph_builder.add_node("run_model", run_model)
graph_builder.add_node("convert_sql_response_to_human_readable", convert_sql_response_to_human_readable)
graph_builder.add_node("run_sql_query", run_sql_query)
graph_builder.add_node("save_messages", save_messages)
graph_builder.add_node("sql_to_image", sql_to_image)
graph_builder.add_node("run_python_code", run_python_code)

graph_builder.add_edge(START, "load_messages")
graph_builder.add_edge("load_messages", "run_model")
graph_builder.add_edge("run_model", "run_sql_query")
graph_builder.add_conditional_edges(
    "run_sql_query",
    checkState,
    {
        True: "sql_to_image",
        False: "convert_sql_response_to_human_readable"
    }
)
graph_builder.add_edge("sql_to_image", "run_python_code")
graph_builder.add_edge("run_python_code", "save_messages")
graph_builder.add_edge("convert_sql_response_to_human_readable", "save_messages")
graph_builder.add_edge("save_messages", END)

graph = graph_builder.compile()
