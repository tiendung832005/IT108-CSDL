EXPLAIN ANALYZE  
select orderNumber, orderDate, status  
from orders  
where year(orderDate) = 2003 and status = 'Shipped';

create index idx_orderDate_status  
on orders (orderDate, status);

EXPLAIN ANALYZE  
select customerNumber, customerName, phone  
from customers  
where phone = '2035552570';

create unique index idx_customerNumber  
on customers (customerNumber);
create unique index idx_phone  
on customers (phone);

EXPLAIN ANALYZE  
select customerNumber, customerName, phone  
from customers  
where phone = '2035552570';







