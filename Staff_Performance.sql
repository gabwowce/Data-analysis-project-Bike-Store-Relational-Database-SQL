#Staff Performance:


#performance of the staff by orders they handled
 SELECT o.staff_id, s.first_name, s.last_name, s2.state, count(o.order_id) AS orders_handled  
 FROM orders o 
 JOIN staffs s ON o.staff_id = s.staff_id
 JOIN stores s2 ON o.store_id = s2.store_id 
 GROUP BY  s.first_name, s.last_name,o.staff_id,s2.state
 
 
 #total revenue generated from orders handled by each staff member
 SELECT o.staff_id, s.first_name, s.last_name, s2.state, 
 round(SUM(oi.quantity * (oi.list_price - (oi.list_price * oi.discount)))) AS total_revenue  
 FROM orders o 
 JOIN order_items oi ON o.order_id = oi.order_id 
 JOIN staffs s ON o.staff_id = s.staff_id
 JOIN stores s2 ON o.store_id = s2.store_id 
 GROUP BY  s.first_name, s.last_name,o.staff_id,s2.state
 
 
 #Assuming the staff is responsible for preparing orders for shipment, 
 #let's calculate the average number of days each employee takes 
 #from order placement to shipment
 SELECT o.staff_id, s.first_name, s.last_name, avg(datediff(o.shipped_date, o.order_date))  AS avg_num_days  
 FROM orders o 
 JOIN staffs s ON o.staff_id = s.staff_id
 GROUP BY s.first_name, s.last_name, o.staff_id
 
 
 #This query counts the number of times where the shipment was late for each staff member
 SELECT o.staff_id, s.first_name, s.last_name, 
 count(*) AS times_late
 FROM orders o 
 JOIN staffs s ON o.staff_id = s.staff_id
 WHERE  datediff(o.shipped_date, o.required_date) > 0
 GROUP BY o.staff_id, s.first_name, s.last_name
 
#This query calculates the percentage of late orders for each staff member.
SELECT o.staff_id, s.first_name, s.last_name,
		ROUND(SUM(CASE 
					WHEN DATEDIFF(o.shipped_date, o.required_date) > 0 THEN 1 ELSE 0 
			      END) * 100 / COUNT(o.order_id), 2) AS late_order_prc
FROM orders o 
JOIN staffs s ON o.staff_id = s.staff_id
GROUP BY s.first_name, s.last_name, o.staff_id;

 
#The query is attempting to identify cases where a customer has placed orders 
#handled by the same staff more than once.
SELECT o.staff_id, o.customer_id, count(o.customer_id) AS repeated_cl
FROM orders o 
GROUP BY o.staff_id, o.customer_id
HAVING repeated_cl > 1 

