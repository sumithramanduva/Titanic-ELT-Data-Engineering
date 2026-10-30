
# validate.py

def validate(df):
    errors = []

    # Check required columns
    required_columns = ["age", "embarked", "sex"]

    missing_columns = [
        column for column in required_columns
        if column not in df.columns
    ]

    if missing_columns:
        errors.append(f"Missing columns: {missing_columns}")
    else:
        # Check nulls in age and embarked
        if df["age"].isnull().any():
            errors.append("Null values found in age!")

        if df["embarked"].isnull().any():
            errors.append("Null values found in embarked!")

        # Check age range
        if ((df["age"] < 0) | (df["age"] > 100)).any():
            errors.append("Age must be between 0 and 100!")

        # Check sex encoding only if sex is numeric
        if df["sex"].dtype.kind in "iuf":
            if not df["sex"].isin([0, 1]).all():
                errors.append("Sex must contain only 0 or 1!")

    if errors:
        for error in errors:
            print(f"Validation failed: {error}")
        return False

    print("Validation passed!")
    return True
