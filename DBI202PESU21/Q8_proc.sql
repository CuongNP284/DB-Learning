create proc pr1 @store_id int, @numberOfStaffs int output
as
begin 
	select @numberOfStaffs = count(f.staff_id) from stores s full join staffs f on s.store_id = f.store_id
	group by s.store_id, s.store_name having s.store_id = @store_id
end

declare @x int
exec pr1 3, @x output
select @x as NumberOfStaffs

