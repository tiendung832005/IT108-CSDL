create database quanlybanhang;
use quanlybanhang;

create table customers(
	customer_id int primary key auto_increment,
    customer_name varchar(100) not null,
    phone varchar(20) not null unique,
    address varchar(255) 
);

create table products (
	product_id int primary key auto_increment,
    product_name varchar(100) not null unique,
    price decimal(10,2) not null,
    quantity int not null check (quantity >= 0),
    category varchar(50) not null
);

create table employees (
	employee_id int primary key auto_increment,
    employee_name varchar(100) not null,
    birthday date null,
    position varchar(50) not null,
	salary decimal(10,2) not null,
    revenue decimal(10,2) default(0)
);

create table Orders(
	order_id int primary key auto_increment,
    customer_id int,
    foreign key (customer_id) references Customers(customer_id),
    order_date datetime default(current_timestamp()),
    total_amount decimal(10,2) default(0)
);

ALTER TABLE Orders
ADD COLUMN employee_id INT,
ADD CONSTRAINT fk_employee
FOREIGN KEY (employee_id) REFERENCES Employees(employee_id);

create table OrderDetails(
	order_detail_id int primary key auto_increment,
    order_id int,
    foreign key (order_id) references Orders(order_id),
    product_id int,
    foreign key (product_id) references Products(product_id),
    quantity int not null check (quantity >= 0), 
    unit_price decimal(10,2) not null
);

alter table customers
add column email varchar(100) not null unique;

alter table employees 
drop column birthday;

insert into customers(customer_id, customer_name, phone, address, email)
values  (1, 'Nguyen Van A', '0912243606', 'Ha Noi', 'nva123@gmail.com'),
		(2, 'Nguyen Van B', '0999999213', 'HCM', 'nvb6543@gmail.com'),
        (3, 'Nguyen Van C', '0339615866', 'Da Nang', 'nvc12343@gmail.com'),
        (4, 'Nguyen Van D', '0976068368', 'Nha Trang', 'nvd9321@gmail.com'),
        (5, 'Nguyen Van E', '0987654322', 'Hai Phong', 'nve3213@gmail.com');
        
insert into products(product_id, product_name, price, quantity, category)
values  (1, 'IP 16 Pro', '20000000', 10, 'Dien thoai'),
		(2, 'Laptop Lenovo', '15000000', 8, 'Laptop'),
        (3, 'Vision 2025', '30000000', 5, 'Xe may'),
        (4, 'Nike Air', '2000000', 15, 'Giay'),
        (5, 'Ao bomber', '1500000', 20, 'Ao khoac');
        
insert into employees(employee_id, employee_name, position, salary, revenue)
values  (1, 'Tran Van A', 'Truong phong', '30000000', 0),
		(2, 'Tran Van B', 'Pho phong', '20000000', 0),
        (3, 'Tran Van C', 'Nhan Vien', '15000000', 0),
        (4, 'Tran Van D', 'Nhan Vien', '15000000', 0),
        (5, 'Tran Van E', 'Nhan Vien', '15000000', 0);

insert into Orders(order_id, customer_id, employee_id, order_date, total_amount)
values  (1, 1, 1, '2024-02-20', '500000'),
		(2, 2, 2, '2024-01-12', '2000000'),
        (3, 3, 3, '2024-01-10', '1000000'),
        (4, 4, 4, '2024-01-08', '2000000'),
        (5, 5, 5, '2024-01-05', '2000000');

insert into OrderDetails(order_detail_id, order_id, product_id, quantity, unit_price) 
values  (1, 1, 1, 3, '2000000'),    
		(2, 2, 2, 1, '1500000'),   
        (3, 3, 3, 2, '2000000'),   
        (4, 4, 4, 1, '20000000'),   
        (5, 5, 5, 1, '2000000');
      
-- 5.1      
select customer_id, customer_name, email, phone, address from customers;

-- 5.2
update products set product_name = 'Laptop Dell XPS', price = '99.99' where product_id = 1;

-- 5.3        
select o.order_id, c.customer_name, e.employee_name, o.order_date, o.total_amount 
from orders o
join customers c on o.customer_id = c.customer_id
join employees e on o.employee_id = e.employee_id;

-- 6.1
select c.customer_id, c.customer_name, count(o.order_id)
from customers c
left join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name;

-- 6.2
select e.employee_id, e.employee_name, sum(o.total_amount)
from employees e
left join orders o on e.employee_id = o.employee_id
where year(o.order_date) = year(CURDATE())
group by e.employee_id, e.employee_name;

-- 6.3
select p.product_id, p.product_name, sum(od.quantity)
from orderdetails od
join products p on od. product_id = p.product_id
join orders o on od.order_id = o.order_id
where month(o.order_date) = month(curdate())
	and year(o.order_date) = year(curdate())
group by p.product_id, p.product_name
having sum(od.quantity) > 100
order by sum(od.quantity) desc;

-- 7.1 
select o.customer_id, c.customer_name from orders o
left join customers c on c.customer_id = o.customer_id
where o.customer_id is null;

-- 7.2 
select * from products
where price > (select avg(price) from products);

-- 7.3 
select customer_id, customer_name, total_spent from 
(select o.customer_id, c.customer_name, sum(o.total_amount) as total_spent from orders o
    join customers c on c.customer_id = o.customer_id
    group by o.customer_id
) as spending
where total_spent = (select max(total_spent) from (select sum(o.total_amount) as total_spent from orders o
group by o.customer_id) as max_spending
);

-- 8.1 
create view view_order_list as
select o.order_id, c.customer_name, e.employee_name, o.total_amount, o.order_date
from orders o
join customers c on o.customer_id = c.customer_id
join employees e on o.employee_id = e.employee_id
order by o.order_date desc;

-- 8.2 
create view view_order_detail_product as
select od.order_detail_id, p.product_name, od.quantity, od.price_at_purchase
from order_details od
join products p on od.product_id = p.product_id
order by od.quantity desc;

-- 9.1
delimiter &&
create procedure proc_insert_employee(in p_employee_name varchar(255), in p_position varchar(100), in p_salary decimal(10,2))
begin
    insert into employees (employee_name, position, salary) 
    values (p_employee_name, p_position, p_salary);
    select last_insert_id() as new_employee_id;
end &&
delimiter ;

-- 9.2.
delimiter &&
create procedure proc_get_orderdetails(in p_order_id int)
begin
    select * from order_details
    where order_id = p_order_id;
end &&
delimiter ;

-- 9.3 
delimiter &&
create procedure proc_cal_total_amount_by_order(in p_order_id int, out p_total_products int)
begin
    select count(distinct product_id) into p_total_products
    from order_details
    where order_id = p_order_id;
end &&
delimiter &&;


delimiter &&
create trigger trigger_after_insert_order_details
after insert on order_details
for each row
begin
    declare available_stock int;
    select stock into available_stock
    from products
    where product_id = new.product_id;
    if available_stock < new.quantity then
        signal sqlstate '45000'
        set message_text = 'Số lượng sản phẩm trong kho không đủ';
    else
        update products
        set stock = stock - new.quantity
        where product_id = new.product_id;
    end if;
end &&
delimiter &&;

-- 
delimiter &&
create procedure proc_insert_order_details(in p_order_id int, in p_product_id int, in p_quantity int, in p_price decimal(10,2))
begin
    declare order_exists int;
    start transaction;
    select count(*) into order_exists from orders where order_id = p_order_id;
    if order_exists = 0 then
        signal sqlstate '45000'
        set message_text = 'không tồn tại mã hóa đơn';
    end if;
    insert into order_details (order_id, product_id, quantity, price_at_purchase)
    values (p_order_id, p_product_id, p_quantity, p_price);

    update orders
    set total_amount = (
        select sum(quantity * price_at_purchase)
        from order_details
        where order_id = p_order_id)
    where order_id = p_order_id;
    commit;
end &&
delimiter &&;