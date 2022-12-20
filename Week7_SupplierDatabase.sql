create database 1BM21CS113_Supplier;
use 1BM21CS113_Supplier;
create table Supplier 
(
sid int primary key,
sname varchar(40),
city varchar(40)
);

create table Parts
(
  pid int primary key,
  pname varchar(30),
  color varchar(30)
  );
  
create table Catalog
(
sid int,
pid int,
primary key(sid,pid),
foreign key(sid) references Supplier(sid) on delete cascade on update cascade,
foreign key(pid) references Parts(pid) on delete cascade on update cascade
);

desc Supplier;
desc Parts;
desc Catalog;

Alter table Catalog
add column cost decimal;

desc Catalog;

insert into Supplier values(10001,"Acme Widget","Banglore");
insert into Supplier values(10002,"Johns","Kolkata");
insert into Supplier values(10003,"Vimal","Mumbai");
insert into Supplier values(10004,"Reliance","Delhi");

select * from Supplier;

insert into Parts values(2001,"Book","Red");
insert into Parts values(2002,"Pen","Red");
insert into Parts values(2003,"Pencil","Green");
insert into Parts values(2004,"Mobile","Green");
insert into Parts values(2005,"Charger","Black");

select * from Parts;

insert into Catalog values(10001,2001,10);
insert into Catalog values(10001,2002,10);
insert into Catalog values(10001,2003,30);
insert into Catalog values(10001,2004,10);
insert into Catalog values(10001,2005,10);
insert into Catalog values(10002,2001,10);
insert into Catalog values(10002,2002,20);
insert into Catalog values(10003,2003,30);
insert into Catalog values(10004,2003,40);

select * from Catalog;

select  distinct p.pname
from Parts p, Supplier s, Catalog c
where s.sid=c.sid and p.pid=c.pid;

select distinct s.sname
from Parts p, Supplier s, Catalog c
where s.sid=c.sid and p.pid=c.pid and p.color="Red";

select distinct s.sname
from Supplier s
where s.sid in(select sid 
               from Catalog 
				group by sid 
                having count(*)=(select count(*) from Parts));
                
select distinct p.pname
from Parts p, Catalog c
where c.sid=(select sid from Supplier where sname="Acme Widget") 
and p.pid=c.pid and c.pid not in(select c.pid
							     from Catalog c
                                 where c.sid!=(select sid from Supplier where sname="Acme Widget"));
                                                                  

select c.sid
from  Catalog c
where c.cost>(select avg(cost) from catalog c1 where c.pid=c1.pid);

select s.sname
from Supplier s
where s.sid in(select c.sid from Catalog c where c.cost=(select max(cost)
                                                        from Catalog c1 where c.pid=c1.pid));



                

