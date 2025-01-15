-- Bai7 
create table order_detail(
	ord_id int,
    ord_product int,
    ord_quantity int not null,
    primary key(ord_id, ord_product)
);

alter table order_detail
	add constraint fk_order_detail_orders
    foreign key (ord_id) references orders(ord_id);
    
alter table order_detail
	add constraint fk_order_detail_products
    foreign key (ord_product) references products(ord_product);
    
