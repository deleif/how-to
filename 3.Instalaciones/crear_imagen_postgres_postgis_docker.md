# CREAR UNA IMAGEN Y CONTENEDOR DE POSTGRES  Y POSTGISEN DOCKER

* Descarga la imagen oficial de PostgreSQL 14.1 desde Docker Hub:
```
docker pull postgres:14.1

```
Para Postres 9.6

```
docker pull postgis/postgis:9.6-3.1

```



* Crea un contenedor a partir de la imagen de PostgreSQL 14.1. Configura el puerto y el nombre del contenedor.
La segunda opción es para configurar la persistencia de datos y el arranque automático del contenedor
```
docker run --name mi-postgres -e POSTGRES_PASSWORD=mi-contrasena -p 5432:5432 -d postgres:14.1


docker run --restart=unless-stopped -v E:\docker\bailin:/var/lib/postgresql/data --name dock_bailin -e POSTGRES_PASSWORD=1234 -p 5432:5432 -d postgres:14.1
```

Para Postgres 9.6

```
docker run --name dock_araconc -e POSTGRES_PASSWORD=1234 -p 5434:5432 -d postgis/postgis:9.6-3.1

```



* Para la versión 14, conéctate al contenedor utilizando docker exec:
```
docker exec -it mi-postgres bash

```

* Una vez dentro del contenedor, instala PostGIS utilizando los comandos de apt-get:
```
apt-get update

```
```
apt-get install -y postgis postgresql-14-postgis-3

```

* Instala la extensión de Postgis en la base de datos que quierase (en ambas versiones)
```
CREATE EXTENSION IF NOT EXISTS postgis;

```
