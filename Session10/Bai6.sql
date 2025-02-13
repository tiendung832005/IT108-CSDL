DELIMITER &&
CREATE PROCEDURE GetCountriesWithLargeCities()
begin
    -- Truy vấn các quốc gia có tổng dân số thành phố lớn hơn 10 triệu thuộc lục địa 'Asia'
    select 
        c.Name as CountryName, 
        sum(ci.Population) as TotalPopulation
    from countries c
    join cities ci on c.Code = ci.CountryCode
    where c.Continent = 'Asia'
    group by c.Name
    having TotalPopulation > 10000000
    order by TotalPopulation desc;
end &&
DELIMITER &&;

call GetCountriesWithLargeCities();

drop procedure if exists GetCountriesWithLargeCities;
