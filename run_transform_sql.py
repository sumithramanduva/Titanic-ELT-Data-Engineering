
import mysql.connector
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent

def run_sql_file(filename):
    connection = mysql.connector.connect(
        host="localhost",
        user="root",
        password="Sumithra@#98",
        database="titanic_db",
        port=3306
    )

    try:
        cursor = connection.cursor()
        sql = (BASE_DIR / filename).read_text(encoding="utf-8")

        statements = [
            statement.strip()
            for statement in sql.split(";")
            if statement.strip()
        ]

        for statement in statements:
            cursor.execute(statement)

        connection.commit()
        print(f"Successfully executed {filename}")

    except Exception:
        connection.rollback()
        raise

    finally:
        cursor.close()
        connection.close()


if __name__ == "__main__":
    run_sql_file("staging.sql")
    run_sql_file("transformation.sql")
