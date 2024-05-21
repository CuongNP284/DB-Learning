select p.ProductID, p.Name, sum(pr.Quantity) as [TotalQuantity]
from ProductInventory pr full join Product p on p.ProductID = pr.ProductID full join Location l on pr.LocationID = l.LocationID
group by p.ProductID, p.Name
having sum(pr.Quantity) is not null and sum(pr.Quantity) >= ALL
(select sum(pr.Quantity) as [TotalQuantity]
from ProductInventory pr full join Product p on p.ProductID = pr.ProductID full join Location l on pr.LocationID = l.LocationID
group by p.ProductID, p.Name having sum(pr.Quantity) is not null)

select p.ProductID, p.Name, sum(pv.Quantity) as TotalQuantity from Product p join ProductInventory pv
on p.ProductID = pv.ProductID
group by p.ProductID, p.Name 
having sum(pv.Quantity) =  (select max(l.TotalQuantity) from 
(select p.ProductID, p.Name, sum(pv.Quantity) as TotalQuantity from Product p join ProductInventory pv
on p.ProductID = pv.ProductID
group by p.ProductID, p.Name) as l)