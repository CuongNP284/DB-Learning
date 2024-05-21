SELECT * FROM Major
SELECT * FROM Student

--1. In ra thông tin chi tiết của SV kèm thông tin chuyên ngành
select * from Student -- info của SV và info tắt của chuyên ngành
SELECT * FROM Major   -- info của CN và thiếu info của Sinh viên
-- JOIN CẦM CHẮC RỒI, LẤY INFO NẰM Ở BÊN KIA GHÉP THÊM THEO CHIỀU NGANG 
select * from Student s, Major m
		 where s.MajorID = m.MajorID -- dư cột MajorID

select s.*, m.MajorName, m.Hotline from Student s, Major m
		 where s.MajorID = m.MajorID 

select s.*, m.MajorName, m.Hotline from Student s JOIN Major m
		 ON s.MajorID = m.MajorID 

-- 2. In ra thông tin chi tiết của SV và Info chuyên ngành, chỉ quan tâm SE và IA
select s.*, m.MajorName, m.Hotline from Student s JOIN Major m
		 ON s.MajorID = m.MajorID where s.MajorID in ('SE','IA')

select s.*, m.MajorName, m.Hotline from Student s JOIN Major m
		 ON s.MajorID = m.MajorID where s.MajorID = 'SE' or m.MajorID = 'IA'

select s.*, m.MajorID, m.MajorName, m.Hotline from Student s, Major m
		 where s.MajorID = m.MajorID and s.MajorID in ('SE','IA') -- s hay m chấm thì tương tự nhau

-- 3. In ra thông tin các SV kèm chuyên ngành. Chuyên ngành nào chưa có SV cũng phải in ra
select s.*, m.MajorName, m.Hotline from Student s Right JOIN Major m
		 ON s.MajorID = m.MajorID 

select s.*, m.* from Student s Right JOIN Major m
		 ON s.MajorID = m.MajorID -- 10 dòng

select s.*, m.* from Major m Right JOIN Student s
		 ON s.MajorID = m.MajorID -- 9 dòng

-- 5. Có bnhiu chuyên ngành
select count(*) as [No of Major] from Major
select count(MajorID) [No of Major] from Major

-- 6. Mỗi CN có bnhiu sinh viên
-- Output 0: Số lượng SV đang theo học từng chuyên ngành
-- Output 1: Mã CN | số lượng SV đang theo học
select count(*) as [No of Students] from Student group by MajorID
select MajorID, count(*) as [No of Students] from Student group by MajorID
select MajorID, count(MajorID) as [No of Students] from Student group by MajorID

-- 7. CN nào có từ 3 SV trở lên
select MajorID, count(MajorID) as [No of Students] from Student group by MajorID having count(MajorID) >= 3

-- 8. CN nào có ít SV nhất
select MajorID, count(MajorID) as [No of Students] from Student group by MajorID 
having count(MajorID) <= all(select count(*) from Student group by MajorID)

-- 9. Đếm số SV chuyên ngành SE
select MajorID, count(MajorID) as [No of Students] from Student group by MajorID having MajorID = 'SE'
-- Câu trên này chạy chậm cần nhanh hơn
select count(*) as [No of Students] from Student where MajorID = 'SE' -- Câu này chạy nhanh
select MajorID, count(*) as [No of Students] from Student where MajorID = 'SE' group by MajorID -- chỉ còn lại 1 nhóm

-- 10. Đếm số SV của mỗi CN
-- Output: Mã CN | Tên CN | SL sV
-- Cần 2 info trên 2 table, đếm trên 2 (đếm trong Major ko có info SV, đếm trong Student thì ko có tên CN)
-- Nên JOIN 2 bảng rr mới đếm
select MajorID, count(MajorID) as [No of Students] from Student group by MajorID

select m.MajorID, m.MajorName, count(*) as [No of Students]  
from Student s inner join Major m on s.MajorID = m.MajorID group by m.MajorID, m.MajorName

-- Câu 10 điểm nè
-- Còn CN tiếng Hàn
select s.StudentID, s.FirstName, m.MajorID, m.MajorName
from Student s right join Major m on s.MajorID = m.MajorID 

select m.MajorID, m.MajorName, count(MajorName) as [No of Students] 
from Student s right join Major m on s.MajorID = m.MajorID 
group by m.MajorID, m.MajorName -- Sai vì có 1 dòng HQ null vế SV
								-- count(1) có 1 dòng null, HQ có 1 SV là sai

select m.MajorID, m.MajorName, count(StudentID) as [No of Students] 
from Student s right join Major m on s.MajorID = m.MajorID 
group by m.MajorID, m.MajorName -- count null lại đúng trong trường hợp này
-- vì Mã SV NULL ứng với chuyên ngành HQ
-- count(*) chỉ cần có 1 dòng là ra số 1
-- chấp dòng có nhiều null hay ko
-- Đếm cell, cell null ==> 0

-- DASHBOARD MÀN HÌNH THỐNG KÊ CỦA CÁC ADMIN WEBSITE TUYỂN SINH