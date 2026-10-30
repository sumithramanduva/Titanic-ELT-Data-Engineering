
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
    sql = (BASE_DIR / "data_quality.sql").read_text(encoding="utf-8")

    for statement in sql.split(";"):
        if statement.strip():
            cursor.execute(statement)

            if cursor.with_rows:
                cursor.fetchall()

    conn.commit()
    print("Successfully executed data_quality.sql")

except mysql.connector.Error as error:
    print("MySQL Error:", error)

finally:
    cursor.close()
    conn.close()
