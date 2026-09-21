# AdventureWorks SQL Product Analysis

This portfolio project uses the AdventureWorks product dataset in MySQL to answer practical merchandising, pricing and data-quality questions. The repository now covers foundational filtering and sorting, followed by aggregate analysis and grouped commercial reporting.

## Project objective

The analysis validates imported product data, identifies premium products, explores catalogue pricing, compares product colours and product lines, and builds focused shortlists for merchandising decisions.

## Skills demonstrated

### Day 1 — Filtering and sorting

- `SELECT` and `FROM`
- `WHERE` filters
- `AND`, `OR` and logical parentheses
- `IN` and `NOT IN`
- `BETWEEN`
- `DISTINCT`
- `LIKE` with wildcards
- `IS NULL` and `IS NOT NULL`
- Single- and multi-column `ORDER BY`
- `LIMIT`
- CSV import and validation in MySQL Workbench

### Day 2 — Aggregation and grouped analysis

- `COUNT`, `SUM`, `AVG`, `MIN` and `MAX`
- `COUNT(DISTINCT ...)`
- Single- and multiple-column `GROUP BY`
- Row filtering with `WHERE`
- Group filtering with `HAVING`
- Aggregate aliases and sorting
- NULL handling in aggregate calculations
- Text-to-decimal data-type validation
- Commercial catalogue and pricing analysis

## Business questions answered

1. How many products were imported and how complete are the price and colour fields?
2. Which are the highest-priced products above selected thresholds?
3. Which valid product colours are available?
4. Which products match Road, Mountain, Jersey and Helmet search criteria?
5. What are the overall catalogue total, average, minimum and maximum prices?
6. How do product volume and average price vary by colour?
7. How do pricing and colour diversity vary by product line?
8. Which colour groups meet minimum volume and average-price thresholds?
9. Which groups contribute more than 10,000 in catalogue value?
10. Which Road products meet grouped colour and price criteria?
11. Which product lines are commercially significant based on volume, average price and catalogue value?
12. Which premium Road and Mountain combinations form the strongest shortlist?

## Data-quality work

During the analysis, `ListPrice` was found to have been imported as `TEXT`, with missing prices represented by empty strings. The field was validated, empty strings were converted to SQL `NULL`, and the column was converted to `DECIMAL(10,4)`. This allowed `MIN`, `MAX`, `AVG` and `SUM` to return reliable numeric results.

## Dataset

- Source: Microsoft AdventureWorks sample data
- Table analysed: `products`
- Records imported: 606
- Database: MySQL
- Tool: MySQL Workbench

## Repository structure

```text
adventureworks-sql-analysis/
├── README.md
├── SQL_Day1_Products_Practice.sql
└── SQL_Day2_Aggregations_Practice.sql
```

## How to run

1. Import the AdventureWorks Products CSV into MySQL as `products`.
2. Create or select the `adventureworks` schema.
3. Confirm that `ListPrice` is a numeric column and missing values are stored as `NULL`.
4. Open the required SQL practice file in MySQL Workbench.
5. Execute individual statements with `Ctrl + Enter`.

## Next steps

Future stages will extend the project with joins, subqueries, common table expressions, conditional logic and window functions.

## Author

**Bhavan Chandupatla**  
MSc Data Science, Coventry University
