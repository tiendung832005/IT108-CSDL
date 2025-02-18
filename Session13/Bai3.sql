CREATE TABLE company_funds (
    fund_id INT PRIMARY KEY AUTO_INCREMENT,
    balance DECIMAL(15,2) NOT NULL -- Số dư quỹ công ty
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(50) NOT NULL,   -- Tên nhân viên
    salary DECIMAL(10,2) NOT NULL    -- Lương nhân viên
);

CREATE TABLE payroll (
    payroll_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,                      -- ID nhân viên (FK)
    salary DECIMAL(10,2) NOT NULL,   -- Lương được nhận
    pay_date DATE NOT NULL,          -- Ngày nhận lương
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);


INSERT INTO company_funds (balance) VALUES (50000.00);

INSERT INTO employees (emp_name, salary) VALUES
('Nguyễn Văn An', 5000.00),
('Trần Thị Bốn', 4000.00),
('Lê Văn Cường', 3500.00),
('Hoàng Thị Dung', 4500.00),
('Phạm Văn Em', 3800.00);

DELIMITER &&
create procedure PaySalary(in p_emp_id int)
begin
    declare v_salary decimal(10,2);
    declare v_balance decimal(15,2);
    declare v_bank_status int;
    
    start transaction;
    
    select salary into v_salary from employees where emp_id = p_emp_id;
    
    select balance into v_balance from company_funds where fund_id = 1;
    
    if v_balance < v_salary then
        signal sqlstate '45000' SET MESSAGE_TEXT = 'Số dư quỹ không đủ';
        rollback;
        leave; -- Thoát khỏi procedure
    end if;
    
    update company_funds 
    set balance = balance - v_salary
    where fund_id = 1;
    
    insert into payroll (emp_id, salary, pay_date) 
    values (p_emp_id, v_salary, CURDATE());
    
    set v_bank_status = FLOOR(RAND() * 2); 
    
    if v_bank_status = 0 then
        signal sqlstate '45000' SET MESSAGE_TEXT = 'Lỗi hệ thống ngân hàng';
        rollback;
    else
        commit;
    end if;
end &&
DELIMITER &&;

call PaySalary(1);

