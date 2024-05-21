Use Northwind
----------------------------------------------------------------------
-- Lý Thuyết

-- #CÚ PHÁP MỞ RỘNG LỆNH SELECT
-- #Có thể có những lúc dữ liệu/info chưa xác định được value, data, nhưng lúc sau sẽ từ từ update
-- *Ngta gọi giá trị chưa xác định này là NULL
-- #NULL ĐẠI DIỆN CHO THỨ CHƯA XÁC ĐỊNH TỨC LÀ CHƯA CÓ GIÁ TRỊ THÌ KHÔNG THỂ SO SÁNH >, >=, <, <=, =, !=
-- *CẤM TUYỆT ĐỐI XÀI CÁC TOÁN TỬ SO SÁNH KÈM VỚI GIÁ TRỊ NULL
-- *TA SẼ DÙNG TOÁN TỬ: IS NULL, IS NOT NULL, NOT (IS NULL) ĐỂ FILTER/LỌC CELL CÓ GIÁ TRỊ NULL
----------------------------------------------------------------------

-- 1.In ra dsnv
select * from Employees

-- 2. Ai chưa xác định khu vực ở, reion null
select * from Employees where Region = 'null' -- 0, vì ko ai ở khu vực null
select * from Employees where Region = null   -- 0, vì null ko thể dùng >, <, =
select * from Employees where Region is null

-- 3. Những ai xác định khu vực lưu trú
select * from Employees where Region is not null
select * from Employees where NOT (Region is null)

-- 4. Những nhân viên đã xác định đại diện kinh doanh và xác định nơi lưu trú	
select * from Employees where Title = 'Sales Representative' and Region is not null
select * from Employees where Title = 'Sales Representative' and not (Region is null)

-- 5. Liệt kê các khách hàng đến từ Anh, Pháp, Mĩ, có cả thông tin số fax và region
select * from Customers where Country in('France', 'USA', 'UK') and Fax is not null and Region is not null