--HÀM: 1 nhóm câu lệnh được đặt tên với mục đích re-use hay làm 1 việc gì đó

--Trong lập trình, có 2 loại hàm:
--HÀM VOID: KO TRẢ VỀ GIÁ TRỊ NÀO CẢ
--HÀM CÓ TRẢ VỀ 1 GIÁ TRỊ (CHỈ 1): LỆNH RETURN

--R.DBMS (CSDL DỰA TRÊN RELATION/TABLE) TA CÓ 2 LOẠI HÀM:
--STORE PROCEDURE ~~~ VOID
--FUNCTION ~~~ RETURN

-- C: void f(int* a, int* b) {
--        
--    }
-- gọi hàm f()
-- int x = 10, y = 11;

-- f(&x, &y), khi trong hàm f mà làm gì với x, y, thì x ở ở 
-- bên ngoài bị ảnh hưởng luôn 
-- hàm thay đổi 2 giá trị x y ở bên ngoài, void mà lại đưa data ra 
-- ngoài qua con trỏ, truyền tham chiếu pass by reference

-- VIẾT HÀM IN RA CÂU CHÀO!!!
--CREATE PROCEDURE PR_Hello() {... code ...}
CREATE DATABASE DBDesign_Programming
USE DBDesign_Programming

GO

CREATE PROCEDURE PR_Hello_1
AS
	PRINT N'Xin chào - Welcome to my own first procedure!!!'

GO

--DÙNG PROCEDURE - LÀ HÀM VOID, GỌI TÊN EM LÀ ĐỦ
GO

CREATE PROC PR_Hello
AS
	PRINT N'Xin chào - Welcome to my own second procedure!!!'

GO

--DÙNG PROCEDURE - LÀ HÀM VOID, GỌI TÊN EM LÀ ĐỦ
GO

PR_Hello_1

dbo.PR_Hello_1

EXECUTE PR_Hello_1 --TUI MUỐN CHẠY/THỰC THI THỦ TỤC/NHÓM LỆNH ĐÃ ĐẶT TÊN

EXEC PR_Hello_1

EXEC PR_Hello

GO
----------------------------------------------------------------------------------------------------------------------------------
--HÀM, PHẢI TRẢ VỀ GIÁ TRỊ!!! QUA LỆNH RETURN
GO
--INT F() {..CODE...}

CREATE FUNCTION FN_Hello() RETURNS NVARCHAR(100)
AS

BEGIN
	RETURN N'Xin chào - Welcome to my own first function!!'
END
GO

--LƯU Ý: Y NHƯ BÊN LÂP TRÌNH, HÀM TRẢ VỀ THÌ ĐƯỢC QUYỀN DÙNG TRONG CÁC CÂU LỆNH KHÁC
--		 GỌI HÀM MÀ KHÔNG KÈM THEO GÌ KHÁC THÌ ĐỪNG HỎI SAO MÀN HÌNH KO CÓ 
--			BỞI NHIỆM VỤ CỦA HÀM LÀ TRẢ VỀ GIÁ TRỊ, IN KHÔNG PHẢI VIỆC CỦA HÀM, VIỆC KHÁC CŨNG VẬY
--			IN XEM HÀM XỬ LÍ RA SAO, THÌ PHẢI KÈM LỆNH IN VÀ LỆNH GỌI HÀM
--			sqrt(4)/Math.sqrt(4) => ko có kết quả gì khi chạy
--			sout(Math.sqrt(4))   => có ngay kết quả chạy hàm
SELECT GETDATE() --Hàm dùng xử lý trả về kết quả, phải dùng kết quả trong lệnh nào đó
SELECT dbo.FN_Hello()
--SELECT FN_Hello(): bắt buộc phải có dbo.Tên_Hàm
PRINT dbo.FN_Hello()
----------------------------------------------------------------------------------------------------------------------------------------------------------
--VIẾT HÀM PROCEDURE ĐỂ ĐỔI TỪ ĐỘ C SANG ĐỘ F, F = C * 1.8 + 32
--THAM SỐ/ĐẦU VÀO/ARGUMENT
GO
CREATE PROC PR_C2F
@CDegree float
AS

BEGIN
	DECLARE @FDegree float = @CDegree * 1.8 + 32
	PRINT @FDegree
END
GO
--XÀI, VÌ CÓ THAM SỐ NÊN CẦN PHẢI TRUYỀN VÀO
EXECUTE PR_C2F @CDegree = 37
EXEC PR_C2F 37
--------------------------------------------------------------------
GO
CREATE FUNCTION FN_C2F(@cDegree float) RETURNS float
AS
BEGIN
	DECLARE @FDegree float = @CDegree * 1.8 + 32
	RETURN @FDegree
END
GO
--SỬ DỤNG HÀM, HÀM LÀ PHẢI VIẾT KÈM VỚI AI ĐÓ, LỆNH KHÁC
PRINT dbo.FN_C2F(37)
PRINT N'37 độ C là ' + CAST(dbo.FN_C2F(37) AS NVARCHAR(30)) + N' độ F'

--PROCEDURE CÒN LÀM ĐƯỢC NHIỀU VIỆC KHÁC:
--VIẾT 1 PROCEDURE IN RA DANH SÁCH NHÂN VIÊN QUÊ Ở ĐÂU ĐÓM, Ở CHỖ NÀO VÀO TRONG PROC
--VIEW: IN RA AI Ở LONDON,... (MỘT TP NÀO ĐÓ)
--MỖI VIEW LÀ 1 SELECT VÀ LÀ 1 TABLE ĐỂ REUSE
--PROCEDURE IN RA KẾT QUẢ NHƯ VIEW, KO REUSE, CHỈ IN RA, NHƯNG LẠI NHẬN ĐƯỢC THAM SỐ
USE Northwind
GO
CREATE PROC PR_EmployeeListByCity
@city nvarchar(30)
AS

BEGIN
	SELECT * FROM Employees WHERE City = @city
END
GO

SELECT * FROM Employees WHERE City = 'REDMOND'
EXEC PR_EmployeeListByCity @city = 'REDMOND'
EXEC PR_EmployeeListByCity 'SEATTLE'	
EXEC PR_EmployeeListByCity 'LONDON'

--ỨNG DỤNG THÊM CỦA PROCEDURE, VIẾT PROC INSERT DATA
CREATE TABLE [Event]
(
	ID int IDENTITY PRIMARY KEY,
	Name nvarchar(50) NOT NULL
)
INSERT INTO [Event] VALUES(N'Lời nói dối chân thật')
select * from [Event]

GO
CREATE PROC PR_InsertEvent
@name nvarchar(50)
AS 
	INSERT INTO [Event] VALUES(@name)
GO
--CHÈN CÁC DÒNG VÀO TABLE
EXEC PR_InsertEvent @name = N'Bí quyết dùng source ở FE'
EXEC PR_InsertEvent @name = N'Hồ Sen Chờ Ai'
select * from [Event]