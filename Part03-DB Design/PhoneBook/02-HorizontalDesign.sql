use DBDesign_PhoneBook

drop table PhonebookV2
create table PhonebookV2
(
	Nick nvarchar(30),
	--Phone varchar(50) -- cấm đa trị, cấm gộp nhiều số phone trong 1 cell
	HomePhone char(11), -- chỉ 1 số phone thôi
	WorkPhone char(11),
	CellPhone char(11)  
)
--MỞ RỘNG THEO TABLE THEO CHIỀU NGANG - THÊM CỘT

create table PhonebookV3
(
	Nick nvarchar(30),
	--Phone varchar(50) -- cấm đa trị, cấm gộp nhiều số phone trong 1 cell
	Phone1 char(11), -- chỉ 1 số phone thôi
	Phone2 char(11),
	Phone3 char(11)  -- ko biết cột nào loại nào, 1, 2, 3 vô hồn

)

SELECT * FROM PhonebookV2

insert into PhonebookV2 values (N'CuongNP', null, null,'0898x')
--An có 2 số phone sao mà lưu
insert into PhonebookV2 values (N'AnNguyen', '090x', '091x', null)
--Bình có 3 số phone ? Do độ rộng của số phone là 50
insert into PhonebookV2 values (N'BinhLe', '090x', '091x', '092x')
insert into PhonebookV2 values (N'CuongVo', '090x', '091x', '092x')
insert into PhonebookV2 values (N'DungPham', '090x' ,'091x', '092x')

select * from PhonebookV2
--PHÂN TÍCH: 
--  ƯU ĐIỂM: Select phone là ra đc tất cả các số di động luôn
--  1.SQL. Cho tui biết các số di động của mọi người
select Nick, CellPhone from PhonebookV2
select p.Nick, p.CellPhone from PhonebookV2 p
-- *Cho tui biết số để bàn ở nhà của anh BinhLe???
-- Số để bàn = số ở nhà
select p.Nick, p.HomePhone, p.CellPhone from PhonebookV2 p
where Nick = 'BinhLe'

--  NHƯỢC ĐIỂM:
-- Thống kê số lượng sô điện thoại mỗi người xài, mấy simm??? Ko trả lời đc
-- DATA BỊ NULL, Phí không gian lưu trữ
-- Người có 4, 5 sô phone thì sao??? 
-- Solution: thêm cột, càng thêm cột trừ hao về người có nhiều phone
--           thì những người còn lại bị NULL rất nhiều
-->Phí vì chỉ 1 vài người đặc biệt có nhiều phone mà tất cả anh em khác đc xem chung là nhiều phone
-->PHÍ KHÔNG GIAN LƯU TRỮ
-->GIẢ SỬ QUYẾT TÂM NỞ THEO CỘT, NỞ CỘT RA, THÌ PHẢI TRẢ GIÁ LÀ SỬA CODE LẬP TRÌNH
-->SAU NÀY, VÌ TÊN CỘT MỚI ĐƯỢC THÊM DÔ KHI NÂNG CẤP APP, SỬA THÊM CÂU QUERY

--TRIẾT LÝ THIẾT KẾ: CỐ GẮNG GIỮ NGUYÊN CÁI TỦ, CHỈ THÊM ĐỒ, KO THÊM CỘT CỦA TABLE, CHỈ CẦN THÊM DÒNG NẾU CÓ BIẾN ĐỘNG



