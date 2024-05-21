DROP TRIGGER Tr4
CREATE TRIGGER Tr4
ON StockItems AFTER INSERT
AS
BEGIN
  SELECT
    i.StockItemID
   ,i.StockItemName
   ,i.OuterPackageID
   ,pt.PackageTypeName AS OuterPackageTypeName
   ,i.UnitPrice
   ,i.TaxRate
  FROM INSERTED i
  LEFT JOIN PackageTypes pt
    ON pt.PackageTypeID = i.OuterPackageID
END

INSERT into StockItems (StockItemID, StockItemName, UnitPackageID, OuterPackageID, QuantityPerOuter, IsChillerStock, TaxRate, UnitPrice, TypicalWeightPerUnit, SupplierID)
  VALUES (308, N'T-shirt Red bull', 7, 6, 1, 0, 0.15, 10.5, 0.4, 4);

select * FROM StockItems si WHERE si.StockItemID = 308