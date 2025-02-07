CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15)
);

-- Tạo bảng courses
CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    duration INT NOT NULL,
    fee DECIMAL(10, 2) NOT NULL
);

-- Tạo bảng enrollments
CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
-- Thêm bản ghi vào bảng students
INSERT INTO students (name, email, phone)
VALUES
('Nguyen Van An', 'nguyenvanan@example.com', '0901234567'),
('Tran Thi Bich', 'tranthibich@example.com', '0912345678'),
('Le Van Cuong', 'levancuong@example.com', '0923456789'),
('Pham Minh Hoang', 'phamminhhoang@example.com', '0934567890'),
('Do Thi Ha', 'dothiha@example.com', '0945678901'),
('Hoang Quang Huy', 'hoangquanghuy@example.com', '0956789012');

-- Thêm bản ghi vào bảng cources
INSERT INTO courses (course_name, duration, fee)
VALUES
('Python Basics', 30, 300000),
('Web Development', 50, 1000000),
('Data Science', 40, 1500000);

-- Thêm bản ghi vào bảng enrollments
INSERT INTO enrollments (student_id, course_id, enrollment_date)
VALUES
(1, 1, '2025-01-10'), 
(2, 2, '2025-01-11'), 
(3, 3, '2025-01-12'), 
(4, 1, '2025-01-13'), 
(5, 2, '2025-01-14'), 
(6, 2, '2025-01-10'), 
(2, 3, '2025-01-17'), 
(3, 1, '2025-01-11'), 
(4, 3, '2025-01-19'); 

select 
    s.student_id,
    s.name AS student_name,
    s.email,
    sum(c.fee) AS total_fee,
    count(e.course_id) AS total_courses
from enrollments e
join students s on e.student_id = s.student_id
join courses c on e.course_id = c.course_id
group by s.student_id, s.name, s.email
having count(e.course_id) > 1
order by total_fee desc
limit 5;

select 
    s.student_id,
    s.name as student_name,
    (select c.course_name from courses c where c.course_id = e.course_id) as course_name,
    (select c.fee from courses c where c.course_id = e.course_id) as fee,
    (case 
        when (select c.fee from courses c where c.course_id = e.course_id) < 500000 then 'Low'
        when (select c.fee from courses c where c.course_id = e.course_id) between 500000 and 1000000 then 'Medium'
        else 'High'end) 
        as fee_category,
    e.enrollment_date
from enrollments e
join students s on e.student_id = s.student_id
group by s.student_id, s.name, e.course_id, e.enrollment_date
having fee_category is not null
order by fee_category asc, student_name asc;

select 
    c.course_name,
    c.fee,
    count(e.student_id) as total_students,
    sum(c.fee) as total_revenue
from enrollments e
join courses c on e.course_id = c.course_id
group by c.course_id, c.course_name, c.fee
having count(e.student_id) > 1
order by total_students desc, total_revenue desc
limit 10;



