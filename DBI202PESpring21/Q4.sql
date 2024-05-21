select e.EmployeeID, e.FirstName, e.LastName, e.Salary, d.DepartmentName, l.StateProvince, l.CountryID 
from Departments d full join Employees e on e.DepartmentID =d.DepartmentID
full join Locations l on d.LocationID = l .LocationID
where e.Salary > 3000 and l.StateProvince = 'Washington' and l.CountryID = 'US'