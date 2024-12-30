use Portfolio_project;
select * from retail_sales;
-- data cleaning
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
set sql_safe_updates=0;

-- data exploration:
-- total sales
SELECT 
    COUNT(*) AS tota_sales
FROM
    retail_sales;

-- How many Unique customers
SELECT 
    COUNT(DISTINCT (customer_id)) AS Unique_customers
FROM
    retail_sales;

-- Unique Categories
SELECT DISTINCT
    (category)
FROM
    retail_sales;

-- Write a SQL query to retrieve all columns for sales made on '2022-11-05:
SELECT 
    *
FROM
    retail_sales
WHERE
    sale_date = '2022-11-05';

-- Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
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

-- Write a SQL query to calculate the total sales (total_sale) for each category.:
SELECT 
    category, SUM(total_sale),count(*) AS `Total sales`
FROM
    retail_sales
GROUP BY category;

-- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
SELECT 
    round(AVG(age),2)
FROM
    retail_sales
WHERE
    category LIKE 'Beauty';
    
-- Write a SQL query to find all transactions where the total_sale is greater than 1000.:
SELECT 
    *
FROM
    retail_sales
WHERE
    total_Sale > 1000;
    
-- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
SELECT 
    gender, category, COUNT(transactions_id)
FROM
    retail_sales
GROUP BY gender , category;

-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
select 
	year,month,round(avg,2),ranks 
from(select year(sale_date) as year,
			month(sale_date) as month,
            avg(total_sale) as avg,
            rank() over (partition by year(sale_date) order by avg(total_sale) desc) as ranks 
	from retail_sales group by 1,2)t 
where ranks = 1;  

-- **Write a SQL query to find the top 5 customers based on the highest total sales **:
select customer_id,sum(total_sale) Total_sales from retail_sales group by 1 order by 2 desc limit 5;

-- Write a SQL query to find the number of unique customers who purchased items from each category.:
SELECT 
    category, COUNT(DISTINCT (customer_id))
FROM
    retail_sales
GROUP BY 1;


-- Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
SELECT 
    COUNT(*),
    CASE
        WHEN et < 12 THEN 'Morning'
        WHEN et BETWEEN 12 AND 17 THEN 'Afternoon'
        WHEN et > 17 THEN 'Evening'
    END AS Shift
FROM
    (SELECT 
        SUBSTRING(sale_time, 1, 2) et
    FROM
        retail_sales) a
GROUP BY 2;