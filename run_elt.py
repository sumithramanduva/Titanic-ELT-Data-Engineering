
import subprocess
import sys
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent

steps = [
    ("Extract and load raw data", "elt_load.py"),
    ("Create staging and clean tables", "run_transform_sql.py"),
    ("Create analytics views", "run_analytics_sql.py"),
    ("Run data quality checks", "run_quality_sql.py"),
]

for step_name, script_name in steps:
    print(f"\n{'=' * 50}")
    print(f"STEP: {step_name}")
    print("=" * 50)

    script_path = BASE_DIR / script_name

    if not script_path.exists():
        print(f"Missing file: {script_name}")
        print("Create this file before running the pipeline.")
        sys.exit(1)

    result = subprocess.run(
        [sys.executable, str(script_path)],
        cwd=BASE_DIR,
        check=False
    )

    if result.returncode != 0:
        print(f"\nPipeline failed during: {step_name}")
        sys.exit(result.returncode)

print("\nELT pipeline completed successfully!")
