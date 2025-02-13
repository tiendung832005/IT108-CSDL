DELIMITER &&
create procedure GetLargeCitiesByCountry(in country_code varchar(10))
begin
    -- Truy vấn danh sách các thành phố có dân số lớn hơn 1 triệu thuộc quốc gia đó
    select CityID, Name as CityName, Population
    from cities
    where CountryCode = country_code and Population > 1000000
    order by Population desc;
end &&
DELIMITER &&

call GetLargeCitiesByCountry('USA');

drop procedure if exists GetLargeCitiesByCountry;
