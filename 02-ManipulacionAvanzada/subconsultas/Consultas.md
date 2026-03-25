# Manual de Referencia SQL Server

Este documento explica los comandos y funciones utilizados en el script de clase, cubriendo desde la creación de bases de datos hasta consultas complejas.

---

## 1. DDL - Definición de Datos

Comandos para crear y modificar la estructura de la base de datos.

### Crear Base de Datos
```sql
CREATE DATABASE tienda;
USE tienda; -- Selecciona la base de datos para trabajar

```

### Crear Tablas

Define las columnas y sus tipos de datos.

* **INT:** Números enteros.
* **NVARCHAR(n):** Texto variable (acepta caracteres especiales/Unicode).
* **MONEY:** Formato optimizado para moneda.
* **DATE:** Solo fecha (AAAA-MM-DD).
* **IDENTITY(1,1):** Campo autoincrementable (empieza en 1, avanza de 1 en 1).

```sql
CREATE TABLE clientes_2(
    cliente_id INT not null IDENTITY (1,1),
    nombre NVARCHAR(50) not null,
    fecha_registro date default GETDATE()
);

```

### Modificar y Eliminar Tablas

```sql
ALTER TABLE products DROP CONSTRAINT fk_products_suppliers; -- Borrar una restricción
DROP TABLE products; -- Eliminar la tabla completa

```

---

## 2. Restricciones (Constraints)

Reglas que aseguran la calidad de los datos.

| Restricción | Descripción | Ejemplo del Script |
| --- | --- | --- |
| **PRIMARY KEY** | Identificador único de la fila. No se repite, no es nulo. | `CONSTRAINT pk_suppliers PRIMARY KEY (supplier_id)` |
| **FOREIGN KEY** | Crea relación con otra tabla (padre-hijo). | `REFERENCES suppliers (supplier_id)` |
| **UNIQUE** | Evita valores duplicados en una columna que no es PK. | `CONSTRAINT unique_name UNIQUE ([name])` |
| **CHECK** | Valida que el dato cumpla una condición lógica. | `CHECK (credit_limit > 0 AND credit_limit <= 50000)` |
| **DEFAULT** | Inserta un valor por defecto si no se especifica. | `DEFAULT GETDATE()` o `DEFAULT 500.0` |

---

## 3. DML - Manipulación de Datos

### INSERT (Agregar datos)

Se puede insertar indicando columnas o asumiendo el orden.

```sql
-- Insertar especificando columnas (Recomendado)
INSERT INTO clientes_2 (nombre, edad, limite_credito)
VALUES ('Batman', 45, 89000);

-- Insertar usando DEFAULT en columnas
INSERT INTO suppliers
VALUES (UPPER('bimbo'), DEFAULT, UPPER('c'), 45000);

```

### UPDATE (Actualizar datos)

> **¡Cuidado!** Si olvidas el `WHERE`, actualizarás **toda** la tabla.

```sql
UPDATE products
SET supplier_id = 10
WHERE product_id IN (3, 4); -- Actualiza solo los IDs 3 y 4

```

### DELETE (Eliminar datos)

```sql
DELETE FROM products
WHERE supplier_id = 1; -- Elimina filas que cumplan la condición

```

---

## 4. Integridad Referencial

Define qué pasa con los datos hijos cuando se borra o edita al padre.

### Comportamientos configurados

1. **NO ACTION (Por defecto):** Si intentas borrar un proveedor que tiene productos, SQL **bloquea** la operación y da error.
2. **ON DELETE SET NULL:** Si borras al proveedor, el campo `supplier_id` en la tabla de productos se vuelve `NULL` (queda huérfano pero no se borra).
3. **ON UPDATE SET NULL:** Si cambias el ID del proveedor, los productos pierden la referencia (se vuelven `NULL`).

```sql
FOREIGN KEY (supplier_id) 
REFERENCES suppliers (supplier_id)
ON DELETE SET NULL
ON UPDATE SET NULL

```

---

## 5. DQL - Consultas Básicas

### SELECT y Proyección

```sql
-- Seleccionar todo
SELECT * FROM Products;

-- Seleccionar columnas específicas y usar ALIAS (AS)
SELECT 
    ProductID AS [NUMERO DE PRODUCTO],
    ProductName 'NOMBRE DE PRODUCTO' -- Comillas simples también sirven para alias
FROM Products;

```

### Campos Calculados

Realizar operaciones matemáticas en la consulta (no altera la tabla real).

```sql
-- Calcular precio con descuento
SELECT 
    UnitPrice * Quantity * (1 - Discount) AS ImporteConDescuento
FROM [Order Details];

```

---

## 6. Filtrado de Datos (WHERE)

El comando `WHERE` filtra filas **antes** de agruparlas.

### Operadores de Comparación

| Operador | Significado |
| --- | --- |
| `=`, `!=`, `<>` | Igual, Diferente |
| `>`, `<`, `>=`, `<=` | Mayor, Menor, Mayor igual... |
| `IS NULL` | Busca valores vacíos/nulos |

### Operadores Lógicos y de Rango

```sql
-- Rango inclusivo
WHERE UnitPrice BETWEEN 20 AND 40;

-- Lista de valores
WHERE Country IN ('Germany', 'France', 'UK');

-- Lógica compuesta
WHERE (Country = 'USA' OR Country = 'Canada') AND CompanyName LIKE 'B%';

```

### Patrones de Texto (LIKE)

Se usan con comodines para buscar texto.

| Comodín | Descripción | Ejemplo |
| --- | --- | --- |
| `%` | Cualquier cadena de caracteres | `'a%'` (Empieza con a) |
| `_` | Un solo carácter | `'a__' ` (Empieza con a y tiene 2 letras más) |
| `[]` | Rango o lista de caracteres | `'[bsp]%'` (Empieza con b, s o p) |
| `[^]` | Negación del rango | `'[^a-f]%'` (NO empieza con letras de la a a la f) |

---

## 7. Funciones de Fecha y Texto

### Fechas

SQL Server tiene funciones potentes para extraer partes de una fecha.

```sql
GETDATE() -- Fecha y hora actual del servidor
YEAR(OrderDate) -- Extrae el año
MONTH(OrderDate) -- Extrae el mes
DATEPART(QUARTER, OrderDate) -- Extrae el trimestre (1-4)
DATENAME(WEEKDAY, OrderDate) -- Devuelve el nombre del día (Lunes, Martes...)

```

### Texto

```sql
UPPER('texto') -- Convierte a MAYÚSCULAS
CONCAT(Nombre, ' ', Apellido) -- Une cadenas de texto

```

---

## 8. Agrupación y Agregación

Las funciones de agregado comprimen muchas filas en un solo valor.

### Funciones Principales

* `COUNT(*)`: Cuenta filas totales.
* `COUNT(campo)`: Cuenta filas donde el campo NO es nulo.
* `SUM()`: Sumatoria.
* `AVG()`: Promedio.
* `MAX()` / `MIN()`: Valor máximo o mínimo.

### GROUP BY

Obligatorio cuando usas funciones de agregado junto con columnas normales. "Agrupa los resultados POR país, POR categoría, etc."

```sql
-- ¿Cuántas órdenes hay por país?
SELECT ShipCountry, COUNT(*) 
FROM Orders
GROUP BY ShipCountry;

```

### HAVING

Es **como un WHERE, pero para grupos**. Filtra después de que `GROUP BY` ha hecho su trabajo.

```sql
SELECT CustomerID, COUNT(*) 
FROM Orders
GROUP BY CustomerID
HAVING COUNT(*) > 10; -- Solo muestra clientes con más de 10 órdenes

```

> **Diferencia Clave:**
> * `WHERE`: Filtra filas individuales (ej. Pedidos de 1997).
> * `HAVING`: Filtra resultados agregados (ej. Clientes con suma de compras > 5000).
> 
> 

---

## 9. Joins y Orden de Ejecución

### Orden Lógico de Ejecución

Aunque escribimos `SELECT` primero, SQL lo ejecuta casi al final. Este es el orden real en que el motor procesa tu código:

1. **FROM / JOIN:** Identifica las tablas y cruza los datos.
2. **WHERE:** Filtra las filas base.
3. **GROUP BY:** Agrupa los datos restantes.
4. **HAVING:** Filtra los grupos formados.
5. **SELECT:** Elige qué columnas mostrar y calcula expresiones.
6. **DISTINCT:** Elimina duplicados.
7. **ORDER BY:** Ordena el resultado final.

### Ejemplo Completo (JOIN + GROUP BY + HAVING)

```sql
SELECT 
    p.ProductName,
    ROUND(AVG(od.UnitPrice), 2) AS [Promedio vendido]
FROM Products AS p
INNER JOIN [Order Details] AS od ON p.ProductID = od.ProductID
WHERE p.Discontinued = 0        -- 1. Filtra productos activos
GROUP BY p.ProductName          -- 2. Agrupa por nombre
HAVING COUNT(OrderID) < 15      -- 3. Filtra grupos con pocas ventas
ORDER BY [Promedio vendido];    -- 4. Ordena el reporte final

```
