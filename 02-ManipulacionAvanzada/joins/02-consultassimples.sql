-- Consultas Simples con SQL-LMD

SELECT * FROM Categories;

SELECT * FROM Products;

SELECT * FROM Orders;

SELECT * FROM [Order Details];

-- Proyeccion (seleccionar algunos campos)

SELECT
ProductID, ProductName, UnitPrice, UnitsInStock
FROM Products;

--Alias de Columnas

SELECT
	ProductID AS [NUMERO DE PRODUCTO],
	ProductName 'NOMBRE DE PRODUCTO',
	UnitPrice AS [PRECIO UNITARIO],
	UnitsInStock AS STOCK
FROM Products;

SELECT 
	CompanyName AS CLIENTE,
	City AS CIUDAD,
	Country AS PAIS
FROM Customers;

-- Campos calculados

-- Seleccionar los productos y calcular el valor del inventario
SELECT *,(UnitPrice * UnitsInStock) AS [COSTO INVENTARIO]
FROM Products;

SELECT 
	ProductID, 
	ProductName,
	UnitPrice,
	UnitsInStock,
	(UnitPrice * UnitsInStock) AS [COSTO INVENTARIO]
FROM Products;

-- CALCULAR EL IMPORTE DE VENTA
SELECT * FROM [Order Details];

SELECT
	OrderID,
	ProductID,
	UnitPrice,
	Quantity,
	(UnitPrice * Quantity) AS [IMPORTE]
FROM [Order Details];

-- SELECCIONAR LA VENTA CON EL CALCULO DEL IMPORTE CON DESCUENTO

SELECT 
    OrderID, 
    ProductID, 
    UnitPrice, 
    Quantity, 
    Discount,
    -- 1. C�lculo del Importe (Precio x Cantidad)
    (UnitPrice * Quantity) AS Importe,
    
    -- 2. C�lculo con Descuento (Precio x Cantidad x (1 - Descuento))
    (UnitPrice * Quantity) * (1 - Discount) AS ImporteConDescuento
FROM [Order Details] -- (O el nombre de tu tabla)

-- Operaciones Relacionales (<,>,<=,>=,=,!=, <>

/*
	Seleccionar los productos con precio mayor a 30 
	Seleccionar los productos con stock menor o igual a 20
	Seleccionar los pedidos posteriores a 1997
*/

SELECT
	ProductID AS [Numero de Producto],
	ProductName AS [Nombre Producto],
	UnitPrice AS [Precio Unitario],
	UnitsInStock AS [Stock]
FROM Products
WHERE UnitPrice > 30
ORDER BY UnitPrice DESC;

SELECT
	ProductID AS [Numero de Producto],
	ProductName AS [Nombre Producto],
	UnitPrice AS [Precio Unitario],
	UnitsInStock AS [Stock]
FROM Products
WHERE UnitsInStock <= 20;


SELECT OrderID, OrderDate, CustomerID, ShipCountry,
	YEAR(OrderDate) AS A�o,
	MONTH(OrderDate) AS Mes,
	DAY(orderdate) AS D�a,
	DATEPART(YEAR, OrderDate) AS A�O2,
	DATEPART(QUARTER, OrderDate) AS Trimestre,
	DATEPART(WEEKDAY, OrderDate) AS [Dia Semana],
	DATENAME(WEEKDAY, OrderDate) AS [Dia Semana Nombre]
FROM Orders
WHERE YEAR(OrderDate) > '1997';



SELECT OrderID, OrderDate, CustomerID, ShipCountry,
	YEAR(OrderDate) AS A�o,
	MONTH(OrderDate) AS Mes,
	DAY(orderdate) AS D�a,
	DATEPART(YEAR, OrderDate) AS A�O2,
	DATEPART(QUARTER, OrderDate) AS Trimestre,
	DATEPART(WEEKDAY, OrderDate) AS [Dia Semana],
	DATENAME(WEEKDAY, OrderDate) AS [Dia Semana Nombre]
FROM Orders
WHERE DATEPART(YEAR, OrderDate) > '1997'

SET LANGUAGE SPANISH;
SELECT OrderID, OrderDate, CustomerID, ShipCountry,
	YEAR(OrderDate) AS A�o,
	MONTH(OrderDate) AS Mes,
	DAY(orderdate) AS D�a,
	DATEPART(YEAR, OrderDate) AS A�O2,
	DATEPART(QUARTER, OrderDate) AS Trimestre,
	DATEPART(WEEKDAY, OrderDate) AS [Dia Semana],
	DATENAME(WEEKDAY, OrderDate) AS [Dia Semana Nombre]
FROM Orders
WHERE DATEPART(YEAR, OrderDate) > '1997'


-- Operadores Logicos (not, and, or)

/*
	Seleccionar los productos que tengan un precio mayor a 20
	y menos de 100 unidades en stock

	Mostrar los clientes que sean de Estados Unidos o de Canada

	Obtener los pedidos que no tengan region

*/

SELECT 
	ProductID, 
	ProductName, 
	UnitPrice, 
	UnitsInStock
FROM Products
WHERE UnitPrice > 20 AND UnitsInStock < 100;

SELECT * FROM Orders;

SELECT 
	OrderID, 
	CustomerID, 
	ShipCountry
FROM Orders
WHERE ShipCountry IN ('USA', 'Canada');

SELECT * FROM Orders
WHERE ShipCountry = 'USA' 
   OR ShipCountry = 'Canada'

SELECT * FROM Orders
WHERE ShipRegion IS NULL;

SELECT * FROM Orders
WHERE ShipRegion IS NOT NULL;

SELECT 
	CustomerID, 
	CompanyName,
	City,
	Region,
	Country
FROM Customers
WHERE Country = 'USA' OR Country = 'Canada';

-- Operador IN

/*
	Mostrar los clietes de Alemania, Francia y UK

	Obtener los productos donde la categoria sea 1, 3 o 5 
*/

SELECT *
FROM Customers
WHERE Country IN ('Germany', 'France', 'uk')
ORDER BY Country DESC;

SELECT *
FROM Customers
WHERE Country = 'Germany' OR Country = 'France' OR Country = 'uk';

-- Operador Between
/*
	Mostrar los productos cuyo precio esta entre 20 y 40
*/

SELECT *
FROM Products
WHERE UnitPrice BETWEEN 20 AND 40
ORDER BY UnitPrice;

SELECT *
FROM Products
WHERE UnitPrice >= 20

-- Operador Like

-- Seleccionar todos los customers que comiencen con la letra a 

SELECT CustomerID, CompanyName, City, Region, Country
FROM Customers
WHERE CompanyName LIKE 'a%';

SELECT CustomerID, CompanyName, City, Region, Country
FROM Customers
WHERE city LIKE 'l_nd__%';


-- Seleccionar los clienets donde la ciudad contenga la letra L
SELECT CustomerID, CompanyName, City, Region, Country
FROM Customers
WHERE City LIKE '%si%';

-- Sleccionar los clientes que en su nombre comiencen con a o con b
SELECT CustomerID, CompanyName, City, Region, Country
FROM Customers
WHERE NOT (CompanyName LIKE 'a%' OR CompanyName LIKE 'b%');

-- Seleccionar todos los clientes que comince con b y termine con s 
SELECT CustomerID, CompanyName, City, Region, Country
FROM Customers
WHERE CompanyName LIKE 'b%s';

SELECT CustomerID, CompanyName, City, Region, Country
FROM Customers
WHERE CompanyName LIKE 'a__%';

-- Seleccnionar todos los clientes (Nombre) que cominecen con b, s, o "p"
SELECT CustomerID, CompanyName, City, Region, Country
FROM Customers
WHERE CompanyName LIKE '[bsp]%';

--Seleccionar todos customers comiecen con "a", "b", "c", "e", "f"
SELECT CustomerID, CompanyName, City, Region, Country
FROM Customers
WHERE CompanyName LIKE '[abcdef]%';

SELECT CustomerID, CompanyName, City, Region, Country
FROM Customers
WHERE CompanyName LIKE '[a-f]%'
ORDER BY 2 ASC;

SELECT CustomerID, CompanyName, City, Region, Country
FROM Customers
WHERE CompanyName LIKE '[^bsp]%';

SELECT CustomerID, CompanyName, City, Region, Country
FROM Customers
WHERE CompanyName LIKE '[^a-f]%'
ORDER BY 2 ASC;

-- Seleccionar todos los clientes de Estaods Unidos o Canada que empiezen con b

SELECT CustomerID, CompanyName, City, Region, Country
FROM Customers
WHERE (Country = 'USA' OR Country = 'Canada')
  AND CompanyName LIKE 'B%';

SELECT CustomerID, CompanyName, City, Region, Country
FROM Customers
WHERE Country IN ('USA','Canada')
  AND CompanyName LIKE 'B%';