create database lab_7;
create table dealer (
                        id integer primary key ,
                        name varchar(255),
                        location varchar(255),
                        commission float
);

INSERT INTO dealer (id, name, location, commission) VALUES (101, 'Oleg', 'Astana', 0.15);
INSERT INTO dealer (id, name, location, commission) VALUES (102, 'Amirzhan', 'Almaty', 0.13);
INSERT INTO dealer (id, name, location, commission) VALUES (105, 'Ademi', 'Taldykorgan', 0.11);
INSERT INTO dealer (id, name, location, commission) VALUES (106, 'Azamat', 'Kyzylorda', 0.14);
INSERT INTO dealer (id, name, location, commission) VALUES (107, 'Rahat', 'Satpayev', 0.13);
INSERT INTO dealer (id, name, location, commission) VALUES (103, 'Damir', 'Aktobe', 0.12);

create table client (
                        id integer primary key ,
                        name varchar(255),
                        city varchar(255),
                        priority integer,
                        dealer_id integer references dealer(id)
);

INSERT INTO client (id, name, city, priority, dealer_id) VALUES (802, 'Bekzat', 'Satpayev', 100, 101);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (807, 'Aruzhan', 'Almaty', 200, 101);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (805, 'Али', 'Almaty', 200, 102);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (808, 'Yerkhan', 'Taraz', 300, 102);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (804, 'Aibek', 'Kyzylorda', 300, 106);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (809, 'Arsen', 'Taldykorgan', 100, 103);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (803, 'Alen', 'Shymkent', 200, 107);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (801, 'Zhandos', 'Astana', null, 105);

create table sell (
                      id integer primary key,
                      amount float,
                      date timestamp,
                      client_id integer references client(id),
                      dealer_id integer references dealer(id)
);

INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (201, 150.5, '2021-10-05 00:00:00.000000', 805, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (209, 270.65, '2021-09-10 00:00:00.000000', 801, 105);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (202, 65.26, '2021-10-05 00:00:00.000000', 802, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (204, 110.5, '2021-08-17 00:00:00.000000', 809, 103);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (207, 948.5, '2021-09-10 00:00:00.000000', 805, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (205, 2400.6, '2021-07-27 00:00:00.000000', 807, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (208, 5760, '2021-09-10 00:00:00.000000', 802, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (210, 1983.43, '2021-10-10 00:00:00.000000', 804, 106);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (203, 2480.4, '2021-10-10 00:00:00.000000', 809, 103);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (212, 250.45, '2021-06-27 00:00:00.000000', 808, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (211, 75.29, '2021-08-17 00:00:00.000000', 803, 107);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (213, 3045.6, '2021-04-25 00:00:00.000000', 802, 101);

-- drop table client;
-- drop table dealer;
-- drop table sell;

--1a
select client.id,client.name,client.priority,dealer.name from client left outer join
                                                              dealer  on client.dealer_id = dealer.id where client.priority<300;
--1b
select * from dealer cross join client;
--1c
select dealer.name,client.name,client.city,sell.id,sell.date,sell.amount from dealer
                                                                                  join client on dealer.id = client.dealer_id join sell on client.id = sell.client_id;
--1d
select dealer.name,dealer.location,client.name from dealer
                                                        join client on dealer.id = client.dealer_id where dealer.location=client.city;
--1e
select sell.id,sell.amount,client.name,client.city from sell
                                                            join client on sell.client_id = client.id where sell.amount between 200 and 500;
--1f
select dealer.name,count(client.id) from client right join dealer on client.dealer_id = dealer.id group by dealer.id;
--1g
select client.name,client.city,dealer.name,dealer.commission from dealer join client on dealer.id = client.dealer_id;
select client.name,client.city,dealer.name,dealer.commission from client left join dealer on client.dealer_id = dealer.id;
--1h
select client.name, client.city, dealer.name, dealer.commission from client join dealer on client.dealer_id = dealer.id
where dealer.commission > 0.13;
--1i
select client.name, client.city, sell.id, sell.date, sell.amount, dealer.name, dealer.commission
from client join sell on client.id = sell.client_id join dealer on client.dealer_id = dealer.id;
--1j
select client.name, client.city, client.priority, dealer.name, sell.id, sell.date, sell.amount from client left join dealer on client.dealer_id = dealer.id left join sell on client.id = sell.client_id where sell.amount>=2000 and client.priority is not null;


--2a
create view V as (select date,count(distinct client_id),avg(amount),sum(amount) from sell group by date);
select * from V;
--2b
create view V2 as (select date,sum(amount) from sell group by date order by sum(amount) desc limit 5);
select * from V2;
--2c
create view V3 as (select dealer_id,avg(amount),sum(amount) from sell group by dealer_id);
select * from V3;
--2d
create view V4 as (select dealer.location, sum(sell.amount)*dealer.commission as earn from dealer join sell on dealer.id = sell.dealer_id group by location,dealer.name,dealer.commission);
select * from V4;
--2e
create view V5 as (select dealer.location, count(sell.id), avg(amount), sum(amount) from sell join dealer on sell.dealer_id = dealer.id  group by dealer.location);
select * from V5;

create view E2(location, sal_number_of_sales, sal_average_amount, sal_total_amount) as
(select dealer.location, count(sell.id), avg(amount), sum(amount) from sell join dealer on sell.dealer_id = dealer.id  group by dealer.location);
select * from E2;
--2f
create view V6 as (select client.city, count(sell.id), avg(amount), sum(amount) from sell join client on sell.client_id = client.id  group by client.city);
select * from V6;

create view F2(city, exp_number_of_sales, exp_average_amount, exp_total_amount)
as (select client.city, count(sell.id), avg(amount), sum(amount) from sell join client on sell.client_id = client.id  group by client.city);
select * from F2;
--2g
create view G as (select * from E2 join F2 on E2.location = F2.city where F2.exp_total_amount > E2.sal_total_amount);
select * from G;
