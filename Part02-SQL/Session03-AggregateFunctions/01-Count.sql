Use Northwind
----------------------------------------------------------------------
-- Lý Thuyết
-- #DB ENGINE hỗ trợ 1 loạt nhóm dùng để thao tác trên nhóm dòng/cột, gom data và tính toán lun
-- *Đây là nhóm hàm gom nhóm - AGGREGATE FUNCTIONS, AGGREGATION
-- COUNT() SUM() MIN() MAX() AVG()

-- *CÚ PHÁP CHUẨN
-- SELECT CỘT ..., HÀM GOM NHÓM(), ... FROM <TABLE>

-- *CÚ PHÁP MỞ RỘNG

-- SELECT CỘT ..., HÀM GOM NHÓM(), ... FROM <TABLE>... WHERE ... GROUP BY (GOM THEO CỤM CỘT NÀO)

-- SELECT CỘT ..., HÀM GOM NHÓM(), ... FROM <TABLE>... WHERE ... GROUP BY (GOM THEO CỤM CỘT NÀO) HAVING ...

-- #HÀM COUNT() ĐẾM SỐ LẦN XUẤT HIỆN CỦA 1 CÁI GÌ ĐÓ
--      COUNT(*)                    : ĐẾM SỐ DÒNG TRONG TABLE, đếm tất cả ko care tiêu chuẩn nào cả
--      COUNT(*) from ... where ... : Chọn ra/filter những tiêu chí where nào đó trước đã, rồi mới đếm

--      COUNT(CỘT NÀO ĐÓ):
----------------------------------------------------------------------
--THỰC HÀNH

-- 1. In ra dsnv
select * from Employees

-- 2. Đếm xem có nhiu nhân viên
select count(*) as [Tổng số nhân viên] from Employees

-- 3. Có bnhiu nhân viên ở London
select count(*) as [No of Emps from London] from Employees where City = 'London'

-- 4. Có bnhiu lượt thành phố xuật hiện, cứ xuất hiện tên tp là đếm, ko care có lặp lại hoay ko
select count(City) from Employees

-- 5. Đếm xem có bnhiu region
select count(Region) from Employees
-- #PHÁT HIỆN HÀM COUNT(CỘT) NẾU CELL CỦA CỘT CHỨA NULL THÌ KO TÍNH, KO ĐẾM

-- 6. Đếm xem có nhiu khu vực Null, trống, có nhiu dòng
select count(*) from Employees where Region is Null  -- đếm sự xuất hiện dòng chứa Region null
select count(Region) from Employees where Region is Null  -- 0, null ko đếm đc, ko value

-- 7. Có nhiu thành phố mà các nhân viên đến từ
select distinct City from Employees
-- *Coi kq trên là 1 table 

-- SUB QUERY MỚI, COI 1 CÂU SELECT LÀ 1 TABLE, BIẾN TABLE NÀY VÀO TRONG MỆNH ĐỀ FROM
select COUNT(*) AS NOoCity 
from (select distinct City from Employees) AS CITIES --đặt tên giả để select đển from <Table>

select count(*) from Employees -- 9NV
select count(City) from Employees -- 9TP

select count(distinct City) as [No of Cities] from Employees

-- 8. Đếm xem mỗi thành phố có bnhiu nhân viên
-- LƯU Ý: KHI CÂU HỎI CÓ TÍNH TOÁN GOM DATA (HÀM AGGRIGATE) MÀ LẠI CHỨA TỪ KHÓA 'MỖI' THÌ CÁCH VIẾT SẼ THAY ĐỔI
-- GẶP TỪ 'MỖI', CHÍNH LÀ CHIA ĐỂ ĐÉM, CHIA ĐỂ TRỊ, CHIA CỤM ĐỂ GOM VÀ ĐẾM
select * from Employees

-- Seattle: 2 | Tacoma: 1 | Kirkland: 1 |  Redmond: 1 | London: 4
-- Sự xuất hiện của nhóm
-- Đếm theo sự xuất hiện của nhóm, count++ trong mỗi nhóm, sau đó reset ở nhóm mới
select count(City) from Employees group by City -- Đếm Value của City, nhưng đếm theo nhóm
                                                -- Chia City thành nhóm, rồi đếm trong nhóm

select City, count(City) as [No of Emps] from Employees group by City

-- CHỐT HẠ: KHI XÀI HÀM GOM NHÓM, BẠN CÓ QUYỀN LIỆT KÊ CỘT Ở SELECT NHƯNG CỘT LẺ ĐÓ
--          BẮT BUỘC PHẢI XUẤT HIỆN TRONG MỆNH ĐỀ GROUP BY ĐỂ ĐẢM BẢO
--          LOGIC: CỘT HIỂN THỊ | SỐ LƯỢNG ĐI KÈM, ĐẾM GOM THEO CỘT HIỂN THỊ MỚI LOGIC
-- CỨ THEO CỘT CITY MÀ GOM, CỘT CITY NẰM Ở SELECT LÀ HỢP LÝ
-- MUỐN HIỂN THỊ SÔ LƯỢNG CỦA AI ĐÓ, GÌ ĐÓ, THÌ GOM NHÓM THEO CÁI GÌ ĐÓ

-- NẾU BẠN GOM THEO KEY/PK THÌ VÔ NGHĨA VÌ KEY KO BAO GIỜ TRÙNG, MỖI THẰNG 1 NHÓM KO THỂ ĐẾM
-- VD: IN MSSV, ĐẾM CÁI CHI ?? - MÃ CHUYEN NGÀNH - ĐẾM SỐ NV CHUYÊN NGÀNH,...
-- CÓ 1 CỘT ĐỂ GOM NHÓM, THÌ CỘT ĐÓ SẼ ĐỂ HIỂN THỊ SỐ LƯỢNG KẾT QUẢ
select City, count(City) as [No of Emps] from Employees group by City

-- 9. Thành phố nào có từ 2 nhân viên trở lên
-- 9.1 Các tp có bnhiu nhân viên
select City, count(*) as [No of Emps] from Employees group by City

-- 9.2 Đếm xong, ta lọc kết quả sau đếm
-- FILTER SAU ĐẾM, WHERE SAU ĐẾM, WHERE SAU KHI ĐÃ GOM NHÓM, AGGREGATE THÌ GỌI LÀ HAVING
select City, count(*) as [No of Emps] from Employees group by City HAVING count(*) >= 2

-- 10. Đếm số nhân viên của hai thành phố Seattle và London
select City, count(City) as [No of Emps] from Employees where City in ('London', 'Seattle') group by City

-- 11. Trong 2 tp London và Seatle, tp nào có nhiều hơn 3 NV
select City, count(City) as [No of Emps] from Employees 
										 where City in ('London', 'Seattle') 
										 group by City 
										 having count(City) >=3

-- HOMEWORK. Thành phố có nhiều nhần viên nhất
select City, count(*) as [The City] from Employees group by City HAVING count(*) >= ALL 
(select count(*) from Employees group by City)

-- 12. Đếm xem có bnhiu đơn hàng đã bán ra
select count(*) as [No of Orders] from Orders
select count(OrderID) as [No of Orders] from Orders -- lưu ý cột có value NULL

-- 12.1. Nước Mĩ có bnhiu đơn hàng (filter lọc nước Mỹ, ko phải chia nhóm, tại ko phải mỗi)
select count(*) [No of Orders from USA] from Orders where ShipCountry = 'USA'

-- 12.2. Mĩ, Anh, Pháp, Chiếm tổng cộng bao nhiêu đơn hàng
select count(*) as [Order UUF] from Orders where ShipCountry in ('USA', 'UK', 'France')
select count(*) as [Order UUF] from Orders where ShipCountry = 'USA'
											or   ShipCountry = 'UK' 
											or   ShipCountry = 'France'

-- 12.3. Mĩ, Anh, Pháp mỗi quốc gia có bnhiu đơn hàng 
select ShipCountry, count(*) as [No of Orders] from Orders 
where ShipCountry in ('USA', 'UK', 'France') group by ShipCountry

-- 12.4. Trong 3 quốc gia trên, quốc gia nào có 100 đơn hàng trở lên
select ShipCountry, count(*) as [No of Orders] from Orders 
where ShipCountry in ('USA', 'UK', 'France') group by ShipCountry
having count(*) >= 100

-- 12.5. Trong 3 quốc gia trên, quốc gia nào nhiều đơn hàng nhất
select ShipCountry, count(*) as [No of Orders] from Orders 
where ShipCountry in ('USA', 'UK', 'France') group by ShipCountry
having count(*) >= all 
(select count(*) from Orders 
where ShipCountry in ('USA', 'UK', 'France') group by ShipCountry )

-- HOMEWORK. Quốc gia nào có nhiều đơn hàng nhất
select ShipCountry, count(*) as [No of Orders] from Orders group by ShipCountry 
Having count(*) >= All (select count(*) from Orders group by ShipCountry )

-- 13. Đếm xem có bnhiu mặt hàng trong kho
select count(ProductID) as [Total Products] from Products

-- 14. Đếm xem có bnhiu lượt quốc gia đã mua hàng
select count(*) from Customers

-- 15. Đếm xem có bnhiu quốc gia đã mua hàng (tính 1 lần)
select count(*) from Customers group by Country
select count(Country) as [Num of Nations] from 
( select distinct Country from Customers group by Country ) as [Num]

-- 16. Đếm SL đơn hàng của mỗi quốc gia
select ShipCountry, count(ShipCountry) as [Num of Orders] from Orders group by ShipCountry

-- 17. Quốc gia nào có từ 10 đơn hàng trở lên
select ShipCountry from Orders group by ShipCountry having count(*) > 10

-- 18. Đếm xem mỗi chủng loại hàng có bnhiu mặt hàng (Bia có 5, hải sản có 10)
select CategoryID, count(*) as [Total Categories] from Products group by CategoryID
select CategoryID, CategoryName  from Categories

select c.CategoryName, count(*) as [Total Categories] from Products p inner join Categories c
on p.CategoryID = c.CategoryID group by c.CategoryID, c.CategoryName


