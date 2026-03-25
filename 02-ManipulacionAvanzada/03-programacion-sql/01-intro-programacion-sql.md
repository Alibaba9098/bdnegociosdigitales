# Lenguaje Transact-SQL (MSServer)

## 🤠 Fundamentos Programables

1. ¿Que es la parte programable de T-SQL?

Es todo lo que permite:

- Usar variables
- Controlar el flujo (if/else, while)
- Crear Procedimientos Almacenados (Stored Procedures)
- Dispadores errores
- Manejar errores
- Crear Funciones
- Usar Transacciones

Es convertir SQL es un lenguaje casi C/Java pero dentro del motor de base de datos 

2. Variables 

⚙️ Una variable almacena un valor temporal

```sql
/* ======================== Variables en Transact-SQL ===================*/

DECLARE @edad INT;
SET @edad = 21;

PRINT @edad

SELECT @edad AS [EDAD];

DECLARE @nombre AS VARCHAR(30) = 'San Gallardo';
SELECT @nombre AS [Nombre];
SET @nombre = 'San Adonai';
SELECT @nombre AS [Nombre];

/* ============================== Ejercicios =============================*/

/*
Ejercicio 1

- Declar una variable @Precio
- Asignar el valor 150
- Calcular el IVA (16)
- Mostrar el total

*/

DECLARE @Precio MONEY = 150;
DECLARE @Iva DECIMAL(10,2);
DECLARE @Total MONEY;

SET @Iva = @Precio * 0.16;
SET @Total = @Precio + @Iva;

SELECT @Precio AS [PRECIO],CONCAT('$', @Iva) AS [IVA (16%)], @Total AS [TOTAL]

```

👌 IF/ELSE 

⚙️ Definicion

Permite ejecutar codigo segun condicion 

```sql
DECLARE @edad INT;

SET @edad = 18;

IF @edad >= 18
    PRINT 'Eres mayor de edad';
ELSE
    PRINT 'Eres menor de edad';

GO

-- se de una calificacion si es mayor a 7 es aprobado, si es menor a 7 es reprobado
DECLARE @calificacion DECIMAL(10,2);
SET @calificacion = -8;

IF @calificacion >= 7
    PRINT 'Aprobado';
ELSE
    PRINT 'Reprobado';

-- Ahora que valide si esta en negativo ni mayor a 10
IF @calificacion < 0 OR @calificacion > 10
    PRINT 'Calificacion no valida';
ELSE IF @calificacion >= 7
    PRINT 'Aprobado';
ELSE
    PRINT 'Reprobado';

DECLARE @calif DECIMAL(10,2) = 9.5;

IF @calif >= 0 AND @calif <= 10
BEGIN
    IF @calif >= 7.0
    BEGIN
        PRINT('Aprobado');
    END
    ELSE
    BEGIN
        PRINT('Reprobado');
    END
END
ELSE
BEGIN
    SELECT CONCAT(@calif, ' Esta fuera de rango') AS [Respuesta];
END
```

😁 WHILE (CICLOS)

```sql
/* ============================== WHILE =============================*/

DECLARE @limite INT = 5;
DECLARE @i INT = 1;

WHILE (@i <= @limite)
BEGIN
    PRINT CONCAT('Numero: ', @i);
    SET @i = @i + 1;
END
```

