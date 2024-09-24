CREATE DATABASE lab2;

CREATE TABLE countries (
    country_id SERIAL PRIMARY KEY,
    country_name VARCHAR(255),
    region_id INTEGER,
    population INTEGER
);

INSERT INTO countries (country_name, region_id, population)
VALUES ('Kazakhstan', 1, 18754440);

INSERT INTO countries (country_id, country_name)
VALUES (2, 'Uzbekistan');

INSERT INTO countries (country_name, region_id, population)
VALUES ('Turkmenistan', NULL, 6031200);

INSERT INTO countries (country_name, region_id, population)
VALUES
('Tajikistan', 2, 9649121),
('Kyrgyzstan', 3, 6524195),
('Afghanistan', 4, 38928341);

ALTER TABLE countries
ALTER COLUMN country_name SET DEFAULT 'Kazakhstan';

INSERT INTO countries (region_id, population)
VALUES (5, 1000000);

INSERT INTO countries DEFAULT VALUES;

CREATE TABLE countries_new (LIKE countries INCLUDING ALL);

INSERT INTO countries_new SELECT * FROM countries;

UPDATE countries
SET region_id = 1
WHERE region_id IS NULL;

SELECT country_name,
       (population * 1.10) AS "New Population"
FROM countries;

DELETE FROM countries
WHERE population < 100000;

DELETE FROM countries_new
WHERE country_id IN (SELECT country_id FROM countries)
RETURNING *;

DELETE FROM countries
RETURNING *;
