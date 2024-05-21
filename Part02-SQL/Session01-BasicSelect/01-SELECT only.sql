USE Northwind -- Chọn để chơi với thùng chứa data nào đó tại 1 thời điểm chơi với 1 thùng
			  -- chứa data (chú thích)

SELECT * FROM Customers

SELECT * FROM Employees
----------------------------------------------------------------------
-- Lý Thuyết
-- 1. DBE cung cấp câu lệnh SELECT dùng để in ra màn hình 1 cái gì đó
--  ~~~printf() sout() để in ra dữ liệu có trong table (hàng và cột)
-- dùng cho mục đích nào thì kết quả hiển thị luôn là 1 table
----------------------------------------------------------------------

-- 1. Hôm nay là ngày bao nhiêu?
Select GETDATE()

Select GETDATE() as [Hôm nay là ngày]

-- 2. Hôm nay là tháng mấy?
Select MONTH(GETDATE()) as [Hôm nay là tháng]

Select YEAR(GETDATE())

-- 3. Trị tuyệt đối của -5 là mấy?
Select ABS(-5) as [Trị tuyệt đối của -5 là]

-- 4. 5 + 5 là mấy?
Select 5 + 5 as [5 + 5 là]

-- 5. In ra tên của mình
Select N'Nguyễn Phú Cường' as [Tên tui là]
Select N'Nguyễn' + N' Phú Cường' as [Tên tui là]

-- 6. Tính tuổi
Select YEAR(GETDATE()) - 2004 as [Năm sinh của tui là]

-- Select N'Nguyễn' + N' Phú Cường' + (YEAR(GETDATE()) - 2004) + ' years old'
-- lỗi vì lẫn lộn kiểu dữ liệu data
Select N'Nguyễn' + N' Phú Cường ' + Convert(Varchar, YEAR(GETDATE()) - 2004) + ' years old' as [My profile]
Select N'Nguyễn' + N' Phú Cường ' + Cast( YEAR(GETDATE()) - 2004 as varchar) + ' years old'

-- 7. Phép nhân hai số
Select 10 * 10 as [10 x 10 =]
