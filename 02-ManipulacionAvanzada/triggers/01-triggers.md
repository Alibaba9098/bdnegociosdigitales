# Triggers en SQL Server

## 1. Que es un trigger?

Un trigger (disparador) es un bloque de codigo SQL que se ejecuta automaticamente cuando
ocurre un evento en una tabla.

- Eventos principales
    - INSERT
    - UPDATE
    - DELETE

Nota: No se ejcutan manualmente, se activan solos 

## 2. Para que sirven 
    - Validaciones
    - Auditorias (guardar historial)
    - Reglas de negocio
    - Automatizacion

## 3. Tipos de Triggers en SQL SERVER
    - AFTER TRIGGER

    Se ejecuta despues del evento

    - INSTEAD OF TRIGGER

    Reemplaza la operacion original

## 4. Sintaxis basica

    ```sql
    CREATE OR ALTER TRIGGER nombre_trigger
    ON nombre_tabla
    AFTER INSERT
    AS
    BEGIN
    END;
    ```

## 5. Tablas especiales

| Tabla | Contenido |
| :--- | :--- |
| insert | Nuevos Datos |
| deleted | Datos anteriores |