create trigger tr_insert_Product
on Product
for insert
as
begin 
	select ied.ProductID, ied.Name as ProductName, ied.ModelID, pm.Name as ModelName
	from inserted ied join ProductModel pm
	on ied.ModelID = pm.ModelID
end

