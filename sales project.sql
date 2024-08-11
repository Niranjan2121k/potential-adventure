select * from order_list;
select * from order_details;
select * from sales_target;
alter table order_list change `order id` order_id varchar(25);
##Query 1: The marketing department is running a sales campaign and they target the customer with different sales materials. 
##They categorized customers into groups based on the RFM model. Show the number and percentage for each customer segment as the final result. 
##Order the results by the percentage of customers.
create view combined_orders as select d.order_id,d.amount,d.profit,d.quantity,d.category,d.sub_category,l.order_date,l.customername,l.state,l.city 
from order_details d inner join order_list l using(order_id);
select * from combined_orders;
drop view customer_grouping;
create VIEW customer_grouping AS SELECT *, CASE WHEN (R>=4 AND R<=5) AND (((F+M)/2) >= 4 AND ((F+M)/2) <= 5) THEN 'Champions'
												WHEN (R>=2 AND R<=5) AND (((F+M)/2) >= 3 AND ((F+M)/2) <= 5) THEN 'Loyal Customers'
												WHEN (R>=3 AND R<=5) AND (((F+M)/2) >= 1 AND ((F+M)/2) <= 3) THEN 'Potential Loyalist'
												WHEN (R>=4 AND R<=5) AND (((F+M)/2) >= 0 AND ((F+M)/2) <= 1) THEN 'New Customers'
												WHEN (R>=3 AND R<=4) AND (((F+M)/2) >= 0 AND ((F+M)/2) <= 1) THEN 'Promising'
												WHEN (R>=2 AND R<=3) AND (((F+M)/2) >= 2 AND ((F+M)/2) <= 3) THEN 'Customers Needing Attention'
												WHEN (R>=2 AND R<=3) AND (((F+M)/2) >= 0 AND ((F+M)/2) <= 2) THEN 'About to Sleep'
												WHEN (R>=0 AND R<=2) AND (((F+M)/2) >= 2 AND ((F+M)/2) <= 5) THEN 'At Risk'
												WHEN (R>=0 AND R<=1) AND (((F+M)/2) >= 4 AND ((F+M)/2) <= 5) THEN "Can't Lost Them"
												WHEN (R>=1 AND R<=2) AND (((F+M)/2) >= 1 AND ((F+M)/2) <= 2) THEN 'Hibernating'
												WHEN (R>=0 AND R<=2) AND (((F+M)/2) >= 0 AND ((F+M)/2) <= 2) THEN 'Lost'
                                                END AS customer_segment
from 
(select max(str_to_date(order_date,"%d-%m-%Y")) as Latest_order_date,customername,
datediff(str_to_date("31-03-2019","%d-%m-%Y"),max(str_to_date(order_date,"%d-%m-%Y"))) as recency,
count(distinct(order_id)) as Frequency,
sum(amount) as monetary,
ntile(5) over (order by datediff(str_to_date("31-03-2019","%d-%m-%Y"),max(str_to_date(order_date,"%d-%m-%Y")))desc) as R,
ntile(5) over (order by count(distinct(order_id))asc) as F,
ntile(5) over (order by sum(amount)asc) as M 
from combined_orders group by customername) rfm_table group by customername;
select * from customer_grouping;
SELECT 
    MAX(STR_TO_DATE(order_date, '%d-%m-%Y')) AS Latest_order_date
FROM
    combined_orders;
SELECT 
    customer_segment,
    COUNT(DISTINCT (customername)) AS num_of_customers,
    ROUND(COUNT(DISTINCT (customername)) / (SELECT 
                    COUNT(*)
                FROM
                    customer_grouping) * 100,
            2) AS pct_of_customers
FROM
    customer_grouping
GROUP BY customer_segment
ORDER BY pct_of_customers DESC;
select * from combined_orders;
select * from customer_grouping;


##Query 2: Find the number of orders, customers, cities, and states.
SELECT 
    COUNT(DISTINCT (order_id)) AS num_of_orders,
    COUNT(DISTINCT (customername)) AS num_of_customers,
    COUNT(DISTINCT (city)) AS num_of_cities,
    COUNT(DISTINCT (state)) AS num_of_states
FROM
    combined_orders;


##Query 3: Find the new customers who made purchases in the year 2019. Only shows the top 5 new customers and their respective cities and states. 
##Order the result by the amount they spent.
SELECT 
    customername, state, city, SUM(amount) AS sales
FROM
    combined_orders
WHERE
    customername NOT IN (SELECT 
            customername
        FROM
            combined_orders
        WHERE
            YEAR(STR_TO_DATE(order_date, '%d-%m-%Y')) = 2018)
GROUP BY customername , state , city
ORDER BY sales DESC
LIMIT 5;



##Query 4: Find the top 10 profitable states & cities so that the company can expand its business. 
##Determine the number of products sold and the number of customers in these top 10 profitable states & cities.
SELECT 
    state,
    city,
    COUNT(DISTINCT (customername)) AS num_of_customers,
    SUM(profit) AS profit,
    SUM(quantity) AS total_quantity
FROM
    combined_orders
GROUP BY state , city
ORDER BY profit DESC
LIMIT 10;



##Query 5: Display the details (in terms of “order_date”, “order_id”, “State”, and “CustomerName”) for the first order in each state. Order the result by “order_id”.
select order_date,order_id,state,customername from(select *,row_number() over(partition by state order by order_id) as rownumber 
from combined_orders)a where rownumber=1 order by order_id;


##Query 6: Determine the number of orders (in the form of a histogram) and sales for different days of the week.
SELECT 
    day_of_order,
    LPAD('+', num_of_orders, '+') AS num_of_orders,
    sales
FROM
    (SELECT 
        DAYNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) AS day_of_order,
            COUNT(DISTINCT (order_id)) AS num_of_orders,
            SUM(amount) AS sales
    FROM
        combined_orders
    GROUP BY day_of_order) a
ORDER BY sales DESC;


##Query 7: Check the monthly profitability and monthly quantity sold to see if there are patterns in the dataset.
SELECT 
    CONCAT(MONTHNAME(STR_TO_DATE(order_date, '%d-%m-%Y')),
            '-',
            YEAR(STR_TO_DATE(order_date, '%d-%m-%Y'))) AS month_of_year,
    SUM(profit) AS total_profit,
    SUM(quantity) AS total_quantity
FROM
    combined_orders
GROUP BY month_of_year
ORDER BY month_of_year = 'april-2018' DESC , month_of_year = 'may-2018' DESC , month_of_year = 'june-2018' DESC , month_of_year = 'july-2018' DESC , month_of_year = 'august-2018' DESC , month_of_year = 'september-2018' DESC , month_of_year = 'october-2018' DESC , month_of_year = 'november-2018' DESC , month_of_year = 'december-2018' DESC , month_of_year = 'january-2019' DESC , month_of_year = 'february-2019' DESC , month_of_year = 'march-2019' DESC;


##Query 8: Determine the number of times that salespeople hit or failed to hit the sales target for each category.
CREATE VIEW sales_by_category AS
    SELECT 
        CONCAT(SUBSTR(MONTHNAME(STR_TO_DATE(order_date, '%d-%m-%Y')),
                    1,
                    3),
                '-',
                SUBSTR(YEAR(STR_TO_DATE(order_date, '%d-%m-%Y')),
                    3,
                    2)) AS order_monthyear,
        Category,
        SUM(Amount) AS Sales
    FROM
        combined orders
    GROUP BY order_monthyear , category;
select * from sales_by_category;
 CREATE VIEW sstarget AS
    SELECT 
        sales, t.category, order_monthyear, target
    FROM
        sales_by_category s
            INNER JOIN
        sales_target t ON s.category = t.category
            AND order_monthyear = month_of_order_date;
select * from sstarget;
CREATE VIEW targetstatus AS
    SELECT 
        *,
        CASE
            WHEN sales >= target THEN 'hit'
            ELSE 'fail'
        END AS Hit_or_fail
    FROM
        sstarget;
SELECT 
    category,
    SUM(IF(hit_or_fail = 'hit', 1, 0)) AS hit_count,
    SUM(IF(hit_or_fail = 'fail', 1, 0)) AS fail_count
FROM
    targetstatus
GROUP BY category;


##Query 9: Find the total sales, total profit, and total quantity sold for each category and sub-category. 
##Return the maximum cost and maximum price for each sub-category too.
CREATE VIEW totals AS
    SELECT 
        category,
        sub_category,
        SUM(amount) AS totalamount,
        SUM(profit) AS totalprofit,
        SUM(quantity) AS totalqnt
    FROM
        order_details
    GROUP BY category , sub_category;
CREATE VIEW max AS
    SELECT 
        category,
        sub_category,
        ROUND((amount - profit) / quantity, 2) AS cost,
        ROUND(amount / quantity, 2) AS price
    FROM
        order_details
    GROUP BY category , sub_category , cost , price;
SELECT 
    category,
    sub_category,
    totalamount,
    totalprofit,
    totalqnt,
    MAX(cost) AS maxcost,
    MAX(price) AS maxprice
FROM
    (SELECT 
        t.category AS category,
            t.sub_category AS sub_category,
            totalamount,
            totalprofit,
            totalqnt,
            ROUND((amount - profit) / quantity, 2) AS cost,
            ROUND(amount / quantity, 2) AS price
    FROM
        totals t
    INNER JOIN order_details o ON t.category = o.category
        AND t.sub_category = o.sub_category) a
GROUP BY category , sub_category
ORDER BY totalprofit DESC;
