create database session05;
use session05;

-- Tạo bảng customers
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    address VARCHAR(255)
);

-- Tạo bảng orders
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY, -- Khóa chính
    customer_id INT, -- Khóa ngoại
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) -- Liên kết với bảng customers
);

-- Thêm bản ghi vào bảng customers
INSERT INTO customers (name, email, phone, address)
VALUES
('Nguyen Van An', 'nguyenvanan@example.com', '0901234567', '123 Le Loi, TP.HCM'),
('Tran Thi Bich', 'tranthibich@example.com', '0912345678', '456 Nguyen Hue, TP.HCM'),
('Le Van Cuong', 'levancuong@example.com', '0923456789', '789 Dien Bien Phu, Ha Noi');

-- Thêm bản ghi vào bảng orders
INSERT INTO orders (customer_id, order_date, total_amount, status)
VALUES
(1, '2025-01-10', 500000, 'Pending'),
(1, '2025-01-12', 325000, 'Completed'),
(NULL, '2025-01-13', 450000, 'Cancelled'),
(3, '2025-01-14', 270000, 'Pending'),
(2, '2025-01-16', 850000, NULL);

SELECT 
    orders.order_id,
    orders.order_date,
    orders.total_amount,
    customers.name,
    customers.email
FROM orders
LEFT JOIN customers ON orders.customer_id = customers.customer_id
UNION
SELECT 
    orders.order_id,
    orders.order_date,
    orders.total_amount,
    customers.name,
    customers.email
FROM orders 
RIGHT JOIN customers ON orders.customer_id = customers.customer_id;


SELECT 
    customers.customer_id,
    customers.name,
    customers.phone,
    orders.order_id,
    orders.status
FROM customers
LEFT JOIN orders ON customers.customer_id = orders.customer_id;

SELECT 
    customers.customer_id,
    customers.name,
    orders.order_id,
    orders.total_amount,
    orders.order_date
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id;












