-- CREATE DATABASE
DROP DATABASE IF EXISTS tienda_gafas;
CREATE DATABASE tienda_gafas;
USE tienda_gafas;

-- CREATE DB TABLES
CREATE TABLE distribuidores(
id_distribuidor INT NOT NULL AUTO_INCREMENT,
nombre_distribuidor VARCHAR(60) NOT NULL,
calle VARCHAR(50) NOT NULL,
numero_calle INT NOT NULL,
cp VARCHAR(10) NOT NULL,
ciudad VARCHAR(35) NOT NULL,
pais VARCHAR(20) NOT NULL,
telefono VARCHAR(20) NOT NULL,
fax VARCHAR(20) NOT NULL,
nif VARCHAR(20) NOT NULL,
PRIMARY KEY(id_distribuidor)
);

CREATE TABLE clientes(
id_cliente INT NOT NULL AUTO_INCREMENT,
nombre_completo VARCHAR(60) NOT NULL,
cp INT NOT NULL,
telefono VARCHAR(15) NOT NULL,
email VARCHAR(45) NOT NULL,
fecha_registro DATE NOT NULL,
referencia_cliente INT,
PRIMARY KEY(id_cliente),
FOREIGN KEY(referencia_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE trabajadores(
id_trabajador INT NOT NULL AUTO_INCREMENT,
nombre VARCHAR(60) NOT NULL,
apellido VARCHAR(60) NOT NULL,
PRIMARY KEY(id_trabajador)
);

CREATE TABLE ventas(
id_venta INT NOT NULL AUTO_INCREMENT,
fecha_venta DATE NOT NULL,
marca VARCHAR(60) NOT NULL,
graduacion_derecha DECIMAL(4,2), 
graduacion_izquierda DECIMAL(4,2),
tipo_montura ENUM('acero', 'madera', 'acetato') NOT NULL,
montura_color VARCHAR(45),
lente_color VARCHAR(45) NOT NULL,
precio DECIMAL(6,2) NOT NULL,
id_distribuidor INT NOT NULL,
id_cliente INT NOT NULL,
id_trabajador INT NOT NULL,
PRIMARY KEY(id_venta),
FOREIGN KEY(id_distribuidor) REFERENCES distribuidores(id_distribuidor),
FOREIGN KEY(id_cliente) REFERENCES clientes(id_cliente),
FOREIGN KEY(id_trabajador) REFERENCES trabajadores(id_trabajador)

);

-- INSERT DATA 
-- trabajadores table
INSERT INTO trabajadores (nombre, apellido)
VALUES ('Bob', 'Esponja'), 
('Michael', 'Jackson'), 
('Freddie', 'Mercury');

-- proveedores table
INSERT INTO distribuidores (nombre_distribuidor, calle, numero_calle, cp, ciudad, pais, telefono, fax, nif)
VALUES('GafaDistri', 'Aribau', '85', '08013', 'Barcelona', 'España', '933423423', '933333333', 'P14159265'),
('Distrubugafas', 'Gran Via', '666', '08001', 'Barcelona', 'España', '936666666', '932233222', 'F1618033');

-- clientes tables
INSERT INTO clientes (nombre_completo, cp, telefono, email, fecha_registro)
VALUES('Michael Jordan', '08010', '623233322', 'sixrings@nba.com', '1914-02-03'),
('Scottie Pippen', '08014', '623623623', 'IamScottie@nbamail.com', '1939-01-01'),
('Magic Johnson', '08024', '611223344', 'mrmagic@lakers.com', '2022-11-21');

-- ventas tables
INSERT INTO ventas (fecha_venta, marca, graduacion_izquierda, graduacion_derecha, tipo_montura, montura_color,lente_color, precio, id_cliente, id_trabajador, id_distribuidor)
VALUES ('1945-11-11', 'Oakley', '4.75', '3.25', 'acero', NULL, 'negro', '219.50', '1', '1','1'),
('1919-04-10', 'Hawkers', NULL, NULL, 'madera', 'madera', 'negro', '199.99', '1','2','1'),
('2022-11-15', 'Armani', '7.00', '5.50', 'acetato', 'verde', 'oscuro', '99.99', '2', '1','1'),
('2022-11-20', 'Gucci', 3.5, 2.5, 'acero', 'cromado', 'transparente', '200.90', '2', '2','1');

SELECT *
	FROM ventas
	WHERE id_cliente = 1;

-- 2. Llista les diferents ulleres que ha venut un empleat durant un any.

SELECT *
	FROM ventas
	WHERE id_trabajador = 1 AND fecha_venta > '2021-11-01';

-- 3. Llista els diferents proveïdors que han subministrat ulleres venudes amb èxit per l'òptica.

SELECT dis.nombre_distribuidor
	FROM ventas v INNER JOIN distribuidores dis
	ON dis.id_distribuidor = v.id_distribuidor
    WHERE id_venta > 0
    GROUP BY dis.nombre_distribuidor;