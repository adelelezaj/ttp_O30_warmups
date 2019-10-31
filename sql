-- 1) Download and install the northwind database - northwind.sql - from here (https://github.com/pthom/northwind_psql)
-- install the database from:
-- Mac terminal: 
-- >> navigate to your download folder
-- >> type: createdb northwind -U postgres
-- >> type: psql northwind < northwind.sql
-- Windows:
-- >> We'll have to figure it out :) 

-- Once installed, run the query below (in psql or pgadmin4)

SELECT p.product_id, o.order_id, p.unit_price, od.quantity
FROM orders as o
JOIN order_details as od ON o.order_id = od.order_id
JOIN products as p ON p.product_id = od.product_id;

-- 2) Look at the query results, and modify the above query to get the order totals for each order.
-- IMPORTANT: Note that each order is broken up into multiple rows, so you'll need to group by order_id
-- ALSO IMPORTANT: You have to do some math here. How do you get the order total? You'll have to 
-- multiply the unit_price column by the quanity column, then SUM over each order_id

with order_details as (
    SELECT p.product_id, o.order_id, p.unit_price, od.quantity
    FROM orders as o
    JOIN order_details as od ON o.order_id = od.order_id
    JOIN products as p ON p.product_id = od.product_id
    )
SELECT order_id, SUM(unit_price* quantity) as order_total
FROM order_details
GROUP BY 1
ORDER BY 1;

SELECT p.product_id, o.order_id, p.unit_price, od.quantity
FROM orders as o
JOIN order_details as od ON o.order_id = od.order_id
JOIN products as p ON p.product_id = od.product_id;
-- 3) Use the above query as a CTE, and use AVG, stddev_samp, and COUNT, to get the mean, standard deviation
-- of the orders, and how many orders there are total.

with order_details as (
    SELECT p.product_id, o.order_id, p.unit_price, od.quantity
    FROM orders as o
    JOIN order_details as od ON o.order_id = od.order_id
    JOIN products as p ON p.product_id = od.product_id
    ),
order_info as (
SELECT order_id, SUM(unit_price* quantity) as order_total
FROM order_details
GROUP BY 1
ORDER BY 1)
SELECT count(order_id) as number_of_orders,
avg(order_total) as average, 
stddev_samp(order_total) as standard_deviation
FROM order_info;


-- 4) The CEO of your company announced the other week that the company's long run average sales per order is 
-- $1850! Do you believe him? Assuming the data in this database is only a subset of all the sales
-- (and that this database is a good representation of all of the other sales databases for the company)
-- Set up a hypothesis test based on suspicion that he's exaggerating. IE. we're going to try to give compelling evidence
-- that the sales are less than $1850.
-- You want to bring this up to your boss ONLY if you really sure, like 95% sure.

*Claim: Company's long run average is $1850.*


-- Use the results of the last query to do this in excel.
-- What's the null hypothesis?
* H0: mu <= $1850 *
-- What's the alternative hypothesis? 
* HA: mu > $1850 *
-- What's the significance level? 
* 5 % *
-- Is this a one or two tail test? 
* One tailed *
-- What's the standard error for our sample?
* 73.9 *
-- What's the cutoff threshold for your decision?
* 1728.42 *
-- What's your p value?
* 0.079 *
-- WHat's your conclusion?
*  Conclusion: Since p_value > significance level, we fail to reject the null Hypothesis 
   and the claim of the boss seems to be true, because we don't have enough evidence to prove otherwise *-- 1) Download and install the northwind database - northwind.sql - from here (https://github.com/pthom/northwind_psql)

