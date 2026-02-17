# Guía de Instalación y Primeros Pasos en Git

Git es el estándar mundial para el control de versiones. Esta guía documenta el proceso de instalación, configuración y flujo de trabajo básico para gestionar proyectos.

---

## 1. Instalación

### Windows
1. Descarga el instalador desde [git-scm.com](https://git-scm.com/download/win).
![Imagen de Instalacion de GIT](/img/imagen01.png)
2. Ejecuta el archivo `.exe`.
3. **Importante:** Durante la instalación, asegúrate de marcar la opción que integra **Git Bash** en el menú contextual (click derecho).
4. Verifica la instalación abriendo **Git Bash** y escribiendo:

~~~
git --version
~~~

# Configuración Inicial de Git

Antes de comenzar a trabajar, se configuró el nombre y correo del usuario:

~~~
git config --global user.name "Tu Nombre"
git config --global user.email "tu_email@ejemplo.com"
~~~
    
## Caso Práctico: Inicialización del Repositorio Local

A continuación se documenta el proceso realizado para iniciar el control de versiones en el proyecto **BaseDeDatosNegociosDigitales**.

---

### 1. Creación del Repositorio

Se navegó a la carpeta del proyecto y se ejecutó el comando de inicialización.

~~~
cd /c/BaseDeDatosNegociosDigitales
git init
~~~

### 2. Preparación de Archivos (Staging)

Se añadieron todos los archivos y subcarpetas actuales (como 01-Gestion..., 02-Manipulacion..., img/, etc.) al área de preparación.

~~~
git add .
~~~

### 3. Verificación de Estado

Se confirmó que Git reconociera correctamente los archivos antes de guardarlos.

~~~
git status
~~~

### 4. Primer Commit (Punto de Guardado)

Se realizó el primer guardado del proyecto con un mensaje descriptivo:

~~~
git commit -m "Inicio de Repositorio de bd para negocios digitales"
~~~

Este commit marca el inicio formal del control de versiones del proyecto.

### 5. Verificación del Historial
Se comprobó que el commit se guardara correctamente con el autor y fecha asignados.
~~~
git log
~~~

Salida: Se confirmó el commit con hash b99e14... realizado por el usuario Alibaba9098.

### 6: Conexión con GitHub (Remote)
Se vinculó el repositorio local con el repositorio remoto vacío creado previamente en GitHub.

~~~
git remote
git remote -v
git push -u origin main
~~~

![imagen Final.](/img/Imagen03.png)

### 7: Listado de Ramas
Antes de crear una nueva rama, se verificó el estado actual:

~~~
git branch
~~~

Resultado:

* main: El asterisco y el color indican que la rama main es la rama activa en la que se está trabajando.

### 8: Creación de una Nueva Rama
Se procedió a crear un nuevo espacio de trabajo independiente:

~~~
git branch rama-ma
~~~

Nota: Este comando crea la rama pero no te cambia a ella automáticamente. Es como crear una carpeta nueva pero seguir parado en la carpeta actual.

### 9: Cambio de Rama (Checkout)
Para empezar a registrar cambios en la nueva rama, es necesario "moverse" hacia ella.

~~~
git checkout rama-ma
~~~

Salida confirmada:

Switched to branch 'rama-ma': Esto indica que cualquier cambio, archivo nuevo o modificación que hagas a partir de ahora, solo afectará a y no a la rama principal ().rama-mamain