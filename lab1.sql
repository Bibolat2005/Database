create database lab1;
create table students
(
    id        serial primary key,
    firstname varchar(50),
    lastname  varchar(50)
);


insert into students(firstname, lastname)
VALUES ('Bibolat','Kaldybay'),
       ('Ilias','Bekturgan');


select * from students;
alter table students
    add column is_admin integer;



alter table students
    alter column is_admin set data type boolean
        using is_admin::boolean;



alter table students
    alter column is_admin set default false;


create table tasks
(
    id integer,
    name varchar(50),
    user_id integer
);


select * from tasks;


drop table tasks;
drop database lab1;

