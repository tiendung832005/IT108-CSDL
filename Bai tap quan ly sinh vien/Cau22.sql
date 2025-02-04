-- cau22
select count(*) as tongsinhvien, count(case when Phai = 'Nữ' then 1 end) as tongsinhvienNu from dmsv;