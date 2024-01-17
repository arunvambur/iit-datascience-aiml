USE master;
GO

CREATE DATABASE Sales ON
(NAME = Sales_dat,
    FILENAME = 'C:\sales\saledat.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5)
LOG ON
(NAME = Sales_log,
    FILENAME = 'C:\sales\salelog.ldf',
    SIZE = 5 MB,
    MAXSIZE = 25 MB,
    FILEGROWTH = 5 MB);
GO

/* Salesman table creation */

CREATE TABLE Salesman (
    SalesmanId INT,
    Name VARCHAR(255),
    Commission DECIMAL(10, 2),
    City VARCHAR(255),
    Age INT
);

/* Salesman table record insertion */

INSERT INTO Salesman (SalesmanId, Name, Commission, City, Age)
VALUES
    (101, 'Joe', 50, 'California', 17),
    (102, 'Simon', 75, 'Texas', 25),
    (103, 'Jessie', 105, 'Florida', 35),
    (104, 'Danny', 100, 'Texas', 22),
    (105, 'Lia', 65, 'New Jersey', 30);


/* Customer table creation */

CREATE TABLE Customer (
    SalesmanId INT,
    CustomerId INT,
    CustomerName VARCHAR(255),
    PurchaseAmount INT,
    );

/* Customer table record insertion  */

INSERT INTO Customer (SalesmanId, CustomerId, CustomerName, PurchaseAmount)
VALUES
    (101, 2345, 'Andrew', 550),
    (103, 1575, 'Lucky', 4500),
    (104, 2345, 'Andrew', 4000),
    (107, 3747, 'Remona', 2700),
    (110, 4004, 'Julia', 4545);


/* Orders table Creation */


CREATE TABLE Orders (OrderId int, CustomerId int, SalesmanId int, Orderdate Date, Amount money)

/* Orders table record insertion */

INSERT INTO Orders Values 
(5001,2345,101,'2021-07-01',550),
(5003,1234,105,'2022-02-15',1500)

/*1. Insert a new record in your Orders table.*/

INSERT INTO Orders Values(5004, 2345, 107, '2024-01-17', 878);
SELECT * FROM Orders;

/*2. Add Primary key constraint for SalesmanId column in Salesman table. Add default
constraint for City column in Salesman table. Add Foreign key constraint for SalesmanId
column in Customer table. Add not null constraint in Customer_name column for the
Customer table.*/

ALTER TABLE Salesman ALTER COLUMN SalesmanId int NOT NULL;

ALTER TABLE Salesman ADD PRIMARY KEY(SalesmanId);

ALTER TABLE Salesman ADD CONSTRAINT default_city DEFAULT 'Pune' for City;

/*test*/
SELECT * FROM Salesman
INSERT INTO Salesman (SalesmanId, Name, Commission, Age)
VALUES  (106, 'Arun', 50, 17);
SELECT * FROM Salesman WHERE Name = 'Arun'


INSERT INTO Salesman (SalesmanId, Name, Commission, Age)
VALUES  (107, 'Kurinji', 50, 17);

INSERT INTO Salesman (SalesmanId, Name, Commission, Age)
VALUES  (110, 'Arun', 50, 17);

ALTER TABLE Customer
ADD CONSTRAINT FK_CustomerSalesman
FOREIGN KEY (SalesmanId) REFERENCES Salesman(SalesmanId);

ALTER TABLE Customer ALTER COLUMN CustomerName VARCHAR(255) NOT NULL;

/*3. Fetch the data where the Customer’s name is ending with either ‘N’ also get the
purchase amount value greater than 500.*/

INSERT INTO Customer (SalesmanId, CustomerId, CustomerName, PurchaseAmount)
VALUES
    (106, 2345, 'ARUN', 550);

SELECT * FROM Customer
WHERE PurchaseAmount > 500 AND CustomerName like '%N'

/*4. Using SET operators, retrieve the first result with unique SalesmanId values from two
tables, and the other result containing SalesmanId without duplicates from two tables.*/

SELECT SalesmanId FROM (
SELECT SalesmanId FROM Salesman
UNION
SELECT SalesmanId FROM Customer
) a
GROUP BY SalesmanId


/*5. Display the below columns which has the matching data.
Orderdate, Salesman Name, Customer Name, Commission, and City which has the
of Purchase Amount between 1500 to 3000*/


SELECT o.Orderdate, s.Name SalesmanName, c.CustomerName, s.Commission, s.City
FROM Customer c, Salesman s, Orders o
WHERE c.SalesmanId = s.SalesmanId AND o.SalesmanId = s.SalesmanId AND c.PurchaseAmount BETWEEN 1500 AND 3000;

/*6. Using right join fetch all the results from Salesman and Orders table.*/

SELECT s.SalesmanId, s.Name, s.Age, s.City, s.Commission, o.OrderId, o.Orderdate,  o.Amount
FROM Orders o
RIGHT join Salesman s
ON o.SalesmanId = s.SalesmanId