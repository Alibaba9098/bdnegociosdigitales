# ¿Que es una subconsulta?

Una subconsulta (subquery) es ubn select dentro de otro SELECT. Puede devolver:

1. Un soloo valor  (escalar)
1. Una lista de valores (una columna, varias filas)
1. Una tabla (varias columnas y/o varias filas)
1. Segun lo que devuelva se elige el operador correcto (=, IN, EXISTS, etc).

Una subconsulta es una consulta anidada dentro de otra consulta que permite resolver problemas en varios niveles de informacion

```
Dependiendo de donde se coloque y que retorne, cambia su comportamiento
```

5 grandes formas de ussarlas

1. Subconsultas escalares
2. Subconsultas con IN, ANY, ALL
3. Subconsultas correlacionadas
4. Subconsultas en SELECT
5. Subconsultas en FROM (Tablas derivadas)

1. Escalares

Devuelve un unico valor, por eso se pueden utilizar con operadores =, >, <.

Ejemplo:

SELECT *
FROM pedidos
WHERE total = (
    SELECT MAX(total)
    FROM pedidos
);

## Subconsultas con IN, ANY, ALL
Devuelve varios valores con una sola columna (IN)

> Seleccionar todos los clientes que han hecho pedidos
```sql
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
```

## Clausula ANY

- Compara un valor contra una Lista
- La condiccion se cumple si se cumple con AL MENOS UNO

```sql
valor > ANY (subconsulta)
```

> Es como decir: Mayor que al mennos uno de los valores

- Seleccionar Pedidos mayores que algun pedido de Luis (id_cliente = 2)

```sql
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

```

## Clausula ALL
Se cumple contra todos los valores 

```sql
valor > ALL (subconsulta)
```

Significa:

- Mayor que todos los valores

```sql
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
```

## Subconsultas correlacionadas

> Una subconsulta correlacionada depende de la fila actual de la consulta principal y se ejecuta
una vez por cada fila 

---

1. Seleccionar los clientes cuyo total de compras sea mayor a 1000