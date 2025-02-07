select  min(price) as 'MinPrice', max(price) as 'MaxPrice' from orders;

select customername, count(quantity) as 'OrderCount' from orders
group by customername;

select min(orderdate) as 'EarliestDate', max(orderdate) as 'LatestDate' from orders;
