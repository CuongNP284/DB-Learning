
select * from VnDict, EnDict -- tích Đề-Các

select * from VnDict cross join EnDict -- tích Đề-Các

select * from VnDict vn, EnDict en where Nmbr = Nmbr -- bối rối tên

select * from VnDict vn, EnDict en where vn.Nmbr = en.Nmbr -- tích Đề các xong filter lại
-- THỰC DỤNG 


select * from VnDict, EnDict where VnDict.Nmbr = EnDict.Nmbr -- nên đặt Alias thì giúp ngắn gọn câu lệnh

-- CHUẨN THẾ GIỚI
select * from VnDict INNER JOIN EnDict -- Nhìn sâu TABLE RỒI GHÉP, KO GHÉP BỪA BÃI
		 ON VnDict.Nmbr = EnDict.Nmbr -- GHÉP CÓ TƯƠNG QUAN BÊN TRONG, THEO ĐIỂM CHUNG

select * from VnDict JOIN EnDict -- Nhìn sâu TABLE RỒI GHÉP, KO GHÉP BỪA BÃI
		 ON VnDict.Nmbr = EnDict.Nmbr

-- CÓ THỂ DÙNG THÊM WHERE ĐC HAY KO ?? KHI XÀI INNER VÀ JOIN
-- JOIN CHỈ LÀ THÊM DATA ĐỂ TÍNH TOÁN, GỘP DATA LẠI NHIỀU HƠN, SAU ĐÓ ÁP DỤNG TOÀN BỘ KIẾN THỨC SELECT ĐÃ HỌC

-- Thí nghiệm thêm cho INNER JOIN, ghép ngang xem có môn đăng hổ đối hay ko
select * from VnDict
select * from EnDict

select * from EnDict, VnDict where EnDict.Nmbr = VnDict.Nmbr

select * from EnDict, VnDict where EnDict.Nmbr > VnDict.Nmbr -- Ghép có chọn lọc nhưng ko xài dấu
-- mà chỉ dùng dấu > >= < <= !=
-- Non-Equi Join, vẫn ko là ghép bừa bãi
select * from EnDict, VnDict where EnDict.Nmbr != VnDict.Nmbr -- THỰC DỤNG
select * from EnDict JOIN VnDict ON EnDict.Nmbr != VnDict.Nmbr -- CHUẨN MỰC