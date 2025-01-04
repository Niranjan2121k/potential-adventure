Portfolio Project: E-Commerce Sales and Marketing Analysis

Project Objective:

The primary goal of this project is to provide a comprehensive analysis of an e-commerce business’s sales and marketing performance using SQL. This analysis involves customer segmentation, profitability insights, sales trends, and sales target achievement. Through the application of data analytics, businesses can make data-driven decisions for growth and expansion.

Project Summary
	1.	Database Structure:
	•	The project involves three main tables:
	•	order_list: Contains order metadata such as order dates and customer information.
	•	order_details: Details of the orders, including category, sub-category, profit, quantity, and amount.
	•	sales_target: Monthly sales targets for different product categories.
	•	Tables were joined, and columns were reformatted to create a cohesive and analyzable dataset.

Analysis Breakdown

1. Customer Segmentation with the RFM Model
	•	Objective: Group customers based on their Recency (R), Frequency (F), and Monetary (M) values to tailor marketing campaigns.
	•	Process:
	•	Calculated RFM metrics for each customer.
	•	Assigned RFM scores using SQL window functions.
	•	Categorized customers into segments like “Champions,” “Loyal Customers,” “At Risk,” and “Lost.”
	•	Insights:
	•	Percentage breakdown of customer segments to identify high-value and dormant customers.

2. Market Coverage Analysis
	•	Objective: Understand the business’s geographical and demographic reach.
	•	Key Metrics:
	•	Total orders, unique customers, cities, and states served.
	•	Insights:
	•	Highlights the breadth of the business’s customer base and potential regions for expansion.

3. Top 5 New Customers in 2019
	•	Objective: Identify new customers with significant sales contributions.
	•	Process:
	•	Excluded customers with purchases in previous years.
	•	Sorted new customers by total sales in 2019.
	•	Insights:
	•	Key new customers for targeted retention strategies.

4. Profitability by Location
	•	Objective: Identify the top 10 most profitable cities and states for potential expansion.
	•	Process:
	•	Aggregated profit and quantity data by state and city.
	•	Ranked locations based on profitability.
	•	Insights:
	•	A roadmap for focusing marketing efforts on high-performing regions.

5. First Order Analysis by State
	•	Objective: Explore early adopters in each state to study buying behavior.
	•	Process:
	•	Used SQL window functions to rank orders by state and date.
	•	Insights:
	•	Found key trends in early customers’ orders.

6. Sales Trends by Day of the Week
	•	Objective: Understand how sales and order volume vary across days of the week.
	•	Process:
	•	Analyzed orders and sales by day using SQL date functions.
	•	Insights:
	•	Identification of peak sales days to optimize marketing campaigns.

7. Monthly Profitability and Quantity Trends
	•	Objective: Explore seasonal sales patterns and profitability trends.
	•	Process:
	•	Analyzed monthly profitability and quantity sold.
	•	Insights:
	•	Data-driven strategies for inventory management and marketing during peak seasons.

8. Sales Target Analysis
	•	Objective: Evaluate whether sales targets were achieved across categories.
	•	Process:
	•	Compared actual sales with targets and categorized months as “hit” or “fail.”
	•	Insights:
	•	Identified consistent and underperforming categories for strategic improvement.

9. Category and Sub-Category Analysis
	•	Objective: Analyze sales, profit, cost, and price trends across product categories and sub-categories.
	•	Process:
	•	Aggregated data to calculate total sales, profit, and quantity.
	•	Calculated maximum cost and price per category.
	•	Insights:
	•	Key products driving profitability and areas to optimize pricing.

Key Skills and Tools Utilized
	•	SQL:
	•	Joins, window functions, subqueries, views, and aggregate functions.
	•	RFM segmentation, date manipulation, and statistical calculations.
	•	Data Analysis:
	•	Segmentation, trend analysis, and profitability evaluation.
	•	Business Insights:
	•	Data-driven strategies for customer retention, expansion, and sales optimization.

Deliverables
	•	SQL Queries: Comprehensive scripts covering all aspects of the analysis.
	•	Dashboards/Visuals: (Optional) Convert the findings into visual insights using tools like Tableau, Power BI, or Excel.
	•	Report: Summarized insights for stakeholders with actionable recommendations.

Potential Extensions
	•	Predictive Analytics: Implement machine learning models for customer lifetime value (CLV) predictions.
	•	Interactive Dashboards: Real-time tracking of key metrics.
	•	Advanced Segmentation: Use clustering techniques for deeper customer insights.

This portfolio project highlights SQL’s power in driving actionable insights for business growth.Initial Setup Queries
SELECT * FROM order_list;
SELECT * FROM order_details;
SELECT * FROM sales_target;

ALTER TABLE order_list 
CHANGE `order id` order_id VARCHAR(25);


Query 1: RFM Customer Segmentation
## Marketing Campaign Analysis: Categorize customers based on RFM model
CREATE VIEW combined_orders AS 
SELECT d.order_id, d.amount, d.profit, d.quantity, d.category, d.sub_category, 
       l.order_date, l.customername, l.state, l.city 
FROM order_details d 
INNER JOIN order_list l USING(order_id);

SELECT * FROM combined_orders;

DROP VIEW IF EXISTS customer_grouping;

CREATE VIEW customer_grouping AS 
SELECT *, 
       CASE 
           WHEN (R >= 4 AND R <= 5) AND (((F + M) / 2) >= 4 AND ((F + M) / 2) <= 5) THEN 'Champions'
           WHEN (R >= 2 AND R <= 5) AND (((F + M) / 2) >= 3 AND ((F + M) / 2) <= 5) THEN 'Loyal Customers'
           WHEN (R >= 3 AND R <= 5) AND (((F + M) / 2) >= 1 AND ((F + M) / 2) <= 3) THEN 'Potential Loyalist'
           WHEN (R >= 4 AND R <= 5) AND (((F + M) / 2) >= 0 AND ((F + M) / 2) <= 1) THEN 'New Customers'
           WHEN (R >= 3 AND R <= 4) AND (((F + M) / 2) >= 0 AND ((F + M) / 2) <= 1) THEN 'Promising'
           WHEN (R >= 2 AND R <= 3) AND (((F + M) / 2) >= 2 AND ((F + M) / 2) <= 3) THEN 'Customers Needing Attention'
           WHEN (R >= 2 AND R <= 3) AND (((F + M) / 2) >= 0 AND ((F + M) / 2) <= 2) THEN 'About to Sleep'
           WHEN (R >= 0 AND R <= 2) AND (((F + M) / 2) >= 2 AND ((F + M) / 2) <= 5) THEN 'At Risk'
           WHEN (R >= 0 AND R <= 1) AND (((F + M) / 2) >= 4 AND ((F + M) / 2) <= 5) THEN "Can't Lose Them"
           WHEN (R >= 1 AND R <= 2) AND (((F + M) / 2) >= 1 AND ((F + M) / 2) <= 2) THEN 'Hibernating'
           WHEN (R >= 0 AND R <= 2) AND (((F + M) / 2) >= 0 AND ((F + M) / 2) <= 2) THEN 'Lost'
       END AS customer_segment
FROM (
    SELECT MAX(STR_TO_DATE(order_date, "%d-%m-%Y")) AS Latest_order_date, customername,
           DATEDIFF(STR_TO_DATE("31-03-2019", "%d-%m-%Y"), MAX(STR_TO_DATE(order_date, "%d-%m-%Y"))) AS recency,
           COUNT(DISTINCT(order_id)) AS Frequency,
           SUM(amount) AS monetary,
           NTILE(5) OVER (ORDER BY DATEDIFF(STR_TO_DATE("31-03-2019", "%d-%m-%Y"), MAX(STR_TO_DATE(order_date, "%d-%m-%Y"))) DESC) AS R,
           NTILE(5) OVER (ORDER BY COUNT(DISTINCT(order_id)) ASC) AS F,
           NTILE(5) OVER (ORDER BY SUM(amount) ASC) AS M
    FROM combined_orders 
    GROUP BY customername
) rfm_table;

SELECT * FROM customer_grouping;

## Summary of Customer Segments
SELECT customer_segment,
       COUNT(DISTINCT customername) AS num_of_customers,
       ROUND(COUNT(DISTINCT customername) / (SELECT COUNT(*) FROM customer_grouping) * 100, 2) AS pct_of_customers
FROM customer_grouping
GROUP BY customer_segment
ORDER BY pct_of_customers DESC;

Query 2: Orders, Customers, Cities, and States
## Find the number of orders, customers, cities, and states
SELECT COUNT(DISTINCT order_id) AS num_of_orders,
       COUNT(DISTINCT customername) AS num_of_customers,
       COUNT(DISTINCT city) AS num_of_cities,
       COUNT(DISTINCT state) AS num_of_states
FROM combined_orders;

Query 3: Top 5 New Customers in 2019
## Find new customers who made purchases in 2019
SELECT customername, state, city, SUM(amount) AS sales
FROM combined_orders
WHERE customername NOT IN (
    SELECT customername 
    FROM combined_orders 
    WHERE YEAR(STR_TO_DATE(order_date, '%d-%m-%Y')) = 2018
)
GROUP BY customername, state, city
ORDER BY sales DESC
LIMIT 5;

Query 4: Top 10 Profitable States and Cities
## Top 10 profitable states & cities for expansion
SELECT state, city,
       COUNT(DISTINCT customername) AS num_of_customers,
       SUM(profit) AS profit,
       SUM(quantity) AS total_quantity
FROM combined_orders
GROUP BY state, city
ORDER BY profit DESC
LIMIT 10;

Query 5: First Order in Each State
## First order details in each state
SELECT order_date, order_id, state, customername
FROM (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY state ORDER BY order_id) AS rownumber 
    FROM combined_orders
) a
WHERE rownumber = 1
ORDER BY order_id;

Query 6: Orders and Sales by Day of the Week
## Histogram: Orders and sales by day of the week
SELECT day_of_order,
       LPAD('+', num_of_orders, '+') AS num_of_orders,
       sales
FROM (
    SELECT DAYNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) AS day_of_order,
           COUNT(DISTINCT order_id) AS num_of_orders,
           SUM(amount) AS sales
    FROM combined_orders
    GROUP BY day_of_order
) a
ORDER BY sales DESC;

Query 7: Monthly Profitability and Quantity Patterns
## Monthly profitability and quantity sold
SELECT CONCAT(MONTHNAME(STR_TO_DATE(order_date, '%d-%m-%Y')), '-', YEAR(STR_TO_DATE(order_date, '%d-%m-%Y'))) AS month_of_year,
       SUM(profit) AS total_profit,
       SUM(quantity) AS total_quantity
FROM combined_orders
GROUP BY month_of_year
ORDER BY FIELD(month_of_year, 'April-2018', 'May-2018', ..., 'March-2019');

Query 8: Sales Target Analysis
## Sales target performance by category
CREATE VIEW sales_by_category AS
SELECT CONCAT(SUBSTR(MONTHNAME(STR_TO_DATE(order_date, '%d-%m-%Y')), 1, 3), '-', SUBSTR(YEAR(STR_TO_DATE(order_date, '%d-%m-%Y')), 3, 2)) AS order_monthyear,
       Category,
       SUM(Amount) AS Sales
FROM combined_orders
GROUP BY order_monthyear, category;

CREATE VIEW sstarget AS
SELECT sales, t.category, order_monthyear, target
FROM sales_by_category s
INNER JOIN sales_target t 
    ON s.category = t.category AND order_monthyear = month_of_order_date;

CREATE VIEW targetstatus AS
SELECT *, 
       CASE WHEN sales >= target THEN 'hit' ELSE 'fail' END AS Hit_or_fail
FROM sstarget;

SELECT category,
       SUM(IF(hit_or_fail = 'hit', 1, 0)) AS hit_count,
       SUM(IF(hit_or_fail = 'fail', 1, 0)) AS fail_count
FROM targetstatus
GROUP BY category;

Query 9: Total Sales, Profit, and Quantity by Category and Sub-Category
## Sales, profit, quantity, cost, and price analysis
CREATE VIEW totals AS
SELECT category, sub_category,
       SUM(amount) AS totalamount,
       SUM(profit) AS totalprofit,
       SUM(quantity) AS totalqnt
FROM order_details
GROUP BY category, sub_category;

CREATE VIEW max AS
SELECT category, sub_category,
       ROUND((amount - profit) / quantity, 2) AS cost,
       ROUND(amount / quantity, 2) AS price
FROM order_details
GROUP BY category, sub_category, cost, price;

SELECT category, sub_category,
       totalamount, totalprofit, totalqnt,
       MAX(cost) AS maxcost,
       MAX(price) AS maxprice
FROM (
    SELECT t.category AS category,
           t.sub_category AS sub_category,
           totalamount, totalprofit, totalqnt,
           ROUND((amount - profit) / quantity, 2) AS cost,
           ROUND(amount / quantity, 2) AS price
    FROM totals t
    INNER JOIN order_details o 
        ON t.category = o.category AND t.sub_category = o.sub_category
) a
GROUP BY category, sub_category
ORDER BY totalprofit DESC;

