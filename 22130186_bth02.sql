CREATE DATABASE QUANLIGIAOVU
USE QUANLIGIAOVU
/* A. Ngôn ngữ định nghĩa dữ liệu (DDL) */
-- 1. Tạo quan hệ và khai báo tất cả các ràng buộc khóa chính, khóa ngoại
CREATE TABLE KHOA (MAKHOA varchar(4) NOT NULL, TENKHOA varchar(40) NOT NULL, NGTLAP smalldatetime NOT NULL,
TRGKHOA char(4) NULL);
CREATE TABLE MONHOC (MAMH varchar(10) NOT NULL, TENMH varchar(40) NOT NULL, TCLT tinyint NOT NULL, TCTH tinyint NOT NULL,
MAKHOA varchar(4) NOT NULL);
CREATE TABLE DIEUKIEN (MAMH varchar(10) NOT NULL, MAMH_TRUOC varchar(10) NOT NULL);
CREATE TABLE GIAOVIEN (MAGV char(4) NOT NULL, HOTEN varchar(40) NOT NULL, HOCVI varchar(10) NOT NULL, 
HOCHAM varchar(10) NULL, GIOITINH varchar(3) NOT NULL, NGSINH smalldatetime NOT NULL, NGVL smalldatetime NOT NULL, 
HESO numeric(4, 2) NOT NULL, MUCLUONG money NOT NULL, MAKHOA varchar(4) NOT NULL);
CREATE TABLE LOP (MALOP char(3) NOT NULL, TENLOP varchar(40) NOT NULL, TRGLOP char(5) NOT NULL, 
SISO tinyint NOT NULL, MAGVCN char(4) NOT NULL);
CREATE TABLE HOCVIEN (MAHV char(5) NOT NULL, HO varchar(40) NOT NULL, TEN varchar(10)  NOT NULL, 
NGSINH smalldatetime NOT NULL, GIOITINH varchar(3) NOT NULL, NOISINH varchar(40) NOT NULL, MALOP char(3) NOT NULL);
CREATE TABLE GIANGDAY (MALOP char(3) NOT NULL, MAMH varchar(10) NOT NULL, MAGV char(4) NOT NULL, HOCKY tinyint NOT NULL, 
NAM smallint NOT NULL, TUNGAY smalldatetime NOT NULL, DENNGAY smalldatetime NOT NULL);
CREATE TABLE KETQUATHI (MAHV char(5) NOT NULL, MAMH varchar(10) NOT NULL, LANTHI tinyint NOT NULL, 
NGTHI smalldatetime NOT NULL, DIEM numeric(4,2) NOT NULL, KQUA varchar(10) NOT NULL);

ALTER TABLE KHOA 
ADD CONSTRAINT prim_khoa PRIMARY KEY (MAKHOA);
ALTER TABLE MONHOC
ADD CONSTRAINT prim_mh PRIMARY KEY (MAMH);
ALTER TABLE MONHOC 
ADD CONSTRAINT foreign_mh FOREIGN KEY (MAKHOA) REFERENCES KHOA (MAKHOA);
ALTER TABLE DIEUKIEN
ADD CONSTRAINT prim_dk PRIMARY KEY (MAMH, MAMH_TRUOC);
ALTER TABLE DIEUKIEN
ADD CONSTRAINT foreign_dk FOREIGN KEY (MAMH) REFERENCES MONHOC (MAMH);
ALTER TABLE DIEUKIEN
ADD CONSTRAINT foreign_dk2 FOREIGN KEY (MAMH_TRUOC) REFERENCES MONHOC (MAMH);
ALTER TABLE GIAOVIEN
ADD CONSTRAINT prim_gv PRIMARY KEY (MAGV);
ALTER TABLE GIAOVIEN
ADD CONSTRAINT foreign_gv FOREIGN KEY (MAKHOA) REFERENCES KHOA(MAKHOA);
ALTER TABLE LOP
ADD CONSTRAINT prim_lop PRIMARY KEY (MALOP);
ALTER TABLE LOP
ADD CONSTRAINT foreign_lop FOREIGN KEY (MAGVCN) REFERENCES GIAOVIEN(MAGV);
ALTER TABLE HOCVIEN
ADD CONSTRAINT prim_hv PRIMARY KEY (MAHV);
ALTER TABLE HOCVIEN
ADD CONSTRAINT foreign_hv FOREIGN KEY (MALOP) REFERENCES LOP(MALOP);
ALTER TABLE LOP
ADD CONSTRAINT foreign_trlop FOREIGN KEY (TRGLOP) REFERENCES HOCVIEN(MAHV);
ALTER TABLE GIANGDAY 
ADD CONSTRAINT prim_gd PRIMARY KEY (MALOP, MAMH);
ALTER TABLE GIANGDAY
ADD CONSTRAINT foreign_gdlop FOREIGN KEY (MALOP) REFERENCES LOP(MALOP);
ALTER TABLE GIANGDAY
ADD CONSTRAINT foreign_gdmh FOREIGN KEY (MAMH) REFERENCES MONHOC(MAMH);
ALTER TABLE GIANGDAY
ADD CONSTRAINT foreign_gdgv FOREIGN KEY (MAGV) REFERENCES GIAOVIEN(MAGV);
ALTER TABLE KETQUATHI
ADD CONSTRAINT prim_kq PRIMARY KEY (MAHV, MAMH, LANTHI);
ALTER TABLE KETQUATHI
ADD CONSTRAINT foreign_kqhv FOREIGN KEY (MAHV) REFERENCES HOCVIEN(MAHV);
ALTER TABLE KETQUATHI
ADD CONSTRAINT foreign_kqmh FOREIGN KEY (MAMH) REFERENCES MONHOC(MAMH);
-- 2. Thêm vào thuộc tính NAMSINH cho quan hệ HOCVIEN
ALTER TABLE HOCVIEN
ADD NAMSINH smallint NOT NULL;
-- 3. Thêm vào các thuộc tính THAMNIEN, PCTHAMNIEN (phụ cấp thâm niên) cho quan hệ GIAOVIEN
ALTER TABLE GIAOVIEN
ADD THAMNIEN smallint NULL, PCTHAMNIEN numeric(5, 2) NULL;
ALTER TABLE GIAOVIEN
ALTER COLUMN PCTHAMNIEN numeric(9, 2)
/* 4. Thêm vào các ràng buộc toàn vẹn sau:
a. Thuộc tính GIOITINH chỉ có giá trị là “Nam” hoặc “Nu”.
b. Điểm số có giá trị từ 0 đến 10
c. Học kỳ chỉ có giá trị từ 1 đến 3.
d. Học vị của giáo viên chỉ có thể là “CN”, “KS”, “Ths”, ”TS”, ”PTS”.
e. Một môn học phải có ngày bắt đầu (TUNGAY) nhỏ hơn ngày kết thúc (DENNGAY). */
ALTER TABLE HOCVIEN
ADD CONSTRAINT check_gt CHECK (GIOITINH IN ('Nam', 'Nu'));
ALTER TABLE GIAOVIEN
ADD CONSTRAINT check_gtgv CHECK (GIOITINH IN ('Nam', 'Nu'));
ALTER TABLE KETQUATHI
ADD CONSTRAINT check_diem CHECK(DIEM >= 0 AND DIEM <= 10);
ALTER TABLE GIANGDAY
ADD CONSTRAINT check_hocky CHECK(HOCKY >= 1 AND HOCKY <= 3);
ALTER TABLE GIAOVIEN
ADD CONSTRAINT check_hocvi CHECK(HOCVI IN('CN', 'KS', 'Ths', 'TS', 'PTS'));
ALTER TABLE GIANGDAY
ADD CONSTRAINT check_ngayhoc CHECK(TUNGAY < DENNGAY);

/* B. Ngôn ngữ thao tác dữ liệu (DML) */
-- 1. Nhập toàn bộ dữ liệu cho các quan hệ trên
INSERT INTO KHOA VALUES 
('KHMT', 'Khoa hoc may tinh', '2005-06-07', 'GV01'),
('HTTT', 'He thong thong tin', '2005-06-07', 'GV02'), 
('CNPM', 'Cong nghe phan mem', '2005-06-07', 'GV04'),
('MTT', 'Mang va truyen thong', '2005-10-20', 'GV03'),
('KTMT', 'Ky thuat may tinh', '2005-12-19', NULL);
INSERT INTO LOP VALUES
('K11', 'Lop 1 khoa 1', 'K1108', 11, 'GV07'),
('K12',	'Lop 2 khoa 1', 'K1205', 12, 'GV09'),
('K13', 'Lop 3 khoa 1', 'K1305', 12, 'GV14');
INSERT INTO GIAOVIEN VALUES 
('GV01', 'Ho Thanh Son', 'PTS', 'GS', 'Nam', '1950-05-02', '2004-01-11', 5.00, 2250000, 'KHMT'),
('GV02', 'Tran Tam Thanh', 'TS', 'PGS', 'Nam', '1965-12-17', '2004-04-20', 4.50, 2025000, 'HTTT'),
('GV03','Do Nghiem Phung', 'TS', 'GS', 'Nu', '1950-08-01', '2004-09-23', 4.00, 1800000, 'CNPM'),
('GV04', 'Tran Nam Son', 'TS', 'PGS', 'Nam', '1961-02-22', '2005-01-12', 4.50, 2025000, 'KTMT'),
('GV05', 'Mai Thanh Danh', 'ThS', 'GV', 'Nam', '1958-03-12', '2005-01-12', 3.00, 1350000, 'HTTT'),
('GV06', 'Tran Doan Hung', 'TS', 'GV', 'Nam', '1953-03-11', '2005-01-12', 4.50, 2025000, 'KHMT'),
('GV07', 'Nguyen Minh Tien', 'ThS', 'GV', 'Nam', '1971-11-23', '2005-03-01', 4.00, 1800000, 'KHMT'),
('GV08', 'Le Thi Tran', 'KS', NULL, 'Nu', '1974-03-26', '2005-03-01', 1.69, 760500, 'KHMT'),
('GV09', 'Nguyen To Lan', 'ThS', 'GV', 'Nu', '1966-12-31', '2005-03-01', 4.00, 1800000, 'HTTT'),
('GV10', 'Le Tran Anh Loan', 'KS', NULL, 'Nu', '1972-07-17', '2005-03-01', 1.86, 837000, 'CNPM'),
('GV11', 'Ho Thanh Tung', 'CN', 'GV', 'Nam', '1980-01-12', '2005-05-15', 2.67, 1201500, 'MTT'),
('GV12', 'Tran Van Anh', 'CN', NULL, 'Nu', '1981-03-29', '2005-05-15', 1.69, 760500, 'CNPM'),
('GV13', 'Nguyen Linh Dan', 'CN', NULL, 'Nu', '1980-05-23', '2005-05-15', 1.69, 760500, 'KTMT'),
('GV14', 'Truong Minh Chau', 'ThS', 'GV', 'Nu', '1976-11-30', '2005-05-15', 3.00, 1350000, 'MTT'),
('GV15', 'Le Ha Thanh', 'ThS', 'GV', 'Nam', '1978-05-04', '2005-05-15', 3.00, 1350000, 'KHMT');
INSERT INTO HOCVIEN VALUES
('K1101', 'Nguyen Van', 'A', '1986-01-27', 'Nam', 'TpHCM', 'K11'),
('K1102', 'Tran Ngoc', 'Han', '1986-03-14', 'Nu', 'Kien Giang', 'K11'),
('K1103', 'Ha Duy', 'Lap', '1986-04-18', 'Nam', 'Nghe An', 'K11'),
('K1104', 'Tran Ngoc', 'Linh', '1986-03-30', 'Nu', 'Tay Ninh', 'K11'),
('K1105', 'Tran Minh', 'Long', '1986-02-27', 'Nam', 'TpHCM', 'K11'),
('K1106', 'Le Nhat', 'Minh', '1986-01-24', 'Nam', 'TpHCM', 'K11'),
('K1107', 'Nguyen Nhu', 'Nhut', '1986-01-27', 'Nam', 'Ha Noi', 'K11'),
('K1108', 'Nguyen Manh', 'Tam', '1986-02-27', 'Nam', 'Kien Giang', 'K11'),
('K1109', 'Phan Thi Thanh', 'Tam', '1986-01-27', 'Nu', 'Vinh Long', 'K11'),
('K1110', 'Le Hoai', 'Thuong', '1986-02-05', 'Nu', 'Can Tho', 'K11'),
('K1111', 'Le Ha', 'Vinh', '1986-12-25', 'Nam', 'Vinh Long', 'K11'),
('K1201', 'Nguyen Van', 'B', '1986-02-11', 'Nam', 'TpHCM', 'K12'),
('K1202', 'Nguyen Thi Kim', 'Duyen', '1986-01-18', 'Nu', 'TpHCM', 'K12'),
('K1203', 'Tran Thi Kim', 'Duyen', '1986-09-17', 'Nu', 'TpHCM', 'K12'),
('K1204', 'Truong My', 'Hanh', '1986-05-19', 'Nu', 'Dong Nai', 'K12'),
('K1205', 'Nguyen Thanh', 'Nam', '1986-04-17', 'Nam', 'TpHCM', 'K12'),
('K1206', 'Nguyen Thi Truc', 'Thanh', '1986-03-04', 'Nu', 'Kien Giang', 'K12'),
('K1207', 'Tran Thi Bich', 'Thuy', '1986-02-08', 'Nu', 'Nghe An', 'K12'),
('K1208', 'Huynh Thi Kim', 'Trieu', '1986-04-08', 'Nu', 'Tay Ninh', 'K12'),
('K1209', 'Pham Thanh', 'Trieu', '1986-02-23', 'Nam', 'TpHCM', 'K12'),
('K1210', 'Ngo Thanh', 'Tuan', '1986-02-14', 'Nam', 'TpHCM', 'K12'),
('K1211', 'Do Thi', 'Xuan', '1986-03-09', 'Nu', 'Ha Noi', 'K12'),
('K1212', 'Le Thi Phi', 'Yen', '1986-03-12', 'Nu', 'TpHCM', 'K12'),
('K1301', 'Nguyen Thi Kim', 'Cuc', '1986-06-09', 'Nu', 'Kien Giang', 'K13'),
('K1302', 'Truong Thi My', 'Hien', '1986-03-18', 'Nu', 'Nghe An', 'K13'),
('K1303', 'Le Duc', 'Hien', '1986-03-21', 'Nam', 'Tay Ninh', 'K13'),
('K1304', 'Le Quang', 'Hien', '1986-04-18', 'Nam', 'TpHCM', 'K13'),
('K1305', 'Le Thi', 'Huong', '1986-03-27', 'Nu', 'TpHCM', 'K13'),
('K1306', 'Nguyen Thai', 'Huu', '1986-03-30', 'Nam', 'Ha Noi', 'K13'),
('K1307', 'Tran Minh', 'Man', '1986-05-28', 'Nam', 'TpHCM', 'K13'),
('K1308', 'Nguyen Hieu', 'Nghia', '1986-04-08', 'Nam', 'Kien Giang', 'K13'),
('K1309', 'Nguyen Trung', 'Nghia', '1987-01-18', 'Nam', 'Nghe An', 'K13'),
('K1310', 'Tran Thi Hong', 'Tham', '1986-04-22', 'Nu', 'Tay Ninh', 'K13'),
('K1311', 'Tran Minh', 'Thuc', '1986-04-04', 'Nam', 'TpHCM', 'K13'),
('K1312', 'Nguyen Thi Kim', 'Yen', '1986-09-07', 'Nu', 'TpHCM', 'K13');
INSERT INTO MONHOC VALUES
('THDC', 'Tin hoc dai cuong', 4, 1, 'KHMT'),
('CTRR', 'Cau truc roi rac', 5, 0, 'KHMT'),
('CSDL', 'Co so du lieu', 3, 1, 'HTTT'),
('CTDLGT', 'Cau truc du lieu va giai thuat', 3, 1, 'KHMT'),
('PTTKTT', 'Phan tich thiet ke thuat toan', 3, 0, 'KHMT'),
('DHMT', 'Do hoa may tinh', 3, 1, 'KHMT'),
('KTMT', 'Kien truc may tinh', 3, 0, 'KTMT'),
('TKCSDL', 'Thiet ke co so du lieu', 3, 1, 'HTTT'),
('PTTKHTTT', 'Phan tich thiet ke he thong thong tin', 4, 1, 'HTTT'),
('HDH', 'He dieu hanh', 4, 0, 'KTMT'),
('NMCNPM', 'Nhap mon cong nghe phan mem', 3, 0, 'CNPM'),
('LTCFW', 'Lap trinh C for win', 3, 1, 'CNPM'),
('LTHDT', 'Lap trinh huong doi tuong', 3, 1, 'CNPM');
INSERT INTO GIANGDAY VALUES
('K11', 'THDC', 'GV07', 1, 2006, '2006-01-02', '2006-05-12'),
('K12', 'THDC', 'GV06', 1, 2006, '2006-01-02', '2006-05-12'),
('K13', 'THDC', 'GV15', 1, 2006, '2006-01-02', '2006-05-12'),
('K11', 'CTRR', 'GV02', 1, 2006, '2006-01-09', '2006-05-17'),
('K12', 'CTRR', 'GV02', 1, 2006, '2006-01-09', '2006-05-17'),
('K13', 'CTRR', 'GV08', 1, 2006, '2006-01-09', '2006-05-17'),
('K11', 'CSDL', 'GV05', 2, 2006, '2006-06-01', '2006-07-15'),
('K12', 'CSDL', 'GV09', 2, 2006, '2006-06-01', '2006-07-15'),
('K13', 'CTDLGT', 'GV15', 2, 2006, '2006-06-01', '2006-07-15'),
('K13', 'CSDL', 'GV05', 3, 2006, '2006-08-01', '2006-12-15'),
('K13', 'DHMT', 'GV07', 3, 2006, '2006-08-01', '2006-12-15'),
('K11', 'CTDLGT', 'GV15', 3, 2006, '2006-08-01', '2006-12-15'),
('K12', 'CTDLGT', 'GV15', 3, 2006, '2006-08-01', '2006-12-15'),
('K11', 'HDH', 'GV04', 1, 2007, '2007-01-02', '2007-02-18'),
('K12', 'HDH', 'GV04', 1, 2007, '2007-01-02', '2007-03-20'),
('K11', 'DHMT', 'GV07', 1, 2007, '2007-02-18', '2007-03-20');
INSERT INTO DIEUKIEN VALUES
('CSDL', 'CTRR'),
('CSDL', 'CTDLGT'),
('CTDLGT', 'THDC'),
('PTTKTT', 'THDC'),
('PTTKTT', 'CTDLGT'),
('DHMT', 'THDC'),
('LTHDT', 'THDC'),
('PTTKHTTT', 'CSDL');
INSERT INTO KETQUATHI VALUES
('K1101', 'CSDL', 1, '2006-07-20', 10.00, 'Dat'),
('K1101', 'CTDLGT', 1, '2006-12-28', 9.00, 'Dat'),
('K1101', 'THDC', 1, '2006-05-20', 9.00, 'Dat'),
('K1101', 'CTRR', 1, '2006-05-13', 9.50, 'Dat'),
('K1102', 'CSDL', 1, '2006-07-20', 4.00, 'Khong Dat'),
('K1102', 'CSDL', 2, '2006-07-27', 4.25, 'Khong Dat'),
('K1102', 'CSDL', 3, '2006-08-10', 4.50, 'Khong Dat'),
('K1102', 'CTDLGT', 1, '2006-12-28', 4.50, 'Khong Dat'),
('K1102', 'CTDLGT', 2, '2007-01-05', 4.00, 'Khong Dat'),
('K1102', 'CTDLGT', 3, '2007-01-15', 6.00, 'Dat'),
('K1102', 'THDC', 1, '2006-05-20', 5.00, 'Dat'),
('K1102', 'CTRR', 1, '2006-05-13', 7.00, 'Dat'),
('K1103', 'CSDL', 1, '2006-07-20', 3.50, 'Khong Dat'),
('K1103', 'CSDL', 2, '2006-07-27', 8.25, 'Dat'),
('K1103', 'CTDLGT', 1, '2006-12-28', 7.00, 'Dat'),
('K1103', 'THDC', 1, '2006-05-20', 8.00, 'Dat'),
('K1103', 'CTRR', 1, '2006-05-13', 6.50, 'Dat'),
('K1104', 'CSDL', 1, '2006-07-20', 3.75, 'Khong Dat'),
('K1104', 'CTDLGT', 1, '2006-12-28', 4.00, 'Khong Dat'),
('K1104', 'THDC', 1, '2006-05-20', 4.00, 'Khong Dat'),
('K1104', 'CTRR', 1, '2006-05-13', 4.00, 'Khong Dat'),
('K1104', 'CTRR', 2, '2006-05-20', 3.50, 'Khong Dat'),
('K1104', 'CTRR', 3, '2006-06-30', 4.00, 'Khong Dat'),
('K1201', 'CSDL', 1, '2006-07-20', 6.00, 'Dat'),
('K1201', 'CTDLGT', 1, '2006-12-28', 5.00, 'Dat'),
('K1201', 'THDC', 1, '2006-05-20', 8.50, 'Dat'),
('K1201', 'CTRR', 1, '2006-05-13', 9.00, 'Dat'),
('K1202', 'CSDL', 1, '2006-07-20', 8.00, 'Dat'),
('K1202', 'CTDLGT', 1, '2006-12-28', 4.00, 'Khong Dat'),
('K1202', 'CTDLGT', 2, '2007-01-05', 5.00, 'Dat'),
('K1202', 'THDC', 1, '2006-05-20', 4.00, 'Khong Dat'),
('K1202', 'THDC', 2, '2006-05-27', 4.00, 'Khong Dat'),
('K1202', 'CTRR', 1, '2006-05-13', 3.00, 'Khong Dat'),
('K1202', 'CTRR', 2, '2006-05-20', 4.00, 'Khong Dat'),
('K1202', 'CTRR', 3, '2006-06-30', 6.25, 'Dat'),
('K1203', 'CSDL', 1, '2006-07-20', 9.25, 'Dat'),
('K1203', 'CTDLGT', 1, '2006-12-28', 9.50, 'Dat'),
('K1203', 'THDC', 1, '2006-05-20', 10.00, 'Dat'),
('K1203', 'CTRR', 1, '2006-05-13', 10.00, 'Dat'),
('K1204', 'CSDL', 1, '2006-07-20', 8.50, 'Dat'),
('K1204', 'CTDLGT', 1, '2006-12-28', 6.75, 'Dat'),
('K1204', 'THDC', 1, '2006-05-20', 4.00, 'Khong Dat'),
('K1204', 'CTRR', 1, '2006-05-13', 6.00, 'Dat'),
('K1301', 'CSDL', 1, '2006-12-20', 4.25, 'Khong Dat'),
('K1301', 'CTDLGT', 1, '2006-07-25', 8.00, 'Dat'),
('K1301', 'THDC', 1, '2006-05-20', 7.75, 'Dat'),
('K1301', 'CTRR', 1, '2006-05-13', 8.00, 'Dat'),
('K1302', 'CSDL', 1, '2006-12-20', 6.75, 'Dat'),
('K1302', 'CTDLGT', 1, '2006-07-25', 5.00, 'Dat'),
('K1302', 'THDC', 1, '2006-05-20', 8.00, 'Dat'),
('K1302', 'CTRR', 1, '2006-05-13', 8.50, 'Dat'),
('K1303', 'CSDL', 1, '2006-12-20', 4.00, 'Khong Dat'),
('K1303', 'CTDLGT', 1, '2006-07-25', 4.50, 'Khong Dat'),
('K1303', 'CTDLGT', 2, '2006-08-07', 4.00, 'Khong Dat'),
('K1303', 'CTDLGT', 3, '2006-08-15', 4.25, 'Khong Dat'),
('K1303', 'THDC', 1, '2006-05-20', 4.50, 'Khong Dat'),
('K1303', 'CTRR', 1, '2006-05-13', 3.25, 'Khong Dat'),
('K1303', 'CTRR', 2, '2006-05-20', 5.00, 'Dat'),
('K1304', 'CSDL', 1, '2006-12-20', 7.75, 'Dat'),
('K1304', 'CTDLGT', 1, '2006-07-25', 9.75, 'Dat'),
('K1304', 'THDC', 1, '2006-05-20', 5.50, 'Dat'),
('K1304', 'CTRR', 1, '2006-05-13', 5.00, 'Dat'),
('K1305', 'CSDL', 1, '2006-12-20', 9.25, 'Dat'),
('K1305', 'CTDLGT', 1, '2006-07-25', 10.00, 'Dat'),
('K1305', 'THDC', 1, '2006-05-20', 8.00, 'Dat'),
('K1305', 'CTRR', 1, '2006-05-13', 10.00, 'Dat');
-- 2. Cập nhật giá trị NAMSINH cho quan hệ HOCVIEN bằng giá trị year(NGAYSINH)
UPDATE HOCVIEN
SET NAMSINH = YEAR(NGSINH);
-- 3. Cập nhật giá trị THAMNIEN cho quan hệ GIAOVIEN bằng giá trị year(GETDATE())-year(NGVL)
UPDATE GIAOVIEN
SET THAMNIEN = YEAR(GETDATE()) - YEAR(NGVL);
-- 4. Cập nhật giá trị PCTHAMNIEN cho quan hệ GIAOVIEN như sau:
/*	Nếu THAMNIEN >5 : PCTHAMNIEN là 500000
	Nếu 5>=THAMNIEN >3 : PCTHAMNIEN là 300000
	Nếu 3>=THAMNIEN >1 : PCTHAMNIEN là 100000 */
UPDATE GIAOVIEN
SET PCTHAMNIEN = 
	CASE
        WHEN THAMNIEN > 5 THEN 500000.00
        WHEN THAMNIEN > 3 THEN 300000.00
        WHEN THAMNIEN > 1 THEN 100000.00
        ELSE 0 
    END;

/* C. Sử dụng ngôn ngữ SQL thực hiện các yêu cầu sau */
-- 1. Cho biết danh sách các khoa được thành lập trong 6 tháng cuối năm 2005
SELECT * FROM KHOA
WHERE YEAR(NGTLAP) = 2005 AND MONTH(NGTLAP) IN (7, 8, 9, 10, 11, 12);
-- 2. Cho biết danh sách các khoa chưa có trưởng khoa
SELECT * FROM KHOA
WHERE TRGKHOA IS NULL;
-- 3. Cho biết danh sách các khoa có tên khoa bắt đầu bởi ký tự ‘k’ và kết thúc bởi ký tự ‘h’.
SELECT * FROM KHOA
WHERE TENKHOA LIKE 'k%h';
-- 4. Cho biết danh sách các khoa được thành lập sớm nhất
SELECT * FROM KHOA
WHERE NGTLAP IN (SELECT MIN(NGTLAP) FROM KHOA);
-- 5. Cho biết danh sách giáo viên có mức lương thấp nhất
SELECT * FROM GIAOVIEN
WHERE MUCLUONG IN (SELECT MIN(MUCLUONG) FROM GIAOVIEN);
-- 6. Cho biết danh sách giáo viên có hoc vị tiến sĩ và nhỏ hơn 50 tuổi
SELECT * FROM GIAOVIEN
WHERE HOCVI = 'TS' AND YEAR(GETDATE()) - YEAR(NGSINH) < 50;
-- 7. Cho biết danh sách giáo viên nam có mức lương >1800000
SELECT * FROM GIAOVIEN
WHERE GIOITINH = 'Nam' AND MUCLUONG > 1800000;
-- 8. Cho biết danh sách giáo viên lớn tuổi nhất
SELECT * FROM GIAOVIEN
WHERE NGSINH IN (SELECT MIN(NGSINH) FROM GIAOVIEN);
-- 9. Cho biết danh sách học viên nữ, sinh tại Vĩnh long và lớn hơn 30 tuổi
SELECT * FROM HOCVIEN
WHERE GIOITINH = 'Nu' AND NOISINH = 'Vinh Long' AND YEAR(GETDATE()) - YEAR(NGSINH) > 30;
-- 10. Cho biết danh sách học viên nhỏ tuổi nhất
SELECT * FROM HOCVIEN
WHERE NGSINH IN (SELECT MAX(NGSINH) FROM HOCVIEN);
-- 11. In ra danh sách (mã học viên, họ tên, ngày sinh, mã lớp) lớp trưởng của các lớp
SELECT hv.MAHV, hv.HO, hv.TEN, c.MALOP
FROM HOCVIEN hv JOIN LOP c ON hv.MALOP = c.MALOP
WHERE hv.MAHV = c.TRGLOP;
-- 12. In ra điểm thi môn CSDL (mã học viên, họ tên , lần thi, điểm số) sắp xếp theo tên, họ học viên.
SELECT hv.MAHV, hv.HO, hv.TEN, kq.LANTHI, kq.DIEM
FROM KETQUATHI kq JOIN HOCVIEN hv ON kq.MAHV = hv.MAHV
ORDER BY hv.TEN, hv.HO;
-- 13. In danh sách học viên và điểm thi môn CSDL (chỉ lấy điểm của lần thi sau cùng).
SELECT hv.MAHV, hv.HO, hv.TEN, kq.MAMH, kq.DIEM, kq.LANTHI
FROM HOCVIEN hv JOIN KETQUATHI kq ON hv.MAHV = kq.MAHV
WHERE kq.MAMH = 'CSDL'
AND kq.LANTHI = (
    SELECT MAX(LANTHI)
    FROM KETQUATHI
    WHERE MAHV = hv.MAHV AND MAMH = 'CSDL'
);
-- 14. In Danh sách học viên và điểm thi môn “Co So Du Lieu” (chỉ lấy điểm cao nhất của các lần thi).
SELECT hv.MAHV, hv.HO, hv.TEN, mh.MAMH, mh.TENMH, kq.DIEM
FROM HOCVIEN hv 
JOIN KETQUATHI kq ON hv.MAHV = kq.MAHV
JOIN MONHOC mh ON kq.MAMH = mh.MAMH
WHERE mh.TENMH = 'Co so du lieu' 
AND kq.DIEM = (
    SELECT MAX(DIEM)
    FROM KETQUATHI
    WHERE MAHV = hv.MAHV AND MAMH = 'CSDL'
);
-- 15. In ra danh sách những học viên (mã học viên, họ tên) và những môn học mà học viên đó thi lần thứ nhất đã đạt.
SELECT hv.MAHV, hv.HO, hv.TEN, mh.MAMH, mh.TENMH, kq.LANTHI, kq.KQUA, kq.DIEM
FROM HOCVIEN hv
JOIN KETQUATHI kq ON hv.MAHV = kq.MAHV
JOIN MONHOC mh ON kq.MAMH = mh.MAMH
WHERE kq.LANTHI = 1 AND kq.KQUA = 'Dat';
-- 16. In ra danh sách học viên (mã học viên, họ tên) thi môn CTRR không đạt (ở lần thi 1)
SELECT hv.MAHV, hv.HO, hv.TEN, mh.MAMH, mh.TENMH, kq.LANTHI, kq.KQUA, kq.DIEM
FROM HOCVIEN hv
JOIN KETQUATHI kq ON hv.MAHV = kq.MAHV
JOIN MONHOC mh ON kq.MAMH = mh.MAMH
WHERE mh.TENMH = 'Cau truc roi rac' AND kq.LANTHI = 1 AND kq.KQUA = 'Khong Dat';
-- 17. Tìm tên những môn học mà giáo viên có tên “Tran Tam Thanh” dạy trong học kỳ 1 năm 2006.
SELECT mh.TENMH, gv.HOTEN, gd.HOCKY, gd.NAM
FROM MONHOC mh 
JOIN GIANGDAY gd ON mh.MAMH = gd.MAMH 
JOIN GIAOVIEN gv ON gv.MAGV = gd.MAGV
WHERE gv.HOTEN = 'Tran Tam Thanh' AND gd.HOCKY = 1 AND gd.NAM = 2006;
-- 18. Tìm những môn học (mã môn học, tên môn học) mà giáo viên chủ nhiệm lớp “K11” dạy trong học kỳ 1 năm 2006.
SELECT mh.MAMH, mh.TENMH, gd.MAGV, gd.HOCKY, gd.NAM
FROM MONHOC mh 
JOIN GIANGDAY gd ON mh.MAMH = gd.MAMH 
JOIN LOP c ON gd.MALOP = c.MALOP
WHERE gd.MAGV = (
	SELECT c2.MAGVCN FROM LOP c2
	WHERE c2.MALOP = 'K11'
) 
AND gd.HOCKY = 1 AND gd.NAM = 2006;
-- 19. Tìm họ tên lớp trưởng của các lớp mà giáo viên có tên “Nguyen To Lan” dạy môn “Co So Du Lieu”.
SELECT hv.HO, hv.TEN, hv.MAHV, c.TRGLOP, gd.MAGV, gv.HOTEN, mh.TENMH
FROM LOP c 
JOIN HOCVIEN hv ON c.TRGLOP = hv.MAHV 
JOIN GIANGDAY gd ON c.MALOP = gd.MALOP
JOIN MONHOC mh ON gd.MAMH = mh.MAMH 
JOIN GIAOVIEN gv ON gd.MAGV = gv.MAGV
WHERE gv.HOTEN = 'Nguyen To Lan' AND mh.TENMH = 'Co so du lieu';
-- 20. In ra danh sách những môn học (mã môn học, tên môn học) phải học liền trước môn “Co So Du Lieu”
SELECT mh.MAMH, mh.TENMH, dk.MAMH_TRUOC
FROM DIEUKIEN dk JOIN MONHOC mh ON dk.MAMH = mh.MAMH
WHERE dk.MAMH_TRUOC = (
	SELECT MAMH FROM MONHOC 
	WHERE TENMH = 'Co so du lieu'
);
-- 21. Môn “Cau Truc Roi Rac” là môn bắt buộc phải học liền trước những môn học (mã môn học, tên môn học) nào.
SELECT mh.MAMH, mh.TENMH, dk.MAMH_TRUOC
FROM DIEUKIEN dk JOIN MONHOC mh ON dk.MAMH = mh.MAMH
WHERE dk.MAMH_TRUOC = (
	SELECT MAMH FROM MONHOC 
	WHERE TENMH = 'Cau truc roi rac'
);
-- 22. Tìm họ tên giáo viên dạy môn CTRR cho cả hai lớp “K11” và “K12” trong cùng học kỳ 1 năm 2006
SELECT gv.HOTEN, c.MALOP, mh.TENMH, gd.HOCKY, gd.NAM
FROM LOP c 
JOIN HOCVIEN hv ON c.TRGLOP = hv.MAHV 
JOIN GIANGDAY gd ON c.MALOP = gd.MALOP
JOIN MONHOC mh ON gd.MAMH = mh.MAMH 
JOIN GIAOVIEN gv ON gd.MAGV = gv.MAGV
WHERE mh.MAMH = 'CTRR' AND c.MALOP IN ('K11', 'K12') AND gd.HOCKY = 1 AND gd.NAM = 2006;
-- 23. Thống kê số lượng học viên của từng lớp. Danh sách gồm: mã lớp, tên lớp, số lượng học viên. sắp xếp theo số lượng giảm dần
SELECT MALOP, TENLOP, SISO FROM LOP
ORDER BY SISO DESC ;
-- 24. Thống kê có bao nhiêu giáo viên có học vị là “CN”, “KS”, “Ths”, “TS”, “PTS” trong mỗi khoa
SELECT khoa.TENKHOA,
       SUM(CASE WHEN gv.HOCVI = 'CN' THEN 1 ELSE 0 END) AS SoGV_CN,
       SUM(CASE WHEN gv.HOCVI = 'KS' THEN 1 ELSE 0 END) AS SoGV_KS,
       SUM(CASE WHEN gv.HOCVI = 'Ths' THEN 1 ELSE 0 END) AS SoGV_Ths,
       SUM(CASE WHEN gv.HOCVI = 'TS' THEN 1 ELSE 0 END) AS SoGV_TS,
       SUM(CASE WHEN gv.HOCVI = 'PTS' THEN 1 ELSE 0 END) AS SoGV_PTS
FROM GIAOVIEN gv JOIN KHOA khoa ON gv.MAKHOA = khoa.MAKHOA
GROUP BY khoa.TENKHOA;
/* 25. Thống kê số lượng giáo viên theo độ tuổi. Cao tuổi: trên 60 tuổi, 
Trung niên: từ 40 đến 60 tuổi, Trẻ : dưới 40 tuổi Danh sách gồm: độ tuổi, số lượng giáo viên */
SELECT
    SUM(CASE WHEN YEAR(GETDATE()) - YEAR(NGSINH) > 60 THEN 1 ELSE 0 END) AS Cao_Tuoi,
    SUM(CASE WHEN YEAR(GETDATE()) - YEAR(NGSINH) BETWEEN 40 AND 60 THEN 1 ELSE 0 END) AS Trung_Nien,
    SUM(CASE WHEN YEAR(GETDATE()) - YEAR(NGSINH) < 40 THEN 1 ELSE 0 END) AS Tre
FROM GIAOVIEN;
-- 26. Mỗi môn học thống kê số lượng học viên theo kết quả (đạt và không đạt).
SELECT mh.MAMH, mh.TENMH,
    SUM(CASE WHEN kq.KQUA = 'Dat' THEN 1 ELSE 0 END) AS SOLUONG_DAT,
    SUM(CASE WHEN kq.KQUA = 'Khong Dat' THEN 1 ELSE 0 END) AS SOLUONG_KHONG_DAT
FROM MONHOC mh JOIN KETQUATHI kq ON mh.MAMH = kq.MAMH
GROUP BY mh.MAMH, mh.TENMH;
-- 27. Tìm giáo viên (mã giáo viên, họ tên) là giáo viên chủ nhiệm của một lớp, đồng thời dạy cho lớp đó ít nhất một môn học.
SELECT gv.MAGV, gv.HOTEN, gd.MAMH, gd.MALOP, c.MAGVCN
FROM LOP c 
JOIN GIANGDAY gd ON c.MALOP = gd.MALOP 
JOIN GIAOVIEN gv ON gd.MAGV = gv.MAGV
WHERE c.MAGVCN = gd.MAGV;
-- 28. Tìm giáo viên (mã giáo viên, họ tên) không được phân công giảng dạy bất kỳ môn học nào
SELECT gv.MAGV, gv.HOTEN
FROM GIAOVIEN gv LEFT JOIN GIANGDAY gd ON gv.MAGV = gd.MAGV
WHERE gd.MAMH IS NULL
-- 29. Tìm giáo viên (mã giáo viên, họ tên) đã dạy hết tất cả các môn học của khoa quản lý
SELECT gv.MAGV, gv.HOTEN
FROM GIAOVIEN gv
JOIN MONHOC mh ON gv.MAKHOA = mh.MAKHOA  
LEFT JOIN GIANGDAY gd ON gv.MAGV = gd.MAGV AND mh.MAMH = gd.MAMH
GROUP BY gv.MAGV, gv.HOTEN
HAVING COUNT(DISTINCT mh.MAMH) = COUNT(DISTINCT gd.MAMH); 
-- 30. Tìm họ tên lớp trưởng của lớp có sỉ số cao nhất.
SELECT hv.HO, hv.TEN
FROM HOCVIEN hv JOIN LOP c ON hv.MAHV = c.TRGLOP 
WHERE c.SISO IN (
	SELECT MAX(SISO) FROM LOP
);
-- 31. Tìm họ tên những LOPTRG thi không đạt quá 3 môn (mỗi môn đều thi không đạt ở tất cả các lần thi).
SELECT hv.HO, hv.TEN
FROM LOP c 
JOIN HOCVIEN hv ON c.TRGLOP = hv.MAHV 
JOIN KETQUATHI kq ON kq.MAHV = c.TRGLOP
GROUP BY hv.HO, hv.TEN
HAVING SUM(CASE WHEN kq.KQUA = 'Khong Dat' THEN 1 ELSE 0 END) >= 3
-- 32. Tìm học viên (mã học viên, họ tên) có số môn đạt điểm 9,10 nhiều nhất.
SELECT TOP 1 hv.MAHV, hv.HO, hv.TEN, COUNT(kq.DIEM) AS "SO DIEM 9, 10"
FROM HOCVIEN hv JOIN KETQUATHI kq ON hv.MAHV = kq.MAHV
WHERE kq.DIEM IN (9, 10)
GROUP BY hv.MAHV,hv.HO, hv.TEN
ORDER BY COUNT(kq.DIEM) DESC
-- 33. Trong từng lớp, tìm học viên (mã học viên, họ tên) có số môn đạt điểm 9,10 nhiều nhất.
WITH HocVienDiem AS (
    SELECT hv.MAHV, hv.HO, hv.TEN, c.MALOP, COUNT(kq.DIEM) AS So_Diem_9_10,
    ROW_NUMBER() OVER (PARTITION BY c.MALOP ORDER BY COUNT(kq.DIEM) DESC) AS RowNum
    FROM HOCVIEN hv JOIN KETQUATHI kq ON hv.MAHV = kq.MAHV JOIN LOP c ON hv.MALOP = c.MALOP
    WHERE kq.DIEM IN (9, 10)
    GROUP BY hv.MAHV, hv.HO, hv.TEN, c.MALOP
)
SELECT MALOP, MAHV, HO, TEN, So_Diem_9_10 FROM HocVienDiem WHERE RowNum = 1;
-- 34. Trong từng học kỳ của từng năm, mỗi giáo viên phân công dạy bao nhiêu môn học, bao nhiêu lớp
SELECT gv.MAGV, gv.HOTEN, gd.HOCKY, gd.NAM, 
COUNT(DISTINCT gd.MAMH) AS "SO MON HOC",
COUNT(DISTINCT MALOP) AS "SO LOP"
FROM GIAOVIEN gv JOIN GIANGDAY gd ON gv.MAGV = gd.MAGV 
GROUP BY gv.MAGV, gv.HOTEN, gd.HOCKY, gd.NAM
ORDER BY MAGV, HOCKY, NAM;
-- 35. Trong từng học kỳ của từng năm, tìm giáo viên (mã giáo viên, họ tên) giảng dạy nhiều nhất.
WITH TeacherSubjectCounts AS (
	SELECT gv.MAGV, gv.HOTEN AS HO_TEN, gd.HOCKY, gd.NAM, 
	COUNT(DISTINCT gd.MAMH) AS SO_MON_HOC,
	COUNT(DISTINCT gd.MALOP) AS SO_LOP,
	ROW_NUMBER() OVER (PARTITION BY gd.HOCKY, gd.NAM ORDER BY COUNT(DISTINCT gd.MAMH) DESC) AS RowNum
    FROM GIAOVIEN gv JOIN GIANGDAY gd ON gv.MAGV = gd.MAGV
    GROUP BY gv.MAGV, gv.HOTEN, gd.HOCKY, gd.NAM
)
SELECT MAGV, HO_TEN, HOCKY, NAM, SO_MON_HOC, SO_LOP
FROM TeacherSubjectCounts WHERE RowNum = 1 ORDER BY HOCKY, NAM;
-- 36. Thống kê số lượng các môn thi theo từng học kỳ,từng năm.
SELECT HOCKY, NAM, COUNT(DISTINCT MAMH) AS "SO MON THI"
FROM GIANGDAY
GROUP BY HOCKY, NAM
ORDER BY NAM, HOCKY;
-- 37. Tìm môn học (mã môn học, tên môn học) có nhiều học viên thi không đạt (ở lần thi thứ 1) nhất.
SELECT TOP 1 mh.MAMH, mh.TENMH, COUNT(kq.MAHV) AS "SO LUONG SV KO DAT"
FROM KETQUATHI kq JOIN MONHOC mh ON kq.MAMH = mh.MAMH
WHERE kq.LANTHI = 1 AND kq.KQUA = 'Khong Dat'
GROUP BY mh.MAMH, mh.TENMH
ORDER BY COUNT(kq.MAHV) DESC
-- 38. Tìm học viên (mã học viên, họ tên) thi môn nào cũng đạt (chỉ xét lần thi thứ 1)
SELECT MAHV, HO, TEN
FROM HOCVIEN
WHERE MAHV NOT IN (
	SELECT MAHV FROM KETQUATHI 
	WHERE LANTHI = 1 AND KQUA = 'Khong Dat'
);
-- 39. Tìm học viên (mã học viên, họ tên) thi môn nào cũng đạt (chỉ xét lần thi sau cùng).
SELECT MAHV, HO, TEN
FROM HOCVIEN
WHERE MAHV NOT IN (
	SELECT MAHV FROM KETQUATHI 
	WHERE LANTHI = (
		SELECT MAX(LANTHI) FROM KETQUATHI
	)
	AND KQUA = 'Khong Dat'
);
-- 40. Tìm học viên (mã học viên, họ tên) có điểm thi cao nhất trong từng môn (lấy điểm ở lần thi sau cùng).
WITH MaxScores AS (
    SELECT hv.MAHV, hv.HO, hv.TEN, kq.MAMH, mh.TENMH, kq.DIEM,
    ROW_NUMBER() OVER (PARTITION BY kq.MAMH ORDER BY kq.DIEM DESC) AS RankOrder
    FROM HOCVIEN hv 
	JOIN KETQUATHI kq ON hv.MAHV = kq.MAHV 
	JOIN MONHOC mh ON kq.MAMH = mh.MAMH
    WHERE kq.LANTHI = (
		SELECT MAX(LANTHI) FROM KETQUATHI 
		WHERE MAHV = hv.MAHV AND MAMH = kq.MAMH
	)
)
SELECT MAHV, HO, TEN, MAMH, TENMH, DIEM
FROM MaxScores
WHERE RankOrder = 1;






