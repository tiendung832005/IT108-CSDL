create database session10;
use session10;

DELIMITER &&
	create procedure getcity(in country_code char(3))
    begin
		select id, name, population from city
        where CountryCode = country_code;
    end &&
DELIMITER &&

call getcity('USA');

drop procedure if exists getcity;
