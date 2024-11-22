BEGIN TRANSACTION;
-- Insertar vuelos en la tabla flight_number
MERGE flight_number AS target
USING (VALUES
    ('08:30:00', '11:45:00', 'Vuelo de Buenos Aires a Santiago', 'Internacional', 'Aerolineas Argentinas', 1, 5, 1),  -- Buenos Aires -> Santiago
    ('12:00:00', '14:30:00', 'Vuelo de Sao Paulo a Rio de Janeiro', 'Nacional', 'LATAM Airlines', 3, 4, 18),  -- Sao Paulo -> Rio de Janeiro
    ('07:00:00', '10:15:00', 'Vuelo de Nueva York a Los Ángeles', 'Nacional', 'Delta Airlines', 12, 13, 1),  -- New York -> Los Angeles
    ('16:00:00', '19:30:00', 'Vuelo de Los Ángeles a Toronto', 'Internacional', 'Air Canada', 13, 14, 7), -- Los Angeles -> Toronto
    ('09:45:00', '13:15:00', 'Vuelo de Londres a París', 'Internacional', 'British Airways', 17, 19, 8), -- London -> Paris
    ('10:30:00', '12:00:00', 'Vuelo de Berlín a Ámsterdam', 'Internacional', 'Lufthansa', 18, 22, 9), -- Berlin -> Amsterdam
    ('06:15:00', '09:45:00', 'Vuelo de Moscú a Estambul', 'Internacional', 'Aeroflot', 24, 32, 10), -- Moscow -> Istanbul
    ('08:50:00', '11:30:00', 'Vuelo de París a Madrid', 'Internacional', 'Air France', 19, 21, 10), -- Paris -> Madrid
    ('13:00:00', '17:00:00', 'Vuelo de Ciudad de México a Nueva York', 'Internacional', 'American Airlines', 16, 12, 2), -- Mexico City -> New York
    ('11:45:00', '15:30:00', 'Vuelo de Tokio a Seúl', 'Internacional', 'All Nippon Airways', 26, 27, 11), -- Tokyo -> Seoul
    ('09:00:00', '14:30:00', 'Vuelo de Río de Janeiro a Buenos Aires', 'Internacional', 'GOL Linhas Aéreas', 4, 1, 12), -- Rio de Janeiro -> Buenos Aires
    ('17:30:00', '20:45:00', 'Vuelo de Santiago a Lima', 'Internacional', 'LATAM Airlines', 5, 9, 18), -- Santiago -> Lima
    ('07:15:00', '09:00:00', 'Vuelo de Montevideo a Buenos Aires', 'Internacional', 'Aerolineas Argentinas', 10, 1, 1), -- Montevideo -> Buenos Aires
    ('18:00:00', '22:30:00', 'Vuelo de Estambul a Tel Aviv', 'Internacional', 'Turkish Airlines', 32, 33, 13), -- Istanbul -> Tel Aviv
    ('13:15:00', '17:00:00', 'Vuelo de Sydney a Auckland', 'Internacional', 'Qantas Airways', 29, 30, 14), -- Sydney -> Auckland
    ('20:00:00', '23:45:00', 'Vuelo de Toronto a Nueva York', 'Internacional', 'Air Canada', 14, 12, 7), -- Toronto -> New York
    ('06:45:00', '10:15:00', 'Vuelo de Madrid a Roma', 'Internacional', 'Iberia', 21, 20, 15), -- Madrid -> Rome
    ('09:30:00', '11:15:00', 'Vuelo de Ámsterdam a Zúrich', 'Internacional', 'KLM', 22, 23, 16), -- Amsterdam -> Zurich
    ('16:30:00', '21:00:00', 'Vuelo de Tel Aviv a Moscú', 'Internacional', 'El Al', 33, 24, 17), -- Tel Aviv -> Moscow
    ('11:00:00', '14:30:00', 'Vuelo de Ciudad del Cabo a Londres', 'Internacional', 'British Airways', 34, 17, 8), -- Cape Town -> London
    ('07:45:00', '10:00:00', 'Vuelo de Bogotá a Lima', 'Internacional', 'Avianca', 6, 9, 6), -- Bogota -> Lima
    ('15:00:00', '17:45:00', 'Vuelo de Nueva York a Toronto', 'Internacional', 'United Airlines', 12, 14, 3), -- New York -> Toronto
    ('08:30:00', '10:15:00', 'Vuelo de Río de Janeiro a Sao Paulo', 'Nacional', 'GOL Linhas Aéreas', 4, 3, 12), -- Rio de Janeiro -> Sao Paulo
    ('12:30:00', '15:15:00', 'Vuelo de Sydney a Tokio', 'Internacional', 'Qantas Airways', 29, 26, 14), -- Sydney -> Tokyo
    ('19:15:00', '22:00:00', 'Vuelo de Pekín a Seúl', 'Internacional', 'Air China', 25, 27, 18), -- Beijing -> Seoul
    ('05:30:00', '09:45:00', 'Vuelo de México a Los Ángeles', 'Internacional', 'Aeroméxico', 16, 13, 18), -- Mexico City -> Los Angeles
    ('14:00:00', '18:15:00', 'Vuelo de Santiago a Bogotá', 'Internacional', 'LATAM Airlines', 5, 6, 18), -- Santiago -> Bogota
    ('08:45:00', '12:15:00', 'Vuelo de Lima a Quito', 'Internacional', 'LATAM Airlines', 9, 7, 18), -- Lima -> Quito
    ('18:30:00', '21:45:00', 'Vuelo de Los Ángeles a Nueva York', 'Nacional', 'American Airlines', 13, 12, 2) -- Los Angeles -> New York
) AS source (departure_time, arrival_time, "description", "type", airline, id_airport_start, id_airport_goal, id_airline)
ON target.departure_time = source.departure_time
WHEN NOT MATCHED BY TARGET THEN
    INSERT (departure_time, arrival_time, "description", "type", airline, id_airport_start, id_airport_goal, id_airline)
    VALUES (source.departure_time, source.arrival_time, source."description", source."type", source.airline, source.id_airport_start, source.id_airport_goal, source.id_airline);

COMMIT TRANSACTION;



BEGIN TRANSACTION;

-- Insertar más vuelos en la tabla flight_number
MERGE flight_number AS target
USING (VALUES
    ('06:30:00', '09:15:00', 'Vuelo de Buenos Aires a Montevideo', 'Internacional', 'Aerolineas Argentinas', 1, 10, 1),  -- Buenos Aires -> Montevideo
    ('11:00:00', '15:30:00', 'Vuelo de Buenos Aires a Madrid', 'Internacional', 'Iberia', 1, 21, 15),  -- Buenos Aires -> Madrid
    ('18:00:00', '22:30:00', 'Vuelo de Ciudad de México a Miami', 'Internacional', 'Aeroméxico', 16, 11, 18), -- Ciudad de México -> Miami
    ('09:45:00', '14:00:00', 'Vuelo de Bogotá a Ciudad de México', 'Internacional', 'Avianca', 6, 16, 6), -- Bogotá -> Ciudad de México
    ('07:00:00', '11:30:00', 'Vuelo de Lima a Miami', 'Internacional', 'LATAM Airlines', 9, 11, 18), -- Lima -> Miami
    ('10:00:00', '15:45:00', 'Vuelo de Nueva York a Londres', 'Internacional', 'British Airways', 12, 17, 8), -- Nueva York -> Londres
    ('13:00:00', '16:45:00', 'Vuelo de París a Berlín', 'Internacional', 'Air France', 19, 18, 10), -- París -> Berlín
    ('08:30:00', '10:45:00', 'Vuelo de Sao Paulo a Buenos Aires', 'Internacional', 'GOL Linhas Aéreas', 3, 1, 12), -- Sao Paulo -> Buenos Aires
    ('11:45:00', '15:15:00', 'Vuelo de Moscú a Tel Aviv', 'Internacional', 'Aeroflot', 24, 33, 10), -- Moscú -> Tel Aviv
    ('09:30:00', '11:15:00', 'Vuelo de Ámsterdam a Berlín', 'Internacional', 'KLM', 22, 18, 16), -- Ámsterdam -> Berlín
    ('07:30:00', '10:30:00', 'Vuelo de Madrid a Ámsterdam', 'Internacional', 'Iberia', 21, 22, 15), -- Madrid -> Ámsterdam
    ('14:00:00', '17:30:00', 'Vuelo de París a Roma', 'Internacional', 'Air France', 19, 20, 10), -- París -> Roma
    ('06:45:00', '08:30:00', 'Vuelo de Berlín a París', 'Internacional', 'Lufthansa', 18, 19, 9), -- Berlín -> París
    ('09:15:00', '12:00:00', 'Vuelo de Roma a Londres', 'Internacional', 'Alitalia', 20, 17, 19), -- Roma -> Londres
    ('11:30:00', '14:00:00', 'Vuelo de Londres a Berlín', 'Internacional', 'British Airways', 17, 18, 8), -- Londres -> Berlín
    ('12:15:00', '15:45:00', 'Vuelo de Zúrich a París', 'Internacional', 'Swiss Air', 23, 19, 20), -- Zúrich -> París
    ('16:00:00', '19:00:00', 'Vuelo de Madrid a Zúrich', 'Internacional', 'Iberia', 21, 23, 15), -- Madrid -> Zúrich
    ('10:45:00', '12:45:00', 'Vuelo de Quito a Lima', 'Internacional', 'LATAM Airlines', 7, 9, 18), -- Quito -> Lima
    ('08:15:00', '10:45:00', 'Vuelo de Lima a Buenos Aires', 'Internacional', 'Aerolineas Argentinas', 9, 1, 1), -- Lima -> Buenos Aires
    ('07:30:00', '09:30:00', 'Vuelo de Río de Janeiro a Montevideo', 'Internacional', 'GOL Linhas Aéreas', 4, 10, 12), -- Río de Janeiro -> Montevideo
    ('15:00:00', '18:15:00', 'Vuelo de Los Ángeles a Tokio', 'Internacional', 'American Airlines', 13, 26, 2), -- Los Ángeles -> Tokio
    ('08:30:00', '11:45:00', 'Vuelo de Sydney a Hong Kong', 'Internacional', 'Qantas Airways', 29, 28, 14), -- Sydney -> Hong Kong
    ('09:30:00', '13:30:00', 'Vuelo de Hong Kong a Tokio', 'Internacional', 'Cathay Pacific', 28, 26, 21), -- Hong Kong -> Tokio
    ('16:00:00', '19:45:00', 'Vuelo de Londres a Madrid', 'Internacional', 'British Airways', 17, 21, 8), -- Londres -> Madrid
    ('10:15:00', '12:30:00', 'Vuelo de Estambul a Moscú', 'Internacional', 'Turkish Airlines', 32, 24, 13), -- Estambul -> Moscú
    ('13:00:00', '17:30:00', 'Vuelo de Los Ángeles a Ciudad de México', 'Internacional', 'Aeroméxico', 13, 16, 18), -- Los Ángeles -> Ciudad de México
    ('14:45:00', '19:15:00', 'Vuelo de Nueva York a Toronto', 'Internacional', 'Delta Airlines', 12, 14, 3), -- Nueva York -> Toronto
    ('07:30:00', '12:00:00', 'Vuelo de Pekín a Tokio', 'Internacional', 'Air China', 25, 26, 22), -- Pekín -> Tokio
    ('09:45:00', '13:30:00', 'Vuelo de Tel Aviv a Estambul', 'Internacional', 'El Al', 33, 32, 17), -- Tel Aviv -> Estambul
    ('06:15:00', '09:00:00', 'Vuelo de Londres a Zúrich', 'Internacional', 'Swiss Air', 17, 23, 20), -- Londres -> Zúrich
    ('12:30:00', '14:45:00', 'Vuelo de Ámsterdam a Londres', 'Internacional', 'KLM', 22, 17, 16), -- Ámsterdam -> Londres
    ('16:45:00', '21:15:00', 'Vuelo de Tokio a Seúl', 'Internacional', 'All Nippon Airways', 26, 27, 11), -- Tokio -> Seúl
    ('08:30:00', '12:45:00', 'Vuelo de Estambul a Roma', 'Internacional', 'Turkish Airlines', 32, 20, 13), -- Estambul -> Roma
    ('11:45:00', '14:00:00', 'Vuelo de Ciudad del Cabo a Johannesburgo', 'Nacional', 'South African Airways', 34, 35, 23), -- Ciudad del Cabo -> Johannesburgo
    ('07:15:00', '11:00:00', 'Vuelo de Johannesburgo a Londres', 'Internacional', 'British Airways', 35, 17, 8), -- Johannesburgo -> Londres
    ('08:30:00', '11:45:00', 'Vuelo de Seúl a Hong Kong', 'Internacional', 'Korean Air', 27, 28, 19), -- Seúl -> Hong Kong
    ('07:00:00', '10:15:00', 'Vuelo de Tokio a Sydney', 'Internacional', 'Qantas Airways', 26, 29, 14), -- Tokio -> Sydney
    ('16:30:00', '21:00:00', 'Vuelo de Santiago a Buenos Aires', 'Internacional', 'LATAM Airlines', 5, 1, 18), -- Santiago -> Buenos Aires
    ('11:00:00', '14:30:00', 'Vuelo de Quito a Bogotá', 'Internacional', 'Avianca', 7, 6, 6), -- Quito -> Bogotá
    ('08:15:00', '12:45:00', 'Vuelo de Buenos Aires a Lima', 'Internacional', 'Aerolineas Argentinas', 1, 9, 1), -- Buenos Aires -> Lima
    ('09:30:00', '12:00:00', 'Vuelo de Lima a Quito', 'Internacional', 'LATAM Airlines', 9, 7, 18), -- Lima -> Quito
    ('14:45:00', '19:00:00', 'Vuelo de Ciudad de México a Bogotá', 'Internacional', 'Aeroméxico', 16, 6, 18), -- Ciudad de México -> Bogotá
    ('07:30:00', '10:30:00', 'Vuelo de Sao Paulo a Río de Janeiro', 'Nacional', 'GOL Linhas Aéreas', 3, 4, 12), -- Sao Paulo -> Río de Janeiro
    ('11:00:00', '14:45:00', 'Vuelo de Madrid a Tel Aviv', 'Internacional', 'Iberia', 21, 33, 15), -- Madrid -> Tel Aviv   
	('15:45:00', '19:30:00', 'Vuelo de Ámsterdam a Zúrich', 'Internacional', 'Swiss Air', 22, 23, 9),
	('08:00:00', '11:45:00', 'Vuelo de París a Berlín', 'Internacional', 'Air France', 19, 18, 2),
	('12:15:00', '14:45:00', 'Vuelo de Londres a Ámsterdam', 'Internacional', 'KLM', 17, 22, 16),
	('06:30:00', '09:15:00', 'Vuelo de Johannesburgo a Ciudad del Cabo', 'Nacional', 'South African Airways', 31, 34, 23),
	('13:30:00', '17:15:00', 'Vuelo de Nueva York a Ciudad de México', 'Internacional', 'Delta Airlines', 12, 16, 3),
	('10:15:00', '13:00:00', 'Vuelo de Tel Aviv a Roma', 'Internacional', 'El Al', 33, 20, 17),
	('14:15:00', '18:00:00', 'Vuelo de Londres a Hong Kong', 'Internacional', 'British Airways', 17, 28, 8),
	('07:45:00', '10:30:00', 'Vuelo de Johannesburgo a Tel Aviv', 'Internacional', 'South African Airways', 31, 33, 5),
	('08:30:00', '11:15:00', 'Vuelo de Estambul a Zúrich', 'Internacional', 'Turkish Airlines', 32, 23, 9),
	('13:00:00', '15:45:00', 'Vuelo de Montevideo a Río de Janeiro', 'Internacional', 'GOL Linhas Aéreas', 10, 4, 12),
	('06:45:00', '10:15:00', 'Vuelo de París a Ámsterdam', 'Internacional', 'Air France', 19, 22, 19),
	('09:30:00', '11:45:00', 'Vuelo de Seúl a Tokio', 'Internacional', 'Korean Air', 27, 26, 22),
	('14:00:00', '18:00:00', 'Vuelo de Ciudad de México a Lima', 'Internacional', 'Aeroméxico', 16, 9, 1),
	('10:30:00', '14:15:00', 'Vuelo de Roma a Estambul', 'Internacional', 'Turkish Airlines', 20, 32, 5),
	('09:45:00', '13:30:00', 'Vuelo de Tokio a Los Ángeles', 'Internacional', 'All Nippon Airways', 26, 13, 4),
	('16:30:00', '19:00:00', 'Vuelo de Moscú a Estambul', 'Internacional', 'Turkish Airlines', 24, 32, 13),
	('07:15:00', '10:45:00', 'Vuelo de Madrid a Londres', 'Internacional', 'Iberia', 21, 17, 7),
	('11:00:00', '15:30:00', 'Vuelo de Hong Kong a Pekín', 'Internacional', 'Cathay Pacific', 28, 25, 11),
	('08:30:00', '12:00:00', 'Vuelo de Lima a Santiago', 'Internacional', 'LATAM Airlines', 9, 5, 20),
	('09:45:00', '13:15:00', 'Vuelo de Buenos Aires a Montevideo', 'Nacional', 'Aerolineas Argentinas', 1, 10, 14),
	('07:00:00', '10:30:00', 'Vuelo de Berlín a Roma', 'Internacional', 'Lufthansa', 18, 20, 6)


) AS source (departure_time, arrival_time, description, flight_type, airline, origin_airport, destination_airport, airline_id)
ON target.departure_time = source.departure_time
WHEN NOT MATCHED THEN
INSERT (departure_time, arrival_time, "description", "type", airline, id_airport_start, id_airport_goal, id_airline)
    VALUES (source.departure_time, source.arrival_time, source."description", source.flight_type, source.airline, source.origin_airport, source.destination_airport, source.airline_id);	

COMMIT TRANSACTION;

Insert into flight_number(departure_time, arrival_time, "description", "type", airline, id_airport_start, id_airport_goal, id_airline) Values('14:00:00', '18:00:00', 'Vuelo de Ciudad de México a Lima', 'Internacional', 'Aeroméxico', 16, 9, 1)

ALTER TABLE flight
DROP CONSTRAINT CHK_flight_flight_date;




BEGIN TRANSACTION;

MERGE flight AS target
USING (VALUES 
    -- Año 2022
    ('2022-01-15', '05:30:00', 'A1', 'C1', 1, 1),
    ('2022-02-20', '10:00:00', 'B2', 'D5', 2, 2),
    ('2022-03-05', '07:45:00', 'C3', 'A7', 3, 3),
    ('2022-04-10', '12:30:00', 'D4', 'F8', 4, 4),
    ('2022-05-15', '09:30:00', 'E5', 'G2', 5, 5),
    ('2022-06-10', '08:15:00', 'F6', 'H3', 6, 6),
    ('2022-07-20', '10:45:00', 'A7', 'B9', 7, 7),
    ('2022-08-15', '11:30:00', 'B8', 'C6', 8, 8),
    ('2022-09-10', '06:45:00', 'C9', 'D4', 9, 9),
    ('2022-10-20', '09:15:00', 'D10', 'E1', 10, 10),
    ('2022-11-05', '07:30:00', 'E11', 'F5', 11, 11),
    ('2022-12-15', '08:00:00', 'F12', 'G8', 12, 12),

    -- Año 2023
    ('2023-01-10', '09:15:00', 'A13', 'H3', 13, 13),
    ('2023-02-15', '06:00:00', 'B14', 'A6', 14, 14),
    ('2023-03-20', '11:30:00', 'C15', 'B3', 15, 15),
    ('2023-04-25', '07:15:00', 'D16', 'C7', 16, 16),
    ('2023-05-30', '10:00:00', 'E17', 'D3', 17, 17),
    ('2023-06-15', '09:45:00', 'F18', 'E4', 18, 18),
    ('2023-07-10', '07:30:00', 'A19', 'F9', 19, 19),
    ('2023-08-20', '06:45:00', 'B20', 'G6', 20, 20),
    ('2023-09-15', '08:15:00', 'C21', 'H3', 21, 21),
    ('2023-10-05', '10:45:00', 'D22', 'A9', 22, 22),
    ('2023-11-10', '06:00:00', 'E23', 'B6', 23, 23),
    ('2023-12-20', '11:30:00', 'F24', 'C2', 24, 24),

    -- Año 2024
    ('2024-01-15', '08:30:00', 'A25', 'D5', 25, 1),
    ('2024-02-10', '07:15:00', 'B26', 'E9', 2, 2),
    ('2024-03-05', '09:45:00', 'C27', 'F4', 3, 3),
    ('2024-04-20', '06:30:00', 'D28', 'G1', 4, 4),
    ('2024-05-25', '11:00:00', 'E29', 'H7', 5, 5),
    ('2024-06-15', '09:00:00', 'F30', 'A3', 6, 6),
    ('2024-07-10', '10:15:00', 'A31', 'B8', 7, 7),
    ('2024-08-05', '06:45:00', 'B32', 'C1', 8, 8),
    ('2024-09-25', '08:30:00', 'C33', 'D7', 9, 9),
    ('2024-10-20', '07:00:00', 'D34', 'E3', 10, 10),
    ('2024-11-15', '10:30:00', 'E35', 'F6', 11, 11),
    ('2024-12-10', '06:45:00', 'F36', 'G8', 12, 12),

    -- Vuelos adicionales distribuidos
    ('2022-06-05', '08:15:00', 'A37', 'H1', 13, 13),
    ('2022-07-25', '11:00:00', 'B38', 'A4', 14, 14),
    ('2022-08-10', '09:00:00', 'C39', 'B5', 15, 15),
    ('2022-09-20', '07:30:00', 'D40', 'C2', 16, 16),
    ('2022-10-30', '06:45:00', 'E41', 'D3', 17, 17),
    ('2023-05-15', '08:45:00', 'F42', 'E9', 18, 18),
    ('2023-08-20', '10:30:00', 'A43', 'F8', 19, 19),
    ('2023-11-15', '09:00:00', 'B44', 'G2', 20, 20),
    ('2024-03-25', '06:45:00', 'C45', 'H5', 21, 21),
    ('2024-07-20', '09:15:00', 'D46', 'A9', 22, 22),
    ('2024-09-10', '08:00:00', 'E47', 'B3', 23, 23),
    ('2024-11-25', '10:45:00', 'F48', 'C1', 24, 24),
    ('2023-04-10', '07:15:00', 'A49', 'D7', 25, 17),
    ('2022-11-05', '09:30:00', 'B50', 'E6', 1, 1)
) AS source (flight_date, boarding_time, gate, check_in_counter, id_flight_number, id_airplane) 
ON target.flight_date = source.flight_date AND target.boarding_time = source.boarding_time 
WHEN NOT MATCHED THEN
    INSERT (flight_date, boarding_time, gate, check_in_counter, id_flight_number, id_airplane)
    VALUES (source.flight_date, source.boarding_time, source.gate, source.check_in_counter, source.id_flight_number, source.id_airplane);

COMMIT TRANSACTION;

--capitanes / pilotos  2,5,9,7,20,17,46,49

INSERT INTO flight_crew_role (role, work_start_time, work_end_time, assignment_date, id_role, id_flight, id_flight_crew)
VALUES
    -- Año 2022
    ('Pilot', '06:00:00', '12:00:00', '2022-01-15', 5, 1, 2),
    ('Pilot', '06:00:00', '12:00:00', '2022-02-20', 5, 2, 5),
    ('Pilot', '06:00:00', '12:00:00', '2022-03-05', 5, 3, 9),
    ('Pilot', '06:00:00', '12:00:00', '2022-04-10', 5, 4, 46),
    ('Pilot', '06:00:00', '12:00:00', '2022-05-15', 5, 5, 2),
    ('Pilot', '06:00:00', '12:00:00', '2022-06-10', 5, 6, 7),
    ('Pilot', '06:00:00', '12:00:00', '2022-07-20', 5, 7, 20),
    ('Pilot', '06:00:00', '12:00:00', '2022-08-15', 5, 8, 17),
    ('Pilot', '06:00:00', '12:00:00', '2022-09-10', 5, 9, 2),
    ('Pilot', '06:00:00', '12:00:00', '2022-10-20', 5, 10, 9),
    ('Pilot', '06:00:00', '12:00:00', '2022-11-05', 5, 11, 46),
    ('Pilot', '06:00:00', '12:00:00', '2022-12-15', 5, 12, 9),

    -- Año 2023
    ('Pilot', '06:00:00', '12:00:00', '2023-01-10', 5, 13, 7),
    ('Pilot', '06:00:00', '12:00:00', '2023-02-15', 5, 14, 2),
    ('Pilot', '06:00:00', '12:00:00', '2023-03-20', 5, 15, 49),
    ('Pilot', '06:00:00', '12:00:00', '2023-04-25', 5, 16, 7),
    ('Pilot', '06:00:00', '12:00:00', '2023-05-30', 5, 17, 9),
    ('Pilot', '06:00:00', '12:00:00', '2023-06-15', 5, 18, 2),
    ('Pilot', '06:00:00', '12:00:00', '2023-07-10', 5, 19, 5),
    ('Pilot', '06:00:00', '12:00:00', '2023-08-20', 5, 20, 9),
    ('Pilot', '06:00:00', '12:00:00', '2023-09-15', 5, 21, 17),
    ('Pilot', '06:00:00', '12:00:00', '2023-10-05', 5, 22, 2),
    ('Pilot', '06:00:00', '12:00:00', '2023-11-10', 5, 23, 5),
    ('Pilot', '06:00:00', '12:00:00', '2023-12-20', 5, 24, 2),

    -- Año 2024
    ('Pilot', '06:00:00', '12:00:00', '2024-01-15', 5, 25, 9),
    ('Pilot', '06:00:00', '12:00:00', '2024-02-10', 5, 26, 17),
    ('Pilot', '06:00:00', '12:00:00', '2024-03-05', 5, 27, 49),
    ('Pilot', '06:00:00', '12:00:00', '2024-04-20', 5, 28, 5),
    ('Pilot', '06:00:00', '12:00:00', '2024-05-25', 5, 29, 2),
    ('Pilot', '06:00:00', '12:00:00', '2024-06-15', 5, 30, 9),
    ('Pilot', '06:00:00', '12:00:00', '2024-07-10', 5, 31, 5),
    ('Pilot', '06:00:00', '12:00:00', '2024-08-05', 5, 32, 49),
    ('Pilot', '06:00:00', '12:00:00', '2024-09-25', 5, 33, 46),
    ('Pilot', '06:00:00', '12:00:00', '2024-10-20', 5, 34, 7),
    ('Pilot', '06:00:00', '12:00:00', '2024-11-15', 5, 35, 2),
    ('Pilot', '06:00:00', '12:00:00', '2024-12-10', 5, 36, 17);


INSERT INTO flight_crew_role (role, work_start_time, work_end_time, assignment_date, id_role, id_flight, id_flight_crew)
VALUES
-- Año 2022
('Pilot', '06:00:00', '12:00:00', '2022-06-05', 5, 37, 2),
('Pilot', '06:00:00', '12:00:00', '2022-07-25', 5, 38, 5),
('Pilot', '06:00:00', '12:00:00', '2022-08-10', 5, 39, 7),
('Pilot', '06:00:00', '12:00:00', '2022-09-20', 5, 40, 46),
('Pilot', '06:00:00', '12:00:00', '2022-10-30', 5, 41, 49),
-- Año 2023
('Pilot', '06:00:00', '12:00:00', '2023-05-15', 5, 42, 7),
('Pilot', '06:00:00', '12:00:00', '2023-08-20', 5, 43, 2),
('Pilot', '06:00:00', '12:00:00', '2023-11-15', 5, 44, 5),
('Pilot', '06:00:00', '12:00:00', '2023-04-10', 5, 49, 7),
-- Año 2024
('Pilot', '06:00:00', '12:00:00', '2024-03-25', 5, 45, 46),
('Pilot', '06:00:00', '12:00:00', '2024-07-20', 5, 46, 17),
('Pilot', '06:00:00', '12:00:00', '2024-09-10', 5, 47, 20),
('Pilot', '06:00:00', '12:00:00', '2024-11-25', 5, 48, 2),
-- Asignaciones adicionales
('Pilot', '06:00:00', '12:00:00', '2022-11-05', 5, 50, 20);

-- rol primer oficial--- 5, 7, 59, 12, 3, 16, 22
INSERT INTO flight_crew_role (role, work_start_time, work_end_time, assignment_date, id_role, id_flight, id_flight_crew)
VALUES
    -- Año 2022
    ('Primer Oficial', '06:00:00', '12:00:00', '2022-01-15', 6, 1, 3),
    ('Primer Oficial', '06:00:00', '12:00:00', '2022-02-20', 6, 2, 2),
    ('Primer Oficial', '06:00:00', '12:00:00', '2022-03-05', 6, 3, 59),
    ('Primer Oficial', '06:00:00', '12:00:00', '2022-04-10', 6, 4, 12),
    ('Primer Oficial', '06:00:00', '12:00:00', '2022-05-15', 6, 5, 3),
    ('Primer Oficial', '06:00:00', '12:00:00', '2022-06-10', 6, 6, 20),
    ('Primer Oficial', '06:00:00', '12:00:00', '2022-07-20', 6, 7, 7),
    ('Primer Oficial', '06:00:00', '12:00:00', '2022-08-15', 6, 8, 59),
    ('Primer Oficial', '06:00:00', '12:00:00', '2022-09-10', 6, 9, 2),
    ('Primer Oficial', '06:00:00', '12:00:00', '2022-10-20', 6, 10,3),
    ('Primer Oficial', '06:00:00', '12:00:00', '2022-11-05', 6, 11, 22),
    ('Primer Oficial', '06:00:00', '12:00:00', '2022-12-15', 6, 12, 16),

    -- Año 2023
    ('Primer Oficial', '06:00:00', '12:00:00', '2023-01-10', 6, 13, 2),
    ('Primer Oficial', '06:00:00', '12:00:00', '2023-02-15', 6, 14, 5),
    ('Primer Oficial', '06:00:00', '12:00:00', '2023-03-20', 6, 15, 59),
    ('Primer Oficial', '06:00:00', '12:00:00', '2023-04-25', 6, 16, 3),
    ('Primer Oficial', '06:00:00', '12:00:00', '2023-05-30', 6, 17, 16),
    ('Primer Oficial', '06:00:00', '12:00:00', '2023-06-15', 6, 18, 22),
    ('Primer Oficial', '06:00:00', '12:00:00', '2023-07-10', 6, 19, 59),
    ('Primer Oficial', '06:00:00', '12:00:00', '2023-08-20', 6, 20, 22),
    ('Primer Oficial', '06:00:00', '12:00:00', '2023-09-15', 6, 21, 3),
    ('Primer Oficial', '06:00:00', '12:00:00', '2023-10-05', 6, 22, 5),
    ('Primer Oficial', '06:00:00', '12:00:00', '2023-11-10', 6, 23, 22),
    ('Primer Oficial', '06:00:00', '12:00:00', '2023-12-20', 6, 24, 59),

    -- Año 2024
    ('Primer Oficial', '06:00:00', '12:00:00', '2024-01-15', 6, 25, 22),
    ('Primer Oficial', '06:00:00', '12:00:00', '2024-02-10', 6, 26, 59),
    ('Primer Oficial', '06:00:00', '12:00:00', '2024-03-05', 6, 27, 16),
    ('Primer Oficial', '06:00:00', '12:00:00', '2024-04-20', 6, 28, 3),
    ('Primer Oficial', '06:00:00', '12:00:00', '2024-05-25', 6, 29, 27),
    ('Primer Oficial', '06:00:00', '12:00:00', '2024-06-15', 6, 30, 3),
    ('Primer Oficial', '06:00:00', '12:00:00', '2024-07-10', 6, 31, 16),
    ('Primer Oficial', '06:00:00', '12:00:00', '2024-08-05', 6, 32, 59),
    ('Primer Oficial', '06:00:00', '12:00:00', '2024-09-25', 6, 33, 42),
    ('Primer Oficial', '06:00:00', '12:00:00', '2024-10-20', 6, 34, 45),
    ('Primer Oficial', '06:00:00', '12:00:00', '2024-11-15', 6, 35, 69),
    ('Primer Oficial', '06:00:00', '12:00:00', '2024-12-10', 6, 36, 71);


INSERT INTO flight_crew_role (role, work_start_time, work_end_time, assignment_date, id_role, id_flight, id_flight_crew)
VALUES
-- Año 2022
('Primer Oficial', '06:00:00', '12:00:00', '2022-06-05', 6, 37, 3),
('Primer Oficial', '06:00:00', '12:00:00', '2022-07-25', 6, 38, 8),
('Primer Oficial', '06:00:00', '12:00:00', '2022-08-10', 6, 39, 22),
('Primer Oficial', '06:00:00', '12:00:00', '2022-09-20', 6, 40, 59),
('Primer Oficial', '06:00:00', '12:00:00', '2022-10-30', 6, 41, 16),
-- Año 2023
('Primer Oficial', '06:00:00', '12:00:00', '2023-05-15', 6, 42, 69),
('Primer Oficial', '06:00:00', '12:00:00', '2023-08-20', 6, 43, 71),
('Primer Oficial', '06:00:00', '12:00:00', '2023-11-15', 6, 44, 3),
('Primer Oficial', '06:00:00', '12:00:00', '2023-04-10', 6, 49, 71),
-- Año 2024
('Primer Oficial', '06:00:00', '12:00:00', '2024-03-25', 6, 45, 27),
('Primer Oficial', '06:00:00', '12:00:00', '2024-07-20', 6, 46, 69),
('Primer Oficial', '06:00:00', '12:00:00', '2024-09-10', 6, 47, 71),
('Primer Oficial', '06:00:00', '12:00:00', '2024-11-25', 6, 48, 16),
-- Asignaciones adicionales
('Primer Oficial', '06:00:00', '12:00:00', '2022-11-05', 6, 50, 3);

--azafatas  4,10, 72, 31, 55
INSERT INTO flight_crew_role (role, work_start_time, work_end_time, assignment_date, id_role, id_flight, id_flight_crew)
VALUES
    -- Año 2022
    ('Azafata', '06:00:00', '12:00:00', '2022-01-15', 7, 1, 4),
	('Azafata', '06:00:00', '12:00:00', '2022-01-15', 7, 1, 10),
	('Azafata', '06:00:00', '12:00:00', '2022-01-15', 7, 1, 73),


    ('Azafata', '06:00:00', '12:00:00', '2022-02-20', 7, 2, 74),
	('Azafata', '06:00:00', '12:00:00', '2022-02-20', 7, 2, 75),
	('Azafata', '06:00:00', '12:00:00', '2022-02-20', 7, 2, 80),


    ('Azafata', '06:00:00', '12:00:00', '2022-03-05', 7, 3, 4),
    ('Azafata', '06:00:00', '12:00:00', '2022-03-05', 7, 3, 78),

    ('Azafata', '06:00:00', '12:00:00', '2022-04-10', 7, 4, 10),
    ('Azafata', '06:00:00', '12:00:00', '2022-04-10', 7, 4, 89),
    ('Azafata', '06:00:00', '12:00:00', '2022-04-10', 7, 4, 91),

    ('Azafata', '06:00:00', '12:00:00', '2022-05-15', 7, 5, 4),
    ('Azafata', '06:00:00', '12:00:00', '2022-05-15', 7, 5, 77),
    ('Azafata', '06:00:00', '12:00:00', '2022-05-15', 7, 5, 85),

    ('Azafata', '06:00:00', '12:00:00', '2022-06-10', 7, 6, 31),
    ('Azafata', '06:00:00', '12:00:00', '2022-06-10', 7, 6, 79),

    ('Azafata', '06:00:00', '12:00:00', '2022-07-20', 7, 7, 25),
    ('Azafata', '06:00:00', '12:00:00', '2022-07-20', 7, 7, 83),
    ('Azafata', '06:00:00', '12:00:00', '2022-07-20', 7, 7, 95),

    ('Azafata', '06:00:00', '12:00:00', '2022-08-15', 7, 8, 24),
    ('Azafata', '06:00:00', '12:00:00', '2022-08-15', 7, 8, 80),
    ('Azafata', '06:00:00', '12:00:00', '2022-08-15', 7, 8, 96),

    ('Azafata', '06:00:00', '12:00:00', '2022-09-10', 7, 9, 25),
    ('Azafata', '06:00:00', '12:00:00', '2022-09-10', 7, 9, 84),
    ('Azafata', '06:00:00', '12:00:00', '2022-09-10', 7, 9, 97),

    ('Azafata', '06:00:00', '12:00:00', '2022-10-20', 7, 10, 4),
    ('Azafata', '06:00:00', '12:00:00', '2022-10-20', 7, 10, 76),
    ('Azafata', '06:00:00', '12:00:00', '2022-10-20', 7, 10, 98),

    ('Azafata', '06:00:00', '12:00:00', '2022-11-05', 7, 11, 62),
    ('Azafata', '06:00:00', '12:00:00', '2022-11-05', 7, 11, 81),
    ('Azafata', '06:00:00', '12:00:00', '2022-11-05', 7, 11, 99),

    ('Azafata', '06:00:00', '12:00:00', '2022-12-15', 7, 12, 25),
    ('Azafata', '06:00:00', '12:00:00', '2022-12-15', 7, 12, 87),
    ('Azafata', '06:00:00', '12:00:00', '2022-12-15', 7, 12, 94),

    -- Año 2023
    ('Azafata', '06:00:00', '12:00:00', '2023-01-10', 7, 13, 62),
	('Azafata', '06:00:00', '12:00:00', '2023-01-10', 7, 13, 81),

    ('Azafata', '06:00:00', '12:00:00', '2023-02-15', 7, 14, 4),
	('Azafata', '06:00:00', '12:00:00', '2023-02-15', 7, 14, 94),
	('Azafata', '06:00:00', '12:00:00', '2023-02-15', 7, 14, 25),

    ('Azafata', '06:00:00', '12:00:00', '2023-03-20', 7, 15, 87),
	('Azafata', '06:00:00', '12:00:00', '2023-03-20', 7, 15, 62),

    ('Azafata', '06:00:00', '12:00:00', '2023-04-25', 7, 16, 25),
	('Azafata', '06:00:00', '12:00:00', '2023-04-25', 7, 16, 4),

    ('Azafata', '06:00:00', '12:00:00', '2023-05-30', 7, 17, 62),
	('Azafata', '06:00:00', '12:00:00', '2023-05-30', 7, 17, 97),

    ('Azafata', '06:00:00', '12:00:00', '2023-06-15', 7, 18, 82),
	('Azafata', '06:00:00', '12:00:00', '2023-06-15', 7, 18, 83),
	('Azafata', '06:00:00', '12:00:00', '2023-06-15', 7, 18, 84),

    ('Azafata', '06:00:00', '12:00:00', '2023-07-10', 7, 19, 4),
	('Azafata', '06:00:00', '12:00:00', '2023-07-10', 7, 19, 15),

    ('Azafata', '06:00:00', '12:00:00', '2023-08-20', 7, 20, 82),
	('Azafata', '06:00:00', '12:00:00', '2023-08-20', 7, 20, 83),

    ('Azafata', '06:00:00', '12:00:00', '2023-09-15', 7, 21, 78),
	('Azafata', '06:00:00', '12:00:00', '2023-09-15', 7, 21, 79),

    ('Azafata', '06:00:00', '12:00:00', '2023-10-05', 7, 22, 15),
	('Azafata', '06:00:00', '12:00:00', '2023-10-05', 7, 22, 4),
	('Azafata', '06:00:00', '12:00:00', '2023-10-05', 7, 22, 91),

    ('Azafata', '06:00:00', '12:00:00', '2023-11-10', 7, 23, 83),
	('Azafata', '06:00:00', '12:00:00', '2023-11-10', 7, 23, 84),

    ('Azafata', '06:00:00', '12:00:00', '2023-12-20', 7, 24, 78),
	('Azafata', '06:00:00', '12:00:00', '2023-12-20', 7, 24, 79),
	('Azafata', '06:00:00', '12:00:00', '2023-12-20', 7, 24, 80),

    -- Año 2024
    ('Azafata', '06:00:00', '12:00:00', '2024-01-15', 7, 25, 81),
	('Azafata', '06:00:00', '12:00:00', '2024-01-15', 7, 25, 82),
	('Azafata', '06:00:00', '12:00:00', '2024-01-15', 7, 25, 83),

    ('Azafata', '06:00:00', '12:00:00', '2024-02-10', 7, 26, 4),
	('Azafata', '06:00:00', '12:00:00', '2024-02-10', 7, 26, 15),

    ('Azafata', '06:00:00', '12:00:00', '2024-03-05', 7, 27, 91),
	('Azafata', '06:00:00', '12:00:00', '2024-03-05', 7, 27, 93),
	('Azafata', '06:00:00', '12:00:00', '2024-03-05', 7, 27, 92),

    ('Azafata', '06:00:00', '12:00:00', '2024-04-20', 7, 28, 72),
	('Azafata', '06:00:00', '12:00:00', '2024-04-20', 7, 28, 4),

    ('Azafata', '06:00:00', '12:00:00', '2024-05-25', 7, 29, 15),
	('Azafata', '06:00:00', '12:00:00', '2024-05-25', 7, 29, 10),

    ('Azafata', '06:00:00', '12:00:00', '2024-06-15', 7, 30, 85),
	('Azafata', '06:00:00', '12:00:00', '2024-06-15', 7, 30, 86),
	('Azafata', '06:00:00', '12:00:00', '2024-06-15', 7, 30, 87),

    ('Azafata', '06:00:00', '12:00:00', '2024-07-10', 7, 31, 4),
	('Azafata', '06:00:00', '12:00:00', '2024-07-10', 7, 31, 15),

    ('Azafata', '06:00:00', '12:00:00', '2024-08-05', 7, 32, 10),
	('Azafata', '06:00:00', '12:00:00', '2024-08-05', 7, 32, 25),

    ('Azafata', '06:00:00', '12:00:00', '2024-09-25', 7, 33, 82),
	('Azafata', '06:00:00', '12:00:00', '2024-09-25', 7, 33, 83),
	('Azafata', '06:00:00', '12:00:00', '2024-09-25', 7, 33, 84),

    ('Azafata', '06:00:00', '12:00:00', '2024-10-20', 7, 34, 91),
	('Azafata', '06:00:00', '12:00:00', '2024-10-20', 7, 34, 92),

    ('Azafata', '06:00:00', '12:00:00', '2024-11-15', 7, 35, 82),
	('Azafata', '06:00:00', '12:00:00', '2024-11-15', 7, 35, 25),

    ('Azafata', '06:00:00', '12:00:00', '2024-12-10', 7, 36, 92),
	('Azafata', '06:00:00', '12:00:00', '2024-12-10', 7, 36, 4),
	('Azafata', '06:00:00', '12:00:00', '2024-12-10', 7, 36, 78);


INSERT INTO flight_crew_role (role, work_start_time, work_end_time, assignment_date, id_role, id_flight, id_flight_crew)
VALUES
-- Año 2022
('Azafata', '06:00:00', '12:00:00', '2022-06-05', 7, 37, 81),
('Azafata', '06:00:00', '12:00:00', '2022-06-05', 7, 37, 83),
('Azafata', '06:00:00', '12:00:00', '2022-06-05', 7, 37, 84),

('Azafata', '06:00:00', '12:00:00', '2022-07-25', 7, 38, 72),
('Azafata', '06:00:00', '12:00:00', '2022-07-25', 7, 38, 73),

('Azafata', '06:00:00', '12:00:00', '2022-08-10', 7, 39, 91),
('Azafata', '06:00:00', '12:00:00', '2022-08-10', 7, 39, 92),

('Azafata', '06:00:00', '12:00:00', '2022-09-20', 7, 40, 4),
('Azafata', '06:00:00', '12:00:00', '2022-09-20', 7, 40, 10),
('Azafata', '06:00:00', '12:00:00', '2022-09-20', 7, 40, 15),

('Azafata', '06:00:00', '12:00:00', '2022-10-30', 7, 41, 91),
('Azafata', '06:00:00', '12:00:00', '2022-10-30', 7, 41, 82),

---------------------------------------------
-- Año 2023
('Azafata', '06:00:00', '12:00:00', '2023-05-15', 7, 42, 72),
('Azafata', '06:00:00', '12:00:00', '2023-05-15', 7, 42, 73),
('Azafata', '06:00:00', '12:00:00', '2023-05-15', 7, 42, 74),

('Azafata', '06:00:00', '12:00:00', '2023-08-20', 7, 43, 4),
('Azafata', '06:00:00', '12:00:00', '2023-08-20', 7, 43, 15),

('Azafata', '06:00:00', '12:00:00', '2023-11-15', 7, 44, 10),
('Azafata', '06:00:00', '12:00:00', '2023-11-15', 7, 44, 91),

('Azafata', '06:00:00', '12:00:00', '2023-04-10', 7, 49, 93),
('Azafata', '06:00:00', '12:00:00', '2023-04-10', 7, 49, 92),
('Azafata', '06:00:00', '12:00:00', '2023-04-10', 7, 49, 82),
-- Año 2024
('Azafata', '06:00:00', '12:00:00', '2024-03-25', 7, 45, 27),
('Azafata', '06:00:00', '12:00:00', '2024-03-25', 7, 45, 29),

('Azafata', '06:00:00', '12:00:00', '2024-07-20', 7, 46, 91),
('Azafata', '06:00:00', '12:00:00', '2024-07-20', 7, 46, 92),
('Azafata', '06:00:00', '12:00:00', '2024-07-20', 7, 46, 93),

('Azafata', '06:00:00', '12:00:00', '2024-09-10', 7, 47, 81),
('Azafata', '06:00:00', '12:00:00', '2024-09-10', 7, 47, 82),

('Azafata', '06:00:00', '12:00:00', '2024-11-25', 7, 48, 91),
('Azafata', '06:00:00', '12:00:00', '2024-11-25', 7, 48, 92),
('Azafata', '06:00:00', '12:00:00', '2024-11-25', 7, 48, 93),

-- Asignaciones adicionales
('Azafata', '06:00:00', '12:00:00', '2022-11-05', 7, 50, 81),
('Azafata', '06:00:00', '12:00:00', '2022-11-05', 7, 50, 82),
('Azafata', '06:00:00', '12:00:00', '2022-11-05', 7, 50, 83);






select * from airplane
select * from airline
select * from airport
select * from flight_number
select * from flight
select * from country
select * from city
select * from plane_model

select * from flight_crew
select * from flight_crew_role
select * from role_flight

select * from person




alter table flight_number
add arrival_date date 

