SELECT * FROM Club

SELECT * FROM Student

SELECT * FROM Registration

-- Thực hành

-- 1. Liệt kê thông tin sinh viên đang theo học
SELECT * FROM Student

-- 2. Liệt kê thông tin SV đang theo học kèm theo CLB cậu í đang tham gia
-- Output 1: Mã SV, Tên SV, Mã CLB
-- Output 2: Mã SV, Tên SV, Mã CLB, tên CLB

select s.StudentID, s.FirstName + ' '+ s.LastName as FullName, r.ClubID 
from Student AS s join Registration AS r on s.StudentID = r.StudentID
-- vì join = nên thiếu những SV ko tham gia CLB

select s.StudentID, s.FirstName + ' '+ s.LastName as FullName, r.ClubID 
from Student AS s left outer join Registration AS r on s.StudentID = r.StudentID

-- 3. In ra thông tin tham gia CLB của SV
-- Output: Mã SV, Tên SV, Mã CLB, tên CLB, Joined Date
select s.StudentID, s.FirstName + ' '+ s.LastName as FullName, c.ClubID, c.ClubName, r.JoinedDate 
from Student s full join Registration r
on s.StudentID = r.StudentID
full join Club c on c.ClubID = r.ClubID 

-- BTVN:

-- 1. Đếm số CLB mà mỗi SV tham gia
-- Output: Mã SV, Tên SV, Số-CLB-tham gia
select s.StudentID, s.FirstName + ' '+ s.LastName as FullName ,count(r.RegID) as [No of Club]
from Student s full join Registration r
on s.StudentID = r.StudentID
group by s.StudentID, s.FirstName, s.LastName

 -- 2. SV SE1 tham gia mấy CLB
 -- Output: Mã SV, Tên SV, Số-CLB-tham gia
select s.StudentID, s.FirstName + ' '+ s.LastName as FullName ,count(r.RegID) as [No of Club]
from Student s full join Registration r
on s.StudentID = r.StudentID
group by s.StudentID, s.FirstName, s.LastName
having s.StudentID = 'SE1'

-- 3. SV nào tham gia nhiều CLB nhất
select s.StudentID, s.FirstName + ' '+ s.LastName as FullName ,count(r.RegID) as [No of Club]
from Student s full join Registration r
on s.StudentID = r.StudentID
group by s.StudentID, s.FirstName, s.LastName
having count (*) >= all (select count(r.RegID) as [No of Club]
from Student s full join Registration r
on s.StudentID = r.StudentID
group by s.StudentID)

-- 4. CLB SiTi có những SV nào tham gia
select s.StudentID, s.FirstName + ' '+ s.LastName as FullName, c.ClubName 
from Student s full join Registration r
on s.StudentID = r.StudentID
full join Club c on c.ClubID = r.ClubID 
where c.ClubName = N'Cộng đồng Sinh viên Tình nguyện'

-- 5. Mỗi CLB có nhiu thành viên
-- Output: MÃ CLB, Tên CLB, Số TV

select *
from Student s full join Registration r
on s.StudentID = r.StudentID
right join Club c on c.ClubID = r.ClubID

select c.ClubID, c.ClubName, count(s.StudentID) as [No of Members]
from Student s full join Registration r
on s.StudentID = r.StudentID
right join Club c on c.ClubID = r.ClubID
group by c.ClubID, c.ClubName

-- 6.. CLB nào đông nhất
-- Output: MÃ CLB, Tên CLB, Số TV
select c.ClubID, c.ClubName, count(s.StudentID) as [No of Members]
from Student s full join Registration r
on s.StudentID = r.StudentID
right join Club c on c.ClubID = r.ClubID
group by c.ClubID, c.ClubName having count(s.StudentID) >= all 
(select count(s.StudentID)
from Student s full join Registration r
on s.StudentID = r.StudentID
right join Club c on c.ClubID = r.ClubID
group by c.ClubID, c.ClubName)

-- 7. CLB Siti và CSG có bnhiu member 
-- Output: MÃ CLB, Tên CLB, Số TV
select c.ClubID, c.ClubName, count(s.StudentID) as [No of Members]
from Student s full join Registration r
on s.StudentID = r.StudentID
right join Club c on c.ClubID = r.ClubID
group by c.ClubID, c.ClubName 
having c.ClubID in ('Siti', 'CSG')

select c.ClubID, c.ClubName, count(s.StudentID) as [No of Members]
from Student s full join Registration r
on s.StudentID = r.StudentID
right join Club c on c.ClubID = r.ClubID
group by c.ClubID, c.ClubName 
having c.ClubName = N'CLB Truyền thông Cóc Sài Gòn' or c.ClubName = N'Cộng đồng Sinh viên Tình nguyện'

-- 8. CÓ tổng cộng bnhiu lượt SV tham gia CLB
select * from Student s left join Registration r 
on s.StudentID = r.StudentID

select s.StudentID, count(r.ClubID) as [No of Clubs] from Student s left join Registration r 
on s.StudentID = r.StudentID
group by s.StudentID
