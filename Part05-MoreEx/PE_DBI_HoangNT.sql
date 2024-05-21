use FUH_COMPANY
-- 1. Display the employee list that belongs to the department of 'Phòng Phần mềm trong nước', and sort the result by EmpSSN
select * from tblEmployee where depNum = (select depNum from tblDepartment where depName = N'Phòng Phần mềm trong nước') order by empSSN ASC

-- 2. Display the total number of employees of each department
-- Output: DepNum, DepName, NoEmployees

select d.depNum, d.depName, COUNT(*) as [NoEmployees]from tblEmployee e full join tblDepartment d on e.depNum = d.depNum
group by d.depName, d.depNum

-- 3. Which department has the most employees?
-- Output: DepNum, DepName, NoEmployees
select depNum, depName, NoEmployees from (select d.depName, d.depNum, COUNT(*) as [NoEmployees]from tblEmployee e full join tblDepartment d on e.depNum = d.depNum
group by d.depName, d.depNum) as [Q2] 
where NoEmployees >= ALL(select COUNT(*) as [NoEmployees]from tblEmployee e full join tblDepartment d on e.depNum = d.depNum
group by d.depName, d.depNum)

-- 4. Display the total number of projects of each department.
--Output: DepNum, DepName, NoProjects
select d.depNum, d.depName, count(p.proNum) as [NoProjects] from tblDepartment d full join tblProject p on d.depNum = p.depNum
group by d.depNum, d.depName

-- 5. Display the project information regarding to all of employees that belong to the department of 'Phòng Phần mềm trong nước' and 'Phòng Phần mềm nước ngoài', and sort the result by ProjectNumber
--Output: EmpSSN, EmpName, ProjectNumber, WorkHours, DepNum, DepName
select e.empSSN, e.empName, w.proNum, w.workHours, e.depNum, d.depName from tblEmployee e full join tblWorksOn w on e.empSSN = w.empSSN 
full join tblDepartment d on e.depNum = d.depNum where d.depName in (N'Phòng Phần mềm trong nước', N'Phòng Phần mềm nước ngoài')
order by w.proNum ASC

-- 6. How many employees are working on the 'Project A'
--Output: ProjectNum, ProjectName, NoEmployees
select p.proNum, p.proName, count(e.depNum) as [NoEmployees] from tblEmployee e full join tblProject p on e.depNum = p.depNum
group by  p.proNum, p.proName
having p.proName = 'ProjectA'
