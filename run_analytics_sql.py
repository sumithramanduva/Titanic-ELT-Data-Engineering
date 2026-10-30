import mysql.connector
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Sumithra@#98",
    database="titanic_db"
)

cursor = conn.cursor()

try:
    sql = (BASE_DIR / "analytics.sql").read_text(encoding="utf-8")

    for statement in sql.split(";"):
        if statement.strip():
            cursor.execute(statement)

            # Read results if the SQL statement returns rows
            if cursor.with_rows:
                cursor.fetchall()

    conn.commit()
    print("Successfully executed analytics.sql")

finally:
    cursor.close()
    conn.close()