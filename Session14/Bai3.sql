DELIMITER &&
create procedure sp_create_order(
    in customer_id int, 
    in product_id int, 
    in quantity int, 
    in price decimal(10,2)
)
begin
    declare stock_quantity int;

    start transaction;

    select stock_quantity into stock_quantity
    from inventory
    where product_id = product_id;

    if stock_quantity < quantity then
        rollback;
        signal sqlstate '45000' SET MESSAGE_TEXT = 'Không đủ hàng trong kho!';
    else
        
        insert into orders (customer_id, total_amount, status) 
        values (customer_id, 0, 'Pending');
        
        set @order_id = LAST_INSERT_ID();

        insert into order_items (order_id, product_id, quantity, price) 
        values (@order_id, product_id, quantity, price);

        update inventory 
        set stock_quantity = stock_quantity - quantity 
        where product_id = product_id;

        update orders 
        set total_amount = (select sum(quantity * price) 
                            from order_items 
                            where order_id = @order_id)
        where order_id = @order_id;

        commit;
    end if;
end &&;
DELIMITER &&;

delimiter &&
create procedure sp_cancel_order(
    in order_id int, 
    in payment_method varchar(20)
)
begin
    declare order_status varchar(20);
    declare total_amount decimal(10,2);

    start transaction;

    select status, total_amount into order_status, total_amount
    from orders
    where order_id = order_id;

    if order_status <> 'pending' then
        rollback;
        signal sqlstate '45000' set message_text = 'chỉ có thể thanh toán đơn hàng ở trạng thái pending!';
    else
       
        insert into payments (order_id, payment_date, amount, payment_method, status) 
        values (order_id, now(), total_amount, payment_method, 'completed');

        
        update orders
        set status = 'completed'
        where order_id = order_id;

        
        commit;
    end if;
end &&;
delimiter &&;

delimiter &&

create procedure sp_cancel_order(
    in order_id int
)
begin
    declare order_status varchar(20);
    declare product_id int;
    declare quantity int;

 
    start transaction;

  
    select status into order_status
    from orders
    where order_id = order_id;

    
    if order_status <> 'pending' then
        rollback;
        signal sqlstate '45000' set message_text = 'chỉ có thể hủy đơn hàng ở trạng thái pending!';
    else
        declare inventory_cursor cursor for 
            select product_id, quantity
            from order_items
            where order_id = order_id;

        open inventory_cursor;

      
        fetch inventory_cursor into product_id, quantity;
        while found do
            update inventory
            set stock_quantity = stock_quantity + quantity
            where product_id = product_id;

            fetch inventory_cursor into product_id, quantity;
        end while;

        close inventory_cursor;

        
        delete from order_items
        where order_id = order_id;

       
        update orders
        set status = 'cancelled'
        where order_id = order_id;

	
        commit;
    end if ;
end &&;


delimiter &&;

drop procedure if exists sp_create_order;
drop procedure if exists sp_cancel_order;

