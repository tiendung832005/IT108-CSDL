use chinook;

create view view_high_value_customers as
select 
    c.customerid,
    concat(c.firstname, ' ', c.lastname) as fullname,
    c.email,
    sum(i.total) as total_spending
from customer c
join invoice i on c.customerid = i.customerid
where i.invoicedate >= '2010-01-01'
and c.country <> 'Brazil'
group by c.customerid, c.firstname, c.lastname, c.email
having sum(i.total) > 200;


create view view_popular_tracks as
select 
    t.trackid,
    t.name as track_name,
    sum(il.quantity) as total_sales
from track t
join invoiceline il on t.trackid = il.trackid
where t.unitprice > 1.00
group by t.trackid, t.name
having sum(il.quantity) > 15;


create index idx_customer_country 
on customer (country) using hash;

explain select * from customer 
where country = 'Canada';

create fulltext index idx_track_name_ft 
on track (name);

explain select * from track 
where match(name) against('Love' in natural language mode);



explain
select v.customerid, v.fullname, v.email, v.total_spending, c.country 
from view_high_value_customers v
join customer c use index (idx_customer_country) 
on v.customerid = c.customerid
where v.total_spending > 200 and c.country = 'Canada';

select t.trackid, t.name as track_name, t.unitprice, vpt.total_sales
from view_popular_tracks vpt
join track t on vpt.trackid = t.trackid
where vpt.total_sales > 15
and match(t.name) against ('love' in natural language mode);

delimiter //

drop procedure if exists GetHighValueCustomersByCountry //
create procedure GetHighValueCustomersByCountry (in p_Country varchar(50))
begin
    select vhvc.customerid, vhvc.fullname, vhvc.total_spending, c.country
    from view_high_value_customers vhvc
    join customer c on vhvc.customerid = c.customerid
    where vhvc.total_spending > 200
    and c.country = p_Country;
end //

delimiter ;

call GetHighValueCustomersByCountry('Canada');

explain select vhvc.customerid, vhvc.fullname, vhvc.total_spending, c.country
from view_high_value_customers vhvc
join customer c on vhvc.customerid = c.customerid
where vhvc.total_spending > 200
and c.country = 'Canada';


delimiter //

drop procedure if exists updatecustomerspending //
create procedure updatecustomerspending (
    in p_customerid int,
    in p_amount decimal(10,2)
)
begin
    update invoice
    set total = total + p_amount
    where customerid = p_customerid
    order by invoicedate desc
    limit 1;
end //

delimiter ;

call updatecustomerspending(5, 50.00);

select * from view_high_value_customers where customerid = 5;

drop view if exists view_high_value_customers;
drop view if exists view_popular_tracks;

drop index idx_customer_country on customer;
drop index idx_track_name_ft on track;

drop procedure if exists gethighvaluecustomersbycountry;
drop procedure if exists updatecustomerspending;