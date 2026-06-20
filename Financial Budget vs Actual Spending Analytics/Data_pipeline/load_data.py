import gspread
import pandas as pd
from google.cloud import bigquery
from google.oauth2 import service_account

# ---------------- CONFIG ----------------
KEY_FILE = r"C:\Users\Samson Noronha\Downloads\Key.json"
SHEET_NAME = "Finance Tracker"
GCP_PROJECT = "finance-tracker-499615"
DATASET = "finance_dataset"
TABLE_NAME = "transactions"

table_id = f"{GCP_PROJECT}.{DATASET}.{TABLE_NAME}"

# ---------------- AUTH ----------------
credentials = service_account.Credentials.from_service_account_file(KEY_FILE)

# BigQuery client
bq_client = bigquery.Client(
    credentials=credentials,
    project=GCP_PROJECT
)

# Google Sheets client (needs scopes)
scope = [
    "https://spreadsheets.google.com/feeds",
    "https://www.googleapis.com/auth/drive"
]

gs_credentials = service_account.Credentials.from_service_account_file(
    KEY_FILE,
    scopes=scope
)

gc = gspread.authorize(gs_credentials)

# ---------------- READ GOOGLE SHEET ----------------
print("Reading Transactions sheet...")

sheet = gc.open(SHEET_NAME).worksheet("Transactions")
data = sheet.get_all_records()

transactions = pd.DataFrame(data)

# ---------------- CLEAN DATA ----------------
transactions['Date'] = pd.to_datetime(
    transactions['Date'],
    dayfirst=True,
    errors='coerce'
).dt.date

transactions['Amount'] = pd.to_numeric(
    transactions['Amount'],
    errors='coerce'
)

print("Data cleaned successfully")

# ---------------- BIGQUERY UPLOAD ----------------
job_config = bigquery.LoadJobConfig()
job_config.write_disposition = bigquery.WriteDisposition.WRITE_TRUNCATE

job = bq_client.load_table_from_dataframe(
    transactions,
    table_id,
    job_config=job_config
)

job.result()
print("Upload successful!")


# ---------------- BUDGET SHEET ----------------
print("Reading Budget sheet...")

budget_sheet = gc.open(SHEET_NAME).worksheet("Budget")
budget_data = budget_sheet.get_all_records()

budget_df = pd.DataFrame(budget_data)

print("Budget rows:", len(budget_df))

budget_table_id = f"{GCP_PROJECT}.{DATASET}.Budget"

budget_job = bq_client.load_table_from_dataframe(
    budget_df,
    budget_table_id,
    job_config=job_config
)

budget_job.result()

print("Budget upload successful!")