create database lab_8;

create table countries(
    country_id serial primary key,
    name varchar(100)
);

create table departments(
    department_id serial primary key,
    department_name varchar(100) unique,
    budget integer,
    country_id integer references countries
);

create table employees(
    employee_id serial primary key,
    name varchar(100),
    surname varchar(100),
    salary integer,
    department_id integer references departments
);

INSERT INTO countries (country_id, name)
VALUES
    (1, 'France'),
    (2, 'China'),
    (3, 'Brazil'),
    (4, 'Australia'),
    (5, 'India'),
    (6, 'Japan'),
    (7, 'United Kingdom'),
    (8, 'South Africa'),
    (9, 'Mexico'),
    (10, 'Italy'),
    (11, 'Spain'),
    (12, 'Argentina'),
    (13, 'South Korea'),
    (14, 'Netherlands'),
    (15, 'Sweden'),
    (16, 'Switzerland'),
    (17, 'Norway'),
    (18, 'Denmark'),
    (19, 'Finland'),
    (20, 'Austria'),
    (21, 'Belgium'),
    (22, 'Portugal'),
    (23, 'Greece'),
    (24, 'Turkey'),
    (25, 'Poland'),
    (26, 'Kazakhstan'),
    (27, 'Russia'),
    (28, 'USA'),
    (29, 'Canada'),
    (30, 'Germany');

drop table departments cascade;
INSERT INTO departments (department_id, department_name, budget, country_id)
VALUES
    (90, 'Research and Development', 160000, 6),
    (100, 'Customer Support', 90000, 7),
    (110, 'Logistics Department', 140000, 8),
    (120, 'Quality Assurance', 95000, 9),
    (130, 'Public Relations', 80000, 10),
    (140, 'Legal Department', 110000, 11);

drop table employees cascade;
INSERT INTO employees (name, surname, salary, department_id)
VALUES
    ('Matthew', 'Clark', 67000, 90),
    ('Olivia', 'White', 83000, 100),
    ('Ethan', 'Harris', 69000, 110),
    ('Lauren', 'Davis', 82000, 120),
    ('Christopher', 'Thomas', 71000, 130),
    ('Ashley', 'Lee', 95000, 140);

select * from countries where name = 'Italy';
create index ind_country_name on countries(name);

select * from employees where name = 'Ethan' and surname = 'Harris';
create index ind_employees_name_and_surname on employees(name,surname);

SELECT * FROM employees WHERE salary < 95000 and salary > 71000;
create unique index ind_emp_salary on employees(salary);


SELECT * FROM employees WHERE substring(name from 1 for 4) = 'Laur';
CREATE INDEX index_employees_name_substring ON employees(name);


SELECT * FROM employees e JOIN departments d
    ON d.department_id = e.department_id WHERE d.budget > 90000 AND e.salary < 140000;
CREATE INDEX index_employees_salary_budget ON employees(name,department_id);
