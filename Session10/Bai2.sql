DELIMITER &&
	create procedure CalculatePopulation(in p_countryCode char(3), out total_population int)
	begin	
		select sum(population)
        into total_population
        from city
        WHERE CountryCode = p_countryCode;
    end &&
DELIMITER &&

call CalculatePopulation('USA', @total_population);
SELECT @total_population;

drop procedure if exists CalculatePopulation;
