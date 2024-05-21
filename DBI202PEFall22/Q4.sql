select s.StockItemID, s.StockItemName, su.SupplierID, su.SupplierName, s.OuterPackageID, pt.PackageTypeName as OuterPackageTypeName, s.UnitPrice
from StockItems s full join Suppliers su on s.SupplierID = su.SupplierID
full join PackageTypes pt on s.OuterPackageID = pt.PackageTypeID
where s.StockItemID >= 135
order by OuterPackageTypeName ASC, s.StockItemName ASC
