--TRIGGER
--TRIGGER LÀ 1 HÀM VOID, KO NHẬN THAM SỐ, KO TRẢ VỀ
--NÓ LÀM NHIỆM VỤ GÁC CỔNG CHO 1 TABLE NÀO ĐÓ
--NẾU CÓ SỰ THAY ĐỔI DATA TRONG TABLE, NÓ SẼ TỰ ĐỘNG ĐƯỢC TRIỆU HỒI/THỰC THI/CHẠY 
--DÙNG ĐỂ KIỂM TRA/ĐẢM BẢO TÍNH TOÀN VẸN, NHẤT QUÁN CỦA DỮ LIỆU (CONSISTENCY)
--HOẶC DÙNG ĐỂ KIỂM TRA CÁC RÀNG BUỘC MÀ SQL CHUẨN KHÔNG THỂ CUNG CẤP ĐỦ

--CHỈ TỰ GỌI NẾU LIÊN QUAN ĐẾN 1 TABLE NÀO ĐÓ VÀ LIÊN QUAN ĐẾN 3 LỆNH: INSERT, UPDATE, DELETE
--GẮN CHẶT VỚI 1 TABLE, NHƯNG KO CẤM CODE CỦA NÓ CAN THIỆP TABLE KHÁC
--1 TABLE KO ÉP PHẢI CÓ TRIGGER


CREATE TABLE [Event]
(
	ID int IDENTITY PRIMARY KEY,
	Name nvarchar(50) NOT NULL
)
SELECT * FROM Event

GO

CREATE TRIGGER TR_CheckInsertionOnEvent ON [Event] FOR INSERT
AS

BEGIN
	PRINT 'You have just inserted a record in Event Table'
END

GO

GO
EXEC PR_InsertEvent @name = N'Blockchain & Games' --Kiểm tra xem có thông báo 1 câu khi insert an event
GO
SELECT * FROM Event

--PHÁ: KHÔNG CHO INSERT VÀO TABLE EVENT
GO

CREATE TRIGGER TR_ForbidInsertionEvent ON [Event] FOR INSERT
AS

BEGIN
	PRINT 'You have just inserted a record in Event Table. Sorry'
	ROLLBACK --CẤM, UNDO NHỮNG GÌ ĐÃ XẢY RA KHI INSERT	
END

GO
EXEC PR_InsertEvent @name = N'Thổi nến và Tài chính 4.0'
DROP TRIGGER TR_ForbidInsertionEvent
DROP TRIGGER TR_CheckInsertionOnEvent
--KIỂM TRA KO CHO INSERT QUÁ 5 RECORDS/EVENTS
--SQL CÓ THỂ ĐẾM, QUYẾT ĐỊNH ĐẾM XONG RỒI LÀM GÌ TIẾP => LẬP TRÌNH => TRIGGER CHẶN KHÔNG CHO VÀO
DROP TRIGGER TR_CheckInsertionLimitationEvent
GO
CREATE TRIGGER TR_CheckInsertionLimitationEvent ON [Event] FOR INSERT
AS
BEGIN
	--XEM THỬ NGƯỜI TA CHÈN EVENT GÌ VÀO TABLE???
	SELECT * FROM INSERTED
	ROLLBACK
END
GO
SELECT * FROM Event
EXEC PR_InsertEvent @name = N'Thổi nến và Tài chính 4.0'

--LƯU Ý KHI CHƠI VỚI TRIGGER
--DB ENGINE SẼ TỰ TẠO RA 2 TABLE ẢO LÚC RUN-TIME LIÊN QUAN ĐẾN TRIGGER
--CÂU LỆNH INSERT VÀO TABLE => DB E TẠO RA 1 TABLE ẢO TÊN LÀ INSERTED, CHỨA RECORD VỪA ĐƯA VÀO TỪ CÂU LỆNH INSERT
--CÂU LỆNH DELETE FROM TABLE => DB E TẠO RA 1 TABLE ẢO TÊN LÀ DELETED, CHỨA NHỮNG DÒNG VỪA BỊ XÓA
--CÂU LỆNH UPDATE EVENT, SET NAME = 'ĐỔI TÊN SỰ KIỆN' => DB E TẠO RA 2 TABLE ẢO
--	INSERTED CHỨA VALUE MỚI ĐƯA VÀO
--	DELETED CHỨA VALUE BỊ GHI ĐÈ/VALUE CŨ

GO
CREATE TRIGGER TR_CheckInsertionLimitationEvent ON [Event] FOR INSERT
AS
BEGIN
	--KIỂM TRA XEM TRONG TABLE KHÔNG CHO VƯỢT QUÁ 5 SỰ KIỆN
	--IF SỐ SỰ KIỆN > 5 ROLLBACK
	--PHẢI ĐẾM SỐ SỰ KIỆN ĐANG CÓ
	--LẤY ĐƯỢC SỐ SỰ KIỆN ĐỂ IF, TỨC LÀ KHAI BÁO BIẾN
	--LỆNH COUNT(*) TRONG SELECT TRẢ VỀ 1 TABLE, KHÔNG TRẢ VỀ 1 BIẾN
	DECLARE @noEvents int
	SELECT @noEvents = COUNT(*) FROM Event
	--PRINT @noEvents
	--SELECT @noEvents
	IF @noEvents > 5 
	BEGIN
		PRINT 'To much Events, no more 5 events!!!'
		ROLLBACK
	END
END
GO
-- LIÊN QUAN ĐẾN TABLE, CÓ 2 LOẠI TRIGGER CƠ BẢN:
-- CHẶN TRƯỚC KHI DỮ LIỆU ĐƯA VÀO TABLE, LÚC NÀY DỮ LIỆU MỚI VÀO INSERTED (BEFORE)

-- CHẶN SAU KHI ĐÃ VÀO INSERTED VÀ ĐỒNG THỜI VÀO LUÔN TABLE RỒI (AFTER)
SELECT * FROM Event
EXEC PR_InsertEvent N'Làm sao sống sót ở FU.HCM'
EXEC PR_InsertEvent N'Thổi nến và Tài chính 4.0'