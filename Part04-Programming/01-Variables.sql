--Kiểu dữ liệu - data type là 1 cách ta lưu 1 loại dữ liệu nào đó
--VD: số (nguyên, thực), chữ, câu/đoạn văn, ngày-tháng, tiền,...
--Một ngôn ngữ lập trình sẽ hỗ trợ nhiều loại dữ liệu khác nhau -DATA TYPE

--Khi lập trình trong SQL Server, vì câu lệnh sẽ nằm trên nhiều dòng...
--Nhăc Tool rằng là: Đừng nhìn lệnh riêng lẻ (nhiều dòng) mà hãy nhìn nguyên cụm lệnh mới có ý nghĩa (BATCH)
--Ta dùng lệnh GO để gom một cụm lệnh lập trình lại thành 1 đơn vị có ý nghĩa

--KHAI BÁO BIẾN
GO

DECLARE @msg1 AS nvarchar(30)
DECLARE @msg nvarchar(30) = N'Xin chào - Welcome to T-SQL'

--IN BIẾN CÓ 2 LỆNH
PRINT @msg  --IN RA KẾT QUẢ KIỂU CỬA SỔ CONSOLE - GIỐNG LẬP TRÌNH

SELECT @msg --IN RA KẾT QUẢ KIỂU DẠNG TABLE

DECLARE @yob int -- = 2004

--GÁN GIÁ TRỊ CHO BIẾN 
SET @yob = 2003
SELECT @yob = 2004 --LỆNH SELECT DÙNG 2 CÁCH: GÁN GIÁ TRỊ CHO BIẾN, IN GIÁ TRỊ CỦA BIẾN

PRINT @yob

IF @yob > 2003
	BEGIN
		PRINT 'HEY BOY/GIRL'
		PRINT 'HELLO GENZ'
	END
ELSE
	PRINT 'HEY GENTLEMENT & LADY'

GO

