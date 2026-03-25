-- 1
SELECT p.Num_Pedido, p.Fecha_Pedido, c.Empresa, pr.Descripcion, 
    p.Cantidad, pr.Precio,
    (p.Cantidad * pr.Precio) AS [Total Calculado]
FROM Clientes AS c
INNER JOIN Pedidos AS p
ON p.Cliente = c.Num_Cli
INNER JOIN Productos AS pr
ON p.Fab = pr.Id_fab AND p.Producto = pr.Id_producto
WHERE p.Fecha_Pedido BETWEEN '1989-10-10' AND '1990-2-10'

--2
SELECT c.Num_Cli, c.Empresa, c.Limite_Credito, r.Nombre
FROM Clientes AS c
INNER JOIN Representantes AS r
ON c.Rep_Cli = r.Num_Empl
WHERE c.Limite_Credito IN (20000, 30000, 65000) 
ORDER BY c.Empresa, c.Limite_Credito DESC

--3
SELECT Id_fab, Id_producto, Descripcion, Precio, Stock
FROM Productos 
WHERE Descripcion LIKE 'Zapata%' AND Precio > 1000

--4
SELECT * --r.Num_Empl, r.Nombre, p.Rep
FROM Representantes AS r
INNER JOIN Pedidos AS p
ON r.Num_Empl = p.Rep

--5
SELECT c.Num_Cli, c.Empresa, SUM(p.Importe) AS [Total_Importe]
FROM Clientes AS c
INNER JOIN Pedidos AS p
ON c.Num_Cli = p.Cliente
GROUP BY c.Num_Cli, c.Empresa
HAVING SUM(p.Importe) >= 20000
ORDER BY SUM(p.Importe) DESC

--6
/*
SELECT *
FROM Pedidos AS p
INNER JOIN Representantes AS r
*/

--7
CREATE OR ALTER VIEW vw_PedidosDetalle_A
AS
SELECT p.Num_Pedido, p.Fecha_Pedido, c.Empresa, 
    p.Rep, pr.Id_fab, pr.Id_producto, pr.Descripcion, p.Cantidad, pr.Precio,
    (p.Cantidad * pr.Precio) AS [Total Calculado]
FROM Clientes AS c
INNER JOIN Pedidos AS p
ON c.Num_Cli = p.Cliente 
INNER JOIN Productos AS pr
ON p.Fab = pr.Id_fab AND p.Producto = pr.Id_producto;

--8
CREATE OR ALTER VIEW vw_VentasPorRepresentante_A
AS
SELECT r.Num_Empl, r.Nombre, 
    SUM(p.Importe) AS [Total Importe], COUNT(p.Num_Pedido) AS [Total Pedidos]
FROM Representantes AS r
INNER JOIN Pedidos AS p
ON P.Rep = R.Num_Empl
GROUP BY r.Num_Empl, r.Nombre
HAVING SUM(p.Importe) >= 30000;






1-21
2-10
3-2
4-9
5-6 having
6-7  3JOINS-- REPRESENTANTES CON PEDIDOS Y OFICINAS CON REPRESENTANTES
vista 1-28
vista 2-4 having








