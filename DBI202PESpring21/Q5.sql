select l.LocationID, l.StreetAddress, l.City, l.StateProvince, l.CountryID, count(d.DepartmentID) as [NumberOfDepartments]
from Locations l full join Departments d on l.LocationID = d.LocationID
group by l.LocationID, l.StreetAddress, l.City, l.StateProvince, l.CountryID
order by [NumberOfDepartments] desc, l.LocationID ASC