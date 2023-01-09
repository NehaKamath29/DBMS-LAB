create database 1bm21cs113_DbmsExam;
use 1bm21cs113_DbmsExam;

create table Hall
(
    hall_no int primary key,
    address varchar(50),
    hall_manager varchar(50),
    tel_ph bigint,
    monthly_rent decimal
);

create table apartment
(
   flat_no int primary key,
   address varchar(50),
   no_dorms int
);

create table Rooms
(
  room_no varchar(10) primary key,
  hall_no int,
  flat_no int,
  foreign key(hall_no) references Hall(hall_no) on delete cascade on update cascade,
  foreign key(flat_no) references apartment(flat_no) on delete cascade on update cascade
);

create table reg_office
(
   place_no varchar(10) primary key,
   room_no varchar(10),
   foreign key(room_no) references Rooms(room_no),
   bed_no int
);
alter table reg_office
add foreign key(room_no) references Rooms(room_no) on delete cascade on update cascade;

create table student
(
   sid int primary key,
   fname varchar(50),
   lname varchar(50),
   street varchar(50),
   city varchar(50), 
   postcode int,
   nationality varchar(50),
   age int,
   phno bigint,
   gender varchar(10),
   study_level varchar(5),
   status varchar(50),
   place_no varchar(10),
   foreign key(place_no) references reg_office(place_no)
);

create table bed
(
   place_no varchar(10),
   bed_no int,
   primary key(place_no, bed_no),
   foreign key(place_no) references reg_office(place_no),
   monthly_rent decimal
);
alter table bed
add foreign key(place_no) references reg_office(place_no) on delete cascade on update cascade;

alter table student
add foreign key(place_no) references reg_office(place_no) on delete cascade on update cascade; 

create table inspection
(
   staff_name varchar(50),
   staff_id int primary key,
   doi date,
   condn varchar(5),
   hall_no int,
   flat_no int,
   foreign key(hall_no) references Hall(hall_no) on delete cascade on update cascade,
   foreign key(flat_no) references apartment(flat_no) on delete cascade on update cascade
);

create table payment
(
   invoice_no int primary key,
   term varchar(5),
   sid int,
   foreign key(sid) references student(sid) on delete cascade on update cascade,
   place_no varchar(10),
   foreign key(place_no) references reg_office(place_no) on delete cascade on update cascade,
   room_no varchar(10),
   mode varchar(20),
   rem1 date,
   rem2 date,
   pay_date date
);
   
   