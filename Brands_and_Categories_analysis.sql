#Brands and Categories analysis


#Query to count the number of sold bikes by brand.
SELECT b.brand_name, sum(oi.quantity) as sold_as_unit
 FROM order_items oi 
JOIN products p on oi.product_id = p.product_id  
JOIN brands b on p.brand_id = b.brand_id 
GROUP by b.brand_name
ORDER BY  sold_as_unit DESC


#Query to count the number of sold bikes by product name.
##"LIMIT 10" at the end would show top 10 products
SELECT p.product_name, b.brand_name, sum(oi.quantity) as sold_as_unit
 FROM order_items oi 
JOIN products p on oi.product_id = p.product_id  
JOIN brands b on p.brand_id = b.brand_id 
GROUP by p.product_name, b.brand_name
ORDER BY  sold_as_unit DESC


#Query to count the number of orders for each bike category
SELECT c.category_name , sum(oi.quantity) as sold_by_category
FROM order_items oi 
JOIN products p on oi.product_id = p.product_id  
JOIN categories c on p.category_id = c.category_id 
GROUP by c.category_name
ORDER BY  sold_by_category DESC

#query to calculate the total sales for each bike brand.
SELECT b.brand_name, round(SUM(oi.quantity * (oi.list_price - (oi.list_price * oi.discount))),2) as total_sales
FROM order_items oi 
JOIN products p on oi.product_id = p.product_id  
JOIN brands b on p.brand_id = b.brand_id 
GROUP by b.brand_name
ORDER BY  total_sales DESC

#the bike products with the highest total sales.
SELECT p.product_name, b.brand_name, ROUND(SUM(oi.quantity * (oi.list_price - (oi.list_price * oi.discount))), 2) as total_sales
FROM order_items oi 
JOIN products p on oi.product_id = p.product_id  
JOIN brands b on p.brand_id = b.brand_id 
GROUP by p.product_name, b.brand_name
ORDER BY  total_sales DESC
LIMIT 10

#query to calculate the total sales for each bike category.
SELECT c.category_name , ROUND(SUM(oi.quantity * (oi.list_price - (oi.list_price * oi.discount))), 2) as total_sales
FROM order_items oi 
JOIN products p on oi.product_id = p.product_id  
JOIN categories c on p.category_id = c.category_id 
GROUP by c.category_name
ORDER BY  total_sales DESC




#products by brand and category
SELECT b.brand_name, p.product_name, c.category_name
FROM brands b JOIN products p on b.brand_id = p.brand_id  
JOIN categories c on p.category_id = c.category_id 
ORDER BY  b.brand_name

#Brand and Category Correlation:

#cross-tabulation
SELECT c.category_name, b.brand_name
FROM categories c
CROSS JOIN brands b
LEFT JOIN products p ON p.brand_id = p.brand_id
GROUP by c.category_name, b.brand_name



#This query checks for each combination of 
#category and brand whether there is matching product, 
#and it creates a flag to indicate the result.
SELECT c.category_name, b.brand_name,
  CASE
    WHEN COUNT(p.product_id) > 0 THEN 1
    ELSE 0
  END AS has_match
FROM categories c
CROSS JOIN brands b
LEFT JOIN products p ON b.brand_id = p.brand_id AND c.category_id = p.category_id
GROUP BY c.category_name, b.brand_name;

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


