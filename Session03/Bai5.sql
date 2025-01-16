create table Employees(
	employee_id int primary key auto_increment,
    employee_name varchar(255) not null,
    email varchar(255) not null unique,
    department varchar(255) not null,
    salary decimal(10,2)
);

INSERT INTO Employees (employee_name, email, department, salary)
VALUES 
('Nguyen Van A', 'nguyenvana@example.com', 'Sales', 50000.00),
('Le Thi B', 'lethib@example.com', 'IT', 60000.00),
('Tran Van C', 'tranvanc@example.com', 'HR', 45000.00), 
('Pham Thi D', 'phamthid@example.com', 'Marketing', 55000.00);

select * from employees where department = 'Sales';

update employees set salary = salary * 1.1 where department = 'Marketing';