DELIMITER &&
CREATE PROCEDURE GetEnglishSpeakingCountriesWithCities(IN language VARCHAR(50))
begin
    -- Truy vấn danh sách 10 quốc gia đầu tiên sử dụng ngôn ngữ chính thức và có tổng dân số thành phố > 5 triệu
    select 
        c.Name as CountryName, 
        SUM(ci.Population) as TotalPopulation
    from countries c
    join countrylanguage cl on c.Code = cl.CountryCode
    join cities ci on c.Code = ci.CountryCode
    where cl.Language = language and cl.IsOfficial = 'T'
    group by c.Name
    having TotalPopulation > 5000000
    order by TotalPopulation desc
    limit 10;
end &&
DELIMITER &&;

call GetEnglishSpeakingCountriesWithCities('English');

drop procedure if exists GetEnglishSpeakingCountriesWithCities;

