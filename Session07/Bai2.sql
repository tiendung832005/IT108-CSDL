create table Employees (
	employee_id int,
    name varchar(255),
    dob date,
    department_id int, 
    salary decimal(10,2)
);

create table Departments(
	department_id int,
    department_name varchar(255),
    location varchar(255)
);

create table Projects(
	project_id int,
    project_name varchar(255),
    start_date date,
    end_date date
);

create table TimeSheets(
	timesheet_id int,
    employee_id int,
    foreign key (employee_id) references Employees(employee_id),
    project_id int,
    foreign key (project_id) references Projects(project_id),
    work_date date,
    hours_worked decimal(5,2)
);

create table WorkReports (
	report_id int,
    employee_id int,
    foreign key (employee_id) references Employees(employee_id),
    report_date date,
    report_content text
);

-- Thêm phòng ban
INSERT INTO Departments (department_name, location) VALUES 
('IT', 'Hanoi'), 
('HR', 'Ho Chi Minh');

-- Thêm nhân viên
INSERT INTO Employees (name, dob, department_id, salary) VALUES 
('Nguyen Van A', '1990-05-10', 1, 15000000.00), 
('Tran Thi B', '1995-08-15', 2, 12000000.00);

-- Thêm dự án
INSERT INTO Projects (project_name, start_date, end_date) VALUES 
('Website Development', '2024-01-01', '2024-06-30'), 
('HR System Upgrade', '2024-02-01', '2024-07-31');

-- Thêm bảng chấm công
INSERT INTO TimeSheets (employee_id, project_id, work_date, hours_worked) VALUES 
(1, 1, '2024-02-05', 8.00), 
(2, 2, '2024-02-06', 7.50);

-- Thêm báo cáo công việc
INSERT INTO WorkReports (employee_id, report_date, report_content) VALUES 
(1, '2024-02-05', 'Completed the frontend layout of the website.'), 
(2, '2024-02-06', 'Updated employee database in HR system.');

update Projects set start_date = '2024-12-12' where project_name = 'Website Development';

delete from employees where name = 'Nguyen Van A';

