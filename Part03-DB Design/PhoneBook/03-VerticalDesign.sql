use DBDesign_PhoneBook

create table PhonebookV3_1
(
	Nick nvarchar(30),
	Phone char(11), -- chỉ 1 số phone thôi
)
--MỞ RỘNG TABLE THEO CHIỀU DỌC, AI CÓ NHÌU SIM THÌ THÊM DÒNG

SELECT * FROM PhonebookV3_1

insert into PhonebookV3_1 values (N'CuongNP','0898x')

insert into PhonebookV3_1 values (N'AnNguyen', '090x')
insert into PhonebookV3_1 values (N'AnNguyen', '091x')

insert into PhonebookV3_1 values (N'BinhLe', '090x')
insert into PhonebookV3_1 values (N'BinhLe', '091x')
insert into PhonebookV3_1 values (N'BinhLe', '092x')

SELECT * FROM PhonebookV3_1

--PHÂN TÍCH: 
--  ƯU ĐIỂM: Select phone là ra đc tất cả các số luôn
-- Thống kê số lượng sô điện thoại mỗi người xài, mấy simm???NGON
select Nick, count(Phone) as [Number of Phones] from PhonebookV3_1 group by Nick
select Nick, count(*) as [Number of Phones] from PhonebookV3_1 group by Nick

-- Ko bị NULL, Muốn thêm bao nhiêu phone cho ai thì thêm!!!


--  NHƯỢC ĐIỂM:
-- KO BIẾT SỐ PHONE X THUỘC LOẠI NÀO!!!???
-- *Cho tui biết số để bàn ở nhà của anh BinhLe???
-- *In cho tui số di động của mọi người???

-- VI PHẠM PK, REDUNDANCY, CuongNP LẶP LẠI NHIỀU LẦN LÀM GÌ KHI CuongNP MỚI LƯU NICK THOI CÒN CHƯA CÓ FULLNAME, TITLE, TÊN CTY, EMAIL, ... 

--TRIẾT LÝ THIẾT KẾ: CỐ GẮNG GIỮ NGUYÊN CÁI TỦ, CHỈ THÊM ĐỒ, KO THÊM CỘT CỦA TABLE, CHỈ CẦN THÊM DÒNG NẾU CÓ BIẾN ĐỘNG

--TRÁNH BỊ REDUNDANCY, PK ==> TÁCH BẢNG, PHẦN LẶP LẠI RA 1 CHỖ KHÁC

----------------------------------------------------------------------------------------------
--TA CẦN GIẢI QUYẾT PHONE NÀY THUỘC LOẠI NÀO ???

create table PhonebookV3_2
(
	Nick nvarchar(30),
	Phone char(11), -- chỉ 1 số phone thôi, cần giải nghĩa thêm số này là gì
	PhoneType nvarchar(20) -- 090x Home, 091x Work
)

insert into PhonebookV3_2 values (N'CuongNP', '0898x', 'Cell')

insert into PhonebookV3_2 values (N'AnNguyen', '090x', 'CELL')
insert into PhonebookV3_2 values (N'AnNguyen', '091x', 'Home')

insert into PhonebookV3_2 values (N'BinhLe', '090x', 'Work')
insert into PhonebookV3_2 values (N'BinhLe', '091x', 'cell')
insert into PhonebookV3_2 values (N'BinhLe', '092x', 'cell')

select * from PhonebookV3_2

--PHÂN TÍCH: 
--  ƯU ĐIỂM: 
-- Count() ngon, GROUP BY theo Nick, theo loại Phone
-- Where theo loại Phone cũng ngon luôn
select * from PhonebookV3_2 where PhoneType = 'Cell'

--  NHƯỢC ĐIỂM:
-- REDUNDANCY trên info của nick/fullname/cty/email/năm sinh...

--MỘT KHI BỊ TRÙNG LẶP INFO, LẶP LẠI INFO, REDUNDANCY, CHỈ CÓ 1 SOLUTION KO CHO TRÙNG
--TỨC LÀ XUẤT HIỆN 1 LẦN, TỨC LÀ RA BẢNG KHÁC
-->DECOMPOSITION (PHÂN RÃ)

