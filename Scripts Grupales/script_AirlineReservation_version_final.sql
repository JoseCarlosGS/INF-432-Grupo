--- ELIMINACION COMPLETA DEL DATABASE

/*
USE master;
GO
ALTER DATABASE AirlineReservation
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
GO
DROP DATABASE AirlineReservation;
GO

*/
------------ FIN DE METODOS PARA ELIMINAR

If Not Exists(select * from sys.indexes where object_id=OBJECT_ID (N'dbo.frequent_flyer_card')and name='_IDX_frequent_flyer_card_ffc_number_')
Begin
----- CREACION DE LA BASE DE DATOS ---------------
IF NOT EXISTS(SELECT name FROM master.sys.databases WHERE name='AirlineReservation')
	BEGIN	
	CREATE DATABASE AirlineReservation;
	PRINT'Base de datos creada exitosamente';
	END
ELSE
	BEGIN
		PRINT 'La base de datos ya existe';
	END
END
GO
--------------
USE AirlineReservation;
GO
--------------
--IF OBJECT_ID('customers','U') IS NOT NULL
--DROP TABLE customers;
--GO


------- persona------------
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'person') AND type = N'U')
BEGIN
    CREATE TABLE person (
        id INT PRIMARY KEY IDENTITY(1,1),
	[name] VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
    );
END ELSE
BEGIN
 print 'ya existe la tabla person';
END
GO
If not Exists(Select * from sys.indexes where object_id=OBJECT_ID(N'dbo.person')and name='IDX_person_name_')
Begin
CREATE INDEX IDX_person_name_ ON person([name]);
End
 Else
 Begin
  print'El índice de person_name ya ha sido creado!!'
 End
GO

----- CLIENTE---------------------
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'customer') AND type = N'U')
BEGIN
    CREATE TABLE customer(
	id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	date_of_birth DATE NOT NULL,
	id_person INT NOT NULL,
	FOREIGN KEY(id_person) REFERENCES person(id),
	CONSTRAINT CHK_customer_date_of_birth 
	CHECK (date_of_birth < GETDATE())
);
END ELSE
BEGIN
 print 'ya existe la tabla customer';
END
GO



-------------------- PAIS ------------------
IF NOT EXISTS( SELECT* FROM sys.objects WHERE object_id=OBJECT_ID (N'country') and type=N'U')
BEGIN
CREATE TABLE country(
	id INT PRIMARY KEY IDENTITY(1,1),
	"name" VARCHAR(100),
	CONSTRAINT UQ_country_name UNIQUE("name")
)
END
 ELSE
BEGIN
print'la tabla ya existe';
END
GO


---------------- CIUDAD ------------------
IF NOT EXISTS(SELECT * FROM sys.objects where object_id=OBJECT_ID(N'city') and type=N'U' )
BEGIN
CREATE TABLE city(
	id INT PRIMARY KEY IDENTITY(1,1),
	"name" VARCHAR(100) UNIQUE,
	id_country INT NOT NULL,
	FOREIGN KEY (id_country) REFERENCES country(id)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
	CONSTRAINT CHK_city_id_country CHECK(id_country>0)
)
END
 ELSE
BEGIN
print 'La tabla ya existe!!!'
END
GO


----------------- AEROPUERTO -----------------
IF not exists(select * from sys.objects where object_id=OBJECT_ID(N'airport')and type=N'U')
BEGIN
CREATE TABLE airport(
	id INT PRIMARY KEY IDENTITY(1,1),
	"name" VARCHAR(255) NOT NULL,
	id_city INT NOT NULL,
	FOREIGN KEY (id_city) REFERENCES city(id),
	CONSTRAINT CHK_airport_id_city CHECK(id_city>0)
)
END
 ELSE
BEGIN
print'La tabla airport ya existe!!!'
END
GO

IF NOT EXISTS (
    SELECT * 
    FROM sys.indexes 
    WHERE object_id = OBJECT_ID(N'dbo.airport') 
    AND name = N'IDX_airport_name_'
)
BEGIN
    CREATE INDEX IDX_airport_name_
    ON dbo.airport("name");
END;
 ELSE
Begin
print 'El índice airport_name ya ah sido creado!!!'
End
GO

------------------ 1 AEROLINEA --------------
IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id=OBJECT_ID(N'airline')AND type=N'U')
BEGIN
CREATE TABLE airline (
    id INT PRIMARY KEY IDENTITY(1,1),
    [name] VARCHAR(255) NOT NULL,
    code VARCHAR(10) NOT NULL,
	Grapchic VARCHAR(255),
    CONSTRAINT airline_code UNIQUE(code)
)
END
 ELSE
 BEGIN
  print 'La tabla airline ya existe!!!';
 END
GO

IF NOT EXISTS(SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID(N'dbo.airline')and name=N'IDX_airline_name')
BEGIN
CREATE INDEX IDX_airline_name ON airline([name]);
END 
 ELSE
BEGIN
  print 'El índice airline_name ya ah sido creado';
END
GO

---- NUMERO DE VUELO ------------
If not Exists(Select * from sys.objects where object_id=OBJECT_ID(N'flight_number')and type=N'U')
Begin
CREATE TABLE flight_number(
	id INT PRIMARY KEY IDENTITY(1,1),
	departure_time TIME NOT NULL,
	arrival_time TIME NOT NULL,
	"description" VARCHAR(255),
	"type" VARCHAR(255) NOT NULL,
	airline VARCHAR(255) NOT NULL,
	id_airport_start INT NOT NULL,
	id_airport_goal INT NOT NULL,
	id_airline INT NOT NULL,
	FOREIGN KEY(id_airline) REFERENCES airline(id),
	FOREIGN KEY(id_airport_start) REFERENCES airport(id),
	FOREIGN KEY(id_airport_goal) REFERENCES airport(id)
	ON DELETE CASCADE
	ON UPDATE CASCADE
)
End
 Else
Begin
print 'La tabla flight_number ya existe!!!'
End
GO



---------TARJETA DE VIAJERO FRECUENTE 
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'frequent_flyer_card') AND type = N'U')
BEGIN
    CREATE TABLE frequent_flyer_card (
	id INT PRIMARY KEY IDENTITY(1,1),
	ffc_number INT NOT NULL,
	miles INT,
	meal_code VARCHAR(10),
	id_customer INT NOT NULL,
	FOREIGN KEY(id_customer) REFERENCES customer(id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	CONSTRAINT UQ_frequent_flyer_card_ffc_number UNIQUE(ffc_number),
	CONSTRAINT CHK_miles CHECK (miles>0)
);
END ELSE
BEGIN
 print 'ya existe la tabla frequent_flyer_card';
END
GO
IF NOT EXISTS(SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID(N'dbo.frequent_flyer_card')and name=N'IDX_frequent_flyer_card_ffc_number')
BEGIN	
	CREATE INDEX IDX_frequent_flyer_card_ffc_number ON frequent_flyer_card(ffc_number);
	print'índice creado exitosamente!!';
End
 Else
Begin
 print 'El índice f_f_c_number ya ah sido creado';
End
GO


-------------------- TIPO DE DOCUMENTO ------------------
IF NOT EXISTS( SELECT* FROM sys.objects WHERE object_id=OBJECT_ID (N'document_type') and type=N'U')
BEGIN
CREATE TABLE document_type(
	id INT PRIMARY KEY IDENTITY(1,1),
	"name" VARCHAR(100),
	CONSTRAINT UQ_document_type_name UNIQUE("name")
)
END
 ELSE
BEGIN
print'la tabla ya existe';
END
GO

-------- DOCUMENTO DE IDENTIFICACION ---------
IF NOT EXISTS(SELECT* FROM sys.objects where object_id=OBJECT_ID(N'identification_document') and type=N'U' )
BEGIN
CREATE TABLE identification_document(
	id INT PRIMARY KEY IDENTITY(1,1),
	document_number VARCHAR(50) NOT NULL,
	document_type_id INT NOT NULL,
	issue_date DATE NOT NULL,
	expiration_date DATE NOT NULL,
	issue_country INT NOT NULL,
	FOREIGN KEY (issue_country) REFERENCES country(id),
	FOREIGN KEY (document_type_id) REFERENCES document_type(id),
	CONSTRAINT UQ_identification_document_document_number UNIQUE(document_number),
	CONSTRAINT CHK_identification_document_issue_date CHECK(issue_date<=GETDATE()),
	CONSTRAINT CHK_identification_document_expiration_date CHECK(expiration_date>GETDATE()),
)
END
 ELSE
BEGIN
print 'La tabla identification_document ya existe!!!';
END
GO

If Not Exists(select * from sys.indexes where object_id=OBJECT_ID(N'dbo.identification_document')and name='IDX_identification_document_document_number_')
Begin
CREATE INDEX IDX_identification_document_document_number_ ON identification_document(document_number);
 print'Índice creado exitosamente!!!'
End
 Else
Begin
 print'El índice i_doc_doc_number ya ah sido creado';
End
GO


------------------ METODO DE PAGO  -------------
If not Exists(Select *from sys.objects where object_id=OBJECT_ID(N'payment_method')and type=N'U')
Begin
CREATE TABLE payment_method (
    id INT PRIMARY KEY IDENTITY(1,1),
	number_card VARCHAR(255),
	type_method VARCHAR(20),
);
End
 Else
Begin
print 'La tabla payment_method ya existe'
End
GO

------------------ PAGO  -------------
If not Exists(Select *from sys.objects where object_id=OBJECT_ID(N'payment')and type=N'U')
Begin
CREATE TABLE payment (
    id INT PRIMARY KEY IDENTITY(1,1),
	amount FLOAT NOT NULL,
	date_of_pay DATE NOT NULL,
	id_payment_method INT NOT NULL,
	FOREIGN KEY (id_payment_method) REFERENCES payment_method(id),
    -- CONSTRAINT CHK_date_of_pay CHECK(date_of_pay>getDate()),
	CONSTRAINT CHK_amount CHECK(amount>=0)
);
End
 Else
Begin
print 'La tabla payment ya existe'
End
GO


--------- MODELO DE AVION ---------------
If Not Exists(select * from sys.objects where object_id=OBJECT_ID(N'plane_model')and type=N'U')
Begin
CREATE TABLE plane_model(
	id INT PRIMARY KEY IDENTITY(1,1),
	"description" VARCHAR(255),
	graphic VARCHAR(255),
)
End
 Else
Begin
print'La tabla plane_model ya existe!!!';
End
GO

----------------------- AVION ----------------
If not Exists(Select *from sys.objects where object_id=OBJECT_ID(N'airplane')and type=N'U')
Begin
CREATE TABLE airplane(
	id INT PRIMARY KEY IDENTITY(1,1),
	registration_number VARCHAR(15) NOT NULL,
	begin_of_operation DATE NOT NULL,
	"status" VARCHAR(50),
	id_plane_model INT NOT NULL,
	FOREIGN KEY (id_plane_model) REFERENCES plane_model(id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	CONSTRAINT UQ_airplane_registration_number UNIQUE(registration_number),
	CONSTRAINT CHK_airplane_begin_of_operation CHECK(begin_of_operation<=GETDATE())
);
End
 Else
 Begin
 print 'La tabla airplane ya existe!!!';
 End
GO

-------------------- VUELO ---------------
If Not Exists(select *from sys.objects where object_id=OBJECT_ID(N'flight')and type=N'U')
Begin
CREATE TABLE flight(
	id INT PRIMARY KEY IDENTITY(1,1),
	boarding_time TIME NOT NULL,
	flight_date DATE NOT NULL,
	gate VARCHAR(10) NOT NULL,
	check_in_counter VARCHAR(10) NOT NULL,
	id_flight_number INT NOT NULL,
	id_airplane INT NOT NULL,
	FOREIGN KEY(id_flight_number) REFERENCES flight_number(id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY(id_airplane) REFERENCES airplane(id),
	CONSTRAINT CHK_flight_flight_date CHECK(flight_date>GETDATE())
)
End
 Else
Begin
print'La tabla flight ya existe!!!'; 
End
GO

------------------ RESERVAS -------------
If not Exists(Select *from sys.objects where object_id=OBJECT_ID(N'reservation')and type=N'U')
Begin
CREATE TABLE reservation (
    id INT PRIMARY KEY IDENTITY(1,1),
    reservation_code VARCHAR(50) NOT NULL,
    reservation_date DATE NOT NULL,
    id_customer INT NOT NULL,
	id_payment INT NOT NULL,
    FOREIGN KEY(id_customer) REFERENCES customer(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
	FOREIGN KEY(id_payment) REFERENCES payment(id),
    CONSTRAINT UQ_reservation_code UNIQUE(reservation_code),
    CONSTRAINT CHK_reservation_date CHECK (reservation_date >= GETDATE())
);
End
 Else
Begin
print 'La tabla reservation ya existe'
End
GO

IF NOT EXISTS (
    SELECT * 
    FROM sys.indexes 
    WHERE object_id = OBJECT_ID(N'dbo.reservation') 
    AND name = N'IDX_reservation_code_'
)
BEGIN
    CREATE INDEX IDX_reservation_code_
    ON dbo.reservation(reservation_code);
END;
 ELSE
Begin
print 'El índice reservation_code ya ah sido creado!!!'
End
GO

------------   TICKET   ----------------
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ticket') AND type = N'U')
BEGIN
    CREATE TABLE ticket(
	id INT PRIMARY KEY IDENTITY(1,1),
	ticketing_code INT NOT NULL,
	number INT NOT NULL,
	id_reservation INT NOT NULL,
	id_person INT NOT NULL,
	id_identification_document INT NOT NULL,
	FOREIGN KEY(id_identification_document) REFERENCES identification_document(id),
	FOREIGN KEY (id_person) REFERENCES person(id),
	FOREIGN KEY (id_reservation) REFERENCES reservation(id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	CONSTRAINT UQ_ticket_ticketing_code_number UNIQUE (ticketing_code, number)
);
END ELSE
BEGIN
 print 'ya existe la tabla ticket';
END
GO

------------  CHECKIN-----------------
If not Exists(Select *from sys.objects where object_id=OBJECT_ID(N'checkin')and type=N'U')
Begin
CREATE TABLE checkin (
    id INT PRIMARY KEY IDENTITY(1,1),
	[date] DATE NOT NULL,
	[time] TIME NOT NULL,
	id_ticket INT NOT NULL,
	FOREIGN KEY(id_ticket) REFERENCES ticket(id),
    CONSTRAINT CHK_date_checkin CHECK([date]>getDate())
);
End
 Else
Begin
print 'La tabla checkin ya existe'
End
GO

------------  CANCELACION-----------------
If not Exists(Select *from sys.objects where object_id=OBJECT_ID(N'cancellation')and type=N'U')
Begin
CREATE TABLE cancellation (
    id INT PRIMARY KEY IDENTITY(1,1),
	[date] DATE NOT NULL,
	[time] TIME NOT NULL,
	id_ticket INT NOT NULL,
	FOREIGN KEY(id_ticket) REFERENCES ticket(id),
    CONSTRAINT CHK_date_cancellation CHECK([date]>getDate())
);
End
 Else
Begin
print 'La tabla cancelation ya existe'
End
GO



------- CLASEv-----------------------
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'coupon_class') AND type = N'U')
BEGIN
    CREATE TABLE coupon_class (
        id INT PRIMARY KEY IDENTITY(1,1),
	[name] VARCHAR(50) NOT NULL,
	CONSTRAINT UQ_coupon_class_name UNIQUE([name])
    );
END ELSE
BEGIN
 print 'ya existe la tabla coupon_class';
END
GO

-------------- CUPON -----------------
If not exists(select* from sys.objects where object_id=OBJECT_ID(N'coupon')and type=N'U')
Begin
CREATE TABLE coupon(
	id INT PRIMARY KEY IDENTITY(1,1),
	id_ticket INT NOT NULL,
	date_of_redemption DATE NOT NULL,
	class VARCHAR(255) NOT NULL,
	stand_by VARCHAR(255),
	meal_code VARCHAR(10),
	id_flight INT NOT NULL,
	id_class INT NOT NULL,
	FOREIGN KEY (id_ticket) REFERENCES ticket(id),
	FOREIGN KEY (id_flight) REFERENCES flight(id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY (id_class) REFERENCES coupon_class(id),
	CONSTRAINT CHK_coupon_date_of_redemption CHECK (date_of_redemption <= GETDATE()),
)
End
 Else
Begin
print 'La tabla coupon ya existe!!!';
End
GO

--------------------- EQUIPAJE ---------------------
If not Exists(select *from sys.objects where object_id=OBJECT_ID(N'pieces_of_luggage')and type=N'U')
Begin
CREATE TABLE pieces_of_luggage(
	id INT PRIMARY KEY IDENTITY(1,1),
	number INT NOT NULL,
	"weight" DECIMAL NOT NULL, 
	id_coupon INT NOT NULL,
	FOREIGN KEY (id_coupon) REFERENCES coupon(id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	CONSTRAINT CHK_pieces_of_luggage_weight CHECK ("weight" > 0),
    CONSTRAINT CHK_pieces_of_luggage_number CHECK (number > 0)
)
End
 Else
Begin
 print'La tabla lugage ya existe!!!';
End
GO


------------------ ASIENTO ----------------
If not Exists(select* from sys.objects where object_id=OBJECT_ID(N'seat')and type=N'U')
Begin
CREATE TABLE seat(
	id INT PRIMARY KEY IDENTITY(1,1),
	size DECIMAL NOT NULL,
	number INT NOT NULL,
	"location" VARCHAR(20),
	id_plane_model INT NOT NULL,
	FOREIGN KEY (id_plane_model) REFERENCES plane_model(id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	CONSTRAINT CHK_seat_size CHECK (size > 0),
    CONSTRAINT CHK_seat_number CHECK (number > 0)
)
End
 Else
Begin
 print'La tabla seat ya existe!!!';
End
GO


---------------- ASIENTOS DISPONIBLES ---------------------
If not exists(select * from sys.objects where object_id=OBJECT_ID(N'available_seat')and type=N'U')
Begin
CREATE TABLE available_seat(
	id INT PRIMARY KEY IDENTITY(1,1),
	id_coupon INT NOT NULL,
	id_flight INT NOT NULL,
	id_seat INT NOT NULL,
	FOREIGN KEY(id_coupon) REFERENCES coupon(id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY(id_flight) REFERENCES flight(id),
	FOREIGN KEY(id_seat) REFERENCES seat(id)
)
End
 Else
 Begin
  print'La tabla available_seat ya existe!!!';
 End
GO




----------------PERIODO DE USO----------------
If not Exists(Select *from sys.objects where object_id=OBJECT_ID(N'aircraft_assignment')and type=N'U')
Begin
CREATE TABLE aircraft_assignment(
	id INT PRIMARY KEY IDENTITY(1,1),
	start_of_operation DATE NOT NULL,
	end_of_operation DATE,
	id_airplane INT NOT NULL,
	id_airline INT NOT NULL,
	FOREIGN KEY (id_airplane) REFERENCES airplane(id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY (id_airline) REFERENCES airline(id),
	CONSTRAINT CHK_airplane_start_of_operation CHECK(start_of_operation<=GETDATE()),
	CONSTRAINT CHK_airplane_end_of_operation CHECK(end_of_operation > start_of_operation)
);
End
 Else
 Begin
 print 'La tabla aircraft_assignament ya existe!!!';
 End
GO


------- rol ----------------
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'role_flight') AND type = N'U')
BEGIN
    CREATE TABLE role_flight (
        id INT PRIMARY KEY IDENTITY(1,1),
	[name] VARCHAR(50) NOT NULL,
	CONSTRAINT UQ_role_name UNIQUE([name])
    );
END ELSE
BEGIN
 print 'ya existe la tabla role_flight';
END
GO



---------------- 3 TRIPULACION DE VUELO ------------------
If not exists(select* from sys.objects where object_id=OBJECT_ID(N'flight_crew')and type=N'U')
Begin
CREATE TABLE flight_crew (
    id INT PRIMARY KEY IDENTITY(1,1),
    role VARCHAR(100) NOT NULL,
    id_person INT NOT NULL,
    FOREIGN KEY(id_person) REFERENCES person(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
End
 Else
 Begin
 print'La tabla flight_crew ya existe!!!'; 
 End
GO

/*ALTER TABLE flight_crew
DROP COLUMN role;*/

---------------- 3 TRIPULACION DE VUELO-rol ------------------
If not exists(select* from sys.objects where object_id=OBJECT_ID(N'flight_crew_role')and type=N'U')
Begin
CREATE TABLE flight_crew_role (
    id INT PRIMARY KEY IDENTITY(1,1),
    role VARCHAR(100) NOT NULL,
	work_start_time TIME NOT NULL,
	work_end_time TIME NOT NULL,
	assignment_date DATE NOT NULL,
    id_role INT NOT NULL,
    id_flight INT NOT NULL,
    id_flight_crew INT NOT NULL,
    FOREIGN KEY(id_role) REFERENCES role_flight(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
	FOREIGN KEY(id_flight) REFERENCES flight(id),
	FOREIGN KEY(id_flight_crew) REFERENCES flight_crew(id)
)
End
 Else
 Begin
 print'La tabla flight_crew_role ya existe!!!'; 
 End
GO

/*
BULK INSERT
	customer
FROM 
	'D:\Carlos\Semestre2-2024Apuntes\Sistmas para el soporte\prueba.csv'
WITH(
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 1
)
*/

BEGIN TRANSACTION;
	IF NOT EXISTS (SELECT 1 FROM document_type WHERE name = 'Carnet de Identidad')
	BEGIN
		INSERT INTO document_type (name) VALUES ('Carnet de Identidad');
	END;
	IF NOT EXISTS (SELECT 1 FROM document_type WHERE name = 'Pasaporte')
	BEGIN
		INSERT INTO document_type (name) VALUES ('Pasaporte');
	END;
	IF NOT EXISTS (SELECT 1 FROM document_type WHERE name = 'Licencia de Conducir')
	BEGIN
		INSERT INTO document_type (name) VALUES ('Licencia de Conducir');
	END;
	IF NOT EXISTS (SELECT 1 FROM document_type WHERE name = 'Libreta de Servicio Militar')
	BEGIN
		INSERT INTO document_type (name) VALUES ('Libreta de Servicio Militar');
	END;
COMMIT TRANSACTION;


BEGIN TRANSACTION;

-- Realizar inserciones en la tabla plane_model solo si los registros no existen
MERGE plane_model AS target
USING (VALUES
    ('Boeing 737', 'https://example.com/graphics/boeing_737.png'),
    ('Airbus A320', 'https://example.com/graphics/airbus_a320.png'),
    ('Embraer 190', 'https://example.com/graphics/embraer_190.png'),
    ('Boeing 747', 'https://example.com/graphics/boeing_747.png'),
    ('Airbus A380', 'https://example.com/graphics/airbus_a380.png'),
    ('Boeing 767', 'https://example.com/graphics/boeing_767.png'),
    ('Boeing 777', 'https://example.com/graphics/boeing_777.png'),
    ('Boeing 787 Dreamliner', 'https://example.com/graphics/boeing_787.png'),
    ('Airbus A330', 'https://example.com/graphics/airbus_a330.png'),
    ('Airbus A350', 'https://example.com/graphics/airbus_a350.png'),
    ('Bombardier CRJ700', 'https://example.com/graphics/crj700.png'),
    ('Bombardier CRJ900', 'https://example.com/graphics/crj900.png'),
    ('Embraer E175', 'https://example.com/graphics/embraer_e175.png'),
    ('Cessna 172', 'https://example.com/graphics/cessna_172.png'),
    ('Cessna Citation CJ3', 'https://example.com/graphics/cessna_citation_cj3.png'),
    ('Dassault Falcon 7X', 'https://example.com/graphics/falcon_7x.png'),
    ('Gulfstream G650', 'https://example.com/graphics/gulfstream_g650.png'),
    ('Pilatus PC-12', 'https://example.com/graphics/pilatus_pc12.png'),
    ('Boeing 727', 'https://example.com/graphics/boeing_727.png'),
    ('McDonnell Douglas MD-80', 'https://example.com/graphics/md_80.png'),
    ('Sukhoi Superjet 100', 'https://example.com/graphics/sukhoi_superjet_100.png'),
    ('Tupolev Tu-154', 'https://example.com/graphics/tu_154.png'),
    ('Antonov An-225', 'https://example.com/graphics/an_225.png'),
    ('Concorde', 'https://example.com/graphics/concorde.png')
) AS source (description, graphic)
ON target.description = source.description
WHEN NOT MATCHED BY TARGET THEN
    INSERT (description, graphic)
    VALUES (source.description, source.graphic);

-- Commit the transaction
COMMIT TRANSACTION;

-----DATOS PARA AEROLINEA---------------------------
BEGIN TRANSACTION;

-- Realizar inserciones en la tabla airline solo si los registros no existen
MERGE airline AS target
USING (VALUES
    ('Delta Airlines', 'DL', 'https://example.com/logos/delta_airlines.png'),
    ('American Airlines', 'AA', 'https://example.com/logos/american_airlines.png'),
    ('United Airlines', 'UA', 'https://example.com/logos/united_airlines.png'),
    ('Southwest Airlines', 'WN', 'https://example.com/logos/southwest_airlines.png'),
    ('JetBlue Airways', 'B6', 'https://example.com/logos/jetblue.png'),
    ('Alaska Airlines', 'AS', 'https://example.com/logos/alaska_airlines.png'),
    ('Air Canada', 'AC', 'https://example.com/logos/air_canada.png'),
    ('British Airways', 'BA', 'https://example.com/logos/british_airways.png'),
    ('Lufthansa', 'LH', 'https://example.com/logos/lufthansa.png'),
    ('Air France', 'AF', 'https://example.com/logos/air_france.png'),
    ('Qatar Airways', 'QR', 'https://example.com/logos/qatar_airways.png'),
    ('Emirates', 'EK', 'https://example.com/logos/emirates.png'),
    ('Singapore Airlines', 'SQ', 'https://example.com/logos/singapore_airlines.png'),
    ('Cathay Pacific', 'CX', 'https://example.com/logos/cathay_pacific.png'),
    ('Qantas Airways', 'QF', 'https://example.com/logos/qantas.png'),
    ('KLM Royal Dutch Airlines', 'KL', 'https://example.com/logos/klm.png'),
    ('Turkish Airlines', 'TK', 'https://example.com/logos/turkish_airlines.png'),
    ('Aeroméxico', 'AM', 'https://example.com/logos/aeromexico.png'),
    ('LATAM Airlines', 'LA', 'https://example.com/logos/latam_airlines.png'),
    ('Iberia', 'IB', 'https://example.com/logos/iberia.png'),
    ('Virgin Atlantic', 'VS', 'https://example.com/logos/virgin_atlantic.png'),
    ('Japan Airlines', 'JL', 'https://example.com/logos/japan_airlines.png'),
    ('All Nippon Airways', 'NH', 'https://example.com/logos/ana.png'),
    ('Thai Airways', 'TG', 'https://example.com/logos/thai_airways.png'),
    ('Etihad Airways', 'EY', 'https://example.com/logos/etihad_airways.png')
) AS source ([name], code, Graphic)
ON target.code = source.code
WHEN NOT MATCHED BY TARGET THEN
    INSERT ([name], code, Grapchic)
    VALUES (source.[name], source.code, source.Graphic);

-- Commit the transaction
COMMIT TRANSACTION;

------------DATOS PARA AVION-----------------
BEGIN TRANSACTION;

-- Realizar inserciones en la tabla airplane solo si los registros no existen
MERGE airplane AS target
USING (VALUES
    ('N12345', '2020-01-15', 'Active', 1),   -- Boeing 737
    ('N54321', '2019-05-10', 'Maintenance', 2), -- Airbus A320
    ('N98765', '2021-07-20', 'Active', 3),   -- Embraer 190
    ('N34567', '2018-03-14', 'Inactive', 4), -- Boeing 747
    ('N76543', '2017-08-22', 'Active', 5),   -- Airbus A380
    ('N11223', '2022-02-25', 'Active', 6),   -- Boeing 767
    ('N33221', '2021-09-11', 'Maintenance', 7), -- Boeing 777
    ('N55678', '2023-01-05', 'Active', 8),   -- Boeing 787 Dreamliner
    ('N99887', '2020-11-08', 'Active', 9),   -- Airbus A330
    ('N44455', '2021-06-18', 'Maintenance', 10), -- Airbus A350
    ('N66677', '2019-04-27', 'Active', 11),  -- Bombardier CRJ700
    ('N77788', '2018-12-09', 'Active', 12),  -- Bombardier CRJ900
    ('N88899', '2022-07-03', 'Inactive', 13), -- Embraer E175
    ('N90909', '2021-02-14', 'Active', 14),  -- Cessna 172
    ('N10001', '2020-09-30', 'Maintenance', 15), -- Cessna Citation CJ3
    ('N11111', '2023-03-21', 'Active', 16),  -- Dassault Falcon 7X
    ('N22222', '2021-10-10', 'Active', 17),  -- Gulfstream G650
    ('N33333', '2020-06-06', 'Active', 18),  -- Pilatus PC-12
    ('N44444', '2019-12-22', 'Inactive', 19),-- Boeing 727
    ('N55555', '2023-01-15', 'Maintenance', 20), -- McDonnell Douglas MD-80
    ('N66666', '2018-08-16', 'Active', 21),  -- Sukhoi Superjet 100
    ('N77777', '2017-11-24', 'Inactive', 22),-- Tupolev Tu-154
    ('N88888', '2020-04-14', 'Active', 23),  -- Antonov An-225
    ('N99999', '2019-05-18', 'Inactive', 24) -- Concorde
) AS source (registration_number, begin_of_operation, [status], id_plane_model)
ON target.registration_number = source.registration_number
WHEN NOT MATCHED BY TARGET THEN
    INSERT (registration_number, begin_of_operation, [status], id_plane_model)
    VALUES (source.registration_number, source.begin_of_operation, source.[status], source.id_plane_model);

-- Commit the transaction
COMMIT TRANSACTION;

----DATOS PARA PAISES-------
BEGIN TRANSACTION;

-- Insertar países en la tabla country
MERGE country AS target
USING (VALUES
    ('Argentina'),
    ('Bolivia'),
    ('Brazil'),
    ('Chile'),
    ('Colombia'),
    ('Ecuador'),
    ('Paraguay'),
    ('Peru'),
    ('Uruguay'),
    ('Venezuela'),
    ('United States'),
    ('Canada'),
    ('Mexico'),
    ('United Kingdom'),
    ('Germany'),
    ('France'),
    ('Italy'),
    ('Spain'),
    ('Netherlands'),
    ('Switzerland'),
    ('Russia'),
    ('China'),
    ('Japan'),
    ('South Korea'),
    ('India'),
    ('Australia'),
    ('New Zealand'),
    ('Saudi Arabia'),
    ('Turkey'),
    ('Israel'),
    ('South Africa')
) AS source ([name])
ON target.[name] = source.[name]
WHEN NOT MATCHED BY TARGET THEN
    INSERT ([name])
    VALUES (source.[name]);

COMMIT TRANSACTION;

BEGIN TRANSACTION;

-- Insertar ciudades en la tabla city
MERGE city AS target
USING (VALUES
    ('Buenos Aires', 1),    -- Argentina
    ('La Paz', 2),          -- Bolivia
    ('Sao Paulo', 3),       -- Brazil
    ('Rio de Janeiro', 3),  -- Brazil
    ('Santiago', 4),        -- Chile
    ('Bogota', 5),          -- Colombia
    ('Quito', 6),           -- Ecuador
    ('Asuncion', 7),        -- Paraguay
    ('Lima', 8),            -- Peru
    ('Montevideo', 9),      -- Uruguay
    ('Caracas', 10),        -- Venezuela
    ('New York', 11),       -- United States
    ('Los Angeles', 11),    -- United States
    ('Toronto', 12),        -- Canada
    ('Vancouver', 12),      -- Canada
    ('Mexico City', 13),    -- Mexico
    ('London', 14),         -- United Kingdom
    ('Berlin', 15),         -- Germany
    ('Paris', 16),          -- France
    ('Rome', 17),           -- Italy
    ('Madrid', 18),         -- Spain
    ('Amsterdam', 19),      -- Netherlands
    ('Zurich', 20),         -- Switzerland
    ('Moscow', 21),         -- Russia
    ('Beijing', 22),        -- China
    ('Tokyo', 23),          -- Japan
    ('Seoul', 24),          -- South Korea
    ('Mumbai', 25),         -- India
    ('Sydney', 26),         -- Australia
    ('Auckland', 27),       -- New Zealand
    ('Riyadh', 28),         -- Saudi Arabia
    ('Istanbul', 29),       -- Turkey
    ('Tel Aviv', 30),       -- Israel
    ('Cape Town', 31)       -- South Africa
) AS source ([name], id_country)
ON target.[name] = source.[name]
WHEN NOT MATCHED BY TARGET THEN
    INSERT ([name], id_country)
    VALUES (source.[name], source.id_country);

COMMIT TRANSACTION;
------------------------------DATOS PARA AEROPUERTOS----------------

BEGIN TRANSACTION;

-- Insertar aeropuertos en la tabla airport
MERGE airport AS target
USING (VALUES
    ('Aeropuerto Internacional de Ezeiza', 1),       -- Buenos Aires
    ('Aeropuerto Internacional El Alto', 2),         -- La Paz
    ('Aeropuerto Internacional de Guarulhos', 3),    -- Sao Paulo
    ('Aeropuerto Santos Dumont', 4),                 -- Rio de Janeiro
    ('Aeropuerto Internacional Arturo Merino Benítez', 5), -- Santiago
    ('Aeropuerto Internacional El Dorado', 6),       -- Bogota
    ('Aeropuerto Internacional Mariscal Sucre', 7),  -- Quito
    ('Aeropuerto Internacional Silvio Pettirossi', 8), -- Asuncion
    ('Aeropuerto Internacional Jorge Chávez', 9),    -- Lima
    ('Aeropuerto Internacional de Carrasco', 10),    -- Montevideo
    ('Aeropuerto Internacional Simón Bolívar', 11),  -- Caracas
    ('Aeropuerto Internacional John F. Kennedy', 12), -- New York
    ('Aeropuerto Internacional de Los Ángeles', 13), -- Los Angeles
    ('Aeropuerto Internacional Toronto Pearson', 14),-- Toronto
    ('Aeropuerto Internacional de Vancouver', 15),   -- Vancouver
    ('Aeropuerto Internacional Benito Juárez', 16),  -- Mexico City
    ('Aeropuerto de Heathrow', 17),                  -- London
    ('Aeropuerto de Berlín-Brandeburgo', 18),        -- Berlin
    ('Aeropuerto Charles de Gaulle', 19),            -- Paris
    ('Aeropuerto Leonardo da Vinci (Fiumicino)', 20),-- Rome
    ('Aeropuerto Adolfo Suárez Madrid-Barajas', 21), -- Madrid
    ('Aeropuerto Schiphol', 22),                     -- Amsterdam
    ('Aeropuerto de Zúrich', 23),                    -- Zurich
    ('Aeropuerto Internacional de Moscú-Sheremétievo', 24), -- Moscow
    ('Aeropuerto Internacional de Pekín-Capital', 25), -- Beijing
    ('Aeropuerto Internacional de Narita', 26),      -- Tokyo
    ('Aeropuerto Internacional de Incheon', 27),     -- Seoul
    ('Aeropuerto Internacional Chhatrapati Shivaji', 28), -- Mumbai
    ('Aeropuerto Internacional Kingsford Smith', 29),-- Sydney
    ('Aeropuerto Internacional de Auckland', 30),    -- Auckland
    ('Aeropuerto Internacional Rey Khalid', 31),     -- Riyadh
    ('Aeropuerto Internacional de Estambul', 32),    -- Istanbul
    ('Aeropuerto Internacional Ben Gurion', 33),     -- Tel Aviv
    ('Aeropuerto Internacional de Ciudad del Cabo', 34) -- Cape Town
) AS source ([name], id_city)
ON target.[name] = source.[name]
WHEN NOT MATCHED BY TARGET THEN
    INSERT ([name], id_city)
    VALUES (source.[name], source.id_city);

COMMIT TRANSACTION;


SELECT * FROM city

BEGIN TRANSACTION;
	IF NOT EXISTS (SELECT 1 FROM role_flight WHERE name = 'Capitan')
	BEGIN
		INSERT INTO role_flight (name) VALUES ('Capitan');
	END;
	IF NOT EXISTS (SELECT 1 FROM role_flight WHERE name = 'Primer Oficial')
	BEGIN
		INSERT INTO role_flight (name) VALUES ('Primer Oficial');
	END;
	IF NOT EXISTS (SELECT 1 FROM role_flight WHERE name = 'Azafata')
	BEGIN
		INSERT INTO role_flight (name) VALUES ('Azafata');
	END;
	IF NOT EXISTS (SELECT 1 FROM role_flight WHERE name = 'Auxiliar de Vuelo')
	BEGIN
		INSERT INTO role_flight (name) VALUES ('Auxiliar de Vuelo');
	END;
COMMIT TRANSACTION;