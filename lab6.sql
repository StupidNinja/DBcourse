create database lab6;

create table if not exists locations(
    location_id serial primary key ,
    street_address varchar(25) ,
    postal_code varchar(12),
    city varchar(30),
    state_province varchar(12)
);

create table if not exists departments(
    department_id serial primary key ,
    department_name varchar(50) unique ,
    budget integer,
    location_id integer references locations
);

create table if not exists employees (
    employee_id serial primary key ,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(50),
    phone_number varchar(20),
    salary integer,
    department_id integer references departments
);

select e.first_name, e.last_name, e.department_id, department_name from employees e join departments d on e.department_id = d.department_id;

select e.first_name, e.last_name, e.department_id, d.department_name from employees e join departments d on d.department_id = e.department_id where d.department_id in (80,40);

select e.first_name, e.last_name, d.department_name, l.city, l.state_province from employees e join departments d on e.department_id = d.department_id join locations l on d.location_id = l.location_id;

select d.department_id, d.department_name, d.budget, d.location_id from departments d left join employees e on d.department_id = e.department_id;

select e.first_name, e.last_name, e.department_id, d.department_name from employees e left join departments d on e.department_id = d.department_id;


INSERT INTO locations (location_id, street_address, postal_code, city, state_province) VALUES
(1, '123 Maple St.', '10001', 'New York', 'NY'),
(2, '456 Oak Ave.', '90001', 'Los Angeles', 'CA'),
(3, '789 Pine Rd.', '60601', 'Chicago', 'IL');

INSERT INTO departments (department_id, department_name, budget, location_id) VALUES
(40, 'Sales', 50000, 1),
(80, 'Engineering', 150000, 2),
(10, 'Human Resources', 30000, 3),
(60, 'Marketing', 70000, 1); --no employee


INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, salary, department_id) VALUES
(1, 'John', 'Doe', 'john.doe@example.com', '555-1234', 60000, 40),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '555-5678', 80000, 80),
(3, 'Alice', 'Johnson', 'alice.j@example.com', '555-9012', 75000, 80),
(4, 'Bob', 'Brown', 'bob.brown@example.com', '555-3456', 50000, NULL); --no department