import mysql.connector

try:
    connection = mysql.connector.connect(
        host="localhost",
        user="root",
        password="Sumithra@#98",
        database="titanic_db",
        port=3306
    )

    print("MySQL connection successful!")
    connection.close()

except mysql.connector.Error as error:
    print("MySQL connection failed:", error)