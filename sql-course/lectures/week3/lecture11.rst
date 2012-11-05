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

.. note::
 Se observa que se unen las dos tablas **Personas** y **Ordenes** cumpliendo la condición
 que definimos.

NATURAL JOIN
~~~~~~~~~~~~

En el caso de existir columnas con el mismo nombre en las relaciones que se combinan, 
solo se incluirá una de ellas en el resultado de la combinación. 

Se *crearán* dos tablas llamadas **Alimentos** y **Compañia**, para realizar el ejemplo
que mostrará como funciona el **NATURAL JOIN**.

.. code-block:: sql

 postgres=# CREATE TABLE COMPANIA(id_compania serial, nombre_compania VARCHAR(30), ciudad VARCHAR(30), PRIMARY KEY(id_compania));
 postgres=# CREATE TABLE ALIMENTOS(id_alimento serial, nombre_alimento VARCHAR(30), id_compania INTEGER, PRIMARY KEY(id_alimento), FOREIGN KEY(id_compania) REFERENCES COMPANIA(id_compania));

*Ingresamos* datos a las tablas.

.. code-block:: sql

 postgres=# INSERT INTO COMPANIA(nombre_compania, ciudad) VALUES('Order All', 'Boston');
 INSERT 0 1
 postgres=# INSERT INTO COMPANIA(nombre_compania, ciudad) VALUES('Akas Foods', 'Delhi');
 INSERT 0 1
 postgres=# INSERT INTO COMPANIA(nombre_compania, ciudad) VALUES('Foodies', 'London');
 INSERT 0 1
 postgres=# INSERT INTO COMPANIA(nombre_compania, ciudad) VALUES('sip-n-Bite', 'New York');
 INSERT 0 1
 postgres=# INSERT INTO COMPANIA(nombre_compania, ciudad) VALUES('Jack Hill Ltd', 'London');
 INSERT 0 1
 postgres=# INSERT INTO ALIMENTOS(nombre_alimento, id_compania) VALUES('Chex Mix', 2);
 INSERT 0 1
 postgres=# INSERT INTO ALIMENTOS(nombre_alimento, id_compania) VALUES('Cheez-lt', 3);
 INSERT 0 1
 postgres=# INSERT INTO ALIMENTOS(nombre_alimento, id_compania) VALUES('BN Biscuit', 3); 
 INSERT 0 1
 postgres=# INSERT INTO ALIMENTOS(nombre_alimento, id_compania) VALUES('Mighty Munch',5);
 INSERT 0 1
 postgres=# INSERT INTO ALIMENTOS(nombre_alimento, id_compania) VALUES('Pot Rice',4);
 INSERT 0 1

Ahora podemos realizar la *consulta* del **NATURAL JOIN**.

.. code-block:: sql

 postgres=# SELECT * FROM ALIMENTOS NATURAL JOIN COMPANIA;
  id_compania | id_alimento | nombre_alimento | nombre_compania |  ciudad  
 -------------+-------------+-----------------+-----------------+----------
            2 |           1 | Chex Mix        | Akas Foods      | Delhi
            3 |           2 | Cheez-lt        | Foodies         | London
            3 |           3 | BN Biscuit      | Foodies         | London
            5 |           4 | Mighty Munch    | Jack Hill Ltd   | London
            4 |           5 | Pot Rice        | sip-n-Bite      | New York
 (5 filas)

.. note::
 Se puede notar que al realizar el **NATURAL JOIN**, retorna una tabla con solo una
 columna llamada **id_compania**, que estaba repetida en las dos tablas **ALIMENTOS** y 
 **COMPANIA** y la unión de las otras columnas. 

INNER JOIN USING(attrs)
~~~~~~~~~~~~~~~~~~~~~~~

Al realizar el **INNER JOIN** con la cláusula **USING(attrs)**.

A continuación mostraremos el ejemplo anterior utilizando la cláusula **USING(id_compania)** 
que es la columna que se repite en las dos tablas.

.. code-block:: sql

 postgres=# SELECT * FROM ALIMENTOS INNER JOIN COMPANIA USING(id_compania);
  id_compania | id_alimento | nombre_alimento | nombre_compania |  ciudad  
 -------------+-------------+-----------------+-----------------+----------
            2 |           1 | Chex Mix        | Akas Foods      | Delhi
            3 |           2 | Cheez-lt        | Foodies         | London
            3 |           3 | BN Biscuit      | Foodies         | London
            5 |           4 | Mighty Munch    | Jack Hill Ltd   | London
            4 |           5 | Pot Rice        | sip-n-Bite      | New York
 (5 filas)

LEFT|RIGHT|FULL OUTER JOIN
~~~~~~~~~~~~~~~~~~~~~~~~~~

Aquí vamos a utilizar el ejemplo de la **lectura 7** de la tabla **Empleados** y 
**Departamentos**, puesto que aquí podemos utilizar la cláusula **WHERE**.

LEFT JOIN
=========

La sentencia **LEFT JOIN** combina los valores de la primera tabla con los valores 
de la segunda tabla. Siempre devolverá las filas de la primera tabla, incluso aunque 
no cumplan la condición que se definió.

.. code-block:: sql

 SELECT * FROM tabla_1 LEFT JOIN tabla_2 WHERE tabla_1.columna = tabla_2.columna

La siguiente consulta muestra un ejemplo de **LEFT JOIN** y la tabla que se retorna, 
al utilizar la cláusula **WHERE** con las condiciones del año de ingreso a la empresa 
de los empleados sea mayor o igual al 2005 y el departamento al que pertenezcan sea el de 
Informatica.



  
 
 
