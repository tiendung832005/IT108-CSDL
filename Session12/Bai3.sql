create table deleted_orders (
    deleted_id int auto_increment primary key,
    order_id int not null,
    customer_name varchar(100) not null,
    product varchar(100) not null,
    order_date date not null,
    deleted_at datetime not null
);

DELIMITER $$
create trigger after_order_delete
after delete on orders
for each row
begin
    insert into deleted_orders (order_id, customer_name, product, quantity, price, order_date)
    values (old.order_id, old.customer_name, old.product, old.quantity, old.price, old.order_date);
end $$
DELIMITER &&;

delete from orders where order_id = 4;

delete from orders where order_id = 5;

select * from deleted_orders;

