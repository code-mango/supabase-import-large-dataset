from supabase import create_client

def get_or_insert(supabase, table, column, value):
    res = supabase.table(table).select("id").eq(column, value).execute()
    if res.data: return res.data[0]["id"]
    return supabase.table(table).insert({column: value}).execute().data[0]["id"]