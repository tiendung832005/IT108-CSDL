select year(ngaysinh) as namsinh, count(*) as soluongsinhvien 
from dmsv group by year(ngaysinh) having count(*) = 2;