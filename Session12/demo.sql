create database session12;
use session12;

create table tbl_users(
	user_id int primary key auto_increment,
    user_name varchar(100) not null unique,
    user_password varchar(100) not null,
    user_email varchar(100) not null unique,
    user_created date default (current_date),
    user_status enum('active', 'block', 'deleted')
);

create table tbl_user_log(
	user_name varchar(100) not null unique,
    user_password varchar(100) not null,
    user_email varchar(100) not null unique,
    user_log_created date default (current_date()),
    user_action enum ('created', 'updated', 'deleted')
);

-- 1. Cài đặt ghi log cho sự kiện thêm mới 1 user 
DELIMITER &&
create trigger trg_after_insert after insert on tbl_users for each row
begin
	insert into tbl_users_log(user_name, user_password, user_email)
    values(new.user_name, new.user_password, new.user_email, 'Created');
end &&
DELIMITER &&;

insert into tbl_users(user_name, user_password, user_email,user_status)
values ('ttdung', '1234456', 'ttdung@gmail.com', 'active');

-- 2. Chặn cập nhật email trên bảng tbl_users
DELIMITER &&
create trigger trg_before_update
before update on tbl_users for each row
begin
	-- 1. Lay email tu bang NEW
    declare email varchar(100);
    select new.user_email into email;
    -- 2. Kiem tra email co bi null khong --> null chan
	if email is not null then
		signal sqlstate '45000'
        set message_text = 'Không thể cập nhật email';
    end if;
end &&
DELIMITER &&;

update tbl_users 
	set user_status = 'blocked'
    where user_id = 1;
    
-- 2. Chặn cập nhật bảng email
drop 

-- 3 viết trigger khi xóa dữ liệu
DELIMITER &&
create trigger trg_before_delete
before delete on tbl_users for each row
begin
	-- 1 Cập nhật trạng thái tbl_users thành deleted
    update tbl_users
		set user_status = 'deleted'
        where user_id = new.user_id;
    -- 2. Ghi log bảng tbl_users_log
    insert into tbl_users_log(user_name, user_password, user_email, user_status)
    values (old.user_name, old.user_password, old.user_email, old.user_status);
    -- 3. chặn hành động delete
    signal sqlstate '45000'
    set message_text = 'Delete thành công'; 
end &&
DELIMITER &&;

delete from tbl_users where user_id = 1;