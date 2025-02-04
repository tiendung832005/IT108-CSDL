-- cau 27
select dmkhoa.tenkhoa, max(dmsv.hocbong) as hocbongcaonhat from dmsv join dmkhoa on masv.makhoa = dmkhoa.makhoa 
group by dmkhoa.TenKhoa;