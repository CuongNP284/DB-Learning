--PHẦN NÀY THÍ NGHIỆM CÁC LOẠI RÀNG BUỘC - CONSTRAINT - QUY TẮC GÀI TRÊN DATA

-- 1. RÀNG BUỘC PRIMARY KEY
-- Tạm thời hiểu PK là 1 cột (tương lai có thể có nhiều cột) mà giá trị của nó trên mọi dòng/mọi cell của cột này
-- không trùng lại, mục đích dùng để WHERE ra được 1 dòng duy nhất
-- VALUE CỦA KEY CÓ THỂ ĐC TẠO RA THEO 2 CÁCH:
-- CÁCH 1: TỰ NHẬP = TAY, DB ENGINE SẼ TỰ KIỂM TRA COI CÓ TRÙNG HAY KO?
--		   NẾU TRÙNG, DB ENGINE TỰ BÁO VI PHẠM  PK CONSTRAINT - HỌC RỒI - UI/UX

-- CÁCH 2: KO CẦN NHẬP = TAY CÁI VALUE CỦA PK, MÁY/DB ENGINE TỰ TẠO/GENERATE CHO MÌNH 1 CON SỐ KO TRÙNG LẠI!!! 
--         CON SỐ TỰ TĂNG, CON SỐ HEXA,...

--***Thực hành thử: 
--Thiết kế table lưu thông tin đăng kí event nào đó (google form)
--Thông tin cần lưu trữ: STT đăng kí, fullname, email, ngày giờ đăng kí, sđt.

--***PHÂN TÍCH
--Ngày giờ đăng kí: không bắt nhập, default 
--Số thự tự: không cần nhập, tự gán 
--Email, phone: Không cho trùng, 1 email 1 lần đăng kí 

USE DBDesign_OneTable
/*
CREATE TABLE Registration
(
	SEQ int PRIMARY KEY,      --Phải tự nhập STT, vớ vẩn
	FirstName nvarchar(10),
	LastName nvarchar(30),
	Email varchar(50),
	Phone varchar (10),
	RegDate datetime default GetDate() --CONSTRAINT DEFAULT

)*/

CREATE TABLE Registration
(
	SEQ int PRIMARY KEY IDENTITY, --MẶC ĐỊNH ĐI TỪ 1, NHẢY ++ CHO NGƯỜI SAU, IDENTITY(1, 5), TỪ 1, 6, 11.     
	FirstName nvarchar(10),
	LastName nvarchar(30),
	Email varchar(50),
	Phone varchar (10),
	RegDate datetime default GetDate() --CONSTRAINT DEFAULT

)

--ĐĂNG KÍ EVENT
INSERT INTO Registration VALUES (N'An', N'Nguyễn', 'annguyen123@gmail.com', '090x') 
--báo lỗi do ko match đc các cột rõ ràng
INSERT INTO Registration VALUES (N'An', N'Nguyễn', 'annguyen123@gmail.com', '090x', null) 

INSERT INTO Registration(FirstName, LastName, Email, Phone) 
VALUES (N'Bình', N'Lê', 'binhle124@gmail.com', '091x') 

--XÓA 1 DÒNG CÓ AUTO GENERATED KEY, THÌ TABLE SẼ LỦNG LỔ, DB ENGINE KO LẤP CHỖ LỦNG	

select * from Registration