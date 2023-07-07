-- TẠO DATABASE
GO
CREATE DATABASE LinhKienDienTu
GO
USE LinhKienDienTu
-- TẠO BẢNG
GO
CREATE TABLE QUANTRI
(
	TAIKHOAN VARCHAR(30),
	MATKHAU VARCHAR(30),
	CONSTRAINT PK_QUANTRI PRIMARY KEY (TAIKHOAN, MATKHAU)
)
GO
CREATE TABLE KHACHHANG
(
	MAKH INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	TENKH  NVARCHAR(50),
	DIACHI NVARCHAR(50),
	SDT VARCHAR(11) NOT NULL,
	GIOITINH NVARCHAR(30),
	NGAYSINH DATETIME,
	TAIKHOAN VARCHAR(30),
	MATKHAU VARCHAR(30),
	EMAIL VARCHAR(40)
)
-- TẠO RÀNG BUỘC
GO
ALTER TABLE KHACHHANG
ADD CONSTRAINT UNI_KHACHHANG UNIQUE (SDT)
GO
CREATE TABLE NHANVIEN
(
	MANV INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	TENNV  NVARCHAR(50),
	PHAI NVARCHAR(5),
	NGAYSINH DATETIME,
	SDT VARCHAR(11) NOT NULL,
)
-- TẠO RÀNG BUỘC
GO
ALTER TABLE NHANVIEN
ADD CONSTRAINT UNI_MANV UNIQUE (MANV)
GO
ALTER TABLE NHANVIEN
ADD CONSTRAINT UNI_SDT UNIQUE (SDT)
GO
CREATE TABLE HOADON
(
	MAHD INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	MAKH INT,
	MANV INT,
	NGAYLAPHD DATETIME,
	NGAYGIAO DATETIME
)
-- TẠO RÀNG BUỘC
GO
ALTER TABLE HOADON
ADD CONSTRAINT FK_HOADON_MAKH FOREIGN KEY (MAKH)
	REFERENCES KHACHHANG (MAKH)
GO
ALTER TABLE HOADON
ADD CONSTRAINT FK_HOADON_MANV FOREIGN KEY (MANV)
	REFERENCES NHANVIEN (MANV)
GO
ALTER TABLE HOADON
ADD CONSTRAINT UNI_HOADON UNIQUE (MAHD)
GO
CREATE TABLE LOAILINHKIEN
(
	MALOAI INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	TENLOAI NVARCHAR(50),
	NOTE VARCHAR(50)
)
-- TẠO RÀNG BUỘC
GO
ALTER TABLE LOAILINHKIEN
ADD CONSTRAINT UNI_LOAILINHKIEN UNIQUE (MALOAI)
GO
CREATE TABLE LINHKIEN
(
	MALK INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	MALOAI INT,
	TENLK NVARCHAR(50),
	HANGSX NVARCHAR(60),
	MOTA NVARCHAR(MAX),
	TGBH INT,
	NGAYCAPNHAT DATETIME,
	DONGIA DECIMAL(18,3),
	HINHANH VARCHAR(50)
)
-- TẠO RÀNG BUỘC
GO
ALTER TABLE LINHKIEN
ADD CONSTRAINT FK_LINHKIEN_MALOAI FOREIGN KEY (MALOAI)
	REFERENCES LOAILINHKIEN (MALOAI)
GO
ALTER TABLE LINHKIEN
ADD CONSTRAINT UNI_LINHKIEN UNIQUE (MALK)
GO
ALTER TABLE LINHKIEN
ADD CONSTRAINT CK_LINHKIEN_DONGIA CHECK (DONGIA > 0)
GO
CREATE TABLE CTHOADON
(
	MALK INT NOT NULL,
	MAHD INT NOT NULL,
	SOLUONG INT,
	THANHTIEN DECIMAL(18,3),
	CONSTRAINT PK_CTHOADON PRIMARY KEY (MALK, MAHD)
)
-- TẠO RÀNG BUỘC
GO
ALTER TABLE CTHOADON
ADD CONSTRAINT FK_CTHOADON_MALK FOREIGN KEY (MALK)
	REFERENCES LINHKIEN (MALK)
GO
ALTER TABLE CTHOADON
ADD CONSTRAINT FK_CTHOADON_MAHD FOREIGN KEY (MAHD)
	REFERENCES HOADON (MAHD)
GO
ALTER TABLE CTHOADON
ADD CONSTRAINT CK_CTHOADON_THANHTIEN CHECK (THANHTIEN > 0)
GO
ALTER TABLE CTHOADON
ADD CONSTRAINT CK_CTHOADON_SOLUONG CHECK (SOLUONG > 0)
GO
CREATE TABLE LOAITINTUC
(
	MALOAITIN INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	TENLOAITIN NVARCHAR(30)
)
-- TẠO RÀNG BUỘC
GO
ALTER TABLE LOAITINTUC
ADD CONSTRAINT UNI_LOAITINTUC UNIQUE (MALOAITIN)
GO
CREATE TABLE TINTUC
(
	MATIN INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	TENTIEUDE NVARCHAR(250),
	NOIDUNG NVARCHAR(MAX),
	NGAYDANG DATETIME,
	HINHANH VARCHAR(50),
	MALOAITIN INT  NOT NULL,
)
-- TẠO RÀNG BUỘC
GO
ALTER TABLE TINTUC
ADD CONSTRAINT FK_TINTUC_MALOAITIN FOREIGN KEY (MALOAITIN)
	REFERENCES LOAITINTUC (MALOAITIN)
GO
ALTER TABLE TINTUC
ADD CONSTRAINT UNI_TINTUC UNIQUE (MATIN)
----THÊM DỮ LIỆU
GO
INSERT INTO QUANTRI(TAIKHOAN, MATKHAU)
VALUES('phuc', '1111')
GO
INSERT INTO KHACHHANG(TENKH,DIACHI,SDT,GIOITINH,NGAYSINH,TAIKHOAN,MATKHAU,EMAIL) 
VALUES (N'Lê Huỳnh Phúc', N'TP.Hồ Chí Minh', '0989751723', N'Nam', '2001-03-21', 'phuc', '1412', 'huynhphuc@gmail.com'),
	(N'Triệu Phú Sang', N'TP.Hồ Chí Minh', '0918234654', N'Nam', '2001-11-01', 'sang', '23456', 'sang@gmail.com'),
	(N'Đặng Viết Anh', N'TP.Hồ Chí Minh', '0978123765', N'Nam', '2000-05-11','anh','34567', 'anh@gmail.com'),
	(N'Trần Vũ Kha', N'TP.Hồ Chí Minh', '0909456768', N'Nam','1999-02-02', 'kha','45678', 'kha@gmail.com')
GO
INSERT INTO NHANVIEN(TENNV, PHAI, NGAYSINH, SDT)
VALUES(N'Lê Huỳnh Phúc', N'Nam', '2001-03-21', N'0989751723'),
	(N'Triệu Phú Sang', N'Nam', '1988-02-03', N'0918234654'),
	(N'Trần Vũ Kha', N'Nam', '1988-02-04', N'0978123765'),
	(N'Trần Viết Anh', N'Nam', '1988-12-04', N'0909456768')
GO
INSERT INTO HOADON(MAKH, MANV, NGAYLAPHD, NGAYGIAO)
VALUES(1, 1, '2020-02-01', '2020-02-02'),
	(2, 2, '2020-03-01', '2020-03-02'),
	(3, 3, '2021-02-01', '2021-02-02'),
	(4, 4, '2020-03-01', '2020-03-02'),
	(1, 1, '2021-02-05', '2021-02-06')
GO
INSERT INTO LOAILINHKIEN(TENLOAI, NOTE) 
VALUES(N'PC Gaming', N'Còn hàng'),
	(N'CPU Bộ Vi Xử Lý', N'Còn hàng'),
	(N'VGA-Card Đồ Hoạ', N'Còn hàng'),
	(N'RAM', N'Còn hàng'),
	(N'Bo Mạch Chủ', N'Còn hàng')
GO
INSERT INTO LINHKIEN(MALOAI, TENLK, HANGSX, MOTA, TGBH, NGAYCAPNHAT, DONGIA, HINHANH)
VALUES(1, N'GVN MINION i1650', N'Intel', 
N'Thiết kế tinh tế và hiện đại
MSI GF63 Thin 11UD-473VN là một chiếc laptop gaming với thiết kế mỏng, nhẹ và vô cùng tinh tế cùng hiệu năng mạnh mẽ. Đây là một lựa chọn tuyệt vời cho nhiều người dùng ngày nay.
Hiệu năng thực sự ấn tượng
MSI đã trang bị cho chiếc laptop này những linh kiện tốt nhất nhằm có thể tối ưu hiệu năng và trải nghiệm cho người dùng. Bạn sẽ được sở hữu bộ vi xử lý thế hệ thứ 11 của Intel Core i5-11400H ( 2.7 GHz - 4.5 GHz / 12MB / 6 nhân, 12 luồng ).
Màn hình 15.6 inch, viền mỏng, độ phân giải FullHD
Giờ đây bạn có thể thoải mái thưởng thức trò chơi nhập vai trên một màn hình có tỷ lệ khung hình lớn hơn đây chính là một lợi thế dành cho các game thủ . Với viền màn hình mỏng, màn hình rộng 15.6 inch có tỷ lệ khung hình lớn hơn các dòng laptop gaming truyền thống khác đem lại một trải nghiệm chơi game choáng ngợp.
Bàn phím LED và cổng kết nối đa dạng
MSI GF63 Thin 11UD 473VN đã tiếp nối truyền thống của thương hiệu MSI bằng một bộ bàn phím được trang bị led đỏ nổi bật trên nền đen. Layout quen thuộc với khoảng cách phím vừa phải. Keycap của bàn phím có gờ nổi phía trên làm tăng độ chính xác khi gõ.',
12, '2021-02-01', 13290.000, 'pc1.jpg'),
(1, N'GVN VIPER Plus i3060', N'Intel', 
N'Thiết kế tinh tế và hiện đại
MSI GF63 Thin 11UD-473VN là một chiếc laptop gaming với thiết kế mỏng, nhẹ và vô cùng tinh tế cùng hiệu năng mạnh mẽ. Đây là một lựa chọn tuyệt vời cho nhiều người dùng ngày nay.
Hiệu năng thực sự ấn tượng
MSI đã trang bị cho chiếc laptop này những linh kiện tốt nhất nhằm có thể tối ưu hiệu năng và trải nghiệm cho người dùng. Bạn sẽ được sở hữu bộ vi xử lý thế hệ thứ 11 của Intel Core i5-11400H ( 2.7 GHz - 4.5 GHz / 12MB / 6 nhân, 12 luồng ).
Màn hình 15.6 inch, viền mỏng, độ phân giải FullHD
Giờ đây bạn có thể thoải mái thưởng thức trò chơi nhập vai trên một màn hình có tỷ lệ khung hình lớn hơn đây chính là một lợi thế dành cho các game thủ . Với viền màn hình mỏng, màn hình rộng 15.6 inch có tỷ lệ khung hình lớn hơn các dòng laptop gaming truyền thống khác đem lại một trải nghiệm chơi game choáng ngợp.
Bàn phím LED và cổng kết nối đa dạng
MSI GF63 Thin 11UD 473VN đã tiếp nối truyền thống của thương hiệu MSI bằng một bộ bàn phím được trang bị led đỏ nổi bật trên nền đen. Layout quen thuộc với khoảng cách phím vừa phải. Keycap của bàn phím có gờ nổi phía trên làm tăng độ chính xác khi gõ.',
12, '2021-02-01', 30000.000, 'pc2.jpg'),
(1, N'GVN VIPER Plus i3060Ti', N'Intel', 
N'Để đảm bảo mang đến tay người dùng bộ máy PC gaming chất lượng có thể chơi game và làm việc tốt nhất, GVN VIPER Plus i3060Ti được trang bị mainboard MSI MAG B660M MORTAR DDR4.',
12, '2021-02-01', 35000.000, 'pc3.jpg'),
(1, N'GVN ProArt Plus 5', N'Intel', 
N'Thiết kế tinh tế và hiện đại
MSI GF63 Thin 11UD-473VN là một chiếc laptop gaming với thiết kế mỏng, nhẹ và vô cùng tinh tế cùng hiệu năng mạnh mẽ. Đây là một lựa chọn tuyệt vời cho nhiều người dùng ngày nay.
Hiệu năng thực sự ấn tượng
MSI đã trang bị cho chiếc laptop này những linh kiện tốt nhất nhằm có thể tối ưu hiệu năng và trải nghiệm cho người dùng. Bạn sẽ được sở hữu bộ vi xử lý thế hệ thứ 11 của Intel Core i5-11400H ( 2.7 GHz - 4.5 GHz / 12MB / 6 nhân, 12 luồng ).
Màn hình 15.6 inch, viền mỏng, độ phân giải FullHD
Giờ đây bạn có thể thoải mái thưởng thức trò chơi nhập vai trên một màn hình có tỷ lệ khung hình lớn hơn đây chính là một lợi thế dành cho các game thủ . Với viền màn hình mỏng, màn hình rộng 15.6 inch có tỷ lệ khung hình lớn hơn các dòng laptop gaming truyền thống khác đem lại một trải nghiệm chơi game choáng ngợp.
Bàn phím LED và cổng kết nối đa dạng
MSI GF63 Thin 11UD 473VN đã tiếp nối truyền thống của thương hiệu MSI bằng một bộ bàn phím được trang bị led đỏ nổi bật trên nền đen. Layout quen thuộc với khoảng cách phím vừa phải. Keycap của bàn phím có gờ nổi phía trên làm tăng độ chính xác khi gõ.',
12, '2021-02-01', 49000.000, 'pc4.jpg'),
(1, N'GVN ProArt Plus 5', N'Intel', 
N'Thiết kế tinh tế và hiện đại
MSI GF63 Thin 11UD-473VN là một chiếc laptop gaming với thiết kế mỏng, nhẹ và vô cùng tinh tế cùng hiệu năng mạnh mẽ. Đây là một lựa chọn tuyệt vời cho nhiều người dùng ngày nay.
Hiệu năng thực sự ấn tượng
MSI đã trang bị cho chiếc laptop này những linh kiện tốt nhất nhằm có thể tối ưu hiệu năng và trải nghiệm cho người dùng. Bạn sẽ được sở hữu bộ vi xử lý thế hệ thứ 11 của Intel Core i5-11400H ( 2.7 GHz - 4.5 GHz / 12MB / 6 nhân, 12 luồng ).
Màn hình 15.6 inch, viền mỏng, độ phân giải FullHD
Giờ đây bạn có thể thoải mái thưởng thức trò chơi nhập vai trên một màn hình có tỷ lệ khung hình lớn hơn đây chính là một lợi thế dành cho các game thủ . Với viền màn hình mỏng, màn hình rộng 15.6 inch có tỷ lệ khung hình lớn hơn các dòng laptop gaming truyền thống khác đem lại một trải nghiệm chơi game choáng ngợp.
Bàn phím LED và cổng kết nối đa dạng
MSI GF63 Thin 11UD 473VN đã tiếp nối truyền thống của thương hiệu MSI bằng một bộ bàn phím được trang bị led đỏ nổi bật trên nền đen. Layout quen thuộc với khoảng cách phím vừa phải. Keycap của bàn phím có gờ nổi phía trên làm tăng độ chính xác khi gõ.',
12, '2021-02-01', 40000.000, 'pc5.jpg'),
(1, N'GVN ProArt Plus 5', N'Intel', 
N'Thiết kế tinh tế và hiện đại
MSI GF63 Thin 11UD-473VN là một chiếc laptop gaming với thiết kế mỏng, nhẹ và vô cùng tinh tế cùng hiệu năng mạnh mẽ. Đây là một lựa chọn tuyệt vời cho nhiều người dùng ngày nay.
Hiệu năng thực sự ấn tượng
MSI đã trang bị cho chiếc laptop này những linh kiện tốt nhất nhằm có thể tối ưu hiệu năng và trải nghiệm cho người dùng. Bạn sẽ được sở hữu bộ vi xử lý thế hệ thứ 11 của Intel Core i5-11400H ( 2.7 GHz - 4.5 GHz / 12MB / 6 nhân, 12 luồng ).
Màn hình 15.6 inch, viền mỏng, độ phân giải FullHD
Giờ đây bạn có thể thoải mái thưởng thức trò chơi nhập vai trên một màn hình có tỷ lệ khung hình lớn hơn đây chính là một lợi thế dành cho các game thủ . Với viền màn hình mỏng, màn hình rộng 15.6 inch có tỷ lệ khung hình lớn hơn các dòng laptop gaming truyền thống khác đem lại một trải nghiệm chơi game choáng ngợp.
Bàn phím LED và cổng kết nối đa dạng
MSI GF63 Thin 11UD 473VN đã tiếp nối truyền thống của thương hiệu MSI bằng một bộ bàn phím được trang bị led đỏ nổi bật trên nền đen. Layout quen thuộc với khoảng cách phím vừa phải. Keycap của bàn phím có gờ nổi phía trên làm tăng độ chính xác khi gõ.',
12, '2022-02-01', 69000.000, 'pc6.jpg'),
(1, N'GVN ProArt Plus 5', N'Intel', 
N'Thiết kế tinh tế và hiện đại
MSI GF63 Thin 11UD-473VN là một chiếc laptop gaming với thiết kế mỏng, nhẹ và vô cùng tinh tế cùng hiệu năng mạnh mẽ. Đây là một lựa chọn tuyệt vời cho nhiều người dùng ngày nay.
Hiệu năng thực sự ấn tượng
MSI đã trang bị cho chiếc laptop này những linh kiện tốt nhất nhằm có thể tối ưu hiệu năng và trải nghiệm cho người dùng. Bạn sẽ được sở hữu bộ vi xử lý thế hệ thứ 11 của Intel Core i5-11400H ( 2.7 GHz - 4.5 GHz / 12MB / 6 nhân, 12 luồng ).
Màn hình 15.6 inch, viền mỏng, độ phân giải FullHD
Giờ đây bạn có thể thoải mái thưởng thức trò chơi nhập vai trên một màn hình có tỷ lệ khung hình lớn hơn đây chính là một lợi thế dành cho các game thủ . Với viền màn hình mỏng, màn hình rộng 15.6 inch có tỷ lệ khung hình lớn hơn các dòng laptop gaming truyền thống khác đem lại một trải nghiệm chơi game choáng ngợp.
Bàn phím LED và cổng kết nối đa dạng
MSI GF63 Thin 11UD 473VN đã tiếp nối truyền thống của thương hiệu MSI bằng một bộ bàn phím được trang bị led đỏ nổi bật trên nền đen. Layout quen thuộc với khoảng cách phím vừa phải. Keycap của bàn phím có gờ nổi phía trên làm tăng độ chính xác khi gõ.',
12, '2022-02-01', 49000.000, 'pc7.jpg'),
(1, N'GVN ProArt Plus 5', N'Intel', 
N'Thiết kế tinh tế và hiện đại
MSI GF63 Thin 11UD-473VN là một chiếc laptop gaming với thiết kế mỏng, nhẹ và vô cùng tinh tế cùng hiệu năng mạnh mẽ. Đây là một lựa chọn tuyệt vời cho nhiều người dùng ngày nay.
Hiệu năng thực sự ấn tượng
MSI đã trang bị cho chiếc laptop này những linh kiện tốt nhất nhằm có thể tối ưu hiệu năng và trải nghiệm cho người dùng. Bạn sẽ được sở hữu bộ vi xử lý thế hệ thứ 11 của Intel Core i5-11400H ( 2.7 GHz - 4.5 GHz / 12MB / 6 nhân, 12 luồng ).
Màn hình 15.6 inch, viền mỏng, độ phân giải FullHD
Giờ đây bạn có thể thoải mái thưởng thức trò chơi nhập vai trên một màn hình có tỷ lệ khung hình lớn hơn đây chính là một lợi thế dành cho các game thủ . Với viền màn hình mỏng, màn hình rộng 15.6 inch có tỷ lệ khung hình lớn hơn các dòng laptop gaming truyền thống khác đem lại một trải nghiệm chơi game choáng ngợp.
Bàn phím LED và cổng kết nối đa dạng
MSI GF63 Thin 11UD 473VN đã tiếp nối truyền thống của thương hiệu MSI bằng một bộ bàn phím được trang bị led đỏ nổi bật trên nền đen. Layout quen thuộc với khoảng cách phím vừa phải. Keycap của bàn phím có gờ nổi phía trên làm tăng độ chính xác khi gõ.',
12, '2022-02-01', 59000.000, 'pc8.jpg'),
(1, N'GVN ProArt Plus 5', N'Intel', 
N'Thiết kế tinh tế và hiện đại
MSI GF63 Thin 11UD-473VN là một chiếc laptop gaming với thiết kế mỏng, nhẹ và vô cùng tinh tế cùng hiệu năng mạnh mẽ. Đây là một lựa chọn tuyệt vời cho nhiều người dùng ngày nay.
Hiệu năng thực sự ấn tượng
MSI đã trang bị cho chiếc laptop này những linh kiện tốt nhất nhằm có thể tối ưu hiệu năng và trải nghiệm cho người dùng. Bạn sẽ được sở hữu bộ vi xử lý thế hệ thứ 11 của Intel Core i5-11400H ( 2.7 GHz - 4.5 GHz / 12MB / 6 nhân, 12 luồng ).
Màn hình 15.6 inch, viền mỏng, độ phân giải FullHD
Giờ đây bạn có thể thoải mái thưởng thức trò chơi nhập vai trên một màn hình có tỷ lệ khung hình lớn hơn đây chính là một lợi thế dành cho các game thủ . Với viền màn hình mỏng, màn hình rộng 15.6 inch có tỷ lệ khung hình lớn hơn các dòng laptop gaming truyền thống khác đem lại một trải nghiệm chơi game choáng ngợp.
Bàn phím LED và cổng kết nối đa dạng
MSI GF63 Thin 11UD 473VN đã tiếp nối truyền thống của thương hiệu MSI bằng một bộ bàn phím được trang bị led đỏ nổi bật trên nền đen. Layout quen thuộc với khoảng cách phím vừa phải. Keycap của bàn phím có gờ nổi phía trên làm tăng độ chính xác khi gõ.',
12, '2022-02-01', 49000.000, 'pc9.jpg'),
(1, N'GVN ProArt Plus 5', N'Intel', 
N'Thiết kế tinh tế và hiện đại
MSI GF63 Thin 11UD-473VN là một chiếc laptop gaming với thiết kế mỏng, nhẹ và vô cùng tinh tế cùng hiệu năng mạnh mẽ. Đây là một lựa chọn tuyệt vời cho nhiều người dùng ngày nay.
Hiệu năng thực sự ấn tượng
MSI đã trang bị cho chiếc laptop này những linh kiện tốt nhất nhằm có thể tối ưu hiệu năng và trải nghiệm cho người dùng. Bạn sẽ được sở hữu bộ vi xử lý thế hệ thứ 11 của Intel Core i5-11400H ( 2.7 GHz - 4.5 GHz / 12MB / 6 nhân, 12 luồng ).
Màn hình 15.6 inch, viền mỏng, độ phân giải FullHD
Giờ đây bạn có thể thoải mái thưởng thức trò chơi nhập vai trên một màn hình có tỷ lệ khung hình lớn hơn đây chính là một lợi thế dành cho các game thủ . Với viền màn hình mỏng, màn hình rộng 15.6 inch có tỷ lệ khung hình lớn hơn các dòng laptop gaming truyền thống khác đem lại một trải nghiệm chơi game choáng ngợp.
Bàn phím LED và cổng kết nối đa dạng
MSI GF63 Thin 11UD 473VN đã tiếp nối truyền thống của thương hiệu MSI bằng một bộ bàn phím được trang bị led đỏ nổi bật trên nền đen. Layout quen thuộc với khoảng cách phím vừa phải. Keycap của bàn phím có gờ nổi phía trên làm tăng độ chính xác khi gõ.',
12, '2022-02-01', 49000.000, 'pc10.jpg'),
(1, N'GVN Power 10', N'Intel', 
N'Thiết kế tinh tế và hiện đại
MSI GF63 Thin 11UD-473VN là một chiếc laptop gaming với thiết kế mỏng, nhẹ và vô cùng tinh tế cùng hiệu năng mạnh mẽ. Đây là một lựa chọn tuyệt vời cho nhiều người dùng ngày nay.
Hiệu năng thực sự ấn tượng
MSI đã trang bị cho chiếc laptop này những linh kiện tốt nhất nhằm có thể tối ưu hiệu năng và trải nghiệm cho người dùng. Bạn sẽ được sở hữu bộ vi xử lý thế hệ thứ 11 của Intel Core i5-11400H ( 2.7 GHz - 4.5 GHz / 12MB / 6 nhân, 12 luồng ).
Màn hình 15.6 inch, viền mỏng, độ phân giải FullHD
Giờ đây bạn có thể thoải mái thưởng thức trò chơi nhập vai trên một màn hình có tỷ lệ khung hình lớn hơn đây chính là một lợi thế dành cho các game thủ . Với viền màn hình mỏng, màn hình rộng 15.6 inch có tỷ lệ khung hình lớn hơn các dòng laptop gaming truyền thống khác đem lại một trải nghiệm chơi game choáng ngợp.
Bàn phím LED và cổng kết nối đa dạng
MSI GF63 Thin 11UD 473VN đã tiếp nối truyền thống của thương hiệu MSI bằng một bộ bàn phím được trang bị led đỏ nổi bật trên nền đen. Layout quen thuộc với khoảng cách phím vừa phải. Keycap của bàn phím có gờ nổi phía trên làm tăng độ chính xác khi gõ.',
12, '2022-02-01', 59000.000, 'pc11.jpg'),
(1, N'GVN Alpha Plus', N'Intel', 
N'Thiết kế tinh tế và hiện đại
MSI GF63 Thin 11UD-473VN là một chiếc laptop gaming với thiết kế mỏng, nhẹ và vô cùng tinh tế cùng hiệu năng mạnh mẽ. Đây là một lựa chọn tuyệt vời cho nhiều người dùng ngày nay.
Hiệu năng thực sự ấn tượng
MSI đã trang bị cho chiếc laptop này những linh kiện tốt nhất nhằm có thể tối ưu hiệu năng và trải nghiệm cho người dùng. Bạn sẽ được sở hữu bộ vi xử lý thế hệ thứ 11 của Intel Core i5-11400H ( 2.7 GHz - 4.5 GHz / 12MB / 6 nhân, 12 luồng ).
Màn hình 15.6 inch, viền mỏng, độ phân giải FullHD
Giờ đây bạn có thể thoải mái thưởng thức trò chơi nhập vai trên một màn hình có tỷ lệ khung hình lớn hơn đây chính là một lợi thế dành cho các game thủ . Với viền màn hình mỏng, màn hình rộng 15.6 inch có tỷ lệ khung hình lớn hơn các dòng laptop gaming truyền thống khác đem lại một trải nghiệm chơi game choáng ngợp.
Bàn phím LED và cổng kết nối đa dạng
MSI GF63 Thin 11UD 473VN đã tiếp nối truyền thống của thương hiệu MSI bằng một bộ bàn phím được trang bị led đỏ nổi bật trên nền đen. Layout quen thuộc với khoảng cách phím vừa phải. Keycap của bàn phím có gờ nổi phía trên làm tăng độ chính xác khi gõ.',
12, '2022-02-01', 39000.000, 'pc12.jpg'),

(2, N'AMD Ryzen 3 3200G', N'AMD', 
N'Chip xử lý dành cho game esports giá rẻ, hiệu năng cao
Thật vậy, trong thời buỗi bão giá card màn hình hiện nay thì AMD với con chip Ryzen 3 3200G này đã đem đến một cơn gió mới mát lành thỏa mãn cơn khát cho game thủ esport với hầu bao hạn chế. Chip tích hợp sẵn card đồ họa Vega 8 mang lại khả năng cân max setting ở độ phân giải fullhd đối với các game esports nhẹ nhàng hiện nay như LOL với hơn 100FPS thật đúng là một món hời.
Hiệu năng tối ưu, chi phí hợp lý
Một lần nữa AMD lại cho thấy triết lý kinh doanh vì người tiêu dùng. Chúng ta có một con chip 4 nhân 4 luồng với xung cơ bản 3.6Ghz khá cao, và có thể turbo lên 4.0Ghz dễ dàng.Xử lý mọi tác vụ văn phòng cơ bản thoải mái. Ngoài ra cũng có thể chỉnh sửa ảnh và video một cách nhẹ nhàng nếu bạn cung cấp một mức ram tốt từ 8gb đến 16gb thì chip đồ họa đi kèm Vega8 đảm bảo bạn hoàn toàn hài lòng.
Khả năng cân game online và offline như LOL,CS:GO,PUBG,GTA V không cần card màn hình
Đúng vậy, nếu bạn cung cấp cho máy một mức dung lượng ram cao từ 8gb đến 16gb thì nó hoàn toàn có thể cân được những game như trên ở mức thiết lập hợp lý.',
12, '2022-02-01', 2690.000, 'cpu7.jpg'),
(2, N'Intel Core i7', N'Intel', 
N'Thông số mạnh mẽ từ i7-9700K
Được tạo với tiền tố, CPU Intel Core i7-9700K được sản xuất theo quy trình 14nm, được tích hợp nhân xử lý đồ họa là Intel UHD 630. Sở hữu 8 nhân 8 luồng cùng xung nhịp 3.6GHz turbo đạt 4.9GHz, i7-9700K cho khả năng xử lý từ các công việc nhẹ như các tác vụ liên quan đến văn phòng đến nặng như xử lý đồ họa trong các tựa game, render clip,
Ép xung với i7-9700K
Mang trong mình tiền tố K, i7-9700K giúp bạn dễ dàng ép xung với hệ số nhân tỷ lệ mở khóa và khả năng tương thích với RAM DDR4 - 2666 dual channel. Hãy chú ý đến điện năng tiêu thụ của i7-9700K, một con số không hề nhỏ đó là 95W.
', 12, '2022-02-01', 2690.000, 'cpu1.jpg'),
(2, N'Intel Core i7', N'Intel', 
N'Thông số mạnh mẽ từ i7-9700K
Được tạo với tiền tố, CPU Intel Core i7-9700K được sản xuất theo quy trình 14nm, được tích hợp nhân xử lý đồ họa là Intel UHD 630. Sở hữu 8 nhân 8 luồng cùng xung nhịp 3.6GHz turbo đạt 4.9GHz, i7-9700K cho khả năng xử lý từ các công việc nhẹ như các tác vụ liên quan đến văn phòng đến nặng như xử lý đồ họa trong các tựa game, render clip,
Ép xung với i7-9700K
Mang trong mình tiền tố K, i7-9700K giúp bạn dễ dàng ép xung với hệ số nhân tỷ lệ mở khóa và khả năng tương thích với RAM DDR4 - 2666 dual channel. Hãy chú ý đến điện năng tiêu thụ của i7-9700K, một con số không hề nhỏ đó là 95W.
',
12, '2022-02-01', 3690.000, 'cpu2.jpg'),
(2, N'Intel Core i7', N'Intel', 
N'Thông số mạnh mẽ từ i7-9700K
Được tạo với tiền tố, CPU Intel Core i7-9700K được sản xuất theo quy trình 14nm, được tích hợp nhân xử lý đồ họa là Intel UHD 630. Sở hữu 8 nhân 8 luồng cùng xung nhịp 3.6GHz turbo đạt 4.9GHz, i7-9700K cho khả năng xử lý từ các công việc nhẹ như các tác vụ liên quan đến văn phòng đến nặng như xử lý đồ họa trong các tựa game, render clip,
Ép xung với i7-9700K
Mang trong mình tiền tố K, i7-9700K giúp bạn dễ dàng ép xung với hệ số nhân tỷ lệ mở khóa và khả năng tương thích với RAM DDR4 - 2666 dual channel. Hãy chú ý đến điện năng tiêu thụ của i7-9700K, một con số không hề nhỏ đó là 95W.
',
12, '2022-02-01', 2790.000, 'cpu3.jpg'),
(2, N'Intel Core i7', N'Intel', 
N'Thông số mạnh mẽ từ i7-9700K
Được tạo với tiền tố, CPU Intel Core i7-9700K được sản xuất theo quy trình 14nm, được tích hợp nhân xử lý đồ họa là Intel UHD 630. Sở hữu 8 nhân 8 luồng cùng xung nhịp 3.6GHz turbo đạt 4.9GHz, i7-9700K cho khả năng xử lý từ các công việc nhẹ như các tác vụ liên quan đến văn phòng đến nặng như xử lý đồ họa trong các tựa game, render clip,
Ép xung với i7-9700K
Mang trong mình tiền tố K, i7-9700K giúp bạn dễ dàng ép xung với hệ số nhân tỷ lệ mở khóa và khả năng tương thích với RAM DDR4 - 2666 dual channel. Hãy chú ý đến điện năng tiêu thụ của i7-9700K, một con số không hề nhỏ đó là 95W.
',
12, '2022-02-01', 1690.000, 'cpu4.jpg'),
(2, N'Intel Core i7', N'Intel', 
N'Thông số mạnh mẽ từ i7-9700K
Được tạo với tiền tố, CPU Intel Core i7-9700K được sản xuất theo quy trình 14nm, được tích hợp nhân xử lý đồ họa là Intel UHD 630. Sở hữu 8 nhân 8 luồng cùng xung nhịp 3.6GHz turbo đạt 4.9GHz, i7-9700K cho khả năng xử lý từ các công việc nhẹ như các tác vụ liên quan đến văn phòng đến nặng như xử lý đồ họa trong các tựa game, render clip,
Ép xung với i7-9700K
Mang trong mình tiền tố K, i7-9700K giúp bạn dễ dàng ép xung với hệ số nhân tỷ lệ mở khóa và khả năng tương thích với RAM DDR4 - 2666 dual channel. Hãy chú ý đến điện năng tiêu thụ của i7-9700K, một con số không hề nhỏ đó là 95W.
',
12, '2022-02-01', 3690.000, 'cpu5.jpg'),
(2, N'Intel Core i7', N'Intel', 
N'Thông số mạnh mẽ từ i7-9700K
Được tạo với tiền tố, CPU Intel Core i7-9700K được sản xuất theo quy trình 14nm, được tích hợp nhân xử lý đồ họa là Intel UHD 630. Sở hữu 8 nhân 8 luồng cùng xung nhịp 3.6GHz turbo đạt 4.9GHz, i7-9700K cho khả năng xử lý từ các công việc nhẹ như các tác vụ liên quan đến văn phòng đến nặng như xử lý đồ họa trong các tựa game, render clip,
Ép xung với i7-9700K
Mang trong mình tiền tố K, i7-9700K giúp bạn dễ dàng ép xung với hệ số nhân tỷ lệ mở khóa và khả năng tương thích với RAM DDR4 - 2666 dual channel. Hãy chú ý đến điện năng tiêu thụ của i7-9700K, một con số không hề nhỏ đó là 95W.
',
12, '2022-02-01', 2690.000, 'cpu6.jpg'),
(2, N'Intel Core i7', N'Intel', 
N'Thông số mạnh mẽ từ i7-9700K
Được tạo với tiền tố, CPU Intel Core i7-9700K được sản xuất theo quy trình 14nm, được tích hợp nhân xử lý đồ họa là Intel UHD 630. Sở hữu 8 nhân 8 luồng cùng xung nhịp 3.6GHz turbo đạt 4.9GHz, i7-9700K cho khả năng xử lý từ các công việc nhẹ như các tác vụ liên quan đến văn phòng đến nặng như xử lý đồ họa trong các tựa game, render clip,
Ép xung với i7-9700K
Mang trong mình tiền tố K, i7-9700K giúp bạn dễ dàng ép xung với hệ số nhân tỷ lệ mở khóa và khả năng tương thích với RAM DDR4 - 2666 dual channel. Hãy chú ý đến điện năng tiêu thụ của i7-9700K, một con số không hề nhỏ đó là 95W.
',
12, '2022-02-01', 1690.000, 'cpu3.jpg'),
(2, N'Intel Core i7', N'Intel', 
N'Thông số mạnh mẽ từ i7-9700K
Được tạo với tiền tố, CPU Intel Core i7-9700K được sản xuất theo quy trình 14nm, được tích hợp nhân xử lý đồ họa là Intel UHD 630. Sở hữu 8 nhân 8 luồng cùng xung nhịp 3.6GHz turbo đạt 4.9GHz, i7-9700K cho khả năng xử lý từ các công việc nhẹ như các tác vụ liên quan đến văn phòng đến nặng như xử lý đồ họa trong các tựa game, render clip,
Ép xung với i7-9700K
Mang trong mình tiền tố K, i7-9700K giúp bạn dễ dàng ép xung với hệ số nhân tỷ lệ mở khóa và khả năng tương thích với RAM DDR4 - 2666 dual channel. Hãy chú ý đến điện năng tiêu thụ của i7-9700K, một con số không hề nhỏ đó là 95W.
',
12, '2022-02-01', 2690.000, 'cpu5.jpg'),
(2, N'Intel Core i7', N'Intel', 
N'Thông số mạnh mẽ từ i7-9700K
Được tạo với tiền tố, CPU Intel Core i7-9700K được sản xuất theo quy trình 14nm, được tích hợp nhân xử lý đồ họa là Intel UHD 630. Sở hữu 8 nhân 8 luồng cùng xung nhịp 3.6GHz turbo đạt 4.9GHz, i7-9700K cho khả năng xử lý từ các công việc nhẹ như các tác vụ liên quan đến văn phòng đến nặng như xử lý đồ họa trong các tựa game, render clip,
Ép xung với i7-9700K
Mang trong mình tiền tố K, i7-9700K giúp bạn dễ dàng ép xung với hệ số nhân tỷ lệ mở khóa và khả năng tương thích với RAM DDR4 - 2666 dual channel. Hãy chú ý đến điện năng tiêu thụ của i7-9700K, một con số không hề nhỏ đó là 95W.
',
12, '2022-02-01', 3690.000, 'cpu4.jpg'),
(2, N'Intel Core i10', N'Intel', 
N'Thông số mạnh mẽ từ i7-9700K
Được tạo với tiền tố, CPU Intel Core i7-9700K được sản xuất theo quy trình 14nm, được tích hợp nhân xử lý đồ họa là Intel UHD 630. Sở hữu 8 nhân 8 luồng cùng xung nhịp 3.6GHz turbo đạt 4.9GHz, i7-9700K cho khả năng xử lý từ các công việc nhẹ như các tác vụ liên quan đến văn phòng đến nặng như xử lý đồ họa trong các tựa game, render clip,
Ép xung với i7-9700K
Mang trong mình tiền tố K, i7-9700K giúp bạn dễ dàng ép xung với hệ số nhân tỷ lệ mở khóa và khả năng tương thích với RAM DDR4 - 2666 dual channel. Hãy chú ý đến điện năng tiêu thụ của i7-9700K, một con số không hề nhỏ đó là 95W.
',
12, '2022-02-01', 5690.000, 'cpu1.jpg'),
(2, N'Intel Core i7', N'Intel', 
N'Thông số mạnh mẽ từ i7-9700K
Được tạo với tiền tố, CPU Intel Core i7-9700K được sản xuất theo quy trình 14nm, được tích hợp nhân xử lý đồ họa là Intel UHD 630. Sở hữu 8 nhân 8 luồng cùng xung nhịp 3.6GHz turbo đạt 4.9GHz, i7-9700K cho khả năng xử lý từ các công việc nhẹ như các tác vụ liên quan đến văn phòng đến nặng như xử lý đồ họa trong các tựa game, render clip,
Ép xung với i7-9700K
Mang trong mình tiền tố K, i7-9700K giúp bạn dễ dàng ép xung với hệ số nhân tỷ lệ mở khóa và khả năng tương thích với RAM DDR4 - 2666 dual channel. Hãy chú ý đến điện năng tiêu thụ của i7-9700K, một con số không hề nhỏ đó là 95W.
',
12, '2022-02-01', 3690.000, 'cpu3.jpg'),


(3, N'ASROCK Radeon', N'ASROCK', 
N'Thiết kế quạt kép
Hai quạt cung cấp hiệu suất làm mát mạnh mẽ và giúp giàn máy chơi game của bạn luôn mát mẻ. Nó được tối ưu hóa để mang lại trải nghiệm chơi game tuyệt vời với thiết kế cá tính, linh hoạt
Backplate Kim loại chắc chắn, đầy cá tính
Được thiết kế để tránh bị uốn cong PCB. Giao diện lạ mắt làm cho card đồ họa trở nên bắt mắt hơn. Nó cũng giúp tăng cường khả năng làm mát với các tấm tản nhiệt cao cấp được trang bị ở mặt sau.
Quạt hướng trục có sọc
Được thiết kế cho luồng không khí tăng cường. Quạt hướng trục có sọc tùy chỉnh của ASRock mang lại luồng không khí tăng cường để tối ưu hóa khả năng làm mát từ không chỉ cấu trúc sọc trên mỗi cánh quạt mà còn cả bề mặt đánh bóng ở mặt dưới.
Vây xé gió
Hướng dẫn luồng không khí đi qua thường xuyên và nhanh chóng. Hướng luồng không khí đi đều đặn và nhanh chóng hơn để nâng cao hiệu quả làm mát bằng cánh tản nhiệt hình chữ V và lỗ thông khí hình chữ V.',
12, '2022-02-01', 13490.000, 'vga1.jpg'),
(3, N'ASROCK Radeon', N'ASROCK', 
N'Thiết kế quạt kép
Hai quạt cung cấp hiệu suất làm mát mạnh mẽ và giúp giàn máy chơi game của bạn luôn mát mẻ. Nó được tối ưu hóa để mang lại trải nghiệm chơi game tuyệt vời với thiết kế cá tính, linh hoạt
Backplate Kim loại chắc chắn, đầy cá tính
Được thiết kế để tránh bị uốn cong PCB. Giao diện lạ mắt làm cho card đồ họa trở nên bắt mắt hơn. Nó cũng giúp tăng cường khả năng làm mát với các tấm tản nhiệt cao cấp được trang bị ở mặt sau.
Quạt hướng trục có sọc
Được thiết kế cho luồng không khí tăng cường. Quạt hướng trục có sọc tùy chỉnh của ASRock mang lại luồng không khí tăng cường để tối ưu hóa khả năng làm mát từ không chỉ cấu trúc sọc trên mỗi cánh quạt mà còn cả bề mặt đánh bóng ở mặt dưới.
Vây xé gió
Hướng dẫn luồng không khí đi qua thường xuyên và nhanh chóng. Hướng luồng không khí đi đều đặn và nhanh chóng hơn để nâng cao hiệu quả làm mát bằng cánh tản nhiệt hình chữ V và lỗ thông khí hình chữ V.',
12, '2022-02-01', 10490.000, 'vga2.jpg'),
(3, N'ASUS Dual GeForce', N'ASROCK', 
N'Thiết kế quạt kép
Hai quạt cung cấp hiệu suất làm mát mạnh mẽ và giúp giàn máy chơi game của bạn luôn mát mẻ. Nó được tối ưu hóa để mang lại trải nghiệm chơi game tuyệt vời với thiết kế cá tính, linh hoạt
Backplate Kim loại chắc chắn, đầy cá tính
Được thiết kế để tránh bị uốn cong PCB. Giao diện lạ mắt làm cho card đồ họa trở nên bắt mắt hơn. Nó cũng giúp tăng cường khả năng làm mát với các tấm tản nhiệt cao cấp được trang bị ở mặt sau.
Quạt hướng trục có sọc
Được thiết kế cho luồng không khí tăng cường. Quạt hướng trục có sọc tùy chỉnh của ASRock mang lại luồng không khí tăng cường để tối ưu hóa khả năng làm mát từ không chỉ cấu trúc sọc trên mỗi cánh quạt mà còn cả bề mặt đánh bóng ở mặt dưới.
Vây xé gió
Hướng dẫn luồng không khí đi qua thường xuyên và nhanh chóng. Hướng luồng không khí đi đều đặn và nhanh chóng hơn để nâng cao hiệu quả làm mát bằng cánh tản nhiệt hình chữ V và lỗ thông khí hình chữ V.',
12, '2022-02-01', 13490.000, 'vga1.jpg'),
(3, N'ASUS Dual GeForce', N'ASUS', 
N'Thiết kế quạt kép
Hai quạt cung cấp hiệu suất làm mát mạnh mẽ và giúp giàn máy chơi game của bạn luôn mát mẻ. Nó được tối ưu hóa để mang lại trải nghiệm chơi game tuyệt vời với thiết kế cá tính, linh hoạt
Backplate Kim loại chắc chắn, đầy cá tính
Được thiết kế để tránh bị uốn cong PCB. Giao diện lạ mắt làm cho card đồ họa trở nên bắt mắt hơn. Nó cũng giúp tăng cường khả năng làm mát với các tấm tản nhiệt cao cấp được trang bị ở mặt sau.
Quạt hướng trục có sọc
Được thiết kế cho luồng không khí tăng cường. Quạt hướng trục có sọc tùy chỉnh của ASRock mang lại luồng không khí tăng cường để tối ưu hóa khả năng làm mát từ không chỉ cấu trúc sọc trên mỗi cánh quạt mà còn cả bề mặt đánh bóng ở mặt dưới.
Vây xé gió
Hướng dẫn luồng không khí đi qua thường xuyên và nhanh chóng. Hướng luồng không khí đi đều đặn và nhanh chóng hơn để nâng cao hiệu quả làm mát bằng cánh tản nhiệt hình chữ V và lỗ thông khí hình chữ V.',
12, '2022-02-01', 13390.000, 'vga2.jpg'),
(3, N'ASUS Dual GeForce', N'ASUS', 
N'Thiết kế quạt kép
Hai quạt cung cấp hiệu suất làm mát mạnh mẽ và giúp giàn máy chơi game của bạn luôn mát mẻ. Nó được tối ưu hóa để mang lại trải nghiệm chơi game tuyệt vời với thiết kế cá tính, linh hoạt
Backplate Kim loại chắc chắn, đầy cá tính
Được thiết kế để tránh bị uốn cong PCB. Giao diện lạ mắt làm cho card đồ họa trở nên bắt mắt hơn. Nó cũng giúp tăng cường khả năng làm mát với các tấm tản nhiệt cao cấp được trang bị ở mặt sau.
Quạt hướng trục có sọc
Được thiết kế cho luồng không khí tăng cường. Quạt hướng trục có sọc tùy chỉnh của ASRock mang lại luồng không khí tăng cường để tối ưu hóa khả năng làm mát từ không chỉ cấu trúc sọc trên mỗi cánh quạt mà còn cả bề mặt đánh bóng ở mặt dưới.
Vây xé gió
Hướng dẫn luồng không khí đi qua thường xuyên và nhanh chóng. Hướng luồng không khí đi đều đặn và nhanh chóng hơn để nâng cao hiệu quả làm mát bằng cánh tản nhiệt hình chữ V và lỗ thông khí hình chữ V.',
12, '2022-02-01', 23390.000, 'vga5.jpg'),
(3, N'ASUS Dual GeForce', N'ASUS', 
N'Thiết kế quạt kép
Hai quạt cung cấp hiệu suất làm mát mạnh mẽ và giúp giàn máy chơi game của bạn luôn mát mẻ. Nó được tối ưu hóa để mang lại trải nghiệm chơi game tuyệt vời với thiết kế cá tính, linh hoạt
Backplate Kim loại chắc chắn, đầy cá tính
Được thiết kế để tránh bị uốn cong PCB. Giao diện lạ mắt làm cho card đồ họa trở nên bắt mắt hơn. Nó cũng giúp tăng cường khả năng làm mát với các tấm tản nhiệt cao cấp được trang bị ở mặt sau.
Quạt hướng trục có sọc
Được thiết kế cho luồng không khí tăng cường. Quạt hướng trục có sọc tùy chỉnh của ASRock mang lại luồng không khí tăng cường để tối ưu hóa khả năng làm mát từ không chỉ cấu trúc sọc trên mỗi cánh quạt mà còn cả bề mặt đánh bóng ở mặt dưới.
Vây xé gió
Hướng dẫn luồng không khí đi qua thường xuyên và nhanh chóng. Hướng luồng không khí đi đều đặn và nhanh chóng hơn để nâng cao hiệu quả làm mát bằng cánh tản nhiệt hình chữ V và lỗ thông khí hình chữ V.',
12, '2022-02-01', 23390.000, 'vga2.jpg'),
(3, N'ASUS Dual GeForce', N'ASUS', 
N'Thiết kế quạt kép
Hai quạt cung cấp hiệu suất làm mát mạnh mẽ và giúp giàn máy chơi game của bạn luôn mát mẻ. Nó được tối ưu hóa để mang lại trải nghiệm chơi game tuyệt vời với thiết kế cá tính, linh hoạt
Backplate Kim loại chắc chắn, đầy cá tính
Được thiết kế để tránh bị uốn cong PCB. Giao diện lạ mắt làm cho card đồ họa trở nên bắt mắt hơn. Nó cũng giúp tăng cường khả năng làm mát với các tấm tản nhiệt cao cấp được trang bị ở mặt sau.
Quạt hướng trục có sọc
Được thiết kế cho luồng không khí tăng cường. Quạt hướng trục có sọc tùy chỉnh của ASRock mang lại luồng không khí tăng cường để tối ưu hóa khả năng làm mát từ không chỉ cấu trúc sọc trên mỗi cánh quạt mà còn cả bề mặt đánh bóng ở mặt dưới.
Vây xé gió
Hướng dẫn luồng không khí đi qua thường xuyên và nhanh chóng. Hướng luồng không khí đi đều đặn và nhanh chóng hơn để nâng cao hiệu quả làm mát bằng cánh tản nhiệt hình chữ V và lỗ thông khí hình chữ V.',
12, '2022-02-01', 13390.000, 'vga2.jpg'),
(3, N'ASUS Dual GeForce', N'ASUS', 
N'Thiết kế quạt kép
Hai quạt cung cấp hiệu suất làm mát mạnh mẽ và giúp giàn máy chơi game của bạn luôn mát mẻ. Nó được tối ưu hóa để mang lại trải nghiệm chơi game tuyệt vời với thiết kế cá tính, linh hoạt
Backplate Kim loại chắc chắn, đầy cá tính
Được thiết kế để tránh bị uốn cong PCB. Giao diện lạ mắt làm cho card đồ họa trở nên bắt mắt hơn. Nó cũng giúp tăng cường khả năng làm mát với các tấm tản nhiệt cao cấp được trang bị ở mặt sau.
Quạt hướng trục có sọc
Được thiết kế cho luồng không khí tăng cường. Quạt hướng trục có sọc tùy chỉnh của ASRock mang lại luồng không khí tăng cường để tối ưu hóa khả năng làm mát từ không chỉ cấu trúc sọc trên mỗi cánh quạt mà còn cả bề mặt đánh bóng ở mặt dưới.
Vây xé gió
Hướng dẫn luồng không khí đi qua thường xuyên và nhanh chóng. Hướng luồng không khí đi đều đặn và nhanh chóng hơn để nâng cao hiệu quả làm mát bằng cánh tản nhiệt hình chữ V và lỗ thông khí hình chữ V.',
12, '2022-02-01', 15390.000, 'vga5.jpg'),
(3, N'ASUS Dual GeForce', N'ASUS', 
N'Thiết kế quạt kép
Hai quạt cung cấp hiệu suất làm mát mạnh mẽ và giúp giàn máy chơi game của bạn luôn mát mẻ. Nó được tối ưu hóa để mang lại trải nghiệm chơi game tuyệt vời với thiết kế cá tính, linh hoạt
Backplate Kim loại chắc chắn, đầy cá tính
Được thiết kế để tránh bị uốn cong PCB. Giao diện lạ mắt làm cho card đồ họa trở nên bắt mắt hơn. Nó cũng giúp tăng cường khả năng làm mát với các tấm tản nhiệt cao cấp được trang bị ở mặt sau.
Quạt hướng trục có sọc
Được thiết kế cho luồng không khí tăng cường. Quạt hướng trục có sọc tùy chỉnh của ASRock mang lại luồng không khí tăng cường để tối ưu hóa khả năng làm mát từ không chỉ cấu trúc sọc trên mỗi cánh quạt mà còn cả bề mặt đánh bóng ở mặt dưới.
Vây xé gió
Hướng dẫn luồng không khí đi qua thường xuyên và nhanh chóng. Hướng luồng không khí đi đều đặn và nhanh chóng hơn để nâng cao hiệu quả làm mát bằng cánh tản nhiệt hình chữ V và lỗ thông khí hình chữ V.',
12, '2022-02-01', 13390.000, 'vga1.jpg'),
(3, N'ASUS Dual GeForce', N'ASUS', 
N'Thiết kế quạt kép
Hai quạt cung cấp hiệu suất làm mát mạnh mẽ và giúp giàn máy chơi game của bạn luôn mát mẻ. Nó được tối ưu hóa để mang lại trải nghiệm chơi game tuyệt vời với thiết kế cá tính, linh hoạt
Backplate Kim loại chắc chắn, đầy cá tính
Được thiết kế để tránh bị uốn cong PCB. Giao diện lạ mắt làm cho card đồ họa trở nên bắt mắt hơn. Nó cũng giúp tăng cường khả năng làm mát với các tấm tản nhiệt cao cấp được trang bị ở mặt sau.
Quạt hướng trục có sọc
Được thiết kế cho luồng không khí tăng cường. Quạt hướng trục có sọc tùy chỉnh của ASRock mang lại luồng không khí tăng cường để tối ưu hóa khả năng làm mát từ không chỉ cấu trúc sọc trên mỗi cánh quạt mà còn cả bề mặt đánh bóng ở mặt dưới.
Vây xé gió
Hướng dẫn luồng không khí đi qua thường xuyên và nhanh chóng. Hướng luồng không khí đi đều đặn và nhanh chóng hơn để nâng cao hiệu quả làm mát bằng cánh tản nhiệt hình chữ V và lỗ thông khí hình chữ V.',
12, '2022-02-01', 21390.000, 'vga2.jpg'),
(3, N'ASUS GeForce', N'ASUS', 
N'Thiết kế quạt kép
Hai quạt cung cấp hiệu suất làm mát mạnh mẽ và giúp giàn máy chơi game của bạn luôn mát mẻ. Nó được tối ưu hóa để mang lại trải nghiệm chơi game tuyệt vời với thiết kế cá tính, linh hoạt
Backplate Kim loại chắc chắn, đầy cá tính
Được thiết kế để tránh bị uốn cong PCB. Giao diện lạ mắt làm cho card đồ họa trở nên bắt mắt hơn. Nó cũng giúp tăng cường khả năng làm mát với các tấm tản nhiệt cao cấp được trang bị ở mặt sau.
Quạt hướng trục có sọc
Được thiết kế cho luồng không khí tăng cường. Quạt hướng trục có sọc tùy chỉnh của ASRock mang lại luồng không khí tăng cường để tối ưu hóa khả năng làm mát từ không chỉ cấu trúc sọc trên mỗi cánh quạt mà còn cả bề mặt đánh bóng ở mặt dưới.
Vây xé gió
Hướng dẫn luồng không khí đi qua thường xuyên và nhanh chóng. Hướng luồng không khí đi đều đặn và nhanh chóng hơn để nâng cao hiệu quả làm mát bằng cánh tản nhiệt hình chữ V và lỗ thông khí hình chữ V.',
12, '2022-02-01', 31390.000, 'vga2.jpg'),
(3, N'ASUS Power GeForce', N'ASUS', 
N'Thiết kế quạt kép
Hai quạt cung cấp hiệu suất làm mát mạnh mẽ và giúp giàn máy chơi game của bạn luôn mát mẻ. Nó được tối ưu hóa để mang lại trải nghiệm chơi game tuyệt vời với thiết kế cá tính, linh hoạt
Backplate Kim loại chắc chắn, đầy cá tính
Được thiết kế để tránh bị uốn cong PCB. Giao diện lạ mắt làm cho card đồ họa trở nên bắt mắt hơn. Nó cũng giúp tăng cường khả năng làm mát với các tấm tản nhiệt cao cấp được trang bị ở mặt sau.
Quạt hướng trục có sọc
Được thiết kế cho luồng không khí tăng cường. Quạt hướng trục có sọc tùy chỉnh của ASRock mang lại luồng không khí tăng cường để tối ưu hóa khả năng làm mát từ không chỉ cấu trúc sọc trên mỗi cánh quạt mà còn cả bề mặt đánh bóng ở mặt dưới.
Vây xé gió
Hướng dẫn luồng không khí đi qua thường xuyên và nhanh chóng. Hướng luồng không khí đi đều đặn và nhanh chóng hơn để nâng cao hiệu quả làm mát bằng cánh tản nhiệt hình chữ V và lỗ thông khí hình chữ V.',
12, '2022-02-01', 21390.000, 'vga2.jpg'),

(4, N'RAM Kingston Fury', N'KINGSTON', 
N'Đánh giá chi tiết RAM Kingston FURY™ Beast DDR4 RGB Special Edition
Là một trong những mẫu RAM được yêu thích nhất thuộc dòng RAM DDR4, Kingston FURY™ Beast DDR4 RGB Special Edition sở hữu vẻ ngoài sang trọng và đậm chất gaming, mẫu RAM này vừa phù hợp cho cả những bộ PC gaming lẫn PC văn phòng, thiết kế đồ họa, …
Tốc độ lên đến 3600 MT/giây
Nổi tiếng với chất lượng vượt trội, Kingston FURY™ Beast DDR4 RGB Special Edition tăng hiệu năng với tốc độ lên đến 3200 MT/giây và 3600 MT/giây. RAM sở hữu độ trễ từ CL16-18 cùng hiệu năng cực cao giúp trải nghiệm chơi game tối ưu. Kingston FURY™ Beast DDR4 RGB Special Edition có khả năng tương tích cao cho bất kỳ hệ thống nào dùng bộ xử lý Intel® hay AMD.
Thiết kế ấn tượng
Có thiết kế với bộ tản nhiệt màu trắng độc đáo kết hợp cùng dải đèn LED RGB ấn tượng, bộ PC gaming của bạn giờ đây trở nên ấn tượng và đẹp mắt hơn rất nhiều. Khả năng điều chỉnh hiệu ứng ánh sáng RGB như ý cũng trở nên dễ dàng hơn nhờ phần mềm Kingston FURY CTRL.
Công nghệ Infrared Sync Technology được cấp bằng sáng chế giúp bạn có thể đồng bộ hóa một cách hoàn hảo những hiệu ứng trên để mang lại sự hài hòa tuyệt đối. RAM Kingston FURY™ Beast DDR4 RGB Special Edition chắc chắn sẽ tạo nét ấn tượng riêng cho bạn và dàn máy của mình.',
12, '2022-02-01', 1090.000, 'ram1.jpg'),
(4, N'Corsair Vengeance', N'CORSAIR', 
N'Đánh giá chi tiết RAM Kingston FURY™ Beast DDR4 RGB Special Edition
Là một trong những mẫu RAM được yêu thích nhất thuộc dòng RAM DDR4, Kingston FURY™ Beast DDR4 RGB Special Edition sở hữu vẻ ngoài sang trọng và đậm chất gaming, mẫu RAM này vừa phù hợp cho cả những bộ PC gaming lẫn PC văn phòng, thiết kế đồ họa, …
Tốc độ lên đến 3600 MT/giây
Nổi tiếng với chất lượng vượt trội, Kingston FURY™ Beast DDR4 RGB Special Edition tăng hiệu năng với tốc độ lên đến 3200 MT/giây và 3600 MT/giây. RAM sở hữu độ trễ từ CL16-18 cùng hiệu năng cực cao giúp trải nghiệm chơi game tối ưu. Kingston FURY™ Beast DDR4 RGB Special Edition có khả năng tương tích cao cho bất kỳ hệ thống nào dùng bộ xử lý Intel® hay AMD.
Thiết kế ấn tượng
Có thiết kế với bộ tản nhiệt màu trắng độc đáo kết hợp cùng dải đèn LED RGB ấn tượng, bộ PC gaming của bạn giờ đây trở nên ấn tượng và đẹp mắt hơn rất nhiều. Khả năng điều chỉnh hiệu ứng ánh sáng RGB như ý cũng trở nên dễ dàng hơn nhờ phần mềm Kingston FURY CTRL.
Công nghệ Infrared Sync Technology được cấp bằng sáng chế giúp bạn có thể đồng bộ hóa một cách hoàn hảo những hiệu ứng trên để mang lại sự hài hòa tuyệt đối. RAM Kingston FURY™ Beast DDR4 RGB Special Edition chắc chắn sẽ tạo nét ấn tượng riêng cho bạn và dàn máy của mình.',
12, '2022-02-01', 1190.000, 'ram2.jpg'),
(4, N'RAM Kingston Fury', N'KINGSTON', 
N'Đánh giá chi tiết RAM Kingston FURY™ Beast DDR4 RGB Special Edition
Là một trong những mẫu RAM được yêu thích nhất thuộc dòng RAM DDR4, Kingston FURY™ Beast DDR4 RGB Special Edition sở hữu vẻ ngoài sang trọng và đậm chất gaming, mẫu RAM này vừa phù hợp cho cả những bộ PC gaming lẫn PC văn phòng, thiết kế đồ họa, …
Tốc độ lên đến 3600 MT/giây
Nổi tiếng với chất lượng vượt trội, Kingston FURY™ Beast DDR4 RGB Special Edition tăng hiệu năng với tốc độ lên đến 3200 MT/giây và 3600 MT/giây. RAM sở hữu độ trễ từ CL16-18 cùng hiệu năng cực cao giúp trải nghiệm chơi game tối ưu. Kingston FURY™ Beast DDR4 RGB Special Edition có khả năng tương tích cao cho bất kỳ hệ thống nào dùng bộ xử lý Intel® hay AMD.
Thiết kế ấn tượng
Có thiết kế với bộ tản nhiệt màu trắng độc đáo kết hợp cùng dải đèn LED RGB ấn tượng, bộ PC gaming của bạn giờ đây trở nên ấn tượng và đẹp mắt hơn rất nhiều. Khả năng điều chỉnh hiệu ứng ánh sáng RGB như ý cũng trở nên dễ dàng hơn nhờ phần mềm Kingston FURY CTRL.
Công nghệ Infrared Sync Technology được cấp bằng sáng chế giúp bạn có thể đồng bộ hóa một cách hoàn hảo những hiệu ứng trên để mang lại sự hài hòa tuyệt đối. RAM Kingston FURY™ Beast DDR4 RGB Special Edition chắc chắn sẽ tạo nét ấn tượng riêng cho bạn và dàn máy của mình.',
12, '2022-02-01', 1090.000, 'ram3.jpg'),
(4, N'RAM Kingston Fury', N'KINGSTON', 
N'Đánh giá chi tiết RAM Kingston FURY™ Beast DDR4 RGB Special Edition
Là một trong những mẫu RAM được yêu thích nhất thuộc dòng RAM DDR4, Kingston FURY™ Beast DDR4 RGB Special Edition sở hữu vẻ ngoài sang trọng và đậm chất gaming, mẫu RAM này vừa phù hợp cho cả những bộ PC gaming lẫn PC văn phòng, thiết kế đồ họa, …
Tốc độ lên đến 3600 MT/giây
Nổi tiếng với chất lượng vượt trội, Kingston FURY™ Beast DDR4 RGB Special Edition tăng hiệu năng với tốc độ lên đến 3200 MT/giây và 3600 MT/giây. RAM sở hữu độ trễ từ CL16-18 cùng hiệu năng cực cao giúp trải nghiệm chơi game tối ưu. Kingston FURY™ Beast DDR4 RGB Special Edition có khả năng tương tích cao cho bất kỳ hệ thống nào dùng bộ xử lý Intel® hay AMD.
Thiết kế ấn tượng
Có thiết kế với bộ tản nhiệt màu trắng độc đáo kết hợp cùng dải đèn LED RGB ấn tượng, bộ PC gaming của bạn giờ đây trở nên ấn tượng và đẹp mắt hơn rất nhiều. Khả năng điều chỉnh hiệu ứng ánh sáng RGB như ý cũng trở nên dễ dàng hơn nhờ phần mềm Kingston FURY CTRL.
Công nghệ Infrared Sync Technology được cấp bằng sáng chế giúp bạn có thể đồng bộ hóa một cách hoàn hảo những hiệu ứng trên để mang lại sự hài hòa tuyệt đối. RAM Kingston FURY™ Beast DDR4 RGB Special Edition chắc chắn sẽ tạo nét ấn tượng riêng cho bạn và dàn máy của mình.',
12, '2022-02-01', 1290.000, 'ram4.jpg'),
(4, N'RAM Kingston Fury', N'KINGSTON', 
N'Đánh giá chi tiết RAM Kingston FURY™ Beast DDR4 RGB Special Edition
Là một trong những mẫu RAM được yêu thích nhất thuộc dòng RAM DDR4, Kingston FURY™ Beast DDR4 RGB Special Edition sở hữu vẻ ngoài sang trọng và đậm chất gaming, mẫu RAM này vừa phù hợp cho cả những bộ PC gaming lẫn PC văn phòng, thiết kế đồ họa, …
Tốc độ lên đến 3600 MT/giây
Nổi tiếng với chất lượng vượt trội, Kingston FURY™ Beast DDR4 RGB Special Edition tăng hiệu năng với tốc độ lên đến 3200 MT/giây và 3600 MT/giây. RAM sở hữu độ trễ từ CL16-18 cùng hiệu năng cực cao giúp trải nghiệm chơi game tối ưu. Kingston FURY™ Beast DDR4 RGB Special Edition có khả năng tương tích cao cho bất kỳ hệ thống nào dùng bộ xử lý Intel® hay AMD.
Thiết kế ấn tượng
Có thiết kế với bộ tản nhiệt màu trắng độc đáo kết hợp cùng dải đèn LED RGB ấn tượng, bộ PC gaming của bạn giờ đây trở nên ấn tượng và đẹp mắt hơn rất nhiều. Khả năng điều chỉnh hiệu ứng ánh sáng RGB như ý cũng trở nên dễ dàng hơn nhờ phần mềm Kingston FURY CTRL.
Công nghệ Infrared Sync Technology được cấp bằng sáng chế giúp bạn có thể đồng bộ hóa một cách hoàn hảo những hiệu ứng trên để mang lại sự hài hòa tuyệt đối. RAM Kingston FURY™ Beast DDR4 RGB Special Edition chắc chắn sẽ tạo nét ấn tượng riêng cho bạn và dàn máy của mình.',
12, '2022-02-01', 1110.000, 'ram5.jpg'),
(4, N'RAM Kingston Fury', N'KINGSTON', 
N'Đánh giá chi tiết RAM Kingston FURY™ Beast DDR4 RGB Special Edition
Là một trong những mẫu RAM được yêu thích nhất thuộc dòng RAM DDR4, Kingston FURY™ Beast DDR4 RGB Special Edition sở hữu vẻ ngoài sang trọng và đậm chất gaming, mẫu RAM này vừa phù hợp cho cả những bộ PC gaming lẫn PC văn phòng, thiết kế đồ họa, …
Tốc độ lên đến 3600 MT/giây
Nổi tiếng với chất lượng vượt trội, Kingston FURY™ Beast DDR4 RGB Special Edition tăng hiệu năng với tốc độ lên đến 3200 MT/giây và 3600 MT/giây. RAM sở hữu độ trễ từ CL16-18 cùng hiệu năng cực cao giúp trải nghiệm chơi game tối ưu. Kingston FURY™ Beast DDR4 RGB Special Edition có khả năng tương tích cao cho bất kỳ hệ thống nào dùng bộ xử lý Intel® hay AMD.
Thiết kế ấn tượng
Có thiết kế với bộ tản nhiệt màu trắng độc đáo kết hợp cùng dải đèn LED RGB ấn tượng, bộ PC gaming của bạn giờ đây trở nên ấn tượng và đẹp mắt hơn rất nhiều. Khả năng điều chỉnh hiệu ứng ánh sáng RGB như ý cũng trở nên dễ dàng hơn nhờ phần mềm Kingston FURY CTRL.
Công nghệ Infrared Sync Technology được cấp bằng sáng chế giúp bạn có thể đồng bộ hóa một cách hoàn hảo những hiệu ứng trên để mang lại sự hài hòa tuyệt đối. RAM Kingston FURY™ Beast DDR4 RGB Special Edition chắc chắn sẽ tạo nét ấn tượng riêng cho bạn và dàn máy của mình.',
12, '2022-02-01', 1090.000, 'ram1.jpg'),
(4, N'RAM Kingston Fury', N'KINGSTON', 
N'Đánh giá chi tiết RAM Kingston FURY™ Beast DDR4 RGB Special Edition
Là một trong những mẫu RAM được yêu thích nhất thuộc dòng RAM DDR4, Kingston FURY™ Beast DDR4 RGB Special Edition sở hữu vẻ ngoài sang trọng và đậm chất gaming, mẫu RAM này vừa phù hợp cho cả những bộ PC gaming lẫn PC văn phòng, thiết kế đồ họa, …
Tốc độ lên đến 3600 MT/giây
Nổi tiếng với chất lượng vượt trội, Kingston FURY™ Beast DDR4 RGB Special Edition tăng hiệu năng với tốc độ lên đến 3200 MT/giây và 3600 MT/giây. RAM sở hữu độ trễ từ CL16-18 cùng hiệu năng cực cao giúp trải nghiệm chơi game tối ưu. Kingston FURY™ Beast DDR4 RGB Special Edition có khả năng tương tích cao cho bất kỳ hệ thống nào dùng bộ xử lý Intel® hay AMD.
Thiết kế ấn tượng
Có thiết kế với bộ tản nhiệt màu trắng độc đáo kết hợp cùng dải đèn LED RGB ấn tượng, bộ PC gaming của bạn giờ đây trở nên ấn tượng và đẹp mắt hơn rất nhiều. Khả năng điều chỉnh hiệu ứng ánh sáng RGB như ý cũng trở nên dễ dàng hơn nhờ phần mềm Kingston FURY CTRL.
Công nghệ Infrared Sync Technology được cấp bằng sáng chế giúp bạn có thể đồng bộ hóa một cách hoàn hảo những hiệu ứng trên để mang lại sự hài hòa tuyệt đối. RAM Kingston FURY™ Beast DDR4 RGB Special Edition chắc chắn sẽ tạo nét ấn tượng riêng cho bạn và dàn máy của mình.',
12, '2022-02-01', 2090.000, 'ram2.jpg'),
(4, N'RAM Kingston Fury', N'KINGSTON', 
N'Đánh giá chi tiết RAM Kingston FURY™ Beast DDR4 RGB Special Edition
Là một trong những mẫu RAM được yêu thích nhất thuộc dòng RAM DDR4, Kingston FURY™ Beast DDR4 RGB Special Edition sở hữu vẻ ngoài sang trọng và đậm chất gaming, mẫu RAM này vừa phù hợp cho cả những bộ PC gaming lẫn PC văn phòng, thiết kế đồ họa, …
Tốc độ lên đến 3600 MT/giây
Nổi tiếng với chất lượng vượt trội, Kingston FURY™ Beast DDR4 RGB Special Edition tăng hiệu năng với tốc độ lên đến 3200 MT/giây và 3600 MT/giây. RAM sở hữu độ trễ từ CL16-18 cùng hiệu năng cực cao giúp trải nghiệm chơi game tối ưu. Kingston FURY™ Beast DDR4 RGB Special Edition có khả năng tương tích cao cho bất kỳ hệ thống nào dùng bộ xử lý Intel® hay AMD.
Thiết kế ấn tượng
Có thiết kế với bộ tản nhiệt màu trắng độc đáo kết hợp cùng dải đèn LED RGB ấn tượng, bộ PC gaming của bạn giờ đây trở nên ấn tượng và đẹp mắt hơn rất nhiều. Khả năng điều chỉnh hiệu ứng ánh sáng RGB như ý cũng trở nên dễ dàng hơn nhờ phần mềm Kingston FURY CTRL.
Công nghệ Infrared Sync Technology được cấp bằng sáng chế giúp bạn có thể đồng bộ hóa một cách hoàn hảo những hiệu ứng trên để mang lại sự hài hòa tuyệt đối. RAM Kingston FURY™ Beast DDR4 RGB Special Edition chắc chắn sẽ tạo nét ấn tượng riêng cho bạn và dàn máy của mình.',
12, '2022-02-01', 1090.000, 'ram3.jpg'),
(4, N'RAM Kingston Fury', N'KINGSTON', 
N'Đánh giá chi tiết RAM Kingston FURY™ Beast DDR4 RGB Special Edition
Là một trong những mẫu RAM được yêu thích nhất thuộc dòng RAM DDR4, Kingston FURY™ Beast DDR4 RGB Special Edition sở hữu vẻ ngoài sang trọng và đậm chất gaming, mẫu RAM này vừa phù hợp cho cả những bộ PC gaming lẫn PC văn phòng, thiết kế đồ họa, …
Tốc độ lên đến 3600 MT/giây
Nổi tiếng với chất lượng vượt trội, Kingston FURY™ Beast DDR4 RGB Special Edition tăng hiệu năng với tốc độ lên đến 3200 MT/giây và 3600 MT/giây. RAM sở hữu độ trễ từ CL16-18 cùng hiệu năng cực cao giúp trải nghiệm chơi game tối ưu. Kingston FURY™ Beast DDR4 RGB Special Edition có khả năng tương tích cao cho bất kỳ hệ thống nào dùng bộ xử lý Intel® hay AMD.
Thiết kế ấn tượng
Có thiết kế với bộ tản nhiệt màu trắng độc đáo kết hợp cùng dải đèn LED RGB ấn tượng, bộ PC gaming của bạn giờ đây trở nên ấn tượng và đẹp mắt hơn rất nhiều. Khả năng điều chỉnh hiệu ứng ánh sáng RGB như ý cũng trở nên dễ dàng hơn nhờ phần mềm Kingston FURY CTRL.
Công nghệ Infrared Sync Technology được cấp bằng sáng chế giúp bạn có thể đồng bộ hóa một cách hoàn hảo những hiệu ứng trên để mang lại sự hài hòa tuyệt đối. RAM Kingston FURY™ Beast DDR4 RGB Special Edition chắc chắn sẽ tạo nét ấn tượng riêng cho bạn và dàn máy của mình.',
12, '2022-02-01', 1490.000, 'ram4.jpg'),
(4, N'RAM Kingston Fury', N'KINGSTON', 
N'Đánh giá chi tiết RAM Kingston FURY™ Beast DDR4 RGB Special Edition
Là một trong những mẫu RAM được yêu thích nhất thuộc dòng RAM DDR4, Kingston FURY™ Beast DDR4 RGB Special Edition sở hữu vẻ ngoài sang trọng và đậm chất gaming, mẫu RAM này vừa phù hợp cho cả những bộ PC gaming lẫn PC văn phòng, thiết kế đồ họa, …
Tốc độ lên đến 3600 MT/giây
Nổi tiếng với chất lượng vượt trội, Kingston FURY™ Beast DDR4 RGB Special Edition tăng hiệu năng với tốc độ lên đến 3200 MT/giây và 3600 MT/giây. RAM sở hữu độ trễ từ CL16-18 cùng hiệu năng cực cao giúp trải nghiệm chơi game tối ưu. Kingston FURY™ Beast DDR4 RGB Special Edition có khả năng tương tích cao cho bất kỳ hệ thống nào dùng bộ xử lý Intel® hay AMD.
Thiết kế ấn tượng
Có thiết kế với bộ tản nhiệt màu trắng độc đáo kết hợp cùng dải đèn LED RGB ấn tượng, bộ PC gaming của bạn giờ đây trở nên ấn tượng và đẹp mắt hơn rất nhiều. Khả năng điều chỉnh hiệu ứng ánh sáng RGB như ý cũng trở nên dễ dàng hơn nhờ phần mềm Kingston FURY CTRL.
Công nghệ Infrared Sync Technology được cấp bằng sáng chế giúp bạn có thể đồng bộ hóa một cách hoàn hảo những hiệu ứng trên để mang lại sự hài hòa tuyệt đối. RAM Kingston FURY™ Beast DDR4 RGB Special Edition chắc chắn sẽ tạo nét ấn tượng riêng cho bạn và dàn máy của mình.',
12, '2022-02-01', 1090.000, 'ram5.jpg'),
(4, N'RAM Kingston', N'KINGSTON', 
N'Đánh giá chi tiết RAM Kingston FURY™ Beast DDR4 RGB Special Edition
Là một trong những mẫu RAM được yêu thích nhất thuộc dòng RAM DDR4, Kingston FURY™ Beast DDR4 RGB Special Edition sở hữu vẻ ngoài sang trọng và đậm chất gaming, mẫu RAM này vừa phù hợp cho cả những bộ PC gaming lẫn PC văn phòng, thiết kế đồ họa, …
Tốc độ lên đến 3600 MT/giây
Nổi tiếng với chất lượng vượt trội, Kingston FURY™ Beast DDR4 RGB Special Edition tăng hiệu năng với tốc độ lên đến 3200 MT/giây và 3600 MT/giây. RAM sở hữu độ trễ từ CL16-18 cùng hiệu năng cực cao giúp trải nghiệm chơi game tối ưu. Kingston FURY™ Beast DDR4 RGB Special Edition có khả năng tương tích cao cho bất kỳ hệ thống nào dùng bộ xử lý Intel® hay AMD.
Thiết kế ấn tượng
Có thiết kế với bộ tản nhiệt màu trắng độc đáo kết hợp cùng dải đèn LED RGB ấn tượng, bộ PC gaming của bạn giờ đây trở nên ấn tượng và đẹp mắt hơn rất nhiều. Khả năng điều chỉnh hiệu ứng ánh sáng RGB như ý cũng trở nên dễ dàng hơn nhờ phần mềm Kingston FURY CTRL.
Công nghệ Infrared Sync Technology được cấp bằng sáng chế giúp bạn có thể đồng bộ hóa một cách hoàn hảo những hiệu ứng trên để mang lại sự hài hòa tuyệt đối. RAM Kingston FURY™ Beast DDR4 RGB Special Edition chắc chắn sẽ tạo nét ấn tượng riêng cho bạn và dàn máy của mình.',
12, '2022-02-01', 1190.000, 'ram5.jpg'),
(4, N'RAM Kingston Fury II', N'KINGSTON', 
N'Đánh giá chi tiết RAM Kingston FURY™ Beast DDR4 RGB Special Edition
Là một trong những mẫu RAM được yêu thích nhất thuộc dòng RAM DDR4, Kingston FURY™ Beast DDR4 RGB Special Edition sở hữu vẻ ngoài sang trọng và đậm chất gaming, mẫu RAM này vừa phù hợp cho cả những bộ PC gaming lẫn PC văn phòng, thiết kế đồ họa, …
Tốc độ lên đến 3600 MT/giây
Nổi tiếng với chất lượng vượt trội, Kingston FURY™ Beast DDR4 RGB Special Edition tăng hiệu năng với tốc độ lên đến 3200 MT/giây và 3600 MT/giây. RAM sở hữu độ trễ từ CL16-18 cùng hiệu năng cực cao giúp trải nghiệm chơi game tối ưu. Kingston FURY™ Beast DDR4 RGB Special Edition có khả năng tương tích cao cho bất kỳ hệ thống nào dùng bộ xử lý Intel® hay AMD.
Thiết kế ấn tượng
Có thiết kế với bộ tản nhiệt màu trắng độc đáo kết hợp cùng dải đèn LED RGB ấn tượng, bộ PC gaming của bạn giờ đây trở nên ấn tượng và đẹp mắt hơn rất nhiều. Khả năng điều chỉnh hiệu ứng ánh sáng RGB như ý cũng trở nên dễ dàng hơn nhờ phần mềm Kingston FURY CTRL.
Công nghệ Infrared Sync Technology được cấp bằng sáng chế giúp bạn có thể đồng bộ hóa một cách hoàn hảo những hiệu ứng trên để mang lại sự hài hòa tuyệt đối. RAM Kingston FURY™ Beast DDR4 RGB Special Edition chắc chắn sẽ tạo nét ấn tượng riêng cho bạn và dàn máy của mình.',
12, '2022-02-01', 2010.000, 'ram4.jpg'),

(5, N'ASUS CROSSHAIR', N'ASUS', 
N'HERO Crosshair VIII
Với sự hỗ trợ cho CPU AMD Ryzen ™ thế hệ thứ 3 , trên bo mạch, Realtek ® 2.5 Gbps LAN và PCIe 4.0, cùng với thiết kế kim loại được đại tu và được trang bị các tính năng ROG nổi tiếng, đó là nền tảng hoàn hảo cho giàn AMD Ryzen của bạn.  
BOOSTED PERFORMANCE, NO BOTTLENECKS​
ROG Crosshair VIII Hero được trang bị bố trí thiết kế năng lượng tối ưu và tất cả các tiêu đề làm mát bạn cần để xử lý sức mạnh phi thường của bộ xử lý AMD Ryzen mới nhất mà không cần điều chỉnh nhiệt hiệu suất. 
UNCOMPLICATED SYSTEM TUNING​
ROG cung cấp cho bạn các công cụ mạnh mẽ giúp tối ưu hóa hệ thống của bạn nhanh chóng và dễ dàng. Đối với những người thích kiểm soát chi tiết, BIOS UEFI có vô số tùy chọn nâng cao được sắp xếp thành các danh mục trực quan cung cấp khả năng điều chỉnh mọi khía cạnh của hệ thống của bạn. ',
12, '2022-02-01', 9990.000, 'bmc1.jpg'),
(5, N'MSI MEG X670E', N'ASUS', 
N'HERO Crosshair VIII
Với sự hỗ trợ cho CPU AMD Ryzen ™ thế hệ thứ 3 , trên bo mạch, Realtek ® 2.5 Gbps LAN và PCIe 4.0, cùng với thiết kế kim loại được đại tu và được trang bị các tính năng ROG nổi tiếng, đó là nền tảng hoàn hảo cho giàn AMD Ryzen của bạn.  
BOOSTED PERFORMANCE, NO BOTTLENECKS​
ROG Crosshair VIII Hero được trang bị bố trí thiết kế năng lượng tối ưu và tất cả các tiêu đề làm mát bạn cần để xử lý sức mạnh phi thường của bộ xử lý AMD Ryzen mới nhất mà không cần điều chỉnh nhiệt hiệu suất. 
UNCOMPLICATED SYSTEM TUNING​
ROG cung cấp cho bạn các công cụ mạnh mẽ giúp tối ưu hóa hệ thống của bạn nhanh chóng và dễ dàng. Đối với những người thích kiểm soát chi tiết, BIOS UEFI có vô số tùy chọn nâng cao được sắp xếp thành các danh mục trực quan cung cấp khả năng điều chỉnh mọi khía cạnh của hệ thống của bạn. ',
12, '2022-02-01', 19990.000, 'bmc2.jpg'),
(5, N'MSI MEG X670E', N'ASUS', 
N'HERO Crosshair VIII
Với sự hỗ trợ cho CPU AMD Ryzen ™ thế hệ thứ 3 , trên bo mạch, Realtek ® 2.5 Gbps LAN và PCIe 4.0, cùng với thiết kế kim loại được đại tu và được trang bị các tính năng ROG nổi tiếng, đó là nền tảng hoàn hảo cho giàn AMD Ryzen của bạn.  
BOOSTED PERFORMANCE, NO BOTTLENECKS​
ROG Crosshair VIII Hero được trang bị bố trí thiết kế năng lượng tối ưu và tất cả các tiêu đề làm mát bạn cần để xử lý sức mạnh phi thường của bộ xử lý AMD Ryzen mới nhất mà không cần điều chỉnh nhiệt hiệu suất. 
UNCOMPLICATED SYSTEM TUNING​
ROG cung cấp cho bạn các công cụ mạnh mẽ giúp tối ưu hóa hệ thống của bạn nhanh chóng và dễ dàng. Đối với những người thích kiểm soát chi tiết, BIOS UEFI có vô số tùy chọn nâng cao được sắp xếp thành các danh mục trực quan cung cấp khả năng điều chỉnh mọi khía cạnh của hệ thống của bạn. ',
12, '2022-02-01', 15990.000, 'bmc3.jpg'),
(5, N'MSI MEG X670E', N'ASUS', 
N'HERO Crosshair VIII
Với sự hỗ trợ cho CPU AMD Ryzen ™ thế hệ thứ 3 , trên bo mạch, Realtek ® 2.5 Gbps LAN và PCIe 4.0, cùng với thiết kế kim loại được đại tu và được trang bị các tính năng ROG nổi tiếng, đó là nền tảng hoàn hảo cho giàn AMD Ryzen của bạn.  
BOOSTED PERFORMANCE, NO BOTTLENECKS​
ROG Crosshair VIII Hero được trang bị bố trí thiết kế năng lượng tối ưu và tất cả các tiêu đề làm mát bạn cần để xử lý sức mạnh phi thường của bộ xử lý AMD Ryzen mới nhất mà không cần điều chỉnh nhiệt hiệu suất. 
UNCOMPLICATED SYSTEM TUNING​
ROG cung cấp cho bạn các công cụ mạnh mẽ giúp tối ưu hóa hệ thống của bạn nhanh chóng và dễ dàng. Đối với những người thích kiểm soát chi tiết, BIOS UEFI có vô số tùy chọn nâng cao được sắp xếp thành các danh mục trực quan cung cấp khả năng điều chỉnh mọi khía cạnh của hệ thống của bạn. ',
12, '2022-02-01', 19990.000, 'bmc2.jpg'),
(5, N'MSI MEG X670E', N'ASUS', 
N'HERO Crosshair VIII
Với sự hỗ trợ cho CPU AMD Ryzen ™ thế hệ thứ 3 , trên bo mạch, Realtek ® 2.5 Gbps LAN và PCIe 4.0, cùng với thiết kế kim loại được đại tu và được trang bị các tính năng ROG nổi tiếng, đó là nền tảng hoàn hảo cho giàn AMD Ryzen của bạn.  
BOOSTED PERFORMANCE, NO BOTTLENECKS​
ROG Crosshair VIII Hero được trang bị bố trí thiết kế năng lượng tối ưu và tất cả các tiêu đề làm mát bạn cần để xử lý sức mạnh phi thường của bộ xử lý AMD Ryzen mới nhất mà không cần điều chỉnh nhiệt hiệu suất. 
UNCOMPLICATED SYSTEM TUNING​
ROG cung cấp cho bạn các công cụ mạnh mẽ giúp tối ưu hóa hệ thống của bạn nhanh chóng và dễ dàng. Đối với những người thích kiểm soát chi tiết, BIOS UEFI có vô số tùy chọn nâng cao được sắp xếp thành các danh mục trực quan cung cấp khả năng điều chỉnh mọi khía cạnh của hệ thống của bạn. ',
12, '2022-02-01', 19990.000, 'bmc1.jpg'),
(5, N'MSI MEG X670E', N'ASUS', 
N'HERO Crosshair VIII
Với sự hỗ trợ cho CPU AMD Ryzen ™ thế hệ thứ 3 , trên bo mạch, Realtek ® 2.5 Gbps LAN và PCIe 4.0, cùng với thiết kế kim loại được đại tu và được trang bị các tính năng ROG nổi tiếng, đó là nền tảng hoàn hảo cho giàn AMD Ryzen của bạn.  
BOOSTED PERFORMANCE, NO BOTTLENECKS​
ROG Crosshair VIII Hero được trang bị bố trí thiết kế năng lượng tối ưu và tất cả các tiêu đề làm mát bạn cần để xử lý sức mạnh phi thường của bộ xử lý AMD Ryzen mới nhất mà không cần điều chỉnh nhiệt hiệu suất. 
UNCOMPLICATED SYSTEM TUNING​
ROG cung cấp cho bạn các công cụ mạnh mẽ giúp tối ưu hóa hệ thống của bạn nhanh chóng và dễ dàng. Đối với những người thích kiểm soát chi tiết, BIOS UEFI có vô số tùy chọn nâng cao được sắp xếp thành các danh mục trực quan cung cấp khả năng điều chỉnh mọi khía cạnh của hệ thống của bạn. ',
12, '2022-02-01', 29990.000, 'bmc3.jpg'),
(5, N'MSI MEG X670E', N'ASUS', 
N'HERO Crosshair VIII
Với sự hỗ trợ cho CPU AMD Ryzen ™ thế hệ thứ 3 , trên bo mạch, Realtek ® 2.5 Gbps LAN và PCIe 4.0, cùng với thiết kế kim loại được đại tu và được trang bị các tính năng ROG nổi tiếng, đó là nền tảng hoàn hảo cho giàn AMD Ryzen của bạn.  
BOOSTED PERFORMANCE, NO BOTTLENECKS​
ROG Crosshair VIII Hero được trang bị bố trí thiết kế năng lượng tối ưu và tất cả các tiêu đề làm mát bạn cần để xử lý sức mạnh phi thường của bộ xử lý AMD Ryzen mới nhất mà không cần điều chỉnh nhiệt hiệu suất. 
UNCOMPLICATED SYSTEM TUNING​
ROG cung cấp cho bạn các công cụ mạnh mẽ giúp tối ưu hóa hệ thống của bạn nhanh chóng và dễ dàng. Đối với những người thích kiểm soát chi tiết, BIOS UEFI có vô số tùy chọn nâng cao được sắp xếp thành các danh mục trực quan cung cấp khả năng điều chỉnh mọi khía cạnh của hệ thống của bạn. ',
12, '2022-02-01', 19990.000, 'bmc1.jpg'),
(5, N'MSI MEG X670E', N'ASUS', 
N'HERO Crosshair VIII
Với sự hỗ trợ cho CPU AMD Ryzen ™ thế hệ thứ 3 , trên bo mạch, Realtek ® 2.5 Gbps LAN và PCIe 4.0, cùng với thiết kế kim loại được đại tu và được trang bị các tính năng ROG nổi tiếng, đó là nền tảng hoàn hảo cho giàn AMD Ryzen của bạn.  
BOOSTED PERFORMANCE, NO BOTTLENECKS​
ROG Crosshair VIII Hero được trang bị bố trí thiết kế năng lượng tối ưu và tất cả các tiêu đề làm mát bạn cần để xử lý sức mạnh phi thường của bộ xử lý AMD Ryzen mới nhất mà không cần điều chỉnh nhiệt hiệu suất. 
UNCOMPLICATED SYSTEM TUNING​
ROG cung cấp cho bạn các công cụ mạnh mẽ giúp tối ưu hóa hệ thống của bạn nhanh chóng và dễ dàng. Đối với những người thích kiểm soát chi tiết, BIOS UEFI có vô số tùy chọn nâng cao được sắp xếp thành các danh mục trực quan cung cấp khả năng điều chỉnh mọi khía cạnh của hệ thống của bạn. ',
12, '2022-02-01', 10090.000, 'bmc2.jpg'),
(5, N'MSI MEG X670E', N'ASUS', 
N'HERO Crosshair VIII
Với sự hỗ trợ cho CPU AMD Ryzen ™ thế hệ thứ 3 , trên bo mạch, Realtek ® 2.5 Gbps LAN và PCIe 4.0, cùng với thiết kế kim loại được đại tu và được trang bị các tính năng ROG nổi tiếng, đó là nền tảng hoàn hảo cho giàn AMD Ryzen của bạn.  
BOOSTED PERFORMANCE, NO BOTTLENECKS​
ROG Crosshair VIII Hero được trang bị bố trí thiết kế năng lượng tối ưu và tất cả các tiêu đề làm mát bạn cần để xử lý sức mạnh phi thường của bộ xử lý AMD Ryzen mới nhất mà không cần điều chỉnh nhiệt hiệu suất. 
UNCOMPLICATED SYSTEM TUNING​
ROG cung cấp cho bạn các công cụ mạnh mẽ giúp tối ưu hóa hệ thống của bạn nhanh chóng và dễ dàng. Đối với những người thích kiểm soát chi tiết, BIOS UEFI có vô số tùy chọn nâng cao được sắp xếp thành các danh mục trực quan cung cấp khả năng điều chỉnh mọi khía cạnh của hệ thống của bạn. ',
12, '2022-02-01', 20990.000, 'bmc1.jpg'),
(5, N'MSI MEG X670E', N'ASUS', 
N'HERO Crosshair VIII
Với sự hỗ trợ cho CPU AMD Ryzen ™ thế hệ thứ 3 , trên bo mạch, Realtek ® 2.5 Gbps LAN và PCIe 4.0, cùng với thiết kế kim loại được đại tu và được trang bị các tính năng ROG nổi tiếng, đó là nền tảng hoàn hảo cho giàn AMD Ryzen của bạn.  
BOOSTED PERFORMANCE, NO BOTTLENECKS​
ROG Crosshair VIII Hero được trang bị bố trí thiết kế năng lượng tối ưu và tất cả các tiêu đề làm mát bạn cần để xử lý sức mạnh phi thường của bộ xử lý AMD Ryzen mới nhất mà không cần điều chỉnh nhiệt hiệu suất. 
UNCOMPLICATED SYSTEM TUNING​
ROG cung cấp cho bạn các công cụ mạnh mẽ giúp tối ưu hóa hệ thống của bạn nhanh chóng và dễ dàng. Đối với những người thích kiểm soát chi tiết, BIOS UEFI có vô số tùy chọn nâng cao được sắp xếp thành các danh mục trực quan cung cấp khả năng điều chỉnh mọi khía cạnh của hệ thống của bạn. ',
12, '2022-02-01', 19090.000, 'bmc3.jpg'),
(5, N'MSI MEG X770E', N'ASUS', 
N'HERO Crosshair VII
Với sự hỗ trợ cho CPU AMD Ryzen ™ thế hệ thứ 3 , trên bo mạch, Realtek ® 2.5 Gbps LAN và PCIe 4.0, cùng với thiết kế kim loại được đại tu và được trang bị các tính năng ROG nổi tiếng, đó là nền tảng hoàn hảo cho giàn AMD Ryzen của bạn.  
BOOSTED PERFORMANCE, NO BOTTLENECKS​
ROG Crosshair VIII Hero được trang bị bố trí thiết kế năng lượng tối ưu và tất cả các tiêu đề làm mát bạn cần để xử lý sức mạnh phi thường của bộ xử lý AMD Ryzen mới nhất mà không cần điều chỉnh nhiệt hiệu suất. 
UNCOMPLICATED SYSTEM TUNING​
ROG cung cấp cho bạn các công cụ mạnh mẽ giúp tối ưu hóa hệ thống của bạn nhanh chóng và dễ dàng. Đối với những người thích kiểm soát chi tiết, BIOS UEFI có vô số tùy chọn nâng cao được sắp xếp thành các danh mục trực quan cung cấp khả năng điều chỉnh mọi khía cạnh của hệ thống của bạn. ',
12, '2022-02-01', 21090.000, 'bmc3.jpg'),
(5, N'MSI Mega X670E', N'ASUS', 
N'HERO Crosshair XX
Với sự hỗ trợ cho CPU AMD Ryzen ™ thế hệ thứ 3 , trên bo mạch, Realtek ® 2.5 Gbps LAN và PCIe 4.0, cùng với thiết kế kim loại được đại tu và được trang bị các tính năng ROG nổi tiếng, đó là nền tảng hoàn hảo cho giàn AMD Ryzen của bạn.  
BOOSTED PERFORMANCE, NO BOTTLENECKS​
ROG Crosshair VIII Hero được trang bị bố trí thiết kế năng lượng tối ưu và tất cả các tiêu đề làm mát bạn cần để xử lý sức mạnh phi thường của bộ xử lý AMD Ryzen mới nhất mà không cần điều chỉnh nhiệt hiệu suất. 
UNCOMPLICATED SYSTEM TUNING​
ROG cung cấp cho bạn các công cụ mạnh mẽ giúp tối ưu hóa hệ thống của bạn nhanh chóng và dễ dàng. Đối với những người thích kiểm soát chi tiết, BIOS UEFI có vô số tùy chọn nâng cao được sắp xếp thành các danh mục trực quan cung cấp khả năng điều chỉnh mọi khía cạnh của hệ thống của bạn. ',
12, '2022-02-01', 16010.000, 'bmc1.jpg')

GO
INSERT INTO CTHOADON(MALK, MAHD, SOLUONG, THANHTIEN)
VALUES(1, 1, 2, 2900.000),
	(2, 2, 1, 1900.000),
	(3, 3, 3, 4600.000),
	(4, 4, 5, 6000.000)
GO
INSERT INTO LOAITINTUC(TENLOAITIN)
VALUES(N'Công Nghệ'),
	(N'Game'),
	(N'Khuyến Mãi')
GO
INSERT INTO TINTUC(TENTIEUDE, NOIDUNG, NGAYDANG, HINHANH, MALOAITIN)
VALUES(N'Nvidia cà khịa AMD tung driver beta rất nhiều mà driver chính thức thì chẳng được bao nhiêu',
N'Có vẻ Nvidia thấy rằng việc họ tung càng nhiều driver chính thức, hỗ trợ càng nhiều game, hạn chế tối đa driver beta thì sẽ càng tốt hơn so với AMD và Intel.
Sean Pelletier – Quản lý sản phẩm cấp cao của Nvidia – vừa mới có 1 pha “đâm chọt” AMD lẫn Intel bằng 1 cái bảng Excel, cho thấy đội ngũ phát triển driver của Nvidia chất lượng hơn hẳn so với các đối thủ. Cụ thể, trang tính này ghi số lượng các bản driver đạt chuẩn (non-beta) mà Nvidia đã phát hành trong vòng 2 năm qua, cũng như là số lượng game mà nó tối ưu so với AMD và Intel. Đoạn tweet này phê bình Intel và AMD một cách nhẹ nhàng và tinh tế về việc 2 hãng này ít tung ra driver cập nhật cho GPU của họ, đồng thời ám chỉ 1 điều rằng chất lượng driver của 2 hãng này không thật sự tốt cho lắm.
Đây là lần thứ 2 trong năm 20222 mà Nvidia đã “cà khịa” các đối thủ của họ về việc cập nhật driver GPU. Trước đó, Nvidia đã tự hào rằng họ không hề tung ra driver beta (thử nghiệm) làm chi, vì chất lượng của nó dưới mức trung bình và chỉ được test rất ít. Rõ ràng đây là 1 cú đâm khá mạnh vào AMD, do đội đỏ thường có xu hướng tung ra driver beta rất nhiều.',
'2022-02-01', 'tt1.jpg', 1),
(N'Dell ra mắt laptop Concept Luna có thể tháo lắp dễ dàng như một khẩu súng AK',
N'Dell đã giới thiệu một mẫu concept laptop thú vị vào năm 2021. Họ nỗ lực tạo ra một chiếc laptop thân thiện môi trường hơn với cấu tạo càng ít ốc vít càng tốt, cùng với đó là các bộ phận dễ nâng cấp và tái chế nhất có thể, và họ gọi nó là Concept Luna. Giờ thì Concept Luna đã đến giai đoạn chín muồi với những thành tựu xa hơn. Nó có thể được tháo rời hoàn toàn chỉ trong khoảng 30 giây bằng dụng cụ đặc biệt và mấy cái khớp, hoàn toàn không có con ốc nào để vặn và cũng chẳng có sợi cáp nào để bạn sợ đứt luôn.
Để làm được điều kỳ diệu này thì Dell đã thiết kế toàn bộ chiếc laptop với dạng nhiều module cấu thành và mọi module đều có thể được ghép nối với nhau một cách dễ dàng. Trong video, người đại diện từ phía Dell không hề mất nhiều công sức để tháo rời một chiếc laptop Concept Luna. Anh đã tháo hai bộ loa, pin, quạt CPU và bo mạch chủ của máy một cách dễ dàng. Màn hình cũng rất dễ gỡ sau khi tháo viền.', 
'2022-02-01', 'tt2.jpg', 1),
(N'Nhờ Starlink của Elon Musk mà nhà khoa học ở Nam Cực vẫn có Internet để nghiên cứu lớp băng 2,7 triệu năm giữa gió 54km/h', 
N'Dịch vụ internet vệ tinh Starlink của SpaceX hiện đang cung cấp kết nối internet cho một nhóm các nhà nghiên cứu ở Nam Cực. Họ thuộc tổ chức Center for Oldest Ice Exploration (COLDEX), hiện tại đang nghiên cứu một trong những lớp băng lâu đời nhất thế giới, có niên đại lên đến 2,7 triệu năm.
Hiện họ đang làm việc ở vùng Allan Hills của Nam Cực, nơi hiện đang có nhiệt độ dưới -19 độ C. Mức nhiệt độ này vẫn cao hơn mức nhiệt độ thấp nhất mà đĩa vệ tinh Starlink có thể hoạt động là -30 độ C. Ngoài ra thì sức gió ở đó thường xuyên lên đến trên 10m/s (36km/h), thậm chí 15m/s (54km/h) là chuyện bình thường. Bất chấp những điều kiện khắc nghiệt đó, đĩa vệ tinh của Starlink vẫn có thể hoạt động hoàn hảo, cung cấp internet cho nhóm nghiên cứu COLDEX làm việc.', 
'2022-02-01', 'tt3.jpg', 1),

(N'The Game Awards 2022 phá vỡ loạt kỷ lục, trở thành chương trình trending số 1 thế giới với hơn 100 triệu người xem', 
N'The Game Awards 2022 đến rồi lại đi, mang đến cho chúng ta một vài thông tin bất ngờ trong làng game. Dù vậy, sự kiện này vẫn tiếp tục trở thành công vượt ngoài mong đợi, và Geoff Keighley – MC nổi tiếng dẫn dắt The Game Awards 2022 – đã tiết lộ rằng chương trình đã phá vỡ một số kỷ lục về số lượng người xem lẫn độ phổ biến.
Có 1 điều thú vị trong sự kiện The Game Awards 2022, đó là chương trình tặng máy Steam Deck (512GB) cứ mỗi 1 phút diễn ra sự kiện, nghĩa là người xem sẽ có đến 150 cơ hội để sở hữu chiếc máy Steam Deck. Nhờ vậy mà nó đã thu hút tới hơn 9,5 triệu người xem độc nhất (unique customer) khi The Game Awards 2022 bắt đầu livestream, và đỉnh điểm là hơn 850.000 người xem tại cùng 1 thời điểm. Quả là chiếc máy chơi game cầm tay của Valve vẫn chưa hết “hot” các bạn ạ.', 
'2022-02-01', 'tt4.jpg', 2),
(N'King of Seas đang miễn phí, mời bạn hóa thân hải tặc chinh phục đại dương sâu thẳm và xanh ngắt',
N'King of Seas là game phiêu lưu nhập vai sandbox với yếu tố roguelike và lấy đề tài hải tặc làm chủ đạo. Game đưa người chơi nhập vai người con của vị vua quá cố. Sau chuyến giao thương đầu tiên, nhân vật chính rơi vào vòng xoáy của những âm mưu chính trị và số phận đưa đẩy trở thành cướp biển. Câu chuyện được kể lại thông qua lời thoại giữa các nhân vật, và đưa người chơi trải qua những trận hải chiến đầy hào hứng, nhất là cảm giác ngắm tàu của đối thủ chìm xuống biển sâu.
King of Seas lấy bối cảnh hải tặc thống trị thất đại hải và phép thuật được sử dụng như cơm bữa. Chỉ đến khi lực lượng hải quân đánh đuổi cướp biển ra khỏi bảy đại dương rồi dựng nên vương quốc. Dù vậy, họ vẫn tiếp tục ngăn chặn mối đe dọa từ cướp biển, và điều này khiến nghệ thuật hắc ám cũng dần thất truyền khỏi thế giới. Nhiều thế kỷ sau, tội ác trỗi dậy khi quốc vương đương nhiệm bị ám sát bởi lời nguyền, và tội mưu sát bị đổ hết cho con của đức vua. Vậy là cuộc phiêu lưu rửa sạch thanh danh bắt đầu.', 
'2022-02-01', 'tt5.jpg', 2),
(N'Horizon Chase Turbo đang miễn phí, mời bạn theo đuổi những chân trời tốc độ', 
N'Horizon Chase Turbo là một tựa game đua xe được lấy cảm hứng từ các tựa game nổi tiếng vào những năm 80 và 90 như Out Run, Lotus Turbo Challenge, Top Gear (SNES), Rush và một số tựa game đua xe khác. Mỗi đường đua trong tựa game đều tái hiện lại thành công phong cách gameplay arcade cổ điển để đảm bảo mang lại cho người chơi cảm giác hoài cổ nhưng vẫn có chút gì đó hiện đại.
Horizon Chase Turbo còn hỗ trợ chơi nhiều người bằng cách chia màn hình ra thành nhiều phần. Tính năng này được áp dụng trên tất cả các chế độ đua của game. Các bạn có thể mời bạn bè vào chơi cùng để tranh tài xem ai mới là tay lái lụa cự phách nhất, và ai mới là người có thể làm chủ được tốc độ, cũng như nắm gọn đường đua trong lòng bàn tay.', 
'2022-05-03', 'tt6.jpg', 2),

(N'Lộ thông số cả dàn CPU AMD Ryzen 7000 non-X, giá chỉ từ 229 USD', 
N'Tới giờ này thì vi xử lý AMD Ryzen 7000 non-X series hẳn cũng không còn là cái gì xa lạ với anh em game thủ nữa. Trước đây đã từng có những đợt rò rỉ riêng lẻ rồi, nhưng thông tin mới nhất không chỉ củng cố cho những tin đồn đó mà còn cho chúng ta biết nó sẽ đối đầu với CPU nào bên Intel. Hiển nhiên, cả 3 CPU Ryzen 9 7900, Ryzen 7 7700, Ryzen 5 7600 bị lộ lần này đều sử dụng kiến trúc Zen 4 (tiến trình 5nm), và chúng sẽ có một số khác biệt so với phiên bản X hiện đang được bán trên thị trường.
AMD Ryzen 9 7900 sẽ có 12 nhân 24 luồng, 76MB bộ nhớ đệm (64 MB L3 + 12 MB L3) và sẽ có xung nhịp tối đa lên tới 5,4 GHz (thấp hơn 200 MHz so với Ryzen 9 7900X). Con chip này sẽ được bán với giá 429 USD, tức là thấp hơn 120 USD so với Ryzen 9 7900X. AMD sẽ dùng con chip này để cạnh tranh với CPU Intel Core i9-13900 và Core i9-12900.', 
'2022-05-03', 'tt7.jpg', 3),
(N'Nguyên lô console Evercade EXP Limited Edition trị giá 600.000 USD đã không cánh mà bay ngay trong xe tải chở hàng', 
N'Một chiếc xe tải chở lô hàng máy chơi game cầm tay retro Evercade EXP vừa mới bị cướp mất hồi ngày 06/12/2022 các bạn ạ. Những chiếc console này đều là phiên bản Evercade EXP Limited Edition đang trên đường vận chuyển, chuẩn bị giao hàng cho các game thủ tại Anh, Mỹ, và các nước còn lại trên thế giới. Tổng giá trị lô hàng bị mất cắp lên tới 600.000 USD.
Nói sơ một chút về Evercade EXP thì nó là một chiếc console cầm tay theo dạng retro với màn hình IPS 4,3-inch, độ phân giải 800 x 480, cổng xuất hình mini-HDMI (720p), tích hợp WiFi, thời lượng pin 4-5 giờ, cổng sạc USB-C. Chúng có giá bán từ 150 USD cho phiên bản Standard Edition, còn phiên bản Limited Edition (đã hết hàng) thì có giá khoảng 200 USD.', 
'2022-05-03', 'tt8.jpg', 3),
(N'SSD 1TB của Tesla có giá tới 350 đô và chịu được rung chấn của xe… y như SSD thường', 
N'Vừa rồi, xe Tesla có nhận được bản cập nhật lớn Holiday Update 2022. Điểm nhấn của bản cập nhật này là nó giúp xe Model S và Model X (mẫu 2022 trở về sau) chơi được hơn 1000 game trên Steam. Những chiếc xe điện này được trang bị đồ họa Ryzen SoC với kiến trúc RDNA 2 xịn sò cùng 16GB RAM, đủ để chiến game trên màn hình 17-inch ngay giữa xe hoặc màn hình 8-inch phía sau xe. Nhưng thư viện game sẽ càng ngày càng lớn, vậy thì chỗ đâu mà chứa hết?
Ngoài những điều trên thì Tesla không cung cấp thêm thông số gì cả. Nhưng có 1 điều là những chiếc SSD di động thông thường hoàn toàn có thể chịu được những rung động, những lần dằn xóc khi xe đang chạy. Còn về ngưỡng nhiệt độ hoạt động thì lấy ví dụ là chiếc SSD Samsung T7 Shield giá 89 USD có thể hoạt động ổn định trong khoảng từ 0 đến 60 độ C, với độ ẩm môi trường trong khoảng 5% đến 95%. Vì thế cho nên trừ khi cabin của bạn xuống tới nhiệt độ âm khi đang chạy xe, có vẻ SSD của Tesla chẳng bền hơn là bao so với những chiếc SSD thông thường khác, chí ít là trong những trường hợp không nguy cấp.', 
'2022-05-03', 'tt9.jpg', 3)

