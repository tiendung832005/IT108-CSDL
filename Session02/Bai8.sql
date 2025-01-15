-- Bai 8
create table point(
	poi_id varchar(20) primary key not null,
    poi_name int not null,
    constraint check_poi_name check (poi_name between 0 and 10)
);