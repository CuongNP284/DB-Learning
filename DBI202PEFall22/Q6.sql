select s.UnitPackageID, p.PackageTypeName as UnitPackageTypeName, count(s.UnitPackageID) as NumberOfStockItems
from StockItems s join PackageTypes p on s.UnitPackageID = p.PackageTypeID
group by s.UnitPackageID, p.PackageTypeName
having count(s.UnitPackageID) = (select top 1 count(s.UnitPackageID) as NumberOfStockItems
from StockItems s join PackageTypes p on s.UnitPackageID = p.PackageTypeID
group by s.UnitPackageID, p.PackageTypeName
order by NumberOfStockItems ASC)