drop proc CountProduct

create proc  CountProduct @OrderID nvarchar(255), @NbProducts int output
as
begin
	select @NbProducts = count(*) from OrderDetails o
	where o.OrderID = @OrderID
	group by o.OrderID
end

declare @t int
exec CountProduct 'CA-2014-100391', @t output 
print @t