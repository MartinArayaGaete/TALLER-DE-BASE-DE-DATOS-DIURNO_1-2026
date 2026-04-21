# Control 1 - Base de Datos

Este repositorio contiene scripts SQL y configuración Docker para crear una base de datos, cargar datos y ejecutar consultas de prueba.

## Requisitos

- Docker Desktop o Docker Engine instalado
- Docker Compose habilitado (`docker compose`)
- Terminal (Linux/macOS) o PowerShell (Windows)

## Archivos principales

- `dbCreate.sql`: crea la estructura de la base de datos (tablas, relaciones, etc.)
- `loadData.sql`: carga datos iniciales
- `runStatements.sql`: ejecuta consultas de ejemplo
- `docker-compose.yml`: define el contenedor de PostgreSQL
- `diccionarioDatos.md`: apoyo para entender el modelo

## Ejecucion basica

### 1. Entrar a la carpeta del proyecto

Linux/macOS:

```bash
cd /home/martin/Descargas/TBD/Control1
```

Windows (PowerShell):

```powershell
cd C:\ruta\a\Control1
```

### 2. Levantar el contenedor

```bash
docker compose up -d
```

### 3. Crear tablas y estructura

Linux/macOS:

```bash
docker compose exec -T db psql -U postgres -d postgres -v ON_ERROR_STOP=1 -f - < dbCreate.sql
```

Windows (PowerShell):

```powershell
Get-Content .\dbCreate.sql | docker compose exec -T db psql -U postgres -d postgres -v ON_ERROR_STOP=1 -f -
```

### 4. Cargar datos

Linux/macOS:

```bash
docker compose exec -T db psql -U postgres -d postgres -v ON_ERROR_STOP=1 -f - < loadData.sql
```

Windows (PowerShell):

```powershell
Get-Content .\loadData.sql | docker compose exec -T db psql -U postgres -d postgres -v ON_ERROR_STOP=1 -f -
```

### 5. Ejecutar consultas del control

Linux/macOS:

```bash
docker compose exec -T db psql -U postgres -d postgres -v ON_ERROR_STOP=1 -f - < runStatements.sql
```

Windows (PowerShell):

```powershell
Get-Content .\runStatements.sql | docker compose exec -T db psql -U postgres -d postgres -v ON_ERROR_STOP=1 -f -
```

## Comandos utiles para revisar la base

### Abrir consola de PostgreSQL en el contenedor

```bash
docker compose exec db psql -U postgres -d postgres
```

### Ver tablas

Dentro de `psql`:

```sql
\dt
```

### Ver estructura de una tabla

```sql
\d nombre_tabla
```

### Hacer una consulta simple

```sql
SELECT *
FROM nombre_tabla
LIMIT 10;
```

## Apagar el entorno

```bash
docker compose down
```

Si tambien quieres eliminar volumenes (datos persistidos):

```bash
docker compose down -v
```

## Nota corta

Si `docker compose` no funciona en tu equipo, prueba `docker-compose` (versiones antiguas).
