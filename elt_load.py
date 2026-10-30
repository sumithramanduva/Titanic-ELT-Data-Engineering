
from datetime import datetime, timezone

from extract import extract
from load import load


def load_raw():
    df = extract()

    # Add the two required ELT metadata columns.
    df["load_timestamp"] = datetime.now(timezone.utc).replace(tzinfo=None)
    df["batch_id"] = datetime.now(timezone.utc).strftime("%Y%m%d%H%M%S")

    # Reuse your existing load() function.
    load(df, table_name="raw_titanic")


if __name__ == "__main__":
    load_raw()
