create table price_changes (
    change_id INT AUTO_INCREMENT PRIMARY KEY,
    product VARCHAR(100) NOT NULL,
    old_price DECIMAL(10, 2) NOT NULL,
    new_price DECIMAL(10, 2) NOT NULL
);

DELIMITER $$
create trigger after_order_price_update
after update on orders
for each row
begin
    if OLD.price <> NEW.price then
        insert into price_changes (product, old_price, new_price, change_date)
        value (NEW.product, OLD.price, NEW.price, curdate());
    end if;
end $$
DELIMITER ;

update orders 
set price = 1400.00 
where product = 'Laptop';

update orders 
set price = 800.00 
where product = 'Smartphone';

select * from price_changes;

