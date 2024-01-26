create database lab_6;
create table locations(
    location_id serial primary key,
    street_address varchar(25),
    postal_code varchar(12),
    city varchar(30),
    state_province varchar(12)
);
create table departments(
    department_id serial primary key,
    department_name varchar(50) unique,
    budget integer,
    location_id integer references locations
);
create table employees(
    employee_id serial primary key,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(50),
    phone_number varchar(20),
    salary integer,
    department_id integer references departments
);
drop table locations CASCADE ;
drop table departments CASCADE;
drop table employees CASCADE;
INSERT INTO locations (street_address, postal_code, city, state_province)
VALUES
    ('123 Main St', '12345', 'Moscow', 'EX State'),
    ('456 Elm St', '54321', 'Sampletown', 'SA State'),
    ('789 Oak St', '98765', 'Testville', 'TE State'),
    ('101 Pine St', '11111', 'Sample City', 'SC State'),
    ('222 Cedar St', '22222', 'New Town', 'NT State');


INSERT INTO departments (department_id,department_name, budget, location_id)
VALUES
    (30,'HR Department', 100000, 1),
    (50,'IT Department', 150000, 2),
    (60,'Marketing Department', 120000, 3),
    (70,'Finance Department', 130000, 4),
    (80,'Sales Department', 110000, 5);

INSERT INTO employees (first_name, last_name, email, phone_number, salary, department_id)
VALUES
    ('John', 'Doe', 'john.doe@example.com', '555-123-4567', 60000, 30),
    ('Jane', 'Smith', 'jane.smith@example.com', '555-987-6543', 70000, 50),
    ('Mike', 'Johnson', 'mike.johnson@example.com', '555-555-5555', 80000, 60),
    ('Sarah', 'Williams', 'sarah.williams@example.com', '555-777-8888', 75000, 70),
    ('Chris', 'Brown', 'chris.brown@example.com', '555-444-3333', 85000, 80);

SELECT first_name,last_name,department_name,d.department_id FROM employees JOIN departments d on d.department_id = employees.department_id;
SELECT first_name,last_name,department_name,d.department_id FROM employees JOIN departments d on (d.department_id = 30 or d.department_id=80) and (employees.department_id=d.department_id);
SELECT first_name,last_name,departments.department_name,city,state_province FROM employees join departments on employees.department_id=departments.department_id join locations on departments.location_id=locations.location_id;
SELECT employees.first_name,employees.last_name,departments.department_id,departments.department_name from employees right outer join departments on departments.department_id = employees.department_id;
SELECT employees.first_name,employees.last_name,departments.department_id,departments.department_name from employees left outer join departments on departments.department_id = employees.department_id;
SELECT employees.last_name,employees.first_name, city FROM employees join departments on employees.department_id = departments.department_id join locations l on departments.location_id = l.location_id WHERE city='Moscow';

