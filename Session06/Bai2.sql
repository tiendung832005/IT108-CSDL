select customername, productname, sum(quantity) as 'TotalQuantity' from orders
group by customername, productname
having sum(quantity) > 1;

select customername, orderdate, sum(quantity) from orders
group by customername, orderdate
having sum(quantity) > 2;

select customername, orderdate, sum(quantity * price) as 'TotalSpent' from orders
group by customername, orderdate
having sum(quantity * price) > 20000000;
