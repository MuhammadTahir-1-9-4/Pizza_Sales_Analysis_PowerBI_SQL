-- Total number of columns
select count(*) as total_columns
from information_schema.columns
where table_name = 'pizza_sales'
and table_schema = 'pizza';


-- A. KPI's
-- 1. Total Revenue
SELECT Round(SUM(total_price), 2) AS Total_Revenue
FROM pizza_sales;

-- 2. Average Order Value
SELECT Round((SUM(total_price) / COUNT(DISTINCT order_id)), 2) AS Avg_Order_Value
FROM pizza_sales;

-- 3. Total Pizza Sold
SELECT SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales;

-- 4. Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales;

-- 5. Average Pizzas per Order
SELECT ROUND(SUM(quantity)/COUNT(DISTINCT order_id), 2) AS Avg_Pizza_per_Order
FROM pizza_sales;

-- B. Daily Trend for Total Orders
SELECT DAYNAME(order_date) AS order_day, COUNT(DISTINCT order_id) as total_orders
FROM pizza_sales
GROUP BY order_day
ORDER BY total_orders DESC;

-- C. Monthly Trend for Total Orders
SELECT MONTHNAME(order_date) as month_name, COUNT(DISTINCT order_id) as total_orders
FROM pizza_sales
GROUP BY month_name
ORDER BY total_orders DESC;

-- D. % of Sales by Pizza Category
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue,
	CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category;

-- E. % of Sales by pizza size
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue,
	CAST(SUM(total_price)*100/(SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size;

-- F. Total Pizzas Sold by Pizza Category
SELECT pizza_category, SUM(quantity) AS total_pizzas_sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY total_quantity_sold DESC;

-- G. Top 5 Pizzas by Revenue
SELECT pizza_name, SUM(total_price) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue DESC
LIMIT 5;

-- H. Bottom 5 Pizza by Revenue
SELECT pizza_name, SUM(total_price) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue ASC
LIMIT 5;

-- I. Top 5 Pizzas by Quantity
SELECT pizza_name, SUM(quantity) AS total_pizza_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_quantity DESC
LIMIT 5;

-- J. Bottom 5 Pizzas by Quantity
SELECT pizza_name, SUM(quantity) AS total_pizza_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_quantity ASC
LIMIT 5;


-- K. Top 5 Pizzas by Total Orders
SELECT pizza_name, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders DESC
LIMIT 5;

-- L. BOTTOM 5 Pizzas by Total Orders
SELECT pizza_name, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders ASC
LIMIT 5;