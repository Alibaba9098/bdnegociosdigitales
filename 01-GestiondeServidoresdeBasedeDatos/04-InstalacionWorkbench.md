# Reporte Técnico: Instalación y Configuración de MySQL Workbench

---

## 1. Inicio del Asistente de Instalación
El proceso comienza con el asistente de configuración (*Setup Wizard*) para **MySQL Workbench 8.0 CE**.

![imagen Final.](/img/Imagen20.png)

* **Versión detectada:** El instalador indica que se instalará la versión `8.0.36`.

---

## 2. Configuración de la Nueva Conexión
Una vez instalado el software, se procede a crear una nueva conexión para enlazar Workbench con el servidor de base de datos.

![imagen Final.](/img/Imagen21.png)

**Parámetros configurados:**
* **Connection Name:** `MysqlEV`.
* **Connection Method:** Standard (TCP/IP).
* **Hostname:** `127.0.0.1` (Localhost).
* **Port:** `3341`.
    * *Observación Importante:* El puerto estándar de MySQL es el `3306`. En este caso, se ha configurado el puerto `3341`, lo cual se utilizan contenedores (Docker) o para evitar conflictos con otras instalaciones locales de MySQL.
* **Username:** `root`.

Se finaliza este paso haciendo clic en **"Test Connection"** para verificar la comunicación con el servidor.

---

## 3. Advertencia de Compatibilidad (Connection Warning)
Al intentar establecer la conexión, el sistema arroja una advertencia informativa: *"Incompatible/nonstandard server version or connection protocol detected"*.

![imagen Final.](/img/Imagen22.png)

* **Causa:** MySQL Workbench (versión 8.0) ha detectado que el servidor de base de datos corre una versión más reciente (**MySQL 9.5.0**).
* **Análisis:** Esto suele ocurrir cuando el motor de base de datos (el servidor o contenedor) está más actualizado que la herramienta cliente (Workbench).
* **Solución:** Aunque algunas funcionalidades nuevas podrían no estar soportadas visualmente, la conexión básica es segura y estable. Se selecciona la opción **"Continue Anyway"** (Continuar de todos modos).

---

## 4. Validación y Entorno de Trabajo
La conexión se ha establecido exitosamente, permitiendo el acceso a la interfaz principal de administración.

![imagen Final.](/img/Imagen23.png)

**Evidencias de funcionamiento:**
1.  **Panel de Navegación:** Se observan las opciones de administración (*Server Status*, *Users and Privileges*) a la izquierda.
2.  **Editor SQL:** Se visualiza un script SQL activo (`Query 1`) ejecutando sentencias de inserción de datos:
    ```sql
    CREATE DATABASE IF NOT EXISTS Northwind;
    USE Northwind;
    ...
    COMMIT;
    ```
3.  **Estado:** El sistema está listo para recibir consultas y gestionar la base de datos `MysqlEV`.