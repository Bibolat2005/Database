create database lab10;

create table Books(
    book_id serial primary key,
    title varchar(200),
    author varchar(200),
    price decimal,
    quantity integer
);

create table orders(
    order_id serial primary key,
    book_id int references books(book_id),
    customer_id integer,
    order_date date,
    quantity integer
);

create table customers(
    customer_id serial primary key,
    name varchar(200),
    email varchar(200)
);


insert into Books(book_id,title,author,price,quantity)
values (1, 'Database 101', 'A.Smith', 40, 10),
       (2, 'Learn SQL', 'B.Johnson', 35, 15),
       (3, 'Advanced DB', 'C.Lee', 50 ,5);



insert into customers(customer_id, name, email)
values (101, 'John Doe', 'johndoe@example.com'),
       (102, 'Jane Doe', 'janedoe@example.com');



insert into orders(book_id, customer_id, order_date, quantity)
values (1, 103, '2023-01-01', 2),
       (3, 104, '2022-11-21', 10);

-- task 1 --
begin;
update Books
set quantity = quantity + 2
where book_id = 1;
commit;
select * from Books;

-- task 2 --
begin;
do $$
    <<outer_block>>
    begin
        declare
            available_quantity integer;
        begin select quantity into available_quantity
              from Books where book_id = 3;
        if available_quantity < 10 then raise exception 'Insufficient';
        end if;
        end;
        update Books
        set quantity = quantity - 10 where book_id = 3;
    end outer_block $$;
commit;
select * from Books;





-- task 3 --
set transaction isolation level read committed;
begin;
update Books
set price = 30
where book_id = 1;
commit;
select * from Books;




-- task 4
begin;
update customers
set email = 'myemail@example.com'
where customer_id = 101;
commit;
select * from customers where customer_id = 102;




