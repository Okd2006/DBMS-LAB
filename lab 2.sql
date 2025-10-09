use mysql;
show databases;
drop database omkrrish;
create database omkrrish;
show databases;
use omkrrish;
create table PERSON(
driver_id varchar(10),
name varchar(20), 
address varchar(30),
primary key(driver_id)
);
show tables;
desc person;
create table CAR(
reg_num varchar(10),
model varchar(10),
year int(4),
primary key(reg_num)
);
desc CAR;
create table ACCIDENT(
report_num int(10),
accident_date date,
location varchar(50),
primary key(report_num)
);
desc Accident;
create table OWNS(
driver_id varchar(10),
reg_num varchar(10),
report_num int,
damage_amount int,
primary key(driver_id,reg_num,report_num),
foreign key(driver_id) references person(driver_id),
foreign key(reg_num) references car(reg_num),
foreign key(report_num) references accident(report_num)
);
desc OWNS;
alter table OWNS rename to PARTICIPATED;
desc PARTICIPATED;
create table OWNS(
driver_id varchar(10),
reg_num varchar(10),
primary key(driver_id,reg_num),
foreign key(driver_id) references person(driver_id),
foreign key(reg_num) references car(reg_num)
);
desc OWNS;

INSERT INTO PERSON  VALUES
('A01', 'Richard', 'Srinivas nagar'),
('A02', 'Pradeep', 'Rajaji nagar'),
('A03', 'Smith', 'Ashok nagar'),
('A04', 'Venu', 'N R Colony'),
('A05', 'Jhon', 'Hanumanth nagar');


INSERT INTO CAR  VALUES
('KA052250', 'Indica', 1990),
('KA031181', 'Lancer', 1957),
('KA095477', 'Toyota', 1998),
('KA053408', 'Honda', 2008),
('KA041702', 'Audi', 2005);


INSERT INTO OWNS VALUES
('A01', 'KA052250'),
('A02', 'KA053408'),
('A03', 'KA031181'),
('A04', 'KA095477'),
('A05', 'KA041702');
select * from person;
select * from car;
select * from owns;
insert into accident values
(11,'2003-01-01','Mysore Road'),
(12,'2004-02-02','South end Circle'),
(13,'2003-01-21','Bull temple Road'),
(14,'2008-02-17','Mysore Road'),
(15,'2005-03-04','Kanakpura Road');
select * from accident;
INSERT INTO PARTICIPATED VALUES
('A01', 'KA052250', 11, 10000),
('A02', 'KA053408', 12, 50000),
('A03', 'KA095477', 13, 25000),
('A04', 'KA031181', 14, 3000),
('A05', 'KA041702', 15, 5000);
desc participated;
select * from participated ;
update participated set damage_amount=25000 where reg_num='KA053408' and report_num=12;
select * from participated ;
insert into accident values(16,'2008-03-15','Domlur');
select * from accident;
select accident_date,location from accident;
select driver_id from participated where damage_amount>=25000;
select * from participated order by damage_amount desc;
select avg(damage_amount) from participated;
delete from participated where damage_amount<13600;
select* from car order by year asc;
select count(distinct(reg_num)) as accident_no from car where model='Lancer';
select count(*) as accident_no from participated where(select reg_num from car where model='Lancer');
select count(distinct driver_id)  as Total_no from owns where driver_id in(select reg_num from participated where report_num in(select report_num from accident where year(accident_date)=2008));
select* from participated order by damage_amount desc;
select* from owns;
select* from accident;
select* from participated;
INSERT INTO PARTICIPATED VALUES
('A04', 'KA031181', 14, 3000);
select* from person;
select* from car;
select count(distinct driver_id)  as Total_no from owns where reg_num in(select reg_num from participated where report_num in(select report_num from accident where year(accident_date)=2008));
select avg(damage_amount) from participated;
DELETE FROM participated
WHERE damage_amount < (
    SELECT avg_val
    FROM (
        SELECT AVG(damage_amount) AS avg_val
        FROM participated
    ) AS temp
);
select* from participated order by damage_amount desc;
select name from person where driver_id in(select driver_id from participated where damage_amount>=(select avg(damage_amount) from participated));
select max(damage_amount) from participated;















