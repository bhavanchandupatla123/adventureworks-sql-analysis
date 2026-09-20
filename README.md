# AdventureWorks SQL Product Analysis

This project documents the first stage of my structured SQL portfolio, using the AdventureWorks product dataset in MySQL to answer practical business questions.

## Project objective

The analysis focuses on validating imported data, identifying premium products, exploring product colours, applying price bands and creating focused product shortlists for merchandising and pricing decisions.

## Skills demonstrated

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

## Business questions answered

1. How many products were imported successfully?
2. Which are the ten highest-priced products above 1,000?
3. Which valid product colours are available?
4. Which priced products contain “Road” in their name?
5. Which Jersey and Helmet products are priced above 50?
6. What are the five highest-priced Black or Silver Mountain products?
7. Which premium Road or Mountain products satisfy the selected price and colour rules?

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
└── SQL_Day1_Products_Practice.sql
```

## How to run

1. Import the AdventureWorks Products CSV into MySQL as `products`.
2. Create or select the `adventureworks` schema.
3. Open `SQL_Day1_Products_Practice.sql` in MySQL Workbench.
4. Execute individual statements with `Ctrl + Enter`.

## Next steps

Future stages will extend the analysis with aggregate functions, `GROUP BY`, `HAVING`, joins, subqueries, common table expressions and window functions.

## Author

**Bhavan Chandupatla**  
MSc Data Science, Coventry University
