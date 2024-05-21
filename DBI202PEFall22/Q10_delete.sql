delete FROM PackageTypes WHERE PackageTypeID not IN (select si.OuterPackageID FROM StockItems si
JOIN PackageTypes pt ON si.OuterPackageID = pt.PackageTypeID
group BY si.OuterPackageID
UNION
select si.UnitPackageID FROM StockItems si
JOIN PackageTypes pt ON si.UnitPackageID = pt.PackageTypeID
GROUP BY si.UnitPackageID)