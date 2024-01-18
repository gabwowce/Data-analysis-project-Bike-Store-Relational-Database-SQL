#Customers analysis



#Total Customer Count:
select count(*) from customers c 

#Customer Distribution by State:
select state, count(*) as Total_customers from customers c 
group by state

#Customer Distribution by City:
select state, city, count(*) as Total_customers from customers c 
group by state, city
order by Total_customers desc




#Customer Contact Information Analysis. Query to check if there is missing contact information:
select customer_id, first_name, last_name,
  CASE
    WHEN email IS NOT NULL THEN 'Yes'
    ELSE 'No'
  END AS email,
  CASE
    WHEN phone IS NOT NULL THEN 'Yes'
    ELSE 'No'
  END AS phone
FROM customers c
where phone = 'No' or email='No';




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




#Customer Loyalty:
# frequency of customer orders
select c.first_name, c.last_name, c.state, count(o.order_id) as orders from customers c join orders o on c.customer_id = o.customer_id 
group by c.first_name, c.last_name, c.state
order by orders desc

#average number of orders per customer, asumming we have customers without orders
select AVG(order_count) as avg_order_per_customer
from (
    select c.customer_id, COUNT(o.order_id) as order_count
    from customers c
    left join orders o ON c.customer_id = o.customer_id
    group by c.customer_id
) as customer_order_counts;

