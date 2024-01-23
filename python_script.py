import pandas as pd
import mysql.connector

database_info = {
    'user': 'root',
    'password': '12301',
    'host': 'localhost',
    'database': 'bikestore',
}

conn = mysql.connector.connect(**database_info)

query1 = '''
    SELECT YEAR(order_date) AS year, COUNT(DISTINCT customer_id) AS new_clients_count
FROM orders o
WHERE NOT EXISTS (SELECT 1 FROM orders o2
        		  WHERE o2.customer_id = o.customer_id
                  AND YEAR(o2.order_date) < YEAR(o.order_date))
GROUP BY year;
'''

new_customers_for_each_year = pd.read_sql(query1, conn)

conn.close()


