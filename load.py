
from sqlalchemy import create_engine, URL
from config import DB_CONFIG

def load(df, table_name="raw_titanic"):
    connection_url = URL.create(
        "mysql+mysqlconnector",
        username=DB_CONFIG["user"],
        password=DB_CONFIG["password"],
        host=DB_CONFIG["host"],
        port=3306,
        database=DB_CONFIG["database"]
    )

    engine = create_engine(connection_url)

    try:
        df.to_sql(
            table_name,
            con=engine,
            if_exists="replace",
            index=False
        )
        print(f"Loaded {len(df)} rows into '{table_name}' table")
    finally:
        engine.dispose()
