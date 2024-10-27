CREATE DATABASE PrimerCubo;

-- Crear tabla de dimensión de aerolíneas
CREATE TABLE dimAerolinea (
    idAerolinea INT PRIMARY KEY,
    aerolinea VARCHAR(100)
);

-- Crear tabla de dimensión de destinos
CREATE TABLE dimDestino (
    idDestino INT PRIMARY KEY,
    pais VARCHAR(100),
    ciudad VARCHAR(100),
    aeropuerto VARCHAR(100)
);

-- Crear tabla de dimensión de modelos de avión
CREATE TABLE dimModelo (
    idModelo INT PRIMARY KEY,
    descripcion VARCHAR(100)
);

-- Crear tabla de dimensión de períodos
CREATE TABLE dimPeriodo (
    idPeriodo INT PRIMARY KEY,
    start_of_operations DATE,
    end_of_operations DATE
);

-- Crear tabla de hechos para los aviones
CREATE TABLE factAvion (
    idAerolinea INT,
    idPeriodo INT,
    idDestino INT,
    idModelo INT,
    frecuenciaUso DECIMAL(10, 2),
    promedioHorasVuelo DECIMAL(10, 2),
    cantidadDisponible INT,
    PRIMARY KEY (idAerolinea, idPeriodo, idDestino, idModelo),
    
    -- Definir las claves foráneas
    FOREIGN KEY (idAerolinea) REFERENCES dimAerolinea(idAerolinea),
    FOREIGN KEY (idPeriodo) REFERENCES dimPeriodo(idPeriodo),
    FOREIGN KEY (idDestino) REFERENCES dimDestino(idDestino),
    FOREIGN KEY (idModelo) REFERENCES dimModelo(idModelo)
);

select * from dimDestino
ALTER TABLE dimDestino
ALTER COLUMN aeropuerto VARCHAR(255);
