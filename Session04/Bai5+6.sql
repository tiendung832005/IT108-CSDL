create table Employee(
	employee_id char(4) primary key,
    employee_name varchar(50) not null,
    date_of_birth date,
    sex bit Not null,
    base_salary int not null,
    phone_number char(11) not null unique
);

create table Department(
	department_id int primary key auto_increment,
    department_name Varchar(50) Not null unique,
    address varchar(50) not null
);

INSERT INTO Employee (employee_id, employee_name, date_of_birth, sex, base_salary, phone_number) VALUES
('E001', 'Nguyễn Minh Nhật', '2004-12-11', 1, 4000000, '0987836473'),
('E002', 'Đỗ Đức Long', '2004-01-12', 1, 3500000, '0982378673'),
('E003', 'Mai Tiến Linh', '2004-02-03', 1, 3500000, '0976734562'),
('E004', 'Nguyễn Ngọc Ánh', '2004-10-04', 0, 5000000, '0987352772'),
('E005', 'Phạm Minh Sơn', '2003-03-12', 1, 4000000, '0987236568'),
('E006', 'Nguyễn Ngọc Minh', '2003-11-11', 0, 5000000, '0928864736');

select employee_id, employee_name, date_of_birth, phone_number from Employee;

update Employee set base_salary = base_salary * 1.1 where sex = 0;

delete from Employee where year(date_of_birth) = 2003;

ALTER TABLE Employee
add column department_id int not null,
add constraint fk_department
FOREIGN KEY (department_id) REFERENCES Department(department_id);

INSERT INTO Department (department_name, address) VALUES
('Sales', '123 Phan Chu Trinh, Hanoi'),
('Marketing', '456 Le Duan, Hanoi'),
('Finance', '789 Ngo Quyen, Hanoi'),
('IT', '101 Tran Hung Dao, Hanoi'),
('HR', '202 Ba Trieu, Hanoi');

INSERT INTO Employee (employee_id, employee_name, date_of_birth, sex, base_salary, phone_number) VALUES
('E001', 'Nguyen Thi Lan', '1985-06-15', 0, 12000000, '0912345678'),
('E002', 'Tran Minh Tu', '1990-03-10', 1, 15000000, '0909876543'),
('E003', 'Pham Quang Hieu', '1987-11-05', 1, 13000000, '0922334455'),
('E004', 'Le Mai Lan', '1992-08-25', 0, 11000000, '0933445566'),
('E005', 'Hoang Thi Lan', '1989-01-20', 0, 14000000, '0944556677'),
('E006', 'Nguyen Minh Thanh', '1995-04-18', 1, 10000000, '0955667788'),
('E007', 'Dinh Lan Anh', '1993-07-30', 0, 12500000, '0966778899'),
('E008', 'Vu Thi Kim', '1990-10-25', 0, 13500000, '0977889900'),
('E009', 'Ho Thi Mai', '1988-02-12', 0, 11000000, '0988990011'),
('E010', 'Phan Quoc Toan', '1991-09-17', 1, 12000000, '0999001122');


ALTER TABLE Employee DROP FOREIGN KEY fk_department;

DELETE FROM Department WHERE department_id = 1;

UPDATE Department
SET department_name = 'Phong kinh doanh'
WHERE department_id = 1;

SELECT * FROM Employee;

SELECT * FROM Department;




