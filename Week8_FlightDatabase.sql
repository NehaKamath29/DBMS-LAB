create database 1bm21cs113_Week8_Flight;
use 1bm21cs113_Week8_FLight;

create table Flights
(
flno int primary key,
dep_airport varchar(40),
arr_airport varchar(40),
distance decimal,
departs time,
arrives time,
price decimal);

create table Aircraft
(
aid int primary key,
aname varchar(40),
cruisingrange int);

create table Employee
(
eid int primary key,
ename varchar(50),
salary decimal);

create table certified
(
aid int,
eid int,
primary key(aid,eid),
foreign key(eid) references Employee(eid),
foreign key(aid) references Aircraft(aid));

Alter table certified
add foreign key(eid) references Employee(eid) on delete cascade on update cascade;

Alter table certified
add foreign key(aid) references Aircraft(aid) on delete cascade on update cascade;


desc Flights;
desc Aircraft;
desc Employee;
desc certified;

insert into Flights values(1,"Banglore","New Delhi",500,"6:00","9:00",5000);
insert into Flights values(2,"Banglore","Chennal",300,"7:00","8:30",3000);
insert into Flights values(3,"Trivandrum","New Delhi",800,"8:00","11:30",6000);
insert into Flights values(4,"Banglore","Frankfurt",10000,"6:00","23:30",50000);
insert into Flights values(5,"Kolkata","New Delhi",2400,"11:00","3:30",9000);
insert into Flights values(6,"Banglore","Frankfurt",8000,"9:00","23:00",40000);

select * from Flights;

insert into Aircraft values(1,"Airbus",2000);
insert into Aircraft values(2,"Boeing",700);
insert into Aircraft values(3,"JetAirways",550);
insert into Aircraft values(4,"Indigo",5000);
insert into Aircraft values(5,"Boeing",4500);
insert into Aircraft values(6,"Airbus",2200);

select * from Aircraft;

insert into Employee values(101,"Avinash",50000);
insert into Employee values(102,"Lokesh",60000);
insert into Employee values(103,"Rakesh",70000);
insert into Employee values(104,"Santhosh",82000);
insert into Employee  values(105,"Tilak",5000);

select * from Employee;

insert into certified values(2,101);
insert into certified values(4,101);
insert into certified values(5,101);
insert into certified values(6,101);
insert into certified values(1,102);
insert into certified values(3,102);
insert into certified values(5,102);
insert into certified values(2,103);
insert into certified values(3,103);
insert into certified values(5,103);
insert into certified values(6,103);
insert into certified values(6,104);
insert into certified values(1,104);
insert into certified values(3,104);
insert into certified values(3,105);


select * from certified;

select a.aname
from Aircraft a, certified c, Employee e 
where a.aid=c.aid and c.eid=e.eid
and e.salary>80000;

select c.eid, max(a.cruisingrange)
from Aircraft a, certified c, Employee e 
where a.aid=c.aid and c.eid=e.eid
group by c.eid
having count(c.aid)>=3;


select e.ename
from Employee e 
where e.salary< all(select min(price)
                     from Flights 
                     where dep_airport="Banglore" and arr_airport="Frankfurt");
                     
select a.aname, avg(e.salary) as Avg_Salary
from Aircraft a, certified c, Employee e 
where a.aid=c.aid and c.eid=e.eid and a.cruisingrange>1000
group by c.aid;

select distinct e.ename
from Aircraft a, certified c, Employee e 
where a.aid=c.aid and c.eid=e.eid and a.aname="Boeing";

select distinct a.aid
from Aircraft a
where a.cruisingrange >any(select distance
                        from Flights
                        where dep_airport="Banglore" and arr_airport="New Delhi");

                     

