-- cau 14
select dmsv.masv, dmsv.hosv, dmsv.tensv as hotensv, dmkhoa.tenkhoa, dmsv.phai from dmsv join dmkhoa on dmsv.makhoa = dmkhoa.makhoa
where dmsv.phai = 'Nam' and (dmkhoa.tenkhoa = 'Anh Văn' or dmkhoa.tenkhoa = 'Tin học';