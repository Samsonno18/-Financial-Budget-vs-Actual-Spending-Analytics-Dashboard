# 📊 Financial Budget vs Actual Spending Analytics Dashboard
End-to-end finance analytics project using Python, Google Sheets, BigQuery, SQL, and Looker Studio.
## 🔗 Live Dashboard

View the interactive dashboard here:

https://datastudio.google.com/s/utou10WciZg

---

## 📌 Project Overview

This project demonstrates an end-to-end data analytics workflow using Google Sheets, Python, BigQuery, SQL, and Looker Studio.

The objective was to build a financial analytics solution that tracks spending patterns, compares actual expenses against budget allocations, and visualizes insights through an interactive dashboard.

The project simulates a real-world analytics pipeline where data is collected, transformed, stored in a cloud data warehouse, analyzed using SQL, and presented through business intelligence dashboards.

---

## 🏗️ Architecture

```text
Google Sheets
      ↓
Python (ETL & Data Cleaning)
      ↓
Google BigQuery
      ↓
SQL Analysis
      ↓
Looker Studio Dashboard
```

---

## 🛠️ Tech Stack

- Python
- Pandas
- Google Sheets API (gspread)
- Google BigQuery
- SQL
- Looker Studio
- Google Cloud Platform

---

## 📂 Data Sources

### Transactions Table

Contains transaction-level spending data:

| Column | Description |
|----------|------------|
| Date | Transaction Date |
| Category | Expense Category |
| Amount | Transaction Amount |

### Budget Table

Contains monthly budget allocations:

| Column | Description |
|----------|------------|
| Month | Budget Month |
| Category | Expense Category |
| Budget_Amount | Planned Budget |

---

## ⚙️ Data Pipeline

### 1. Data Extraction

Financial transaction and budget data are stored in Google Sheets.

Python uses the Google Sheets API to extract data automatically.

### 2. Data Transformation

Data cleaning is performed using Pandas:

- Date conversion
- Numeric validation
- Missing value handling
- Data type standardization

### 3. Data Loading

Cleaned datasets are uploaded into BigQuery tables using the Google Cloud BigQuery client.

### 4. SQL Analysis

SQL queries are used to analyze:

- Category-wise spending
- Monthly spending trends
- Budget variance
- Budget utilization

### 5. Dashboard Creation

Looker Studio is used to build an interactive dashboard with KPIs and visualizations.

---

## 📈 Dashboard Features

### KPI Cards

- Total Spending
- Total Budget
- Budget Utilization %

### Visualizations

- Category-wise Spending Analysis
- Monthly Spending Trend
- Budget vs Actual Comparison
- Interactive Filters

---

## 📊 Example SQL Analysis

#### -- Category contribution %--

  SELECT 
  Category,
  SUM(Amount) AS total_spent,
  ROUND(SUM(Amount) / SUM(SUM(Amount)) OVER() * 100, 2) AS percent_share
FROM `finance_dataset.transactions`
GROUP BY Category
ORDER BY total_spent DESC;

### -- Monthly spending trend --

SELECT 
  FORMAT_DATE('%Y-%m', Date) AS Month,
  SUM(Amount) AS total_spent
FROM `finance_dataset.transactions`
GROUP BY Month
ORDER BY Month;```

---

## 📸 Dashboard Screenshots

### Dashboard Overview

<img width="857" height="637" alt="Financial_Budget_vs_Actual_Spending_Analytics_Dashboard" src="https://github.com/user-attachments/assets/48261091-3043-4ae1-b3c7-fad19aabe8fe" />

### Monthly Analysis 

<img width="387" height="210" alt="Monthly_Analysis" src="https://github.com/user-attachments/assets/c4544c42-3dad-4ea6-a58d-ada35d76ce4b" />


### Analysis By Category

<img width="367" height="201" alt="Analysis_By_Category" src="https://github.com/user-attachments/assets/f43dff8e-f875-4f15-95ac-dda823b9e782" />


---

## 💡 Key Insights

- Spending patterns vary significantly across categories.
- Budget utilization helps identify overspending.
- Variance analysis highlights categories exceeding planned budgets.
- Monthly trends provide visibility into spending behavior over time.

---

## 🎯 Skills Demonstrated

### Data Analytics

- Data Cleaning
- Exploratory Data Analysis
- Business Reporting
- KPI Development

### SQL

- Aggregations
- Joins
- Group By
- Financial Variance Analysis

### Python

- Pandas
- API Integration
- ETL Development

### Cloud Technologies

- BigQuery
- Google Cloud Platform
- Looker Studio

---

## 🚀 Future Improvements

- Automated scheduled refreshes
- Real-time data ingestion
- Expense forecasting
- Budget anomaly detection
- Advanced financial KPI tracking

---

## 📁 Repository Structure

```text
finance-analytics-dashboard/
│
├── data_pipeline/
│   └── load_data.py
│
├── sql/
│  ├── finance_budget_vs_Actual_spending_Analytics.sql
│  ├── Budget_table 
│  └── Transactions_table
├── screenshots/
│   ├── dashboard.png
│   ├── Monthly_Analysis
│   ├── Spent_Vs_Budget
│   └── analysis_by_category.png
│
├── README.md
├── requirements.txt
└── .gitignore
```

---

## 📚 Learning Outcomes

Through this project I gained hands-on experience with:

- Building ETL pipelines using Python
- Integrating Google Sheets with BigQuery
- Writing analytical SQL queries
- Designing dashboards in Looker Studio
- Creating end-to-end analytics workflows
- Working with cloud-based data platforms

---

## 👨‍💻 Author

**Samson Noronha**

Aspiring Data Analyst

Skills: SQL • Python • BigQuery • Looker Studio • Data Analytics
