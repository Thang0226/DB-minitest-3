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
















