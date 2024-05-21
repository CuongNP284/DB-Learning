delete from ProductInventory where ProductID in (select pv.ProductID from Location l join ProductInventory pv
on l.LocationID = pv.LocationID where l.Name = 'Tool Crib')

delete from ProductInventory where ProductID in (select py.ProductID from Product p full join ProductModel pl on p.ModelID = pl.ModelID full join ProductInventory py
on p.ProductID = py.ProductID where p.ModelID = 33)
