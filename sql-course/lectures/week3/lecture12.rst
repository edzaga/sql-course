Lectura 12 - Funciones de Agregación
------------------------------------

.. role:: sql(code)
   :language: sql
   :class: highlight

Funciones de Agregación
~~~~~~~~~~~~~~~~~~~~~~~

Las Funciones de Agregación realizan un cálculo sobre un conjunto de datos y regresan 
un solo valor.

Algunas funciones útiles de agregado son:

* ``AVG()``   - Retorna el valor promedio
* ``COUNT()`` - Retorna el número de filas
* ``MAX()``   - Retorna el mayor valor
* ``MIN()``   - Retorna el menor valor
* ``SUM()``   - Retorna la suma

Para mostrar el funcionamiento de dichas funciones, consideraremos
el siguiente ejemplo:

Se *creará* una tabla de **Ordenes**, que tendrá los atributos de ``id``, ``fecha de orden``,
``precio de la orden`` y el ``cliente``.

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
=============

La función ``AVG()`` retorna el valor promedio de una columna numérica.

En SQL la sintaxis es de la siguiente manera:

.. code-block:: sql

 SELECT AVG(nombre_columna) FROM nombre_tabla;

Para calcular el ``precio promedio`` de las ordenes se realiza la siguiente consulta:

.. code-block:: sql

 postgres=# SELECT AVG(precio_ordenes) AS precio_promedio FROM Ordenes;
    precio_promedio
 -----------------------
  1081.6666666666666667
 (1 row)

.. note::

 En la consulta se utilizó la palabra "AS", esto es para darle un nombre a la tabla
 de retorno en este caso se llamará "precio_promedio".

También podemos calcular con :sql:`SELECT` anidados,
el precio de las ordenes que son mayores al promedio calculado,
retornando el ``id``, ``fecha de orden``, ``precio_ordenes`` y el ``cliente``.

.. code-block:: sql

 postgres=# SELECT id, fecha_ordenes, precio_ordenes, cliente FROM Ordenes WHERE precio_ordenes > (SELECT AVG(precio_ordenes) FROM Ordenes);
  id | fecha_ordenes | precio_ordenes | cliente
 ----+---------------+----------------+---------
   1 | 2010-09-23    |           1120 | Alison
   2 | 2007-02-21    |           1990 | Alicia
   5 | 2005-03-30    |           2120 | Brad
 (3 rows)


Función COUNT()
===============

La función ``COUNT()`` retorna el número de filas según los criterios que especificaron.

En SQL la sintaxis que se utiliza para realizar la consulta es:

SQL COUNT(nombre_columna)
^^^^^^^^^^^^^^^^^^^^^^^^^

``COUNT(nombre_columna)`` retorna el número de valores que se encuentran en la columna
especificada. Los valores NULL no se cuentan.

.. code-block:: sql

 SELECT COUNT(nombre_columna) FROM nombre_tabla;

Realizaremos la consulta COUNT(clientes) para retornar la cantidad de *cliente*
que tengan el nombre de *Alison* existen en la tabla **Ordenes**.

.. code-block:: sql

 postgres=# SELECT COUNT(cliente) AS cliente_Alison FROM Ordenes WHERE cliente='Alison';
  cliente_alison
 ----------------
               3
 (1 row)

SQL COUNT(*)
^^^^^^^^^^^^

``COUNT(*)`` retorna el número de registros de una tabla.

.. code-block:: sql

 SELECT COUNT(*) FROM nombre_tabla;

Se realizará la consulta ``COUNT(*)``,
que retornara el número de ordenes de la tabla **Ordenes**.

.. code-block:: sql

 postgres=# SELECT COUNT(*) AS numero_ordenes FROM Ordenes;
 numero_ordenes
 ----------------
               6
 (1 row)

SQL COUNT(DISTINCT nombre_columna)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

``COUNT(DISTINCT nombre_columna)`` retorna el número de valores distintos a la columna
especificada.

.. code-block:: sql

 SELECT COUNT(DISTINCT nombre_columna) FROM nombre_tabla;

Se realizará la consulta ``COUNT(DISTINCT cliente)``,
que retornará la cantidad de *clientes*
distintos que existen en la tabla **Ordenes**, que son *Alison*, *Alicia* y *Brad*.

.. code-block:: sql

 postgres=# SELECT COUNT(DISTINCT cliente) AS numero_de_clientes FROM Ordenes;
 numero_de_clientes
 --------------------
                   3
 (1 row)

Función MAX()
=============

La función ``MAX()`` retorna el máximo valor de la columna seleccionada.

En SQL la sintaxis utilizada es de la siguiente manera:

.. code-block:: sql

 SELECT MAX(nombre_columna) FROM nombre_tabla;

Se realizará la consulta ``MAX(precio_ordenes)`` que retornará el mayor precio
de las ordenes en la tabla **Ordenes**.

.. code-block:: sql

 postgres=# SELECT MAX(precio_ordenes) AS mayor_precio FROM Ordenes;
  mayor_precio
 --------------
          2120
 (1 row)

Función MIN()
=============

La función ``MIN()`` retorna el mínimo valor de la columna seleccionada.

En SQL la sintaxis utilizada es de la siguiente manera:

.. code-block:: sql

 SELECT MIN(nombre_columna) FROM nombre_tabla;

Se realizará la consulta MIN(precio_ordenes) que retornará el menor precio de las ordenes
en la tabla **Ordenes**.

.. code-block:: sql

 postgres=# SELECT MIN(precio_ordenes) AS menor_precio FROM Ordenes;
  menor_precio
 --------------
           160
 (1 row)

Función SUM()
=============

La función ``SUM()`` retorna la suma total de una columna numérica.

En SQL la sintaxis utilizada es de la siguiente manera:

.. code-block:: sql

 SELECT SUM(nombre_columna) FROM nombre_tabla;

Se realizará la consulta ``SUM(precio_ordenes)`` que retornará el precio total de las
ordenes que se encuentran en la tabla **Ordenes**.

.. code-block:: sql

 postgres=# SELECT SUM(precio_ordenes) AS precio_total FROM Ordenes;
 precio_total
 --------------
          6490
 (1 row)

SQL GROUP BY
~~~~~~~~~~~~

La instrucción :sql:`GROUP BY` se utiliza en conjunción con las funciones de agregado
para agrupar el conjunto de resultados de una o más columnas.

.. code-block:: sql

 SELECT nombre_columna, funcion_de_agregacion(nombre_columna) FROM nombre_tabla WHERE condicion GROUP BY nombre_columna;

La siguiente consulta utilizará la instrucción ``GROUP BY``, para realizar la ``suma`` por
``cliente`` de los precios de ordenes en la tabla **Ordenes**.

.. code-block:: sql

 postgres=# SELECT cliente, SUM(precio_ordenes) FROM Ordenes GROUP BY cliente;
  cliente | sum
 ---------+------
  Alison  | 2220
  Brad    | 2120
  Alicia  | 2150
 (3 rows)

SQL HAVING
~~~~~~~~~~

La cláusula :sql:`HAVING` se utiliza en SQL, puesto que la palabra clave *WHERE* no puede
utilizarse con las funciones de agregado en sus condiciones.

En SQL la sintaxis que se utiliza es de la siguiente manera:

.. code-block:: sql

 SELECT nombre_columna, funcion_de_agregacion(nombre_columna) FROM nombre_tabla WHERE condicion GROUP BY nombre_columna HAVING funcion_de_agregacion(nombre_columna) operador valor;

Ahora queremos saber si alguno de los clientes tiene un precio total de ordenes mayor
a 2130.

.. code-block:: sql

 postgres=# SELECT cliente, SUM(precio_ordenes) FROM Ordenes GROUP BY cliente HAVING SUM(precio_ordenes)>2130;
  cliente | sum
 ---------+------
  Alison  | 2220
  Alicia  | 2150
 (2 rows)

Realizaremos la consulta anterior, agregando la cláusula *WHERE* con la condición que
el ``cliente`` se igual a "Alison".

.. code-block:: sql

 postgres=# SELECT cliente, SUM(precio_ordenes) FROM Ordenes WHERE cliente='Alicia' GROUP BY cliente HAVING SUM(precio_ordenes)>2130;
  cliente | sum
 ---------+------
  Alicia  | 2150
 (1 row)

