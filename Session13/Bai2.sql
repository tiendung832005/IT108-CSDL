CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(50),
    price DECIMAL(10,2),
    stock INT NOT NULL
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    quantity INT NOT NULL,
    total_price DECIMAL(10,2),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO products (product_name, price, stock) VALUES
('Laptop Dell', 1500.00, 10),
('iPhone 13', 1200.00, 8),
('Samsung TV', 800.00, 5),
('AirPods Pro', 250.00, 20),
('MacBook Air', 1300.00, 7);

DELIMITER &&
create procedure PlaceOrder(
    in p_product_id int,
    in p_quantity int
)
begin
    declare v_stock int;
    declare v_price decimal(10,2);
    declare v_total_price decimal(10,2);
    
    start transaction;

    select stock, price into v_stock, v_price 
    from products 
    where product_id = p_product_id;
    
    if v_stock < p_quantity then
        rollback;
        signal sqlstate '45000' SET MESSAGE_TEXT = 'Not enough stock available';
    else
        set v_total_price = v_price * p_quantity;
        
        
        insert into orders (product_id, quantity, total_price) 
        values (p_product_id, p_quantity, v_total_price);
        
        
        update products 
        set stock = stock - p_quantity 
        where product_id = p_product_id;
        
        
        commit;
	end if;
end &&
DELIMITER &&;

CALL TransferMoney(1, 2, 200.00);
