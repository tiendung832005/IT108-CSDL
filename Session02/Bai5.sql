-- Bai5
create table customers(
	cus_id int primary key,
    cus_name varchar(255),
    cus_phone varchar(10) not null
);

create table orders(
	ord_id int primary key,
    ord_date date,
    ord_id1 int,
    foreign key (ord_id1) references customers(cus_id)
);