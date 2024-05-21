--Khi có nhiều câu lệnh SQL phức tạp, hay ta cần viết lại nhiều lần 1 câu SELECT nào đó
--Ta đặt cho câu lệnh SQL SELECT này 1 cái tên, sau này muốn xài lại câu SQL này chỉ cần gọi tên ra là đủ

--1 câu lệnh SELECT ~~~ 1 TABLE được trả về	khi chạy
--1 câu lệnh SELECT đặt cho nó 1 cái tên ~~~ 1 TABLE được trả về khi chạy
--Nếu ta muốn nhìn TABLE này, chạy lại câu lệnh SELECT này 
--Ta chỉ việc SELECT * FROM CÁI-TÊN-ĐÃ ĐẶT
USE Northwind
SELECT * FROM Employees

-- 1. Liệt kê các nhân viên ở London
SELECT * FROM Employees WHERE CITY = 'LONDON' --COI CÂU NÀY LÀ 1 TABLE, CHO NÓ CÁI TÊN, SAU NÀY MUỐN XÀI, SELECT CÁI TÊN THÔI

GO

CREATE VIEW VW_LondonEmployees 
AS 
SELECT * FROM Employees WHERE CITY = 'LONDON'

GO

--XÀI VIEW, COI MÀY LÀ TABLE, VÌ SAU LƯNG MÀY LÀ SELECT CHỐNG LƯNG MÀ
SELECT * FROM VW_LondonEmployees
SELECT * FROM [Category Sales for 1997]