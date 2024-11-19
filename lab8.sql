create database lab8;

create table if not exists customers(
    customer_id int primary key,
    name varchar(100),
    city varchar(50),
    grade int,
    salesman_id int references salesmans(salesman_id)
);

create table orders(
    ord_no int primary key ,
    purch_amt decimal(10,2),
    ord_date date,
    customer_id int references customers(customer_id),
    salesman_id int references salesmans(salesman_id)
);

create table if not exists salesmans(
    salesman_id int primary key,
    name varchar(100),
    city varchar(50),
    comission decimal(10,2)
);

insert into customers(customer_id, name, city, grade, salesman_id) values
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3005, 'Graham Zusi','California',200,5001),
(3001,'Brad Guzan','London',null,5005),
(3004, 'Fabian Johns', 'Paris', 300, 5006),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3009, 'Geoff Camero', 'Berlin', 100, 5003),
(3008, 'Julian Green', 'London', 300, 5002);

insert into orders(ord_no, purch_amt, ord_date, customer_id, salesman_id) values
(70001, 150.5, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.5, '2012-08-17', 3009, 5003),
(70007, 948.5, '2012-09-10', 3005, 5002),
(70005, 2400.6, '2012-07-27', 3007, 5001),
(70008, 5760, '2012-09-10', 3002, 5001);

insert into salesmans(salesman_id, name, city, comission) values
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5003, 'Lauson Hen', null, 0.12),
(5007, 'Paul Adam', 'Rome', 0.13);



CREATE ROLE junior_dev WITH LOGIN;

-------------------
CREATE VIEW new_york_salesman AS
SELECT * FROM salesmans
WHERE city = 'New York';

-------------------
CREATE VIEW salesman_customer_for_order AS
SELECT 
    o.ord_no, 
    o.purch_amt, 
    o.ord_date, 
    c.name AS customer_name, 
    s.name AS salesman_name
FROM 
    orders o
JOIN 
    customers c ON o.customer_id = c.customer_id
JOIN 
    salesmans s ON o.salesman_id = s.salesman_id;

GRANT ALL PRIVILEGES ON VIEW order_salesman_customer TO junior_dev;

-------------------
CREATE VIEW highest_grade_customers AS
SELECT * FROM customers
WHERE grade = (SELECT MAX(grade) FROM customers);

GRANT SELECT ON VIEW highest_grade_customers TO junior_dev;
-------------------
CREATE VIEW salesman_number_each_city AS
SELECT 
    city, 
    COUNT(*) AS salesman_count
FROM 
    salesmans
GROUP BY 
    city;
-------------------
CREATE VIEW salesmen_with_multiple_customers AS
SELECT 
    s.salesman_id, 
    s.name AS salesman_name, 
    COUNT(c.customer_id) AS customer_count
FROM 
    salesmans s
JOIN 
    customers c ON s.salesman_id = c.salesman_id
GROUP BY 
    s.salesman_id, s.name
HAVING 
    COUNT(c.customer_id) > 1;
-------------------
CREATE ROLE intern;
GRANT junior_dev TO intern;