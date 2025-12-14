drop database if exists om3;
create database om3;
use om3;
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
(1,"OK",322,"12-02-2006",200000,4),
(544,"Nishant",322,"13-02-2006",50000,3),
(322,"Niketh",NUll,"14-03-2006",70000,2),
(4,"Kanishka",322,"15-04-2006",100000,1),
(5,"Prabhav",544,"16-04-2006",150000,5);
insert into project values
(1,"Hyderabad","Housing Project"),
(2,"Bengaluru","Office space"),
(3,"Mysore","Mall"),
(4,"Delhi","Road"),
(5,"Bombay","School");
insert into assigned_to values
(1,3,"Site Incahrge"),
(544,1,"Manager"),
(322,4,"Architect"),
(4,2,"Designer"),
(5,5,"Production Head");
insert into incentives values
("05-06-2008",40000,1),
("05-07-2009",60000,544),
("08-09-2010",0,322),
("08-08-2011" ,56000,4),
("01-10-2012",50000,5);
SELECT E2.ENAME AS MANAGER_NAME
FROM EMPLOYEE E1
JOIN EMPLOYEE E2 ON E1.MGR_NO = E2.EMPNO
GROUP BY E2.ENAME
HAVING COUNT(E1.EMPNO) = (
    SELECT MAX(EMP_COUNT)
    FROM (
        SELECT COUNT(E1.EMPNO) AS EMP_COUNT
        FROM EMPLOYEE E1
        WHERE E1.MGR_NO IS NOT NULL
        GROUP BY E1.MGR_NO
    ) AS TEMP
);
select* from employee;
select m.ename as mgr_name from employee m join employee e on m.empno=e.mgr_no group by m.empno,e.ename,m.sal having m.sal>avg(e.sal);

SELECT DISTINCT E.ENAME AS SECOND_LEVEL_MANAGER, E.DEPTNO
FROM EMPLOYEE E
JOIN EMPLOYEE M ON E.MGR_NO = M.EMPNO
WHERE M.MGR_NO IS NULL;                               
select e.ename from employee e join employee m on e.mgr_no=m.empno where e.deptno=m.deptno;
SELECT E2.ENAME AS MANAGER_NAME
FROM EMPLOYEE E1
JOIN EMPLOYEE E2 ON E1.MGR_NO = E2.EMPNO
GROUP BY E2.ENAME
ORDER BY COUNT(E1.EMPNO) DESC
LIMIT 1;

/* ---------------------------------------------------------
i. Create tables with proper Primary Keys & Foreign Keys
   (Already correctly done by you — reproduced for completeness)
---------------------------------------------------------- */

CREATE TABLE dept(
    deptno INT PRIMARY KEY,
    dname VARCHAR(20),
    dloc VARCHAR(20)
);

CREATE TABLE employee(
    empno INT PRIMARY KEY,
    ename VARCHAR(40),
    mgr_no INT,
    hiredate VARCHAR(40),
    sal INT,
    deptno INT,
    FOREIGN KEY (deptno) REFERENCES dept(deptno)
);

CREATE TABLE project(
    pno INT PRIMARY KEY,
    ploc VARCHAR(30),
    pname VARCHAR(30)
);

CREATE TABLE assigned_to(
    empno INT,
    pno INT,
    job_role VARCHAR(40),
    PRIMARY KEY(empno, pno),
    FOREIGN KEY (empno) REFERENCES employee(empno),
    FOREIGN KEY (pno) REFERENCES project(pno)
);

CREATE TABLE incentives(
    incentive_date VARCHAR(40),
    incentve_amount INT,
    empno INT,
    FOREIGN KEY (empno) REFERENCES employee(empno)
);

/* ---------------------------------------------------------
ii. Insert greater than five tuples for each table
   (Already satisfied in your dataset)
---------------------------------------------------------- */


/* ---------------------------------------------------------
iii. List the name of the managers with the maximum employees
---------------------------------------------------------- */

SELECT e.ename
FROM employee e
JOIN employee emp ON e.empno = emp.mgr_no
GROUP BY e.empno, e.ename
HAVING COUNT(emp.empno) = (
    SELECT MAX(cnt)
    FROM (
        SELECT COUNT(*) AS cnt
        FROM employee
        WHERE mgr_no IS NOT NULL
        GROUP BY mgr_no
    ) x
);


/* ---------------------------------------------------------
iv. Display managers whose salary is more than the
    average salary of their employees
---------------------------------------------------------- */

SELECT e.ename
FROM employee e
JOIN employee emp ON e.empno = emp.mgr_no
GROUP BY e.empno, e.ename, e.sal
HAVING e.sal > AVG(emp.sal);


/* ---------------------------------------------------------
v. Find the second top-level managers of each department
   (Managers reporting to the department head)
---------------------------------------------------------- */

SELECT DISTINCT m.ename, m.deptno
FROM employee m
JOIN employee e ON m.empno = e.mgr_no
WHERE m.mgr_no IS NOT NULL
AND m.mgr_no IN (
    SELECT empno
    FROM employee
    WHERE mgr_no IS NULL
);


/* ---------------------------------------------------------
vi. Find employee details who got the second maximum
    incentive in January 2019
---------------------------------------------------------- */

SELECT *
FROM employee
WHERE empno IN (
    SELECT empno
    FROM incentives
    WHERE incentive_date LIKE '%01-2019%'
    AND incentve_amount = (
        SELECT MAX(incentve_amount)
        FROM incentives
        WHERE incentive_date LIKE '%01-2019%'
        AND incentve_amount < (
            SELECT MAX(incentve_amount)
            FROM incentives
            WHERE incentive_date LIKE '%01-2019%'
        )
    )
);


/* ---------------------------------------------------------
vii. Display employees working in the same department
     as their manager
---------------------------------------------------------- */

SELECT e.empno, e.ename
FROM employee e
JOIN employee m ON e.mgr_no = m.empno
WHERE e.deptno = m.deptno;


