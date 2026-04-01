-- 1. Crear BD -> bdpracticas
-- 2. Crear el siguiente Diagrama
--      Utilizando como base los datos de NORTHWND en las tablas de catalogo
/*
Se va a llenar con NORTHWND.dbo.products

    CatProducto
    -----------
    id_producto int identity PK
    nombre_Producto nvarchar(40)
    existencia int
    precio money
*/

/*
Se va a llenar con NORTHWND.dbo.customers

    CatCliente
    -----------
    id_cliente NCHAR(5) PK
    nombre_cliente NVARCHAR(40)
    pais nvarchar(15)
    ciudad navarchar(15)
*/

/*
    TblVenta
    ------------
    id.Venta PK identity
    fecha Date
    id_cliente FK
*/

/*
    tblDetalleVenta
    ------------
    id_venta int FK
    id_producto int PK FK
    precio_venta money
    cantidad_vendido int
*/

-- 3. Crear un store Procedure usp_agregar_venta
--  * Insertar en la tabla tblVenta, la fecha debe ser la fecha actual (getDate()), verificar si el cliente existe 
      /*
      Insertar en la tabla tblDetalleVenta
      -Verificar si el producto existe -> store termina
      -Obtener el precio del producto
      -Cantidad_vendido sea suficiente en la existencia de la tabla CatProducto -> store termina
      */
--  * Actualizar la existencia de la tabla CatProducto mediante la operacion existencia - cantidad_vendido
-- 4. Documentar todo el procedimiento de la solucion en archivo md
-- 5. Crear un commit llamado Practica venta en Store Procedure
-- 6. Hacer merge a main 
-- 7. Hacer Push a github

CREATE DATABASE bdpracticas;
GO

USE bdpracticas;
GO

CREATE TABLE CatProducto
(
    id_producto INT IDENTITY PRIMARY KEY,
    nombre_Producto NVARCHAR(40),
    existencia INT,
    precio MONEY
);
GO

CREATE TABLE CatCliente
(
    id_cliente NCHAR(5) PRIMARY KEY,
    nombre_cliente NVARCHAR(40),
    pais NVARCHAR(15),
    ciudad NVARCHAR(15)
);
GO

CREATE TABLE TblVenta
(
    id_Venta INT IDENTITY PRIMARY KEY,
    fecha DATE,
    id_cliente NCHAR(5) FOREIGN KEY REFERENCES CatCliente(id_cliente)
);
GO

CREATE TABLE tblDetalleVenta
(
    id_venta INT FOREIGN KEY REFERENCES TblVenta(id_Venta),
    id_producto INT FOREIGN KEY REFERENCES CatProducto(id_producto),
    precio_venta MONEY,
    cantidad_vendido INT,
    PRIMARY KEY (id_venta, id_producto)
);
GO

INSERT INTO CatProducto (nombre_Producto, existencia, precio)
SELECT ProductName, UnitsInStock, UnitPrice
FROM NORTHWND.dbo.products;
GO

INSERT INTO CatCliente (id_cliente, nombre_cliente, pais, ciudad)
SELECT CustomerID, CompanyName, Country, City
FROM NORTHWND.dbo.customers;
GO


CREATE OR ALTER PROC usp_agregar_venta
    @id_cliente NCHAR(5),
    @id_producto INT,
    @cantidad_vendido INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            
            -- Verificar si el cliente existe
            IF NOT EXISTS (SELECT 1 FROM CatCliente WHERE id_cliente = @id_cliente)
            BEGIN
                THROW 50001, 'El cliente especificado no existe en la base de datos.', 1;
            END

            -- Verificar si el producto existe
            IF NOT EXISTS (SELECT 1 FROM CatProducto WHERE id_producto = @id_producto)
            BEGIN
                THROW 50002, 'El producto especificado no existe.', 1;
            END

            -- Obtener el precio y la existencia actual
            DECLARE @precio_producto MONEY;
            DECLARE @existencia_actual INT;

            SELECT 
                @precio_producto = precio, 
                @existencia_actual = existencia 
            FROM CatProducto 
            WHERE id_producto = @id_producto;

            -- Verificar si la cantidad vendida es suficiente
            IF @cantidad_vendido > @existencia_actual
            BEGIN
                THROW 50003, 'Stock insuficiente para completar la venta.', 1;
            END

            -- Insertar en la tabla TblVenta
            INSERT INTO TblVenta (fecha, id_cliente)
            VALUES (GETDATE(), @id_cliente);

            -- Obtener el id de la venta recién insertada
            DECLARE @id_venta INT = SCOPE_IDENTITY();

            -- Insertar en la tabla tblDetalleVenta
            INSERT INTO tblDetalleVenta (id_venta, id_producto, precio_venta, cantidad_vendido)
            VALUES (@id_venta, @id_producto, @precio_producto, @cantidad_vendido);

            -- Actualizar la existencia de la tabla CatProducto
            UPDATE CatProducto
            SET existencia = existencia - @cantidad_vendido
            WHERE id_producto = @id_producto;

        COMMIT;
        PRINT 'Venta guardada correctamente.';

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK;
        PRINT 'Error al registrar la venta: ';
        THROW;
    END CATCH
END
GO


EXEC usp_agregar_venta 
@id_cliente = 'ALFKI', 
@id_producto = 1, 
@cantidad_vendido = 10;
GO

SELECT * FROM TblVenta;
GO

SELECT * FROM tblDetalleVenta;
GO

SELECT * FROM CatProducto;
GO
