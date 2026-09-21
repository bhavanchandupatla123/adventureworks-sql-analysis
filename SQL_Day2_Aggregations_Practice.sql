/*
    AdventureWorks Product Analysis
    SQL Day 2: Aggregations, grouped analysis and commercial reporting
    Author: Bhavan Chandupatla
    Database: MySQL

    Note:
    ListPrice was validated and converted from TEXT to DECIMAL(10,4)
    before running these analytical queries. Missing prices are stored as NULL.
*/

USE adventureworks;

-- 1. Validate total products, priced products and unique colours.
SELECT
    COUNT(*) AS total_products,
    COUNT(ListPrice) AS products_with_price,
    COUNT(DISTINCT Colour) AS unique_colours
FROM products;

-- 2. Produce an overall catalogue price summary.
SELECT
    ROUND(SUM(ListPrice), 2) AS total_catalogue_value,
    ROUND(AVG(ListPrice), 2) AS average_price,
    MIN(ListPrice) AS lowest_price,
    MAX(ListPrice) AS highest_price
FROM products;

-- 3. Summarise the price profile of Black products.
SELECT
    COUNT(*) AS black_product_count,
    ROUND(AVG(ListPrice), 2) AS average_black_price,
    MIN(ListPrice) AS lowest_black_price,
    MAX(ListPrice) AS highest_black_price
FROM products
WHERE Colour = 'Black';

-- 4. Compare product volume and average price across valid colours.
SELECT
    Colour,
    COUNT(*) AS product_count,
    ROUND(AVG(ListPrice), 2) AS average_price
FROM products
WHERE Colour IS NOT NULL
  AND Colour <> 'NA'
GROUP BY Colour
ORDER BY product_count DESC;

-- 5. Compare volume and price statistics across product lines.
SELECT
    ProductLine,
    COUNT(*) AS product_count,
    ROUND(AVG(ListPrice), 2) AS average_price,
    MIN(ListPrice) AS lowest_price,
    MAX(ListPrice) AS highest_price
FROM products
WHERE ProductLine IS NOT NULL
GROUP BY ProductLine
ORDER BY average_price DESC;

-- 6. Count products and unique valid colours within each product line.
SELECT
    ProductLine,
    COUNT(*) AS product_count,
    COUNT(DISTINCT Colour) AS unique_colour_count
FROM products
WHERE ProductLine IS NOT NULL
  AND Colour IS NOT NULL
  AND Colour <> 'NA'
GROUP BY ProductLine
ORDER BY unique_colour_count DESC;

-- 7. Identify substantial, higher-priced colour groups.
SELECT
    Colour,
    COUNT(*) AS product_count,
    ROUND(AVG(ListPrice), 2) AS average_price
FROM products
WHERE Colour IS NOT NULL
  AND Colour <> 'NA'
GROUP BY Colour
HAVING COUNT(*) >= 20
   AND AVG(ListPrice) > 500
ORDER BY average_price DESC;

-- 8. Identify colour groups with catalogue value above 10,000.
SELECT
    Colour,
    COUNT(*) AS product_count,
    ROUND(SUM(ListPrice), 2) AS total_catalogue_value
FROM products
WHERE Colour IS NOT NULL
  AND Colour <> 'NA'
  AND ListPrice IS NOT NULL
GROUP BY Colour
HAVING SUM(ListPrice) > 10000
ORDER BY total_catalogue_value DESC;

-- 9. Analyse qualifying Road products by colour.
SELECT
    Colour,
    COUNT(*) AS road_product_count,
    ROUND(AVG(ListPrice), 2) AS average_road_price,
    MAX(ListPrice) AS highest_price
FROM products
WHERE ProductName LIKE '%Road%'
  AND Colour IS NOT NULL
  AND Colour <> 'NA'
GROUP BY Colour
HAVING COUNT(*) >= 5
   AND AVG(ListPrice) > 700
ORDER BY average_road_price DESC;

-- 10. Compare Colour and ProductLine combinations.
SELECT
    Colour,
    ProductLine,
    COUNT(*) AS product_count,
    ROUND(AVG(ListPrice), 2) AS average_price
FROM products
WHERE Colour IS NOT NULL
  AND Colour <> 'NA'
  AND ProductLine IS NOT NULL
  AND ListPrice IS NOT NULL
GROUP BY Colour, ProductLine
HAVING COUNT(*) >= 5
ORDER BY product_count DESC,
         average_price DESC;

-- 11. Identify commercially significant product lines.
SELECT
    ProductLine,
    COUNT(ListPrice) AS priced_product_count,
    COUNT(DISTINCT Colour) AS unique_colour_count,
    ROUND(AVG(ListPrice), 2) AS average_price,
    ROUND(SUM(ListPrice), 2) AS total_catalogue_value,
    MAX(ListPrice) AS highest_price
FROM products
WHERE ProductLine IS NOT NULL
  AND Colour IS NOT NULL
  AND Colour <> 'NA'
  AND ListPrice IS NOT NULL
GROUP BY ProductLine
HAVING COUNT(ListPrice) >= 10
   AND AVG(ListPrice) BETWEEN 500 AND 2000
   AND SUM(ListPrice) > 10000
ORDER BY total_catalogue_value DESC;

-- 12. Build a premium Road and Mountain combination shortlist.
SELECT
    ProductLine,
    Colour,
    COUNT(*) AS product_count,
    COUNT(DISTINCT ProductName) AS unique_product_count,
    ROUND(AVG(ListPrice), 2) AS average_price,
    ROUND(SUM(ListPrice), 2) AS total_catalogue_value,
    MAX(ListPrice) AS highest_price
FROM products
WHERE ListPrice BETWEEN 500 AND 3000
  AND (
        ProductName LIKE '%Road%'
        OR ProductName LIKE '%Mountain%'
      )
  AND Colour IS NOT NULL
  AND Colour <> 'NA'
  AND ProductLine IS NOT NULL
GROUP BY ProductLine, Colour
HAVING COUNT(*) >= 5
   AND AVG(ListPrice) >= 1000
ORDER BY total_catalogue_value DESC,
         average_price DESC
LIMIT 5;
