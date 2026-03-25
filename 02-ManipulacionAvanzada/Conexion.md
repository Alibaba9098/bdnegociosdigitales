### Mapa de Conexiones (Los `JOIN` que debes memorizar)

La tabla central de todo es **`Pedidos`**. A partir de ahí, todo se conecta. Grábate estas relaciones:

* **Pedidos con Clientes:**
`Pedidos.Cliente = Clientes.Num_Cli`
* **Pedidos con Representantes:**
`Pedidos.Rep = Representantes.Num_Empl`
* **Pedidos con Productos (¡Ojo con la llave doble!):**
`Pedidos.Fab = Productos.Id_fab AND Pedidos.Producto = Productos.Id_producto`
* **Clientes con Representantes (Quién atiende a quién):**
`Clientes.Rep_Cli = Representantes.Num_Empl`
* **Representantes con Oficinas (Dónde trabajan):**
`Representantes.Oficina_Rep = Oficinas.Oficina`
* **Oficinas con Representantes (Quién dirige la oficina):**
`Oficinas.Jef = Representantes.Num_Empl`
* **Representantes con Representantes (Quién es el jefe de quién):**
`Representantes.Jefe = Representantes.Num_Empl`

---

### Posibles Preguntas

#### Nivel 1: Filtros y Cálculos Básicos

**1. "¿Qué representantes tienen ventas que superan su cuota?"**

```sql
SELECT Nombre, Ventas, Cuota
FROM Representantes
WHERE Ventas > Cuota;

```

**2. "Calcula el importe total de todos los pedidos realizados en 1989."**

```sql
SELECT SUM(Importe) AS Total_Ventas_1989
FROM Pedidos
WHERE YEAR(Fecha_Pedido) = 1989;

```

#### Nivel 2: Agrupaciones (`GROUP BY`) y Cruces Simples

**3. "¿Cuál es el importe total de pedidos por cada cliente? Muestra el nombre de la empresa y el total."**
*Truco: Siempre que te pidan "por cada X", necesitas un `GROUP BY`.*

```sql
SELECT C.Empresa, SUM(P.Importe) AS Total_Comprado
FROM Clientes C
INNER JOIN Pedidos P ON C.Num_Cli = P.Cliente
GROUP BY C.Empresa;

```

**4. "Muestra todos los pedidos incluyendo la descripción del producto."**
*Trampa: Tienes que igualar los dos campos de la llave compuesta.*

```sql
SELECT Ped.Num_Pedido, Prod.Descripcion, Ped.Cantidad, Ped.Importe
FROM Pedidos Ped
INNER JOIN Productos Prod ON Ped.Fab = Prod.Id_fab AND Ped.Producto = Prod.Id_producto;

```

#### Nivel 3: Cruces Múltiples y "Self-Joins" (Nivel Examen Final)

**5. "Lista a todos los empleados junto con el nombre de su jefe."**
*Trampa: La tabla se cruza consigo misma.*

```sql
SELECT Empleado.Nombre AS Representante, Jefe.Nombre AS Su_Jefe
FROM Representantes Empleado
LEFT JOIN Representantes Jefe ON Empleado.Jefe = Jefe.Num_Empl;

```

**6. "Muestra el nombre de la empresa, el pedido que hizo, la descripción del producto y el nombre del representante que tomó el pedido."**
*Truco: Es un súper `JOIN` de 4 tablas.*

```sql
SELECT C.Empresa, Ped.Num_Pedido, Prod.Descripcion, Rep.Nombre AS Vendedor
FROM Pedidos Ped
INNER JOIN Clientes C ON Ped.Cliente = C.Num_Cli
INNER JOIN Representantes Rep ON Ped.Rep = Rep.Num_Empl
INNER JOIN Productos Prod ON Ped.Fab = Prod.Id_fab AND Ped.Producto = Prod.Id_producto;

```

**7. "Encuentra las oficinas (Ciudad) cuyas ventas totales de todos sus representantes superen el objetivo de la oficina."**
*Truco: Tienes que sumar las ventas de los representantes de esa oficina y compararlas.*

```sql
SELECT O.Ciudad, O.Objetivo, SUM(R.Ventas) AS Ventas_Totales_Equipo
FROM Oficinas O
INNER JOIN Representantes R ON O.Oficina = R.Oficina_Rep
GROUP BY O.Ciudad, O.Objetivo
HAVING SUM(R.Ventas) > O.Objetivo;

```

---
