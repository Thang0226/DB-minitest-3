create database VatTu;

use VatTu;

create table VatTu (
	id int auto_increment primary key,
    ma_vt varchar(20) not null,
    ten_vt varchar(30) not null,
    dv_tinh varchar(20) not null,
    gia_tien decimal(10,2)
);

create table TonKho (
	id int auto_increment primary key,
	vattu_id int not null,
    sl_dau int,
    tong_sln int,
    tong_slx int,
    foreign key (vattu_id) references VatTu (id)
);

create table NhaCC (
	id int auto_increment primary key,
	ma_ncc varchar(20) not null,
    ten_ncc varchar(30) not null,
    dia_chi varchar(50),
    sdt varchar(15)
);
drop table dondh;
drop table PhieuNhap;
drop table PhieuXuat;
drop table CTDonHang;
drop table CTPhieuNhap;
drop table CTPhieuXuat;
drop table nhacc;

create table DonDH (
	id int auto_increment primary key,
	ma_dh varchar(20) not null,
    ngay_dh date not null,
    ncc_id int not null,
    foreign key (ncc_id) references NhaCC (id)
);

create table PhieuNhap (
	id int auto_increment primary key,
	so_pn varchar(20) not null,
    ngay_nhap date not null,
    dh_id int not null,
    foreign key (dh_id) references DonDH (id)
);

create table PhieuXuat (
	id int auto_increment primary key,
	ngay_xuat date not null,
    ten_kh varchar(20) not null
);

create table CTDonHang (
	id int auto_increment primary key,
	dh_id int not null,
    vt_id int not null,
    sl_dat int,
    foreign key (dh_id) references DonDH (id),
    foreign key (vt_id) references VatTu (id)
);

create table CTPhieuNhap (
	id int auto_increment primary key,
	pn_id int not null,
    vt_id int not null,
    sl_nhap int,
    dg_nhap decimal(10,2),
    ghi_chu text,
    foreign key (pn_id) references PhieuNhap (id),
    foreign key (vt_id) references VatTu (id)
);

create table CTPhieuXuat (
	id int auto_increment primary key,
	px_id int not null,
    vt_id int not null,
    sl_xuat int,
    dg_xuat decimal(10,2),
    ghi_chu text,
    foreign key (px_id) references PhieuXuat (id),
    foreign key (vt_id) references VatTu (id)
);


INSERT INTO VatTu (ma_vt, ten_vt, dv_tinh, gia_tien)
VALUES
('VT001', 'Xi mang', 'Bao', 90000.00),
('VT002', 'Gach do', 'Vien', 3000.00),
('VT003', 'Cat xay', 'Khoi', 550000.00),
('VT004', 'Thep ong', 'Kg', 15000.00),
('VT005', 'Son nuoc', 'Thung', 350000.00),
('VT006', 'Day dien', 'Cuon', 250000.00),
('VT007', 'Ong nhua', 'Met', 10000.00),
('VT008', 'Da 1x2', 'Khoi', 700000.00),
('VT009', 'Xi mang trang', 'Bao', 120000.00),
('VT010', 'Gach men', 'Hop', 200000.00);

insert into TonKho (vattu_id, sl_dau, tong_sln, tong_slx) values
	(1, 100, 50, 30), -- VatTu ID 1: Xi mang
	(2, 200, 100, 80), -- VatTu ID 2: Gach do
	(3, 300, 150, 120), -- VatTu ID 3: Cat xay
	(4, 400, 200, 180), -- VatTu ID 4: Thep ong
	(5, 500, 250, 230); -- VatTu ID 5: Son nuoc
    
INSERT INTO NhaCC (ma_ncc, ten_ncc, dia_chi, sdt)
VALUES
('NCC001', 'Cong ty A', '123 Duong ABC, TP HCM', '0912345678'),
('NCC002', 'Cong ty B', '456 Duong XYZ, Ha Noi', '0987654321'),
('NCC003', 'Cong ty C', '789 Duong DEF, Da Nang', '0933456789');

INSERT INTO DonDH (ma_dh, ngay_dh, ncc_id)
VALUES
('DH001', '2024-11-20', 1), -- Liên kết với NCC001
('DH002', '2024-11-21', 2), -- Liên kết với NCC002
('DH003', '2024-11-22', 3); -- Liên kết với NCC003

INSERT INTO PhieuNhap (so_pn, ngay_nhap, dh_id)
VALUES
('PN001', '2024-11-21', 1), -- Liên kết với DH001
('PN002', '2024-11-22', 2), -- Liên kết với DH002
('PN003', '2024-11-23', 3); -- Liên kết với DH003

INSERT INTO PhieuXuat (ngay_xuat, ten_kh)
VALUES
('2024-11-21', 'Nguyen Van A'),
('2024-11-22', 'Le Thi B'),
('2024-11-23', 'Tran Van C');

INSERT INTO CTDonHang (dh_id, vt_id, sl_dat)
VALUES
(1, 1, 50), -- DonDH ID 1, VatTu ID 1
(1, 2, 30), -- DonDH ID 1, VatTu ID 2
(2, 3, 100), -- DonDH ID 2, VatTu ID 3
(2, 4, 20), -- DonDH ID 2, VatTu ID 4
(3, 5, 10), -- DonDH ID 3, VatTu ID 5
(3, 6, 25); -- DonDH ID 3, VatTu ID 6

INSERT INTO CTPhieuNhap (pn_id, vt_id, sl_nhap, dg_nhap, ghi_chu)
VALUES
(1, 1, 50, 90000.00, 'Nhap tu NCC001'),
(1, 2, 30, 3000.00, 'Nhap tu NCC001'),
(2, 3, 100, 550000.00, 'Nhap tu NCC002'),
(2, 4, 20, 15000.00, 'Nhap tu NCC002'),
(3, 5, 10, 350000.00, 'Nhap tu NCC003'),
(3, 6, 25, 250000.00, 'Nhap tu NCC003');

INSERT INTO CTPhieuXuat (px_id, vt_id, sl_xuat, dg_xuat, ghi_chu)
VALUES
(1, 1, 20, 92000.00, 'Xuat cho Nguyen Van A'),
(1, 2, 15, 3100.00, 'Xuat cho Nguyen Van A'),
(2, 3, 50, 560000.00, 'Xuat cho Le Thi B'),
(2, 4, 10, 15200.00, 'Xuat cho Le Thi B'),
(3, 5, 5, 360000.00, 'Xuat cho Tran Van C'),
(3, 6, 10, 255000.00, 'Xuat cho Tran Van C');















