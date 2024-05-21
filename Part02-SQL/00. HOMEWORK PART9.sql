-- Homework Part9

-- 1. Các nhà cung cấp đến từ Mỹ cung cấp những mặt hàng nào
select ProductName from Products where SupplierID in 
(select SupplierID from Suppliers where Country = 'USA')

-- 2. Các nhà cung cấp đến từ Mỹ cung cấp những nhóm hàng nào
+
select CategoryName from Categories where CategoryID in (
select CategoryID from Products where SupplierID in 
(select SupplierID from Suppliers where Country = 'USA')
)

-- 3. Các đơn hàng vận chuyển tới thành phố Sao Paulo đc vận chuyển bởi những hãng nào
-- ~~ Các Cty nào đã vận chuyển chuyển hàng tới Sao Paulo
select CompanyName from Shippers where ShipperID in (
select ShipVia from Orders where ShipCity = 'Sao Paulo')

-- 4. Khách hàng đến từ tp Berlin, London, Madrid có những đơn hàng nào
-- ~~ Liệt kê các đơn hàng của khách hàng đến từ tp Berlin, London, Madrid
select OrderID from Orders where CustomerID in 
(select CustomerID from Customers where City in ('Berlin', 'London', 'Madrid')
)

-- 4.1 . Khách hàng đến từ tp Berlin, London, Madrid mua những mật hàng nào

select ProductName from Products where ProductID in(select ProductID from [Order Details] where OrderID in 
(select OrderID from Orders where CustomerID in 
(select CustomerID from Customers where City in ('Berlin', 'London', 'Madrid')
)))