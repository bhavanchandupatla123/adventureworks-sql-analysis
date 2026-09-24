-- AdventureWorks SQL Analysis
-- Subqueries and Common Table Expressions (CTEs)
-- Author: Bhavan Chandupatla
-- Database: MySQL 8+

USE adventureworks;

-- 1. Scalar subquery: products priced above the overall average
SELECT
    ProductKey,
    ProductName,
    ListPrice
FROM products
WHERE ListPrice > (
    SELECT AVG(ListPrice)
    FROM products
)
ORDER BY ListPrice DESC;


-- 2. Multiple-row subquery: products that appear in the sales table
SELECT
    ProductKey,
    ProductName,
    Colour
FROM products
WHERE ProductKey IN (
    SELECT ProductKey
    FROM factinternetsales
)
  AND Colour IS NOT NULL
  AND Colour <> 'NA'
ORDER BY ProductKey;


-- 3. NOT EXISTS: products that have never been sold
SELECT
    p.ProductKey,
    p.ProductName,
    p.Colour
FROM products AS p
WHERE NOT EXISTS (
    SELECT 1
    FROM factinternetsales AS f
    WHERE f.ProductKey = p.ProductKey
)
  AND p.Colour IS NOT NULL
  AND p.Colour <> 'NA'
ORDER BY p.ProductKey;


-- 4. Correlated subquery: products priced above their own product-line average
SELECT
    p1.ProductKey,
    p1.ProductName,
    p1.ProductLine,
    p1.ListPrice
FROM products AS p1
WHERE p1.ListPrice > (
    SELECT AVG(p2.ListPrice)
    FROM products AS p2
    WHERE p2.ProductLine = p1.ProductLine
)
  AND p1.ProductLine IS NOT NULL
  AND p1.ListPrice IS NOT NULL
ORDER BY
    p1.ProductLine,
    p1.ListPrice DESC;


-- 5. Scalar subqueries in SELECT: overall average and difference from average
SELECT
    p1.ProductName,
    p1.ListPrice,
    ROUND(
        (
            SELECT AVG(p2.ListPrice)
            FROM products AS p2
        ),
        2
    ) AS overall_average,
    ROUND(
        p1.ListPrice - (
            SELECT AVG(p2.ListPrice)
            FROM products AS p2
        ),
        2
    ) AS difference_from_average
FROM products AS p1
WHERE p1.ListPrice IS NOT NULL
ORDER BY difference_from_average DESC;


-- 6. Derived table: filter an aggregated product-line summary
SELECT
    summary.ProductLine,
    summary.product_count,
    summary.average_price,
    summary.highest_price
FROM (
    SELECT
        ProductLine,
        COUNT(*) AS product_count,
        ROUND(AVG(ListPrice), 2) AS average_price,
        MAX(ListPrice) AS highest_price
    FROM products
    WHERE ProductLine IS NOT NULL
      AND ListPrice IS NOT NULL
    GROUP BY ProductLine
) AS summary
WHERE summary.average_price > 500
  AND summary.product_count >= 10
ORDER BY summary.average_price DESC;


-- 7. CTE: the same product-line analysis in a clearer structure
WITH product_summary AS (
    SELECT
        ProductLine,
        COUNT(*) AS product_count,
        ROUND(AVG(ListPrice), 2) AS average_price,
        MAX(ListPrice) AS highest_price,
        ROUND(SUM(ListPrice), 2) AS total_line_price
    FROM products
    WHERE ProductLine IS NOT NULL
      AND ListPrice IS NOT NULL
    GROUP BY ProductLine
)
SELECT
    ProductLine,
    product_count,
    average_price,
    highest_price,
    total_line_price
FROM product_summary
WHERE average_price > 500
  AND product_count >= 10
ORDER BY average_price DESC;


-- 8. Multiple CTEs: products performing above the average product total
WITH product_sales AS (
    SELECT
        p.ProductKey,
        p.ProductName,
        ROUND(SUM(f.SalesAmount), 2) AS total_sales
    FROM products AS p
    JOIN factinternetsales AS f
        ON p.ProductKey = f.ProductKey
    GROUP BY
        p.ProductKey,
        p.ProductName
),
average_total_sales AS (
    SELECT
        AVG(total_sales) AS average_product_sale
    FROM product_sales
)
SELECT
    ProductKey,
    ProductName,
    total_sales
FROM product_sales
WHERE total_sales > (
    SELECT average_product_sale
    FROM average_total_sales
)
ORDER BY total_sales DESC;


-- 9. ALL: products priced above every product in ProductLine S
SELECT
    p1.ProductKey,
    p1.ProductName,
    p1.ProductLine,
    p1.ListPrice
FROM products AS p1
WHERE p1.ListPrice > ALL (
    SELECT p2.ListPrice
    FROM products AS p2
    WHERE p2.ProductLine = 'S'
      AND p2.ListPrice IS NOT NULL
)
  AND p1.ListPrice IS NOT NULL
ORDER BY p1.ListPrice DESC;


-- 10. Recursive CTE: generate all months in 2013
WITH RECURSIVE months AS (
    SELECT DATE('2013-01-01') AS month_start

    UNION ALL

    SELECT DATE_ADD(month_start, INTERVAL 1 MONTH)
    FROM months
    WHERE month_start < '2013-12-01'
)
SELECT
    DATE_FORMAT(month_start, '%Y-%m') AS sales_month
FROM months;
