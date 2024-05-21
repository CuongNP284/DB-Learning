select o.order_id, o.order_date, c.customer_id, c.first_name, c.last_name, s.store_name 
from orders o full join customers c on o.customer_id = c.customer_id
full join stores s on o.store_id = s.store_id
where o.order_date between '2016-01-01' and '2016-01-31' and s.store_name = 'Santa Cruz Bikes'
