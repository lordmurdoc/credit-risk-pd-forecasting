"""Quick PostgreSQL connection check (optional)."""
import os
from pathlib import Path
import pandas as pd
from dotenv import load_dotenv
from sqlalchemy import create_engine
from sqlalchemy.engine import URL

load_dotenv(Path(__file__).resolve().parent / ".env")
required = ["DB_USER", "DB_PASSWORD", "DB_HOST", "DB_NAME"]
if any(not os.getenv(name) for name in required):
    raise RuntimeError("Configure .env from .env.example before running main.py")

url = URL.create(
    "postgresql+psycopg", username=os.getenv("DB_USER"),
    password=os.getenv("DB_PASSWORD"), host=os.getenv("DB_HOST"),
    port=int(os.getenv("DB_PORT", "5432")), database=os.getenv("DB_NAME"),
)
engine = create_engine(url, pool_pre_ping=True)
contracts = pd.read_sql("SELECT * FROM raw.contracts LIMIT 5", engine)
print(contracts.to_string(index=False))
