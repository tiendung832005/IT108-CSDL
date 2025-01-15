/*
	Bài 3:
    Tạo bảng sản phẩm gồm các trường:
    - Mã sản phẩm: PK
    - Tên sản phẩm: varchar
    - GiaBan: DECIMAL
    - SoLuong: INT
*/

create table products(
	pro_id int primary key,
    pro_name varchar(100) not null,
    pro_price decimal not null,
    pro_quantity int
);