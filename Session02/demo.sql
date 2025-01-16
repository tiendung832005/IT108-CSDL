/*
	Lưu ý:
    1. K phân biệt hoa thường
    2. Để kết thúc câu lệnh bắt buộc sử dụng;
    3. Comment 1 dong --, nhiều dòng 
    4. đặt tên kiểu snake _
*/  
-- 1. Tạo CSDL có tên là KS23B_Database
create database KS23B_database;

-- 2. Xóa CSDL có tên là KS23B_Database
drop database ks23b_database;

-- 3. Lựa chọn CSDL có tên KS23B_database
use ks23b_database;

/*
	ER -TABLE
    1 thực thể = 1 colums
	- Cú pháp tạo bảng:
	CREATE TABLE [table_name](
		-- Khai báo các cột trong bảng
        [column_name] datatype constraints,
    )
*/ 

/* 4. Tạo bảng danh mục sản phẩm gồm các trường: MÃ DANH MỤC, TÊN DANH MỤC, MÔ TẢ, ĐỘ ƯU TIÊN
- Mã danh mục: PK
- Tên danh mục: duy nhất, bắt buộc nhập
- Mô tả danh mục: text
- Độ ưu tiên danh mục: int
- Trạng thái danh mục: bit mặc định là 1
 */
 create table Categories(
	cat_id int primary key auto_increment,
    cat_name varchar(100) unique not null,
    cat_description text,
    cat_priority int,
    cat_status bit default(1)
);

-- 6. Xóa bảng categories
drop table categories;
-- 7. Xóa bảng product;
drop table products;

-- 8. Thêm cột ngày tạo vào bảng categories
alter table categories;

-- 9. SỬa tên cột cat_created thành catalog_created
alter table categories
	rename column cat_created to catalog_created;
-- 10. Thay đổi kiểu dữ liệu của cột catalog_created
alter table categories
	modify column catalog_created varchar(100);
