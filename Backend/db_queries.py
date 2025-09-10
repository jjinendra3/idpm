schema_summary_columns_query = """
    SELECT table_schema, table_name, column_name, data_type, is_nullable
    FROM information_schema.columns
    WHERE table_schema NOT IN ('pg_catalog','information_schema','storage','vault','graphql_public','public','realtime','pgbouncer','auth','extensions','graphql')
    """
schema_summary_constraints_query = """
    SELECT 
        tc.table_schema,
        tc.table_name,
        kcu.column_name,
        tc.constraint_type,
        ccu.table_schema AS foreign_table_schema,
        ccu.table_name   AS foreign_table_name,
        ccu.column_name  AS foreign_column_name
    FROM information_schema.table_constraints AS tc
    LEFT JOIN information_schema.key_column_usage AS kcu
        ON tc.constraint_name = kcu.constraint_name
        AND tc.table_schema = kcu.table_schema
    LEFT JOIN information_schema.constraint_column_usage AS ccu
        ON ccu.constraint_name = tc.constraint_name
        AND ccu.table_schema = tc.table_schema
    WHERE tc.table_schema NOT IN ('pg_catalog','information_schema','storage','vault','graphql_public','public','realtime','pgbouncer','auth','extensions','graphql')
    ORDER BY tc.table_schema, tc.table_name;
    """