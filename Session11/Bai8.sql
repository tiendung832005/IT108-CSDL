use sakila;

create view view_long_action_movies as
select 
    f.film_id,
    f.title,
    f.description,
    f.length,
    c.name as category_name
from film f
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id
where c.name = 'Action' and f.length > 100;


create view view_texas_customers as
select 
    c.customer_id,
    c.first_name,
    c.last_name,
    ci.city
from customer c
join address a on c.address_id = a.address_id
join city ci on a.city_id = ci.city_id
join rental r on c.customer_id = r.customer_id
where ci.city = 'Texas'
group by c.customer_id, c.first_name, c.last_name, ci.city;



create view view_high_value_staff as
select 
    s.staff_id,
    s.first_name,
    s.last_name,
    sum(p.amount) as total_payment
from staff s
join payment p on s.staff_id = p.staff_id
group by s.staff_id, s.first_name, s.last_name
having total_payment > 100;



create fulltext index idx_film_title_description 
on film (title, description);


create index idx_rental_inventory_id 
on rental (inventory_id) using hash;


select * 
from view_long_action_movies 
where match(title, description) against('War' in natural language mode);

create index idx_rental_inventory_id 
on rental (inventory_id) using hash;

delimiter //
drop procedure if exists get_rental_by_inventory //
create procedure get_rental_by_inventory(in p_inventory_id int)
begin
    select rental_id, rental_date, inventory_id, customer_id, return_date, staff_id
    from rental
    where inventory_id = p_inventory_id;
end //
delimiter ;

call get_rental_by_inventory(5);




-- Xóa INDEX
drop index idx_film_title_description on film;
drop index idx_rental_inventory_id on rental;

-- Xóa VIEW
drop view if exists view_texas_customers;
drop view if exists view_high_value_staff;
drop view if exists view_long_action_movies;

drop procedure if exists GetRentalByInventory;