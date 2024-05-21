Use FUH_COMPANY

select * from tblEmployee

-- 1.Liệt kê các nhân viên có lương hơn 50000
select * from tblEmployee where empSalary > 50000 order by empSalary DESC
Go

-- 2.Liệt kê các nhân viên có lương hơn 50000 gồm tên và lương
select empName, empSalary from tblEmployee where empSalary > 50000 order by empSalary DESC
Go

-- 3.Liệt kê các nhân viên có lương hơn 50000 gồm tên và lương (bản premium)
select empName as [FullName], empSalary [Lương] from tblEmployee where empSalary > 50000 order by empSalary DESC
Go
-- 4.1 Liệt kê tất cả nhân viên nam dưới 50 tuổi
select empName as [Họ và tên], empSex as [Giới tính], YEAR(GETDATE()) - YEAR(empBirthdate) as [Tuổi] 
from tblEmployee 
where YEAR(GETDATE()) - YEAR(empBirthdate) < 50 and empSex = 'M'
Go

-- 4. Liệt kê tất cả nhân viên nam dưới 50 tuổi hoặc nữ dưới 40 tuổi
select empName as [Họ và tên], empSex as [Giới tính], YEAR(GETDATE()) - YEAR(empBirthdate) as [Tuổi] 
from tblEmployee 
where (YEAR(GETDATE()) - YEAR(empBirthdate) < 50 and empSex = 'M')
or (YEAR(GETDATE()) - YEAR(empBirthdate) < 40 and empSex = 'F')
Go

-- 6. Liệt kê tất cả nhân viên theo số bộ phận tăng dần, sau đó theo mức lương giảm dần
select * from tblEmployee order by depNum ASC, empSalary DESC
Go

-- 7/11. Liệt kê tất cả các nhân viên làm ở dep 'Phòng Phần mềm trong nước'
select * from tblEmployee
select * from tblDepartment
select * from tblEmployee where depNum = (select depNum from tblDepartment where depName = N'Phòng Phần mềm trong nước')
select * from tblEmployee e, tblDepartment d where e.depNum = d.depNum and depName = N'Phòng Phần mềm trong nước'
select * from tblEmployee e, tblDepartment d where e.depNum = d.depNum and depName like N'Phòng Phần mềm trong nước'
select * from tblEmployee where depNum = ANY(select depNum from tblDepartment where depName = N'Phòng Phần mềm trong nước')
select * from tblEmployee where depNum in (select depNum from tblDepartment where depName = N'Phòng Phần mềm trong nước')
Go

-- 8. Liệt kê tất cả tp mà các cty thuộc về
select * from tblLocation
select * from tblDepLocation

select * from tblLocation where locNum = ANY(select locNum from tblDepLocation)
select distinct locName from tblLocation where locNum in (select locNum from tblDepLocation)
select distinct l.locName from tblLocation l, tblDepLocation d where l.locNum = d.locNum

-- 9. Tìm tất cả các số dự án có nhiều hơn hai thành viên
select * from tblWorksOn 
select proNum from tblWorksOn group by proNum
select distinct w1.proNum as [ProNum] from tblWorksOn w1, tblWorksOn w2 where w1.proNum = w2.proNum and w1.empSSN <> w2.empSSN
select proNum from tblWorksOn group by proNum having count(proNum) >= 2
-- 10.1 Tìm tất cả những nhân viên có tên bắt đầu bằng ‘H’ hoặc có mức lương vượt quá 80000
select * from tblEmployee where empName like 'H%' or empSalary > 80000

select * from tblEmployee where empName like 'H%' UNION
select * from tblEmployee where empSalary > 80000

-- 10.2 Tìm tất cả những nhân viên bình thường, tức là những người không giám sát bất kỳ nhân viên nào khác
select * from tblEmployee
select empSSN from tblEmployee except select supervisorSSN from tblEmployee

-- 10.3 Tìm tất cả nhân viên làm việc trên projectB và projectC
select * from tblProject
select * from tblWorksOn

select empSSN from tblWorksOn where proNum = (select proNum from tblProject where proName = 'ProjectB') 
intersect
select empSSN from tblWorksOn where proNum = (select proNum from tblProject where proName = 'Projectc') 

select empSSN from tblWorksOn w, tblProject p where w.proNum = p .proNum and p.proName = 'ProjectB'
intersect select empSSN from tblWorksOn w, tblProject p 
where w.proNum = p .proNum and p.proName = 'ProjectC'

-- 12. Liệt kê tất cả những người phụ thuộc ở phòng số 1
select * from tblDependent where empSSN IN (select empSSN from tblEmployee where depNum = 1)

-- 13. Liệt kê tất cả dự án có cùng địa điểm với dự án A
select * from tblProject where locNum = 
(select locNum from tblProject where proName = 'ProjectA')

-- 15. 
select * from tblDepartment d JOIN tblEmployee e on d.depNum = e.depNum

-- 17.1 For each location, listing the projects that are processed in it
select l.locNum, l.locName, p.proNum, p.proName from tblLocation l LEFT JOIN tblProject p ON l.locNum = p.locNum;

-- 17.2 For each department, listing the projects that it controls
select d.depName, p.proName from tblDepartment d LEFT JOIN tblProject p ON d.depNum = p.depNum;

-- 18.1 Find average salary of all employees
select AVG(empSalary) as [Average Of Salary]from tblEmployee

-- 18.2 Find number of employees
select COUNT(*) as [Count Of Employees]from tblEmployee

-- 19.1 Group employees by department number
SELECT * from tblEmployee order by depNum

-- 19.2 List number of employees for each department number
SELECT depNum, count(*)	as [Number of Employees]from tblEmployee group by depNum order by count(*) ASC

-- 20. Compute the number of employees for each project
select proNum, COUNT(*) as [Number of Employees] from tblWorksOn group by proNum

-- 21. Print the number of employees for each those department, whose average salary exceeds 80000
select depNum, count(empSSN) [Number of Employees] from tblEmployee group by depNum having AVG(empSalary) > 80000
select depNum, AVG(empSalary) as [Average Of Salary] from tblEmployee group by depNum having AVG(empSalary) > 80000
