# Advanced CTEs and Window Functions

This section extends the AdventureWorks SQL portfolio from foundational querying into commercial sales analysis using reusable CTE pipelines and MySQL window functions.

## Business questions

1. Which products occupy the top three sales ranks within each product line in 2013?
2. What percentage of its product line's revenue is contributed by each product?
3. How did monthly sales change during 2013, in value and percentage terms?
4. What were cumulative sales and the rolling three-month sales trend?
5. Which products were above or below their product-line average, and how were they ranked and segmented?

## Skills demonstrated

- Multi-stage common table expressions
- Transaction-to-month and transaction-to-product aggregation
- `LAG()` for period-over-period comparison
- `DENSE_RANK()` for ranking with ties
- `NTILE(4)` for performance quartiles
- `SUM() OVER()` for contribution and cumulative totals
- `AVG() OVER()` for peer-group benchmarks
- Explicit window frames with `ROWS BETWEEN`
- Three-month moving averages
- Month-on-month growth calculations
- `CASE WHEN` performance classification
- `NULLIF()` for safe division
- Half-open date-range filtering for `DATETIME` values

## Analytical workflow

Each question follows a commercial analysis pattern:

1. Define the required reporting grain.
2. Aggregate raw transactions in a CTE.
3. Apply window functions without collapsing detail rows.
4. Calculate the final KPI or classification.
5. Sort the result for business interpretation.

## Key interpretation points

- A positive month-on-month percentage indicates growth; a negative value indicates decline.
- The running total shows cumulative 2013 revenue.
- The moving average smooths short-term monthly volatility.
- Product-line contribution identifies revenue concentration.
- Quartile 1 contains the strongest performers within each product line.
- `DENSE_RANK()` preserves tied sales positions, whereas `ROW_NUMBER()` would enforce an exact row count.

## File

- [SQL_Day6_Advanced_CTEs_Window_Functions.sql](SQL_Day6_Advanced_CTEs_Window_Functions.sql)

## Author

**Bhavan Chandupatla**  
MSc Data Science, Coventry University
