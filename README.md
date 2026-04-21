DBA-Grupo 1
Prerrequisitos
Tener Docker instalado.

Guía de ejecución
Una vez descargada la carpeta con el código fuente, la ejecución se realiza desde la terminal.

Primero, se debe ingresar al directorio "/TALLER-DE-BASE-DE-DATOS-DIURNO_1-2026":

cd /TALLER-DE-BASE-DE-DATOS-DIURNO_1-2026

Después de ingresar al directorio, se debe levantar el contenedor con el siguiente comando:

docker compose up -d

Tras levantar el contenedor, se debe ejecutar el script dbCreate.sql, el cual está encargado de la creación de la base de datos:

docker compose exec -T db psql -U postgres -d postgres -v ON_ERROR_STOP=1 -f - < dbCreate.sql

Después, se debe ejecutar loadData.sql, script con el cual se llenarán las tablas con datos:

docker compose exec -T db psql -U postgres -d postgres -v ON_ERROR_STOP=1 -f - < loadData.sql

Finalmente, se debe ejecutar runStatements.sql, el cual contiene las consultas:

docker compose exec -T db psql -U postgres -d postgres -v ON_ERROR_STOP=1 -f - < runStatements.sql
