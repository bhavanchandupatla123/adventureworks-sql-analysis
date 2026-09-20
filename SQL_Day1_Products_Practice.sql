/*
    AdventureWorks Product Analysis
    SQL Day 1: Filtering, sorting and data validation
    Author: Bhavan Chandupatla
    Database: MySQL
*/

USE adventureworks;

-- 1. Validate the number of imported product records.
SELECT COUNT(*) AS total_products
FROM products;

-- 2. Preview the imported dataset.
SELECT *
FROM products
LIMIT 10;

-- 3. Inspect column names and data types.
DESCRIBE products;

-- 4. Identify the 10 most expensive products priced above 1,000.
SELECT ProductKey, ProductName, ListPrice, Colour
FROM products
WHERE ListPrice > 1000
ORDER BY ListPrice DESC
LIMIT 10;

-- 5. Return a clean alphabetical list of available product colours.
SELECT DISTINCT Colour
FROM products
WHERE Colour IS NOT NULL
  AND Colour <> 'NA'
ORDER BY Colour ASC;

-- 6. Find priced products whose names contain "Road".
SELECT ProductKey, ProductName, ListPrice, Colour
FROM products
WHERE ProductName LIKE '%Road%'
  AND ListPrice IS NOT NULL
ORDER BY ProductName ASC;

-- 7. Compare Jersey and Helmet products priced above 50.
SELECT ProductKey, ProductName, ListPrice, Colour
FROM products
WHERE (
        ProductName LIKE '%Jersey%'
        OR ProductName LIKE '%Helmet%'
      )
  AND ListPrice > 50
ORDER BY ListPrice DESC;

-- 8. Find the five highest-priced Black or Silver Mountain products.
SELECT ProductKey, ProductName, ListPrice, Colour
FROM products
WHERE ProductName LIKE '%Mountain%'
  AND Colour IN ('Silver', 'Black')
  AND ListPrice BETWEEN 1000 AND 4000
ORDER BY ListPrice DESC
LIMIT 5;

-- 9. Build a premium Road or Mountain product shortlist.
SELECT ProductKey, ProductName, ListPrice, Colour
FROM products
WHERE (
        ProductName LIKE '%Mountain%'
        OR ProductName LIKE '%Road%'
      )
  AND Colour IS NOT NULL
  AND Colour NOT IN ('NA', 'Silver')
  AND ListPrice BETWEEN 500 AND 3000
ORDER BY ListPrice DESC,
         ProductName ASC
LIMIT 10;
