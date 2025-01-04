Portfolio Project: Zomato Order Analysis

Project Objective

This project aims to analyze Zomato’s order data to derive meaningful business insights. The analysis covers customer behavior, restaurant performance, monthly revenue growth, and popular food combinations, providing actionable recommendations to improve customer satisfaction, operational efficiency, and profitability.

Project Summary

Database Structure

The project uses the following tables:
	•	users: Customer information such as user ID and names.
	•	restaurants: Details of partner restaurants, including restaurant names and IDs.
	•	menu: Menu items offered by restaurants, including food IDs, names, and prices.
	•	food: Additional details about food items.
	•	orders: Order-level information, including order IDs, dates, amounts, and restaurant IDs.
	•	order_details: Detailed breakdown of each order, including food IDs and quantities.
	•	delivery_partner: Information about delivery personnel.

Analysis Breakdown

1. Identify Customers Who Have Never Ordered
	•	Objective: Find users registered on the platform who have not placed any orders.
	•	Approach:
	•	Compared the user list against the order history to isolate non-ordering users.
	•	Insight:
	•	Highlights potential customers for targeted marketing campaigns.

2. Average Price per Dish
	•	Objective: Calculate the average price of each dish across all restaurants.
	•	Approach:
	•	Aggregated price data from the menu table, grouped by food name.
	•	Insight:
	•	Helps in setting competitive pricing strategies and identifying premium dishes.

3. Top Restaurant by Orders in June
	•	Objective: Identify the restaurant with the highest number of orders in June.
	•	Approach:
	•	Filtered order data for June and ranked restaurants based on order counts.
	•	Insight:
	•	Recognizes top-performing restaurants during specific periods for partnership expansion or rewards.

4. Restaurants with High Monthly Sales
	•	Objective: Find restaurants with sales exceeding ₹1,000 in July.
	•	Approach:
	•	Filtered orders for July and aggregated sales by restaurant.
	•	Insight:
	•	Identifies high-performing restaurants and their sales trends.

5. Orders by a Specific User
	•	Objective: Retrieve order details for a specific user (Nitish) within a specific date range.
	•	Approach:
	•	Combined order and user data to filter based on user name and date.
	•	Insight:
	•	Demonstrates customer-specific order behavior, useful for personalization strategies.

6. Restaurants with Maximum Repeat Customers
	•	Objective: Identify restaurants with the most loyal repeat customers.
	•	Approach:
	•	Counted distinct orders per user for each restaurant and ranked by frequency.
	•	Insight:
	•	Highlights restaurants with high customer retention rates.

7. Month-over-Month (MoM) Revenue Growth
	•	Objective: Calculate Zomato’s overall revenue growth on a month-over-month basis.
	•	Approach:
	•	Used SQL window functions to compute revenue changes across months.
	•	Insight:
	•	Provides insights into platform growth trends and revenue seasonality.

8. Customer Favorite Food
	•	Objective: Identify the most frequently ordered food item for each customer.
	•	Approach:
	•	Used SQL ranking to determine favorite foods based on order frequency.
	•	Insight:
	•	Facilitates personalized food recommendations.

9. Most Loyal Customers per Restaurant
	•	Objective: Find the most loyal customer for each restaurant.
	•	Approach:
	•	Ranked customers based on order frequency at each restaurant.
	•	Insight:
	•	Enables tailored loyalty programs for frequent customers.

10. MoM Revenue Growth by Restaurant
	•	Objective: Analyze monthly revenue trends for individual restaurants.
	•	Approach:
	•	Used SQL window functions to calculate month-over-month revenue growth for each restaurant.
	•	Insight:
	•	Identifies growth opportunities and peak performance periods for restaurants.

11. Top Paired Food Items
	•	Objective: Find the most frequently paired food items in orders.
	•	Approach:
	•	Analyzed order details to identify and rank popular food item pairs.
	•	Insight:
	•	Supports cross-selling strategies by identifying complementary food pairings.

Key Skills and Tools Utilized
	•	SQL:
	•	Joins, subqueries, window functions, aggregate functions, and ranking functions.
	•	Complex queries for data extraction and trend analysis.
	•	Data Analysis:
	•	Customer behavior, restaurant performance, revenue growth, and product pairing trends.
	•	Business Insights:
	•	Revenue optimization, customer retention, and operational efficiency strategies.

Deliverables
	•	SQL Queries: A complete set of SQL queries for replicating the analysis.
	•	Insights Report: Summarized findings with actionable recommendations for stakeholders.
	•	Dashboard/Visuals: (Optional) Translate results into visual insights using Power BI or Tableau.

Potential Extensions
	•	Predictive Analytics: Use machine learning to predict future order trends and customer lifetime value.
	•	Real-Time Dashboards: Implement a live dashboard for tracking key metrics like revenue and orders.
	•	Advanced Segmentation: Cluster users based on ordering behavior for targeted marketing campaigns.

This portfolio project showcases advanced SQL skills and a deep understanding of e-commerce analytics, tailored for a business-critical domain.Zomato Order Analysis SQL Queries

USE `zomato order analysis`;

SELECT * FROM delivery_partner;
SELECT * FROM food;
SELECT * FROM menu;
SELECT * FROM order_details;
SELECT * FROM orders;
SELECT * FROM restaurants;
SELECT * FROM users;

-- ##Query1: Find customers who have never ordered.
SELECT 
    `name`
FROM
    users
WHERE
    user_id NOT IN (SELECT DISTINCT
            (user_id)
        FROM
            orders);

-- ##Query2: Average Price/dish
SELECT 
    f_name, AVG(price) AS average_price
FROM
    menu
        INNER JOIN
    food USING (f_id)
GROUP BY f_name;

-- ##Query3: Find the top restaurant in terms of the number of orders in June.
SELECT 
    r_name,
    MONTHNAME(o.date) AS monthnames,
    COUNT(r_id) AS counts
FROM
    orders o
        JOIN
    restaurants r USING (r_id)
WHERE
    MONTH(o.date) = 6
GROUP BY r_id
ORDER BY counts DESC
LIMIT 1;

-- ##Query4: Restaurants with monthly sales greater than 1000 for July.
SELECT 
    r_name AS Restaurant_name,
    r_id AS restaurant_id,
    SUM(amount) AS sales
FROM
    restaurants r
        JOIN
    orders o USING (r_id)
WHERE
    MONTHNAME(o.date) = 'july'
GROUP BY Restaurant_name
HAVING sales > 1000;

-- ##Query5: Show all orders with order details of Nitish (user_id = 1) from 10th June’22 to 10th July’22.
SELECT 
    *
FROM
    (SELECT 
        date AS order_date,
            name AS users,
            r_name AS restaurants,
            f_name AS food
    FROM
        order_details
    JOIN orders USING (order_id)
    JOIN restaurants USING (r_id)
    JOIN users USING (user_id)
    JOIN food USING (f_id)) a
WHERE
    users = 'nitish'
        AND order_date BETWEEN '2022-06-10' AND '2022-07-10';

-- ##Query6: Find restaurants with maximum repeat customers.
SELECT 
    r_id, r_name, COUNT(*) AS counts, SUM(order_counts)
FROM
    (SELECT 
        r_id,
            user_id,
            COUNT(user_id) counts,
            COUNT(DISTINCT (order_id)) AS order_counts
    FROM
        orders
    GROUP BY r_id , user_id
    HAVING order_counts > 1) a
        JOIN
    restaurants USING (r_id)
GROUP BY r_name
ORDER BY counts DESC
LIMIT 1;

-- ##Query7: Month-over-month revenue growth of Zomato.
SELECT 
    month, revenue, CONCAT(ROUND(((revenue - prerevenue) / prerevenue) * 100, 2), "%") AS MOM_revenue_percentage 
FROM 
    (SELECT 
        MONTH(date) AS month, SUM(amount) AS revenue, 
        LAG(SUM(amount)) OVER (ORDER BY MONTH(date)) AS prerevenue 
     FROM 
         orders o 
     GROUP BY month 
     ORDER BY month) a;

-- ##Query8: Customer — favorite food.
SELECT 
    name, f_name, counts 
FROM
    (SELECT 
        user_id, f_id, COUNT(*) AS counts, 
        DENSE_RANK() OVER (PARTITION BY user_id ORDER BY COUNT(*) DESC) AS ranks 
     FROM 
         orders 
     JOIN order_details USING (order_id) 
     GROUP BY f_id, user_id) a 
JOIN users USING (user_id) 
JOIN food USING (f_id) 
WHERE ranks = 1;

-- ##Query9: Find the most loyal customers for all restaurants.
SELECT 
    *, name 
FROM 
    (SELECT 
        r_name AS restaurant_name, user_id, r_id, COUNT(*), 
        RANK() OVER (PARTITION BY r_id ORDER BY COUNT(*) DESC) AS ranks 
     FROM 
         orders 
     JOIN restaurants USING (r_id) 
     GROUP BY user_id, r_id) a 
JOIN users USING (user_id) 
WHERE ranks = 1;

-- ##Query10: Month-over-month revenue growth of each restaurant.
SELECT 
    R_NAME, monthname, 
    ROUND(((sales - prerevenue) / prerevenue) * 100, 2) AS MOM_revenue_percentage 
FROM 
    (SELECT 
        date, r_name, r_id, MONTHNAME(date) AS monthname, 
        SUM(amount) AS sales, 
        LAG(SUM(amount)) OVER (PARTITION BY r_name ORDER BY MONTH(date)) AS prerevenue 
     FROM 
         orders 
     JOIN restaurants USING (r_id) 
     GROUP BY r_name, monthname) a;

-- ##Query11: Top 3 most paired products.
SELECT 
    *, COUNT(od.order_id) pair_count 
FROM 
    order_details od 
        JOIN 
    order_details od1 USING (order_id) 
        JOIN 
    food f1 ON od.f_id = f1.f_id 
        JOIN 
    food f2 ON od1.f_id = f2.f_id 
WHERE 
    od.f_id < od1.f_id 
GROUP BY 
    f1.f_name, f2.f_name, order_id 
ORDER BY 
    pair_count DESC 
LIMIT 3;


