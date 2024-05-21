select l.LocationID, l.Name, count(py.ProductID) as [NumberOfProducts] from ProductInventory py full join Location l
on py.LocationID = l.LocationID
group by l.LocationID, l.Name
order by [NumberOfProducts] DESC, l.Name ASC