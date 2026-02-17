# Guía Rápida: Docker Desktop y Comandos Básicos

Este documento registra la verificación de la instalación y la descarga de imágenes de contenedores esenciales mediante la terminal.

---

## Fase 1: Verificación e Imágenes

Antes de crear nada, aseguramos el entorno y descargamos las "plantillas" (imágenes) necesarias.

### 1. Estado del Sistema
![Estado de Docker Desktop](/img/imagen07.png)
**Estado:** La aplicación de escritorio confirma que la versión **4.55.0** está actualizada y el motor está corriendo.

### 2. Comandos Iniciales (CLI)
![Versión y primer pull](/img/imagen08.png)
* **Versión:** `docker --version` confirma la build 29.1.3.
* **Descarga SQL:** Se inicia la descarga de la imagen de SQL Server 2019 (`docker pull ...mssql/server:2019-latest`).

### 3. Descarga de Herramientas Adicionales
![Pull MySQL](/img/imagen09.png)
![Pull Tutorial](/img/imagen10.png)
Se completó el inventario local descargando:
* **MySQL:** `docker pull mysql:latest`
* **Tutorial:** `docker pull docker/getting-started`

---

## Fase 2: Ejecución Básica

### 1. Listado y Primer "Run"
![Listar imágenes y correr](/img/imagen11.png)
* **`docker images`:** Muestra nuestro catálogo local (Tutorial, SQL Server, MySQL).
* **`docker run d793`:** Se arranca el contenedor del tutorial usando los primeros dígitos de su ID.

### 2. Verificación Visual (GUI)
![Panel de Contenedores](/img/imagen12.png)
El dashboard de Docker Desktop muestra el contenedor activo (nombre aleatorio: *serene_wiles*), confirmando que el comando anterior funcionó.

---

## Fase 3: Ciclo de Vida (Start, Stop, Remove)

Gestión de contenedores que ya existen pero están detenidos o necesitan ser borrados.

### 1. Historial de Contenedores
![Listado completo](/img/imagen13.png)
**Comando:** `docker container ls -a`
Muestra *todos* los contenedores, incluso los apagados. Aquí vemos que *serene_wiles* se detuvo (Exited).

### 2. Reactivación
![Start y Stop](/img/imagen14.png)
Se manipula el estado del contenedor existente:
* **`docker start 6f95`:** "Revive" el contenedor apagado.
* **`docker stop serene_wiles`:** Lo detiene usando su nombre.

### 3. Eliminación Forzada
![Borrado forzado](/img/imagen15.png)
* **Error:** Al intentar borrar (`rm`) un contenedor activo, Docker lo impide por seguridad.
* **Solución:** `docker rm -f 6f95` fuerza la eliminación inmediata.

---

## Fase 4: Configuración Avanzada

Aquí es donde "personalizamos" los contenedores para que sean útiles en desarrollo real.

### Despliegue con Puertos y Variables
![Run complejo con puertos](/img/imagen16.png)

Se ejecutan dos contenedores con configuraciones específicas:

1.  **Web Server (Tutorial):**
    * `docker run --name tutorial-docker -d -p 8089:80 d793`
    * **Explicación:** Se le pone nombre propio, se corre en segundo plano (`-d`) y se redirige el puerto 80 del contenedor al **8089** de tu PC.

2.  **SQL Server (Base de Datos):**
    * Se configura con variables de entorno críticas (`-e`) para aceptar la licencia EULA y definir la contraseña (`SA_PASSWORD`).
    * Se mapea el puerto **1435** (PC) al **1433** (SQL).

---

## Fase 5: Persistencia de Datos (Volúmenes)

Para evitar que los datos se borren al eliminar un contenedor, creamos un volumen independiente.

![Creación de volumen](/img/imagen18.png)

**Comandos ejecutados:**
1.  **Crear:** `docker volume create volume-mssqlevnd`
    * Se crea un espacio de almacenamiento aislado llamado *volume-mssqlevnd*.
2.  **Verificar:** `docker volume ls`
    * Confirma que el volumen existe y es de tipo `local`.

---

## Fase 6: Despliegue de SQL Server (Producción)

Aquí unimos todo: puertos personalizados, contraseñas y el volumen de datos que creamos.

![Ejecución con volumen](/img/imagen19.png)

**Comando Maestro ejecutado:**
~~~
docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=P@ssw0rd" \
-p 1435:1433 --name servidorsqlserver \
-v volume-mssqlevnd:/var/opt/mssql/data \
-d [mcr.microsoft.com/mssql/server:2019-latest](https://mcr.microsoft.com/mssql/server:2019-latest)
~~~

## Fase 7: Conexión Final (Cliente SQL)

El paso definitivo: conectar una herramienta gráfica (como Azure Data Studio o SSMS) al contenedor que acabamos de crear.

![Conexión al servidor](/img/imagen17.png)

**`Parámetros de Conexión:`**
* **`Server Name:`** .,1435 (El punto representa localhost y la coma separa el puerto).
* **`Authentication:`** SQL Server Authentication.
* **`User name:`** sa (El usuario por defecto configurado en la imagen).
* **`Password:`** La contraseña definida en la variable MSSQL_SA_PASSWORD del paso anterior.
* **`Resultado:`** ¡Conexión exitosa a una instancia de SQL Server que vive aislada dentro de Docker!