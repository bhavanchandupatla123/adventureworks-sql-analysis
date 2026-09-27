# AdventureWorks SQL Sales Analysis

A progressive MySQL portfolio project analysing AdventureWorks product and internet-sales data. The project develops from data validation and filtering through joins, date cleaning, conditional analysis, subqueries, CTEs and advanced window functions.

## Project objective

Transform raw product and sales records into reliable commercial insights covering catalogue quality, pricing, product performance, revenue contribution, shipping performance and monthly sales trends.

## Dataset

- **Source:** Microsoft AdventureWorks sample data
- **Products:** 606 rows
- **Internet sales:** 60,398 rows
- **Core tables:** `products`, `factinternetsales`
- **Database:** MySQL
- **Development tool:** MySQL Workbench

## Skills demonstrated

### Day 1 — Filtering and sorting

- `SELECT`, `WHERE`, `DISTINCT`
- `AND`, `OR`, `IN`, `NOT IN`
- `BETWEEN`, `LIKE`, `NULL` handling
- Multi-column `ORDER BY` and `LIMIT`

### Day 2 — Aggregation and grouped analysis

- `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`
- `COUNT(DISTINCT ...)`
- `GROUP BY` and `HAVING`
- Commercial catalogue and pricing analysis
- Text-to-decimal validation and missing-value handling

### Day 3 — Joins and reconciliation

- `INNER JOIN`, `LEFT JOIN` and self joins
- Product-to-sales relationship analysis
- Missing-key detection
- Unsold-product identification
- Sales and order aggregation after joins

### Day 4 — Date cleaning and conditional analysis

- `STR_TO_DATE()` and validated `DATETIME` columns
- `DATEDIFF()` shipping calculations
- `CASE WHEN` status classification
- Conditional aggregation
- Monthly operational KPI reporting
- Safe percentage calculations with `NULLIF()`

### Day 5 — Subqueries and CTEs

- Scalar, correlated and multi-row subqueries
- `EXISTS` and `NOT EXISTS`
- Derived tables
- Single and multiple CTEs
- Recursive CTE month generation
- Above-average product and product-line analysis

### Day 6 — Advanced CTEs and window functions

- `LAG()` for month-on-month comparison
- `DENSE_RANK()` for product ranking
- `NTILE(4)` for performance quartiles
- Partitioned averages and contribution percentages
- Running totals and explicit window frames
- Three-month moving averages
- Multi-stage analytical CTE pipelines

## Featured business analyses

- Top sales ranks within each product line
- Product contribution to product-line revenue
- Month-on-month sales difference and growth percentage
- Cumulative sales progression
- Rolling three-month trend analysis
- Above- and below-average product classification
- Product quartile segmentation
- Shipping-speed classification and on-time order analysis
- Unsold products and missing relationship keys

## Data-quality work

The project identifies and resolves common import problems:

- `ListPrice` imported as text
- Empty strings requiring conversion to SQL `NULL`
- Date fields imported as text
- Date parsing validated before conversion
- New `DATETIME` fields created for reliable filtering and calculations
- Safe-update constraints handled during controlled cleaning
- Join keys checked for duplicates and unmatched records

## Repository structure

```text
adventureworks-sql-analysis/
├── README.md
├── SQL_Day1_Products_Practice.sql
├── SQL_Day2_Aggregations_Practice.sql
├── Day-3-Joins/
│   ├── README.md
│   └── SQL_Day3_Joins_Practice.sql
├── Day-4-Date-Cleaning-and-CASE/
│   ├── SQL_Day4_Date_Cleaning_CASE_Practice.sql
│   └── results/
├── Day-5-Subqueries-and-CTEs/
│   ├── README.md
│   └── SQL_Day5_Subqueries_and_CTEs_Practice.sql
└── Day-6-Advanced-CTEs-and-Window-Functions/
    ├── README.md
    └── SQL_Day6_Advanced_CTEs_Window_Functions.sql
```

## Featured advanced workflow

```text
Raw transactions
    → Aggregate to the required business grain
    → Apply window functions
    → Calculate KPIs and classifications
    → Present decision-ready results
```

## How to run

1. Create or select the `adventureworks` schema.
2. Import the Products and FactInternetSales datasets.
3. Run the data-type validation and cleaning queries before date-dependent analysis.
4. Open the relevant SQL file in MySQL Workbench.
5. Execute individual business questions with `Ctrl + Enter`.

## Portfolio value

This project demonstrates the ability to move beyond writing isolated SQL statements. It shows how to structure multi-stage analysis, validate data quality, translate commercial questions into reporting logic and produce transparent, reusable KPI calculations.

## Next step

Use the cleaned MySQL model as the source for an interactive Power BI sales-performance dashboard.

## Author

**Bhavan Chandupatla**  
MSc Data Science, Coventry University  
Data Analyst | SQL | Power BI | Python | Excel
