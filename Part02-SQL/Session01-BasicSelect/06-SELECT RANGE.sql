Use Northwind
----------------------------------------------------------------------
-- Lý Thuyết

-- #CÚ PHÁP MỞ RỘNG LỆNH SELECT
-- #Khi cần lọc dữ liệu trong 1 đoạn cho trước, thay vì dùng >= ... and <= ..., ta có thể thay thế
-- bằng mệnh đề between, in
-- #CÚ PHÁP: CỘT BETWEEN VALUE-1 AND VALUE-2
--           >>>> Between thay thế cho 2 mệnh đề >=, <=, and
-- #CÚ PHÁP: CỘT IN (1 TẬP CÁC GIÁ TRỊ ĐC LIỆT KÊ CÁCH NHAU BẰNG CÁCH DẤU PHẨY) 
----------------------------------------------------------------------

-- 1. Liệt kê dsnv sinh trong đoạn [1960-1970]
select * from Employees where Year(BirthDate) >= 1960 and Year(BirthDate) <= 1970 order by BirthDate DESC
select * from Employees where Year(BirthDate) between 1960 and 1970 order by BirthDate DESC

-- 2. Liệt kê các đơn hàng có trọng lượng từ 100 đến 500
select * from Orders where Freight between 100 and 500 order by Freight DESC
select * from Orders where Freight >= 100 and Freight <= 500 order by Freight DESC

-- 3. Liệt kê các đơn hàng gửi tới Anh, Pháp, Mĩ
select * from Orders where ShipCountry = 'USA' or ShipCountry = 'France' or ShipCountry = 'UK'
select * from Orders where ShipCountry in( 'USA', 'France', 'UK')

-- 4. Liệt kê các đơn hàng KHÔNG gửi tới Anh, Pháp, Mĩ
select * from Orders where ShipCountry NOT in( 'USA', 'France', 'UK')
select * from Orders where NOT (ShipCountry = 'USA' or ShipCountry = 'France' or ShipCountry = 'UK')

-- 5. Liệt kê các đơn hàng trong năm 1966 ngoại trừ các tháng 6, 7, 8, 9
select * from Orders where YEAR(OrderDate) = 1996 and MONTH(OrderDate) not between 6 and 9
select * from Orders where YEAR(OrderDate) = 1996 and MONTH(OrderDate) not in (6, 7, 8, 9)

-- LƯU Ý CHO 'IN': CHỈ KHI TA LIỆT KÊ ĐƯỢC CÁC TẬP GIÁ TRỊ THÌ MỚI CHỚI
--                 CÒN KHOẢNG SỐ THỰC THÌ KO LÀM ĐC

-- 6. Liệt kê các đơn hàng có trọng lượng từ 100 đến 110
select * from Orders where Freight between 100 and 110 order by Freight DESC
select * from Orders where Freight >= 100 and Freight <= 110 order by Freight DESC
-- #Từ 100 đến 110 có vô số giá trị thực nên không thể xài 'IN'



