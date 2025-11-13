show databases;
create database parts1;
use parts1;
create table suppliers(
sid int(50) primary key,
sname varchar(50),city varchar(50));
create table parts(pid int(50) 
primary key,pnmae varchar(50),color varchar(50));
create table catalog(sid int(50),pid int(50),cost int(50),
foreign key(sid) references suppliers(sid),
foreign key(pid) references parts(pid));
insert into suppliers values
(1,"Acme Widget Suppliers","London"),
(2,"Best Parts Co","Paris"),
(3,"Quick Supply Ltd","Tokyo");
insert into parts values
(1,"Bolt","Red"),
(2,"Nut","Green"),
(3,"Screw","Blue"),
(4,"Gear","Red"),
(5,"Bearing","Yellow");
insert into catalog values
(1,1,250),
(1,2,180),
(1,3,200),
(2,2,175),
(2,4,220),
(3,1,260),
(3,3,190),
(3,4,230),
(3,5,300),
(3,2,400);
select distinct p.pnmae from parts p join catalog c on p.pid=c.pid where c.sid is not null; 
select * from parts;
SELECT s.sname
FROM suppliers s
JOIN catalog c ON s.sid = c.sid
GROUP BY s.sname
HAVING COUNT(DISTINCT c.pid) = (SELECT COUNT(*) FROM parts);
select s.sname from suppliers s join catalog c on s.sid=c.sid join parts p on c.pid=p.pid where p.color="red" group by s.sname having count(distinct p.pid)=(select count(*) from parts where color="Red"); 
use parts1;
show tables;
SELECT p.pnmae
FROM parts p
JOIN catalog c ON p.pid = c.pid
JOIN suppliers s ON c.sid = s.sid
WHERE s.sname = 'Acme Widget Suppliers'
AND p.pid NOT IN (
    SELECT c2.pid
    FROM catalog c2
    JOIN suppliers s2 ON c2.sid = s2.sid
    WHERE s2.sname <> 'Acme Widget Suppliers'
);
SELECT DISTINCT c.sid
FROM catalog c
WHERE c.cost > (
    SELECT AVG(c2.cost)
    FROM catalog c2
    WHERE c2.pid = c.pid
);
SELECT p.pnmae, s.sname
FROM parts p
JOIN catalog c ON p.pid = c.pid
JOIN suppliers s ON c.sid = s.sid
WHERE c.cost = (
    SELECT MAX(c2.cost)
    FROM catalog c2
    WHERE c2.pid = p.pid
);                                                                     
