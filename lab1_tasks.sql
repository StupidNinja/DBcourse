

CREATE DATABASE lab1;


CREATE TABLE users (
    id SERIAL,
    firstname VARCHAR(50),
    lastname VARCHAR(50)
);


ALTER TABLE users
ADD COLUMN isadmin INTEGER;


ALTER TABLE users
ALTER COLUMN isadmin TYPE BOOLEAN;


ALTER TABLE users
ALTER COLUMN isadmin SET DEFAULT FALSE;


ALTER TABLE users
ADD CONSTRAINT users_pkey PRIMARY KEY (id);


CREATE TABLE tasks (
    id SERIAL,
    name VARCHAR(50),
    user_id INTEGER
);


DROP TABLE tasks;


DROP DATABASE lab1;
