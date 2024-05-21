
-- 1. Liệt kê các cặp từ điển tiếng anh-việt
select * from EnDict e, VnDict v where e.Nmbr = v. Nmbr
-- có bằng cell thì mới ghép

select * from EnDict e INNER JOIN VnDict v ON e.Nmbr = v. Nmbr
-- hãy ghép đi, trên cột này có cell/value này = cell/value bên kia
select * from EnDict e JOIN VnDict v ON e.Nmbr = v. Nmbr
-- 3 câu tương đương

-- 2. Hụt mất của tui từ 4/Four và 5/Five ko thấy xuất hiện
-- Muốn xuất hiện thì sử dụng tích đề các
select * from EnDict e, VnDict v 

select * from VnDict -- DML/Data Manipuplation Language
select * from Endict

-- 3. Lấy tiếng Anh làm chuẩn tìm các nghĩa tiếng Việt nếu ko có vẫn phải xuất hiện
select * from EnDict e LEFT JOIN VnDict v ON e.Nmbr = v. Nmbr
select * from EnDict e LEFT OUTER JOIN VnDict v ON e.Nmbr = v. Nmbr

-- 4. Lấy tiếng Việt làm chuẩn tìm các nghĩa tiếng Anh nếu ko có vẫn phải xuất hiện
select * from VnDict v LEFT OUTER JOIN EnDict e ON e.Nmbr = v. Nmbr
-- vẫn lấy lấy tiếng việt làm đầu nhưng để tiếng việt bên phải
select * from EnDict e RIGHT OUTER JOIN VnDict v ON e.Nmbr = v. Nmbr

-- 5. Dù chung và riêng của mỗi bên, lấy tất cả, chấp nhận NULL ở 1 vế
select * from EnDict e FULL OUTER JOIN VnDict v ON e.Nmbr = v. Nmbr
select * from VnDict e FULL JOIN EnDict v ON e.Nmbr = v. Nmbr
-- FULL OUTER JOIN, THỨ TỰ TABLE KO QUAN TRỌNG, VIẾT TRƯỚC SAU ĐỀ ĐC
-- LEFT, RIGHT JOIN THỨ TỤ TABLE LÀ CÓ CHUYỆN KHÁC NHAU
select * from VnDict e LEFT JOIN EnDict v ON e.Nmbr = v. Nmbr
select * from EnDict e LEFT OUTER JOIN VnDict v ON e.Nmbr = v. Nmbr

-- OUTER JOIN SINH RA ĐỂ ĐẢM BẢO VIỆC KẾT NỐI GHÉP BẢNG
-- KO BỊ MẤT MÁT DATA	
-- DO INNER JOIN, JOIN = CHỈ TÌM CÁI CHUNG 2 BÊN 

-- SAU KHI TÌM RA ĐC DATA CHUNG RIÊNG, TA CÓ QUYỀN FILTER TRÊN LOẠI CELL NÀO ĐÓ
-- WHERE NHƯ BÌNH THƯỜNG 

-- 6. IN RA từ điển Anh Việt (Anh làm chuẩn) của những con số từ 3 trở lên
select * from EnDict e LEFT OUTER JOIN VnDict v ON e.Nmbr = v. Nmbr where e.Nmbr >= 3
select * from EnDict e LEFT OUTER JOIN VnDict v ON e.Nmbr = v. Nmbr where v.Nmbr >= 3

-- 7. IN RA từ điển Anh Việt Việt Anh (Anh làm chuẩn) của những con số từ 3 trở lên
select * from EnDict e FULL OUTER JOIN VnDict v ON e.Nmbr = v. Nmbr where e.Nmbr >= 3
select * from EnDict e FULL OUTER JOIN VnDict v ON e.Nmbr = v. Nmbr where V.Nmbr >= 3
select * from EnDict e FULL OUTER JOIN VnDict v ON e.Nmbr = v. Nmbr where V.Nmbr >= 3 OR e.Nmbr >= 3
