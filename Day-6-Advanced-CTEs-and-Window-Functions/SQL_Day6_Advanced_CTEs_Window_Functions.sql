/*
Project: AdventureWorks SQL Sales Analysis
Section: Advanced CTEs and Window Functions
Author: Bhavan Chandupatla
Database: MySQL

Objective:
Answer practical sales-performance questions using CTEs, joins,
aggregations, ranking, contribution analysis, month-on-month growth,
running totals, moving averages and product segmentation.
*/

USE adventureworks;

-- ============================================================
-- BUSINESS QUESTION 1
-- Top three sales ranks within each product line during 2013
-- DENSE_RANK includes all products tied within the top three ranks.
-- ============================================================

WITH year_sales AS
(
    SELECT
        p.ProductKey,
        p.ProductName,
        p.ProductLine,
        ROUND(SUM(f.SalesAmount), 2) AS total_sales
    FROM products AS p
    JOIN factinternetsales AS f
        ON p.ProductKey = f.ProductKey
    WHERE f.OrderDate_new >= '2013-01-01'
      AND f.OrderDate_new <  '2014-01-01'
      AND p.ProductLine IS NOT NULL
    GROUP BY
        p.ProductKey,
        p.ProductName,
        p.ProductLine
),
ranked_sales AS
(
    SELECT
        ProductKey,
        ProductName,
        ProductLine,
        total_sales,
        DENSE_RANK() OVER
        (
            PARTITION BY ProductLine
            ORDER BY total_sales DESC
        ) AS sales_rank
    FROM year_sales
)
SELECT
    ProductKey,
    ProductName,
    ProductLine,
    total_sales,
    sales_rank
FROM ranked_sales
WHERE sales_rank <= 3
ORDER BY ProductLine, sales_rank, ProductKey;


-- ============================================================
-- BUSINESS QUESTION 2
-- Each product's percentage contribution to its product-line sales
-- Uses all available sales history.
-- ============================================================

WITH product_sales AS
(
    SELECT
        p.ProductKey,
        p.ProductName,
        p.ProductLine,
        ROUND(SUM(f.SalesAmount), 2) AS total_sales
    FROM products AS p
    JOIN factinternetsales AS f
        ON p.ProductKey = f.ProductKey
    WHERE p.ProductLine IS NOT NULL
    GROUP BY
        p.ProductKey,
        p.ProductName,
        p.ProductLine
)
SELECT
    ProductKey,
    ProductName,
    ProductLine,
    total_sales,
    ROUND(
        SUM(total_sales) OVER (
            PARTITION BY ProductLine
        ),
        2
    ) AS productline_total,
    ROUND(
        100.0 * total_sales
        / NULLIF(
            SUM(total_sales) OVER (
                PARTITION BY ProductLine
            ),
            0
        ),
        2
    ) AS contribution_percentage
FROM product_sales
ORDER BY ProductLine, contribution_percentage DESC;


-- ============================================================
-- BUSINESS QUESTION 3
-- Month-on-month sales difference and growth percentage for 2013
-- ============================================================

WITH monthly_summary AS
(
    SELECT
        DATE_FORMAT(OrderDate_new, '%Y-%m') AS sales_month,
        ROUND(SUM(SalesAmount), 2) AS monthly_sales
    FROM factinternetsales
    WHERE OrderDate_new >= '2013-01-01'
      AND OrderDate_new <  '2014-01-01'
    GROUP BY DATE_FORMAT(OrderDate_new, '%Y-%m')
),
month_comparison AS
(
    SELECT
        sales_month,
        monthly_sales,
        LAG(monthly_sales, 1) OVER (
            ORDER BY sales_month
        ) AS previous_month_sales
    FROM monthly_summary
)
SELECT
    sales_month,
    monthly_sales,
    previous_month_sales,
    ROUND(
        monthly_sales - previous_month_sales,
        2
    ) AS sales_difference,
    ROUND(
        100.0 * (monthly_sales - previous_month_sales)
        / NULLIF(previous_month_sales, 0),
        2
    ) AS growth_percentage
FROM month_comparison
ORDER BY sales_month;


-- ============================================================
-- BUSINESS QUESTION 4
-- Cumulative sales and three-month moving average for 2013
-- ============================================================

WITH monthly_summary AS
(
    SELECT
        DATE_FORMAT(OrderDate_new, '%Y-%m') AS sales_month,
        ROUND(SUM(SalesAmount), 2) AS monthly_sales
    FROM factinternetsales
    WHERE OrderDate_new >= '2013-01-01'
      AND OrderDate_new <  '2014-01-01'
    GROUP BY DATE_FORMAT(OrderDate_new, '%Y-%m')
)
SELECT
    sales_month,
    monthly_sales,
    ROUND(
        SUM(monthly_sales) OVER (
            ORDER BY sales_month
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ),
        2
    ) AS running_total,
    ROUND(
        AVG(monthly_sales) OVER (
            ORDER BY sales_month
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ),
        2
    ) AS three_month_moving_average
FROM monthly_summary
ORDER BY sales_month;


-- ============================================================
-- BUSINESS QUESTION 5
-- Rank, segment and classify 2013 product performance
-- within each product line.
-- ============================================================

WITH product_sales AS
(
    SELECT
        p.ProductKey,
        p.ProductName,
        p.ProductLine,
        ROUND(SUM(f.SalesAmount), 2) AS total_sales
    FROM products AS p
    JOIN factinternetsales AS f
        ON p.ProductKey = f.ProductKey
    WHERE f.OrderDate_new >= '2013-01-01'
      AND f.OrderDate_new <  '2014-01-01'
      AND p.ProductLine IS NOT NULL
    GROUP BY
        p.ProductKey,
        p.ProductName,
        p.ProductLine
),
performance_metrics AS
(
    SELECT
        ProductKey,
        ProductName,
        ProductLine,
        total_sales,
        ROUND(
            AVG(total_sales) OVER (
                PARTITION BY ProductLine
            ),
            2
        ) AS average_product_sales,
        DENSE_RANK() OVER (
            PARTITION BY ProductLine
            ORDER BY total_sales DESC
        ) AS sales_rank,
        NTILE(4) OVER (
            PARTITION BY ProductLine
            ORDER BY total_sales DESC
        ) AS sales_quartile
    FROM product_sales
)
SELECT
    ProductKey,
    ProductName,
    ProductLine,
    total_sales,
    average_product_sales,
    sales_rank,
    sales_quartile,
    CASE
        WHEN total_sales >= average_product_sales
            THEN 'Above Average'
        ELSE 'Below Average'
    END AS performance_status
FROM performance_metrics
ORDER BY ProductLine, sales_rank, ProductKey;
