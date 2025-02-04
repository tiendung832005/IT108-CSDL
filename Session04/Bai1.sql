create database session04;
use session04;

create table Rooms(
	room_id int primary key auto_increment,
    room_name varchar(255) not null,
    room_manager varchar(255) not null
);

create table computer(
	com_id int primary key auto_increment,
    ram varchar(100) not null,
    cpu varchar(100) not null,
    hard_drive varchar(100) not null
);

create table subjects(
	sub_id int primary key auto_increment,
    sub_name varchar(255) not null,
    sub_time varchar(255) not null
);

create table register(
	register_id int primary key,
    room_id int,
    sub_id int,
    date_start date,
    foreign key (room_id) references rooms(room_id),
    foreign key (sub_id) references subjects(sub_id)
);

