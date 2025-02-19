DELIMITER &&
create trigger before_insert_check_payment
before insert on payments
for each row
begin
    declare order_total decimal(10,2);
    select total_amount into order_total
    from orders
    where order_id = new.order_id;
    if new.amount < order_total then
        signal sqlstate '45000' set message_text = 'số tiền thanh toán không khớp với tổng đơn hàng!';
    end if;
end &&
DELIMITER &&;

CREATE TABLE order_logs (

    log_id INT PRIMARY KEY AUTO_INCREMENT,

    order_id INT NOT NULL,

    old_status ENUM('Pending', 'Completed', 'Cancelled'),

    new_status ENUM('Pending', 'Completed', 'Cancelled'),

    log_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE

);

DELIMITER &&
create trigger after_update_order_status
after update on orders
for each row
begin
    if old.status <> new.status then
        insert into order_logs (order_id, old_status, new_status, log_date)
        values (new.order_id, old.status, new.status, now());
    end if;
end &&
DELIMITER &&;

DELIMITER &&
create procedure sp_update_order_status_with_payment(
    in order_id int,
    in new_status enum('Pending', 'Completed', 'Cancelled'),
    in amount decimal(10,2),
    in payment_method varchar(20)
)
begin
    declare current_status enum('Pending', 'Completed', 'Cancelled');
    START TRANSACTION;
    select status into current_status
    from orders
    where order_id = order_id;
    if current_status = new_status then
        rollback;
        signal sqlstate '45000' set message_text = 'đơn hàng đã có trạng thái này!';
    else
        if new_status = 'Completed' then
            insert into payments (order_id, payment_date, amount, payment_method, status)
            values (order_id, now(), amount, payment_method, 'Completed');
        end if;
        update orders
        set status = new_status
        where order_id = order_id;
        commit;
    end if;
end &&
DELIMITER &&;


insert into customers (name, email, phone, address) 
values ('Nguyễn Văn A', 'nguyenvana@example.com', '0123456789', 'Hà Nội');

insert into products (name, price, description) 
values ('Laptop Dell', 15000000, 'Laptop cao cấp');

insert into inventory (product_id, stock_quantity) 
values (1, 10);

insert into orders (customer_id, order_date, total_amount, status)
values (1, now(), 15000000, 'Pending');

insert into order_items (order_id, product_id, quantity, price)
values (1, 1, 1, 15000000);

call sp_update_order_status_with_payment(1, 'Completed', 15000000, 'Credit Card');
 
select * from order_logs;

drop trigger if exists before_insert_check_payment;
drop trigger if exists after_update_order_status;
drop procedure if exists sp_update_order_status_with_payment;