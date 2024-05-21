select pl.ModelID, pl.Name, p.ProductID, p.Name, count(p.ProductID) as [NumberOfLocations]
from Product p right join ProductInventory py on p.ProductID = py.ProductID
right join ProductModel pl on p.ModelID = pl.ModelID
where pl.Name like 'HL Mountain%'
group by pl.ModelID, pl.Name, p.ProductID, p.Name