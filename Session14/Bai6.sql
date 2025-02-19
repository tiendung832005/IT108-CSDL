DELIMITER &&
create trigger before_update_phone
before update on employees
for each row
begin
    if length(new.phone) <> 10 or new.phone not regexp '^[0-9]+$' then
        signal sqlstate '45000' set message_text = 'số điện thoại phải có đúng 10 chữ số!';
    end if;
end &&
DELIMITER &&;

CREATE TABLE notifications (

    notification_id INT PRIMARY KEY AUTO_INCREMENT,

    employee_id INT NOT NULL,

    message TEXT NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

 FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE

);

DELIMITER &&
create trigger after_insert_employee
after insert on employees
for each row
begin
    insert into notifications (employee_id, message)
    values (new.employee_id, 'xin chao');
end &&
DELIMITER &&;

DELIMITER &&
create procedure AddNewEmployeeWithPhone(
    in emp_name varchar(255),
    in emp_email varchar(255),
    in emp_phone varchar(20),
    in emp_hire_date date,
    in emp_department_id int
)
begin
    declare emp_id int;
    declare emp_exists int default 0;
    if length(emp_phone) <> 10 or emp_phone not regexp '^[0-9]+$' then
        signal sqlstate '45000' set message_text = 'số điện thoại phải có đúng 10 chữ so';
    end if;
    select count(*) into emp_exists from employees where email = emp_email;
    if emp_exists > 0 then
        signal sqlstate '45000' set message_text = 'email đã tồn tại không thể thêm nhân viên mới';
    end if;
	START TRANSACTION;
    insert into employees (name, email, phone, hire_date, department_id)
    values (emp_name, emp_email, emp_phone, emp_hire_date, emp_department_id);
    set emp_id = last_insert_id();
    commit;
end &&
DELIMITER &&;