select c.ID, c.CustomerName, c.Segment, c.Country, c.City,
c.State, c.PostalCode, c.Region
from Customer c, Orders o
where c.CustomerName like 'B%'
and c.ID = o.CustomerID and o.OrderDate between '2017/12/1' and '2017/12/31'
order by c.Segment DESC, c.CustomerName ASC