create view OfficialLanguageView as 
select c.Code as CountryCode, c.Name as CountryName, l.Language from country c
join countrylanguage l on l.CountryCode = c.code
where IsOfficial = 'T' ;

select * from OfficialLanguageView;

create index idx_city_name on city(name);

delimiter &&
create procedure GetSpecialCountriesAndCities(in language_name char(30))
begin 
	select v.CountryName, c.name as CityName, c.Population as CityPopulation, 
        (select sum(c2.Population) 
         from city c2 
         join OfficialLanguageView v2 on c2.CountryCode = v2.CountryCode
         where v2.language = language_name and v2.CountryName = v.CountryName
        ) as TotalPopulation
	from OfficialLanguageView v
    join city c on c.CountryCode = v.CountryCode
    where v.language = language_name and c.name like 'New%'
    group by v.CountryName, c.name, c.Population
    having TotalPopulation > 5000000
    order by TotalPopulation desc
    limit 10;
end &&
delimiter &&;



call GetSpecialCountriesAndCities('English');

drop procedure if exists GetSpecialCountriesAndCities;