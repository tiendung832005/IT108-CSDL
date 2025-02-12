create index idx_productLine on products(productLine);

create view view_total_sales as
select productLine, sum(quantityOrdered * priceEach) as total_sales, sum(quantityOrdered) as total_quantity
from orderdetails
join products p on orderdetails.productCode = p.productCode
group by productLine;
