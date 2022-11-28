-- CREATE DATABES
DROP DATABASE IF EXISTS pizzeria;
CREATE DATABASE pizzeria;
USE pizzeria;

-- CREATE DB TABLES
CREATE TABLE provincias(
	id_provincia INT NOT NULL AUTO_INCREMENT,
	nombre_provincia VARCHAR(45) NOT NULL,
	PRIMARY KEY(id_provincia)
);

CREATE TABLE ciudades(
    id_ciudad INT NOT NULL AUTO_INCREMENT,
    nombre_ciudad VARCHAR(45) NOT NULL,
    id_provincia INT NOT NULL,
    PRIMARY KEY(id_ciudad),
    FOREIGN KEY(id_provincia) REFERENCES provincias(id_provincia)
);

CREATE TABLE clientes(
    id_cliente INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(60) NOT NULL,
    apellido VARCHAR(60) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    cp VARCHAR(25) NOT NULL,
    id_ciudad INT NOT NULL,
    telefono VARCHAR(45) NOT NULL,
    PRIMARY KEY(id_cliente),
    FOREIGN KEY(id_ciudad) REFERENCES ciudades(id_ciudad)
);

CREATE TABLE tiendas(
    id_tienda INT NOT NULL AUTO_INCREMENT,
    direccion VARCHAR(60) NOT NULL,
    cp VARCHAR(25) NOT NULL,
    id_ciudad INT NOT NULL,
    PRIMARY KEY(id_tienda),
    FOREIGN KEY(id_ciudad) REFERENCES ciudades(id_ciudad)
);

CREATE TABLE trabajadores(
    id_trabajador INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(45) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    dni VARCHAR(45) NOT NULL,
    telefono VARCHAR(30) NOT NULL,
    cargo ENUM('cocinero', 'repartidor'),
    id_tienda INT NOT NULL,
    PRIMARY KEY(id_trabajador),
    FOREIGN KEY(id_tienda) REFERENCES tiendas(id_tienda)
);

CREATE TABLE pedidos_domicilio(
    id_pedido_domicilio INT NOT NULL AUTO_INCREMENT,
    id_repartidor INT NOT NULL,
    fecha_hora TIMESTAMP,
    PRIMARY KEY(id_pedido_domicilio),
    FOREIGN KEY(id_repartidor) REFERENCES trabajadores(id_trabajador)
);

CREATE TABLE pedidos(
    id_pedido INT NOT NULL AUTO_INCREMENT,
    fecha_hora DATETIME,
    tipo_pedido ENUM('reparto', 'tienda') NOT NULL,
    cantidad INT NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    id_cliente INT NOT NULL,
    id_pedido_domicilio INT,
    id_tienda INT NOT NULL,
    id_trabajador INT NOT NULL,
    PRIMARY KEY(id_pedido),
    FOREIGN KEY(id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY(id_pedido_domicilio) REFERENCES pedidos_domicilio(id_pedido_domicilio),
    FOREIGN KEY(id_tienda) REFERENCES tiendas(id_tienda),
    FOREIGN KEY(id_trabajador) REFERENCES trabajadores(id_trabajador)
);

CREATE TABLE productos(
    id_producto INT NOT NULL AUTO_INCREMENT,
    tipo_producto ENUM ('pizza', 'hamburguesa', 'bebida'),
    nombre_producto VARCHAR(45) NOT NULL,
    id_pedido INT,
    descripcion_producto VARCHAR(300) NOT NULL,
    imagen BLOB,
    precio DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY(id_producto),
    FOREIGN KEY(id_pedido) REFERENCES pedidos(id_pedido)
);

-- TABLE DATA INSERT
INSERT INTO provincias (nombre_provincia) 
VALUES ('Barcelona'),
('Tarragona'),
('Lleida'),
('Girona');

INSERT INTO ciudades (nombre_ciudad, id_provincia) 
VALUES ('Barcelona', 1), 
('Granollers', 1),
('Sitges', 1),
('Tarragona', 2),
('el Vendrell', 2),
('Salou', 2),
('Lleida', 3),
('Tarrega', 3),
('Girona', 4),
('Figueres', 4),
('Lloret de Mar', 4);

INSERT INTO tiendas(direccion, cp, id_ciudad) 
VALUES ('Carrer Valencia, 123', '08086', 2),
('Avinguda Diagonal, 223', '08058', 1),
('Carrer Aribau, 34', '08111', 2),
('Carrer Aragó, 341', '08023', 3),
('Carrer de Sants, 114', '08055', 4),
('Passeig Sant Joan, 111', '08212', 2),
('Carrer Sils, 21', '08003', 2), 
('Avinguda LLefià, 36', '08021', 9), 
('Carrer Roc Boronat, 171', '08001', 2), 
('Plaça Sants, 185', '08013', 2), 
('Carrer de la Creu Coberta, 94', '08014', 2); 

INSERT INTO trabajadores(nombre, apellido, dni, telefono, cargo, id_tienda) 
VALUES ('Rosa', 'Melano', 'X3213214P', '600000623', 'cocinero', 1),
('Deborah', 'Meltrozo', 'Z5656565J', '681012234', 'repartidor', 4),
('Johnny', 'Melavo', 'M4564565', '656818181', 'repartidor', 3),
('Nikita', 'Nipone', '99000990', '726612239', 'repartidor', 2),
('Nicolás', 'Puga', 'M5666711A', '711995551', 'cocinero', 4),
('Elver', 'Galarga', '62310922H', '734323789', 'cocinero', 3),
('Pablito', 'Clavó', '2224442G', '663457432', 'repartidor', 1),
('Benito', 'Camela', '1235552P', '644156789', 'repartidor', 2);

INSERT INTO clientes(nombre, apellido, direccion, cp, id_ciudad, telefono) 
VALUES ('Michael', 'Phelps', 'Carrer Aragó, 2', '08036', 1, '612312362'),
('Kurt', 'Cobain', 'Via Icaria, 21', '08024', 1, '676567567'),
('Marilyn', 'Manson', 'Carrer del Carme,23', '08013', 3, '698567567'),
('Richie', 'Hawtin', 'Carrer Valencia, 234', '08001', 2, '733098098'),
('Paco', 'Lucía', 'Carrer Gran Via, 236', '08002', 4, '600000000');

INSERT INTO productos(tipo_producto, nombre_producto, descripcion_producto, precio) 
VALUES ('pizza', 'Diavola', 'Para los amantes del picante', 14.50),
('pizza', 'cuatro quesos', 'Para los amantes del queso y los que toleren la lactosa', 12.90),
('Hamburguesa', 'Doble Cheeseburguer', 'Súper Hamburguesa, la especialidad de la casa', 12),
('Hamburguesa', 'Veggie Burguer', 'Nuestra opción vegana', 20.80);

INSERT INTO pedidos(tipo_pedido, cantidad, precio, id_cliente, id_tienda, id_trabajador) 
VALUES ('tienda', 2, 18.50, 1, 3, 1),
 ('reparto', 4, 111.80, 2, 2, 1),
 ('reparto', 3, 80.50, 3, 1, 1);
 



-- Llista quants productes del tipus 'begudes' s'han venut en una determinada localitat

SELECT *
	FROM productos p  INNER JOIN ciudades c
    WHERE p.tipo_producto = 'pizza' AND  c.nombre_ciudad = 'Barcelona' ;
    
-- Llista quantes comandes ha executat un determinat empleat

SELECT id_pedido
	FROM pedidos
	WHERE id_trabajador = 1;