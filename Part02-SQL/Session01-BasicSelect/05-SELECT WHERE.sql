Use Northwind
----------------------------------------------------------------------
-- Lý Thuyết

-- #CÚ PHÁP MỞ RỘNG LỆNH SELECT
-- #Mệnh đề Where: Dùng làm bộ lọc/filter/nhặt ra những dữ liệu theo 1 tiêu chí nào đó
-- Sample: Lọc ra những SV ở TPHCM, Lọc ra những SV ở Hà Nội và có đtb >= 8.0

-- #Cú pháp dùng bộ lọc
-- #SELECT * (CỘT-BẠN-MUỐN-IN) FROM <TÊN-TABLE> WHERE <ĐIỀU-KIỆN-LỌC>
-- *ĐK lọc: chính là tìm từng dòng với cái cột có giá trị cần lọc, lọc theo tên cột với value thế nào
--          lấy tên cột, xem value trong cell có thỏa đk lọc hay ko ?

-- Để viết đk lọc ta cần
-- #tên cột
-- #value của cột (cell) 
-- #toán tử (operation) > >= < <= = (1 dấu =, ko giống C Java ==), !=, <> (!= hoặc <> cùng ý nghĩa)
-- *nếu có nhiều đk lọc đi kèm, dùng thêm logic operatiors, AND, OR, NOT (&&, ||, !)
-- VD: where City = N'TPHCM'
--	   where City = N'TPHCM' and GPA >= 8.0
-- Lọc liên quan đến giá trị/value/cell chứa gì, ta phải quan tâm đến data types
-- #Số: nguyên/thực, ghi ra như truyền thống 5 , 10, 15, 29, 3.14, 9.8
-- #Chuỗi/kí tự: 'Ahihi', 'a'
-- #Ngày/tháng: '2004-01-01 ...'
----------------------------------------------------------------------

-- #THỰC HÀNH
-- 1. In ra danh sách các khách hàng
select * from Customers

-- 2. In ra dskh đến từ Ý
select * from Customers where Country = 'Italy'

-- 3. In ra dskh đến từ Mĩ	
select * from Customers where Country = 'USA'

-- 4. In ra dskh đến từ Mĩ cũng như Ý	
select * from Customers where Country = 'USA' or Country = 'Italy' -- hiểu nghĩa logic, hơn tiếng việt
select * from Customers where Country = 'USA' and Country = 'Italy'

-- select * from Customers where Country = 'USA' and 'Italy' ==> Error do thiếu toán tử so sánh

--sort theo USA và Italy để cho ng dùng dễ nhìn
select * from Customers where Country = 'USA' or Country = 'Italy' order by Country

-- 5. In ra dskh đến từ thủ đô nước Đức
select * from Customers where Country = 'Germany' and City = 'Berlin'

-- 6. In ra dsnv
select * from Employees

-- 7. In ra dsnv có năm sinh từ 1960 đến gần đây
select * from Employees where Year(BirthDate) >= 1960

-- 8. In ra thông tin nhân viên có tuổi từ 60 trở lên :(8/9)
select Year(Getdate()) - year(BirthDate) as Age, * from Employees where (Year(Getdate()) - year(BirthDate)) >= 60 order by Age

-- 9. Những nhân viên nào ở London
select * from Employees where City = 'London'

-- 10. Những nhân viên nào không ở London
select * from Employees where City != 'London'
select * from Employees where City <> 'London'
-- vi diệu
-- Đảo mệnh đề !!!
select * from Employees where NOT (City = 'London')
-- select * from Employees where ! (City = 'London') ==> sai cú pháp, đảo mệnh đề, phép so sánh thì dùng NOT

-- 11. In ra dsnv có mã số là 1 -- vì là kiểu số nên ko có ' ', chơi như lập trình
-- Where trên key chỉ ra 1 mà thôi
-- Select mà có key chỉ trả về 1 dòng, DISTINCT là vô nghĩa, order by cũng là vô nghĩa
select distinct EmployeeID, City from Employees where EmployeeID = 1

-- #CÔNG THỨC FULL KO CHE CỦA SELECT
-- SELECT (DISTINCT) ... FROM (1, HAY NHÌU TABLE) ...	WHERE ... GROUP BY ... HAVING ... ORDER BY
--        HÀM()
--        NESTED QUERY/SUB QUERY

-- 12. Xem thông tin của bên đơn hàng
select * from Orders

-- 13. Xem thông tin bên đơn hàng sắp xép giảm dần theo trọng lượng
select * from Orders order by Freight DESC

-- 14. In thông tin đơn hàng sắp xép giảm dần theo trọng lượng, trọng lượng >=500
select * from Orders where Freight >= 500 order by Freight DESC

-- 15, 16, 17. In thông tin đơn hàng sắp xép giảm dần theo trọng lượng, trọng lượng 100 =< x =< 500 && ship bởi cty số 1
-- và không ship tới London
select * from Orders where Freight >= 100 and Freight <=500 and ShipVia = 1 and ShipCity <> 'London' order by Freight DESC
select * from Orders where Freight >= 100 and Freight <=500 and ShipVia = 1 and NOT (ShipCity = 'London') order by Freight DESC

-- 18. Liệt kê các kh đên từ mỹ hoặc mexico
select * from Customers where Country = 'Mexico' or Country = 'USA'

-- 19. Liệt kê các kh không đên từ mỹ và mexico
select * from Customers where Country != 'Mexico' and Country <> 'USA'
select * from Customers where not(Country = 'Mexico' or Country = 'USA')

-- 20. In ra các nv sinh ra trong giai đoạn 1960 và 1970
select * from Employees where Year(BirthDate) >= 1960 and Year(BirthDate) <= 1970 order by BirthDate DESC

-- #RẤT CẨN THẬN KHI TRONG MỆNH ĐỀ WHERE LẠI CÓ AND OR TRỘN VỚI NHAU, T PHẢI XÀI () ĐỂ TA PHÂN TÁCH THỨ TỰ FILTER..
-- #(SS AND OR KHÁC NỮA) AND (SS KHÁC)