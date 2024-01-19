#Brands and Categories analysis


#Query to count the number of sold bikes by brand.
select b.brand_name, sum(oi.quantity) as sold_as_unit
 from order_items oi 
join products p on oi.product_id = p.product_id  
join brands b on p.brand_id = b.brand_id 
group by b.brand_name
order by sold_as_unit desc


#Query to count the number of sold bikes by product name.
##"LIMIT 10" at the end would show top 10 products
select p.product_name, b.brand_name, sum(oi.quantity) as sold_as_unit
 from order_items oi 
join products p on oi.product_id = p.product_id  
join brands b on p.brand_id = b.brand_id 
group by p.product_name, b.brand_name
order by sold_as_unit desc


#Query to count the number of orders for each bike category
select c.category_name , sum(oi.quantity) as sold_by_category
from order_items oi 
join products p on oi.product_id = p.product_id  
join categories c on p.category_id = c.category_id 
group by c.category_name
order by sold_by_category desc

#query to calculate the total sales for each bike brand.
select b.brand_name, round(SUM(oi.quantity * (oi.list_price - (oi.list_price * oi.discount))),2) as total_sales
from order_items oi 
join products p on oi.product_id = p.product_id  
join brands b on p.brand_id = b.brand_id 
group by b.brand_name
order by total_sales desc

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
order by total_sales desc




#products by brand and category
select b.brand_name, p.product_name, c.category_name
from brands b join products p on b.brand_id = p.brand_id  
join categories c on p.category_id = c.category_id 
order by b.brand_name

#Brand and Category Correlation:

#cross-tabulation
SELECT c.category_name, b.brand_name
FROM categories c
CROSS JOIN brands b
LEFT JOIN products p ON p.brand_id = p.brand_id
GROUP BY c.category_name, b.brand_name



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


