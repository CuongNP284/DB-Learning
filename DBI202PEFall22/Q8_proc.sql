create proc Proc4 @stockItemID int, @OrderYear int, @numberOfPurchaseOrders INT output
as
begin
	select @numberOfPurchaseOrders =  count(*) from PurchaseOrderLines p full join StockItems s on p.StockItemID = s.StockItemID
full join PurchaseOrders po on p.PurchaseOrderID = po.PurchaseOrderID
where Year(po.OrderDate) = @OrderYear and s.StockItemID = @stockItemID
end

DECLARE @x INT
EXEC Proc4 95
          ,2013
          ,@x OUTPUT
SELECT
  @x AS NumberOfPurchaseOrders