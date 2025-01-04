Portfolio Project: Retail Sales Analysis

Project Objective

The goal of this project is to analyze retail sales data to gain insights into customer behavior, product performance, sales trends, and operational patterns. This analysis provides actionable recommendations to drive revenue, improve customer engagement, and optimize inventory management.

Project Summary

Dataset Overview

The project uses a fictional dataset named retail_sales, which includes the following columns:
	•	transactions_id: Unique transaction identifiers.
	•	sale_date: Date of the transaction.
	•	sale_time: Time of the transaction.
	•	customer_id: Unique identifier for customers.
	•	gender: Gender of the customer.
	•	age: Age of the customer.
	•	category: Product category (e.g., Clothing, Beauty).
	•	quantity: Quantity of items purchased.
	•	price_per_unit: Price of each unit.
	•	cogs: Cost of goods sold.
	•	total_sale: Total value of the sale.

Analysis Breakdown

1. Data Cleaning
	•	Objective: Ensure the dataset is clean and reliable for analysis.
	•	Approach:
	•	Identified and removed rows with NULL values in critical columns such as transactions_id, sale_date, customer_id, etc.
	•	Insight:
	•	Establishes a consistent dataset for meaningful analysis.

2. Total Sales
	•	Objective: Count the total number of sales.
	•	Approach:
	•	Queried the total number of transactions in the retail_sales table.
	•	Insight:
	•	Gives a quick snapshot of the business scale.

3. Unique Customers
	•	Objective: Count the number of unique customers.
	•	Approach:
	•	Calculated distinct customer IDs from the retail_sales table.
	•	Insight:
	•	Assesses customer base size and diversity.

4. Unique Categories
	•	Objective: Identify unique product categories.
	•	Approach:
	•	Extracted distinct values from the category column.
	•	Insight:
	•	Highlights the breadth of the product range.

5. Sales on a Specific Date
	•	Objective: Retrieve transactions from November 5, 2022.
	•	Approach:
	•	Filtered sales data by the specified date.
	•	Insight:
	•	Helps analyze daily sales performance and customer activity.

6. Clothing Transactions with Quantity > 4
	•	Objective: Count transactions in the Clothing category with quantities greater than 4 during November 2022.
	•	Approach:
	•	Used subqueries to extract and filter relevant data.
	•	Insight:
	•	Analyzes high-volume purchases for targeted promotions.

7. Total Sales by Category
	•	Objective: Calculate total sales and transaction counts for each category.
	•	Approach:
	•	Grouped data by category and aggregated sales.
	•	Insight:
	•	Identifies best-performing product categories.

8. Average Age of Beauty Product Customers
	•	Objective: Determine the average age of customers purchasing beauty products.
	•	Approach:
	•	Filtered data for the Beauty category and computed the average age.
	•	Insight:
	•	Helps tailor marketing strategies based on demographics.

9. High-Value Transactions
	•	Objective: Retrieve transactions with total sales exceeding ₹1,000.
	•	Approach:
	•	Filtered data using a sales threshold.
	•	Insight:
	•	Identifies premium customers and high-value sales events.

10. Gender-Based Transactions by Category
	•	Objective: Count transactions by gender within each category.
	•	Approach:
	•	Grouped data by gender and category.
	•	Insight:
	•	Facilitates gender-specific marketing campaigns.

11. Monthly Sales Trends
	•	Objective: Identify the best-selling month for each year based on average sales.
	•	Approach:
	•	Used window functions and ranking to rank months by average sales.
	•	Insight:
	•	Analyzes seasonal trends to optimize inventory and marketing.

12. Top Customers by Total Sales
	•	Objective: Identify the top 5 customers based on total sales.
	•	Approach:
	•	Aggregated sales data by customer ID and ranked them by sales.
	•	Insight:
	•	Helps recognize loyal and high-value customers for special programs.

13. Unique Customers per Category
	•	Objective: Count the number of unique customers for each product category.
	•	Approach:
	•	Grouped data by category and counted distinct customers.
	•	Insight:
	•	Provides insights into category-specific customer reach.

14. Shift-Based Orders
	•	Objective: Analyze orders by time shifts (Morning, Afternoon, Evening).
	•	Approach:
	•	Extracted hour values from the sale_time column and categorized them into shifts.
	•	Insight:
	•	Determines peak operational hours for better resource allocation.

Key Skills and Tools Utilized
	•	SQL:
	•	Data cleaning, filtering, aggregation, subqueries, window functions, and ranking.
	•	Data Analysis:
	•	Sales trends, customer demographics, and operational insights.
	•	Business Insights:
	•	Customer behavior, category performance, and operational efficiency.

Deliverables
	•	SQL Queries: A comprehensive set of queries for analysis.
	•	Insights Report: Summarized findings for stakeholders.
	•	Actionable Recommendations:
	•	Optimize inventory for best-selling months and categories.
	•	Target high-value customers with loyalty programs.
	•	Align staffing with peak sales shifts.

Potential Extensions
	•	Real-Time Dashboards: Implement a live dashboard to track key metrics like sales and transactions.
	•	Predictive Analytics: Use machine learning to forecast sales trends.
	•	Customer Segmentation: Perform advanced segmentation for targeted marketing campaigns.

This project demonstrates advanced SQL skills, analytical capabilities, and business acumen, providing a solid foundation for a portfolio project in retail analytics.USE Portfolio_project;

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
