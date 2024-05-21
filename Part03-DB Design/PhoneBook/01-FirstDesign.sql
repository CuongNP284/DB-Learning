Create database DBDesign_PhoneBook
use DBDesign_PhoneBook

drop table PhonebookV1
create table PhonebookV1
(
	Nick nvarchar(30),
	Phone varchar(50) -- 3 số phone gom vào 1 cột
)

insert into PhonebookV1 values (N'CuongNP', '0898x')
--An có 2 số phone sao mà lưu
insert into PhonebookV1 values (N'AnNguyen', '090x, 091x')
--Bình có 3 số phone ? Do độ rộng của số phone là 50
insert into PhonebookV1 values (N'BinhLe', '090x; 091x; 092x')

select * from PhonebookV1
--PHÂN TÍCH: 
--  ƯU ĐIỂM: Select phone là ra đc tất cả các số di động

-- *Cho tui biết số để bàn ở nhà của anh BinhLe ==> toang
-- Đáp án: Quy ước số đầu tiên là số để bàn, số 2 là sô di động, số 3 là for work
-- Khốn nạn vì quy ước ngầm, số nào là loại nào!!!
-- Khó nhớ cho người nhập liệu
-- *In cho tui số di động của mọi người

insert into PhonebookV1 values (N'CuongVo', '090x| 091x| 092x')
insert into PhonebookV1 values (N'DungPham', '090x - 091x - 092x')

-- Tiêu chí cắt chuỗi - DELIMITER (DẤU PHÂN CÁCH) KHÔNG NHẤT QUÁN
-- Quy ước ngầm về nhập dấu phân cách
-- Đếm xem mỗi người có bao nhiêu số phone!!! Count() quá quen
-- Khó cho việc count bởi những dấu phân cách!!!
-- KHÓ KHĂN XẢY RA KHI TA GOM NHIỀU VALUE CÙNG KIỂU, CÙNG NGỮ NGHĨA VÀO TRONG 1 COLUMN
-- (CỘT PHONE LƯU NHÌU SỐ CÁCH NHAU BỞI DẤU CÁCH)
-- GẤY KHÓ KHĂN CHO NHÂP DỮ LIỆU (KO NHẤT QUÁN DẤU CÁCH), KHI SELECT VÀ COUNT() THỐNG KÊ THEO 1 TIÊU CHÍ
-- UPDATE THÊM PHONE MỚI, XÓA SỐ CŨ

-- MỘT CELL MÀ CHỨA NHIỀU VALUE CÙNG KIỂU, ĐƯỢC GỌI LÀ CỘT ĐA TRỊ (MULTIVALUED)
-- ==>Tiềm ẩn khó khăn cho việc xử lý data

-- NẾU 1 TABLE CÓ CỘT ĐA TRỊ NGƯỜI TA NÓI RẰNG NÓ KHÔNG ĐẠT LEVEL CHUẨN 1
-- ==> 1st NORMALIZATION

-- CHUẨN 1: CHẤT LƯỢNG THIẾT KẾ TÍNH TỪ 1, 2, 3, ...

--THIẾT KẾ KÉM THÌ PHẢI NÂNG CẤP, KO CHƠI ĐA TRỊ!!!
--KO CHƠI GOM VALUE TRONG 1 CELL
--2 CHIẾN LƯỢC FIX: CHIỀU NGANG (THÊM CỘT) VÀ CHIỀU DỌC (THÊM DÒNG ĐC ƯU TIÊN HƠN CẢ)
