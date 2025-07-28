import os
import pandas as pd
from dotenv import load_dotenv
from supabase import create_client
from utils import get_or_insert

load_dotenv()
url = os.getenv("SUPABASE_URL")
key = os.getenv("SUPABASE_SERVICE_ROLE_KEY")
supabase = create_client(url, key)

def import_csv(path, chunk_size=10000):
    for chunk in pd.read_csv(path, chunksize=chunk_size):
        records = []
        for _, row in chunk.iterrows():
            vendor_id = get_or_insert(supabase, "vendor", "code", row["vendor_code"])
            region_id = get_or_insert(supabase, "region", "name", row["region"])
            category_id = get_or_insert(supabase, "category", "name", row["category"])
            records.append({
                "id": row["transaction_id"],
                "vendor_id": vendor_id,
                "region_id": region_id,
                "category_id": category_id,
                "amount": float(row["amount"]),
                "currency": row["currency"],
                "transaction_date": row["date"]
            })
        supabase.table("transaction").insert(records).execute()

if __name__ == "__main__":
    import_csv("../data/transactions_5M.csv")