# SQL Case Studies: Banking & Retail Analytics

15 business-driven SQL queries across a realistic banking and retail schema. Each query solves a real analytical problem — from customer segmentation to cohort retention — with a short explanation of the business use case.

---

## Schema Overview

```
customers ──┬── accounts ── transactions
            └── orders ──── products
```

| Table | Rows | Description |
|---|---|---|
| `customers` | 10 | Demographics, segment (Retail / SME / Corporate), join date |
| `accounts` | 15 | Checking, Savings, Credit accounts with balances |
| `transactions` | 22 | Debits and credits by category (Salary, Rent, Shopping, ATM...) |
| `products` | 10 | Electronics, Clothing, Home, Food items |
| `orders` | 15 | Customer purchases with discount and status (Completed, Returned, Cancelled) |

---

## Case Studies

### Level 1 — Basic

| # | Question | Key Concepts |
|---|---|---|
| Q1 | Total account balance per customer | JOIN, GROUP BY, aggregation |
| Q2 | Monthly transaction volume | strftime, GROUP BY month |
| Q3 | Customers with no transactions in 30 days | LEFT JOIN, HAVING, JULIANDAY |

### Level 2 — Intermediate

| # | Question | Key Concepts |
|---|---|---|
| Q4 | Top 3 spending categories per customer | CTE, RANK() window function |
| Q5 | Month-over-month revenue growth | CTE, LAG() window function |
| Q6 | Customer Lifetime Value (CLV) tiers | CTE, CASE WHEN, NULLIF |
| Q7 | Return rate by product category | Conditional aggregation |
| Q8 | Salary earners with high ATM usage | Multiple CTEs, subquery pattern |

### Level 3 — Advanced

| # | Question | Key Concepts |
|---|---|---|
| Q9 | RFM Segmentation (Recency, Frequency, Monetary) | CTE, NTILE(), window functions |
| Q10 | Running account balance (bank statement logic) | SUM() OVER (ROWS UNBOUNDED PRECEDING) |
| Q11 | Product affinity — co-purchase analysis | Self JOIN, cross-sell logic |
| Q12 | Salary-to-spend ratio by segment | Multiple CTEs, NULLIF for division safety |
| Q13 | Dormant account detection | LEFT JOIN, HAVING with NULL check |
| Q14 | Cohort retention analysis | CTE, year-over-year retention rate |
| Q15 | Full customer 360 view | 4-way LEFT JOIN, COALESCE |

---

## Sample Results

**Q1 — Top customers by total balance:**
| Customer | Segment | Total Balance |
|---|---|---|
| Can Yilmaz | Corporate | 337,000 |
| Tolga Koc | SME | 80,900 |
| Ayse Kaya | Retail | 57,500 |

**Q9 — RFM Segmentation:**
| Customer | Recency (days) | Orders | Revenue |
|---|---|---|---|
| Emre Yildiz | 54 | 1 | 39,998 |
| Mehmet Demir | 13 | 2 | 27,927 |
| Can Yilmaz | 27 | 1 | 15,297 |

---

## How to Run

The SQL file is self-contained and runs on any RDBMS. Tested on SQLite.

```bash
# SQLite
sqlite3 < case_studies.sql

# PostgreSQL
psql -U your_user -d your_db -f case_studies.sql

# Or paste into DB Browser for SQLite (free GUI)
```

---

## Tech Stack

- **SQL** — window functions, CTEs, self-joins, conditional aggregation
- **SQLite** compatible (no proprietary syntax)
- Schema designed to mirror real banking and retail data structures

---

## Project Structure

```
sql-case-studies/
├── case_studies.sql    # Full schema + 15 queries with business context
└── README.md
```

---

*Built as part of a business analytics portfolio. All data is synthetically generated.*
