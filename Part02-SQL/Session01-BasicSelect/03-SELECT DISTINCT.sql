Use Northwind
----------------------------------------------------------------------
-- Lý Thuyết

-- #CÚ PHÁP CHUẨN: SELECT * FROM <TÊN-TABLE>
--                        * đại diện cho việc tui muốn lấy all of columns
-- #CÚ PHÁP MỞ RỘNG: SELECT TÊN-CÁC-CỘT-MUỐN-LẤY, CÁCH-NHAU-BỞI-DẤU-PHẨY FROM <TÊN-TABLE>
--                   SELECT CÓ THỂ DÙNG CÁC HÀM XỬ LÝ CÁC CỘT ĐỂ ĐỘ LẠI THÔNG TIN HIỂN THỊ FROM <TÊN-TABLE>

-- #Khi ta SELECT ít cột từ TABLE gốc thì có nguy cơ dữ liệu bị trùng lại
-- #Không phải ta bị sai, ko phải người	thiết kế ra table và người nhập liệu bị sai
-- #Do chúng ta có nhiều info, đặc điểm trùng nhau, nếu chỉ tập trung vào data này trùng nhau chắc chắn xảy ra
-- #Lệnh SELECT HỖ TRỢ LOẠI TRỪ DÒNG TRÙNG NHAU 100%
-- #SELECT DISTINCT TÊN-CÁC-CỘT FROM <TÊN-TABLE>
----------------------------------------------------------------------

-- 1. Liệt kê danh sách nhân viên
-- #Có 9 người nhưng chỉ có 4 title
Select DISTINCT TitleOfCourtesy from Employees
-- #Nếu DISTINCT ĐI KÈM VỚI ID/KEY, NÓ VÔ DỤNG, KEY SAO MÀ TRÙNG ĐC MÀ LOẠI TRỪ

-- 2. In ra thông tin của khác hàng
Select * From Customers

-- 3. Có bnhiu quốc gia xuất hiện ở thông tin khách hàng, cần in ra
Select Distinct Country From Customers

