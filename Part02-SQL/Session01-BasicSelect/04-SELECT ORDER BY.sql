Use Northwind
----------------------------------------------------------------------
-- Lý Thuyết

-- #CÚ PHÁP MỞ RỘNG LỆNH SELECT
-- #Ta muốn sắp xếp dữ liệu/sort theo tiêu chí nào đó, thường là tăng dần - ASCENDING/ASC hay DESCENDING/DESC
-- #Mặc định không nói gì cả thi là sắp xếp tăng dần (A<B<C)
-- #Ta có thể sort trên nhiều cột, logic này từ từ tính
-- #SELECT ... FROM <TÊN-TABLE> ORDER BY TÊN-CỘT MUỐN SORT <KIỂU-SORT>

----------------------------------------------------------------------

-- 1. In ra danh sách nhân viên
Select * From Employees

-- 2. In ra dsnv tăng dần theo năm sinh
Select * From Employees order by BirthDate ASC
Select * From Employees order by BirthDate -- mặc định là tăng dần

-- 3. In ra dsnv giảm dần theo năm sinh
Select * From Employees order by BirthDate DESC

-- 4, 5. Tính tiền chi tiết mua hàng
Select *, UnitPrice * Quantity * (1 - Discount) as SubTotal From [Order Details] order by SubTotal DESC

-- 6. In ra dsnv giảm dần theo tuổi
Select *, YEAR(GETDATE()) - YEAR(BirthDate) as Age From Employees order by Age DESC