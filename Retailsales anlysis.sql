USE Portfolio_project;

-- **Data Cleaning** --
SELECT 
    COUNT(*)
FROM
    retail_sales;

DELETE FROM retail_sales 
WHERE
    transactions_id IS NULL
    OR sale_date IS NULL
    OR sale_time IS NULL
    OR customer_id IS NULL
    OR gender IS NULL
    OR age IS NULL
    OR category IS NULL
    OR quantiy IS NULL
    OR price_per_unit IS NULL
    OR cogs IS NULL
    OR total_sale IS NULL;

SET sql_safe_updates = 0;

-- **Data Exploration** --

-- Total Sales --
SELECT 
    COUNT(*) AS total_sales
FROM
    retail_sales;

-- How Many Unique Customers --
SELECT 
    COUNT(DISTINCT (customer_id)) AS Unique_customers
FROM
    retail_sales;

-- Unique Categories --
SELECT DISTINCT
    (category)
FROM
    retail_sales;

-- Sales Made on '2022-11-05' --
SELECT 
    *
FROM
    retail_sales
WHERE
    sale_date = '2022-11-05';

-- Transactions in 'Clothing' Category with Quantity Sold > 4 in Nov-2022 --
SELECT 
    COUNT(*)
FROM
    retail_sales r1
WHERE
    (SELECT 
            SUBSTR(sale_date, 1, 7)
        FROM
            retail_sales r2
        WHERE
            r1.transactions_id = r2.transactions_id) = '2022-11'
        AND category LIKE 'Clothing'
        AND quantiy >= 4;

-- Total Sales by Each Category --
SELECT 
    category, SUM(total_sale), COUNT(*) AS `Total sales`
FROM
    retail_sales
GROUP BY category;

-- Average Age of Customers Purchasing from 'Beauty' Category --
SELECT 
    ROUND(AVG(age), 2)
FROM
    retail_sales
WHERE
    category LIKE 'Beauty';

-- Transactions Where Total Sale > 1000 --
SELECT 
    *
FROM
    retail_sales
WHERE
    total_Sale > 1000;

-- Total Transactions by Gender in Each Category --
SELECT 
    gender, category, COUNT(transactions_id)
FROM
    retail_sales
GROUP BY gender , category;

-- Average Sale for Each Month, Best-Selling Month in Each Year --
SELECT 
    year, month, ROUND(avg, 2), ranks 
FROM
    (SELECT 
         YEAR(sale_date) AS year,
         MONTH(sale_date) AS month,
         AVG(total_sale) AS avg,
         RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS ranks 
     FROM retail_sales 
     GROUP BY 1, 2) t 
WHERE ranks = 1;

-- Top 5 Customers Based on Highest Total Sales --
SELECT 
    customer_id, SUM(total_sale) AS Total_sales 
FROM 
    retail_sales 
GROUP BY 1 
ORDER BY 2 DESC 
LIMIT 5;

-- Number of Unique Customers Who Purchased Items from Each Category --
SELECT 
    category, COUNT(DISTINCT (customer_id))
FROM
    retail_sales
GROUP BY 1;

-- Shift-Based Orders (Morning, Afternoon, Evening) --
SELECT 
    COUNT(*),
    CASE
        WHEN et < 12 THEN 'Morning'
        WHEN et BETWEEN 12 AND 17 THEN 'Afternoon'
        WHEN et > 17 THEN 'Evening'
    END AS Shift
FROM
    (SELECT 
        SUBSTRING(sale_time, 1, 2) AS et
    FROM
        retail_sales) a
GROUP BY 2;
