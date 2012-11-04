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
 postgres=# INSERT INTO Ordenes(numero_orden, persona) VALUES(226345,3);
 INSERT 0 1
 postgres=# INSERT INTO Ordenes(numero_orden, persona) VALUES(345478,2);
 INSERT 0 1
 postgres=# INSERT INTO Ordenes(numero_orden, persona) VALUES(218909,2);
 INSERT 0 1
 postgres=# INSERT INTO Ordenes(numero_orden, persona) VALUES(567432,5);
 INSERT 0 1
 postgres=# INSERT INTO Ordenes(numero_orden, persona) VALUES(675209,5);
 INSERT 0 1

Y realizamos la consulta para unir las dos tablas, de acuerdo a la condición que 
detallemos.

.. code-block:: sql

 postgres=# SELECT Personas.nombre, Personas.apellido, Ordenes.numero_orden FROM Personas INNER JOIN Ordenes ON Personas.id_persona=Ordenes.persona;
  nombre | apellido | numero_orden 
 --------+----------+--------------
  Bibi   | Mingus   |       226345
  Amy    | Looper   |       345478
  Amy    | Looper   |       218909
  Calvin | Dixson   |       567432
  Calvin | Dixson   |       675209
 (5 filas)

También podemos mostrar todos los atributos.

.. code-block:: sql

 postgres=# SELECT * FROM Personas INNER JOIN Ordenes ON Personas.id_persona=Ordenes.persona;
  id_persona | nombre | apellido |       direccion       |    ciudad     | id_orden | numero_orden | persona 
 ------------+--------+----------+-----------------------+---------------+----------+--------------+---------
           3 | Bibi   | Mingus   | 3901 W Ina Rd         | Los Angeles   |        1 |       226345 |       3
           2 | Amy    | Looper   | 4525 North Oracle Rd. | Miami         |        2 |       345478 |       2
           2 | Amy    | Looper   | 4525 North Oracle Rd. | Miami         |        3 |       218909 |       2
           5 | Calvin | Dixson   | CALLE WALLABY 42      | San Francisco |        4 |       567432 |       5
           5 | Calvin | Dixson   | CALLE WALLABY 42      | San Francisco |        5 |       675209 |       5
 (5 filas)

