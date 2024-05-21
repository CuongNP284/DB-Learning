create trigger Tr1
On Employees
after insert
as
begin
	select i.EmployeeID, i.FirstName, i.LastName, i.DepartmentID, d.DepartmentName
	from inserted i left join Departments d on i.DepartmentID = d.DepartmentID
end