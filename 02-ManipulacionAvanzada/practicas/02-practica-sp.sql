-- Crear un store que permita agregar N productos

-- Crear tabla tipo Type -> Enviar como Parametro al Store

-- Parametros
/*
    id_cliente
    cantidad
    TablaType
*/

-- Crear un store que permita agregar N productos

-- Crear tabla tipo Type -> Enviar como Parametro al Store
-- Parametros
/*
    id_cliente
    cantidad
    TablaType
*/

USE bdpracticas;
GO

CREATE TYPE dbo.ProductoVentaType AS TABLE
(
    id_producto INT,
    cantidad_vendido INT
);
GO

CREATE OR ALTER PROC usp_agregar_venta_n_productos
    @id_cliente NCHAR(5),
    @productos dbo.ProductoVentaType READONLY
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            
            -- 1. Verificar si el cliente existe
            IF NOT EXISTS (SELECT 1 FROM CatCliente WHERE id_cliente = @id_cliente)
            BEGIN
                THROW 50001, 'El cliente especificado no existe en la base de datos.', 1;
            END

            -- 2. VALIDACIÓN DE STOCK (NUEVO)
            -- Si existe AL MENOS UN producto en la lista que supere el inventario, cancelamos todo.
            IF EXISTS (
                SELECT 1 
                FROM @productos p
                JOIN CatProducto c ON p.id_producto = c.id_producto
                WHERE p.cantidad_vendido > c.existencia
            )
            BEGIN
                THROW 50003, 'Stock insuficiente para uno o más productos de la lista.', 1;
            END

            -- 3. Insertar en la tabla TblVenta (Cabecera)
            INSERT INTO TblVenta (fecha, id_cliente)
            VALUES (GETDATE(), @id_cliente);

            -- Obtener el id de la venta recién insertada
            DECLARE @id_venta INT = SCOPE_IDENTITY();

            -- 4. Insertar en la tabla tblDetalleVenta
            INSERT INTO tblDetalleVenta (id_venta, id_producto, precio_venta, cantidad_vendido)
            SELECT 
                @id_venta, 
                p.id_producto, 
                c.precio, 
                p.cantidad_vendido
            FROM @productos p
            JOIN CatProducto c ON p.id_producto = c.id_producto;

            -- 5. Actualizar la existencia de los productos vendidos
            UPDATE c
            SET existencia = c.existencia - p.cantidad_vendido
            FROM CatProducto c
            JOIN @productos p ON c.id_producto = p.id_producto;

        COMMIT;
        PRINT 'Venta masiva guardada correctamente.';

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK;
        PRINT 'Error al registrar la venta: ';
        THROW;
    END CATCH
END
GO

DECLARE @ListaDeCompras dbo.ProductoVentaType;

INSERT INTO @ListaDeCompras (id_producto, cantidad_vendido)
VALUES 
    (1, 2),
    (2, 5),
    (3, 1);

EXEC usp_agregar_venta_n_productos 
    @id_cliente = 'ALFKI',
    @productos = @ListaDeCompras;

GO

SELECT * FROM TblVenta;

SELECT * FROM tblDetalleVenta;

SELECT * FROM CatProducto WHERE id_producto IN (1, 2, 3);
GO