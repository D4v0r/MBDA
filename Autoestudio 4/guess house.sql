
--TABLAS

CREATE TABLE guest  (
    id NUMBER(11),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    addres VARCHAR(50));

CREATE TABLE extra (
    extra_id NUMBER(11),
    booking_id NUMBER(11),
    description VARCHAR(50),
    amount DECIMAL(10,2));
    
CREATE TABLE booking (
    booking_id NUMBER(11),
    booking_date DATE,
    room_no NUMBER(11),
    guest_id NUMBER(11),
    occupants NUMBER(11),
    room_type_requested VARCHAR(6),
    nights NUMBER(11),
    arrival_time VARCHAR(6));
    
CREATE TABLE rate (
    room_type VARCHAR(6),
    occupancy NUMBER(11),
    amount DECIMAL(10,2));
    
CREATE TABLE room_type (
    id VARCHAR(6),
    description VARCHAR(100));

CREATE TABLE room (
    id NUMBER(11),
    room_type VARCHAR(6),
    max_occupancy NUMBER(11));
    
--ATRIBUTOS

ALTER TABLE guest MODIFY (id NOT NULL);
ALTER TABLE extra MODIFY (extra_id NOT NULL);
ALTER TABLE booking MODIFY (occupants NOT NULL);
ALTER TABLE booking MODIFY (nights NOT NULL);
ALTER TABLE booking MODIFY (guest_id NOT NULL);
ALTER TABLE booking MODIFY (booking_id NOT NULL);
ALTER TABLE rate MODIFY (occupancy NOT NULL );
ALTER TABLE rate MODIFY (room_type NOT NULL);
ALTER TABLE room_type MODIFY (id NOT NULL);
ALTER TABLE room MODIFY (id NOT NULL);


--PRIMARIAS

ALTER TABLE guest ADD CONSTRAINT GUEST_PK PRIMARY KEY (id);
ALTER TABLE extra ADD CONSTRAINT EXTRA_PK PRIMARY KEY (extra_id);
ALTER TABLE booking ADD CONSTRAINT BOOKING_PK PRIMARY KEY (booking_id);
ALTER TABLE rate ADD CONSTRAINT RATE_PK PRIMARY KEY (room_type, occupancy);
ALTER TABLE room_type ADD CONSTRAINT ROOM_TYPE_PK PRIMARY KEY (id);
ALTER TABLE room ADD CONSTRAINT ROOM_PK PRIMARY KEY (id);

--FORANEAS

ALTER TABLE booking ADD CONSTRAINT BOOKING_FK FOREIGN KEY (guest_id) REFERENCES guest(id);
ALTER TABLE extra ADD CONSTRAINT EXTRA_FK FOREIGN KEY (booking_id) REFERENCES booking( booking_id);
ALTER TABLE booking ADD CONSTRAINT BOOKING_FK2 FOREIGN KEY ( room_no ) REFERENCES room( id );
ALTER TABLE booking ADD CONSTRAINT BOOKING_FK3 FOREIGN KEY ( room_type_requested, occupants ) REFERENCES rate (room_type, occupancy);
ALTER TABLE booking ADD CONSTRAINT BOOKING_FK4 FOREIGN KEY ( room_type_requested ) REFERENCES room_type (id);
ALTER TABLE rate ADD CONSTRAINT RATE_FK FOREIGN KEY ( room_type ) REFERENCES room_type(id);
ALTER TABLE room ADD CONSTRAINT ROOM_FK FOREIGN KEY ( room_type ) REFERENCES room_type(id);

--PoblandoOK

/* SELECT * FROM room_type */
INSERT INTO room_type VALUES ('double','Fabulously appointed double room.');
INSERT INTO room_type VALUES ('family','Superior appartment for up to 3 people.');
INSERT INTO room_type VALUES ('single','Luxury accomodation suitable for one person.');
INSERT INTO room_type VALUES ('twin','Superb room with two beds.');

/* SELECT * FROM rate */
INSERT INTO rate VALUES ('double',1,56.00);
INSERT INTO rate VALUES ('double',2,72.00);
INSERT INTO rate VALUES ('family',1,56.00);
INSERT INTO rate VALUES ('family',2,72.00);
INSERT INTO rate VALUES ('family',3,84.00);
INSERT INTO rate VALUES ('single',1,48.00);
INSERT INTO rate VALUES ('twin',1,50.00);
INSERT INTO rate VALUES ('twin',2,72.00);*/

/* SELECT * FROM room */
INSERT INTO room VALUES (101,'single',1);
INSERT INTO room VALUES (102,'double',2);
INSERT INTO room VALUES (103,'double',2);
INSERT INTO room VALUES (104,'double',2);
INSERT INTO room VALUES (105,'family',3);
INSERT INTO room VALUES (106,'double',2);
INSERT INTO room VALUES (107,'double',2);
INSERT INTO room VALUES (108,'double',2);
INSERT INTO room VALUES (109,'double',2);
INSERT INTO room VALUES (110,'double',2);

/* SELECT * FROM guest */
INSERT INTO guest VALUES (1001,'Jim','Dowd','Lewisham West and Penge');
INSERT INTO guest VALUES (1002,'Lyn','Brown','West Ham');
INSERT INTO guest VALUES (1003,'Ann','Clwyd','Cynon Valley');
INSERT INTO guest VALUES (1004,'Nic','Dakin','Scunthorpe');
INSERT INTO guest VALUES (1005,'Pat','Glass','North West Durham');
INSERT INTO guest VALUES (1006,'Kate','Hoey','Vauxhall');
INSERT INTO guest VALUES (1007,'Mike','Kane','Wythenshawe and Sale East');
INSERT INTO guest VALUES (1008,'John','Mann','Bassetlaw');
INSERT INTO guest VALUES (1009,'Joan','Ryan','Enfield North');
INSERT INTO guest VALUES (1010,'Cat','Smith','Lancaster and Fleetwood');


/* SELECT * FROM booking */
INSERT INTO booking VALUES (5001, '03/nov/2016',101,1001,1,'single',7,'13:00');
INSERT INTO booking VALUES (5002, '04/nov/2016',102,1001,2,'double',7,'13:00');
INSERT INTO booking VALUES (5003, '03/nov/2016',103,1002,2,'double',7,'13:00');
INSERT INTO booking VALUES (5004, '05/nov/2016',104,1003,2,'double',7,'13:00');
INSERT INTO booking VALUES (5005, '06/nov/2016',105,1004,3,'family',7,'13:00');
INSERT INTO booking VALUES (5006, '03/nov/2016',106,1005,2,'double',7,'13:00');
INSERT INTO booking VALUES (5007, '03/nov/2016',107,1006,2,'double',7,'13:00');
INSERT INTO booking VALUES (5008, '04/nov/2016',108,1007,2,'double',7,'13:00');
INSERT INTO booking VALUES (5009, '06/nov/2016',109,1008,2,'double',7,'13:00');
INSERT INTO booking VALUES (5010, '03/nov/2016',110,1009,2,'double',7,'13:00');

/* SELET * FROM extra */
INSERT INTO extra VALUES (500101, 5001, 'Breakfast x 7', 63.00);
INSERT INTO extra VALUES (500201, 5002,	'Breakfast x 2', 18.00);
INSERT INTO extra VALUES (500301, 5003,	'Breakfast x 4', 36.00);
INSERT INTO extra VALUES (500401, 5003,	'Phone Calls £4.69', 4.69);
INSERT INTO extra VALUES (500501, 5003,	'Phone Calls £4.69', 4.69);
INSERT INTO extra VALUES (500601, 5003,	'Phone Calls £4.69', 4.69);
INSERT INTO extra VALUES (500701, 5008,	'Phone Calls £1.52', 1.52);
INSERT INTO extra VALUES (500801, 5008,	'Phone Calls £1.52', 1.52);

--PoblandoNoOK

INSERT INTO booking VALUES (' ', '2016-11-03',101,1001,1,'single',7,'13:00');
INSERT INTO booking VALUES (5001, '2016-11-03',101,1001,1,2016,7,'13:00');
INSERT INTO extra VALUES ( , 5001, 1122, 63.00);
INSERT INTO extra VALUES (5a, 5002,	'Breakfast x 2', 18.00);
INSERT INTO guest VALUES ('John',1008,'Mann','Bassetlaw');
INSERT INTO guest VALUES ('Glass','Joan',4444,1.45);
INSERT INTO rate VALUES ( , );
INSERT INTO rate VALUES (2,72.00,'13:00');
INSERT INTO room_type VALUES ( ,'Fabulously appointed double room.');
INSERT INTO room_type VALUES ('1.665','familyaddeggrgh gegtrtgtdrg Fabulously appointed double room. familyaddeggrgh gegtrtgtdrg Fabulously appointed double room');
INSERT INTO room VALUES ( ,'single',1);
INSERT INTO room VALUES (102,'double double double',2.78);

--Consultas

SELECT * FROM room_type;
SELECT * FROM rate;
SELECT * FROM room;
SELECT * FROM guest;
SELECT * FROM booking;
SELECT * FROM extra;

--XPoblar

TRUNCATE TABLE extra;
TRUNCATE TABLE booking;
TRUNCATE TABLE guest;
TRUNCATE TABLE room;
TRUNCATE TABLE rate;
TRUNCATE TABLE room_type;

--XTablas

DROP TABLE  extra;
DROP TABLE  booking;
DROP TABLE  guest;
DROP TABLE  room;
DROP TABLE  rate;
DROP TABLE  room_type;

--Atributos
ALTER TABLE room ADD CONSTRAINT id_condition CHECK(LENGTH(id) = 3);
ALTER TABLE booking ADD CONSTRAINT nights_condition CHECK(nights > 0 AND nights <= 30);
--ALTER TABLE room ADD CONSTRAINT id_condition CHECK( LEFT(TO_STRING(id), 1) IN [1-5] AND RIGHT(TO_STRING(id),2) IN [0-10]);

--Acciones
ALTER TABLE booking DROP CONSTRAINT BOOKING_FK2;
ALTER TABLE booking ADD CONSTRAINT BOOKING_FK2 FOREIGN KEY ( room_no )
REFERENCES room( id )ON DELETE CASCADE;

ALTER TABLE booking DROP CONSTRAINT BOOKING_FK;
ALTER TABLE booking ADD CONSTRAINT BOOKING_FK FOREIGN KEY (guest_id) REFERENCES guest(id)
ON DELETE CASCADE;

ALTER TABLE booking DROP CONSTRAINT BOOKING_FK3;
ALTER TABLE booking ADD CONSTRAINT BOOKING_FK3 FOREIGN KEY ( room_type_requested, occupants ) REFERENCES rate (room_type, occupancy)
ON DELETE CASCADE;

ALTER TABLE booking DROP CONSTRAINT BOOKING_FK4;
ALTER TABLE booking ADD CONSTRAINT BOOKING_FK4 FOREIGN KEY ( room_type_requested ) REFERENCES room_type (id)
ON DELETE CASCADE;

--Disparadores
/* El número máximo de ocupantes debe corresponder a una de las tarifas definidas.*/
CREATE TRIGGER max_occupancyT
BEFORE INSERT
ON room
FOR EACH ROW
DECLARE 
tarifa NUMBER;
BEGIN
SELECT MAX(t.occupancy) INTO tarifa FROM tarifa as t WHERE t.room_type = :new.room_type;
IF :new.max_occupancy <> tarifa THEN RAISE_application_error(-20001,'No se puede ingresar');
END IF;
END max_occupancyT;

/*El único dato a modificar el la ocupación máxima, pero sólo puede aumentar. Debe respetar
también las tarifas definidas.
*/
CREATE TRIGGER up_occupancy
BEFORE UPDATE OF max_occupancy
ON room
FOR EACH ROW
DECLARE
tarifa NUMBER;
BEGIN
SELECT MAX(occupancy) INTO tarifa FROM tarifa WHERE room_type = :new.room_type;
IF :new.max_occupancy < :old.max_occupancy  AND :new.max_occupancy <> tarifa
THEN RAISE_APPLICATION_ERROR(-20002,'No se puede actualizar');
END IF;
END up_occupancy;



    


    

    
    