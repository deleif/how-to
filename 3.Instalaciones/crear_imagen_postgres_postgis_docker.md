# CREAR UNA IMAGEN Y CONTENEDOR DE POSTGRES 14.1 Y POSTGIS 3.1 EN DOCKER

* Descarga la imagen oficial de PostgreSQL 14.1 desde Docker Hub:
```
docker pull postgres:14.1

```


* Crea un contenedor a partir de la imagen de PostgreSQL 14.1. Configura el puerto y el nombre del contenedor
```
docker run --name mi-postgres -e POSTGRES_PASSWORD=mi-contrasena -p 5432:5432 -d postgres:14.1

```


* Conéctate al contenedor utilizando docker exec:
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

* Instala la extensión de Postgis en la base de datos que quierase
```
CREATE EXTENSION IF NOT EXISTS postgis;

```
