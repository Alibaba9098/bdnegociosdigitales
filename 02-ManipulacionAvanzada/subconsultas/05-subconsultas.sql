-- Subconsulta escalar (Un valor)

-- Escalar en SELECT

SELECT 
	o.OrderID,
	(od.Quantity * od.UnitPrice) AS [Total],
	(SELECT AVG(od.Quantity * od.UnitPrice) FROM [Order Details] AS od) AS [AVGTOTAL]
FROM Orders AS o
INNER JOIN [Order Details] AS od
ON o.OrderID = od.OrderID;

-- Mostrar el nombre del producto y el precio promedio de todos los productos

SELECT 
    DISTINCT p.ProductName,
    (SELECT AVG(od.UnitPrice) FROM [Order Details] AS od) AS [Promedio Global]
FROM Products AS p
INNER JOIN [Order Details] AS od
ON p.ProductID = od.ProductID;

-- Mostrar cada empleado y la cantidad total de pedidos que tiene

-- Subconsulta correlacionada
SELECT 
    e.FirstName + ' ' + e.LastName AS Empleado,
    (SELECT COUNT(*) 
     FROM Orders AS o 
     WHERE o.EmployeeID = e.EmployeeID) AS CantidadPedidos
FROM Employees AS e;

SELECT e.EmployeeID, FirstName, LastName, COUNT(o.OrderID) AS [NUMERO DE ORDENES]
FROM Employees AS e
INNER JOIN Orders AS o
ON e.EmployeeID = o.EmployeeID
GROUP BY e.EmployeeID, FirstName, LastName;

-- Mostrar cada cliente y la fecha de su ultimo pedido 

-- Mostrar pedidos con nombre del cliente y total del pedido (sum)

SELECT
    o.OrderID,
    c.CompanyName,
    (SELECT SUM(od.Quantity * od.UnitPrice)
    FROM [Order Details] AS od
    WHERE od.OrderID = o.OrderID) AS [Total]
FROM Orders AS o
INNER JOIN Customers AS c
ON o.CustomerID = c.CustomerID;

-- Datos de Ejemplo

CREATE DATABASE bdsubconsultas;
GO

USE bdsubconsultas;

CREATE TABLE clientes(
id_cliente INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
nombre NVARCHAR(56) NOT NULL,
ciudad NCHAR(20) NOT NULL
);

CREATE TABLE pedidos(
id_pedido INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
id_cliente INT NOT NULL,
total MONEY NOT NULL,
fecha DATE NOT NULL,
CONSTRAINT fk_pedidos_clientes
FOREIGN KEY (id_cliente)
REFERENCES clientes(id_cliente)
);

-- Consulta Escalar:

SELECT *
FROM [Order Details];

INSERT INTO clientes (nombre, ciudad) VALUES
('Ana', 'CDMX'),
('Luis', 'Guadalajara'),
('Marta', 'CDMX'),
('Pedro', 'Monterrey'),
('Sofia', 'Puebla'),
('Carlos', 'CDMX'), 
('Artemio', 'Pachuca'), 
('Roberto', 'Veracruz');

INSERT INTO pedidos (id_cliente, total, fecha) VALUES
(1, 1000.00, '2024-01-10'),
(1, 500.00,  '2024-02-10'),
(2, 300.00,  '2024-01-05'),
(3, 1500.00, '2024-03-01'),
(3, 700.00,  '2024-03-15'),
(1, 1200.00, '2024-04-01'),
(2, 800.00,  '2024-02-20'),
(3, 400.00,  '2024-04-10');

-- Seleccionar los pedidos en donde 



SELECT p.id_pedido, c.nombre, p.fecha, p.total
FROM pedidos AS p
INNER JOIN clientes AS c
ON p.id_cliente = c.id_cliente
WHERE p.total = (
    SELECT MAX (total)
    FROM pedidos
);

-- Seleccionar los pedidos mayores al promedio 

SELECT AVG(total)
FROM pedidos;

SELECT *
FROM pedidos
WHERE total > (
    SELECT AVG(total)
    FROM pedidos
);

-- Seleccionar todos los pedidos del cliente que tenga el menor id

SELECT MIN(id_cliente)
FROM pedidos

SELECT *
FROM pedidos
WHERE id_cliente = (
    SELECT MIN(id_cliente)
FROM pedidos
);

SELECT id_cliente, COUNT(*) AS [Numerodepedidos]
FROM pedidos
WHERE id_cliente = (
    SELECT MIN(id_cliente)
FROM pedidos
)
GROUP BY id_cliente;

-- Mostrar los datos del pedido del ultima orden

SELECT MAX(fecha)
FROM pedidos

SELECT p.id_pedido, c.nombre, p.fecha, p.total
FROM pedidos AS p
INNER JOIN clientes AS c
ON p.id_cliente = c.id_cliente
WHERE fecha = (
    SELECT MAX(fecha)
FROM pedidos
);

-- Mostrar todos los pedidos con un total que sea el mas bajo

SELECT p.id_pedido, c.nombre, p.fecha, p.total, p.id_cliente
FROM pedidos AS p
INNER JOIN clientes AS c
ON p.id_cliente = c.id_cliente
WHERE total = (
    SELECT MIN(total)
FROM pedidos
);


-- Seleccionar los pedidos con el nombre del cliente cuyo
-- total (Freight) sea mayor al promedio general de freight

USE NORTHWND

SELECT AVG(Freight)
FROM orders;

SELECT o.OrderID, c.CompanyName, o.Freight
FROM Orders AS o
INNER JOIN Customers AS c
ON o.CustomerID = c.CustomerID
WHERE o.Freight > (
    SELECT AVG(Freight)
FROM orders
);

-- Subqueries de IN, ANNY, ALL (llevan solo columna)
-- La clausula IN

--Clientes que han hecho pedidos

SELECT id_cliente
FROM pedidos;

SELECT *
FROM clientes
WHERE id_cliente IN (
    SELECT id_cliente
FROM pedidos
);

SELECT DISTINCT c.id_cliente, c.nombre, c.ciudad
FROM clientes AS c
INNER JOIN pedidos AS p
ON c.id_cliente = p.id_cliente;

 -- Clientes que han pedido mayores a 800

 SELECT id_cliente
 FROM pedidos
 WHERE total > 800

 SELECT *
 FROM pedidos
 WHERE id_cliente IN (
    SELECT id_cliente
 FROM pedidos
 WHERE total > 800
 )

 -- Seleccionar todos los clientes de la ciudad de mexico que han hecho pedidos

 SELECT *
 FROM clientes
 WHERE ciudad = 'CDMX'
    AND id_cliente IN (
        SELECT id_cliente
        FROM pedidos
    )

 -- Seleccionar clientes que no han hecho pedidos 

SELECT id_cliente
FROM pedidos

SELECT *
FROM clientes
WHERE id_cliente NOT IN (
    SELECT id_cliente
    FROM pedidos
)

SELECT c.id_cliente, c.nombre, c.ciudad
FROM pedidos AS p
RIGHT JOIN clientes AS c
ON p.id_cliente = c.id_cliente
WHERE p.id_cliente IS NULL

-- Seleccione los pedidos de clientes de Monterrey

SELECT id_cliente
FROM clientes
WHERE ciudad = 'Monterrey'

SELECT *
FROM pedidos
WHERE id_cliente IN (
    SELECT id_cliente
FROM clientes
WHERE ciudad = 'Monterrey'
)

SELECT *
FROM clientes AS c
LEFT JOIN pedidos AS p
ON c.id_cliente = p.id_cliente
WHERE c.ciudad = 'Monterrey'

-- Operador ANY

-- Seleccionar Pedidos mayores que algun pedido de Luis (id_cliente = 2)

-- Primera consulta

SELECT total
FROM pedidos
WHERE id_cliente = 2

-- Consulta principal

SELECT *
FROM pedidos
WHERE total > ANY (
    SELECT total
FROM pedidos
WHERE id_cliente = 2
)

-- Selecionar los pedidos mayores (total) de algun pedido de Ana


SELECT total
FROM pedidos
WHERE id_cliente = 1

SELECT *
FROM pedidos
WHERE total > ANY (
    SELECT total
FROM pedidos
WHERE id_cliente = 1
)

-- Seleccionar los pedidos mayores a que algun pedido superior (total) a 500

SELECT total
FROM pedidos
WHERE total > 500

SELECT *
FROM pedidos
WHERE total > ANY (
    SELECT total
FROM pedidos
WHERE total > 500
)

-- Seleccionar los pedidos donde el total sea mayor a todos los totales de los pedidos de Luis
SELECT total
FROM pedidos
WHERE id_cliente = 2

SELECT *
FROM pedidos
WHERE total > ALL (
    SELECT total
FROM pedidos
WHERE id_cliente = 2
)

-- Seleccionar todos los clientes donde su id sea menor que todos los clientes de la ciudad de mexico
SELECT id_cliente
FROM clientes
WHERE ciudad = 'CDMX'

SELECT *
FROM clientes
WHERE id_cliente < ALL (
    SELECT id_cliente
FROM clientes
WHERE ciudad = 'CDMX'
)

-- Subconsultas correlacionadas

SELECT SUM(total)
FROM pedidos AS p

SELECT *
FROM clientes AS c
WHERE (
    SELECT SUM(total)
    FROM pedidos AS p
    WHERE p.id_cliente = c.id_cliente
)>1000

SELECT SUM(total)
FROM pedidos AS p
WHERE p.id_cliente = 3


-- Seleccionar todos los clientes que han hecho mas de un pedido

SELECT COUNT(*)
FROM pedidos AS p
WHERE p.id_cliente = 1

SELECT id_cliente, nombre, ciudad
FROM clientes AS c
WHERE (
    SELECT COUNT(*)
    FROM pedidos AS p
    WHERE p.id_cliente = c.id_cliente
) > 1

-- Seleccionar el total de pedidos que son mayores al promedio de los totales hechos por los clientes
SELECT AVG(total)
FROM pedidos AS p
WHERE p.id_cliente = 

SELECT *
FROM pedidos AS p
WHERE total > (
    SELECT AVG(total)
    FROM pedidos AS pe
    WHERE pe.id_cliente = p.id_cliente
)

-- Seleccionar todos los clientes su cuyo pedido maximo sea mayor a 1200 
SELECT MAX(total)
FROM pedidos AS p
WHERE p.id_cliente = 3

SELECT id_cliente, nombre, ciudad
FROM clientes AS c
WHERE (
    SELECT MAX(total)
    FROM pedidos AS p
    WHERE p.id_cliente = c.id_cliente
) > 1200




SELECT * FROM pedidos
SELECT * FROM clientes


USE bdsubconsultas