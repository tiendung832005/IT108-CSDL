select * from tbl_categories;

-- 1 Tạo procedure cho phép lấy ra tất cả danh mụcache index
DELIMITER &&
create procedure pro_find_all_categories()
begin 
	select * from tbl_categories where cat_priority;
end
DELIMITER &&

call pro_find_all_categories;
-- Xóa procedure pro_find_all_categories
drop procedure pro_find_all_categories;

-- 2. Viết procedure cho phép thêm mới 1 danh mục
DELIMITER &&
	create procedure pro_create_catalog(
		in name_in varchar(100),
        priority_in int,
        status_in bit 
    )
    begin 
		insert into tbl_categories(cat_name, cat_priority, )
        values(name_in, priorty_in, status_in);
    end
	create procedure pro_create_catalog(
		
        
    )
    begin
		update 
        where cat_id = id
    end
    
DELIMITER &&

-- 4 Viết procedure cho phép xóa 1 danh mục
DELIMITER &&
	create procedure pro_delete_catalog(
		
    )
DELIMITER &&

begin
	-- khai báo biến
		declare cnt_product int;
    -- set giá trị chi biến: 2 cách 
		

end