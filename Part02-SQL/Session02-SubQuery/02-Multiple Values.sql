Use Northwind
----------------------------------------------------------------------
-- Lý Thuyết

-- #CÚ PHÁP CHUẨN CỦA LỆNH SELECT
-- SELECT * FROM <TABLE> WHERE ...
-- WHERE CỘT = VALUE NÀO ĐÓ
-- WHERE CỘT IN (TẬP HỢP CÁC GIÁ TRỊ ĐC LIỆT KÊ) VD: where city in ('London', 'Paris', 'Berlin')
--                                                              = 'London' or city = '...' or ...
-- *Nếu có 1 câu sql mà trả về đc 1 cột, nhiều dòng ~~ 1 tập hợp
-- SELECT CITY FROM EMPLOYEES, BẠN ĐC 1 LOẠT CÁC T/P
-- #TA CÓ THỂ LỒNG/NHÉT 1 CỘT/NHIỀU DÒNG VÀO BÊN TRONG MỆNH ĐỀ IN CỦA CÂU SQL BÊN NGOÀI
-- *CÚ PHÁP
-- WHERE CỘT IN (MỘT CÂU SELECT TRẢ VỀ 1 CỘT NHIỀU DÒNG - NHIỀU VALUE CÙNG KIỂU - TẬP HỢP)
----------------------------------------------------------------------
--THỰC HÀNH

-- 1. Liệt kê các nhóm hàng
select * from Categories

-- 2. In ra các món hàng thuộc nhóm 1, 6 và 8
select * from Products where CategoryID in (1, 6, 8) order by CategoryID ASC
select * from Products where CategoryID = 1 or CategoryID =  6 or CategoryID = 8 order by CategoryID ASC

-- 3. In ra các nhóm thuộc nhóm bia, rượu, thịt và hải sản
select * from Products where CategoryID in (
select CategoryID from Categories where CategoryName in ('Beverages', 'Meat/Poultry', 'Seafood') ) 
order by CategoryID ASC

-- 4. Nhân viên quê London phụ trách đơn hàng nào
select * from Employees 
select * from Orders where EmployeeID in (select EmployeeID from Employees where City = 'London') 
order by EmployeeID