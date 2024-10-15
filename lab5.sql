create database lab5;

create table if not exists customers(
    customer_id int primary key,
    name varchar(100),
    city varchar(50),
    grade int,
    salesman_id int references salesmans(salesman_id)
);

create table orders(
    ord_no int primary key ,
    purch_amt numeric(10,2),
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
(3001,'Brad Guzan','London',200,5005),
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
(5003, 'Lauson Hen', 'Paris', 0.12),
(5007, 'Paul Adam', 'Rome', 0.13);


select sum(purch_amt) as total_purchase from orders; --#3

select avg(purch_amt) as avarage_purchase from orders; --#4

select count(*) as customer_number from customers where name is not null; --#5

select min(purch_amt) as minimum_purchase from orders; --#6

select * from customers where name like '%b'; --#7

select orders.* from orders join customers on orders.customer_id = customers.customer_id where customers.city = 'New York'; --#8

select customers.* from customers join orders o on customers.customer_id = o.customer_id where o.purch_amt > 10; --#9

select sum(grade) as total_grade from customers; --#10

select * from customers where name is not null; --#11

select max(grade) as max_grade from customers; --#12