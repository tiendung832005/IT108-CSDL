DELIMITER &&
create procedure GetCountriesByCityNames()
begin
    -- Truy vấn danh sách các quốc gia có thành phố bắt đầu bằng 'A', có ngôn ngữ chính thức và tổng dân số thành phố > 2 triệu
    select 
        c.Name as CountryName, 
        cl.Language as OfficialLanguage, 
        SUM(ci.Population) as TotalPopulation
    from countries c
    join countrylanguage cl on c.Code = cl.CountryCode
    join cities ci ON c.Code = ci.CountryCode
    where ci.Name like 'A%' 
        and cl.IsOfficial = 'T'
    group by c.Name, cl.Language
    having TotalPopulation > 2000000
	order by CountryName asc;
end &&
DELIMITER &&;

call GetCountriesByCityNames();

drop procedure if exists GetCountriesByCityNames;

