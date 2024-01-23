#Sales analysis

#Total Sales by year
SELECT YEAR(o.order_date) AS year, 
ROUND(SUM(oi.quantity * (oi.list_price - (oi.list_price * oi.discount))),2) as total_Sales 
from order_items oi 
JOIN orders o ON oi.order_id = o.order_id 
GROUP BY YEAR(o.order_date)


#Total sales by quarter
SELECT
    YEAR(order_date) AS year,
    QUARTER(order_date) AS quarter,
   ROUND(SUM(oi.quantity * (oi.list_price - (oi.list_price * oi.discount))),2) as total_Sales
from order_items oi 
JOIN orders o ON oi.order_id = o.order_id 
GROUP BY YEAR(order_date), QUARTER(order_date)
ORDER BY YEAR(order_date), QUARTER(order_date)

#Total sales by month
SELECT
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
   ROUND(SUM(oi.quantity * (oi.list_price - (oi.list_price * oi.discount))),2) as total_Sales
from order_items oi 
JOIN orders o ON oi.order_id = o.order_id 
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY YEAR(order_date), MONTH(order_date)

_________________________________________________________________________________


#Query identify products frequently purchased together
SELECT oi1.product_id as product1, p1.product_name, oi2.product_id as product2, p2.product_name, COUNT(*) as occurrences
FROM order_items oi1
JOIN order_items oi2 ON oi1.order_id = oi2.order_id AND oi1.product_id > oi2.product_id
JOIN products p1 ON p1.product_id = oi1.product_id 
JOIN products p2 ON p2.product_id = oi2.product_id 
GROUP BY product1, product2
-- HAVING occurrences >= 10 -- set your minimum occurrences threshold
ORDER BY occurrences DESC;

_________________________________________________________________________________


#query to calculate the total sales for each bike brand.
SELECT b.brand_name, round(SUM(oi.quantity * (oi.list_price - (oi.list_price * oi.discount))),2) as total_sales
FROM order_items oi 
JOIN products p on oi.product_id = p.product_id  
JOIN brands b on p.brand_id = b.brand_id 
GROUP by b.brand_name
ORDER BY  total_sales DESC

#the bike products with the highest total sales.
select p.product_name, b.brand_name, ROUND(SUM(oi.quantity * (oi.list_price - (oi.list_price * oi.discount))), 2) as total_sales
from order_items oi 
join products p on oi.product_id = p.product_id  
join brands b on p.brand_id = b.brand_id 
group by p.product_name, b.brand_name
order by total_sales desc
limit 10

#query to calculate the total sales for each bike category.
select c.category_name , ROUND(SUM(oi.quantity * (oi.list_price - (oi.list_price * oi.discount))), 2) as total_sales
from order_items oi 
join products p on oi.product_id = p.product_id  
join categories c on p.category_id = c.category_id 
group by c.category_name
order by total_sales DESC

#query provides information on the average 
#price of products for each combination of 
#category and brand, excluding combinations where there are no matching products
SELECT c.category_name, b.brand_name, round(avg(p.list_price),2) as avg_price
FROM categories c
CROSS JOIN brands b
LEFT JOIN products p ON b.brand_id = p.brand_id AND c.category_id = p.category_id
GROUP by c.category_name, b.brand_name
HAVING COUNT(p.product_id) > 0
ORDER BY  avg_price DESC

_________________________________________________________________________________


#Total spending by customer
select c.first_name, c.last_name, SUM(oi.quantity * (oi.list_price - (oi.list_price * oi.discount))) as total_Sales from customers c 
join orders o ON c.customer_id = o.customer_id 
join order_items oi ON o.order_id = oi.order_id
group by c.first_name, c.last_name
order by total_Sales desc 

#Total spending by customers in each state:
select c.state, SUM(oi.quantity * (oi.list_price - (oi.list_price * oi.discount))) as total_Sales from customers c 
join orders o ON c.customer_id = o.customer_id 
join order_items oi ON o.order_id = oi.order_id
group by c.state
order by total_Sales desc 

#Total spending by customers in each city:
select c.state, c.city , SUM(oi.quantity * (oi.list_price - (oi.list_price * oi.discount))) as total_Sales from customers c 
join orders o ON c.customer_id = o.customer_id 
join order_items oi ON o.order_id = oi.order_id
group by c.state, c.city
order by total_Sales desc 