select su.SupplierID, su.SupplierName, count(p.SupplierID) as [NumberOfPurchaseOrders]
from PurchaseOrders p full join Suppliers su
on p.SupplierID = su.SupplierID
group by su.SupplierID, su.SupplierName
order by [NumberOfPurchaseOrders] DESC, su.SupplierName ASC