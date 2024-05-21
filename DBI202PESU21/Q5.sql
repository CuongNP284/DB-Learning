select s.store_id, s.store_name, count(s.store_id) as [NumberOfOrdersIn2018]
from stores s join orders o on s.store_id = o.store_id
where YEAR(o.order_date) = 2018 
group by s.store_id, s.store_name
order by NumberOfOrdersIn2018 DESC