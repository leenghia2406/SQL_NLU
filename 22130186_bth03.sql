USE QUANLIBANHANG
/* Sử dụng ngôn ngữ truy vấn dữ liệu (SQL) thực hiện các yêu cầu sau */
-- 1. Lập danh sách nhân viên có họ ‘Nguyen’--
SELECT * FROM dbo.NHANVIEN
WHERE HOTEN LIKE 'Nguyen%';
-- 2. Cho biết HOTEN nhân viên bắt đầu làm việc trong tháng 4 năm 2006--
SELECT HOTEN FROM dbo.NHANVIEN
WHERE NGVL < '2006-05-01' AND  NGVL > '2006-03-31';
-- 3. Cho biết thông tin khách hàng có địa chỉ tại quận 5 --
SELECT * FROM KHACHHANG 
WHERE DCHI LIKE '%Q5%';
-- 4. Cho biết thông tin khách hàng lớn tuổi nhất --
SELECT * FROM dbo.KHACHHANG
WHERE NGSINH = (SELECT MIN(NGSINH) FROM dbo.KHACHHANG);
-- 5. Cho biết thông tin khách hàng nhỏ tuổi nhất--
SELECT  * FROM dbo.KHACHHANG
WHERE NGSINH = (SELECT MAX(NGSINH) FROM dbo.KHACHHANG);
-- 6. Cho biết thông tin khách hàng có doanh số lớn nhất --
SELECT * FROM dbo.KHACHHANG
WHERE DOANHSO = (SELECT MAX(DOANHSO) FROM dbo.KHACHHANG);
-- 7. Tính doanh số trung bình --
SELECT AVG(DOANHSO) AS "DOANH SO TRUNG BINH" FROM dbo.KHACHHANG;
-- 8. Cho biết thông tin khách hàng có doanh số lớn hơn doanh số trung bình --
SELECT * FROM dbo.KHACHHANG
WHERE DOANHSO > (SELECT AVG(DOANHSO) FROM dbo.KHACHHANG);
-- 9. Cho biết thông tin khách hàng đăng ký sớm nhất --
SELECT * FROM dbo.KHACHHANG
WHERE NGDK = (SELECT MIN(NGDK) FROM dbo.KHACHHANG);
-- 10. Cho biết thông tin khách hàng đăng ký trong năm 2007 --
SELECT * FROM dbo.KHACHHANG
WHERE YEAR(NGDK) = 2007;
-- 11. Cho biết thông tin sản phẩm có giá 3000 đồng-- 
SELECT * FROM dbo.SANPHAM
WHERE GIA = 3000.0;
-- 12. Cho biết thông tin sản phẩm do Việt Nam sản xuất-- 
SELECT * FROM dbo.SANPHAM
WHERE NUOCSX = 'Viet Nam';
-- 13. Cho biết thông tin sản phẩm là tập do Trung Quốc sản xuất--
SELECT * FROM dbo.SANPHAM
WHERE TENSP LIKE 'Tap%' AND NUOCSX = 'Trung Quoc';
-- 14. Cho biết tên sản phẩm có giá trong khoản từ 30.000 đồng đến 55.000 đồng--
SELECT * FROM dbo.SANPHAM
WHERE GIA BETWEEN 30000.0 AND 55000.0;
 -- 15. Cho biết đơn giá trung bình của các sản phẩm do Thái Lan sản xuất --
SELECT AVG(GIA) AS "GIA TRUNG BINH" FROM dbo.SANPHAM 
WHERE NUOCSX = 'Thai Lan';
-- 16. Cho biết thông tin chi tiết của đơn hàng 1004 --
SELECT * FROM dbo.HOADON
WHERE SOHD = 1004;
-- 17. Cho biết thông tin về khách hàng có trị giá đơn hàng lớn nhất --
SELECT * FROM dbo.KHACHHANG
WHERE MAKH = (SELECT MAKH FROM dbo.HOADON WHERE TRIGIA = (SELECT MAX(TRIGIA) FROM dbo.HOADON));
-- 18. Cho biết danh sách hóa đơn của khách hàng ‘KH01’ được nhân viên ‘NV03’ lập trước năm 2007 --
SELECT * FROM dbo.HOADON
WHERE MAKH = 'KH01' AND MANV = 'NV03' AND YEAR(NGHD) < 2007;
-- 19. Cho biết số lượng (hộp) phấn viết bảng đã được bán trong năm 2006 --
SELECT SUM(SL) AS "SO HOP PHAN BAN DUOC" FROM dbo.CTHD
WHERE MASP IN ('ST06', 'ST07') AND SOHD IN (SELECT SOHD FROM dbo.HOADON WHERE YEAR(NGHD) = 2006);
-- 20. Cho biết tổng giá trị các đơn hàng mà khách hàng ‘Tran Ngoc Linh’ đã đặt
SELECT SUM(TRIGIA) AS "TONG GIA TRI DON HANG" FROM dbo.HOADON
WHERE MAKH = 'KH03';
