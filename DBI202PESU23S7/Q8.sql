create proc procProductNumber @supCode varchar(2), @productNumbers int output
as
begin
	select @productNumbers = count(p.supcode) from tblProducts p group by p.supcode
	having p.supcode = @supCode
end

declare @Productnumber int
exec procProductNumber 'MT', @Productnumber output
select @Productnumber as ProductNumber
