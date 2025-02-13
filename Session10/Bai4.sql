DELIMITER &&
create procedure UpdateCityPopulation(inout city_id int, in new_population int
)
begin
    update cities 
    set Population = new_population 
    where CityID = city_id;

    select CityID, Name, Population 
    from cities 
    where CityID = city_id;
end &&
DELIMITER &&

set @city_id = 5;  
call UpdateCityPopulation(@city_id, 1200000);
drop procedure if exists UpdateCityPopulation;
