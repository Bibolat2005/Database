create database lab_9;
CREATE TABLE Employee (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    department VARCHAR(100),
    salary DECIMAL(10, 2)
);
INSERT INTO Employee (name, age, department, salary) VALUES
    ('John Doe', 30, 'IT', 50000.00),
    ('Alice Smith', 28, 'HR', 45000.00),
    ('Bob Johnson', 35, 'Finance', 60000.00),
    ('Emily Brown', 32, 'Marketing', 52000.00),
    ('Michael Davis', 29, 'Sales', 48000.00);
select * from Employee;

CREATE TABLE Product (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(100),
    price DECIMAL(10, 2)
);
INSERT INTO Product (name, category, price) VALUES
    ('Product 1', 'Electronics', 499.99),
    ('Product 2', 'Clothing', 39.99),
    ('Product 3', 'Electronics', 899.99),
    ('Product 4', 'Home Decor', 129.99),
    ('Product 5', 'Clothing', 59.99);
select * from Product;

--1task
create or replace function increase_value(value int)
    returns int as
$$
declare
    increased_value int;
begin
    increased_value := value + 10;
    return increased_value;
end;
$$
    language plpgsql;
select increase_value(9);

--2task
create or replace function compare_numbers(a int, b int, out result text)
    returns text as
$$
begin
    if a > b then
        result := 'a is greater than b';
    elsif a < b then
        result := 'a is lesser than b';
    else
        result := 'a and b are equal';
    end if;
    result := result::text;
end;
$$ language plpgsql;
select compare_numbers(4,5);

--3task
create or replace function number_series(n int)
    returns table (series_number int) as
$$
declare
    i int := 1;
begin
    while i < n LOOP
            series_number := i;
            return NEXT;
            i := i + 1;
        end loop;
end;
$$ language plpgsql;
select number_series(8);

--4task
CREATE OR REPLACE FUNCTION find_employee(emp_name VARCHAR)
    RETURNS TABLE (employee_id INT, employee_name VARCHAR, employee_age INT, employee_department VARCHAR, employee_salary DECIMAL) AS $$
BEGIN
    RETURN QUERY SELECT id, name, age, department, salary
                 FROM Employee
                 WHERE name = emp_name;
END;
$$ LANGUAGE plpgsql;
select * from find_employee('Alice Smith');

--5task
CREATE OR REPLACE FUNCTION list_products(prod_category VARCHAR)
    RETURNS TABLE (product_id INT, product_name VARCHAR, product_category VARCHAR, product_price DECIMAL) AS $$
BEGIN
    RETURN QUERY SELECT id, name, category, price
                 FROM Product
                 WHERE category = prod_category;
END;
$$ LANGUAGE plpgsql;
select * from list_products('Electronics');

--6task
CREATE TABLE EmployeeNew (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2)
);

CREATE TABLE Bonus (
    id SERIAL PRIMARY KEY,
    employee_id INT,
    bonus_amount DECIMAL(10, 2),
    FOREIGN KEY (employee_id) REFERENCES Employee(id)
);

INSERT INTO EmployeeNew (name, salary) VALUES
    ('John Doe', 50000.00),
    ('Alice Smith', 45000.00),
    ('Bob Johnson', 60000.00),
    ('Emily Brown', 52000.00),
    ('Michael Davis', 48000.00);
select * from EmployeeNew;

CREATE OR REPLACE FUNCTION calculate_bonus(employee_id INT)
    RETURNS int AS
$$
DECLARE
    bonus DECIMAL;
BEGIN
    SELECT salary * 0.75 INTO bonus
    FROM Employee
    WHERE id = employee_id;

    RETURN bonus;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_salary(employee_id INT)
    RETURNS VOID AS $$
DECLARE
    bonus_amount DECIMAL;
    new_salary DECIMAL;
BEGIN
    bonus_amount := calculate_bonus(employee_id);

    SELECT salary INTO new_salary
    FROM Employee
    WHERE id = employee_id;

    UPDATE Employee SET salary = new_salary + bonus_amount WHERE id = employee_id;
END;
$$ LANGUAGE plpgsql;

SELECT update_salary(1);
SELECT * FROM Employee WHERE id = 1;

--7task
create or replace function complex_calculation(value1 int, value2 varchar)
    returns text as
$$
declare
    result_text text;
    result_numeric int;
begin
    <<main_block>>
    begin
        <<string_manipulation_block>>
        begin
            result_text := 'Value: ' || value1 || ' + ' || value2;
        exception
            when others then
                result_text := 'Error in string manipulation';
        end string_manipulation_block;
        <<numeric_computation_block>>
        begin
            result_numeric := value1 + length(value2);
        exception
            when others then
                result_numeric := -1;
        end numeric_computation_block;

        if result_numeric >= 0 then
            result_text := result_text || ' Result Numeric: ' || result_numeric;
        else
            result_text := result_text || ' Error in numeric computation';
        end if;
    exception
        when others then
            result_text := ' Overall error';
    end main_block;
    return result_text;
end;
$$ language plpgsql;

select complex_calculation(1,'Teacher');