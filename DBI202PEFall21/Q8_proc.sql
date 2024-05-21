create proc proc_product_subcategory @subcategoryID int, @numberOfProducts int output
as
begin
	select @numberOfProducts = sum(p.SubcategoryID) from Product p
    group by p.SubcategoryID having p.SubcategoryID = @subcategoryID
end

declare @x int
exec proc_product_subcategory 1, @x output
select @x as NumberOfProducts

