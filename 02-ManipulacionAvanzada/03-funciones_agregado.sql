/*
	Funciones de Agregado:

	1. sum()
	2. max()
	3. min()
	4. avg()
	5. count(*)
	6. count(campo)

	NOTA: Estas funciones solamente regresan un solo registro
*/


-- Seleccionar los paise de donde son los clientes

SELECT DISTINCT Country
FROM Customers;

--Agregacion count(*) cuenta el numero de registros que tiene una tabla

SELECT COUNT (*) AS [Total de Ordenes]
FROM Orders;

--Seleccionar el total de ordenes que fueron enviadas a Alemania

SELECT COUNT (*)
FROM Orders
WHERE ShipCountry = 'Germany';

SELECT shipcountry, COUNT (*)
FROM Orders
GROUP BY ShipCountry;

SELECT COUNT (CustomerID)
FROM Customers;

SELECT COUNT (Region)
FROM Customers;

-- Selecciona de cuantas ciudades son las ciudades de los clientes

SELECT city
FROM Customers
ORDER BY city ASC;

SELECT COUNT(city)
FROM Customers;

SELECT COUNT(DISTINCT city) AS [CIUDADES CLIENTES]
FROM Customers;

-- Selecciona el precio maximo de los productos

SELECT *
FROM Products
ORDER BY UnitPrice	DESC;

SELECT MAX(UnitPrice) AS [Precio mas Alto]
FROM Products;

-- Seleccionar la fecha de compra mas actual 

SELECT MAX(OrderDate) AS [Fecha mas reciente]
FROM Orders;

-- Seleccionar el año de la fecha de compra mas reciente

SELECT MAX(DATEPART(YEAR, OrderDate)) AS [Fecha mas reciente]
FROM Orders;

-- Cual es el minimo cantidad de los pedidos

SELECT MIN(UnitPrice) AS [Minimo cantidad de pedidos]
FROM [Order Details];

-- Cual es el importe mas bajo de las compras

SELECT (UnitPrice * Quantity * (1-Discount)) AS [IMPORTE]
FROM [Order Details]
ORDER BY [IMPORTE] ASC;

SELECT (UnitPrice * Quantity * (1-Discount)) AS [IMPORTE]
FROM [Order Details]
ORDER BY (UnitPrice * Quantity * (1-Discount)) ASC;

SELECT MIN(UnitPrice * Quantity * (1-Discount)) AS [IMPORTE]
FROM [Order Details];

-- Obtener el total de los precios de los productos
SELECT SUM(UnitPrice) AS [TOTAL DE LOS PRODUCTOS]
FROM Products;

-- Obtener el total de dinero percibido por las ventas
SELECT SUM(UnitPrice * Quantity * (1-Discount)) AS [Total de dinero percibido]
FROM [Order Details];

-- Seleccionar las ventas totales de los productos 4, 10 y 20

SELECT SUM(UnitPrice * Quantity * (1-Discount)) AS [IMPORTE]
FROM [Order Details]
WHERE ProductID IN (4, 10, 20)
GROUP BY ProductID;

-- Seleccionar el numero de ordenes hechas por los siguientes clientes
-- Around the Horn, Bolido Comidas preparadas, Chop-suey Chinese

SELECT *
FROM Orders;

SELECT ShipName, COUNT(*) AS NumeroDeOrdenes
FROM Orders
WHERE ShipName IN ('Around the Horn', 'Bólido Comidas preparadas', 'Chop-suey Chinese')
GROUP BY ShipName

-- Seleccionar el total de ordener del segundo trimestre de 1997

SELECT COUNT(*) AS TotalOrdenes_1997
FROM Orders
WHERE DATEPART(QUARTER, OrderDate) = 2
AND DATEPART(YEAR, OrderDate) = 1997

-- Seleccionar el numero de ordenes entre 1991 a 1994

SELECT COUNT(*) AS [Numero de Ordenes]
FROM Orders
WHERE YEAR(OrderDate) BETWEEN 1996 AND 1997;

-- Seleccionar el numero de clientes que comienzan con a o que comienzen con b

SELECT * FROM Customers;

SELECT COUNT(CompanyName) AS [Clientes que comiencen con a y b]
FROM Customers
WHERE CompanyName LIKE 'a%' OR CompanyName LIKE 'b%';

-- Seleccionar el numero de clientes que comienzan con b y terminen con s

SELECT COUNT(CompanyName) AS [Clientes que comiencen con a y b]
FROM Customers
WHERE CompanyName LIKE 'b%s';

-- Seleccionar el numero de ordenes realizadas por el cliente Chop-suey Chinese en 1995

SELECT * FROM [Order Details];
SELECT * FROM Orders;
SELECT * FROM Customers;

SELECT COUNT(CustomerID) AS [Numero de ordenes], CustomerID 
FROM Orders
WHERE YEAR(OrderDate) = 1996 AND CustomerID = 'CHOPS'
GROUP BY CustomerID;

SELECT COUNT(*) AS [Numero de Ordenes]
FROM Orders
WHERE CustomerID = 'CHOPS' AND YEAR(OrderDate) = 1996;

/*
	GROUP BY Y HAVING
*/

SELECT CustomerID, COUNT(*) AS [Numero de Ordenes]
FROM Orders
GROUP BY CustomerID
ORDER BY 2 DESC;

SELECT customers.CompanyName, COUNT(*) AS [Numero de Ordenes]
FROM Orders
INNER JOIN
Customers
ON orders.CustomerID = Customers.CustomerID
GROUP BY Customers.CompanyName
ORDER BY 2 DESC;

SELECT 
c.CompanyName,
COUNT(*) AS [Numero de Ordenes]
FROM Orders AS o
INNER JOIN
Customers AS c
ON o.CustomerID = c.CustomerID
GROUP BY c.CompanyName
ORDER BY 2 DESC;

-- Seleccionar el numero de productos (conteo) por categoria, mostrar CategoriaID, Total de los productos
-- ordenarlos de mayor a menor por el Total de productos

SELECT * 
FROM Products;

SELECT CategoryID, COUNT(UnitsInStock) AS [Total de productos]
FROM Products
GROUP BY CategoryID
ORDER BY 2 DESC;

-- Seleccionar el precio promedio por provedor de los productos 
-- Redondear a dos decimales el resultado
-- Ordenar de forma descendente por el precio promedio

SELECT 
    SupplierID, 
    ROUND(SUM(UnitPrice) / COUNT(*), 2) AS PrecioPromedio
FROM Products
GROUP BY SupplierID
ORDER BY PrecioPromedio DESC;

-- Seleccionar el numero de clientes por Pais ordenarlos por pais alfabeticamente

SELECT 
	COUNT(*) AS [Ordenarlos por pais alfabeticamente],
	Country
FROM Customers
GROUP BY Country;


-- Obtener la cantidad total vendida agrupada por producto y pedido


SELECT *, (UnitPrice * Quantity) AS [Total]
FROM [Order Details];

SELECT SUM(UnitPrice * Quantity) AS [Total]
FROM [Order Details];

SELECT ProductID, SUM(UnitPrice * Quantity) AS [Total]
FROM [Order Details]
GROUP BY ProductID
ORDER BY ProductID;

SELECT ProductID,OrderID, SUM(UnitPrice * Quantity) AS [Total]
FROM [Order Details]
GROUP BY ProductID, OrderID
ORDER BY ProductID, [Total] DESC

SELECT *, (UnitPrice * Quantity) AS [Total]
FROM
[Order Details]
WHERE OrderID = 10847 AND ProductID = 1

-- Seleccionar la cantidad maxima vendida por producto en cada pedido

SELECT ProductID,OrderID, MAX(Quantity) AS [CANTIDAD MAXIMA]
FROM [Order Details]
GROUP BY ProductID,OrderID
ORDER BY ProductID, OrderID

-- Flujo logico de ejecucion en sql 
/*
	1. FRONT
	2. JOIN
	3. WHERE
	4. GROUP BY
	5. HAVING
	6. SELECT
	7. DISTINCT
	8. ORDER BY
*/

-- Having  (filtro pero de grupos)

-- Seleccionar los clientes que hayan realizado mas de 10 pedidos


SELECT CustomerID, COUNT(*) AS [Numero de Ordenes]
FROM Orders
GROUP BY CustomerID
ORDER BY 2 DESC;

SELECT CustomerID, COUNT(*) AS [Numero de Ordenes]
FROM Orders
WHERE ShipCountry IN ('Germany', 'France', 'Brazil')
GROUP BY CustomerID
HAVING COUNT(*) > 10
ORDER BY 2 DESC;

SELECT CustomerID, COUNT(*) AS [Numero de Ordenes]
FROM Orders
GROUP BY CustomerID
HAVING COUNT(*) > 10
ORDER BY 2 DESC;

SELECT c.CompanyName, COUNT(*) AS [Numero de Ordenes]
FROM Orders AS o
INNER JOIN Customers AS c
ON o.CustomerID = c.CustomerID
GROUP BY c.CompanyName
HAVING COUNT(*) > 10
ORDER BY 2 DESC;

-- Seleccionar los empleados que hayan gestionado pedidos por un total superior por un total a 50000 en ventas
-- (Mostrar el id del empleado y el nombre y total de compras)

SELECT *
FROM Employees AS e
INNER JOIN Orders AS o
ON e.EmployeeID = o.EmployeeID
INNER JOIN [Order Details] AS od
ON o.OrderID = od.OrderID

SELECT 
	CONCAT(e.FirstName,' ', e.LastName) AS [Nombre Completo],
	(od.Quantity * od.UnitPrice * (1 - od.Discount)) AS [IMPORTE]
FROM Employees AS e
INNER JOIN Orders AS o
ON e.EmployeeID = o.EmployeeID
INNER JOIN [Order Details] AS od
ON o.OrderID = od.OrderID
ORDER BY e.FirstName;

SELECT 
	CONCAT(e.FirstName,' ', e.LastName) AS [Nombre Completo],
	ROUND(SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)), 2) AS [IMPORTE]
FROM Employees AS e
INNER JOIN Orders AS o
ON e.EmployeeID = o.EmployeeID
INNER JOIN [Order Details] AS od
ON o.OrderID = od.OrderID
GROUP BY e.FirstName, e.LastName
HAVING SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)) > 100000
ORDER BY [IMPORTE] DESC;

-- Seleccionar el numero de productos vendidos en mas de 20 pedidos distintos
-- Mostrar el id del producto, el nomnbre del prodcuto, el numero de ordenes

SELECT 
	p.ProductID, 
	p.ProductName, 
	COUNT(DISTINCT o.OrderID) AS [Numero de Pedidos]
FROM Products AS p
INNER JOIN [Order Details] AS od
ON p.ProductID = od.ProductID
INNER JOIN Orders AS o
ON o.OrderID = od.OrderID
GROUP BY p.ProductID, p.ProductName
HAVING COUNT(DISTINCT o.OrderID) > 20;

-- Seleccionar los productos no descontinuados calcular el precio promedio vendido 
-- y mostrar solo aquellos que se hayan vendido en menos de 15 pedidos 

SELECT 
	p.ProductName,
	ROUND(AVG (od.UnitPrice), 2) AS [Promedio vendido]
FROM Products AS p
INNER JOIN [Order Details] AS od
ON p.ProductID = od.ProductID
WHERE p.Discontinued = 0
GROUP BY p.ProductName
HAVING COUNT(OrderID) < 15;

-- Seleccionar el precio maximo de productos por categoria, pero solo si la suma de unidades es menor a 200 
-- y ademas que no esten descontinuados

SELECT 
    c.CategoryID,
	c.CategoryName,
	p.ProductName,
    MAX(p.UnitPrice) AS PrecioMaximo
FROM Products AS p
INNER JOIN Categories AS c
ON p.CategoryID = c.CategoryID
WHERE p.Discontinued = 0
GROUP BY c.CategoryID,
		 c.CategoryName,
		 p.ProductName
HAVING SUM(p.UnitsInStock) < 200
ORDER BY CategoryName DESC, p.ProductName;