-- cau 17
select hosv, tensv, DATEDIFF(YEAR, ngaysinh, GETDATE()) AS tuoi, hocbong from dmsv where datediff(YEAR, ngaysinh, GETDATE()) > 20;