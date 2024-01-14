SELECT * FROM pizza_sales;

# Change Field type text to Date
UPDATE pizza_sales SET order_date = STR_TO_DATE(order_date, '%d-%m-%Y');

# Change Field type text to Time
UPDATE pizza_sales SET order_time = STR_TO_DATE(order_time, '%H:%i:%s');

# A. KPI's
# Total Revenue:
SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales;

# Average Order Value
SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_order_Value FROM pizza_sales;

# Total Pizzas Sold
SELECT SUM(quantity) AS Total_pizza_sold FROM pizza_sales;

# Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales;

# Average Pizzas Per Order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Avg_Pizzas_per_order
FROM pizza_sales;

# B. Daily Trend for Total Orders
SELECT DATE_FORMAT(order_date, '%W') AS order_day, COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales
GROUP BY DATE_FORMAT(order_date, '%W');

# C. Monthly Trend for Orders
select DATE_FORMAT(order_date, '%M') as Month_Name, COUNT(DISTINCT order_id) as Total_Orders
from pizza_sales
GROUP BY DATE_FORMAT(order_date, '%M');

# D. % of Sales by Pizza Category
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category;

# E. % of Sales by Pizza Size
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size;

# F. Total Pizzas Sold by Pizza Category
SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;

# G. Top 5 Pizzas by Revenue
SELECT pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC
LIMIT 5;

# H. Bottom 5 Pizzas by Revenue
SELECT pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC
LIMIT 5;

# I. Top 5 Pizzas by Quantity
SELECT pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC
LIMIT 5;

# J. Bottom 5 Pizzas by Quantity
SELECT pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC
LIMIT 5;

# K. Top 5 Pizzas by Total Orders
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC
LIMIT 5;

# L. Bottom 5 Pizzas by Total Orders
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC
LIMIT 5;

# If you want to apply the pizza_category or pizza_size filters to the above queries you can use WHERE clause. Follow some of below examples
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
WHERE pizza_category = 'Classic'
GROUP BY pizza_name
ORDER BY Total_Orders ASC
LIMIT 5;












