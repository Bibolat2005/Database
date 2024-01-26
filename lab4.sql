create database lab_4;
create table Warehouses(
    code integer primary key,
    location varchar(255),
    capacity integer
);

create table Packs(
    code char(4),
    contents varchar(255),
    value integer,
    warehouses integer references Warehouses(code)
);


drop table Packs;
drop table Warehouses;


INSERT INTO Warehouses(code, location, capacity) VALUES(1, 'Chicago', 3);
INSERT INTO Warehouses(code, location, capacity) VALUES(2, 'Rocks', 4);
INSERT INTO Warehouses(code, location, capacity) VALUES(3, 'New York', 7);
INSERT INTO Warehouses(code, location, capacity) VALUES(4, 'Los Angeles', 2);
INSERT INTO Warehouses(code, location, capacity) VALUES(5, 'San Francisko', 8);

INSERT INTO Packs(code, contents, value, warehouses) VALUES ('0MN7', 'Rocks', 180, 3);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('4H8P', 'Rocks', 250, 1);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('4RT3', 'Scissors', 190, 4);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('7G3H', 'Rocks', 200, 1);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('8JN6', 'Papers', 75, 1);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('8Y6U', 'Papers', 50, 3);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('9J6F', 'Papers', 175, 2);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('LL08', 'Rocks', 140, 4);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('P0H6', 'Scissors', 125, 1);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('P2T6', 'Scissors', 150, 2);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('TUSS', 'Papers', 90, 5);


SELECT * from Packs;

SELECT * from Packs
WHERE value>190;

SELECT DISTINCT contents FROM Packs;

SELECT warehouses,count(*) FROM Packs GROUP BY warehouses;

SELECT warehouses,count(warehouses) FROM Packs GROUP BY warehouses HAVING count(warehouses)>2;


INSERT INTO Warehouses (code,location, capacity) VALUES (6,'Texas',5);

INSERT INTO Packs VALUES('H5RT','Papers',150,2);

UPDATE Packs SET value=value*0.82
WHERE value=(
    SELECT value FROM Packs order by value DESC LIMIT 1 OFFSET 2
    );

DELETE FROM Packs WHERE value<150;

DELETE from Packs WHERE warehouses in (SELECT code from warehouses where location='Chicago')
returning *;



