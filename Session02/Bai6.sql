-- Bai6

insert into staffs (staff_id, staff_name, staff_date, staff_wage)
values (1, "Ta Tien Dung", "01-02-2005", 3000), (1, "NGuyen Van Nam", "02-02-2005", 5000), (1, "Nguyen Quang Hai", "03-02-2005", 3500);

update staffs set staff_wage = 7000 where staff_id = 1;

delete from staffs where staff_id = 3;