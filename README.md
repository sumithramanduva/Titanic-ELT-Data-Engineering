# Titanic-ELT-Data-Engineering
# Titanic ELT Data Engineering Project

## Project Overview
This project implements an **Extract, Load, Transform (ELT)** pipeline using the Titanic dataset. It extracts raw data, loads it into a MySQL database, and performs data transformation and quality checks using SQL.

The main objective is to demonstrate how raw data can be stored first and then transformed inside the database.

## Technologies Used
- Python
- Pandas
- MySQL
- SQL
- SQLAlchemy
- Jupyter Notebook
- VS Code

## Dataset
- **Dataset:** Titanic Dataset
- **Source:** Seaborn
- **Total Records:** 891
- **Total Columns:** 15

## Project Workflow

1. **Extract:** Extract the Titanic dataset using Python.
2. **Load:** Load the original, uncleaned dataset into the MySQL `raw_titanic` table.
3. **Transform:** Use SQL scripts to create staging and transformed tables.
4. **Analytics:** Create SQL views for data analysis.
5. **Data Quality:** Execute SQL checks to validate the data.

## Project Structure

```text
Titanic-ELT-Data-Engineering/
│
├── extract.py
├── load.py
├── elt_load.py
├── run_elt.py
├── config.py
├── config.example.py
├── staging.sql
├── transformation.sql
├── analytics.sql
├── data_quality.sql
├── run_transform_sql.py
├── run_analytics_sql.py
├── run_quality_sql.py
├── validate.py
├── pipeline.py
├── test_mysql.py
├── ETL.ipynb
└── README.md
```

## Database Structure

**Database:** `titanic_db`

- `raw_titanic` – Stores the original extracted dataset.
- Staging and transformed tables – Store data processed using SQL.
- Analytics views – Provide useful information for analysis.
- Data quality results – Store validation outcomes.

## How to Run the Project

### 1. Clone the repository

```bash
git clone https://github.com/sumithramanduva/Titanic-ELT-Data-Engineering.git
```

### 2. Open the project folder

```bash
cd Titanic-ELT-Data-Engineering
```

### 3. Install dependencies

```bash
pip install pandas seaborn sqlalchemy mysql-connector-python
```

### 4. Configure MySQL

Create a local `config.py` file using the structure in `config.example.py`. Enter your own MySQL credentials locally.

**Important:** Do not upload `config.py` or expose database passwords on GitHub.

### 5. Run the ELT pipeline

```bash
python run_elt.py
```

## Expected Output

The pipeline performs the following operations:

- Extracts 891 records and 15 columns.
- Loads raw data into MySQL.
- Executes staging and transformation SQL scripts.
- Creates analytics views.
- Runs data quality checks.

## Learning Outcomes

- Understanding the ELT pipeline architecture.
- Working with Python and MySQL.
- Loading raw data into a database.
- Performing transformations using SQL.
- Creating analytics views.
- Implementing data quality checks.

## Author

**Sumithra Manduva**

GitHub: [sumithramanduva](https://github.com/sumithramanduva)
