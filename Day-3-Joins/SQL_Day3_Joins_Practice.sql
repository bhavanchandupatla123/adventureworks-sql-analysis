/*
    AdventureWorks SQL Analysis
    Day 3: JOINs and Data Validation

    Tables:
      - products
      - factinternetsales

    Skills demonstrated:
      INNER JOIN, LEFT JOIN, SELF JOIN, aggregation after JOIN,
      anti-joins, duplicate-key checks, COUNT(DISTINCT), HAVING,
      COALESCE, STR_TO_DATE, sorting and limiting results.
*/

USE adventureworks;

-- Initial data checks
SELECT COUNT(*) AS total_sales_rows
FROM factinternetsales;

SELECT
    ProductKey,
    SalesOrderNumber,
    OrderDate,
    SalesAmount,
    TotalProductCost
FROM factinternetsales
LIMIT 10;


-- Q1. Return the ten highest-value sales with product information.
SELECT
    f.SalesOrderNumber,
    f.OrderDate,
    f.ProductKey,
    p.ProductName,
    p.Colour,
    f.SalesAmount
FROM factinternetsales AS f
INNER JOIN products AS p
    ON f.ProductKey = p.ProductKey
ORDER BY f.SalesAmount DESC
LIMIT 10;


-- Q2. Find the top ten products by total sales revenue.
SELECT
    p.ProductKey,
    p.ProductName,
    ROUND(SUM(f.SalesAmount), 2) AS total_sales
FROM products AS p
INNER JOIN factinternetsales AS f
    ON p.ProductKey = f.ProductKey
GROUP BY
    p.ProductKey,
    p.ProductName
ORDER BY total_sales DESC
LIMIT 10;


-- Q3. Summarise total sales revenue by valid product colour.
SELECT
    p.Colour,
    ROUND(SUM(f.SalesAmount), 2) AS total_sales
FROM products AS p
INNER JOIN factinternetsales AS f
    ON p.ProductKey = f.ProductKey
WHERE p.Colour IS NOT NULL
  AND p.Colour <> 'NA'
GROUP BY p.Colour
ORDER BY total_sales DESC;


-- Q4. Show every product, including products with no sales.
SELECT
    p.ProductKey,
    p.ProductName,
    COALESCE(ROUND(SUM(f.SalesAmount), 2), 0) AS total_sales
FROM products AS p
LEFT JOIN factinternetsales AS f
    ON p.ProductKey = f.ProductKey
GROUP BY
    p.ProductKey,
    p.ProductName
ORDER BY total_sales DESC;


-- Q5. Find products that have never been sold.
SELECT
    p.ProductKey,
    p.ProductName,
    p.Colour
FROM products AS p
LEFT JOIN factinternetsales AS f
    ON p.ProductKey = f.ProductKey
WHERE f.ProductKey IS NULL
ORDER BY p.ProductKey;


-- Q6. Find sales rows whose ProductKey is missing from the product master.
SELECT
    f.SalesOrderNumber,
    f.OrderDate,
    f.ProductKey,
    f.SalesAmount
FROM factinternetsales AS f
LEFT JOIN products AS p
    ON f.ProductKey = p.ProductKey
WHERE p.ProductKey IS NULL
ORDER BY f.SalesOrderNumber;

-- Numeric validation of the same missing-key check.
SELECT COUNT(*) AS unmatched_sales
FROM factinternetsales AS f
LEFT JOIN products AS p
    ON f.ProductKey = p.ProductKey
WHERE p.ProductKey IS NULL;


-- Q7. Check whether ProductKey is duplicated in the product master.
SELECT
    ProductKey,
    COUNT(*) AS key_count
FROM products
GROUP BY ProductKey
HAVING COUNT(*) > 1
ORDER BY key_count DESC;


-- Q8. Create a product-performance report for high-volume products.
SELECT
    p.ProductKey,
    p.ProductName,
    COUNT(f.SalesOrderNumber) AS transaction_count,
    ROUND(SUM(f.SalesAmount), 2) AS total_sales,
    ROUND(AVG(f.SalesAmount), 2) AS average_sale
FROM products AS p
INNER JOIN factinternetsales AS f
    ON p.ProductKey = f.ProductKey
GROUP BY
    p.ProductKey,
    p.ProductName
HAVING COUNT(f.SalesOrderNumber) >= 100
   AND SUM(f.SalesAmount) > 100000
ORDER BY total_sales DESC
LIMIT 10;


-- Q9. SELF JOIN: find pairs of different products with the same colour.
SELECT
    p1.ProductName AS first_product,
    p2.ProductName AS second_product,
    p1.Colour AS shared_colour
FROM products AS p1
INNER JOIN products AS p2
    ON p1.Colour = p2.Colour
   AND p1.ProductKey < p2.ProductKey
WHERE p1.Colour IS NOT NULL
  AND p1.Colour <> 'NA'
LIMIT 10;


-- Q10. Find the top five products by revenue during 2013.
-- OrderDate was imported as DD/MM/YYYY HH:MM text, so it is parsed here.
SELECT
    p.ProductKey,
    p.ProductName,
    COUNT(DISTINCT f.SalesOrderNumber) AS unique_orders,
    ROUND(SUM(f.SalesAmount), 2) AS total_sales
FROM factinternetsales AS f
INNER JOIN products AS p
    ON f.ProductKey = p.ProductKey
WHERE STR_TO_DATE(f.OrderDate, '%d/%m/%Y %H:%i') >= '2013-01-01'
  AND STR_TO_DATE(f.OrderDate, '%d/%m/%Y %H:%i') < '2014-01-01'
GROUP BY
    p.ProductKey,
    p.ProductName
HAVING COUNT(DISTINCT f.SalesOrderNumber) >= 100
ORDER BY total_sales DESC
LIMIT 5;

