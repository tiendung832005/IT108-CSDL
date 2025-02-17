create table budget_warnings (
    warning_id int auto_increment primary key,
    project_id int not null,
    warning_message varchar(255) not null
);

DELIMITER &&
create trigger after_update_total_salary
after update on projects
for each row
begin
    -- kiểm tra nếu tổng lương mới vượt quá ngân sách
    if new.total_salary > new.budget then
        -- kiểm tra xem cảnh báo đã tồn tại hay chưa
        if not exists (
            select 1 from budget_warnings 
            where project_id = new.project_id
        ) then
            -- thêm cảnh báo nếu chưa có
            insert into budget_warnings (project_id, warning_message)
            values (new.project_id, 'budget exceeded due to high salary');
        end if;
    end if;
end &&;
DELIMITER &&;

create table ProjectOverview (
	project_id int,
    project_name varchar(100),
    budget decimal(15,2),
    total_salary decimal(15,2),
    warning_message varchar(255)
);

INSERT INTO workers (name, project_id, salary) VALUES ('Michael', 1, 6000.00);

INSERT INTO workers (name, project_id, salary) VALUES ('Sarah', 2, 10000.00);

INSERT INTO workers (name, project_id, salary) VALUES ('David', 3, 1000.00);

select * from budget_warnings;

select * from ProjectOverview;
