select s.SupplierTransactionID, s.SupplierID, su.SupplierName, s.TransactionDate, s.TransactionAmount from SupplierTransactions s
full join Suppliers su on s.SupplierID = su.SupplierID
where s.TransactionDate >= '2013-02-01' and s.TransactionDate <= '2013-02-15'