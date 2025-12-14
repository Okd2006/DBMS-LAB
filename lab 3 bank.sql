CREATE DATABASE bank_om;
USE bank_om;
-- Branch Table\
DROP DATABASE IF EXISTS bank_om;
CREATE DATABASE bank_om;
USE bank_om;

CREATE TABLE Branch (
    branch_name VARCHAR(50) PRIMARY KEY,
    branch_city VARCHAR(50),
    assets REAL
);

CREATE TABLE BankAccount (
    accno INT PRIMARY KEY,
    branch_name VARCHAR(50),
    balance REAL,
    FOREIGN KEY (branch_name) REFERENCES Branch(branch_name)
);

CREATE TABLE BankCustomer (
    customer_name VARCHAR(50) PRIMARY KEY,
    customer_street VARCHAR(50),
    customer_city VARCHAR(50)
);

CREATE TABLE Depositer (
    customer_name VARCHAR(50),
    accno INT,
    PRIMARY KEY (customer_name, accno),
    FOREIGN KEY (customer_name) REFERENCES BankCustomer(customer_name),
    FOREIGN KEY (accno) REFERENCES BankAccount(accno)
);

CREATE TABLE Loan (
    loan_number INT PRIMARY KEY,
    branch_name VARCHAR(50),
    amount REAL,
    FOREIGN KEY (branch_name) REFERENCES Branch(branch_name)
);
INSERT INTO Branch VALUES
('SBI_Chamrajpet', 'Bangalore', 50000),
('SBI_ResidencyRoad', 'Bangalore', 10000),
('SBI_ShivajiRoad', 'Bombay', 20000),
('SBI_ParlimentRoad', 'Delhi', 10000),
('SBI_Jantarmantar', 'Delhi', 20000);

INSERT INTO BankAccount VALUES
(1, 'SBI_Chamrajpet', 2000),
(2, 'SBI_ResidencyRoad', 5000),
(3, 'SBI_ShivajiRoad', 6000),
(4, 'SBI_ParlimentRoad', 3000),
(5, 'SBI_Jantarmantar', 8000),
(6, 'SBI_ShivajiRoad', 4000),
(8, 'SBI_ResidencyRoad', 4000),
(9, 'SBI_ParlimentRoad', 5000),
(10, 'SBI_ResidencyRoad', 5000),
(11, 'SBI_Jantarmantar', 2000);

INSERT INTO BankCustomer VALUES
('Avinash', 'Bull_Temple_Road', 'Bangalore'),
('Dinesh', 'Bannergatta_Road', 'Bangalore'),
('Mohan', 'NationalCollege_Road', 'Bangalore'),
('Nikhil', 'Akbar_Road', 'Delhi'),
('Ravi', 'Prithviraj_Road', 'Delhi');

INSERT INTO Depositer VALUES
('Avinash', 1),
('Dinesh', 2),
('Nikhil', 4),
('Ravi', 5),
('Avinash', 8),
('Nikhil', 9),
('Dinesh', 10),
('Nikhil', 11);

INSERT INTO Loan VALUES
(1, 'SBI_Chamrajpet', 1000),
(2, 'SBI_ResidencyRoad', 2000),
(3, 'SBI_ShivajiRoad', 3000),
(4, 'SBI_ParlimentRoad', 4000),
(5, 'SBI_Jantarmantar', 5000);





select * from branch;
select branch_name,assets/10 as assets_in_lakh from  branch;
select customer_name,accno from depositer where accno in (select accno from bankaccount group by accno having count(distinct branch_name)>=2);
select * from depositer;
SELECT d.customer_name, ba.branch_name
FROM depositer d
JOIN bankaccount ba ON d.accno = ba.accno
GROUP BY d.customer_name, ba.branch_name
HAVING COUNT(DISTINCT d.accno) >= 2;
create view sum as select sum(amount),branch_name from loan group by(branch_name);
select* from sum;


/* i. Find all the customers who have an account at ALL branches
      located in a specific city (Example: Delhi) */

SELECT d.customer_name
FROM depositer d
JOIN bankaccount ba ON d.accno = ba.accno
JOIN branch b ON ba.branch_name = b.branch_name
WHERE b.branch_city = 'Delhi'
GROUP BY d.customer_name
HAVING COUNT(DISTINCT b.branch_name) =
       (SELECT COUNT(*) FROM branch WHERE branch_city = 'Delhi');


/* ii. Find all customers who have a loan at the bank
       but do NOT have an account */

SELECT DISTINCT bc.customer_name
FROM bankcustomer bc
JOIN loan l ON bc.customer_city = (
    SELECT branch_city FROM branch WHERE branch.branch_name = l.branch_name
)
WHERE bc.customer_name NOT IN (
    SELECT customer_name FROM depositer
);


/* iii. Find all customers who have BOTH an account and a loan
        at the Bangalore branch */

SELECT DISTINCT d.customer_name
FROM depositer d
JOIN bankaccount ba ON d.accno = ba.accno
JOIN loan l ON ba.branch_name = l.branch_name
JOIN branch b ON ba.branch_name = b.branch_name
WHERE b.branch_city = 'Bangalore';


/* iv. Find the names of all branches that have greater assets
       than ALL branches located in Bangalore */

SELECT branch_name
FROM branch
WHERE assets > ALL (
    SELECT assets
    FROM branch
    WHERE branch_city = 'Bangalore'
);


/* v. Delete all account tuples at every branch located
      in a specific city (Example: Bombay) */

DELETE FROM bankaccount
WHERE branch_name IN (
    SELECT branch_name
    FROM branch
    WHERE branch_city = 'Bombay'
);


/* vi. Update the balance of ALL accounts by 5% */

UPDATE bankaccount
SET balance = balance * 1.05;






