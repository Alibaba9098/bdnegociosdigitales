
--Crea una base de datos
CREATE DATABASE tienda;
GO

USE tienda;

--Crear tabla

CREATE TABLE cliente (
	id INT not null,
	nombre NVARCHAR(30) not null,
	apaterno NVARCHAR(10) not null,
	amaterno NVARCHAR(10) null,
	sexo NCHAR(1) not null,
	edad INT not null,
	direccion NVARCHAR(80) not null,
	rfc NVARCHAR(20) not null,
	limitecredito MONEY not null DEFAULT 500.0
);
GO

--Restricciones

CREATE TABLE clientes(
	cliente_id INT not null PRIMARY KEY,
	nombre NVARCHAR(30) not null,
	apellido_paterno NVARCHAR(20) not null,
	apellido_materno NVARCHAR(20),
	edad INT not null,
	fecha_nacimiento DATE not null,
	limite_credito MONEY not null,
);
GO

INSERT INTO clientes
VALUES (1, 'GOKU', 'LITERNA', 'SUPERMAN', 450, '1578-01-17', 100);

INSERT INTO clientes
VALUES (2, 'PANCRACIO', 'RIVERO', 'PATROCLO', 20, '2005-03-12', 10000);

INSERT INTO clientes (nombre, cliente_id, limite_credito, fecha_nacimiento, apellido_paterno, edad)
VALUES ('ARCADIA', 3, 45800, '2000-01-23', 'RAMIREZ', 26);

INSERT INTO clientes
VALUES (4, 'VANESA', 'BUENA VISTA', NULL , 26, '2000-06-02', 3000);

INSERT INTO clientes
VALUES
(5, 'SOYLA', 'VACA', 'DEL CORRAL', 42, '1982-12-12', 27489);

SELECT * FROM clientes;

CREATE TABLE clientes_2(
	cliente_id INT not null IDENTITY (1,1),
	nombre NVARCHAR(50) not null,
	edad INT not null,
	fecha_registro date default GETDATE(),
	limite_credito MONEY not null,
	CONSTRAINT pk_clientes_2
	PRIMARY KEY (cliente_id),
);

SELECT *
FROM clientes_2;

INSERT INTO clientes_2
VALUES ('Chespirito', 89, DEFAULT, 45500);

INSERT INTO clientes_2 (nombre, edad, limite_credito)
VALUES ('Batman', 45, 89000);

INSERT INTO clientes_2
VALUES ('Robin', 35, '2026-01-19', 89.32);

INSERT INTO clientes_2 (limite_credito,edad, nombre, fecha_registro)
VALUES (12.33, 24, 'Flash Reverso', '2026-01-19');

CREATE TABLE suppliers (
supplier_id INT not null IDENTITY(1,1),
[name] NVARCHAR(30) not null,
date_register DATE not null DEFAULT GETDATE(),
tipo CHAR(1)not null,
credit_limit MONEY not null,
CONSTRAINT pk_suppliers
PRIMARY KEY (supplier_id),
CONSTRAINT unique_name 
UNIQUE ([name]),
CONSTRAINT chk_credit_limit
CHECK (credit_limit > 0.0 and credit_limit <=50000),
CONSTRAINT chk_tipo
CHECK (tipo IN('A', 'B', 'C'))
);

SELECT *
FROM suppliers;

INSERT INTO suppliers
VALUES (UPPER('bimbo'), DEFAULT, UPPER('c'), 45000);

INSERT INTO suppliers
VALUES (UPPER('tia rosa'), '2026-01-21', UPPER('a'), 49999.99999999999999);

INSERT INTO suppliers ([name], tipo, credit_limit)
VALUES (UPPER('tia mesa'), UPPER('a'), 49999.99999);

-- Crear Base de Datos dborders

CREATE DATABASE dborders;
GO

USE dborders;
GO

-- Crear tabla customers

CREATE TABLE customers (
	customer_id INT not null IDENTITY (1,1),
	first_name NVARCHAR (20) not null,
	last_name NVARCHAR (30),
	[address] NVARCHAR (80) not null,
	number INT,
	CONSTRAINT pk_customers
	PRIMARY KEY (customer_id)
);

CREATE TABLE suppliers (
	supplier_id INT not null,
	[name] NVARCHAR(30) not null,
	date_register DATE not null DEFAULT GETDATE(),
	tipo CHAR(1)not null,
	credit_limit MONEY not null,
	CONSTRAINT pk_suppliers
	PRIMARY KEY (supplier_id),
	CONSTRAINT unique_name 
	UNIQUE ([name]),
	CONSTRAINT chk_credit_limit
	CHECK (credit_limit > 0.0 and credit_limit <=50000),
	CONSTRAINT chk_tipo
	CHECK (tipo IN('A', 'B', 'C'))
);
GO

ALTER TABLE suppliers
DROP CONSTRAINT pk_suppliers;

CREATE TABLE products (
	product_id INT not null IDENTITY (1,1),
	[name] NVARCHAR (40) not null,
	quantity INT not null,
	unit_price MONEY not null,
	supplier_id INT,
	CONSTRAINT pk_products
	PRIMARY KEY (product_id),
	CONSTRAINT unique_name_products
	UNIQUE ([name]),
	CONSTRAINT chk_quantity
	CHECK (quantity between 1 and 100),
	CONSTRAINT chk_unitprice
	CHECK (unit_price > 0 and unit_price <= 100000),
	CONSTRAINT fk_products_suppliers
	FOREIGN KEY (supplier_id)
	REFERENCES suppliers (supplier_id)
	ON DELETE SET NULL
	ON UPDATE SET NULL
);
GO

DROP TABLE products;
DROP TABLE suppliers;



ALTER TABLE products
DROP CONSTRAINT fk_products_suppliers;

DROP TABLE suppliers;


--DROP TABLE products;

SELECT * FROM suppliers;

INSERT INTO suppliers
VALUES (1, UPPER('Chino s.a.'), DEFAULT, UPPER('c'), 45000);

INSERT INTO suppliers
VALUES (2, UPPER('Chanclotas'), '2026-01-21', UPPER('a'), 49999.99999999999999);

INSERT INTO suppliers (supplier_id, [name], tipo, credit_limit)
VALUES (3, UPPER('Rama-ma'), UPPER('a'), 49999.99999);

SELECT * FROM products;
SELECT * FROM suppliers;


INSERT INTO products
VALUES ('Papas', 10, 5.3, 1);

INSERT INTO products
VALUES ('Rollos Primavera', 20, 100, 1);

INSERT INTO products
VALUES ('Chanclas pata de gallo', 50, 20, 10);

INSERT INTO products
VALUES ('Chanclas buenas', 30, 56.7, 10),
       ('Ramita chiquita', 56, 78.23, 3);

INSERT INTO products
VALUES ('Azulito', 100, 15, null);

-- Comborbacion ON DELETE NO ACTION

-- Eliminar los hijos
DELETE FROM products
WHERE supplier_id = 1;

-- Eliminar al padre
DELETE FROM suppliers
WHERE supplier_id = 1;

-- Comprobar el UPADATE NO ACTION
-- Permite cambiar la estructura 
ALTER TABLE products
ALTER COLUMN supplier_id INT null;

UPDATE products
SET supplier_id = null;

UPDATE products
SET supplier_id = null
WHERE supplier_id = 2;

UPDATE products
SET supplier_id = 10
WHERE product_id IN (3, 4);

UPDATE suppliers
SET supplier_id = 10
WHERE supplier_id = 2;

DELETE FROM products
WHERE supplier_id = 1;

UPDATE products 
SET supplier_id = 2
WHERE product_id IN (4, 5);

UPDATE products
SET supplier_id = 3
WHERE product_id = 6;

UPDATE suppliers
SET supplier_id = 10
WHERE supplier_id = 2;

UPDATE products
SET supplier_id = 20
WHERE supplier_id is null;

-- Comprobar ON DELETE SET NULL

DELETE suppliers
WHERE supplier_id = 10;

UPDATE  suppliers
SET supplier_id = 20
WHERE supplier_id = 1;