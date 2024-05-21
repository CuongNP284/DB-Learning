create trigger InsertProduct
on Product 
after insert
as
begin
	select i.ProductName, s.SubCategoryName from inserted i full join SubCategory s on i.SubCategoryID = s.ID
end