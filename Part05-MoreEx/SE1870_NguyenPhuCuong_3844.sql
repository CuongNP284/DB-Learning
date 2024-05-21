--1. Cho biết ai đang quản lý phòng ban có tên: Phòng Nghiên cứu và phát triển. Thông tin yêu cầu:
--mã số,họ tên nhân viên, mã số phòng ban, tên phòng ban
select e.empSSN, e.empName, e.depNum, d.depName from tblEmployee e full join tblDepartment d 
on e.depNum = d.depNum 
where d.depName = N'Phòng Nghiên cứu và phát triển'

--2. Cho biết dự án có tên ProjectB hiện đang được quản lý bởi phòng ban nào. Thông tin yêu cầu:
--mã số dụ án, tên dự án, tên phòng ban quản lý
select p.proNum, p.proName, d.depName from tblProject p full join tblDepartment d on p.depNum = d.depNum where p.proName = 'ProjectB'

--3. Cho biết ai hiện đang giám sát những nhân viên có tên Mai Duy An. Thông tin yêu cầu: mã số
--nhân viên, họ tên nhân viên giám sát.
select empSSN, empName from tblEmployee where supervisorSSN = (select empSSN from tblEmployee where empName = N'Mai Duy An')

--4. Cho biết vị trí làm việc có tên Tp. HCM hiện đang là chỗ làm việc của những dự án nào. Thông tin
--yêu cầu: mã số, tên dự án
select p.proNum, p.proName from tblLocation l full join tblProject p on l.locNum = p.locNum where l.locName = N'TP Hồ Chí Minh'

--5. Cho biết những người phụ thuộc là nam giới. Thông tin yêu cầu: tên, ngày tháng năm sinh của
--người phụ thuộc, tên nhân viên phụ thuộc vào
select d.depName, d.depBirthdate, e.empName from tblDependent d full join tblEmployee e on d.empSSN = e.empSSN
where d.depSex = 'M'

--6. Cho biết các dự án làm việc tại Tp. HCM. Thông tin yêu cầu: mã dự án, tên dự án, tên phòng ban
--chịu trách nhiệm dự án
select p.proNum, p.proName, d.depName from tblDepartment d full join tblProject p on d.depNum = p.depNum 
full join tblLocation l on  p.locNum = l.locNum where l.locName = N'TP Hồ Chí Minh'
	
--7. Cho biết những người phụ thuộc trên 18 tuổi, của nhân viên thuộc phòng ban có tên: Phòng
--Nghiên cứu và phát triển. Thông tin yêu cầu: tên nhân viên, tên người phụ thuộc, mối liên hệ
--giữa người phụ thuộc với nhân viên
select e.empName, d.depName, d.depRelationship from tblEmployee e full join tblDependent d on e.empSSN = d.empSSN
full join tblDepartment dt on e.depNum = dt.depNum where dt.depName = N'Phòng Nghiên cứu và phát triển' and YEAR(GETDATE()) - YEAR(d.depBirthdate) > 18 

--8. Cho biết số lượng người phụ thuộc theo mối liên hệ với nhân viên. Thông tin yêu cầu: mối liên hệ,
--số lượng người phụ thuộc
select depRelationship, count(*) as [Số lượng người phụ thuộc] from tblDependent group by depRelationship

--9. Cho biết phòng ban nào có số lượng người phụ thuộc là ít nhất. Thông tin yêu cầu: mã phòng
--ban, tên phòng ban, số lượng người phụ thuộc
select d.depNum, d.depName, count(dt.depName) as [Số lượng người phụ thuộc] from tblEmployee e full join tblDepartment d on e.depNum = d.depNum full join tblDependent dt on e.empSSN = dt.empSSN
group by d.depNum, d.depName having count(dt.depName) <= ALL(select count(dt.depName) as [NumOfDependents] from tblEmployee e full join tblDepartment d on e.depNum = d.depNum full join tblDependent dt on e.empSSN = dt.empSSN
group by dt.depName)

--10. Cho biết tổng số giờ tham gia dự án của mỗi nhân viên. Thông tin yêu cầu: mã nhân viên, tên
--nhân viên, tên phòng ban của nhân viên
select e.empSSN, e.empName, d.depName, SUM(w.workHours) as [Tổng số giờ tham gia dự án]  from tblEmployee e full join tblDepartment d on e.depNum = d.depNum
full join tblWorksOn w on e.empSSN = w.empSSN group by e.empSSN, e.empName, d.depName

--11. Cho biết nhân viên nào có số giờ tham gia dự án là ít nhất. Thông tin yêu cầu: mã nhân viên, tên
--nhân viên, tổng số giờ tham gia dự án
select e.empSSN, e.empName, d.depName, SUM(w.workHours) AS [Tổng số giờ tham gia dự án] from tblEmployee e full join tblDepartment d on e.depNum = d.depNum
full join tblWorksOn w on e.empSSN = w.empSSN group by e.empSSN, e.empName, d.depName
having SUM(w.workHours) <= ALL
(select SUM(w.workHours) from tblEmployee e full join tblWorksOn w on e.empSSN = w.empSSN group by e.empSSN having SUM(w.workHours) is not null)

--12. Cho biết những nhân viên nào lần đầu tiên tham gia dụ án. Thông tin yêu cầu: mã nhân viên, tên
--nhân viên, tên phòng ban của nhân viên
select e.empSSN, e.empName, d.depName from tblEmployee e full join tblDepartment d on e.depNum = d.depNum 
full join tblWorksOn w on e.empSSN = w.empSSN
group by e.empSSN, e.empName, d.depName having count(w.proNum) = 1

--13. Cho biết những nhân viên nào tham gia tối thiểu hai dụ án. Thông tin yêu cầu: mã nhân viên, tên
--nhân viên, tên phòng ban của nhân viên
select e.empSSN, e.empName, d.depName from tblEmployee e full join tblDepartment d on e.depNum = d.depNum 
full join tblWorksOn w on e.empSSN = w.empSSN
group by e.empSSN, e.empName, d.depName having count(w.proNum) >= 2

--14. Cho biết tổng số giờ làm của mỗi dự án. Thông tin yêu cầu: mã dự án, tên dự án, tổng số giờ làm
select w.proNum, p.proName, sum(w.workHours) as [Tổng số giờ làm]from tblWorksOn w full join tblProject p on w.proNum = p.proNum 
group by w.proNum, p.proName

--15. Cho biết dự án nào có số lượng thành viên là nhiều nhất. Thông tin yêu cầu: mã dự án, tên dự
--án, số lượng thành viên
select p.proNum, p.proName, count(p.proName) as [Số lượng thành viên] from tblProject p full join tblWorksOn w on p.proNum = w.proNum
group by p.proNum, p.proName having count(p.proName) 
>= ALL(select count(p.proName) as [NoOfEmps] from tblProject p full join tblWorksOn w on p.proNum = w.proNum
group by p.proNum, p.proName)

--16. Cho biết dự án nào có tổng số giờ làm là nhiều nhất. Thông tin yêu cầu: mã dự án, tên dự án,
--tổng số giờ làm
select w.proNum, p.proName, sum(w.workHours) as [Tổng số giờ làm]from tblWorksOn w full join tblProject p on w.proNum = p.proNum 
group by w.proNum, p.proName having sum(w.workHours)
>= ALL (select sum(w.workHours) as [Total]from tblWorksOn w full join tblProject p on w.proNum = p.proNum 
group by w.proNum, p.proName)

--17. Cho biết số lượng chỗ làm việc theo mỗi phòng ban. Thông tin yêu cầu: mã phòng ban, tên
--phòng ban, số lượng chỗ làm việc
select d.depNum, d.depName, count(l.locNum) as [Số lượng chỗ làm việc] 
from tblDepLocation l full join tblDepartment d on d.depNum = l.depNum
group by d.depNum, d.depName

--18. Cho biết phòng ban nào có it chỗ làm việc nhất. Thông tin yêu cầu: mã phòng ban, tên phòng
--ban, số lượng chỗ làm việc
select d.depNum, d.depName, count(e.depNum) as [Số lượng chỗ làm việc] from tblEmployee e full join tblDepartment d on e.depNum = d.depNum
group by d.depNum, d.depName having count(e.depNum) 
<= ALL(select count(e.depNum) from tblEmployee e full join tblDepartment d on e.depNum = d.depNum
group by d.depNum, d.depName)

--19. Cho biết địa điểm nào có ít phòng ban làm việc nhất. Thông tin yêu cầu: tên nơi làm việc, số
--lượng phòng ban
select l.locName, count(d.depNum) as [Số lượng phòng ban] from tblDepLocation dn full join tblDepartment d on d.depNum = dn.depNum
full join tblLocation l on dn.locNum = l.locNum 
group by l.locName having count(d.depNum) 
<= ALL (select count(d.depNum) from tblDepLocation dn full join tblDepartment d on d.depNum = dn.depNum
full join tblLocation l on dn.locNum = l.locNum 
group by l.locName) 

--20. Cho biết nhân viên nào có ít người phụ thuộc nhất. Thông tin yêu cầu: mã số, họ tên nhân viên,
--số lượng người phụ thuộc
select e.empSSN, e.empName, count(d.empSSN) as [Số lượng người phụ thuộc] from tblEmployee e full join tblDependent d on e.empSSN = d.empSSN
group by e.empSSN, e.empName having count(d.empSSN) <= ALL(select count(d.empSSN) from tblEmployee e full join tblDependent d on e.empSSN = d.empSSN
group by e.empSSN, e.empName)