create database DBDesign_OneTable
--create dùng để tạo cấu trúc lưu trữ/dàn khung/thùng chứa dùng lưu trữ data/info
--tương đương với việc cât phòng chứa đồ - DATABASE
--                  mua tủ ở trong phòng - TABLE
-- 1 DB chứa nhiều TABLE - 1 phòng có nhiều tủ 
--                       - 1 nhà có nhiều phòng
--Tạo ra cấu trúc lưu trữ - chưa nói data bỏ vào - DDL (PHÂN NHÁNH CỦA SQL)


use DBDesign_OneTable
drop table StudentV1
--Tạo table lưu trữ hồ sơ sinh viên: Mã số (phân biệt các SV với nhau), tên, dob, địa chỉ ...
--1 SV ~~~ 1 Object ~~~ 1 Entity
--1 Table DÙNG LƯU TRỮ NHIỀU Entity
create table StudentV1
(
	StudentID char(8),
	LastName nvarchar(40),  --tại sao ko lưu fullname
	FirstName nvarchar(10), --n : lưu kí tự Unicode
	DOB datetime,
	[Address] nvarchar(50)
)
--THAO TÁC TRÊN DATA/MÓN ĐỒ TRONG TỦ/TABLE - DML/DQL (dành cho SELECT)
select * from StudentV1 -- gõ thường okayyy
SELECT * FROM StudentV1 -- GÕ CHUẢN

--Đưa Data vào TABLE /mua đồ bỏ vao tủ quần áo
INSERT INTO StudentV1 VALUEs('SE123456', N'Nguyễn', N'An', '2003-1-1', N'... TP.Hồ Chí Minh') -- ĐƯA HẾT VÀO CÁC CỘT, SV FULL KO CHE VỀ THÔNG TIN

-- MỘT SỐ CỘT CHƯA THÈM NHẬP INFO, ĐƯỢC QUYÊN BỎ TRỐNG NẾU CỘT CHO PHÉP TRỐNG VALUE - DEFAULT
-- DEFAULT KHI ĐÓNG CÁI TỦ/MUA TỦ/THIẾT KẾ TỦ, MẶC ĐỊNH NULL
INSERT INTO StudentV1 VALUEs('SE123457', N'Lê', N'Bình', '2003-2-1', NULL) 

-- Tên TP là null, where = 'Null' vẫn okay vì nó là data
-- where ở câu trên là where is not null
INSERT INTO StudentV1 VALUEs('SE123458', N'Võ', N'Cường', '2003-3-1', 'NULL') 

--Tôi chỉ muốn lưu vài info, ko đủ số cột, miễn cột còn lại cho phép trống
INSERT INTO StudentV1(StudentID, LastName, FirstName)
			VALUEs('SE123459', N'Trần', N'Dũng') 

INSERT INTO StudentV1(LastName, FirstName, StudentID)
			VALUEs(N'Phạm', N'Em', 'SE123460') 

INSERT INTO StudentV1(LastName, FirstName, StudentID)
			VALUEs(null, null, null)  --SIÊU NGUY HIỂM, SV TOÀN INFO TOÀN BỎ TRỐNG/NULL
									  --GÀI CÁCH ĐƯA DATA VÀO CÁC CỘT SAO CHO HỢP LÍ
									  --CONSTRAINT TRÊN DATA, VALUE, CELL, COLUMN
select * from StudentV1

--NGUY HIỂM LỚN HƠN!!!!!!!!!!!!!
--TRÙNG MÃ SỐ KO CHẤP NHẬN ĐƯỢC, KO XÁC ĐỊNH ĐƯỢC 1 SINH VIÊN --GÀI RÀNG BUỘC DỮ LIỆU QUAN TRỌNG NÀY
															  --CỘT MÀ CẤM TRÙNG TRÊN MỌI CELL CÙNG CỘT
															  --DÙNG LÀM KEY/CHÌA KHÓA ĐỂ XÁC ĐỊNH, TÌM RA 
															  --DUY NHẤT MỘT INFO, MỘT DÒNG, MỘT SV, 1 ENTITY, 1 OBJECT
															  --CỘT NÀY LÀ CỘT PRIMARY KEY
INSERT INTO StudentV1(LastName, FirstName, StudentID)
			VALUEs(N'Đỗ', N'Giang', 'SE123460')

SELECT * FROM StudentV1 WHERE StudentID = 'SE123460'

--GÀI CÁCH ĐƯA DATA VÀO TABLE ĐỂ KO CÓ NHỮNG HIỆN TƯỢNG BẤT THƯỜNG (1 DÒNG TRỐNG TRƠN, KEY TRÙNG)
--KEY NULL - DEFAULT THIẾT KẾ CHO PHÉP NULL TẤT CẢ
--GÀI CONSTRAINTS
create table StudentV2
(
	StudentID char(8) PRIMARY KEY, --BAO HÀM LUÔN NOT NULL, BUỘC PHẢI ĐƯA DATA, CẤM TRÙNG
	LastName nvarchar(40) NOT NULL,  --tại sao ko lưu fullname
	FirstName nvarchar(10) NOT NULL, --n : lưu kí tự Unicode, (*) như registration/sign uo
	DOB datetime,
	[Address] nvarchar(50)
)

INSERT INTO StudentV2 VALUEs('SE123456', N'Nguyễn', N'An', '2003-1-1', N'... TP.Hồ Chí Minh') -- ĐƯA HẾT VÀO CÁC CỘT, SV FULL KO CHE VỀ THÔNG TIN

--Thử qua mặt
INSERT INTO StudentV2(StudentID, LastName, FirstName)
			VALUEs(null, null, null) --gãy liền

--Thử trùng mssv - cũng gãy luôn
INSERT INTO StudentV2 VALUEs('SE123456', N'Nguyễn', N'An', '2003-1-1', N'... TP.Hồ Chí Minh') -- ĐƯA HẾT VÀO CÁC CỘT, SV FULL KO CHE VỀ THÔNG TIN

INSERT INTO StudentV2 VALUEs('GD123456', N'Nguyễn', N'An', '2003-1-1', N'... TP.Hồ Chí Minh') -- ĐƯA HẾT VÀO CÁC CỘT, SV FULL KO CHE VỀ THÔNG TIN

INSERT INTO StudentV2 VALUEs('SE123457', N'Lê', N'Bình', '2003-2-1', NULL) 

INSERT INTO StudentV2 VALUEs('SE123458', N'Võ', N'Cường', NULL, NULL) 

INSERT INTO StudentV2(StudentID, LastName, FirstName)
			VALUEs('SE123459', N'Trần', N'Dũng') 

INSERT INTO StudentV2
			VALUEs(null, null, null, null, null) --gãy liền 3 chỗ null

select * from StudentV2

create table StudentV3
(
	StudentID char(8) NOT NULL PRIMARY KEY, --BAO HÀM LUÔN NOT NULL, BUỘC PHẢI ĐƯA DATA, CẤM TRÙNG
	LastName nvarchar(40) NOT NULL,  --tại sao ko lưu fullname
	FirstName nvarchar(10) NOT NULL, --n : lưu kí tự Unicode, (*) như registration/sign uo
	DOB datetime NULL,				 --THỪA TỪ NULL, DO DEFAULT ĐÃ LÀ VẬY
	[Address] nvarchar(50) NULL
)

create table StudentV4
(
	StudentID char(8) NOT NULL, --BAO HÀM LUÔN NOT NULL, BUỘC PHẢI ĐƯA DATA, CẤM TRÙNG
	LastName nvarchar(40) NOT NULL,  --tại sao ko lưu fullname
	FirstName nvarchar(10) NOT NULL, --n : lưu kí tự Unicode, (*) như registration/sign uo
	DOB datetime NULL,
	[Address] nvarchar(50) NULL,
	PRIMARY KEY (StudentID)
)

INSERT INTO StudentV4 VALUEs('SE123456', N'Nguyễn', N'An', '2003-1-1', N'... TP.Hồ Chí Minh') -- ĐƯA HẾT VÀO CÁC CỘT, SV FULL KO CHE VỀ THÔNG TIN
select * from StudentV4

--GENERATE TỪ ERD TRONG TOOL THIẾT KẾ
CREATE TABLE StudentV5 (
  StudentID char(8) NOT NULL, 
  LastName  varchar(50) NOT NULL, 
  FirstName varchar(10) NOT NULL, 
  PRIMARY KEY (StudentID));

  SELECT * FROM StudentV5
  -------------------------------------------------------------
  -- HỌC THÊM VỀ CÁI CONSTRAINTS - TRONG ĐÓ PK CONSTRAINT
  -- Ràng buộc là cách ta/DB Designer ép cell/cột nào đó value phải như thế nào
  -- Đặt ra quy tắc/rule cho việc nhập data
  -- Vì có rất nhiều quy tắc, nên tránh nhầm lẫn, dễ kiểm soat ta sẽ có quyên 
  -- đặt tên cho các quy tắc, constraint name
  -- Tên ràng buộc/quy tắc + nội dung/cái data đc gài vào
  -- PK_StudentID		     PRIMARY KEY
  -- Mặc định các DB Engine nó tự đặt tên cho các ràng buộc mà nó thấy khi bạn gõ lệnh DDL
  -- DB Engine cho mình cơ chế tự đặt tên ràng buộc 

  create table StudentV6
(
	StudentID char(8) NOT NULL, 
	LastName nvarchar(40) NOT NULL,
	FirstName nvarchar(10) NOT NULL,
	DOB datetime NULL,
	[Address] nvarchar(50) NULL,
	--PRIMARY KEY (StudentID)      -- tự DB Engine đặt tên cho ràng buộc
	Constraint PK_STUDENTS PRIMARY KEY (StudentID)
)
-- Dân pro đôi khi còn làm cách sau, ngta tách hẳn việc tạo ràng buộc khóa chính ra khỏi cấu trúc TABLE
-- Tức là CREATE TABLE chỉ chứa tên cấu trúc -CỘT -DOMAIN
-- LÀ CÁCH TẠO TABLE RỒI CHỈNH SỬA TABLE - SỬA CÁI TỦ  CHỨ KO PHẢI SỬA DATA TRONG CÁI TỦ
DROP TABLE StudentV7
  create table StudentV7
(
	StudentID char(8) NOT NULL, 
	LastName nvarchar(40) NOT NULL,
	FirstName nvarchar(10) NOT NULL,
	DOB datetime NULL,
	[Address] nvarchar(50) NULL,
	--PRIMARY KEY (StudentID)      -- tự DB Engine đặt tên cho ràng buộc
	--Constraint PK_STUDENTSV7 PRIMARY KEY (StudentID)
)

ALTER TABLE StudentV7 ADD CONSTRAINT PK_STUDENTSV7 PRIMARY KEY (StudentID)

--XÓA ĐƯỢC 1 RÀNG BUỘC, CHO ADD ĐC THÌ DROP ĐC
ALTER TABLE StudentV7 DROP CONSTRAINT PK_STUDENTSV7
