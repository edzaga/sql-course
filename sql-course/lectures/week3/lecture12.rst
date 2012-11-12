Lecture 12 - Aggregation functions
----------------------------------

.. role:: sql(code)                                                                  
   :language: sql                                                                    
   :class: highlight 

Las funciones de agregado de SQL devuelve un único valor, calculado a partir de los 
valores de una columna.

Algunas funciones útiles de agregado son:

* AVG () - Devuelve el valor promedio
* COUNT () - Devuelve el número de filas
* MAX () - Devuelve el mayor valor
* MIN () - Devuelve el menor valor
* SUM () - Devuelve la suma

Para mostrar el funcionamiento de las funciones de agregación, se trabajará con un 
ejemplo que se creará a continuación:

Se *creará* una tabla de **Ordenes**, que tendrá los atributos de id, fecha de orden, 
precio de la orden y el cliente.

.. code-block:: sql

 postgres=# CREATE TABLE Ordenes(id serial, fecha_ordenes DATE, precio_ordenes INTEGER, cliente VARCHAR(30), PRIMARY KEY(id));

*Ingresaremos* datos a la tabla **Ordenes**.

.. code-block:: sql

 postgres=# INSERT INTO Ordenes(fecha_ordenes, precio_ordenes, cliente) VALUES('2010/09/23', 1120,'Alison');
 INSERT 0 1
 postgres=# INSERT INTO Ordenes(fecha_ordenes, precio_ordenes, cliente) VALUES('2007/02/21',1990,'Alicia');
 INSERT 0 1
 postgres=# INSERT INTO Ordenes(fecha_ordenes, precio_ordenes, cliente) VALUES('2006/06/09',400,'Alison');
 INSERT 0 1
 postgres=# INSERT INTO Ordenes(fecha_ordenes, precio_ordenes, cliente) VALUES('2006/04/01',700,'Alison');
 INSERT 0 1
 postgres=# INSERT INTO Ordenes(fecha_ordenes, precio_ordenes, cliente) VALUES('2005/03/30',2120,'Brad');
 INSERT 0 1
 postgres=# INSERT INTO Ordenes(fecha_ordenes, precio_ordenes, cliente) VALUES('2011/11/17',160,'Alicia');
 INSERT 0 1

Función AVG()
~~~~~~~~~~~~~

La función AVG() devuelve el valor promedio de una columna númerica.

En SQL la sintaxis es de la siguiente manera:

.. code-block:: sql

 SELECT AVG(nombre_columna) FROM nombre_tabla;

Para calcular el precio promedio de las ordenes se realiza la siguiente consulta:

.. code-block:: sql

 postgres=# SELECT AVG(precio_ordenes) AS precio_promedio FROM Ordenes;
    precio_promedio    
 -----------------------
  1081.6666666666666667
 (1 row)  

.. note::

 En la consulta se utilizó la palabra "AS", esto es para darle un nombre a la tabla 
 de retorno en este caso se llamará "precio_promedio".

También podemos calcular con :sql:`SELECT` anidados el precio de las ordenes que son 
mayores al promedio calculado con valor 1081, retornando el id, fecha de orden, 
precio_ordenes y el cliente.

.. code-block:: sql

 postgres=# SELECT id, fecha_ordenes, precio_ordenes, cliente FROM Ordenes WHERE precio_ordenes > (SELECT AVG(precio_ordenes) FROM Ordenes);
  id | fecha_ordenes | precio_ordenes | cliente 
 ----+---------------+----------------+---------
   1 | 2010-09-23    |           1120 | Alison
   2 | 2007-02-21    |           1990 | Alicia
   5 | 2005-03-30    |           2120 | Brad
 (3 rows)


Función COUNT()
~~~~~~~~~~~~~~~



Función MAX()
~~~~~~~~~~~~~

Función MIN()
~~~~~~~~~~~~~

Función SUM()
~~~~~~~~~~~~~

