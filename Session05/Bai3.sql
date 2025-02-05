select customers.name, customers.phone, orders.order_id, orders.total_amount from orders 
join customers on orders.customer_id = customers.customer_id
where orders.status = 'Pending' and orders.total_amount > 300000;

select customers.name, customers.email, orders.order_id from orders
join customers on orders.customer_id = customers.customer_id
where orders.status = 'Completed' or orders.status IS NULL;

select customers.name, customers.address, orders.order_id, orders.status from orders 
join customers on orders.customer_id = customers.customer_id
where orders.status = 'Pending' or 'Cancelled';

select customers.name, customers.phone, orders.order_id, total_amount from orders
join customers on orders.customer_id = customers.customer_id
where 300000 < total_amount < 600000;



