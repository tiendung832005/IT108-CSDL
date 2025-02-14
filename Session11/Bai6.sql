create view view_film_category as
select f.film_id,f.title,c.name as category_name
from film f
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id;
drop view if exists  view_film_category;

create view view_high_value_customers as
select c.customer_id,c.first_name,c.last_name,SUM(p.amount) as total_payment
from customer c
join payment p on c.customer_id = p.customer_id
group by c.customer_id, c.first_name, c.last_name
having total_payment > 100;
drop view if exists  view_high_value_customers;

create index idx_rental_rental_date on rental(rental_date);
select * from rental 
where date(rental_date) = '2005-06-14';
explain select * from rental 
where date(rental_date) = '2005-06-14';
explain select * from rental where rental_date >= '2005-06-14 00:00:00' and rental_date < '2005-06-15 00:00:00';
drop index idx_rental_rental_date on rental;


DELIMITER &&
create procedure CountCustomerRentals(in customer_id int, out rental_count int)
begin
    select count(*) into rental_count from rental
    where rental.customer_id = customer_id;
end &&
DELIMITER &&;
drop procedure if exists CountCustomerRentals;

DELIMITER &&
create procedure GetCustomerEmail(
    in customer_id int,
    out customer_email varchar(50)
)
begin
    select email 
    into customer_email
    from customer
    where customer_id = customer_id;
end &&
DELIMITER &&;
drop procedure if exists GetCustomerEmail;



