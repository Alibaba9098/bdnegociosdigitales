# Guía de Instalación: SQL Server Management Studio (SSMS) 22

---

## Introducción

SQL Server Management Studio (SSMS) 22 es la última versión del entorno integrado para gestionar cualquier infraestructura SQL, desde SQL Server hasta Azure SQL Database.

---


## Paso 1: Descarga

1. Dirígete al sitio oficial de Microsoft Learn:
   [Descargar SQL Server Management Studio (SSMS)](https://learn.microsoft.com/es-es/sql/ssms/download-sql-server-management-studio-ssms)
2. Busca la sección **"Download SSMS 22"**.
3. Haz clic en el enlace para descargar el instalador (generalmente llamado `vs_SSMS.exe`).

4. **Ejecutar como Administrador:**
   Haz clic derecho sobre el archivo descargado (`vs_SSMS.exe`) y selecciona **"Ejecutar como administrador"**.

5. **Ventana de Instalación:**
   Se abrirá una ventana similar al *Visual Studio Installer*.
   * Verás el producto: **SQL Server Management Studio 22**.
   * La ruta de instalación por defecto suele ser:
     `C:\Program Files\Microsoft SQL Server Management Studio 22`

6. **Iniciar Instalación:**
   Haz clic en el botón **Instalar** (o *Install*). El instalador descargará y aplicará los paquetes necesarios.

   ![imagen Principal.](/img/Imagen04.png "This is a sample image.")

7. **Reinicio:**
   Una vez finalizado, es muy probable que se te solicite reiniciar el equipo. **Hazlo antes de abrir el programa.**


## Paso 2 :Configuracion

1. **Selección de la Edición**

Dentro del instalador principal (*Setup*), se selecciona la versión a instalar. Se eligió **"Developer"** bajo la opción de ediciones gratuitas, ideal para entornos de desarrollo y pruebas no productivas.

![Selección de edición Developer](/img/imagen05.png)

2. **Configuración del Motor de Base de Datos**

Configuración de seguridad crítica. Se seleccionó el **"Modo Mixto"** (autenticación de Windows + SQL Server), se estableció una contraseña para el administrador del sistema (`sa`) y se agregó al usuario actual de Windows como administrador de SQL Server.

![Configuración de autenticación mixta](/img/imagen06.png)

---

# Comandos SQL Esenciales y sus Funciones

Lista resumida de los comandos más importantes extraídos del script, organizados por su función principal.

## Definición de Estructura (DDL)

Estos comandos se encargan de crear y modificar el "esqueleto" de la base de datos.

- **`CREATE DATABASE [nombre]`**
  - **Función:** Crea un contenedor nuevo y vacío para almacenar toda la información.
  
- **`USE [nombre]`**
  - **Función:** Indica al sistema en qué base de datos se ejecutarán los siguientes comandos.

- **`CREATE TABLE [tabla]`**
  - **Función:** Define una nueva tabla especificando sus columnas y tipos de datos.

- **`IDENTITY(inicio, incremento)`**
  - **Función:** Configura una columna (usualmente el ID) para autogenerar números consecutivos (ej. 1, 2, 3...).

- **`CONSTRAINT [nombre] PRIMARY KEY`**
  - **Función:** Define el identificador único de cada fila (no permite duplicados ni nulos).

- **`CONSTRAINT [nombre] FOREIGN KEY`**
  - **Función:** Vincula una columna con otra tabla para asegurar que los datos estén relacionados correctamente.

- **`CONSTRAINT [nombre] CHECK`**
  - **Función:** Regla de validación lógica que impide guardar datos inválidos (ej. `precio > 0`).

- **`DEFAULT [valor]`**
  - **Función:** Inserta un valor automático si el usuario no escribe nada (ej. la fecha actual).

- **`ALTER TABLE`**
  - **Función:** Modifica la estructura de una tabla ya creada (ej. para borrar una restricción).

- **`DROP TABLE`**
  - **Función:** Elimina la tabla por completo y borra todos sus datos permanentemente.

---

## Manipulación de Datos (DML)

Estos comandos se usan para gestionar la información que vive dentro de las tablas.

- **`INSERT INTO [tabla] VALUES`**
  - **Función:** Agrega nuevos registros (filas) de información.

- **`SELECT * FROM [tabla]`**
  - **Función:** Consulta y visualiza los datos guardados en la tabla.

- **`UPDATE [tabla] SET`**
  - **Función:** Modifica información de registros que ya existen.

- **`DELETE FROM [tabla]`**
  - **Función:** Elimina uno o varios registros de la tabla.