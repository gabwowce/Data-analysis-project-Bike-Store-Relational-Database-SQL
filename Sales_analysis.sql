#Sales analysis

#Total Sales by year
SELECT YEAR(o.order_date), 
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

#Total quantity of sold bikes grouped by discount
SELECT oi.discount,
sum(oi.quantity) AS sold_bikes
from order_items oi 
GROUP BY oi.discount
ORDER BY oi.discount DESC 

#Query identify products frequently purchased together
SELECT oi1.product_id as product1, oi2.product_id as product2, COUNT(*) as occurrences
FROM order_items oi1
JOIN order_items oi2 ON oi1.order_id = oi2.order_id AND oi1.product_id > oi2.product_id
GROUP BY product1, product2
-- HAVING occurrences >= 10 -- set your minimum occurrences threshold
ORDER BY occurrences DESC;



