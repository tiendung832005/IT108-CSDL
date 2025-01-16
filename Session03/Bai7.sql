create table student2(
	student_id int primary key auto_increment,
    student_name varchar(255) not null,
	email varchar(255) not null unique,
    date_of_birh date not null,
    gender enum('Male', 'Female', 'Other') not null,
    gpa decimal(3, 2) check(gpa >= 0 and gpa <= 4)
);

INSERT INTO Student2 (student_name, email, date_of_birh, gender, gpa)
VALUES
('Nguyen Van A', 'nguyenvana@example.com', '2000-05-15', 'Male', 3.50),
('Tran Thi B', 'tranthib@example.com', '1999-08-22', 'Female', 3.80),
('Le Van C', 'levanc@example.com', '2001-01-10', 'Male', 2.70),
('Pham Thi D', 'phamthid@example.com', '1998-12-05', 'Female', 3.00),
('Hoang Van E', 'hoangvane@example.com', '2000-03-18', 'Male', 3.60),
('Do Thi F', 'dothif@example.com', '2001-07-25', 'Female', 4.00),
('Vo Van G', 'vovang@example.com', '2000-11-30', 'Male', 3.20),
('Nguyen Thi H', 'nguyenthih@example.com', '1999-09-15', 'Female', 2.90),
('Bui Van I', 'buivani@example.com', '2002-02-28', 'Male', 3.40),
('Tran Thi J', 'tranthij@example.com', '2001-06-12', 'Female', 3.75);

select * from student2 where gpa > 3.0 and gender = 'Female';
select * from student2 where date_of_birh > '2000 01-01' order by gpa desc;
select * from student2 where date_of_birh = (
	select date_of_birh from student2 where student_id = 1
);
update student2 set gpa = least(gpa + 0.5, 4.0) where gpa < 2.5;
update student2 set gender = 'Other' where email like 'test';
delete from student2 where date_of_birh = (select min(date_of_birh) from student2);