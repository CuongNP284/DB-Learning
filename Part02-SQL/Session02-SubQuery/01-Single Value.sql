Use Northwind
----------------------------------------------------------------------
-- Lý Thuyết

-- #CÚ PHÁP CHUẨN CỦA LỆNH SELECT
-- SELECT * FROM <TABLE> WHERE ...
-- WHERE CỘT = VALUE NÀO ĐÓ
-- WHERE CỘT LIKE PATTERN NÀO ĐÓ e.g '_____'
-- WHERE CỘT BETWEEN RANGE 
-- WHERE CỘT IN (TẬP HỢP CÁC GIÁ TRỊ ĐC LIỆT KÊ)

-- # 1 CÂU SELECT TÙY CÁCH VIẾT THÌ CÓ THỂ TRẢ VỀ ĐÚNG 1 VALUE/CELL
-- # 1 CÂU SELECT TÙY CÁCH VIẾT THÌ CÓ THỂ TRẢ VỀ 1 TẬP VALUES/CELLS
-- Tập này kết quả đồng nhất (các giá trị khác nhau của 1 biến)

-- ****
-- WHERE CỘT = VALUE NÀO ĐÓ - ĐÃ HỌC, E.G YEAR(DOB) = 2004
--           = THAY VALUE NÀY BẰNG 1 CÂU SQL KHÁC MIỄN TRẢ VỀ 1 CELL
-- #KỸ THUẬT VIẾT CÂU SQL THEO KIỂU HỎI GIÁN TIẾP, LỒNG NHAU
-- TRONG CÂU SQL CHỨA CÂU SQL KHÁC
----------------------------------------------------------------------
--THỰC HÀNH

-- 1.In ra dsnv
select * from Employees
select FirstName from Employees where EmployeeID = 1  -- 1 VALUE
select FirstName from Employees -- 1 tập giá trị/1 cột/phép chiếu

-- 2. Liệt kê các nv ở London
select * from Employees where City = 'london'

-- 3. Liệt kê các nhân viên cùng quê với King Robert
select * from Employees where FirstName = 'robert'
select City from Employees where FirstName = 'robert' -- chỉ có 1 value là london
--ANSWER
select * from Employees where City = (select City from Employees where FirstName = 'robert')
-- trong kq vẫn còn robert, tìm cùng quê nhưng ko càn ghi
select * from Employees where City = (select City from Employees where FirstName = 'robert')
                        and FirstName <> 'Robert'

-- 4. Liệt kê các đơn hàng
select * from Orders order by Freight DESC

-- 4.1. Liệt kê các đơn hàng có trọng lượng lớn hơn 252kg
select * from Orders where Freight >= 252 order by Freight DESC

-- 4.2. Liệt kê các đơn hàng có trọng lượng lớn hơn trọng lượng đơn hàng 10555
select * from Orders where Freight >= (select Freight from Orders where OrderID = 10555
) and OrderID <> 10555 order by Freight DESC


