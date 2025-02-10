create database demo_hackathon;
use demo_hackathon;

create table tbl_users(
	user_id int auto_increment primary key,
    user_name varchar(50) not null unique,
    user_fullname varchar(100) not null,
    email varchar(100) not null unique,
    user_address text,
    user_phone varchar(20) not null unique
);

create table tbl_employees(
	emp_id char(5) primary key,
    user_id int unique,
    emp_position varchar(50),
    emp_hire_date date,
    salary decimal(10,2) not null check(salary>0),
    emp_status enum('Dang lam', 'Dang nghi') default 'Dang lam',
    FOREIGN KEY (user_id) REFERENCES tlb_users(user_id) on delete cascade
);

create table tbl_orders(
	order_id int auto_increment primary key,
    user_id int unique,
    order_date date,
    order_total_amount decimal(10,2) not null,
    foreign key (user_id) references tbl_users(user_id) on delete cascade
);

create table tbl_products(
	pro_id varchar(5) primary key,
    pro_name varchar(100) not null unique,
    pro_price decimal(10,2) not null check(pro_price>0),
    pro_quantity int,
    pro_status enum('Con hang', 'Het hang') default 'Con Hang'
);

create table tbl_order_detail(
	order_detail_id int auto_increment primary key,
    order_id int,
    pro_id int,
    order_detail_quantity int not null check(order_detail_quantity>0),
    foreign key (order_id) references tbl_orders(order_id) on delete cascade,
    foreign key (pro_id) references tbl_products(pro_id) on delete cascade
);

-- cau 2

-- Thêm cột order_status vào bảng tbl_orders
ALTER TABLE tbl_orders
ADD COLUMN order_status ENUM('Pending', 'Processing', 'Completed', 'Cancelled') DEFAULT 'Pending';

-- Đổi kiểu dữ liệu của cột user_phone trong bảng tbl_users thành VARCHAR(11)
ALTER TABLE tbl_users
MODIFY COLUMN user_phone VARCHAR(11) NOT NULL UNIQUE;

-- Xoá cột email khỏi bảng tbl_users
ALTER TABLE tbl_users
DROP COLUMN email;

-- cau 3

-- Thêm dữ liệu vào bảng tbl_users (bao gồm ít nhất 1 nhân viên)
INSERT INTO tbl_users (user_name, user_fullname, user_address, user_phone) VALUES
('user1', 'Nguyen Van A', 'Hanoi', '01234567890'),
('user2', 'Tran Thi B', 'Ho Chi Minh', '09876543210'),
('user3', 'Le Van C', 'Da Nang', '03456789123'); -- Nhân viên

-- Thêm dữ liệu vào bảng tbl_employees (chỉ thêm nhân viên)
INSERT INTO tbl_employees (emp_id, user_id, emp_position, emp_hire_date, salary, emp_status) VALUES
('E001', 3, 'Nhan vien ban hang', '2024-01-10', 8000000.00, 'Dang lam');

-- Thêm dữ liệu vào bảng tbl_orders
INSERT INTO tbl_orders (user_id, order_date, order_total_amount, order_status) VALUES
(1, '2024-02-01', 150000.00, 'Processing'),
(2, '2024-02-02', 200000.00, 'Pending'),
(3, '2024-02-03', 50000.00, 'Completed');

-- Thêm dữ liệu vào bảng tbl_products
INSERT INTO tbl_products (pro_id, pro_name, pro_price, pro_quantity, pro_status) VALUES
('P001', 'Ao thun nam', 100000.00, 50, 'Con hang'),
('P002', 'Quan jeans', 200000.00, 30, 'Con hang'),
('P003', 'Giay the thao', 300000.00, 20, 'Het hang');

-- Thêm dữ liệu vào bảng tbl_order_detail
INSERT INTO tbl_order_detail (order_id, pro_id, order_detail_quantity) VALUES
(1, 'P001', 1),
(2, 'P002', 2),
(3, 'P003', 1);

-- 4a
SELECT order_id, order_date, order_total_amount, order_status 
FROM tbl_orders;

-- 4b
SELECT DISTINCT u.user_fullname 
FROM tbl_users u
JOIN tbl_orders o ON u.user_id = o.user_id;

-- 5a
SELECT p.pro_name, SUM(od.order_detail_quantity) AS total_sold
FROM tbl_products p
JOIN tbl_order_detail od ON p.pro_id = od.pro_id
GROUP BY p.pro_name;

-- 5b
SELECT p.pro_name, SUM(od.order_detail_quantity * p.pro_price) AS total_revenue
FROM tbl_products p
JOIN tbl_order_detail od ON p.pro_id = od.pro_id
GROUP BY p.pro_name
ORDER BY total_revenue DESC;

-- 6a
SELECT u.user_fullname, COUNT(o.order_id) AS total_orders
FROM tbl_users u
JOIN tbl_orders o ON u.user_id = o.user_id
GROUP BY u.user_fullname;

-- 6b
SELECT u.user_fullname, COUNT(o.order_id) AS total_orders
FROM tbl_users u
JOIN tbl_orders o ON u.user_id = o.user_id
GROUP BY u.user_fullname
HAVING COUNT(o.order_id) >= 2;

-- 7
SELECT u.user_fullname, SUM(o.order_total_amount) AS total_spent
FROM tbl_users u
JOIN tbl_orders o ON u.user_id = o.user_id
GROUP BY u.user_fullname
ORDER BY total_spent DESC
LIMIT 5;

-- 9 
SELECT u.user_fullname, MAX(o.order_total_amount) AS max_order_value
FROM tbl_users u
JOIN tbl_orders o ON u.user_id = o.user_id
GROUP BY u.user_fullname
ORDER BY max_order_value DESC
LIMIT 1;

-- 10
SELECT u.user_fullname, MAX(o.order_total_amount) AS highest_order_value
FROM tbl_users u
JOIN tbl_orders o ON u.user_id = o.user_id
GROUP BY u.user_fullname
ORDER BY highest_order_value DESC
LIMIT 1;

SELECT p.pro_id, p.pro_name, p.pro_quantity
FROM tbl_products p
LEFT JOIN tbl_order_detail od ON p.pro_id = od.pro_id
WHERE od.pro_id IS NULL;
