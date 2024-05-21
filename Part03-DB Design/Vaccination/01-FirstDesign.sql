--THIẾT KẾ ĐẦU TIÊN: GOM TẤT CẢ TRONG 1 TABLE
--Đặc điểm chính là cột, value đặc điểm chính là 1 cell
--Thông tin chích ngừa bao gồm: Tên(AnNguyen), CCCD(079x), ...
create database DBDesign_Vaccination
create table VaccinationV1
(
	ID char(11) Primary Key,
	LastName nvarchar(30),
	FirstName nvarchar(10),--sort, Fullname là sort họ
	Phone varchar(11) not null UNIQUE, --Constraint, cấm trùng nhưng ko phải key
									   --Key ứng viên, Candidate Key
	InjectionInfo nvarchar (255)
)
--Cách thiết kế như thế nào, lưu trữ các mũi chích được ko ? ĐƯỢC

INSERT INTO VaccinationV1 VALUES('00000000001', N'Nguyễn', N'An', '090x', N'AZ Ngày 7.10.23 ĐH FPT | AZ Ngày 7.11.23 BV Đa Khoa Vạn Hạnh, Q.10')

select * from VaccinationV1

--PHÂN TÍCH
--ƯU   : DỄ LƯU TRỮ, SELECT, CÓ NGÀY, ĐA TRỊ TỐT TRONG VỤ NÀY!!!
--NHƯỢC: THỐNG KÊ KHÔNG ĐƯỢC, ÍT NHẤT ĐI CẮT CHUỖI, CĂNG !!! BỊ CĂNG DO ĐA TRỊ

--SOLUTION: CẦN QUAN TÂM THỐNG KÊ, TÍNH TOÁN SỐ LƯỢNG (CHÍCH BAO NHIÊU MŨI, AZ CÓ BNHIU NG CHÍCH, ...)
--TÁCH CỘT, TÁCH BẢNG
--======================================================================================================
create table VaccinationV2
(
	ID char(11) Primary Key,
	LastName nvarchar(30),
	FirstName nvarchar(10),--sort, Fullname là sort họ
	Phone varchar(11) not null UNIQUE, --Constraint, cấm trùng nhưng ko phải key
									   --Key ứng viên, Candidate Key
	Dose1 nvarchar (155), --AZ/ASTRA/ASTRAZENECA, NGÀY, ĐỊA ĐIỂM --COMPOSITE (PHỨC HỢP)
	Dose2 nvarchar (155)
)
--MULTI-VALUED: MỘT CELL CHỨA NHIỀU INFO ĐỘC LẬP/BÌNH ĐẲNG VỀ NGỮ NGHĨA (GÓM COMBO - NHIỀU ĐỒ TRONG SET)
--              Ví dụ: Address: 1/1, LL, Q.1, TP.HCM(Thường trú); 1/1 LVV, TP.TĐ(Tạm trú)
--ĐỌC: CÓ 2 ĐỊA CHỈ

--COMPOSITE VALUE CELL: Một Cell chỉ chứa 1 value duy nhất, mỗi value này gom nhiều miếng nhỏ hơn,
--                      mỗi miếng có 1 vai trò riêng, gom chung lại thành ra 1 thứ khác 
--						Address: 1/1, LL, Q.1, TP.HCM
--						FullName: Nguyễn  Phú    Cường => All: Tên gọi đầy đủ
--							       Last  Middle  First

--VÍ SỐ LẦN CHÍCH CÓ THỂ TĂNG CHO TÙY NGƯỜI, AI CHÍCH NHIỀU THÌ NHIỀU DÒNG

--PHÂN TÍCH:
--*ƯU   : GỌN GÀNG, SELECT GỌN GÀNG
--*NHƯỢC: NULL!!!, THÊM NHIỀU MŨI (NHẮC LẠI, 3, 4, ...)
--========================================================================================
create table PersonV3
(
	ID char(11) Primary Key,
	LastName nvarchar(30),
	FirstName nvarchar(10),--sort, Fullname là sort họ
	Phone varchar(11) not null UNIQUE, --Constraint, cấm trùng nhưng ko phải key
									   --Key ứng viên, Candidate Key
)
--COMPOSITION GỘP N THÔNG TIN TRONG 1 CELL, DỄ, NHANH, NHẬP 1 CHUỖI DÀI LÀ XONG
--NHƯỢC ĐIỂM: KO THỐNG KÊ TỐT, KO SORT ĐƯỢC DO KO CO QUY ƯỚC
--COMPOSITE SẼ TÁCH CỘT, VÌ MÌNH ĐÃ GOM N THỨ KHÁC NHAU ĐỂ LÀM RA 1 THỨ KHÁC
--             TÁCH CỘT TRẢ LẠI ĐÚNG NGHĨA CHO TỪNG THẰNG

CREATE TABLE VaccinationV3
(
	Dose nvarchar (155), --AZ/ASTRA/ASTRAZENECA, NGÀY, ĐỊA ĐIỂM --COMPOSITE (PHỨC HỢ
	PersonID char(11) REFERENCES PersonV3(ID)
)
--PHÂN TÍCH:
--*ƯU   : CHÍCH MŨI NÀO THÊM MŨI ĐÓ, CÓ THỂ NHIỀU MŨI, KHÔNG ẢNH HƯỞNG NGƯỜI CHƯA CHÍCH
--*NHƯỢC: THỐNG KÊ VẪN CHƯA ĐƯỢC
--COMPOSITE PHẢI TÁCH TIẾP THÀNH CỘT, ĐỂ TRẢ LẠI ĐÚNG Ý NGHĨA CHO TỪNG BIẾN/MIẾNG INFO NHỎ
--===============================================================================================
create table PersonV4
(
	ID char(11) Primary Key,
	LastName nvarchar(30),
	FirstName nvarchar(10),--sort, Fullname là sort họ
	Phone varchar(11) not null UNIQUE, --Constraint, cấm trùng nhưng ko phải key
									   --Key ứng viên, Candidate Key
)
CREATE TABLE VaccinationV4
(
	--Dose nvarchar (155), --AZ/ASTRA/ASTRAZENECA, NGÀY, ĐỊA ĐIỂM --COMPOSITE (PHỨC HỢ
	--TÁCH CỘT ĐỂ THỐNG KÊ
	Dose int, --liều số mấy??
	InjDate datetime,--giờ tiêm chủng
	Vaccine nvarchar(50),--tên vaccine
	Lot nvarchar(20),
	[Location] nvarchar(50),
	PersonID char(11) REFERENCES PersonV4(ID)
)

INSERT INTO PersonV4 VALUES('00000000001', N'Nguyễn', N'An', '090x')
INSERT INTO PersonV4 VALUES('00000000002', N'Lê', N'Bình', '091x')

INSERT INTO VaccinationV4 VALUES(1, GETDATE(), 'AZ', NULL, NULL, '00000000001')
INSERT INTO VaccinationV4 VALUES(2, GETDATE(), 'AZ', NULL, NULL, '00000000001')

select * from PersonV4
select * from VaccinationV4

--IN RA XANH VÀNG CHO MỖI NGƯỜI
SELECT * FROM PersonV4 p LEFT JOIN VaccinationV4 v ON p.ID = v.PersonID

SELECT p.ID, p.FirstName,COUNT(*) as [NoDoses] 
FROM PersonV4 p LEFT JOIN VaccinationV4 v ON p.ID = v.PersonID
GROUP BY P.ID, P.FirstName --COUNT(*) DO BÌNH CÓ DÒNG NULL

SELECT p.ID, p.FirstName,COUNT(V.Dose) as [NoDoses] 
FROM PersonV4 p FULL JOIN VaccinationV4 v ON p.ID = v.PersonID
GROUP BY P.ID, P.FirstName 


--GHI RA TRẠNG THÁI ĐÀNG HOÀNG
SELECT p.ID, p.FirstName, IIF( COUNT(V.Dose) = 0, 'NoDose', 
IIF(COUNT(V.Dose) = 1, 'YELLOW', 'GREEN')) AS STATUS
FROM PersonV4 p LEFT JOIN VaccinationV4 v ON p.ID = v.PersonID
GROUP BY P.ID, P.FirstName 