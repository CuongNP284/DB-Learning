Use Northwind
----------------------------------------------------------------------
-- Lý Thuyết

-- #CÚ PHÁP CHUẨN CỦA LỆNH SELECT
-- SELECT * FROM <TABLE> WHERE ...
-- WHERE CỘT-TOÁN-TỬ-SO-SÁNH VỚI VALUE-CẦN-LỌC
--       CỘT > >= < <= = !=  VỚI VALUE
--                           VỚI CÂU SUB-QUERY NẾU MUỐN
--       CỘT                 = (SUB CHỈ CÓ 1 VALUE)
--       CỘT                 IN (SUB CHỈ CÓ 1 CỘT NHƯNG NHIỀU VALUE)

--       CỘT > >= < <= ALL(SUB CHỈ CÓ 1 CỘT NHƯNG NHIỀU VALUE)
--       CỘT > >= < <= ANY(SUB CHỈ CÓ 1 CỘT NHƯNG NHIỀU VALUE)
----------------------------------------------------------------------
--THỰC HÀNH

-- Tạo 1 Table có 1 cột tên là Number, chỉ chứa 1 đống dòng các số nguyên
CREATE TABLE Num
(
	Number int
)
select * from Num
INSERT INTO Num VALUES (1)
INSERT INTO Num VALUES (1)
INSERT INTO Num VALUES (2)
INSERT INTO Num VALUES (9)
INSERT INTO Num VALUES (5)
INSERT INTO Num VALUES (100)
INSERT INTO Num VALUES (101)

-- 1. In ra những số lớn hơn 5
select * from Num where Number > 5

-- 2. In ra số lớn nhất trong các số đã nhập
-- #Số lớn nhất trong một đám đc định nghĩa là lớn hơn hết cả đám, và bằng chính mình
-- #lớn hơn tất cả, ngoại trừ chính mình ==> mình là MAX của cả đám
select * from Num where Number = 101 -- quá lầy lội
select * from Num where Number >= ALL(select * from Num)

-- 3. In ra số nhỏ nhất trong các số đã nhập
select * from Num where Number <= ALL(select * from Num)

-- 4. Nhân viên nào lớn tuổi nhất
select * from Employees where BirthDate <= All(select BirthDate from Employees)

-- 5. Đơn hàng có trọng lượng nặng nhất
select * from Orders where Freight >= ALL(select Freight from Orders)

SELECT ProductName
FROM Products
WHERE ProductID = ANY (SELECT ProductID FROM [Order Details] WHERE Quantity = 10);

SELECT ProductName
FROM Products
WHERE ProductID = ALL (SELECT ProductID FROM [Order Details] WHERE Quantity = 10);

