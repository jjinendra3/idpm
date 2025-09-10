from main import app
from db_queries import schema_summary_columns_query, schema_summary_constraints_query
from envs import DB_URL
import asyncpg # type: ignore

@app.on_event("startup")
async def startup():
    app.state.db = await asyncpg.create_pool(DB_URL)

@app.on_event("shutdown")
async def shutdown():
    await app.state.db.close()
async def schema_summary():
   
    cols = await app.state.db.fetch(schema_summary_columns_query)
    cons = await app.state.db.fetch(schema_summary_constraints_query)
    schema = {}
    for col in cols:
        schema.setdefault(col["table_schema"], {}).setdefault(col["table_name"], {"columns": {}})
        schema[col["table_schema"]][col["table_name"]]["columns"][col["column_name"]] = \
            f"{col['data_type']} ({'nullable' if col['is_nullable']=='YES' else 'not null'})"

    for c in cons:
        table = schema[c["table_schema"]][c["table_name"]]["columns"]
        col_name = c["column_name"]
        if c["constraint_type"] == "PRIMARY KEY":
            table[col_name] += ", PK"
        elif c["constraint_type"] == "FOREIGN KEY":
            table[col_name] += f", FK -> {c['foreign_table_schema']}.{c['foreign_table_name']}.{c['foreign_column_name']}"
    return schema