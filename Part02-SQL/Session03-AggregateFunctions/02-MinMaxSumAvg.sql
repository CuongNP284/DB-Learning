Use Northwind
----------------------------------------------------------------------
-- Lý Thuyết
-- #DB ENGINE hỗ trợ 1 loạt nhóm dùng để thao tác trên nhóm dòng/cột, gom data và tính toán lun
-- *Đây là nhóm hàm gom nhóm - AGGREGATE FUNCTIONS, AGGREGATION
-- COUNT() SUM() MIN() MAX() AVG()

-- *CÚ PHÁP CHUẨN
-- SELECT CỘT ..., HÀM GOM NHÓM(), ... FROM <TABLE>
-- SELECT CỘT ..., HÀM GOM NHÓM(), ... FROM <TABLE> WHERE ... GROUP BY ... HAVING (WHERE THỨ 2) ...
----------------------------------------------------------------------
--THỰC HÀNH

-- 1. Liệt kê dsnv
select * from Employees

-- 2. Năm sinh nào là bé nhất ( tức là lớn tuổi nhất )
select Min(BirthDate) from Employees
select Max(BirthDate) from Employees

-- 3. Ai sinh năm bé nhất, ai lớn tuổi nhất, in ra info
select * from Employees where BirthDate = (select Min(BirthDate) from Employees)
select * from Employees where BirthDate <= all (select BirthDate from Employees)

-- 4. Trong các đơn hàng, đơn hàng nào có trọng lượng nặng nhất/nhỏ nhất
-- 4.1 Trọng lượng nào là lớn nhất trong các đơn hàng đã bán
select * from Orders order by Freight DESC
select Max(Freight) from Orders

select * from Orders where Freight = (select Max(Freight) from Orders)
select * from Orders where Freight >= all (select Freight from Orders)

-- 5. Tinh tổng khối lượng các đơn hàng đã vận chuyển
select * from Orders
select count(*) from Orders
select sum(Freight) as [Total Freight] from Orders

-- 6. Tính xem trung bình các đơn hàng nặng bao nhiu
select avg(Freight) as [AVG Freight] from Orders

-- 7. Liệt kê các đơn hàng có trọng lượng nặng hơn trọng lượng trung bình
select * from Orders where Freight 
>= (select avg(Freight) as [AVG Freight] from Orders) order by Freight DESC

-- 8. Có bao nhiêu đơn hàng, có trọng lượng nặng hơn trọng lượng trung bình của tất cả
select count(*) from Orders where Freight 
>= (select avg(Freight) as [AVG Freight] from Orders) -- chỉ những thằng lớn hơn TB thì mới đếm

select count(*) from (select * from Orders where Freight 
>= (select avg(Freight) as [AVG Freight] from Orders)) as [AVG]

-- Nhắc lại
-- Cột XH trong Select hàm ý đếm theo cột này, Cột phải XH trong GROUP BY
-- vd: tỉnh ,<đếm cái gì đó của tỉnh> ==> chi tỉnh đếm, GROUP BY TỈNH
--     chuyên ngành, <đếm của chngh>  ==> chỉ tính đếm, GROUP BY CHUYÊN NGÀNH
-- CÓ QUYỀN GROUP BY TRÊN NHIỀU CỘT
-- MÃ CHUYÊN NGÀNH, TÊN CHUYÊN NGÀNH, <SL SV> ==> GROUP BY MÃ CN, TÊN CN

-- Ôn tập thêm 
-- 1. In dsnv
select * from Employees order by Region

-- 2. Đếm xem mỗi khu vực có bnhiu nhân viên
select Region, count(Region) from Employees group by Region -- sai do ko đếm null
select Region, count(*) from Employees group by Region

-- 0 và 5, do Null ko thể đếm đc và ko đc xem là value, nhưng vẫn value để đc chia nhóm (vô danh - ko giá trị)

-- 3. Khảo sát đơn hàng
select * from Orders
-- Mỗi quốc gia có bnhiu đon hàng
select ShipCountry, count(*) as [No of Orders]from Orders group by ShipCountry

-- 4. Quốc gia nào có từ 50 đơn hàng trở lên
select ShipCountry, count(*) as [No of Orders]from Orders group by ShipCountry
having count(*) > 50 order by [No of Orders]

-- 4. Quốc gia nào có nhiều đơn hàng nhất
select ShipCountry, count(*) as [No of Orders]from Orders group by ShipCountry
having count(*) >= all (select count(*) from Orders group by ShipCountry)

select max([No of Orders]) from 
(select ShipCountry, count(*) as [No of Orders]from Orders group by ShipCountry) as [Cntry]

select ShipCountry, count(*) as [No of Orders]from Orders group by ShipCountry
having count(*) = 
(select max([No of Orders]) from 
(select ShipCountry, count(*) as [No of Orders]from Orders group by ShipCountry) as [Cntry]) 

-- 6. Liệt kê các đơn hàng của K/H 'Vinet'
select * from Orders where CustomerID = 'Vinet'

-- 7. K/H Vinet đã mua bnhiu lần
select CustomerID, count(*) as [Total] from Orders where CustomerID = 'Vinet' -- error

select CustomerID, count(*) as [Total] from Orders where CustomerID = 'Vinet' -- chia xong mà ko đếm
group by CustomerID -- đếm xong loại đi cái thằng ko là vinet

select CustomerID, count(*) as [Total] from Orders group by CustomerID having CustomerID = 'Vinet'

