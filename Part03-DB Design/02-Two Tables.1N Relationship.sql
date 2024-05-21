 create database DBDesign_OneMany

use DBDesign_OneMany

--Table 1 tạo trước, Table N tạo sau
create table MajorV1
(
	MajorID char(2) PRIMARY KEY, -- MẶC ĐỊNH DB ENGINE TỰ TẠO TÊN
	MajorName nvarchar(40)
)

--Chèn Data tức là mua quần áo bỏ vào tủ
INSERT INTO MajorV1 VALUES ('SE', N'Kĩ thuật phần mềm')
INSERT INTO MajorV1 VALUES ('IA', N'An toàn thông tin')

create table StudentV1
(
	StudentID char(8) NOT NULL, 
	LastName nvarchar(40) NOT NULL,
	FirstName nvarchar(10) NOT NULL,
	DOB datetime NULL,
	[Address] nvarchar(50) NULL,
	MjrID char(2) --tên cột khóa ngoại/tham chiếu ko cần trùng bên 1-Key, nhưng buộc trùng 100% kiểu dữ liệu, cần tham chiếu data

	Constraint PK_STUDENTSV1 PRIMARY KEY (StudentID)
)

--Chèn data cho sinh viên
select * from StudentV1
select * from MajorV1
insert into StudentV1 values('SE1', N'Nguyễn', N'An', null, null, 'SE')

--THIẾT KẾ TRÊN SAI VÌ KO CÓ THAM CHIẾU GIỮA MAJORID CỦA HAI BẢNG STUDENT VÀ MAJOR
insert into StudentV1 values('SE2', N'Lê', N'Bình', null, null, 'AH')

--Tạo Mới
create table MajorV2
(
	MajorID char(2) PRIMARY KEY, -- MẶC ĐỊNH DB ENGINE TỰ TẠO TÊN
	MajorName nvarchar(40)
)

create table StudentV2
(
	StudentID char(8) PRIMARY KEY, 
	LastName nvarchar(40) NOT NULL,
	FirstName nvarchar(10) NOT NULL,
	DOB datetime NULL,
	[Address] nvarchar(50) NULL,
	--MjrID char(2) REFERENCES MajorV2(MajorID)
	--Tớ chọn chuyên ngành ở tren bảng Major, xin tham chiếu trên bảng kia	
	MajorID char(2) FOREIGN KEY REFERENCES MajorV2(MajorID)
)

--Chèn Data tức là mua quần áo bỏ vào tủ
INSERT INTO MajorV2 VALUES ('SE', N'Kĩ thuật phần mềm')
INSERT INTO MajorV2 VALUES ('IA', N'An toàn thông tin')

insert into StudentV2 values('SE1', N'Nguyễn', N'An', null, null, 'SE')

--THIẾT KẾ TRÊN SAI VÌ KO CÓ THAM CHIẾU GIỮA MAJORID CỦA HAI BẢNG STUDENT VÀ MAJOR
insert into StudentV2 values('SE2', N'Lê', N'Bình', null, null, 'GD')

select * from StudentV2
select * from MajorV2

--KO ĐC XÓA TABLE 1 NẾU NÓ ĐANG ĐC THAM CHIẾU BỞI 1 TABLE KHÁC
--NẾU CÓ MỐI QUAN HỆ 1-N, XÓA N (STUDENT) TRƯỚC RỒI XÓA 1 SAU (MAJOR)

----------------------------------------------------------------------------------------------------------------------

--Thêm kỹ thuật viết khóa ngoại, y cahng cách viết của PK
create table MajorV3
(
	MajorID char(2) PRIMARY KEY, -- MẶC ĐỊNH DB ENGINE TỰ TẠO TÊN
	MajorName nvarchar(40)
)
DROP TABLE StudentV3
/*
create table StudentV3
(
	StudentID char(8) PRIMARY KEY, 
	LastName nvarchar(40) NOT NULL,
	FirstName nvarchar(10) NOT NULL,
	DOB datetime NULL,
	[Address] nvarchar(50) NULL,

	MajorID char(2),
	CONSTRAINT FK_STUDENTV3_MAJORV3 FOREIGN KEY (MajorID) REFERENCES MajorV3(MajorID)
)*/

create table StudentV3
(
	StudentID char(8) PRIMARY KEY, 
	LastName nvarchar(40) NOT NULL,
	FirstName nvarchar(10) NOT NULL,
	DOB datetime NULL,
	[Address] nvarchar(50) NULL,

	MajorID char(2) DEFAULT 'SE',
	CONSTRAINT FK_STUDENTV3_MAJORV3 
	FOREIGN KEY (MajorID) REFERENCES MajorV3(MajorID)
	ON DELETE SET DEFAULT 
	ON UPDATE CASCADE
)


--ALTER TABLE (TÊN) ADD CONSTRAINT ... CODE Ở TRÊN

--CHO SV KO CHỌN CN THÌ HẮN SẼ HỌC GÌ
insert into StudentV3(StudentID, LastName, FirstName) values('SE2', N'Phạm', N'Bình')


--TA CÓ QUYỀN GỠ 1 CÁI RÀNG BUỘC ĐÃ THIẾT LẬP!!!!
ALTER TABLE StudentV3 DROP CONSTRAINT FK_STUDENTV3_MAJORV3

--BỔ SUNG LẠI 1 RÀNG BUỘC KHÁC
ALTER TABLE StudentV3 ADD CONSTRAINT FK_STUDENTV3_MAJORV3 
FOREIGN KEY (MajorID) REFERENCES MajorV3(MajorID)

SELECT * FROM MajorV3
SELECT * FROM StudentV3
insert into StudentV3 values('SE1', N'Nguyễn', N'An', null, null, 'SE')
insert into StudentV3 values('AH1', N'Lê', N'Vui Vẻ', null, null, 'AH')


INSERT INTO MajorV3 VALUES ('SE', N'Kĩ thuật phần mềm')
INSERT INTO MajorV3 VALUES ('IA', N'An toàn thông tin')
INSERT INTO MajorV3 VALUES ('AH', N'Ahihi Đồ Ngốc')

--THAO TÁC MẠNH TAY TRÊN DATA/MÓN ĐỒ QUẦN ÁO TRONG TỦ - DML (UPDATE & DELETE)
DELETE FROM StudentV3 -- CỰC KÌ NGUY HIỂM KHI THIẾU WHERE, XÓA HẾT DATA TRONG TABLE !!!

DELETE FROM StudentV3 WHERE StudentID = 'AH1'

DELETE FROM MajorV3 WHERE MajorID = 'AH'

--GÀI THÊM HÀNH XỬ KHI XÓA, SỬA DATA Ở RÀNG BUỘC KHÓA NGOẠI/DÍNH LUÔN KHÓA CHÍNH LUÔN
--HIỆU ỨNG DOMINO, SỤP ĐỔ DÂY CHUYỀN, 1 XÓA LÀ N ĐI SẠCH,==> CASCADE DELETE
--                                   1 XÓA N BỊ SỬA THÊM ==> CASCADE UPDATE
--NGAY LÚC DESIGN/CREATE TABLE THÌ TA ĐÃ PHẢI TÍNH VỤ NÀY
--VẪN CÓ THỂ SỬA SAU NÀY KHI ĐÃ CÓ DATA, CÓ THỂ CÓ TRỤC TRẶC/TROUBLE
--CỤM LỆNH: CREATE/ALTER/DROP 

ALTER TABLE StudentV3 DROP CONSTRAINT FK_STUDENTV3_MAJORV3 --XÓA RÀNG BUỘC KHÓA NGOẠI BỊ THIẾU 
--VIỆC GÀI XÓA SỬA DATA CẦN THÊM VÀI RULE NHỎ LIÊN QUAN 

ALTER TABLE StudentV3 ADD CONSTRAINT FK_STUDENTV3_MAJORV3 
FOREIGN KEY (MajorID) REFERENCES MajorV3(MajorID)
ON DELETE CASCADE 
ON UPDATE CASCADE

--UPDATE DML, MẠNH MẼ, SỬA DATA ĐANG CÓ
UPDATE MajorV3 SET MajorID = 'AK' --CẨN THẬN NẾU KO CÓ WHERE, TOÀN BỘ TABLE BỊ THAY ĐỔI/ẢNH HƯỞNG

UPDATE MajorV3 SET MajorID = 'AK' WHERE MajorID = 'AH'

--SỤP ĐỔ, XÓA 1, N ĐI SẠCH
--XÓA CHUYÊN NGÀNH AHIHI
DELETE MajorV3 WHERE MajorID = 'AK'
--SV AH1 LÊ VUI VẺ LÊN ĐƯỜNG LUÔN

--CÒN 2 CÁI GÀI NỮA LIÊN QUAN ĐẾN TÍNH ĐỒNG BỘ/NHẮT QUÁN CỦA DATA/CONSISTENCY
--SET NULL VÀ DEFAULT
--KHI 1 XÓA, N VỀ NULL
--KHI 1 XÓA, N VỀ DEFAULT

--********CHỐT HẠ********
--XÓA BÊN 1 TỨC LÀ MẤT BÊN 1, KO LẼ SỤP ĐỔ CẢ ĐÁM BÊN N, KO HAY NÊN CHỌN ĐƯA N VỀ NULL
--UPDATE BÊN 1 TỨC LÀ BÊN 1 VẪN CÓ GIỮ DÒNG THÌ BÊN N NÊN ĐỒNG BỘ THEO, ĂN THEO, NÊN CASCADE

ALTER TABLE StudentV3 DROP CONSTRAINT FK_STUDENTV3_MAJORV3 --XÓA RÀNG BUỘC KHÓA NGOẠI BỊ THIẾU 
--VIỆC GÀI XÓA SỬA DATA CẦN THÊM VÀI RULE NHỎ LIÊN QUAN 

ALTER TABLE StudentV3 ADD CONSTRAINT FK_STUDENTV3_MAJORV3 
FOREIGN KEY (MajorID) REFERENCES MajorV3(MajorID)
ON DELETE SET NULL  -- XÓA THÌ CHO MỒ CÔI, BƠ VƠ, NULL, TỪ TỪ TÍNH SAU
ON UPDATE CASCADE   -- SỬA BỊ ẢNH HƯỞNG DÂY CHUYỀN

UPDATE MajorV3 SET MajorID = 'AK' WHERE MajorID = 'AH'
DELETE MajorV3 WHERE MajorID = 'AK'
--CHO SV NULL BƠ VƠ CHUYÊN NGÀNH VỀ HỌC NGÀNH SE
UPDATE StudentV3 SET MajorID = 'SE' -- TOANG VÌ CẢ TRƯỜNG SẼ HỌC NGÀNH SE
UPDATE StudentV3 SET MajorID = 'SE' WHERE StudentID = 'AH1' --ĐÚNG
UPDATE StudentV3 SET MajorID = 'SE' WHERE MajorID IS NULL

SELECT * FROM MajorV3
SELECT * FROM StudentV3