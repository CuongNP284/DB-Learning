select o.ProductID, p.ProductName, MAX(o.Quantity) as Quantity
from Product p join OrderDetails o on p.ID = o.ProductID
group by o.ProductID, p.ProductName
having MAX(o.Quantity) >= ALL(select MAX(o.Quantity) as Quantity
from Product p join OrderDetails o on p.ID = o.ProductID
group by o.ProductID, p.ProductName)
