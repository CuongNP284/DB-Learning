USE DBDesign_Vaccination
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
--=================================================================================================
--PHÂN TÍCH
--Cột Vaccine cho phép gõ các giá trị tên Vaccine một cách tự do => inconsistency
--AZ, Astra, Astrazeneca, .... ==> Có mùi của drop down, combo box ==> Một dạng lookuptable
--Không cho gõ mà bắt phải lựa chọn từ 1 danh sách đã có sẵn,...
--Tham chiếu từ danh sách có sẵn
--Vaccine phải tách thành table CHA, table 1, đám con đám N phải REFERENCE VỀ
create table PersonV5
(
	ID char(11) Primary Key,
	LastName nvarchar(30),
	FirstName nvarchar(10),--sort, Fullname là sort họ
	Phone varchar(11) not null UNIQUE, --Constraint, cấm trùng nhưng ko phải key
									   --Key ứng viên, Candidate Key
)

INSERT INTO PersonV5 VALUES('00000000001', N'Nguyễn', N'An', '090x')
INSERT INTO PersonV5 VALUES('00000000002', N'Lê', N'Bình', '091x')
INSERT INTO PersonV5 VALUES('00000000003', N'Nguyễn', N'Cường', '0898x')
INSERT INTO PersonV5 VALUES('00000000004', N'Võ', N'Dũng', '092x')

select * from PersonV5

CREATE TABLE VaccineV5
(
	VaccineName varchar(30) PRIMARY KEY
	--HÃNG SX, ĐỊA CHỈ HÃNG, THÔNG TIN VỀ LÂM SÀNG...
)

INSERT INTO VaccineV5 VALUES ('AstraZeneca')
INSERT INTO VaccineV5 VALUES ('Pfizer')
INSERT INTO VaccineV5 VALUES ('Verocell')
INSERT INTO VaccineV5 VALUES ('Moderna')

select * from VaccineV5
--PRIMARY KEY MÀ LÀ VARCHAR() THÌ GIẢM HIỆU NĂNG THƯC THI QUERY ==> CHẠY CHẬM
--THƯỜNG NGƯỜI TA SẼ CHỌN PK LÀ CON SỐ LÀ TỐT NHÁT, TỐT NHÌ LÀ CHAR
--(PK, FK, SPK, NK, SRK-AK)

CREATE TABLE VaccinationV5
(
	SEQ INT IDENTITY PRIMARY KEY, --CỨ TĂNG MÃI ĐI THÔI
	Dose int, --liều số mấy?? CÓ THỂ LẶP LẠI CHO TỪNG NGƯỜI CHO NÊN KHÔNG THỂ LÀ KEY
	InjDate datetime,--giờ tiêm chủng
	Vaccine varchar(30) REFERENCES VaccineV5(VaccineName),--tên vaccine, ko cho nhập tự do phải tham chiếu
	Lot nvarchar(20),
	[Location] nvarchar(50),--nơi tiêm bản chất là COMPOSITE, TÁCH THÀNH CỘT CITY, DISTRICT, PROVINCE,...
							--LẠI LÀ LOOK UP NẾU MUỐN, ĐỂ KO GÕ LUNG TUNG, DỄ THỐNG KÊ TRÊN TỪNG ĐƠN VỊ
	PersonID char(11) REFERENCES PersonV5(ID),
	--FOREIGN KEY (Vaccine) REFERENCES VaccineV5(VaccineName)
	--CONSTRAINT FK_VCN_VC FOREIGN KEY (Vaccine) REFERENCES VaccineV5(VaccineName)
)

INSERT INTO VaccinationV5 VALUES(1, GETDATE(), 'AstraZeneca', NULL, NULL, '00000000001')
INSERT INTO VaccinationV5 VALUES(2, '2023-11-20', 'AstraZeneca', NULL, NULL, '00000000001')
INSERT INTO VaccinationV5 VALUES(3, '2023-12-20', 'AZ', NULL, NULL, '00000000001') --THẤT BẠI
--KO CÓ LOẠI VACCINE GÕ TAY AZ
--SEQ TỰ TĂNG LÊN SỐ 3 VÀ BỊ THẤT BẠI!!!
INSERT INTO VaccinationV5 VALUES(1, GETDATE(), 'Verocell', NULL, NULL, '00000000002')
INSERT INTO VaccinationV5 VALUES(2, '2023-11-20', 'Verocell', NULL, NULL, '00000000002')

select * from VaccineV5
select * from PersonV5
select * from VaccinationV5

--THÔNG KÊ ĐƯỢC HẾT NHỮNG GÌ
--1. Có bao nhiêu mũi vaccine AZ đã được tiêm (ko care ngày)
--Output: Loại vaccine, tổng số mũi đã tiêm
select v.VaccineName, COUNT(va.Vaccine) as [Total] from VaccineV5 v left join VaccinationV5 va on v.VaccineName = va.Vaccine
group by v.VaccineName having v.VaccineName = 'AstraZeneca'

--2. Ngày 20/11/2023 đã có bao nhieu người được tiêm
--Output: Ngày, tổng số mũi đã tiêm
select va.InjDate, count(va.PersonID) as [Total] from VaccinationV5 va group by va.InjDate
having va.InjDate = '2023-11-20'

--3. Thống kê số mũi tiêm của từng cá nhân 
--Output: CCCD, TÊN, DI ĐỘNG, SỐ MŨI ĐÃ CHÍCH
select p.ID, p.FirstName + ' ' + p.LastName as [Fullname], p.Phone, count(va.Dose) as [Total] 
from PersonV5 p full join VaccinationV5 va on p.ID = va.PersonID
group by p.ID, p.FirstName, p.LastName, p.Phone

--4. In ra thông tin tiêm chủng của từng cá nhân	
--Output: CCCD, TÊN, DI ĐỘNG, SỐ MŨI ĐÃ CHÍCH, MÀU SẮC
select p.ID, p.FirstName + ' ' + p.LastName as [Fullname], p.Phone, count(va.Dose) as [Total],
IIF(COUNT(va.Dose) = 0, 'NoDose', IIF(COUNT(va.Dose) = 1, 'YELLOW', 'GREEN')) AS STATUS
from PersonV5 p full join VaccinationV5 va on p.ID = va.PersonID
group by p.ID, p.FirstName, p.LastName, p.Phone

--5. Có bnhiu công dân đã chích ít nhất 1 mũi

--6. Những công dân nào chưa chích vaccine
--Output: CCCD, Tên

--7. Công dân có CCCD X đã tiêm những mũi nào
--Output: CCCD. Tên, Thông tin tiêm (In gộp + chuỗi, tái nhập)

--8. Thống kê số mũi vaccine đã tiêm của mỗi loại
select * from VaccinationV5 -- chỉ thấy AZ, VC, mất tiêu 2 thằng còn lại

select v.VaccineName, COUNT(va.Vaccine) as [Total] from VaccineV5 v left join VaccinationV5 va on v.VaccineName = va.Vaccine
group by v.VaccineName


--CHỐT HẠ: TÁCH ĐA TRỊ HAY COMPOSITE DỰA TREN NHU CẦU THỐNG KÊ NẾU CÓ CỦA DỮ LIỆU MÀ TA ĐANG LƯU TRỮ!!!
--GOM BẢNG ==> TÌM ĐA TRỊ, TÌM COMPOSITE, TÌM LOOKUPTABLE TÁCH THEO NHU CẦU!!!
