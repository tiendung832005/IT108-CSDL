use sakila;

create unique index idx_unique_email on customer (email);

-- Chạy câu lệnh dưới đây và quan sát
INSERT INTO customer (store_id, first_name, last_name, email, address_id, active, create_date)
VALUES (1, 'Jane', 'Doe', 'johndoe@example.com', 6, 1, NOW());

delimiter //

drop procedure if exists CheckCustomerEmail //
create procedure CheckCustomerEmail(
    in email_input varchar(50),
    out exists_flag tinyint
)
begin
    select count(*) into exists_flag
    from customer
    where email = email_input;
    
    if exists_flag > 0 then
        set exists_flag = 1;
    else
        set exists_flag = 0;
    end if;
end //

delimiter ;


call CheckCustomerEmail('johndoe@example.com', @exists_flag);
select @exists_flag;


create index idx_rental_customer_id 
on rental(customer_id);


create view view_active_customer_rentals as
select 
    c.customer_id,
    concat(c.first_name, ' ', c.last_name) as full_name,
    r.rental_date,
    case 
        when r.return_date is not null then 'Returned'
        else 'Not Returned'
    end as status
from customer c
join rental r on c.customer_id = r.customer_id
where c.active = 1
and r.rental_date >= '2023-01-01'
and (r.return_date is null or r.return_date >= curdate() - interval 30 day);


create index idx_payment_customer_id 
on payment(customer_id);


create view view_customer_payments as
select 
    c.customer_id, 
    concat(c.first_name, ' ', c.last_name) as full_name, 
    sum(p.amount) as total_payment
from customer c
join payment p on c.customer_id = p.customer_id
where p.payment_date >= '2023-01-01'
group by c.customer_id, full_name
having total_payment > 100;

delimiter //

drop procedure if exists GetCustomerPaymentsByAmount //
create procedure GetCustomerPaymentsByAmount(
    in min_amount decimal(10,2), 
    in date_from date
)
begin
    select * 
    from view_customer_payments
    where total_payment >= min_amount 
          and customer_id in (
              select distinct p.customer_id
              from payment p
              where p.payment_date >= date_from
          );
end //

delimiter ;

drop view if exists view_active_customer_rentals;
drop view if exists view_customer_payments;

drop procedure if exists CheckCustomerEmail;
drop procedure if exists GetCustomerPaymentsByAmount;

drop index idx_unique_email on customer;
drop index idx_rental_customer_id on rental;
drop index idx_payment_customer_id on payment;