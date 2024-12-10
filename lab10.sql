create database lab10;

drop table Orders;
drop table Customers;
drop table Books;


create table Books (
    book_id serial primary key,
    title varchar(255),
    author varchar(255),
    price decimal(10,2),
    quantity int
);

create table Customers(
    customer_id serial primary key,
    name varchar(255),
    email varchar(255)
);

create table Orders(
    order_id serial primary key,
    book_id int REFERENCES Books(book_id),
    customer_id int REFERENCES Customers(customer_id),
    order_date date,
    quantity int
);

insert into Books(title, author, price, quantity) values
('Database 101', 'A. Smith', 40.00, 10),
('Learn SQL', 'B. Johnson', 35.00, 15),
('Advanced DB', 'C. Lee', 50.00, 5);

insert into Customers(customer_id,name, email) values
(101,'John Doe', 'johndoe@example.com'),
(102,'Jane Doe', 'janedoe@example.com');


-- task #1

create or replace procedure place_order(p_customer_id int, p_book_id int, p_quantity int)
as $$
begin
    insert into orders (order_id, book_id, customer_id, order_date, quantity)
    values (default, p_book_id, p_customer_id, current_date, p_quantity);

    update books
    set quantity = quantity - p_quantity
    where book_id = p_book_id;

    commit;
end;
$$ language plpgsql;


call place_order(101,1,2);
select * from Orders;

-- task#2
create or replace procedure attempt_to_order(p_customer_id int, p_book_id int, p_quantity int)
as $$
declare
    available_stock int;
begin
    select quantity into available_stock from books where book_id = p_book_id;

    if available_stock >= p_quantity then
        insert into orders (order_id, book_id, customer_id, order_date, quantity)
        values (default, p_book_id, p_customer_id, current_date, p_quantity);

        update books
        set quantity = quantity - p_quantity
        where book_id = p_book_id;

        commit;
    else
        raise notice 'There are not enough books in stock';
        rollback;
    end if;
end;
$$ language plpgsql;

call attempt_to_order(102,3,10);
select * from Orders;
select * from Books;


-- task#3
create or replace procedure update_book_price(p_book_id int, p_new_price decimal)
as $$
begin
    set transaction isolation level read committed;

    update books
    set price = p_new_price
    where book_id = p_book_id;

    commit;
end;
$$ language plpgsql;

create or replace procedure read_book_price(p_book_id int)
as $$
begin
    set transaction isolation level read committed;

    raise notice 'book price: %', (select price from books where book_id = p_book_id);

    commit;
end;
$$ language plpgsql;

call update_book_price(1,45.00);
call read_book_price(1);

-- task#4

create or replace procedure update_customer_email(p_customer_id int, p_new_email varchar)
as $$
begin
    update customers
    set email = p_new_email
    where customer_id = p_customer_id;

    commit;
end;
$$ language plpgsql;

call update_customer_email(101, 'newemail@example.com');
select * from Customers;
