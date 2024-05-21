CREATE DATABASE DBDesign_VNLocations
USE DBDesign_VNLocations
DROP DATABASE DBDesign_VNLocations 
--Thiết kế table/CSDL lưu được thông tin của phường/xã, quận/huyện, tỉnh/thành phố
--Chính là 1 phần của địa chỉ được tách ra cho nhu cầu thống kê
--Nó là thành phần của Composite Field
--|SEQ|Dose|InjDate|Vaccine (FK look up)|Lot|Địa chỉ tiêm chủng - Composite|
--|SEQ|Dose|InjDate|Vaccine (FK look up)|Lot|Số nhà|Phường-Quận-Tỉnh|

--XÉT RIÊNG PHƯỜNG-QUẬN-TỈNH: RÕ RÀNG LÀ 3 CỘT LOOK UP 
CREATE TABLE VNLocations
(
	Province nvarchar(30),
	District nvarchar(30),
	Ward nvarchar(30)
)
select * from VNLocations

--PHÂN TÍCH TABLE
--1. Trùng lặp cụm INFO TỈNH-QUẬN
--2. Lookup trên Province, District(Ward)
--3. Sự phụ thuộc logic giữa Tỉnh và District(Ward) ==>FUNCTIONAL DEPENDENCY - FD - PHỤ THUỘC HÀM
--   Có 1 cái ánh xạ, Mối quan hệ giữa A và B, Province và District
--   Cứ chọn TP.HCM => Q.1 Q.2 Q.3,...
--         Đồng Nai => Biên Hòa, LBT, LK,...

--TÁCH LOOKUP VÌ DỄ NHẤT
--RA 1 TABLE, PHẦN TABLE CÒN LẠI THÌ FK SANG LOOKUP

--CHỈ LOOKUP 63 TỈNH, KHÔNG CHO CHỌN LỘN XỘN
CREATE TABLE Province
(
	PName nvarchar(30)
)
select * from Province
select * from VNLocations --10581 DÒNG ỨNG VỚI 10581 XÃ, PHƯỜNG KHÁC NHAU
						  --NHƯNG CHỈ CÓ 63 TỈNH THÀNH LẶP LẠI
SELECT Distinct(Province) FROM VNLocations
--DÙNG NÓ ĐỂ INSERT SANG TABLE LOOKUP
INSERT INTO Province VALUES(N'TP.HỒ CHÍ MINH') --Tương tự cách cũ

--CÁCH INSERT THỨ 2
INSERT INTO Province VALUES(N'TP.HỒ CHÍ MINH'), (N'TP.HÀ NỘI')

--TUYỆT CHIÊU THỨ 3 (COPY PASTE NHƯ CÁCH INSERT CHO 10000 DÒNG)

--TUYỆT CHIÊU INSERT THỨ 4
--INSERT INTO Province VALUES CÓ 63 TỈNH THÀNH LÀ NGON - TA XÀI KIỂU SUB QUERY TRONG LỆNH INSERT
INSERT INTO Province SELECT Distinct(Province) FROM VNLocations

SELECT * FROM Province
SELECT COUNT(*) FROM VNLocations -- 10581 XÃ/PHƯỜNG
SELECT COUNT(Province) FROM VNLocations -- 10581 XÃ/PHƯỜNG
SELECT COUNT(DISTINCT Province) AS [NoOfProvinces] FROM VNLocations -- 63 XÃ/PHƯỜNG

--TẠO TABLE LOOKUP QUẬN/HUYỆN
CREATE TABLE District
(
	DName nvarchar(30)
)
--Có bao nhiêu quận/huyện ở VN
SELECT DISTINCT District FROM VNLocations
--RẤT CẨN THẬN KHI CHƠI VỚI QUẬN/HUYỆN
--NHỮNG NƠI ĐỀU CÓ HUYỆN CHUNG VỚI NHAU
--BẢNG DISTRICT CHỈ CÓ 1 'CHÂU THÀNH'
--PK CỦA DISTRICT KHÔNG THỂ LÀ TÊN QUẬN/HUYỆN

--CHÈN VÀO TABLE QUẬN
INSERT INTO District SELECT DISTINCT District FROM VNLocations
SELECT * FROM District

--CITY VÀ DISTRICT CÓ SỰ PHỤ THUỘC LẪN NHAU, TỪ THẰNG NÀY SUY RA THẰNG KIA
--NHÌN QUẬN CÓ THỂ ĐOÁN ĐƯỢC THÀNH PHỐ (CHIỀU NÀY KO CHẮC AN TOÀN)
--NHÌN THÀNH PHỐ ĐOÁN RA QUẬN (HỢP LÝ VỀ SUY LUẬN)

--FD NÊN ĐỌC LÀ CITY => DISTRICT
--TABLE MÀ CHỨA CÁC FD PHỤ THUỘC NGANG GIỮA CÁC CỘT 
--=> SUY NGHĨ ĐẾN VIỆC TÁCH BẢNG, TÁCH VẾ TRÁI VÀ PHẢI, RA TABLE KHÁC, TÁCH XONG PHẢI FK CHO PHẦN CÒN LẠI

--SAU KHI TÁCH TA CÓ 3 TABLE TRONG TAY
--PROVINCE (PName)
-- DISTRICT(DName, PName(FK Ở PROVINCE))
--     WARD(WName, DName(FK Ở DISTRICT))

--GIẢI PHÁP "DỞ" CHO HUYỆN CHÂU THÀNH CỦA 3 TỈNH MIỀN TÂY --SẼ LÀM SAU
--DÙNG NATURAL KEY, KET TỰ NHIÊN - DÙNG TÊN CỦA TỈNH/HUYỆN LÀM KEY
--DÙNG KEY TỰ GÁN, TỰ TĂNG, KEY THAY THÊ, KEY GIẢ (SURROGATE KEY/ARTIFICIAL KEY)

--PHIÊN BẢN ĐẸP NHƯNG VẪN CÒN CHÚT HUYỆN CHÂU THÀNH
DROP TABLE Province
DROP TABLE District

CREATE TABLE Province
(
	PName nvarchar(30) PRIMARY KEY
)
INSERT INTO Province SELECT Distinct(Province) FROM VNLocations
SELECT * FROM Province

DROP TABLE District
CREATE TABLE District
(
	DName nvarchar(30) NOT NULL, --không có đầy đủ Châu Thành của Miền Tây
	PName nvarchar(30) NOT NULL REFERENCES Province(PName), --Quận nào thuộc về Tỉnh nào/TP nào
	--Tham chiếu để không nhập tỉnh không tồn tại
	PRIMARY KEY (DName, PName)
)
INSERT INTO District SELECT DISTINCT District FROM VNLocations

SELECT District, Province FROM VNLocations  --10581 PHƯỜNG XÃ BỊ CẮT CỘT P.X
SELECT * FROM VNLocations                   -- LẤY ĐỦ 3 CỘT

SELECT DISTINCT District, Province FROM VNLocations ORDER BY District
--699 quận, có rất nhiều Châu Thành của 6 tỉnh miền Tây
INSERT INTO District SELECT DISTINCT District, Province FROM VNLocations ORDER BY District
SELECT * FROM District

--Hỏi thử: TPHCM có những Quận nào???
SELECT DName FROM District WHERE PName = N'Thành phố Hồ Chí Minh'

SELECT DName FROM District WHERE PName = N'Tỉnh Long An'

--THÀNH PHẦN ĐÔNG DATA NHẤT LÀ WARD/PHƯỜNG, CÓ 10581 DÒNG
--ỨNG VỚI VÔ SÔ LẶP LẠI CÁC QUẬN, FK 

--xã có trùng tên hem???
CREATE TABLE Ward
(
	WName nvarchar(30), 
	--xã phường ơi, bạn ở quận nào?
	DName nvarchar(30) --REFERENCES District(DName)
)

SELECT * FROM VNLocations --10581 Xã Phường, liệu rằng có trùng???
SELECT COUNT(DISTINCT Ward) FROM VNLocations --đếm trùng xã đếm 1 lần
                           --7884, TRÙNG TÊN 3000 TÊN 
SELECT Ward FROM VNLocations ORDER BY ward

SELECT Ward, District FROM VNLocations
INSERT INTO WARD SELECT Ward, District FROM VNLocations --10581
SELECT * FROM Ward

--CHO TUI XEM CÁC PHƯỜNG CỦA Q1. TPHCM
SELECT * FROM Ward WHERE DName = N'Quận 1'

--Huyện Châu Thành của Tiền Giang có những xã nào!!!!
--23 xã
SELECT w.WName, w.DName, d.PName FROM Ward w INNER JOIN 
                    District d ON w.DName = d.DName
					WHERE w.DName = N'Huyện Châu Thành'
					AND   d.PName = N'Tỉnh Tiền Giang' 
  

--Huyện Ba Tri của Bến Tre có những xã nào!!!!
--23 xã
SELECT w.WName, w.DName, d.PName FROM Ward w INNER JOIN 
                    District d ON w.DName = d.DName
					WHERE d.DName = N'Huyện Ba Tri'
					AND   d.PName = N'Tỉnh Bến Tre' 
 

SELECT * FROM Ward ORDER BY DName  
SELECT * FROM Ward WHERE DName = N'Huyện Châu Thành'