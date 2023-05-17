# CONCANTENAR PROPIETARIOS PROCEDENTES DE UN XML DE CATASTRO
* Concatenar las columnas **"SUF"** y **"APN"** para obtener los propietarios "HEREDEROS DE..."


* Copiar en una nueva hoja la referencia catastral (**PCA**) y el propieatario (**APN)** habiendo concatenado anteriormente SUF y APN

* Ordenar los datos por referencia catastral

* Introducir la siguiente función excel en la columna C, suponiendo que en la columna A esté la referencia catastral y en la B el propietario
```
=SI(Y(A1=A2);C1&";"&B2;B2)

```

* Introducir la siguiente función en la columna D
``` 
=SI( A2=A3; "Eliminar"; "No eliminar" )
```

* Filtrar la columna D seleccionando "Eliminar" y borrarlos


* Copiar y pegar (pegado especial) los valores de la columna C (datos concatenados por propietario)

* Eliminar la columna D