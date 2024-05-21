select o.CustomerID, c.CustomerName, count(o.ID) as [NumberOfOrders]
from Customer c full join Orders o 
on c.ID = o.CustomerID
group by o.CustomerID, c.CustomerName
having count(o.ID) >= ALL(select count(o.ID) from Customer c full join Orders o 
on c.ID = o.CustomerID
group by o.CustomerID, c.CustomerName)