drop proc proc_product_quantity
create proc proc_product_quantity @productID int, @totalQuantity int output
as
begin
	select @totalQuantity = sum(pr.Quantity) from Product p join ProductInventory pr on p.ProductID = pr.ProductID
	where p.ProductID = @productID group by p.ProductID, p.Name

end

declare @x int
exec proc_product_quantity 1, @x output
select @x as TotalQuantity

select p.ProductID, p.Name, sum(py.Quantity) as [totalQuantity] from Product p full join ProductInventory py on p.ProductID = py.ProductID
group by  p.ProductID, p.Name