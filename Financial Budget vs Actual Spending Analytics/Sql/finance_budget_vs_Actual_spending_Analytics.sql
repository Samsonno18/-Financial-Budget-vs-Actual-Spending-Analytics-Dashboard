
SELECT * FROM `finance_dataset.transactions`;

SELECT * FROM `finance_dataset.Budget`;
-- ================================= --

-- ==================================================== --
-- Checking monthly spending with monthly budegt!
-- ==================================================== --

SELECT
  t.Category,
  FORMAT_DATE('%Y-%m', t.Date) AS Month,
  SUM(t.Amount) AS Total_Spent,
  SUM(b.Budget_Amount),
  SUM(t.Amount) - SUM(b.Budget_Amount) AS Difference
FROM `finance_dataset.transactions` t
JOIN `finance_dataset.Budget` b
  ON t.Category = b.Category
 AND FORMAT_DATE('%Y-%m', t.Date) = b.Month
GROUP BY 
  t.Category,
  Month,
  b.Budget_Amount
ORDER BY Month, Difference DESC;


WITH monthly_spending AS (
  SELECT
    FORMAT_DATE('%Y-%m', t.Date) AS Month,
    t.Category,
    SUM(t.Amount) AS Total_Spent
  FROM `finance_dataset.transactions` t
  GROUP BY Month, t.Category
)

SELECT
  m.Month,
  m.Category,
  m.Total_Spent,
  b.Budget_Amount,
  (m.Total_Spent - b.Budget_Amount) AS Difference,
  ROUND((m.Total_Spent / b.Budget_Amount) * 100, 2) AS Utilization_Percent
FROM monthly_spending m
JOIN `finance_dataset.Budget` b
  ON m.Category = b.Category
 AND m.Month = b.Month
ORDER BY m.Month, Difference DESC;

-- ================================= --
-- Sanity checks --
-- ================================= --

SELECT 
  MIN(Date) AS min_date,
  MAX(Date) AS max_date
FROM `finance_dataset.transactions`;


SELECT 
  COUNT(*) AS total_rows,
  COUNT(DISTINCT CONCAT(CAST(Date AS STRING), Category, CAST(Amount AS STRING))) AS unique_rows
FROM `finance_dataset.transactions`;

SELECT 
  Category,
  COUNT(*) AS row_count,
  SUM(Amount) AS total
FROM `finance_dataset.transactions`
GROUP BY Category
ORDER BY row_count DESC;

SELECT 
  MIN(Amount) AS min_amount,
  MAX(Amount) AS max_amount,
  AVG(Amount) AS avg_amount
FROM `finance_dataset.transactions`;

-- ============================================================================================================================ --

-- This query compares actual spending vs budget at category and monthly level
-- Note: Transactions represent high-value financial data, so spending amounts are significantly larger than budget thresholds
-- The result should be interpreted as budget variance analysis, not absolute financial correctness
-- ============================================================================================================================ --

SELECT
  t.Category,
  FORMAT_DATE('%Y-%m', t.Date) AS Month,

  -- Total actual spending from transaction data
  SUM(t.Amount) AS Total_Spent,

  -- Monthly budget allocated per category
  b.Budget_Amount,

  -- Variance between actual spending and planned budget
  SUM(t.Amount) - b.Budget_Amount AS Difference,

  -- Budget utilization percentage (key KPI for analysis)
  ROUND(SAFE_DIVIDE(SUM(t.Amount), b.Budget_Amount) * 100, 2) AS Utilization_Percent

FROM `finance_dataset.transactions` t
JOIN `finance_dataset.Budget` b
  ON t.Category = b.Category
 AND FORMAT_DATE('%Y-%m', t.Date) = b.Month

GROUP BY
  t.Category,
  Month,
  b.Budget_Amount

ORDER BY
  Month,
  Difference DESC;

-- ========================================== --
  -- Category contribution %--
-- ========================================== --
  SELECT 
  Category,
  SUM(Amount) AS total_spent,
  ROUND(SUM(Amount) / SUM(SUM(Amount)) OVER() * 100, 2) AS percent_share
FROM `finance_dataset.transactions`
GROUP BY Category
ORDER BY total_spent DESC;

-- ================================= --
-- Monthly spending trend --
-- ================================= --
SELECT 
  FORMAT_DATE('%Y-%m', Date) AS Month,
  SUM(Amount) AS total_spent
FROM `finance_dataset.transactions`
GROUP BY Month
ORDER BY Month;

