create proc pr1 @countryID varchar(10), @numberOfDepartments int output
as
begin
	select @numberOfDepartments = count(d.DepartmentID) from Locations l full join Departments d
	on l.LocationID = d.LocationID
	group by l.CountryID
	having l.CountryID = @countryID
end



