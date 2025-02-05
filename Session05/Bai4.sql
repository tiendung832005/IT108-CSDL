
select category, product_name, price from products
order by category, price desc
limit 3 offset 3;

select product_name, category, price, stock_quantity from products
order by product_id
limit 2 offset 2;

select product_name, category, price, stock_quantity from products
where category = 'Electronics'
order by price desc;

select product_name, category, price, stock_quantity from products
where category = 'Clothing'
order by price asc
limit 1;


