select j.JobID, j.JobTitle, count(e.EmployeeID) as [NumberOfEmployees]
from Jobs j full join Employees e on j.JobID = e.JobID
group by j.JobID, j.JobTitle
having count(e.EmployeeID) >= 
ALL(select count(e.EmployeeID)
from Jobs j full join Employees e on j.JobID = e.JobID
group by j.JobID, j.JobTitle)