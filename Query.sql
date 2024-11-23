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
    
    IF in_vt_id is NULL THEN
        SET sl_cuoi = -1; -- Trả về -1 nếu không tìm thấy vật tư
        leave proc;
    END IF;
    
    SELECT sl_dau, tong_sln, tong_slx
    INTO var_sl_dau, var_tong_sln, var_tong_slx
    FROM TonKho
    WHERE vattu_id = in_vt_id;
    
    select concat('Ton kho: ', var_sl_dau,' ', var_tong_sln,' ', var_tong_slx);
    
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
    select concat('So luong cuoi: ', sl_cuoi);
end $
delimiter ;

call demSLCuoiVT('VT005', @sl_cuoi);
select @sl_cuoi;















