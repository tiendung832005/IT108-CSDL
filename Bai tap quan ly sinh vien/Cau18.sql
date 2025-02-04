-- cau 18
select hosv, tensv timestampdiff(year, ngaysinh, curdate()) as tuoi, tenkhoa from dmsv join dmkhoa on dmsv.makhoa = dmkhoa.makhoa
where timestampdiff(year, ngaysinh, curdate()) between 20 and 25;