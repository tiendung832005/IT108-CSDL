create database session07;
use session07;

create table categories(
	category_id int,
    category_name varchar(255)
);

create table Books(
	book_id int,
    title varchar(255),
    author varchar(255),
    pubication_year int,
    available_quantity int,
    category_id int,
    foreign key (category_id) references categories(category_id)
);

create table Readers(
	reader_id int ,
    name varchar(255),
    phone_number varchar(15),
    email varchar(255)
);

create table Borrowing (
	borrow_id int,
    reader_id int,
	book_id int,
    foreign key (reader_id) references Readers(reader_id),
    foreign key (book_id) references Books(book_id),
    borrow_date date,
    due_date date
);

create table Returning (
	return_id int,
    borrow_id int,
    foreign key (borrow_id) references Borrowing(borrow_id),
    return_date date
);

create table Fines (
	fine_id int,
    return_id int,
    foreign key (return_id) references Returning(return_id),
    fine_amount decimal(10,2)
);
DELETE FROM Categories;


-- Thêm danh mục sách
INSERT INTO categories (category_name) VALUES 
('Science Fiction'), 
('History');

-- Thêm sách
INSERT INTO Books (title, author, pubication_year, available_quantity, category_id) VALUES 
('Dune', 'Frank Herbert', 1965, 5, 1), 
('Sapiens', 'Yuval Noah Harari', 2011, 3, 2);

-- Thêm độc giả
INSERT INTO Readers (name, phone_number, email) VALUES 
('Nguyen Van A', '0123456789', 'a@example.com'), 
('Tran Thi B', '0987654321', 'b@example.com');

-- Thêm giao dịch mượn sách
INSERT INTO Borrowing (reader_id, book_id, borrow_date, due_date) VALUES 
(1, 1, '2024-02-01', '2024-02-15'), 
(2, 2, '2024-02-02', '2024-02-16');

-- Thêm giao dịch trả sách
INSERT INTO Returning (borrow_id, return_date) VALUES 
(1, '2024-02-14'), 
(2, '2024-02-18');

-- Thêm tiền phạt
INSERT INTO Fines (return_id, fine_amount) VALUES 
(1, 0.00), 
(2, 5000.00);

update readers set email = 'nguyenvana@gamil.com' where name = 'Nguyen Van A';

delete from books where title = 'Dune';






