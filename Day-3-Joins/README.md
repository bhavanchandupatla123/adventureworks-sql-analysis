# AdventureWorks SQL Analysis — Day 3: JOINs

This project demonstrates how SQL JOINs can turn transactional sales data and product master data into commercially useful analysis.

## Dataset

The analysis uses two AdventureWorks tables:

- `factinternetsales` — sales transactions, order dates, product keys and revenue
- `products` — product names, colours and other product attributes

The tables are connected through `ProductKey`, which acts as the product master key in `products` and a reference key in `factinternetsales`.

## Skills demonstrated

- `INNER JOIN` to enrich sales with product information
- `LEFT JOIN` to preserve complete product or transaction lists
- Anti-joins to identify missing product keys and products with no sales
- `SELF JOIN` to compare products within the same table
- `SUM`, `AVG`, `COUNT` and `COUNT(DISTINCT)` after joining tables
- `GROUP BY` and `HAVING` for commercial performance analysis
- `COALESCE` to represent missing sales as zero
- Duplicate-key checks to protect reporting accuracy
- `STR_TO_DATE` to analyse dates imported from CSV as text
- Half-open date ranges for reliable year filtering

## Business questions answered

1. Which sales transactions have the highest value?
2. Which products generate the most revenue?
3. How is revenue distributed by product colour?
4. Which products have no recorded sales?
5. Are any sales linked to missing product master records?
6. Are product keys unique before joining the tables?
7. Which high-volume products exceed the revenue threshold?
8. Which different products share the same colour?
9. Which products generated the most revenue during 2013?

## Data-quality observations

- The product-key validation query checks for duplicate master records that could inflate revenue after a JOIN.
- The unmatched-sales check tests whether every sales `ProductKey` has a corresponding product record.
- `OrderDate` was imported from CSV as text in `DD/MM/YYYY HH:MM` format. The 2013 analysis uses `STR_TO_DATE` so the filter operates on real date values.

## Files

- `SQL_Day3_Joins_Practice.sql` — documented SQL queries for the full Day 3 exercise

## Tools

- MySQL
- MySQL Workbench
- AdventureWorks sample data

## Key learning

A technically valid JOIN is not automatically a trustworthy JOIN. Before reporting revenue, I validated key uniqueness, checked for unmatched records and used the correct table-preservation logic. These checks help prevent duplicated totals, lost transactions and misleading KPIs.

