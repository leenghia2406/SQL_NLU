CREATE DATABASE NUOCGIAIKHAT
USE NUOCGIAIKHAT
/* I. Ngôn ngữ định nghĩa dữ liệu (Data Definition Language): */
-- 1. Tạo các quan hệ và khai báo các khóa chính, khóa ngoại của quan hệ.
CREATE TABLE KH 
(MaKH char(4) NOT NULL, 
TenKH nvarchar(20) NOT NULL, DCKH nvarchar(20) NOT NULL,
DTKH varchar(15) NOT NULL,
CONSTRAINT prim_kh PRIMARY KEY (MaKH));

CREATE TABLE NHACC 
(MaNCC char(3) NOT NULL, 
TenNCC nvarchar (40) NOT NULL, 
DiaChiNCC nvarchar(40) NOT NULL, 
DTNCC varchar(15) NOT NULL,
CONSTRAINT prim_ncc PRIMARY KEY (MaNCC));

CREATE TABLE LOAINGK
(MaLoaiNGK char(3) NOT NULL, 
TenLoaiNGK nvarchar (40) NOT NULL, 
MaNCC char(3) NOT NULL,
CONSTRAINT prim_loaingk PRIMARY KEY (MaLoaiNGK),
CONSTRAINT foreign_loaingk FOREIGN KEY (MaNCC) 
REFERENCES NHACC (MaNCC));

CREATE TABLE NGK 
(MaNGK varchar(3) NOT NULL,
TenNGK nvarchar(40) NOT NULL, 
Quycach nvarchar(8) NOT NULL, MaLoaiNGK char(3) NOT NULL,
CONSTRAINT prim_ngk PRIMARY KEY (MaNGK),
CONSTRAINT foreign_ngk FOREIGN KEY (MaLoaiNGK) REFERENCES LOAINGK(MaLoaiNGK));

CREATE TABLE DDH 
(SoDDH char(5) NOT NULL,
NgayDH date NOT NULL, MaNCC char(3) NOT NULL,
CONSTRAINT prim_ddh PRIMARY KEY (SoDDH),
CONSTRAINT foreign_ddh FOREIGN KEY (MaNCC) REFERENCES NHACC (MaNCC));

CREATE TABLE CT_DDH 
(SoDDH char(5) NOT NULL,
MaNGK varchar(3) NOT NULL, SLDat int NOT NULL,
CONSTRAINT prim_ctddh PRIMARY KEY (SoDDH, MaNGK),
CONSTRAINT foreign_ctddh1 FOREIGN KEY (SoDDH) REFERENCES DDH(SoDDH),
CONSTRAINT foreign_ctddh2 FOREIGN KEY (MaNGK) REFERENCES NGK(MaNGK));

CREATE TABLE PHIEUGH 
(SoPGH char(5) NOT NULL, 
NgayGH date NOT NULL, SoDDH char(5) NOT NULL,
CONSTRAINT prim_phieugh PRIMARY	KEY(SoPGH),
CONSTRAINT foreign_phieugh FOREIGN KEY (SoDDH) REFERENCES DDH(SoDDH));

CREATE TABLE CT_PGH
(SoPGH char(5) NOT NULL, 
MaNGK varchar(3) NOT NULL, SLGiao int NOT NULL, 
DGGiao int NOT NULL,
CONSTRAINT prim_ctpgh PRIMARY KEY (SoPGH, MaNGK),
CONSTRAINT foreign_ctpgh1 FOREIGN KEY (SoPGH) REFERENCES PHIEUGH(SoPGH),
CONSTRAINT foreign_ctpgh2 FOREIGN KEY (MaNGK) REFERENCES NGK(MaNGK));

CREATE TABLE HOADON
(SoHD char(4) NOT NULL, 
NgaylapHD date NOT NULL, 
MaKH char(4) NOT NULL,
CONSTRAINT primt_hd PRIMARY KEY (SoHD),
CONSTRAINT foreign_hd FOREIGN KEY (MaKH) REFERENCES KH(MaKH));

CREATE TABLE CT_HOADON
(SoHD char(4) NOT NULL, 
MaNGK varchar(3) NOT NULL, SLKHMua int NOT NULL, 
DGBan int NOT NULL,
CONSTRAINT prim_cthd PRIMARY KEY (SoHD, MaNGK),
CONSTRAINT foreign_cthd1 FOREIGN KEY (SoHD) REFERENCES HOADON(SoHD),
CONSTRAINT foreign_cthd2 FOREIGN KEY (MaNGK) REFERENCES NGK(MaNGK));

CREATE TABLE CT_PH 
(SoPH char(4) NOT NULL,
MaNGK varchar(3) NOT NULL, SLHen int NOT NULL,
CONSTRAINT prim_ctph PRIMARY KEY (SoPH, MaNGK),
CONSTRAINT foreign_ctph2 FOREIGN KEY (MaNGK) REFERENCES NGK(MaNGK));

CREATE TABLE PHIEUHEN 
(SoPH char(4) NOT NULL, 
NgayLapPH date NOT NULL, 
NgayHenGiao date NOT NULL,
MaKH char(4) NOT NULL,
CONSTRAINT prim_ph PRIMARY KEY (SoPH),
CONSTRAINT foreign_ph FOREIGN KEY (MaKH) REFERENCES KH(MaKH),
CONSTRAINT foreign_ph2 FOREIGN KEY (SoPH) REFERENCES PHIEUHEN(SoPH));

CREATE TABLE PHIEUTRANO 
(SoPTN char(5) NOT NULL,
NgayTra date NOT NULL, 
SoTienTra money NOT NULL, 
SoHD char(4) NOT NULL,
CONSTRAINT prim_ptn PRIMARY KEY (SoPTN),
CONSTRAINT foreign_ptn FOREIGN KEY (SoHD) REFERENCES HOADON (SoHD));
-- 2. Thêm thuộc tính GHICHU có kiểu dữ liệu varchar(50) cho quan hệ NGK --
ALTER TABLE NGK
ADD GHICHU varchar(50);
-- 3. Thêm vào thuộc tính KHUYENMAI có kiểu dữ liệu là int cho quan hệ HOADON --
ALTER TABLE HOADON
ADD KHUYENMAI int;
-- 4. Sửa kiểu dữ liệu của thuộc tính GHICHU trong quan hệ NGK thành varchar(100). --
ALTER TABLE NGK
ALTER COLUMN GHICHU varchar(100);
-- 5. Xóa thuộc tính GHICHU trong quan hệ NGK --
ALTER TABLE NGK
DROP COLUMN GHICHU;

/* II. Ngôn ngữ thao tác dữ liệu (Data Manipulation Language): */
-- 1. Nhập dữ liệu cho các quan hệ trên.
INSERT INTO dbo.KH VALUES 
('KH01', 'Cửa hàng BT', '144 XVNT', '088405996'),
('KH02', 'Cửa hàng Trà', '198/42 NTT', '085974572'),
('KH03', 'Siêu thị Coop', '24 ĐTH', '086547888');

INSERT INTO dbo.NHACC VALUES 
('NC1', 'Công ty NGK quốc tế CocaCola', 'Xa lộ Hà Nội, Thủ Đức, TP.HCM', '088967908'),
('NC2', 'Công ty NGK quốc tế Pepsi', 'Bến Chương Dương, Quận 1, TP.HCM', '083663366'),
('NC3', 'Công ty NGK Bến Chương Dương', 'Hàm Tử, Q5, TP.HCM', '089456677');

INSERT INTO dbo.LOAINGK VALUES 
('NK1', N'Nước ngọt có gas', 'NC1'),
('NK2', N'Nước ngọt không gas', 'NC2'),
('NK3', N'Trà', 'NC1'),
('NK4', N'Sữa', 'NC2');

INSERT INTO dbo.NGK VALUES 
('CC1', 'Coca Cola', 'Chai', 'NK1'),
('CC2', 'Coca Cola', 'Lon', 'NK1'),
('PS1', 'Pepsi', 'Chai','NK1'),
('PS2', 'Pepsi', 'Lon', 'NK1'),
('SV1', 'Seven Up', 'Chai', 'NK1'),
('SV2', 'Seven Up', 'Lon', 'NK1'),
('NO1', 'Number One', 'Chai', 'NK1'),
('NO2', 'Number One', 'Lon', 'NK1'),
('ST1', N'Sting dâu', 'Chai', 'NK1'),
('ST2', N'Sting dâu', 'Lon', 'NK1'),
('C2', N'Trà C2', 'Chai', 'NK2'),
('OD', N'Trà xanh không độ', 'Chai', 'NK2'),
('ML1', N'Sữa tươi tiệt trùng', N'Bịch', 'NK1'),
('WT1', N'Nước uống đóng chai', 'Chai', 'NK2');

INSERT INTO dbo.DDH VALUES 
('DDH01', '2011-05-10', 'NC1'),
('DDH02', '2011-05-20', 'NC1'),
('DDH03', '2011-05-26', 'NC2'),
('DDH04', '2011-06-03', 'NC2');

INSERT INTO dbo.CT_DDH VALUES 
('DDH01', 'CC1', 20),
('DDH01', 'CC2', 15),
('DDH01', 'PS1', 18),
('DDH01', 'SV2', 12),
('DDH02', 'CC2', 30),
('DDH02', 'PS2', 10),
('DDH02', 'SV1', 5),
('DDH02', 'ST1', 15),
('DDH02', 'C2', 10),
('DDH03', 'OD', 45),
('DDH04', 'CC1', 8),
('DDH04', 'ST2', 12);

INSERT INTO dbo.PHIEUGH VALUES 
('PGH01', '2010-05-12', 'DDH01'),
('PGH02', '2010-05-15', 'DDH01'),
('PGH03', '2010-05-21', 'DDH02'),
('PGH04', '2010-05-22', 'DDH02'),
('PGH05', '2010-05-28', 'DDH03');

INSERT INTO dbo.CT_PGH VALUES 
('PGH01', 'CC1', 15, 5000),
('PGH01', 'CC2', 15, 4000),
('PGH01', 'SV2', 10, 4000),
('PGH02', 'SV2', 2, 4000),
('PGH03', 'CC2', 30, 5000),
('PGH03', 'PS2', 10, 4000),
('PGH03', 'ST1', 15, 9000),
('PGH03', 'C2', 10, 8000);

INSERT INTO dbo.HOADON VALUES 
('HD01', '2010-05-10', 'KH01'),
('HD02', '2010-05-20', 'KH01'),
('HD03', '2010-06-05', 'KH02'),
('HD04', '2010-06-16', 'KH02'),
('HD05', '2011-06-22', 'KH02'),
('HD06', '2010-07-08', 'KH03');

INSERT INTO CT_HOADON VALUES 
('HD01', 'CC1', 20, 6000),
('HD01', 'CC2', 50, 5000),
('HD02', 'ST1', 40, 10000),
('HD03', 'SV2', 60, 5000),
('HD04', 'PS2', 25, 5000),
('HD05', 'CC1', 100, 6000),
('HD05', 'SV1', 12, 8000),
('HD05', 'C2', 80, 9000),
('HD06', 'OD', 55, 1000),
('HD06', 'ST2', 50, 11000);

INSERT INTO dbo.PHIEUHEN VALUES 
('PH01', '2010-05-08', '2010-06-09', 'KH01'),
('PH02', '2010-05-25', '2010-06-28', 'KH02'),
('PH03', '2010-06-01', '2010-06-02', 'KH03');

INSERT INTO dbo.CT_PH VALUES 
('PH01', 'ST2', 10),
('PH01', 'OD', 8),
('PH02', 'CC1', 20),
('PH03', 'ST1', 7),
('PH03', 'SV2', 12),
('PH03', 'CC2', 9),
('PH04', 'PS2', 15);

INSERT INTO dbo.PHIEUTRANO VALUES 
('PTN01', '2010-05-18', 500000, 'HD01'),
('PTN02', '2010-06-01', 350000, 'HD01'),
('PTN03', '2010-06-02', 650000, 'HD02'),
('PTN04', '2010-06-15', 1020000, 'HD03'),
('PTN05', '2010-07-01', 1080000, 'HD03');
-- 2. Cập nhật giá trị KHUYENMAI là 10 đối với những HOADON được lập trong tháng 10 năm 2010--
UPDATE HOADON
SET KHUYENMAI = 10
WHERE NgaylapHD > '2010-09-30' AND NgaylapHD < '2010-11-01';
-- 3. Thêm 1 dòng có giá trị (‘HD01’, ‘ST1’, 20, 60) vào quan hệ CT_HOADON--
INSERT INTO CT_HOADON
VALUES ('HD01', 'ST1', 20, 60);
-- 4. Cập nhật tăng DGBan lên 5% đối với MaNGK là ‘CC2’ --
UPDATE CT_HOADON
SET DGBan = DGBan * 1.05
WHERE MaNGK = 'CC2';
-- 5. Xóa các dòng có DGBan lớn hơn 150 trong quan hệ CT_HOADON--
DELETE FROM CT_HOADON
WHERE DGBan > 150;

/* III. Ngôn ngữ truy vấn dữ liệu: SQL */
-- 1. Cho biết danh sách các nước giải khát có mã loại ngk là NK1. --
SELECT * FROM NGK
WHERE MaLoaiNGK = 'NK1';
-- 2. Liệt kê các hóa đơn mua hàng trong năm 2010 --
SELECT * FROM HOADON
WHERE YEAR(NgaylapHD) = 2010;
-- 3. Cho biết chi tiết các đơn hàng có số lượng đặt (SLDat) nhỏ hơn 60--
SELECT dh.SoDDH, dh.NgayDH, dh.MaNCC, ct.MaNGK, ct.SLDat
FROM DDH dh JOIN CT_DDH ct ON dh.SoDDH = ct.SoDDH 
WHERE ct.SLDat < 60;
SELECT * FROM dbo.DDH
WHERE SoDDH IN (SELECT SoDDH FROM dbo.CT_DDH WHERE SLDat < 60);
-- 4. Cho biết thông tin các phiếu trả nợ có số tiền trả lớn hơn 500000 đồng--
SELECT * FROM PHIEUTRANO
WHERE SoTienTra > 500000;
-- 5. Cho biết thông tin nước giải khát có Quycach là ‘Lon’ --
SELECT * FROM NGK
WHERE Quycach = 'Lon';
-- 6. Hiển thị thông tin của NGK chưa bán được --
SELECT * FROM NGK
WHERE MaNGK NOT IN (SELECT MaNGK FROM CT_HOADON);
-- 7. Hiển thị tên và tổng số lượng bán của từng NGK. -- 
SELECT n.TenNGK, SUM(ct.SLKHMua) AS "TongSLBan" FROM NGK n LEFT JOIN CT_HOADON ct ON n.MaNGK = ct.MaNGK
GROUP BY n.TenNGK;
-- 8. Hiển thị tên và tổng số lượng của NGK nhập về. --
SELECT n.TenNGK, SUM(ct.SLDat) AS "TỔNG SỐ LƯỢNG NHẬP" FROM NGK n JOIN CT_DDH ct ON n.MaNGK = ct.MaNGK
GROUP BY n.TenNGK;
-- 9. Hiển thị ĐĐH đã đặt NGK với số lượng nhiều nhất so với các ĐĐH khác có đặt NGK đó. Thông tin hiển thị: SoDDH, MaNGK, [SL đặt nhiều nhất]
SELECT SoDDH, ct.MaNGK, SLDat AS "SL đặt nhiều nhất"
FROM CT_DDH ct
JOIN ( 
	SELECT MaNGK, MAX(SLDat) AS MaxSLDat
    FROM CT_DDH ct
    GROUP BY MaNGK
) AS MaxSL ON ct.MaNGK = MaxSL.MaNGK AND ct.SLDat = MaxSL.MaxSLDat;
 -- 10. Hiển thị các NGK không được nhập trong tháng 1/2010
SELECT * FROM NGK 
WHERE MaNGK NOT IN (
    SELECT DISTINCT ct.MaNGK 
    FROM CT_DDH ct JOIN DDH dh ON ct.SoDDH = dh.SoDDH
    WHERE YEAR(dh.NgayDH) = 2010 AND MONTH(dh.NgayDH) = 1
);
-- 11. Hiển thị tên các NGK không bán được trong tháng 6/2010
SELECT TenNGK FROM NGK 
WHERE MaNGK NOT IN (
	SELECT DISTINCT ct.MaNGK 
	FROM CT_HOADON ct JOIN HOADON hd ON ct.SoHD = hd.SoHD
	WHERE YEAR(hd.NgaylapHD) = 2010 AND MONTH(hd.NgaylapHD) =5
);
-- 12. Cho biết cửa hàng bán bao nhiêu loại NGK
SELECT COUNT(*) AS "SỐ LOẠI NGK" FROM NGK;
-- 13. Hiển thị thông tin của khách hàng có giao dịch với cửa hàng nhiều nhất (căn cứ vào số lần mua hàng).
SELECT * FROM KH 
WHERE MaKH = (
	SELECT TOP 1 MaKH FROM HOADON
	GROUP BY MaKH
	ORDER BY COUNT(SoHD) DESC
);
-- 14. Tính tổng doanh thu năm 2010 của cửa hàng
SELECT SUM(SLKHMua * DGBan) AS TongDoanhThu 
FROM CT_HOADON ct JOIN HOADON hd ON ct.SoHD = hd.SoHD 
WHERE YEAR(hd.NgaylapHD) = 2010;
-- 15. Liệt kê 5 loại NGK bán chạy nhất (doanh thu) trong tháng 5/2010
SELECT TOP 5 n.MaNGK, hd.SoHD, hd.NgaylapHD, ct.SLKHMua, ct.DGBan, n.TenNGK, 
SUM(ct.SLKHMua * ct.DGBan) AS DoanhThu
FROM NGK n JOIN CT_HOADON ct ON n.MaNGK = ct.MaNGK JOIN HOADON hd ON ct.SoHD = hd.SoHD
WHERE YEAR(hd.NgaylapHD) = 2010 AND MONTH(hd.NgaylapHD) = 5
GROUP BY n.MaNGK,hd.SoHD,hd.NgaylapHD, n.TenNGK, ct.SLKHMua, ct.DGBan
ORDER BY SUM(ct.SLKHMua * ct.DGBan) DESC, n.MaNGK;
-- 16. Liệt kê thông tin bán NGK của tháng 5/2010. Thông tin hiển thị: Mã NGK, Tên NGK, SL bán.
SELECT n.MaNGK, n.TenNGK, ct.SLKHMua AS "SL BÁN" 
FROM NGK n JOIN CT_HOADON ct ON n.MaNGK = ct.MaNGK JOIN HOADON hd ON ct.SoHD = hd.SoHD
WHERE YEAR(hd.NgaylapHD) = 2010 AND MONTH(hd.NgaylapHD) = 5;
-- 17. Liệt kê thông tin của NGK có nhiều người mua nhất --
SELECT TOP 1 n.TenNGK, ct.SLKHMua
FROM NGK n JOIN CT_HOADON ct ON n.MaNGK = ct.MaNGK
ORDER BY ct.SLKHMua DESC;
-- 18. Hiển thị ngày nhập hàng gần nhất của cửa hàng
SELECT MAX(NgayDH) AS "NGÀY ĐH GẦN NHẤT" 
FROM DDH;
-- 19. Cho biết số lần mua hàng của khách có mã là ‘KH001’.
SELECT COUNT(SoHD) AS "SỐ LẦN MUA HÀNG" 
FROM HOADON 
WHERE MaKH = 'KH01';
-- 20. Cho biết tổng tiền của từng hóa đơn
SELECT SoHD, SUM(SLKHMua * DGBan) "TỔNG TIỀN" 
FROM CT_HOADON 
GROUP BY SoHD
/* 21. Cho biết danh sách các hóa đơn gồm SoHD, NgaylapHD, MaKH, TenKH và tổng trị giá của 
từng HoaDon. Danh sách sắp xếp tăng dần theo ngày và giảm dần theo tổng trị giá của hóa đơn */
SELECT hd.SoHD, hd.NgaylapHD, kh.MaKH, kh.TenKH, SUM (ct.SLKHMua * ct.DGBan) AS "TỔNG TRỊ GIÁ"
FROM KH kh JOIN HOADON hd ON kh.MaKH = hd.MaKH JOIN CT_HOADON ct ON hd.SoHD = ct.SoHD
GROUP BY hd.SoHD, hd.NgaylapHD, kh.MaKH, kh.TenKH
ORDER BY hd.NgaylapHD DESC, SUM (ct.SLKHMua * ct.DGBan) 
-- 22. Cho biết các hóa đơn có tổng trị giá lớn hơn tổng trị giá trung bình của các hóa đơn trong ngày 8/06/2010
SELECT SoHD, SUM(SLKHMua * DGBan) "TỔNG TIỀN" 
FROM CT_HOADON 
GROUP BY SoHD
HAVING SUM(SLKHMua * DGBan) > (
	SELECT AVG(ct.SLKHMua * ct.DGBan) "TỔNG TIỀN" FROM CT_HOADON ct JOIN HOADON hd ON ct.SoHD = hd.SoHD
	WHERE YEAR(hd.NgaylapHD) = 2010 AND MONTH(hd.NgaylapHD) = 6 AND DAY(hd.NgaylapHD) = 8
);
-- 23. Cho biết số lượng từng NGK tiêu thụ theo từng tháng của năm 2010
SELECT ct.MaNGK ,COUNT(hd.SoHD) AS "SỐ LƯỢNG BÁN", 
MONTH(hd.NgaylapHD) AS "THÁNG", YEAR(hd.NgaylapHD) AS "NĂM"
FROM HOADON hd JOIN CT_HOADON ct ON hd.SoHD = hd.SoHD  WHERE YEAR(hd.NgaylapHD) = 2010
GROUP BY ct.MaNGK, YEAR(hd.NgaylapHD), MONTH(hd.NgaylapHD) 
ORDER BY MONTH(hd.NgaylapHD), YEAR(hd.NgaylapHD)
-- 24. Đưa ra danh sách NGK chưa được bán trong tháng 9 năm 2010.
SELECT TenNGK FROM NGK 
WHERE MaNGK NOT IN (
	SELECT DISTINCT ct.MaNGK 
	FROM CT_HOADON ct JOIN HOADON hd ON ct.SoHD = hd.SoHD
	WHERE YEAR(hd.NgaylapHD) = 2010 AND MONTH(hd.NgaylapHD) = 9
);
-- 25. Đưa ra danh sách khách hàng có địa chỉ ở TP.HCM và từng mua NGK trong tháng 9 năm 2010
SELECT * FROM KH 
WHERE MaKH IN (
	SELECT kh.MaKH FROM KH kh JOIN HOADON hd ON kh.MaKH = hd.MaKH
	WHERE kh.DCKH LIKE '%TP.HCM' AND MONTH(hd.NgaylapHD) = 9
);
-- 26. Đưa ra số lượng đã bán tương ứng của từng NGK trong tháng 10 năm 2010.
SELECT n.MaNGK, n.TenNGK, COUNT(ct.SoHD) AS "SỐ LƯỢNG BÁN"
FROM NGK n JOIN CT_HOADON ct ON n.MaNGK = ct.MaNGK JOIN HOADON hd ON ct.SoHD = hd.SoHD
WHERE YEAR(hd.NgaylapHD) = 2010 AND MONTH(hd.NgaylapHD) = 10
GROUP BY n.MaNGK, n.TenNGK;
-- 27. Hiển thị thông tin khách hàng đã từng mua và tổng số lượng của từng NGK tại cửa hàng.
SELECT kh.MaKH, kh.TenKH, kh.DCKH, kh.DTKH,
COUNT(hd.SoHD) AS "TỔNG SỐ HÓA ĐƠN",
SUM(ct.SLKHMua) AS "TỔNG SỐ LƯỢNG KHÁCH HÀNG MUA"
FROM KH kh JOIN HOADON hd ON kh.MaKH = hd.MaKH JOIN CT_HOADON ct ON hd.SoHD = ct.SoHD
GROUP BY kh.MaKH, kh.TenKH, kh.DCKH, kh.DTKH;
-- 28. Cho biết trong năm 2010, khách hàng nào đã mua nợ nhiều nhất.
SELECT kh.MaKH, kh.TenKH, kh.DCKH, kh.DTKH, SUM(ptn.SoTienTra) AS TongSoTienTra
FROM PHIEUTRANO ptn JOIN HOADON hd ON ptn.SoHD = hd.SoHD JOIN KH kh ON kh.MaKH = hd.MaKH
WHERE YEAR(hd.NgaylapHD) = 2010
GROUP BY kh.MaKH, kh.TenKH, kh.DCKH, kh.DTKH
HAVING SUM(ptn.SoTienTra) = (SELECT MAX(TongSoTienTra) 
                              FROM (SELECT SUM(ptn2.SoTienTra) AS TongSoTienTra
                                    FROM PHIEUTRANO ptn2 JOIN HOADON hd2 ON ptn2.SoHD = hd2.SoHD 
                                    WHERE YEAR(hd2.NgaylapHD) = 2010
                                    GROUP BY hd2.MaKH) AS MaxTongSoTienTra)
ORDER BY kh.MaKH;
-- 29. Có bao nhiêu hóa đơn chưa thanh toán hết số tiền?
SELECT COUNT(*) AS "SỐ HD CHƯA THANH TOÁN HẾT" 
FROM HOADON hd
WHERE hd.SoHD NOT IN (
    SELECT ptn.SoHD FROM PHIEUTRANO ptn
    GROUP BY ptn.SoHD
    HAVING SUM(ptn.SoTienTra) >= (
        SELECT SUM(ct.SLKHMua * ct.DGBan)
        FROM CT_HOADON ct
        WHERE ct.SoHD = hd.SoHD
    )
);
-- 30. Liệt kê các hóa đơn cùng tên của khách hàng tương ứng đã mua NGK và thanh toán tiền đầy đủ 1 lần. (Không có phiếu trả nợ)
SELECT hd.SoHD, kh.TenKH
FROM HOADON hd
JOIN KH kh ON hd.MaKH = kh.MaKH
LEFT JOIN PHIEUTRANO ptn ON hd.SoHD = ptn.SoHD
WHERE ptn.SoHD IS NULL
AND hd.SoHD IN (
    SELECT SoHD
    FROM CT_HOADON
    GROUP BY SoHD
    HAVING SUM(SLKHMua * DGBan) = (
        SELECT SUM(SLKHMua * DGBan)
        FROM CT_HOADON
        WHERE SoHD = hd.SoHD
    )
);
-- 31. Thống kê cho biết thông tin đặt hàng của cửa hàng trong năm 2010: Mã NGK, Tên NGK, Tổng SL đặt.
SELECT n.MaNGK, n.TenNGK, SUM(ct.SLDat) AS "TỔNG SỐ LƯỢNG ĐẶT"
FROM NGK n JOIN CT_DDH ct ON n.MaNGK = ct.MaNGK JOIN DDH dh ON ct.SoDDH = dh.SoDDH
WHERE YEAR(dh.NgayDH) = 2010
GROUP BY n.MaNGK, n.TenNGK;
/* 32. Để thuận tiện trong việc tặng quà Tết cho khách hàng, hãy liệt kê danh sách khách hàng
đã mua NGK với tổng số tiền tương ứng trong năm 2010 (hiển thị giảm dần theo số tiền đã mua). */
SELECT kh.MaKH, kh.TenKH, kh.DCKH, kh.DTKH, SUM(ct.SLKHMua * DGBan) AS "TỔNG SỐ TIỀN ĐÃ MUA"
FROM KH kh JOIN HOADON hd ON kh.MaKH = hd.MaKH JOIN CT_HOADON ct ON hd.SoHD = ct.SoHD
WHERE YEAR(hd.NgaylapHD) = 2010
GROUP BY kh.MaKH, kh.TenKH, kh.DCKH, kh.DTKH
ORDER BY SUM(ct.SLKHMua * DGBan) DESC;
















 