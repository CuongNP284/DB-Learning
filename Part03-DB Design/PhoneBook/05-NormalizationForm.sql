use DBDesign_PhoneBook

/* create table PersonV5_1
(
	Nick nvarchar(30), --ngoài cột này bị lặp lại, mình còn thêm cột fullname, tên cty, chức vụ
	Title nvarchar(30),
	CompanyName nvarchar(40)
)

create table PhonebookV5_1
(
	Phone char(11),
	PhoneType nvarchar(20), --CHO GÕ TRỰC TIẾP SẼ GÂY NÊN LỘN XỘN LOẠI PHONE (DĐ, CELL, MOBILE, ...)
							--KHÓ KHĂN CHO THỐNG KÊ, OR RẤT NHIỀU, DO CHO GÕ TỰ DO
							--HẠN CHẾ KO CHO GÕ LỘN XỘN, TỨC LÀ CHỌN THEO AI ĐÓ CÓ TRƯỚC, FK
	Nick nvarchar(30) --KO CẦN FK, CHỈ CẦN JOIN LÀ OK
)*/ --BÀI HỌC

create table PersonV5_1
(
	Nick nvarchar(30), --ngoài cột này bị lặp lại, mình còn thêm cột fullname, tên cty, chức vụ
	Title nvarchar(30),
	CompanyName nvarchar(40)
)

--TABLE MỚI XUÁT HIỆN, LƯU LOẠI PHONE KO CHO GÕ LUNG TUNG

CREATE TABLE PhoneTypeV5_1
(
	TypeName nvarchar(20) 
)
--KO MUỐN XÓA TABLE MÀ MUỐN THÊM KHÓA CHÍNH
ALTER TABLE PhoneTypeV5_1 ALTER COLUMN TypeName nvarchar(20) NOT NULL

ALTER TABLE PhoneTypeV5_1 ADD CONSTRAINT PK_PHONETYPEV51 
PRIMARY KEY(TypeName)

ALTER TABLE PhoneTypeV5_1 ADD
PRIMARY KEY(TypeName)

create table PhonebookV5_1
(
	Phone char(11),
	TypeName nvarchar(20) references PhoneTypeV5_1(TypeName),
	Nick nvarchar(30) --KO CẦN FK, CHỈ CẦN JOIN LÀ OK
)

SELECT * FROM PhonebookV5_1
SELECT * FROM PersonV5_1
SELECT * FROM PhoneTypeV5_1

INSERT INTO PhoneTypeV5_1 VALUES (N'DI ĐỘNG')
INSERT INTO PhoneTypeV5_1 VALUES (N'NHÀ/ĐỂ BÀN')
INSERT INTO PhoneTypeV5_1 VALUES (N'CÔNG TY')
INSERT INTO PhoneTypeV5_1 VALUES (N'CHA DƯỢNG NGỌT NGÀO')

insert into PersonV5_1 values(N'CuongNP', 'Lecturer', 'FPTU HCMC')
insert into PersonV5_1 values(N'AnNguyen', 'Student', 'FPTU HCMC')
insert into PersonV5_1 values(N'BinhLe', 'Student', 'FPTU HL')

insert into PhonebookV5_1 values ('0898x', N'DI ĐỘNG', N'CuongNP')

insert into PhonebookV5_1 values ('090x', N'DI ĐỘNG', N'AnNguyen')
insert into PhonebookV5_1 values ('091x', N'NHÀ/ĐỂ BÀN', N'AnNguyen')

insert into PhonebookV5_1 values ('090x', N'CÔNG TY', N'BinhLe')
insert into PhonebookV5_1 values ('091x',  N'DI ĐỘNG', N'BinhLe')
insert into PhonebookV5_1 values ('092x',  N'DI ĐỘNG', N'BinhLe')
insert into PhonebookV5_1 values ('093x', N'DI ĐỘNG', N'BinhLe')
insert into PhonebookV5_1 values ('094x', N'CHA DƯỢNG NGỌT NGÀO', N'BinhLe')

--===========================================================================
create table PersonV5
(
	Nick nvarchar(30) PRIMARY KEY, --Còn cần bàn thêm về PK/PERFORMANCE
	Title nvarchar(30),
	CompanyName nvarchar(40)
)

CREATE TABLE PhoneTypeV5
(
	TypeName nvarchar(20) NOT NULL, --Còn cần bàn thêm về PK/PERFORMANCE
	PRIMARY KEY(TypeName)
)

create table PhonebookV5
(
	Phone char(11), --số điện thoại là số mấy
	TypeName nvarchar(20) references PhoneTypeV5(TypeName), --thuộc loại gì
	Nick nvarchar(30) REFERENCES PersonV5(Nick),--của ai
	CONSTRAINT PK_PHONEBOOK PRIMARY KEY (Phone)
)--Loại gì và của ai, không gõ lung tung