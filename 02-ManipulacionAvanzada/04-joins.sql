/**
JOINS

1. INNER JOIN
2. LEFT JOIN
3. RIGHT JOIN
4. FULL JOIN
**/

-- Seleccionar las categorías y sus productos

SELECT 
	Categories.CategoryID, 
	Categories.CategoryName,
	Products.ProductID,
	Products.ProductName,
	Products.UnitPrice,
	Products.UnitsInStock,
	(Products.UnitPrice * Products.UnitsInStock) 
	AS [Precio Inventario]
FROM Categories
INNER JOIN Products
ON Categories.CategoryID = products.CategoryID
WHERE Categories.CategoryID = 9;

-- Crear una tabla a partir de una consulta
SELECT TOP 0 CategoryID, CategoryName
INTO Categoria
FROM Categories;

ALTER TABLE Categoria
ADD CONSTRAINT pk_categoria
PRIMARY KEY (CategoryID);

INSERT INTO Categoria
VALUES('C1'), ('C2'), ('C3'), ('C4'), ('C5');


SELECT TOP 0
	ProductID AS [Numero_producto],
	ProductName AS [Nombre_producto],
	CategoryID AS [Catego_ID]
INTO Producto
FROM Products;

ALTER TABLE Producto
ADD CONSTRAINT pk_producto
PRIMARY KEY (numero_producto);

ALTER TABLE Producto
ADD CONSTRAINT fk_producto_categoría
FOREIGN KEY (catego_id)
REFERENCES Categoria (CategoryID)
ON DELETE CASCADE;

INSERT INTO Producto
VALUES ('P1', 1),
	   ('P2', 1),
	   ('P3', 2),
	   ('P4', 2),
	   ('P5', 3),
	   ('P6', NULL);

-- INNER JOIN

SELECT *
FROM Categoria AS c
INNER JOIN
Producto AS p
ON c.CategoryID = p.catego_id;

-- RIGHT JOIN

SELECT *
FROM Categoria AS c
RIGHT JOIN
Producto AS p
ON c.CategoryID = p.catego_id;

-- Simular el right join del query anterior
-- LEFT JOIN

SELECT 
	c.CategoryID,
	c.CategoryName,
	p.Numero_producto,
	p.Nombre_producto,
	p.Catego_ID
FROM Producto AS p
LEFT JOIN
Categoria AS c
ON c.CategoryID = p.Catego_id;

SELECT 
	c.CategoryID,
	c.CategoryName,
	p.Numero_producto,
	p.Nombre_producto,
	p.Catego_ID
FROM Categoria AS c
RIGHT JOIN
Producto AS p
ON c.CategoryID = p.Catego_id;

SELECT *
FROM Producto AS p 
LEFT JOIN
Categoria AS c
ON c.CategoryID = p.catego_id;

-- FULL JOIN

SELECT c.CategoryID, c.CategoryName
FROM Categoria AS c
FULL JOIN
Producto AS p
ON c.CategoryID = p.catego_id;

SELECT c.CategoryID, c.CategoryName
FROM Categoria AS c
LEFT JOIN
Producto AS p
ON c.CategoryID = p.catego_id
WHERE numero_producto is null;

-- Seleccionar todos los productos que no tienen categoria

SELECT *
FROM Categoria AS c
RIGHT JOIN
Producto AS p
ON c.CategoryID = p.catego_id
WHERE catego_id is null;

-- Guardar  en una tabla de productos 

SELECT *
FROM Categoria;

SELECT *
FROM Producto;


-- Crear la tabla products_new a partir de products,
-- mediante una consulta
SELECT TOP 0
	   ProductID AS [product_number],
	   ProductName AS [product_name],
	   UnitPrice AS unit_price,
	   UnitsInStock AS [stock],
	   (UnitPrice * UnitsInStock) AS [total]
INTO products_new
FROM Products

ALTER TABLE products_new
ADD CONSTRAINT pk_products_new
PRIMARY KEY ([product_number]);

INSERT INTO products_new

SELECT 
	p.ProductID, 
	p.ProductName, 
	p.UnitPrice, 
	p.UnitsInStock,
	(p.UnitPrice * p.UnitsInStock) AS [Total],
	pw.*
FROM Products AS p
LEFT JOIN products_new AS pw
ON p.ProductID = pw.product_number;


INSERT INTO products_new
SELECT
	p.ProductName, 
	p.UnitPrice, 
	p.UnitsInStock,
	(p.UnitPrice * p.UnitsInStock) AS [Total]
FROM Products AS p
LEFT JOIN products_new AS pw
ON p.ProductID = pw.product_number
WHERE product_number IS NULL;

