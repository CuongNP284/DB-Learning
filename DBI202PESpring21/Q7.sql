SELECT e1.EmployeeID, e1.FirstName, e1.LastName, e1.Salary, e1.DepartmentID, d.DepartmentName, COUNT(e2.EmployeeID) AS NumberOfSubordinates FROM Employees e1
LEFT JOIN Employees e2
ON e1.EmployeeID = e2.ManagerID
JOIN Departments d
ON e1.DepartmentID = d.DepartmentID
GROUP BY e1.EmployeeID, e1.FirstName, e1.LastName, e1.Salary, e1.DepartmentID, d.DepartmentName
HAVING EXISTS (SELECT * FROM Employees WHERE ManagerID = e1.EmployeeID) OR e1.Salary > 10000
ORDER BY COUNT(e2.EmployeeID) DESC, e1.LastName