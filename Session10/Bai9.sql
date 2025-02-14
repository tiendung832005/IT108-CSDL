create view CountryLanguageView AS
select 
    c.Code as CountryCode,
    c.Name as CountryName,
    cl.Language,
    cl.IsOfficial
from countries c
join countrylanguage cl on c.Code = cl.CountryCode
where cl.IsOfficial = 'T';

select * from CountryLanguageView;

DELIMITER &&
create procedure GetLargeCitiesWithEnglish()
begin
    select 
        ci.Name as CityName,
        c.Name as CountryName,
        ci.Population
    from cities ci
    join countries c on ci.CountryCode = c.Code
    join countrylanguage cl on c.Code = cl.CountryCode
    where cl.Language = 'English' and cl.IsOfficial = 'T' 
        and ci.Population > 1000000
    order by ci.Population desc
    limit 20;
end &&
DELIMITER &&;

call GetLargeCitiesWithEnglish();

drop procedure if exists GetLargeCitiesWithEnglish;

