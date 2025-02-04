-- cau 20
select masv, phai, makhoa, case when hocbong > 500000 then 'Học bổng cao' else 'Mức Trung Bình'  
end as muchocbong from dmsv;