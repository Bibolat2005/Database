create database lab5;
create table customers(
    customers_id integer primary key,
    cust_name varchar(100),
    city varchar(100),
    grade integer,
    salesman_id integer references salesman(salesman_id)
);

drop table customers CASCADE ;
create table orders(
    ord_no integer primary key,
    purch_amt float,
    ord_date date,
    customer_id integer references customers(customers_id),
    salesman_id integer references salesman(salesman_id)
);
drop table orders CASCADE;

INSERT INTO orders(ord_no, purch_amt, ord_date, customer_id, salesman_id)
VALUES  (70001, 150.5, '2012-10-05', 3005, 5002),
        (70009, 270.65, '2012-09-10', 3001, 5005),
        (70002, 65.26, '2012-10-05', 3002, 5001),
        (70004, 110.5, '2012-08-17', 3009, 5003),
        (70007, 948.5, '2012-09-10', 3005, 5002),
        (70005, 2400.6, '2012-07-27', 3007, 5001),
        (70008, 5760, '2012-09-10', 3002, 5001);



INSERT INTO customers(customers_id, cust_name, city, grade, salesman_id)
VALUES (3002,'Nick Rimando','New York',100,5001),
       (3005,'Graham Zusi','California',200,5002),
       (3001,'Brad Guzan','London',null,5005),
       (3004,'Fabian Johns','Paris',300,5006),
       (3007,'Brad Davis','New York',200,5001),
       (3009,'Geoff Camero','Berlin',100,5003),
       (3008,'Julian Green','London',300,5002);


drop table customers CASCADE;


create table salesman(
    salesman_id integer primary key,
    name varchar(100),
    city varchar(100),
    comission float
);

INSERT INTO salesman(salesman_id, name, city, comission)
VALUES
        (5001, 'James Hoog', 'New York', 0.15),
        (5002, 'Nail Knite', 'Paris', 0.13),
        (5005, 'Pit Alex', 'London', 0.11),
        (5006, 'Mc Lyon', 'Paris', 0.14),
        (5007, 'Paul Adam', 'Rome', 0.13),
        (5003, 'Lauson Hen', null , 0.12);


SELECT SUM(purch_amt) as total FROM orders;

SELECT avg(purch_amt) as total FROM orders;

SELECT count(cust_name) as num_list FROM customers WHERE cust_name is not null;

SELECT min(purch_amt) as minimum FROM orders;

SELECT * FROM customers WHERE cust_name LIKE '%b';

SELECT * FROM orders WHERE customer_id in(SELECT customers_id FROM customers WHERE city='New York');

SELECT * FROM customers WHERE customers_id in(SELECT customer_id FROM orders WHERE purch_amt>10);

SELECT sum(grade) FROM customers;

SELECT * FROM customers WHERE cust_name is not null;

SELECT max(grade) from customers;