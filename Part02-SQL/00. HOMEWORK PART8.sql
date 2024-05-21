Use Northwind
-- HOMEWORK VID PART 08

-- 1. Liệt kê danh sách các công ty vận chuyển hàng
select CompanyName from Shippers

-- 2. Liệt kê danh sách các đơn hàng đc vận chuyển bởi cty giao vận mã số là 1
select * from Orders where ShipVia = 1 

-- 3. Liệt kê danh sách các đơn hàng đc vận chuyển bởi cty giao vận Speedy Express
select * from Orders where ShipVia = (select ShipperID from Shippers where CompanyName = 'Speedy Express' )

-- 4. Liệt kê danh sách các đơn hàng đc vận chuyển bởi cty giao vận Speedy Express và trọng lượng từ 50-100
select * from Orders where ShipVia = (select ShipperID from Shippers where CompanyName = 'Speedy Express' )
                           and Freight between 50 and 100 order by Freight DESC

-- 5. Liệt kê các mặt hàng có cùng chủng loại với filo mix
select * from Products where CategoryID = (select CategoryID from Categories where CategoryName = 
(select CategoryName from Categories where CategoryID = 
(select CategoryID from Products where ProductName = 'Filo mix')))
 and ProductName <> 'filo mix' -- tự làm

 select * from Products where CategoryID = 
(select CategoryID from Products where ProductName = 'Filo mix')
 and ProductName <> 'filo mix'

 -- 6. Liệt kê các nhân viên nhỏ hơn Janet
 -- Trẻ hơn nghĩa là năm sinh lớn hơn Jane
 select * from Employees where BirthDate > ( select BirthDate from Employees where FirstName = 'Janet') 