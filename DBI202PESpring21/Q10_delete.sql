delete from Employees where DepartmentID not in(
SELECT distinct e.DepartmentID FROM Employees e)