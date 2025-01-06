Walmart Sales Analysis Portfolio

Objective

To analyze Walmart’s sales data and derive actionable insights to enhance operational efficiency, customer satisfaction, and profitability across branches. The goal is to explore transaction patterns, branch performance, and regional sales trends to provide data-driven recommendations.

Dataset Review

The dataset contains transactional information from Walmart, including:
	•	Branch: Identifies store locations.
	•	Category: Product categories sold.
	•	Date and Time: Records the date and time of transactions.
	•	Payment Method: Details payment types used.
	•	Rating: Customer ratings for products or services.
	•	Total: Revenue generated per transaction.
	•	Profit Margin: Indicates profit percentages for products.
	•	Quantity: Number of items sold per transaction.

The dataset spans multiple years, enabling trend and year-over-year analysis.

Analysis Breakdown
	1.	Transaction Patterns by Payment Method
	•	Counted transactions for each payment method to identify their usage frequency.
	2.	Highest-Rated Categories per Branch
	•	Evaluated average customer ratings for each category in every branch.
	•	Identified the best-performing category for each branch.
	3.	Busiest Day per Branch
	•	Determined the day with the highest number of transactions for each branch.
	•	Insights help allocate resources and optimize staffing schedules.
	4.	Quantity of Items Sold by Payment Method
	•	Analyzed item quantity sold via each payment method to understand preferences.
	5.	City-Specific Category Ratings
	•	Calculated average, minimum, and maximum ratings for categories within each city.
	•	Revealed regional variations in customer satisfaction.
	6.	Profitability Analysis by Category
	•	Assessed total profit contributions from each product category based on profit margins.
	7.	Most Common Payment Methods per Branch
	•	Identified the preferred payment method for each branch to align with customer preferences.
	8.	Sales Distribution by Shift
	•	Categorized transactions into Morning, Afternoon, and Evening shifts.
	•	Pinpointed the busiest shifts for targeted marketing and promotions.
	9.	Revenue Decline Analysis
	•	Compared branch-level revenues between 2022 and 2023.
	•	Highlighted branches with the most significant revenue decline for further investigation.

Deliverables
	•	Insights and Findings
	•	Popular payment methods across branches.
	•	Categories with the highest ratings per branch.
	•	Busiest days and shifts for operational planning.
	•	High-profit categories for strategic promotion and restocking.
	•	Regional customer satisfaction trends.
	•	Recommendations
	•	Promote the highest-rated categories in underperforming branches.
	•	Focus on high-demand payment methods for smoother transactions.
	•	Optimize resources based on peak transaction times.
	•	Investigate and address revenue decline in identified branches.

Possible Extensions
	1.	Customer Demographics Analysis
	•	Incorporate demographic data to personalize marketing campaigns.
	2.	Dynamic Pricing Models
	•	Use insights to create region or time-specific pricing strategies.
	3.	Forecasting Trends
	•	Apply machine learning models to predict future sales and trends.
	4.	Product Bundling Opportunities
	•	Identify complementary products for effective bundling strategies.
	5.	Sustainability Efforts
	•	Analyze operational efficiencies to reduce waste and improve sustainability.

This portfolio illustrates the power of leveraging transactional data to drive actionable insights and highlights opportunities for Walmart to enhance its customer service and operational strategy.
  USE projects;

SELECT * 
FROM walmart;

-- Count payment methods and number of transactions by payment method
SELECT 
    payment_method, 
    COUNT(invoice_id) CNT
FROM
    walmart
GROUP BY 1
ORDER BY 2;

-- Identify the highest-rated category in each branch
WITH cte AS (
    SELECT 
        branch, 
        category, 
        AVG(rating) AS avg_rating
    FROM walmart
    GROUP BY branch, category
),
cte2 AS (
    SELECT 
        branch, 
        category, 
        avg_rating,
        RANK() OVER (PARTITION BY branch ORDER BY avg_rating DESC) AS rnk
    FROM cte
)
SELECT 
    cte2.branch, 
    cte2.category, 
    avg_rating
FROM cte2
WHERE rnk = 1;

-- Identify the busiest day for each branch based on the number of transactions
WITH cte AS (
    SELECT 
        branch,
        DAYNAME(date) AS day_name,
        COUNT(*) AS day_count
    FROM walmart
    GROUP BY branch, day_name
),
cte2 AS (
    SELECT 
        branch,
        day_name,
        day_count,
        RANK() OVER (PARTITION BY branch ORDER BY day_count DESC) AS rnk
    FROM cte
)
SELECT 
    branch,
    day_name,
    day_count
FROM cte2
WHERE rnk = 1;

-- Calculate the total quantity of items sold per payment method
SELECT 
    payment_method, 
    SUM(quantity)
FROM
    walmart
GROUP BY 1;

-- Determine the average, minimum, and maximum rating of categories for each city
SET SESSION sql_mode = (SELECT REPLACE(@@sql_mode, "ONLY_FULL_GROUP_BY", ""));

SELECT 
    city,
    category,
    AVG(rating) AS Avg_rating,
    MIN(rating) AS mIn_rating,
    MAX(rating) AS max_rating
FROM
    walmart
GROUP BY 1, 2
ORDER BY 1;

-- Calculate the total profit for each category
SELECT 
    category, 
    ROUND(SUM((total) * profit_margin), 2)
FROM
    walmart
GROUP BY category
ORDER BY 2 DESC;

-- Determine the most common payment method for each branch
SELECT 
    branch, 
    payment_method, 
    ct 
FROM (
    SELECT 
        branch, 
        payment_method, 
        COUNT(payment_method) AS ct, 
        ROW_NUMBER() OVER (PARTITION BY branch ORDER BY COUNT(payment_method) DESC) AS rnk  
    FROM walmart 
    GROUP BY branch, payment_method 
    ORDER BY branch
) a
WHERE rnk = 1;

-- Categorize sales into Morning, Afternoon, and Evening shifts
SELECT 
    Branch,
    CASE
        WHEN HOUR(TIME(time)) < 12 THEN 'Morning'
        WHEN HOUR(TIME(time)) BETWEEN 12 AND 17 THEN 'Afternoon'
        WHEN HOUR(TIME(time)) > 17 THEN 'Evening'
    END AS Shift,
    COUNT(*) AS noi
FROM
    walmart
GROUP BY 1, 2
ORDER BY 1, 3 DESC;

-- Identify the 5 branches with the highest revenue decrease ratio from last year to current year (e.g., 2022 to 2023)
WITH cte AS (
    SELECT 
        branch,
        SUM(total) s1 
    FROM walmart 
    WHERE YEAR(date) = 2022 
    GROUP BY 1 
    ORDER BY 2 DESC
),
cte2 AS (
    SELECT 
        branch,
        SUM(total) s2 
    FROM walmart 
    WHERE YEAR(date) = 2023 
    GROUP BY 1 
    ORDER BY 2 DESC
)
SELECT 
    cte.branch, 
    ROUND(((s1 - s2) / s1) * 100, 2) AS ratio
FROM
    cte,
    cte2
WHERE
    cte.branch = cte2.branch 
    AND s1 > s2
ORDER BY 2 DESC
LIMIT 5;
