CREATE DATABASE bdsubconsultas;
GO

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

-- Subqueries de IN, ANNY, ALL (llevan solo columna)
-- La clausula IN

--Clientes que han hecho pedidos

SELECT id_cliente
FROM pedidos

SELECT *
FROM clientes
WHERE id_cliente IN (
    SELECT id_cliente
FROM pedidos
)

SELECT DISTINCT c.id_cliente, c.nombre, c.ciudad
FROM clientes AS c
INNER JOIN pedidos AS p
ON c.id_cliente = p.id_cliente

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
 FROM pedidos
