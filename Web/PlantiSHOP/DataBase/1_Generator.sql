DROP SCHEMA IF EXISTS plantishop;
CREATE SCHEMA IF NOT EXISTS plantishop;
USE plantishop;

-- Tabla de ubicaciones (opcional, para alcaldías de CDMX u otras regiones)
CREATE TABLE Ubicaciones (
    idubicacion INT PRIMARY KEY AUTO_INCREMENT,
    pais VARCHAR(100),
    estado VARCHAR(100),
    ciudad VARCHAR(100),
    alcaldia VARCHAR(100)
);

-- Tabla de usuarios
CREATE TABLE Usuarios (
    idus INT PRIMARY KEY AUTO_INCREMENT,
    tag VARCHAR(50) UNIQUE NOT NULL,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    edad INT,
    idubicacion INT,
    gmail VARCHAR(100) UNIQUE NOT NULL,
    contrasena VARCHAR(100) NOT NULL,
    premium BOOLEAN DEFAULT FALSE,
    descripcion TEXT,
    calificacion DECIMAL(2,1), -- promedio del 1 al 5
    FOREIGN KEY (idubicacion) REFERENCES Ubicaciones(idubicacion)
);

-- Tabla de plantas
CREATE TABLE Plantas (
    idplanta INT PRIMARY KEY AUTO_INCREMENT,
    idusuario INT,
    nombre VARCHAR(100),
    especie VARCHAR(100),
    luz INT, -- porcentaje de luz necesaria
    tipo VARCHAR(50),
    descripcion TEXT,
    imagen VARCHAR(255),
    precio INT,
    venta BOOLEAN,
    cant INT,
    FOREIGN KEY (idusuario) REFERENCES Usuarios(idus)
);

-- Tabla de mensajes entre usuarios
CREATE TABLE Mensajes (
    idmens INT PRIMARY KEY AUTO_INCREMENT,
    idemisor INT,
    idreceptor INT,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    mensaje TEXT,
    archivo VARCHAR(255),
    FOREIGN KEY (idemisor) REFERENCES Usuarios(idus),
    FOREIGN KEY (idreceptor) REFERENCES Usuarios(idus)
);

-- Tabla de transacciones (ventas presenciales validadas con código)
CREATE TABLE Transacciones (
    idtrans INT PRIMARY KEY AUTO_INCREMENT,
    idusuariov INT, -- vendedor
    idusuarioc INT, -- comprador
    idplanta INT,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    codigo_validacion VARCHAR(10),
    FOREIGN KEY (idusuariov) REFERENCES Usuarios(idus),
    FOREIGN KEY (idusuarioc) REFERENCES Usuarios(idus),
    FOREIGN KEY (idplanta) REFERENCES Plantas(idplanta)
);

-- Tabla para chatbot IA (conversaciones)
CREATE TABLE MensajesIA (
    idmensa INT PRIMARY KEY AUTO_INCREMENT,
    idusuario INT,
    mensaje TEXT,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (idusuario) REFERENCES Usuarios(idus)
);

-- Tabla para fotos procesadas por IA (diagnóstico)
CREATE TABLE FotosIA (
    idfot INT PRIMARY KEY AUTO_INCREMENT,
    imagen VARCHAR(255),
    resultado TEXT
);

-- Tabla de categorías para plantas
CREATE TABLE Categorias (
    idcat INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) UNIQUE NOT NULL
);

-- Tabla intermedia: planta -> categoría
CREATE TABLE PlantaCategoria (
    idplanta INT,
    idcat INT,
    PRIMARY KEY (idplanta, idcat),
    FOREIGN KEY (idplanta) REFERENCES Plantas(idplanta),
    FOREIGN KEY (idcat) REFERENCES Categorias(idcat)
);

CREATE TABLE IF NOT EXISTS Movimientos (
    idtrig INT AUTO_INCREMENT PRIMARY KEY,
    tabla_afectada VARCHAR(50) NOT NULL,
    idus INT,
    accion VARCHAR(20) NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    detalle TEXT,
    FOREIGN KEY (idus) REFERENCES Usuarios(idus)
);