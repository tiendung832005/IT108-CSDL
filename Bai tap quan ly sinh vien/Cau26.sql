-- cau 26
select dmkhoa.tenkhoa, sum(dmsv.hocbong) as tonghocbong from dmsv join dmkhoa on dmsv.makhoa = dmkhoa.makhoa group by dmkhoa.tenkhoa;