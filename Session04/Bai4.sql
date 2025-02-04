create table category(
	category_id int primary key auto_increment,
    category_name varchar(50) not null,
    description text,
    status bit Not null (1 - active, 0 - Inactive)
);

create table film(
	film_id int primary key auto_increment,
    film_name Varchar(50)  not null,
    content text not null,
	duration time Not null (1 - Nam, 2 - Nữ),
    director varchar(50),
    release_date date not null,
);

create table category_film (
    category_id int not null,
    film_id int not null,
    PRIMARY KEY (category_id, film_id),
    FOREIGN KEY (category_id) REFERENCES category(category_id) ,
    FOREIGN KEY (film_id) REFERENCES film(film_id)
);


ALTER TABLE category_film 
ADD CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES category(category_id);

ALTER TABLE category_film 
ADD CONSTRAINT fk_film FOREIGN KEY (film_id) REFERENCES film(film_id);

ALTER TABLE film 
add column status tinyint not null default 1;

ALTER TABLE category 
drop column status;

ALTER TABLE category_film DROP FOREIGN KEY fk_category;
ALTER TABLE category_film DROP FOREIGN KEY fk_film;



