create table Customer(
	customer_id int primary key auto_increment,
    customer_name varchar(50) not null,
    birthday date not null,
    sex bit not null,
    job varchar(50),
    phone_number char(11) not null unique,
    email varchar(100) not null unique,
    address varchar(255) not null
);

INSERT INTO Customer (customer_name, birthday, sex, job, phone_number, email, address) 
VALUES
('Nguyen Van A', '1990-05-15', 1, 'Engineer', '09123456789', 'nguyenvana@example.com', 'HCM'),
('Tran Thi B', '1995-03-10', 0, 'Teacher', '09321234567', 'tranthib@example.com', 'Ha Noi'),
('Le Van C', '1988-07-20', 1, 'Doctor', '09876543210', 'levanc@example.com', 'Da Nang'),
('Pham Thi D', '1992-12-25', 0, 'Designer', '09455667788', 'phamthid@example.com', 'Ha Nam'),
('Hoang Van E', '1993-11-15', 1, 'Accountant', '09223344556', 'hoangvane@example.com', 'Cao Bang'),
('Vu Thi F', '1998-01-05', 0, 'Developer', '09661234567', 'vuthif@example.com', 'Lang Son'),
('Dang Van G', '1985-06-22', 1, 'Mechanic', '09551122334', 'dangvang@example.com', 'Can Tho'),
('Nguyen Thi H', '1997-09-18', 0, 'Nurse', '09779988991', 'nguyenthih@example.com', 'Ha Noi'),
('Bui Van I', '1991-04-10', 1, 'Salesperson', '09881112233', 'buivani@example.com', 'Ho Chi Minh'),
('Dao Thi K', '1996-08-30', 0, 'Photographer', '09334455667', 'daothik@example.com', 'Hai Phong');

update Customer set customer_name = 'Nguyễn Quang Nhật', birthday = '11/01/2004' where customer_id = 1;
delete from customer where month(birth) = 8;
select customer_id, customer_name, birthday, sex, phone_number from customer where birthday > '2000/01/01';
select * from customer where job is null;

