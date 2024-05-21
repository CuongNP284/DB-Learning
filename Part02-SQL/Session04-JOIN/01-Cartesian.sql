create DATABASE Cartesian
-- database tương đương với 1 thùng chứa, 1 cái kho	chứa data bên trong
-- Data bên trong đc cất dưới dạng kệ có ngăn - table

create TABLE EnDict -- DDL/Data Definition Language (một nhánh của SQL)
(
	Nmbr int,
	EnDesc varchar(30)
) -- từ điển tiếng anh số đếm 
-- Drop Table EnDict -- DDL/Data Definition Language (một nhánh của SQL) - xóa bảng
-- Chèn Data
select * from Endict -- DML/Data Manipuplation Language
insert into EnDict values (1, 'One')
insert into EnDict values (2, 'Two')
insert into EnDict values (3, 'Three')

-- PHẦN NÀY CHO THÊM OUTER JOIN
insert into EnDict values (4, 'Four')


create TABLE VnDict -- DDL/Data Definition Language (một nhánh của SQL)
(
	Nmbr int,
	VnDesc nvarchar(30) -- nvarchar() String lưu tiếng việt còn varchar() String lưu tiếng anh
) -- từ điển tiếng việt số đếm
--Drop Table VnDict -- DDL/Data Definition Language (một nhánh của SQL) - xóa bảng

insert into VnDict values (1, N'Một')
insert into VnDict values (2, N'Hai')
insert into VnDict values (3, N'Ba')

-- PHẦN NÀY CHO THÊM OUTER JOIN
insert into VnDict values (5, N'Năm')


select * from VnDict -- DML/Data Manipuplation Language
select * from Endict 
-- Bôi đen cả hai và chạy, thì nó không phải JOIN, nó là hai câu riêng biệt chạy cùng lúc, cho 2 tập kq riêng biệt
-- JOIN là gộp chung 1 bảng thành 1 bảng tạm trong ram ko ảnh hưởng dữ liệu gốc của mỗi table
-- JOIN là SELECT CÙNG LÚC NHIỀU TABLE VỚI NHAU
select * from VnDict, Endict -- sinh ra table mới, tạm thời lúc chạy
							 -- số cột = tổng hai bên và số dòng = tích hai bên
select * from VnDict, Endict order by EnDesc
select * from VnDict, Endict order by Nmbr

-- Khi ghép Table, JOIN bị trùng tên cột
-- Dùng ALIAS (AS), đặt tên giả để làm tham chiếu
-- Chỉ định cột thuộc table	Tránh nhầm
select * from VnDict, Endict order by VnDict.Nmbr -- tham chiếu cột qua tên table
select * from VnDict vn, Endict en order by en.Nmbr -- đặt tên ngắn/giả tên table, dùng tham chiếu cho các cột

select vn.Nmbr, vn.VnDesc, en.EnDesc from VnDict vn, Endict en order by en.Nmbr

select vn.*, en.EnDesc from VnDict vn, Endict en order by en.Nmbr

select vn.*, en.* from VnDict vn, Endict en order by en.Nmbr

-- CÚ PHÁP VIẾT THỨ 2 (CHUẨN)
select vn.*, en.EnDesc from VnDict vn CROSS JOIN Endict en order by en.Nmbr

-- Tui biết rằng có cặp ghép xài đc, vì có tương hợp trong CELL nào đó, HERE Nmbr
select * from VnDict vn, Endict en where vn.Nmbr = en.Nmbr
-- rút từ 3 x 3 = 9 còn 3
-- Ghép có chọn lọc khi tìm tương quan cột/cell để ghép ==> INNER/OUTER/EQUI JOIN
-- Đa phần tương quan ghép theo toán tử =, còn có thể ghép > >= < <= !=
