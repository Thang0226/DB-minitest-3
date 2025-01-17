use VatTu;

-- Tao Views

create view vw_CTPNhap as
select pn.so_pn, vt.ma_vt, ctpn.sl_nhap, ctpn.dg_nhap, ctpn.sl_nhap * ctpn.dg_nhap as 'Thanh tien'
from PhieuNhap pn
join CTPhieuNhap ctpn on pn.id = ctpn.pn_id
join VatTu vt on vt.id = ctpn.vt_id;

select * from vw_CTPNhap;


create view vw_CTPNHAP_VT as
select pn.so_pn, vt.ma_vt, vt.ten_vt, ctpn.sl_nhap, ctpn.dg_nhap, ctpn.sl_nhap * ctpn.dg_nhap as 'thanh tien'
from PhieuNhap pn
join CTPhieuNhap ctpn on pn.id = ctpn.pn_id
join VatTu vt on vt.id = ctpn.vt_id;

select * from vw_CTPNHAP_VT;


create view vw_CTPNHAP_VT_PN as
select pn.so_pn, pn.ngay_nhap, ctdh.sl_dat, vt.ma_vt, vt.ten_vt, ctpn.sl_nhap, ctpn.dg_nhap, ctpn.sl_nhap * ctpn.dg_nhap as 'thanh tien'
from PhieuNhap pn
join CTPhieuNhap ctpn on pn.id = ctpn.pn_id
join VatTu vt on vt.id = ctpn.vt_id
join DonDH on pn.dh_id = DonDH.id
join CTDonHang ctdh on ctdh.dh_id = DonDH.id;

select * from vw_CTPNHAP_VT_PN;


create view vw_CTPNHAP_VT_PN_DH as
select pn.so_pn, pn.ngay_nhap, ctdh.sl_dat, ncc.ma_ncc, vt.ma_vt, vt.ten_vt, ctpn.sl_nhap, ctpn.dg_nhap, ctpn.sl_nhap * ctpn.dg_nhap as 'thanh tien'
from PhieuNhap pn
join CTPhieuNhap ctpn on pn.id = ctpn.pn_id
join VatTu vt on vt.id = ctpn.vt_id
join DonDH on pn.dh_id = DonDH.id
join NhaCC ncc on DonDH.ncc_id = ncc.id
join CTDonHang ctdh on ctdh.dh_id = DonDH.id;

select * from vw_CTPNHAP_VT_PN_DH;


create view vw_CTPNHAP_loc as
select pn.so_pn, vt.ma_vt, ctpn.sl_nhap, ctpn.dg_nhap, ctpn.sl_nhap * ctpn.dg_nhap as 'thanh tien'
from CTPhieuNhap ctpn
join PhieuNhap pn on pn.id = ctpn.pn_id
join VatTu vt on vt.id = ctpn.vt_id
where ctpn.sl_nhap > 5;

select * from vw_CTPNHAP_loc;


create or replace view vw_CTPNHAP_VT_loc as
select pn.so_pn, vt.ma_vt, vt.ten_vt, ctpn.sl_nhap, ctpn.dg_nhap, ctpn.sl_nhap * ctpn.dg_nhap as 'thanh tien'
from CTPhieuNhap ctpn
join PhieuNhap pn on pn.id = ctpn.pn_id
join VatTu vt on vt.id = ctpn.vt_id
-- where vt.dv_tinh = 'Khoi'; 
where vt.dv_tinh = 'Bo';

select * from vw_CTPNHAP_VT_loc;


create view vw_CTPXUAT as
select ctpx.px_id as 'ID phieu xuat', vt.ma_vt, ctpx.sl_xuat, ctpx.dg_xuat, ctpx.sl_xuat * ctpx.dg_xuat as 'thanh tien'
from CTPhieuXuat ctpx 
join VatTu vt on ctpx.vt_id = vt.id;

select * from vw_CTPXUAT;


create view vw_CTPXUAT_VT as
select ctpx.px_id as 'ID phieu xuat', vt.ma_vt, vt.ten_vt, ctpx.sl_xuat, ctpx.dg_xuat
from CTPhieuXuat ctpx 
join VatTu vt on ctpx.vt_id = vt.id;

select * from vw_CTPXUAT_VT;


create view vw_CTPXUAT_VT_PX as
select ctpx.px_id as 'ID phieu xuat', px.ten_kh, vt.ma_vt, vt.ten_vt, ctpx.sl_xuat, ctpx.dg_xuat
from CTPhieuXuat ctpx 
join VatTu vt on ctpx.vt_id = vt.id
join PhieuXuat px on ctpx.px_id = px.id;

select * from vw_CTPXUAT_VT_PX;





-- Tao Stored Procedures

delimiter $
drop procedure if exists demSLCuoiVT $
create procedure demSLCuoiVT(
	in in_ma_vt varchar(20),
    out sl_cuoi int
)
proc: begin
	declare in_vt_id int;
	declare var_sl_dau int default 0;
    declare var_tong_sln int default 0;
    declare var_tong_slx int default 0; 
    declare var_sl_nhap int default 0;
    declare var_sl_xuat int default 0;
    
    select 'Comment';
    
    select id
    into in_vt_id
    from VatTu
    where ma_vt = in_ma_vt;
    
    select concat('id: ', in_vt_id);
    
    if in_vt_id is null then
        set sl_cuoi = -1; -- Trả về -1 nếu không tìm thấy vật tư
        leave proc;
    end if;
    
    select sl_dau, tong_sln, tong_slx
    INTO var_sl_dau, var_tong_sln, var_tong_slx
    FROM TonKho
    WHERE vattu_id = in_vt_id;
    
    select concat('ton kho: ', var_sl_dau,' ', var_tong_sln,' ', var_tong_slx);
    
    select coalesce(sum(sl_nhap),0)
    into var_sl_nhap
    from CTPhieuNhap
    where vt_id = in_vt_id;
    
    select concat('sl_nhap: ', var_sl_nhap);
    
    select coalesce(sum(sl_xuat),0)
    into var_sl_xuat
    from CTPhieuXuat
    where vt_id = in_vt_id;
    
    select concat('sl_xuat: ', var_sl_xuat);
    
    set sl_cuoi = (var_sl_dau + var_tong_sln - var_tong_slx) + var_sl_nhap - var_sl_xuat;
    select concat('so luong cuoi: ', sl_cuoi);
end $
delimiter ;

call demSLCuoivt('VT005', @sl_cuoi);
select @sl_cuoi;


delimiter $
drop procedure if exists tinhTongTienXuat $
create procedure tinhTongTienXuat(
	in in_ma_vt varchar(20),
    out tong_tien decimal(10,2)
)
begin
	declare in_vt_id int;
    
    select id
    into in_vt_id
    from VatTu
    where ma_vt = in_ma_vt;
    
    select coalesce(sum(sl_xuat * dg_xuat), 0)
    into tong_tien
    from CTPhieuXuat
    where vt_id = in_vt_id;
end $
delimiter ;

call tinhTongTienXuat('VT0025', @tong_tien);
select @tong_tien;


delimiter //
drop table if exists tinhTongSLDat//
create procedure tinhTongSLDat(
	in in_ma_dh varchar(20),
    out tong_sl int
)
begin
	declare in_dh_id int;
    
    select id
    into in_dh_id
    from DonDH
    where ma_dh = in_ma_dh;
    
    select coalesce(sum(sl_dat),0)
    into tong_sl
    from CTDonHang
    where dh_id = in_dh_id;
    
end//
delimiter ;

call tinhTongSLDat('DH002', @tong_sl_dat);
select @tong_sl_dat;


delimiter //
create procedure themDonDH(
	in in_ma_dh varchar(20),
    in in_ngay_dh date,
    in in_ncc_id int
)
begin
	insert into DonDH(ma_dh, ngay_dh, ncc_id) values
		(in_ma_dh, in_ngay_dh, in_ncc_id);
end//
delimiter ;

call themDonDH('DH004', '2024-11-23', 2);
select * from DonDH;


delimiter //
create procedure themCTDonHang(
	in in_dh_id int,
    in in_vt_id int,
    in in_sl_dat int
)
begin
	insert into CTDonHang(dh_id, vt_id, sl_dat) values
		(in_dh_id, in_vt_id, in_sl_dat);
end//
delimiter ;

call themCTDonHang(4, 9, 50);
select * from CTDonHang;


delimiter //
drop procedure if exists xoaNhaCC//
create procedure xoaNhaCC(
	in in_id int
)
begin 
	alter table DonDH 
    modify ncc_id int null;
    
	update DonDH
    set ncc_id = null
    where ncc_id = in_id;
    
    delete from NhaCC
    where id = in_id;
end//
delimiter ;

call xoaNhaCC(2);
select * from NhaCC;
select * from DonDH;






