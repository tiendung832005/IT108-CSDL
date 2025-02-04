-- cau 29
select year(getdate()) - year(ngaysinh) as tuoi,
count(*) as soluongsinhvien
from dmsv group by year(getdate()) - year(ngaysinh) order by tuoi;