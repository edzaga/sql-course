Lecture 11 - The JOIN family of operators
-----------------------------------------

.. role:: sql(code)
   :language: sql
   :class: highlight

La sentencia SQL JOIN permite consultar datos de 2 o más tablas. Dichas tablas 
estarán relacionadas entre ellas de alguna forma, a través de alguna de sus columnas.
El propósito del JOIN es unir información de diferentes tablas, para no tener que 
repetir datos entre las tablas.

INNER JOIN
~~~~~~~~~~
La sentencia **INNER JOIN** es el sentencia **JOIN** por defecto que consiste en 
combinar cada fila de una tabla con cada fila de la otra tabla, seleccionado 
las filas que cumplan con una determinada condición.

Esta es la estructura que se ocupa para este tipo de JOIN.

.. code-block:: sql

 SELECT * FROM tabla_1 INNER JOIN tabla_2 ON condicion

A continuación se mostrara un ejemplo de una tabla **Personas** y una de **Ordenes**
de compras que realizaron.

Realizamos la *creación* de las tablas **Personas** y **Ordenes**.

.. code-block:: sql

 postgres=# CREATE TABLE Personas(id_persona serial, nombre VARCHAR(30), apellido VARCHAR(30), direccion VARCHAR(30), ciudad VARCHAR(30), PRIMARY kEY(id_persona));
 postgres=# CREATE TABLE Ordenes(id_orden serial, numero_orden INTEGER, persona INTEGER, PRIMARY KEY(id_orden), FOREIGN KEY(persona) REFERENCES Personas(id_persona));

Ahora *insertamos* algunos datos.

.. code-block:: sql

 postgres=# INSERT INTO Personas(nombre, apellido, direccion, ciudad) VALUES('Allen','Doyle','772 Azores', 'New York');
 INSERT 0 1
 postgres=# INSERT INTO Personas(nombre, apellido, direccion, ciudad) VALUES('Amy','Looper','4525 North Oracle Rd.','Miami');
 INSERT 0 1
 postgres=# INSERT INTO Personas(nombre, apellido, direccion, ciudad) VALUES('Bibi','Mingus','3901 W Ina Rd','Los Angeles');
 INSERT 0 1
 postgres=# INSERT INTO Personas(nombre, apellido, direccion, ciudad) VALUES('Caden','Anderson','7635 N La Cholla Blvd','Chicago');
 INSERT 0 1
 postgres=# INSERT INTO Personas(nombre, apellido, direccion, ciudad) VALUES('Calvin','Dixson','CALLE WALLABY 42','San Francisco');
 INSERT 0 1 

