-- cau 28
select dmkhoa.tenkhoa, 
sum(case when dmsv.phai = 'Nam' then 1 else 0 end) as sosinhviennam,
sum(case when dmsv.phai = 'Nữ' then 1 else 0 end) as sosinhviennu from dmsv join dmkhoa on dmsv.makhoa = dmkhoa.makhoa 
group by dmkhoa.TenKhoa;
