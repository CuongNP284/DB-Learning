Use Northwind
----------------------------------------------------------------------
-- Lý Thuyết
-- #Một DB là nơi chứa data (bán hàng, thư viện, qlsv, ...)
-- #Data được lưu dưới dạng table, tách thành nhiều TABLE (Nghê thuật design DB, NF)
-- #Dùng lệnh SELECT để xem, in dữ liệu từ table, cx hiển thị dưới dạng table
-- #CÚ PHÁP CHUẨN: SELECT * FROM <TÊN-TABLE>
--                        * đại diện cho việc tui muốn lấy all of columns
-- #CÚ PHÁP MỞ RỘNG: SELECT TÊN-CÁC-CỘT-MUỐN-LẤY, CÁCH-NHAU-BỞI-DẤU-PHẨY FROM <TÊN-TABLE>
--                   SELECT CÓ THỂ DÙNG CÁC HÀM XỬ LÝ CÁC CỘT ĐỂ ĐỘ LẠI THÔNG TIN HIỂN THỊ FROM <TÊN-TABLE>

-- #Data trả về có cell/ô có NULL, hiểu rằng chưa xác định value/giá trị, chưa biết sẽ từ từ cập nhật sau
----------------------------------------------------------------------

-- 1. Xem thông tin của tất cả khách hàng đang có, đang giao dịch với mình
Select * From Customers
Insert into Customers(CustomerID, CompanyName, ContactName) 
       values('ALFKI' ,'FPTUniversity' ,'Thanh Nguyen Khac')
	   -- trùng khóa PK nên bị chửi

Insert into Customers(CustomerID, CompanyName, ContactName) 
       values('FPTU' ,'FPTUniversity' ,'Thanh Nguyen Khac')
	   -- ngon lành cành đào

-- 2. Xem thông tin nhân viên, xem full cột
Select * From Employees

-- 3. Xem các sản phẩm bán trong kho
Select * From Products

-- 4. Mua hàng thì thông tin sẽ nằm ở table Order và OrderDetails
Select * From Orders -- 830 bills

-- 5. Xem thông tin giao hàng
Select * From Shippers
Insert into Shippers(CompanyName, Phone) values ('Fedex Vietnam', '(084)909456895')

-- 6. Xem chi tiết đơn hàng
Select * From Orders              -- Phần trên của bill siêu thị
Select * From [Order Details]     -- Phần table kẻ giống lề những món hàng đã mua

-- 7. In ra thông tin khác hàng (ID, CompanyName, ContactName, Country)
Select CustomerID, CompanyName, ContactName, Country from Customers

-- 8. In ra thông tin của nhân viên
-- #Tên người tách thành last và first: dành cho mục tiêu sort theo theo tiêu chí tên, họ.
-- #In ra theo phong cách của từng quốc gia
Select * from Employees
Select EmployeeID, LastName, FirstName, Title, BirthDate from Employees

-- 9. In ra thông tin nhân viên, ghép tên cho đẹp/gộp cột, tính lun tuổi
Select EmployeeID, LastName + ' ' + FirstName as [Full name], Title, BirthDate from Employees

Select EmployeeID, LastName + ' ' + FirstName as [Full name], Title, YEAR(GETDATE()) - Year(BirthDate) as Age from Employees

-- 10. In ra thông tin chi tiết mua hàng
Select * From [Order Details]
--#Tính tổng tiền phải trả cho từng món, có trừ đi giảm giá, phần trăm
Select *, UnitPrice * Quantity * (1 - Discount) as Price From [Order Details]