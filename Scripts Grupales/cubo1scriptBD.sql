CREATE DATABASE PrimerCubo;

-- Crear tabla de dimensión de aerolíneas
CREATE TABLE dimAerolinea (
    idAerolinea INT PRIMARY KEY,
    aerolinea VARCHAR(255)
);

-- Crear tabla de dimensión de destinos
CREATE TABLE dimDestino (
    idDestino INT PRIMARY KEY,
    pais VARCHAR(100),
    ciudad VARCHAR(100),
    aeropuerto VARCHAR(255)
);

-- Crear tabla de dimensión de modelos de avión
CREATE TABLE dimModelo (
    idModelo INT PRIMARY KEY,
    descripcion VARCHAR(255)
);

-- Crear tabla de dimensión de períodos
CREATE TABLE dimPeriodo (
    idPeriodo INT PRIMARY KEY,
    start_of_operations DATE,
    end_of_operations DATE
);

CREATE TABLE dimTiempo (
    idTiempo INT PRIMARY KEY,
    año INT,
    mes INT,
	dia INT
);

-- Crear tabla de hechos para los aviones
CREATE TABLE factAvion (
    idAerolinea INT,
    idTiempo INT,
    idDestino INT,
    idModelo INT,
    frecuenciaUso DECIMAL(10, 2),
    promedioHorasVuelo DECIMAL(10, 2),
    cantidadDisponible INT,
    PRIMARY KEY (idAerolinea, idTiempo, idDestino, idModelo),
    
    -- Definir las claves foráneas
    FOREIGN KEY (idAerolinea) REFERENCES dimAerolinea(idAerolinea),
    FOREIGN KEY (idTiempo) REFERENCES dimTiempo(idTiempo),
    FOREIGN KEY (idDestino) REFERENCES dimDestino(idDestino),
    FOREIGN KEY (idModelo) REFERENCES dimModelo(idModelo)
);

select * from dimAerolinea
ALTER TABLE dimDestino
ALTER COLUMN aeropuerto VARCHAR(255) not null;

ALTER TABLE dimAerolinea
ALTER COLUMN aerolinea VARCHAR(255) not null;

ALTER TABLE dimModelo
ALTER COLUMN descripcion VARCHAR(255) not null;


ALTER TABLE factAvion
-- Cambiar el nombre de la columna frecuenciaUso a avion y su tipo de dato a VARCHAR(15)
DROP COLUMN frecuenciaUso;

ALTER TABLE factAvion
ADD avion VARCHAR(15);

-- Cambiar el nombre de la columna promedioHorasVuelo a horasVuelo y su tipo de dato a INT
ALTER TABLE factAvion
DROP COLUMN promedioHorasVuelo;

ALTER TABLE factAvion
ADD horasVuelo INT;

-- Eliminar la columna cantidadDisponible
ALTER TABLE factAvion
DROP COLUMN cantidadDisponible;
