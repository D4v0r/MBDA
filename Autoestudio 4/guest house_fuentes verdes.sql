--Atributos

ALTER TABLE room ADD CONSTRAINT id_condition CHECK(LENGTH(id) = 3);
ALTER TABLE booking ADD CONSTRAINT nights_condition CHECK(nights > 0 AND nights <= 30);
ALTER TABLE room ADD CONSTRAINT id_condition CHECK( LEFT(TO_STRING(id), 1) IN [1-5] AND RIGHT(TO_STRING(id),2) IN [0-10]);


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
también las tarifas definidas.*/
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

/*Las habitaciones se pueden eliminar si es la última del piso y no tiene reserva.*/
CREATE TRIGGER roomD
BEFORE DELETE
ON room
FOR EACH ROW
DECLARE
num NUMBER;
BEGIN
SELECT MAX(id) INTO num FROM room;
SELECT FROM booking WHERE booking


/* El identificador es un número consecutivo. */
CREATE TRIGGER id_consecutivo
BEFORE INSERT
ON booking
FOR EACH ROW
DECLARE
cont NUMBER;
BEGIN
SELECT COUNT(*)+1 INTO cont FROM booking;
:new.booking_id := cont;
END id_consecutivo;


/*El tipo de habitación asignado debe corresponder al solicitado.*/
CREATE TRIGGER room_typeT
BEFORE INSERT
ON booking
FOR EACH ROW
DECLARE
roomt VARCHAR;
BEGIN
SELECT room_type INTO romt FROM room WHERE id = :new.room_no;
IF :new.room_type_requested <> roomt 
THEN RAISE_APLICATION_ERROR(-20003,'No se puede ingresar');
END IF;
END room_typeT;

