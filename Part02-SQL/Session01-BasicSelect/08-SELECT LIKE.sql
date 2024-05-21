Use Northwind
----------------------------------------------------------------------
-- Lý Thuyết

-- #CÚ PHÁP MỞ RỘNG LỆNH SELECT
-- #Ta muốn tìm/filter dữ liệu theo kiểu gần đúng trên chuỗi
-- VD: Tìm tên An != tên bắt đầu bằng chữ A
-- Tìm đúng, toán tử = 'AN'
-- Tìm gần đúng, tìm có sự xuất hiện, ko dùng toán tử =, DÙNG TOÁN TỬ LIKE
--               LIKE 'A...'...
-- #ĐỂ SỬ DỤNG TOÁN TỬ LIKE, TA CẦN THÊM 2 THỨ TRỢ GIÚP
-- DẤU % (đại diện cho chuỗi bất kì nào đó) VÀ DẤU _ (ký tự nào đó)
-- VD: Name LIKE 'A%', BẤT KÌ AI CÓ TÊN XUẤT HIỆN BẰNG CHỮ A, PHẦN CÒN LẠI LÀ GÌ KO CARE
--     Name LIKE 'A_', BẤT KÌ AI CÓ TÊN 2 KÍ TỰ, MÀ KÝ TỰ ĐẦU PHẢI LÀ CHỮ 'A'
----------------------------------------------------------------------

-- 1. In ra dsnv
select * from Employees

-- 2. In ra dsnv có tên bắt đầu bằng chữ A
select * from Employees where FirstName = 'A%'     -- 0 vì toán tử so sánh bằng A%, có ai tên như vậy ko
select * from Employees where FirstName like 'A%'  -- 2

-- 2.1. In ra dsnv có tên bắt đầu bằng chữ A và in ra full name
select EmployeeID, FirstName + ' ' + LastName as [Full name], Title from Employees where FirstName like 'A%'
select EmployeeID, CONCAT(FirstName, ' ', LastName) as [Full name], Title from Employees where FirstName like 'A%'

-- 3. Nhân viên nào có tên chữ A cuối cùng
select * from Employees where FirstName like '%A'
select EmployeeID, FirstName + ' ' + LastName as [Full name], Title from Employees where FirstName like '%A'

-- 4. In ra dsnv tên có 4 kí tự
select * from Employees where FirstName like '____'
-- #Dùng hàm ktra độ dài tên có bằng 4 hay ko
select * from Employees where LEN(FirstName) = 4

-- 5. Xem ds các sản phẩm đang có
select * from Products

-- 6. Xem ds các sản phẩm đang có bắt đầu bằng từ CH
select * from Products where ProductName like 'Ch%'
select * from Products where ProductName like '%Ch%' -- chỉ cần có chữ ch thoi, ko quan tâm vị trí

-- 7. Xem ds các sản phẩm đang có chứa 5 kí tự
select * from Products where ProductName like '_____'

-- 8. Xem ds các sản phẩm đang có chứa 5 kí tự ở cuối cùng
select * from Products where ProductName like '%_____'  -- tên có 5 kí tự trở lên

select * from Products where ProductName like '% _____' -- tên có ít nhất 2 từ và từ cuối là 5 kí tự 
                                                        -- còn những từ ko biết, vô tình loại đi tên đúng 5 kí tự

select * from Products where ProductName like '% _____' or ProductName like '_____'