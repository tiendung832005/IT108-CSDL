create database cursor_loop_db;
use cursor_loop_db;

create table student(
	student_id int primary key auto_increment,
    student_name varchar(100),
    student_age int,
    student_status bit
);

create table student_log(
	st_log_id int primary key auto_increment,
    st_log_age int
);

CREATE TABLE transaction_log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    log_message TEXT
);

/*
	2. Demo sử dụng con trỏ cursor và vòng lặp loop 
    Viết procedure( không tham số) cho phép thêm tất cả
    sinh viên có trạng thái là 1
*/


DELIMITER &&
	create procedure pro_insert_student_log()
    begin
    -- 0. Khai báo các biến cần thiết sử dụng trong procedure
    declare isfinished bit default 0;
    declare st_id;
    declare st_age;
    -- 1. Khai báo cursor chứa tất cả các sinh viên có status = 0
    declare cursor_students cursor for 
		select student_id, student_age from student where 
    -- 2. Khai báo biến nhận biết kết thúc quá trình duyệt
    declare continue handler for not found set isFinished = 
    -- 3. Mở cursor 
    open cursor_students
    -- 4. Sử dụng loop duyệt dữ liệu cursor
    student_loop: loop
    -- fetch từng dữ liệu trong cursor đẩy ra biến 
    fetch cursor_students into st_id, st_age;
    if isFinished then
		-- thoát khỏi vòng lặp
        leave student_loop;
	end if
    end loop;
    insert into student_log(st_log_age)
    -- 5. Đóng cursor
    close
    end;
DELIMITER &&