-- cau 24
select dmmh.tenmh, count(distinct ketqua.masv) as tongsosinhvien from ketqua join dmmh on ketqua.mamh = dmmh.mamh group by dmmh.tenmh;