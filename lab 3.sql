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

CREATE TABLE Branch (
    branch_name VARCHAR(50) PRIMARY KEY,
    branch_city VARCHAR(50),
    assets REAL
);

-- BankAccount Table
CREATE TABLE BankAccount (
    accno INT PRIMARY KEY,
    branch_name VARCHAR(50),
    balance REAL,
    FOREIGN KEY (branch_name) REFERENCES Branch(branch_name)
);

-- BankCustomer Table
CREATE TABLE BankCustomer (
    customer_name VARCHAR(50) PRIMARY KEY,
    customer_street VARCHAR(50),
    customer_city VARCHAR(50)
);

-- Depositer Table
CREATE TABLE Depositer (
    customer_name VARCHAR(50),
    accno INT,
    PRIMARY KEY (customer_name, accno),
    FOREIGN KEY (customer_name) REFERENCES BankCustomer(customer_name),
    FOREIGN KEY (accno) REFERENCES BankAccount(accno)
);

-- Loan Table
CREATE TABLE Loan (
    loan_number INT PRIMARY KEY,
    branch_name VARCHAR(50),
    amount REAL,
    FOREIGN KEY (branch_name) REFERENCES Branch(branch_name)
);
INSERT INTO Branch VALUES
('SBI_ResidencyRoad', 'Bangalore', 9000000),
('SBI_Jayanagar', 'Bangalore', 7500000),
('HDFC_Indiranagar', 'Bangalore', 8500000),
('ICICI_MG', 'Bangalore', 6500000),
('Axis_Whitefield', 'Bangalore', 7000000);
INSERT INTO BankAccount VALUES
(1, 'SBI_ResidencyRoad', 25000),
(2, 'SBI_ResidencyRoad', 35000),
(3, 'SBI_Jayanagar', 50000),
(4, 'HDFC_Indiranagar', 40000),
(5, 'ICICI_MG', 60000),
(6, 'Axis_Whitefield', 30000),
(7, 'SBI_Jayanagar', 15000),
(8, 'SBI_ResidencyRoad', 70000),
(9, 'Axis_Whitefield', 55000),
(10, 'SBI_ResidencyRoad', 45000);
INSERT INTO BankCustomer VALUES
('Dinesh', 'MG Road', 'Bangalore'),
('Avinash', 'Residency Road', 'Bangalore'),
('Rohit', 'Jayanagar', 'Bangalore'),
('Kiran', 'Whitefield', 'Bangalore'),
('Meena', 'Indiranagar', 'Bangalore'),
('Arjun', 'BTM Layout', 'Bangalore');
INSERT INTO Depositer VALUES
('Dinesh', 2),
('Avinash', 8),
('Dinesh', 10),
('Rohit', 3),
('Kiran', 6),
('Meena', 4),
('Arjun', 5),
('Rohit', 7),
('Avinash', 1),
('Kiran', 9);
INSERT INTO Loan VALUES
(101, 'SBI_ResidencyRoad', 300000),
(102, 'SBI_ResidencyRoad', 200000),
(103, 'HDFC_Indiranagar', 400000),
(104, 'Axis_Whitefield', 500000),
(105, 'ICICI_MG', 350000),
(106, 'SBI_Jayanagar', 250000),
(107, 'SBI_Jayanagar', 450000),
(108, 'HDFC_Indiranagar', 150000),
(109, 'Axis_Whitefield', 100000),
(110, 'ICICI_MG', 275000);

