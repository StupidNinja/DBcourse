Create database lab7;

CREATE INDEX index_countries_name ON countries(name);

CREATE INDEX index_employees_name_surname ON employees(name, surname);

CREATE UNIQUE INDEX index_employees_salary_range ON employees(salary);

CREATE INDEX index_employees_name_substring ON employees((substring(name from 1 for 4)));

CREATE INDEX index_employees_departments_budget_salary 
ON employees (department_id, salary);

CREATE INDEX index_departments_budget 
ON departments(budget);



CREATE TABLE IF NOT EXISTS countries (
    country_id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100),
    budget INTEGER
);

CREATE TABLE IF NOT EXISTS employees (
    employee_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    surname VARCHAR(50),
    salary INTEGER,
    department_id INTEGER REFERENCES departments(department_id)
);

INSERT INTO countries (name) VALUES
('United States'),
('Canada'),
('Mexico'),
('Germany'),
('France'),
('Japan');

INSERT INTO departments (department_name, budget) VALUES
('Sales', 50000),
('Engineering', 150000),
('Human Resources', 30000),
('Marketing', 70000),
('Finance', 120000);

INSERT INTO employees (name, surname, salary, department_id) VALUES
('John', 'Doe', 60000, 1),
('Jane', 'Smith', 80000, 2),
('Alice', 'Johnson', 75000, 2),
('Bob', 'Brown', 50000, 3),
('Charlie', 'Davis', 90000, 4),
('Eve', 'Miller', 70000, 5),
('Frank', 'Wilson', 65000, 1),
('Grace', 'Lee', 85000, 2),
('Hank', 'Taylor', 55000, 3),
('Ivy', 'Anderson', 95000, 4);