use DBDesign_PhoneBook


create table PhonebookV3_2
(
	Nick nvarchar(30), --ngoài cột này bị lặp lại, mình còn thêm cột fullname, tên cty, chức vụ
	-- ...CompanyName, ...
	Phone char(11), -- chỉ 1 số phone thôi, cần giải nghĩa thêm số này là gì
	PhoneType nvarchar(20) -- 090x Home, 091x Work
)

create table PersonV4_1
(
	Nick nvarchar(30), --ngoài cột này bị lặp lại, mình còn thêm cột fullname, tên cty, chức vụ
	Title nvarchar(30),
	CompanyName nvarchar(40)
)

--TÁCH BẢNG
--INFO BỊ PHÂN MẢNH, NẰM NHIỀU NƠI, PHẢI JOIN RỒI
--NHẬP DATA COI CHỪNG BỊ VÊNH, XÓA DATA COI CHỪNG LẠC TRÔI
--PHÂN MẢNH PHẢI CÓ LÚC TÁI NHẬP (JOIN) TRÊN 1 CỘT
--FK XUẤT HIỆN!!!
--KHÔNG THÍCH CHƠI FK, ĐƯỢC VÀ KO ĐC
--NẾU CHỈ CẦN JOIN THÌ KO CẦN FK, CỘT = VALUE, KHỚP LÀ JOIN, NỐI BẢNG, GHÉP NGANG
--NẾU KÈM THÊM XÓA, SỬA, THÊM THÌ SẼ CHẾT VÌ KHÔNG CÓ TÍNH NHẤT QUÁN

create table PhonebookV4_1
(
	Phone char(11), -- chỉ 1 số phone thôi, cần giải nghĩa thêm số này là gì
	PhoneType nvarchar(20), -- 090x Home, 091x Work
	Nick nvarchar(30) --KO CẦN FK, CHỈ CẦN JOIN LÀ OK
)

SELECT * FROM PhonebookV4_1
SELECT * FROM PersonV4_1

insert into PersonV4_1 values(N'CuongNP', 'Lecturer', 'FPTU HCMC')
insert into PersonV4_1 values(N'AnNguyen', 'Student', 'FPTU HCMC')
insert into PersonV4_1 values(N'BinhLe', 'Student', 'FPTU HL')

insert into PhonebookV4_1 values ('0898x','Cell', N'CuongNP')

insert into PhonebookV4_1 values ('090x', 'CELL', N'AnNguyen')
insert into PhonebookV4_1 values ('091x', 'Home', N'AnNguyen')

insert into PhonebookV4_1 values ('090x', 'Work', N'BinhLe')
insert into PhonebookV4_1 values ('091x', 'cell', N'BinhLe')
insert into PhonebookV4_1 values ('092x', 'cell', N'BinhLe')

--PHÂN TÍCH: 
--  ƯU ĐIỂM: 
-- Count() ngon, GROUP BY theo Nick, theo loại Phone
-- Where theo loại Phone cũng ngon luôn
-- REDUNDANCY trên info của nick/fullname/cty/email/năm sinh... giải quyết xong ở bảng person

--  NHƯỢC ĐIỂM:
-- Tính không nhất quán (inconsistency) của loại phone: có người gõ: cell, CELL, Cell ko sợ vì cùng là 1 kiểu
-- nhưng gõ thêm : Di động, DĐ -> nhưng đều là 1 nhưng máy hiểu khác nhau

-- Query liệt kê các số di động của tất cả mọi người, toang khi where
-- Vì ko biết đc có bnhiu cách nhập loại chữ biểu diễn cho Di Động
insert into PhonebookV4_1 values ('093x', 'Mobile', N'BinhLe')
insert into PhonebookV4_1 values ('094x', 'SugarDaddy', N'BinhLe')

--SQL: Liệt kê tất cả số di dộng của anh Binh Le
SELECT * FROM PhonebookV4_1
where PhoneType in ('cell', 'Mobile', 'SugarDaddy') and Nick = 'BinhLe'
--Tính in cái tập hợp này đến bao giờ khi ngta còn gõ những từ khác cùng nghĩa di động

--QUY TẮC THÊM: CÓ NHỮNG LOẠI DỮ LIỆU BIẾT TRƯỚC LÀ NHIỀU, NHƯNG HỮU HẠN VALUE ĐỂ NHẬP
--TỈNH THÀNH NHÌU, CHỈ 63
--QUỐC GIA NHÌU, CHỈ 230
--CHÂU LỤC NHÌU, CHỈ CÓ SỐ NHẤT ĐỊNH
--TRƯỜNG THPT NHÌU, CHỈ CÓ SỐ NHẤT ĐỊNH SAU THỐNG KÊ
-->Cho nên không cho người dùng gõ tay vì nó sẽ gây nên sự không nhất quán!!!
-->Tốt nhất cho chọn, mà chọn từ cái có sẵn, tức là sẵn từ 1 table khác

--KO CHO GÕ LUNG TUNG, GÕ TRONG CÁI ĐÃ CÓ
--DÍNH 2 THỨ: TABLE KHÁC (ĐÃ NÓI Ở TRÊN), FK ĐỂ ĐẢM BẢO CHỌN ĐÚNG TRONG ĐÓ	