use `zomato order analysis`;
select * from delivery_partner;
select * from food;
select * from menu;
select * from order_details;
select * from orders;
select * from restaurants;
select * from users;

##Query1: Find customers who have never ordered.
SELECT 
    `name`
FROM
    users
WHERE
    user_id NOT IN (SELECT DISTINCT
            (user_id)
        FROM
            orders);

##Query2: Average Price/dish
SELECT 
    f_name, AVG(price) AS average_price
FROM
    menu
        INNER JOIN
    food USING (f_id)
GROUP BY f_name;

##Query3: Find the top restaurant in terms of the number of orders in June.
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

##Query 4: Restaurants with monthly sales greater than 1000 for July.
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

##Query5: Show all orders with order details of Nitish (user_id = 1) from 10th June’22 to 10th July’22.
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

##Query6: Find restaurants with maximum repeat customers.
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
 
 
##Query7: Month-over-month revenue growth of Zomato.
select month,revenue,concat(round(((revenue-prerevenue)/prerevenue)*100,2),"%") as MOM_revenue_percentage from(select month(date) as month,sum(amount) as revenue,lag(sum(amount))over(order by month(date)) as prerevenue from orders o group by month order by month)a;


##Query8: Customer — favorite food.
select name,f_name,counts from
(select user_id,f_id,count(*) as counts,dense_rank()over(partition by user_id order by count(*)desc) as ranks 
from orders join order_details using (order_id) group by f_id,user_id)a join users using(user_id) join food using(f_id) where ranks = 1;


##Query9: Find the most loyal customers for all restaurants.
select *,name from (select r_name as restaurant_name,user_id,r_id,count(*),rank()over (partition by r_id order by count(*) desc) as ranks from orders join restaurants using(r_id) group by user_id,r_id)a join users using(user_id) where ranks=1;


##Query10: Month-over-month revenue growth of each restaurant.
SELECT R_NAME,monthname,round(((sales-prerevenue)/prerevenue)*100,2)as MOM_revenue_percentage from (select date,r_name,r_id,monthname(date) as monthname,sum(amount) as sales,lag(sum(amount))over (partition by r_name order by month(date))as prerevenue from orders join restaurants using(r_id) group by r_name,monthname)a;


##Query11:Top 3 most paired products.
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
GROUP BY f1.f_name ,f2.f_name,order_id order by pair_count desc limit 3;


