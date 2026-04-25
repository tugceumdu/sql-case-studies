-- ============================================================
-- SQL CASE STUDIES: Banking & Retail Analytics
-- Author: Tugce Umdu
-- Tools: SQLite-compatible SQL (runs on any RDBMS)
-- ============================================================
-- Schema: customers, accounts, transactions, products, orders
-- 15 business questions across difficulty levels
-- ============================================================


-- ─────────────────────────────────────────────────────────────
-- SCHEMA SETUP
-- ─────────────────────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS customers (
    customer_id     INTEGER PRIMARY KEY,
    name            TEXT,
    city            TEXT,
    segment         TEXT,       -- 'Retail', 'SME', 'Corporate'
    join_date       DATE,
    age             INTEGER,
    gender          TEXT
);

CREATE TABLE IF NOT EXISTS accounts (
    account_id      INTEGER PRIMARY KEY,
    customer_id     INTEGER,
    account_type    TEXT,       -- 'Checking', 'Savings', 'Credit'
    balance         DECIMAL(12,2),
    opened_date     DATE,
    status          TEXT,       -- 'Active', 'Inactive', 'Closed'
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE IF NOT EXISTS transactions (
    transaction_id  INTEGER PRIMARY KEY,
    account_id      INTEGER,
    txn_date        DATE,
    amount          DECIMAL(10,2),
    txn_type        TEXT,       -- 'Credit', 'Debit'
    category        TEXT,       -- 'Salary', 'Rent', 'Shopping', 'Utilities', 'Transfer', 'ATM'
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

CREATE TABLE IF NOT EXISTS products (
    product_id      INTEGER PRIMARY KEY,
    product_name    TEXT,
    category        TEXT,       -- 'Electronics', 'Clothing', 'Food', 'Home'
    price           DECIMAL(8,2),
    stock           INTEGER
);

CREATE TABLE IF NOT EXISTS orders (
    order_id        INTEGER PRIMARY KEY,
    customer_id     INTEGER,
    product_id      INTEGER,
    order_date      DATE,
    quantity        INTEGER,
    discount        DECIMAL(4,2),   -- e.g. 0.10 = 10%
    status          TEXT,           -- 'Completed', 'Returned', 'Cancelled'
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


-- ─────────────────────────────────────────────────────────────
-- SAMPLE DATA
-- ─────────────────────────────────────────────────────────────

INSERT INTO customers VALUES
(1, 'Ayse Kaya',      'Istanbul', 'Retail',    '2019-03-15', 34, 'F'),
(2, 'Mehmet Demir',   'Ankara',   'SME',       '2020-07-01', 45, 'M'),
(3, 'Zeynep Arslan',  'Istanbul', 'Retail',    '2021-01-20', 28, 'F'),
(4, 'Can Yilmaz',     'Izmir',    'Corporate', '2018-11-05', 52, 'M'),
(5, 'Elif Sahin',     'Istanbul', 'Retail',    '2022-06-10', 23, 'F'),
(6, 'Burak Ozturk',   'Ankara',   'SME',       '2019-09-22', 39, 'M'),
(7, 'Selin Celik',    'Izmir',    'Retail',    '2023-02-14', 31, 'F'),
(8, 'Emre Yildiz',    'Istanbul', 'Corporate', '2017-05-30', 47, 'M'),
(9, 'Pinar Aktas',    'Bursa',    'Retail',    '2021-08-17', 29, 'F'),
(10,'Tolga Koc',      'Istanbul', 'SME',       '2020-12-03', 41, 'M');

INSERT INTO accounts VALUES
(101, 1,  'Checking', 12500.00, '2019-03-15', 'Active'),
(102, 1,  'Savings',  45000.00, '2019-03-15', 'Active'),
(103, 2,  'Checking',  8300.00, '2020-07-01', 'Active'),
(104, 2,  'Credit',       0.00, '2020-07-01', 'Active'),
(105, 3,  'Checking',  2100.00, '2021-01-20', 'Active'),
(106, 4,  'Checking', 87000.00, '2018-11-05', 'Active'),
(107, 4,  'Savings', 250000.00, '2018-11-05', 'Active'),
(108, 5,  'Checking',   450.00, '2022-06-10', 'Active'),
(109, 6,  'Checking', 15600.00, '2019-09-22', 'Active'),
(110, 7,  'Savings',   9200.00, '2023-02-14', 'Active'),
(111, 8,  'Checking', 32000.00, '2017-05-30', 'Active'),
(112, 8,  'Credit',       0.00, '2017-05-30', 'Inactive'),
(113, 9,  'Checking',  5700.00, '2021-08-17', 'Active'),
(114, 10, 'Checking', 18900.00, '2020-12-03', 'Active'),
(115, 10, 'Savings',  62000.00, '2020-12-03', 'Active');

INSERT INTO transactions VALUES
(1001, 101, '2024-01-05',  18000.00, 'Credit',  'Salary'),
(1002, 101, '2024-01-08',   2500.00, 'Debit',   'Rent'),
(1003, 101, '2024-01-12',    380.00, 'Debit',   'Shopping'),
(1004, 101, '2024-02-05',  18000.00, 'Credit',  'Salary'),
(1005, 101, '2024-02-10',    150.00, 'Debit',   'Utilities'),
(1006, 103, '2024-01-03',  12000.00, 'Credit',  'Salary'),
(1007, 103, '2024-01-15',   1800.00, 'Debit',   'Rent'),
(1008, 103, '2024-01-20',    420.00, 'Debit',   'Shopping'),
(1009, 103, '2024-02-03',  12000.00, 'Credit',  'Salary'),
(1010, 105, '2024-01-10',   8500.00, 'Credit',  'Salary'),
(1011, 105, '2024-01-18',    900.00, 'Debit',   'Rent'),
(1012, 106, '2024-01-02',  45000.00, 'Credit',  'Transfer'),
(1013, 106, '2024-01-25',  12000.00, 'Debit',   'Transfer'),
(1014, 108, '2024-01-10',   5000.00, 'Credit',  'Salary'),
(1015, 108, '2024-01-28',    200.00, 'Debit',   'ATM'),
(1016, 109, '2024-01-04',  22000.00, 'Credit',  'Salary'),
(1017, 109, '2024-01-14',   3500.00, 'Debit',   'Rent'),
(1018, 111, '2024-01-01',  60000.00, 'Credit',  'Transfer'),
(1019, 111, '2024-01-20',   8000.00, 'Debit',   'Shopping'),
(1020, 114, '2024-01-06',  28000.00, 'Credit',  'Salary'),
(1021, 114, '2024-02-06',  28000.00, 'Credit',  'Salary'),
(1022, 115, '2024-01-31',  10000.00, 'Credit',  'Transfer');

INSERT INTO products VALUES
(1, 'Laptop Pro 15',    'Electronics', 24999.00, 45),
(2, 'Wireless Earbuds', 'Electronics',  1299.00, 200),
(3, 'Running Shoes',    'Clothing',     2199.00, 130),
(4, 'Coffee Maker',     'Home',         1599.00, 80),
(5, 'Protein Powder',   'Food',          549.00, 300),
(6, 'Desk Chair',       'Home',         4499.00, 25),
(7, 'Smartwatch',       'Electronics',  5999.00, 60),
(8, 'Winter Jacket',    'Clothing',     3299.00, 95),
(9, 'Blender',          'Home',          899.00, 110),
(10,'Yoga Mat',         'Clothing',      399.00, 250);

INSERT INTO orders VALUES
(2001, 1,  7,  '2024-01-10', 1, 0.00,  'Completed'),
(2002, 1,  2,  '2024-01-22', 2, 0.10,  'Completed'),
(2003, 2,  1,  '2024-02-03', 1, 0.05,  'Completed'),
(2004, 3,  3,  '2024-01-15', 1, 0.00,  'Completed'),
(2005, 3,  10, '2024-01-28', 3, 0.00,  'Completed'),
(2006, 4,  6,  '2024-02-01', 4, 0.15,  'Completed'),
(2007, 5,  5,  '2024-01-20', 2, 0.00,  'Completed'),
(2008, 5,  9,  '2024-02-05', 1, 0.00,  'Returned'),
(2009, 6,  8,  '2024-01-08', 1, 0.00,  'Completed'),
(2010, 7,  4,  '2024-02-10', 1, 0.10,  'Completed'),
(2011, 8,  1,  '2024-01-05', 2, 0.20,  'Completed'),
(2012, 9,  2,  '2024-01-30', 1, 0.00,  'Completed'),
(2013, 10, 7,  '2024-02-08', 1, 0.00,  'Completed'),
(2014, 1,  4,  '2024-02-12', 1, 0.00,  'Cancelled'),
(2015, 2,  3,  '2024-02-15', 2, 0.05,  'Completed');


-- ─────────────────────────────────────────────────────────────
-- CASE STUDIES
-- ─────────────────────────────────────────────────────────────


-- ══════════════════════════════════════════
-- LEVEL 1: BASIC QUERIES
-- ══════════════════════════════════════════

-- ───────────────────────────────────────
-- Q1. Total account balance per customer
-- Business use: Know who your high-value customers are.
-- ───────────────────────────────────────
SELECT
    c.customer_id,
    c.name,
    c.segment,
    COUNT(a.account_id)             AS total_accounts,
    SUM(a.balance)                  AS total_balance,
    ROUND(AVG(a.balance), 2)        AS avg_balance_per_account
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
WHERE a.status = 'Active'
GROUP BY c.customer_id, c.name, c.segment
ORDER BY total_balance DESC;

-- Expected insight: Customer 4 (Corporate) and Customer 8 (Corporate)
-- hold the highest balances — priority targets for wealth management products.


-- ───────────────────────────────────────
-- Q2. Monthly transaction volume
-- Business use: Identify peak activity months for capacity planning.
-- ───────────────────────────────────────
SELECT
    strftime('%Y-%m', txn_date)     AS month,
    txn_type,
    COUNT(*)                        AS txn_count,
    ROUND(SUM(amount), 2)           AS total_volume,
    ROUND(AVG(amount), 2)           AS avg_txn_amount
FROM transactions
GROUP BY month, txn_type
ORDER BY month, txn_type;


-- ───────────────────────────────────────
-- Q3. Customers with no transactions in the last 30 days
-- Business use: Identify inactive customers for re-engagement campaigns.
-- ───────────────────────────────────────
SELECT
    c.customer_id,
    c.name,
    c.segment,
    MAX(t.txn_date)                 AS last_transaction_date,
    JULIANDAY('2024-02-28') - JULIANDAY(MAX(t.txn_date)) AS days_since_last_txn
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
LEFT JOIN transactions t ON a.account_id = t.account_id
GROUP BY c.customer_id, c.name, c.segment
HAVING days_since_last_txn > 30
    OR last_transaction_date IS NULL
ORDER BY days_since_last_txn DESC;


-- ══════════════════════════════════════════
-- LEVEL 2: INTERMEDIATE QUERIES
-- ══════════════════════════════════════════

-- ───────────────────────────────────────
-- Q4. Top 3 spending categories per customer
-- Business use: Personalize product recommendations based on spending behavior.
-- ───────────────────────────────────────
WITH category_spend AS (
    SELECT
        c.customer_id,
        c.name,
        t.category,
        SUM(t.amount)               AS total_spend,
        RANK() OVER (
            PARTITION BY c.customer_id
            ORDER BY SUM(t.amount) DESC
        )                           AS spend_rank
    FROM customers c
    JOIN accounts a ON c.customer_id = a.customer_id
    JOIN transactions t ON a.account_id = t.account_id
    WHERE t.txn_type = 'Debit'
    GROUP BY c.customer_id, c.name, t.category
)
SELECT customer_id, name, category, total_spend, spend_rank
FROM category_spend
WHERE spend_rank <= 3
ORDER BY customer_id, spend_rank;


-- ───────────────────────────────────────
-- Q5. Month-over-month revenue growth (retail orders)
-- Business use: Track whether the business is growing.
-- ───────────────────────────────────────
WITH monthly_revenue AS (
    SELECT
        strftime('%Y-%m', o.order_date)                         AS month,
        ROUND(SUM(p.price * o.quantity * (1 - o.discount)), 2)  AS revenue
    FROM orders o
    JOIN products p ON o.product_id = p.product_id
    WHERE o.status = 'Completed'
    GROUP BY month
),
growth AS (
    SELECT
        month,
        revenue,
        LAG(revenue) OVER (ORDER BY month)                      AS prev_month_revenue,
        ROUND(
            (revenue - LAG(revenue) OVER (ORDER BY month))
            / LAG(revenue) OVER (ORDER BY month) * 100, 2
        )                                                       AS mom_growth_pct
    FROM monthly_revenue
)
SELECT * FROM growth ORDER BY month;


-- ───────────────────────────────────────
-- Q6. Customer lifetime value (CLV) proxy
-- Business use: Rank customers by value to prioritize retention spend.
-- ───────────────────────────────────────
WITH customer_orders AS (
    SELECT
        o.customer_id,
        COUNT(DISTINCT o.order_id)                              AS total_orders,
        ROUND(SUM(p.price * o.quantity * (1 - o.discount)), 2) AS total_revenue,
        MIN(o.order_date)                                       AS first_order,
        MAX(o.order_date)                                       AS last_order,
        JULIANDAY(MAX(o.order_date)) - JULIANDAY(MIN(o.order_date)) AS days_active
    FROM orders o
    JOIN products p ON o.product_id = p.product_id
    WHERE o.status = 'Completed'
    GROUP BY o.customer_id
)
SELECT
    c.customer_id,
    c.name,
    c.segment,
    co.total_orders,
    co.total_revenue,
    co.days_active,
    ROUND(co.total_revenue / NULLIF(co.total_orders, 0), 2)    AS avg_order_value,
    CASE
        WHEN co.total_revenue > 50000 THEN 'Platinum'
        WHEN co.total_revenue > 10000 THEN 'Gold'
        WHEN co.total_revenue > 3000  THEN 'Silver'
        ELSE 'Bronze'
    END                                                         AS clv_tier
FROM customers c
JOIN customer_orders co ON c.customer_id = co.customer_id
ORDER BY co.total_revenue DESC;


-- ───────────────────────────────────────
-- Q7. Return rate by product category
-- Business use: Identify problem products before they hurt NPS.
-- ───────────────────────────────────────
SELECT
    p.category,
    COUNT(o.order_id)                                           AS total_orders,
    SUM(CASE WHEN o.status = 'Returned' THEN 1 ELSE 0 END)     AS returns,
    ROUND(
        SUM(CASE WHEN o.status = 'Returned' THEN 1.0 ELSE 0 END)
        / COUNT(o.order_id) * 100, 2
    )                                                           AS return_rate_pct
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY return_rate_pct DESC;


-- ───────────────────────────────────────
-- Q8. Customers with salary credits but high ATM withdrawals
--     (potential cash-reliant customers — lower digital engagement)
-- Business use: Target for digital banking adoption campaigns.
-- ───────────────────────────────────────
WITH salary_customers AS (
    SELECT DISTINCT a.customer_id
    FROM transactions t
    JOIN accounts a ON t.account_id = a.account_id
    WHERE t.category = 'Salary'
),
atm_usage AS (
    SELECT
        a.customer_id,
        COUNT(*)                    AS atm_txn_count,
        SUM(t.amount)               AS atm_total
    FROM transactions t
    JOIN accounts a ON t.account_id = a.account_id
    WHERE t.category = 'ATM'
    GROUP BY a.customer_id
)
SELECT
    c.customer_id,
    c.name,
    c.city,
    au.atm_txn_count,
    au.atm_total
FROM customers c
JOIN salary_customers sc ON c.customer_id = sc.customer_id
JOIN atm_usage au ON c.customer_id = au.customer_id
WHERE au.atm_txn_count >= 1
ORDER BY au.atm_total DESC;


-- ══════════════════════════════════════════
-- LEVEL 3: ADVANCED QUERIES
-- ══════════════════════════════════════════

-- ───────────────────────────────────────
-- Q9. RFM Segmentation (Recency, Frequency, Monetary)
-- Business use: Segment customers for targeted marketing.
-- ───────────────────────────────────────
WITH rfm_raw AS (
    SELECT
        c.customer_id,
        c.name,
        JULIANDAY('2024-02-28') - JULIANDAY(MAX(o.order_date))  AS recency_days,
        COUNT(DISTINCT o.order_id)                              AS frequency,
        ROUND(SUM(p.price * o.quantity * (1 - o.discount)), 2) AS monetary
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN products p ON o.product_id = p.product_id
    WHERE o.status = 'Completed'
    GROUP BY c.customer_id, c.name
),
rfm_scored AS (
    SELECT *,
        NTILE(3) OVER (ORDER BY recency_days ASC)   AS r_score,  -- lower days = better
        NTILE(3) OVER (ORDER BY frequency DESC)     AS f_score,
        NTILE(3) OVER (ORDER BY monetary DESC)      AS m_score
    FROM rfm_raw
)
SELECT
    customer_id,
    name,
    ROUND(recency_days, 0)          AS recency_days,
    frequency,
    monetary,
    r_score, f_score, m_score,
    (r_score + f_score + m_score)   AS rfm_total,
    CASE
        WHEN (r_score + f_score + m_score) >= 8 THEN 'Champions'
        WHEN (r_score + f_score + m_score) >= 6 THEN 'Loyal Customers'
        WHEN (r_score + f_score + m_score) >= 4 THEN 'Potential Loyalists'
        ELSE 'At Risk'
    END                             AS rfm_segment
FROM rfm_scored
ORDER BY rfm_total DESC;


-- ───────────────────────────────────────
-- Q10. Running balance per account
-- Business use: Reproduce bank statement logic and flag overdraft risk.
-- ───────────────────────────────────────
SELECT
    t.transaction_id,
    t.account_id,
    t.txn_date,
    t.txn_type,
    t.category,
    t.amount,
    SUM(
        CASE WHEN t.txn_type = 'Credit' THEN t.amount ELSE -t.amount END
    ) OVER (
        PARTITION BY t.account_id
        ORDER BY t.txn_date, t.transaction_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    )                               AS running_balance
FROM transactions t
ORDER BY t.account_id, t.txn_date, t.transaction_id;


-- ───────────────────────────────────────
-- Q11. Product affinity — which products are bought together?
-- Business use: Build cross-sell recommendations ("customers also bought").
-- ───────────────────────────────────────
SELECT
    p1.product_name                 AS product_a,
    p2.product_name                 AS product_b,
    COUNT(*)                        AS co_purchase_count
FROM orders o1
JOIN orders o2
    ON  o1.customer_id = o2.customer_id
    AND o1.product_id < o2.product_id  -- avoid duplicates
    AND o1.status = 'Completed'
    AND o2.status = 'Completed'
JOIN products p1 ON o1.product_id = p1.product_id
JOIN products p2 ON o2.product_id = p2.product_id
GROUP BY p1.product_name, p2.product_name
HAVING co_purchase_count >= 1
ORDER BY co_purchase_count DESC;


-- ───────────────────────────────────────
-- Q12. Salary-to-spend ratio by customer segment
-- Business use: Assess financial health and credit risk by segment.
-- ───────────────────────────────────────
WITH income AS (
    SELECT
        a.customer_id,
        SUM(t.amount)               AS total_salary_credit
    FROM transactions t
    JOIN accounts a ON t.account_id = a.account_id
    WHERE t.category = 'Salary' AND t.txn_type = 'Credit'
    GROUP BY a.customer_id
),
spend AS (
    SELECT
        a.customer_id,
        SUM(t.amount)               AS total_debit_spend
    FROM transactions t
    JOIN accounts a ON t.account_id = a.account_id
    WHERE t.txn_type = 'Debit'
    GROUP BY a.customer_id
)
SELECT
    c.segment,
    COUNT(DISTINCT c.customer_id)   AS customers,
    ROUND(AVG(i.total_salary_credit), 2)    AS avg_monthly_income,
    ROUND(AVG(s.total_debit_spend), 2)      AS avg_monthly_spend,
    ROUND(
        AVG(s.total_debit_spend) / NULLIF(AVG(i.total_salary_credit), 0) * 100
    , 2)                            AS spend_to_income_ratio_pct
FROM customers c
LEFT JOIN income i ON c.customer_id = i.customer_id
LEFT JOIN spend s  ON c.customer_id = s.customer_id
GROUP BY c.segment
ORDER BY spend_to_income_ratio_pct DESC;


-- ───────────────────────────────────────
-- Q13. Detect potentially dormant accounts
--      (active status but zero transactions for 60+ days)
-- Business use: Regulatory compliance + proactive outreach.
-- ───────────────────────────────────────
SELECT
    a.account_id,
    c.name,
    a.account_type,
    a.balance,
    a.status,
    MAX(t.txn_date)                 AS last_txn_date,
    JULIANDAY('2024-02-28') - JULIANDAY(MAX(t.txn_date))  AS days_dormant
FROM accounts a
JOIN customers c ON a.customer_id = c.customer_id
LEFT JOIN transactions t ON a.account_id = t.account_id
WHERE a.status = 'Active'
GROUP BY a.account_id, c.name, a.account_type, a.balance, a.status
HAVING days_dormant > 60 OR last_txn_date IS NULL
ORDER BY days_dormant DESC;


-- ───────────────────────────────────────
-- Q14. Cohort retention — which join cohort retains best?
-- Business use: Measure long-term customer value by acquisition year.
-- ───────────────────────────────────────
WITH cohorts AS (
    SELECT
        c.customer_id,
        strftime('%Y', c.join_date)                         AS cohort_year,
        strftime('%Y', o.order_date)                        AS order_year
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    WHERE o.status = 'Completed'
),
cohort_size AS (
    SELECT cohort_year, COUNT(DISTINCT customer_id) AS cohort_customers
    FROM (SELECT customer_id, strftime('%Y', join_date) AS cohort_year FROM customers)
    GROUP BY cohort_year
)
SELECT
    co.cohort_year,
    co.order_year,
    cs.cohort_customers,
    COUNT(DISTINCT co.customer_id)      AS active_customers,
    ROUND(
        COUNT(DISTINCT co.customer_id) * 100.0 / cs.cohort_customers
    , 1)                                AS retention_rate_pct
FROM cohorts co
JOIN cohort_size cs ON co.cohort_year = cs.cohort_year
GROUP BY co.cohort_year, co.order_year
ORDER BY co.cohort_year, co.order_year;


-- ───────────────────────────────────────
-- Q15. Full customer 360 view
-- Business use: Single-query snapshot for a CRM or analytics dashboard.
-- ───────────────────────────────────────
WITH account_summary AS (
    SELECT
        customer_id,
        COUNT(account_id)           AS num_accounts,
        SUM(balance)                AS total_balance,
        SUM(CASE WHEN account_type = 'Credit' THEN 1 ELSE 0 END) AS has_credit_card
    FROM accounts WHERE status = 'Active'
    GROUP BY customer_id
),
txn_summary AS (
    SELECT
        a.customer_id,
        COUNT(t.transaction_id)     AS total_transactions,
        MAX(t.txn_date)             AS last_txn_date,
        ROUND(SUM(CASE WHEN t.txn_type = 'Debit' THEN t.amount ELSE 0 END), 2) AS total_spend
    FROM transactions t
    JOIN accounts a ON t.account_id = a.account_id
    GROUP BY a.customer_id
),
order_summary AS (
    SELECT
        o.customer_id,
        COUNT(o.order_id)           AS total_orders,
        ROUND(SUM(p.price * o.quantity * (1 - o.discount)), 2) AS total_order_value
    FROM orders o
    JOIN products p ON o.product_id = p.product_id
    WHERE o.status = 'Completed'
    GROUP BY o.customer_id
)
SELECT
    c.customer_id,
    c.name,
    c.city,
    c.segment,
    c.join_date,
    COALESCE(ac.num_accounts, 0)    AS accounts,
    COALESCE(ac.total_balance, 0)   AS total_balance,
    COALESCE(ac.has_credit_card, 0) AS has_credit_card,
    COALESCE(ts.total_transactions, 0) AS transactions,
    ts.last_txn_date,
    COALESCE(ts.total_spend, 0)     AS total_spend,
    COALESCE(os.total_orders, 0)    AS orders,
    COALESCE(os.total_order_value, 0) AS order_value
FROM customers c
LEFT JOIN account_summary ac ON c.customer_id = ac.customer_id
LEFT JOIN txn_summary ts      ON c.customer_id = ts.customer_id
LEFT JOIN order_summary os    ON c.customer_id = os.customer_id
ORDER BY ac.total_balance DESC NULLS LAST;
