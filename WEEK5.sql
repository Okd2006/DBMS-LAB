drop database if exists om;
create database om;
use om;
create table dept(
deptno int(50) primary key,
dname varchar(20),
dloc varchar(20)
);
create table employee(
empno int(30) primary key,
ename varchar(40),
mgr_no int(30),
hiredate varchar(40),
sal int(50),
deptno int(50),
foreign key(deptno) references dept(deptno));
create table project(
pno int(50) primary key,
ploc varchar(30),
pname varchar(30)
);
create table assigned_to(
empno int(30),
pno int(50),
job_role varchar(40),
primary key(empno,pno),
foreign key (empno) references employee(empno),
foreign key (pno) references project(pno)
);
create table incentives(
incentive_date varchar(40),
incentve_amount int(40),
empno int(30),
foreign key (empno) references employee(empno)
);
show tables;
insert into dept value
(1,"IT","Delhi"),
(2,"HR","Pune"),
(3,"Finance","Gurugram"),
(4,"Logistics","Hyderabad"),
(5,"Prodcution","Bengaluru");
insert into employee value
(1,"OK",233,"12-02-2006",200000,4),
(2,"Nishant",322,"13-02-2006",50000,3),
(3,"Niketh",333,"14-03-2006",70000,2),
(4,"Kanishka",453,"15-04-2006",100000,1),
(5,"Prabhav",544,"16-04-2006",150000,5);
insert into project values
(1,"Hyderabad","Housing Project"),
(2,"Bengaluru","Office space"),
(3,"Mysore","Mall"),
(4,"Delhi","Road"),
(5,"Bombay","School");
insert into assigned_to values
(1,3,"Site Incahrge"),
(2,1,"Manager"),
(3,4,"Architect"),
(4,2,"Designer"),
(5,5,"Production Head");
insert into incentives values
("05-06-2008",40000,1),
("05-07-2009",60000,2),
("08-09-2010",0,3),
("08-08-2011" ,56000,4),
("01-10-2012",50000,5);

select e.empno from employee e join assigned_to a on e.empno=a.empno join project p on a.pno=p.pno where p.ploc not in("Hyderabad","Mysore","Bengaluru");
select empno from employee where empno in(select empno from incentives where incentve_amount=0);
select e.empno,e.ename,d.dname,a.job_role,d.dloc,p.ploc from employee e join dept d on e.deptno=d.deptno join assigned_to  on e.empno=a.empno join project p on a.pno=p.pno where p.ploc=d.dloc;
