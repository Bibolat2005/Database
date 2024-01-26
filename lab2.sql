create database lab2;
create table employees(
    emp_no integer primary key,
    birth_date date,
    first_name varchar(14),
    last_name varchar(16),
    gender char,
    hire_date date
);
create table departments(
    dept_no char primary key,
    dept_name varchar(40)
);
create table dept_manager(
    dept_no char(4) references departments(dept_no),
    emp_no integer references employees(emp_no),
    from_date date,
    to_date date
);
create table dept_emp(
    emp_no integer references employees(emp_no),
    dept_no char(4) references departments(dept_no),
    from_date date,
    to_date date
);
create table salaries(
    emp_no integer references employees(emp_no),
    salary integer,
    from_date date,
    to_date date
);
create table titles(
    emp_no integer references employees(emp_no),
    title varchar(50),
    from_date date,
    to_date date
);

select * from employees;
select * from titles;
select * from dept_manager;
select * from dept_emp;
select * from departments;
select * from salaries;
drop table departments;


create table students(
    full_name varchar(50) primary key ,
    age integer,
    birth_date date,
    gender char,
    average_grade float,
    nationality varchar(50),
    phone_number varchar(50) ,
    social_category varchar(50)
);
create table instructors(
    full_name varchar(50) references students(full_name),
    spoken_language varchar(50),
    work_experience integer,
    have_remote_lessons boolean
);
create table student_relatives(
    full_name varchar(50) references students(full_name),
    address varchar(50) primary key ,
    phone_number varchar(50),
    position integer
);
create table student_social_data(
    school varchar(50),
    graduation_date date,
    address varchar(50) references student_relatives(address),
    region varchar(50),
    country varchar(50),
    GPA float,
    honors varchar(50)
);
select * from students;
select * from student_relatives;
select * from student_social_data;
select * from instructors;

drop table students Cascade;
drop table instructors;
drop table student_social_data;
drop table student_relatives;

INSERT INTO students (full_name, age, birth_date, gender, average_grade, nationality, phone_number, social_category)
values ('Bibolat',18,'14-07-2005','b',3.27,'Kazakh','87717761396','Good'),
       ('Alikhan',16,'06-07-2007','b',3.21,'Kazakh','87717761393','excelent');

UPDATE students
SET  full_name='Student A'
where full_name='Bibolat';

DELETE from students where full_name='Alikhan';

alter table students
add column  id serial;

drop table students CASCADE;
drop database lab2;