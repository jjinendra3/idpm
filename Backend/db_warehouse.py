import asyncpg
from db_queries import schema_summary_columns_query, schema_summary_constraints_query

async def schema_summary(url: str):
    conn = await asyncpg.connect(url)
    
    try:
        cols = await conn.fetch(schema_summary_columns_query)
        cons = await conn.fetch(schema_summary_constraints_query)
        
        schema = {}
        
        for col in cols:
            schema.setdefault(col["table_schema"], {}).setdefault(col["table_name"], {"columns": {}})
            schema[col["table_schema"]][col["table_name"]]["columns"][col["column_name"]] = \
                f"{col['data_type']} ({'nullable' if col['is_nullable']=='YES' else 'not null'})"

        for c in cons:
            if c["table_schema"] in schema and c["table_name"] in schema[c["table_schema"]]:
                table = schema[c["table_schema"]][c["table_name"]]["columns"]
                col_name = c["column_name"]
                if c["constraint_type"] == "PRIMARY KEY":
                    table[col_name] += ", PK"
                elif c["constraint_type"] == "FOREIGN KEY":
                    table[col_name] += f", FK -> {c['foreign_table_schema']}.{c['foreign_table_name']}.{c['foreign_column_name']}"
        return schema
        
    finally:
        await conn.close()

async def run_query(url: str, query: str):
    conn = await asyncpg.connect(url)
    
    try:
        result = await conn.fetch(query)
        return result
        
    finally:
        await conn.close()