create database lab9;

CREATE OR REPLACE FUNCTION increase_value(input_value INT)
RETURNS INT AS $$
BEGIN
    RETURN input_value + 10;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION compare_numbers(num1 INT, num2 INT)
RETURNS TEXT AS $$
BEGIN
    IF num1 > num2 THEN
        RETURN 'Greater';
    ELSIF num1 = num2 THEN
        RETURN 'Equal';
    ELSE
        RETURN 'Lesser';
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION number_series(n INT)
RETURNS TABLE(series INT) AS $$
BEGIN
    FOR series IN 1..n LOOP
        RETURN NEXT series;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION number_series(n INT)
RETURNS TABLE(series INT) AS $$
BEGIN
    FOR series IN 1..n LOOP
        RETURN NEXT series;
    END LOOP;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION find_employee(emp_name VARCHAR)
RETURNS TABLE(employee_id INT, name VARCHAR, position VARCHAR, department VARCHAR) AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, position, department
    FROM employees
    WHERE name = emp_name;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION list_products(category_name VARCHAR)
RETURNS TABLE(product_id INT, product_name VARCHAR, price NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, price
    FROM products
    WHERE category = category_name;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION calculate_bonus(salary NUMERIC, bonus_percentage NUMERIC)
RETURNS NUMERIC AS $$
BEGIN
    RETURN salary * (bonus_percentage / 100);
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION update_salary(employee_id INT, bonus_percentage NUMERIC)
RETURNS VOID AS $$
DECLARE
    current_salary NUMERIC;
    bonus NUMERIC;
BEGIN
    SELECT salary INTO current_salary
    FROM employees
    WHERE id = employee_id;

    bonus := calculate_bonus(current_salary, bonus_percentage);

    UPDATE employees
    SET salary = salary + bonus
    WHERE id = employee_id;
END;
$$ LANGUAGE plpgsql;


select increase_value(10);