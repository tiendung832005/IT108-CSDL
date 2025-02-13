DELIMITER &&
	create procedure getlanguage(in language char(30))
    begin
		select countrycode, language, Percentage from countrylanguage 
        where language = language AND Percentage > 50;
    end &&
DELIMITER &&

call getlanguage('USA');

drop procedure if exists getlanguage;