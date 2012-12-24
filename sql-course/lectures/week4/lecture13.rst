Lecture 13 - SQL: Valores NULL 
-----------------------------

.. role:: sql(code)
   :language: sql
   :class: highlight

:sql:`NULL` indica que un valor es desconocido o que no existe un valor dentro de
una base de datos. :sql:`NULL` no pertenece a ningún dominio de datos (no pertenece
a los enteros, ni a los booleanos, ni a los flotantes, etc), se puede considerar
como un marcador que indica la ausencia de un valor.

.. note::
    :sql:`NULL` no debe confundirse con un valor 0, ya que el valor 0 pertenece
    a algún tipo de dato (entero o flotante) mientras que, como ya se mencionó,
    :sql:`NULL` es la falta de un dato.

CREATE TABLE
~~~~~~~~~~~~~~~

En forma predeterminada, una columna puede ser :sql:`NULL`. Si se desea no permitir
un valor :sql:`NULL` en una columna, se debe colocar una restricción en esta columna
especificando que :sql:`NULL` no es ahora un valor permitido.

Forma general:

.. code-block:: sql

    CREATE TABLE nombreTabla
    (atributo1 tipoAtributo NOT NULL,
    atributo2 tipoAtributo);

La consulta anterior crea una tabla llamada nombreTabla, con dos atributos.
El primero  atributo1 no acepta valores nulos (:sql:`NULL`), esto debido a que es
acompañado de la instrucción :sql:`NOT NULL`, atributo2 puede no tener valores, es
decir se puede dar que atributo2 contenga, en alguna de sus filas, valores desconocidos.

Para ilustrar las particularidades y utilidad de :sql:`NULL` se utilizará el
siguiente ejemplo: Una tabla de clientes que almacena el rut, apellido, nombre,
deuda y dirección
`\text{Cliente}(\underline{\text{rut}},\text{nombre,apellido, deuda,direccion})` .

Se crea la tabla Cliente donde las columnas “rut”, “nombre” y “apellido” no incluyen
:sql:`NULL`, mientras que “direccion” y “deuda”  puede incluir :sql:`NULL`.
Es decir, podría desconocerse la dirección del usuario sin que esto traiga problemas
a la base de datos. La consulta SQL que realiza esta acción es la siguiente:

.. code-block:: sql

    postgres=# CREATE TABLE Cliente
    (rut int NOT NULL,
    nombre varchar (30) NOT NULL,
    apellido varchar(30)NOT NULL,
    deuda int,
    direccion varchar (30));
    CREATE TABLE


INSERT y UPDATE
~~~~~~~~~~~~~~~~

Los valores :sql:`NULL` se pueden insertar en una columna si se indica explícitamente
:sql:`NULL` en una instrucción :sql:`INSERT`. De igual forma se puede actualizar un
valor con :sql:`UPDATE` especificando que es :sql:`NULL` en la consulta.

Forma general:

.. code-block:: sql

    INSERT INTO nombreTabla (atributo1,atributo2) values(valorValido, null);

    UPDATE nombreTabla SET atributo2= null WHERE condición;

Continuando con el ejemplo anterior, se inserta un cliente:

.. code-block:: sql

    postgres=# INSERT INTO Cliente (rut,nombre,apellido,deuda,direccion) values(123,'Tom', 'Hofstadter', 456, null);
    INSERT 0 1

Al insertar los valores del cliente 'Tom Hofstadter', se almacenó el atributo
dirección como :sql:`NULL`, es decir sin valor asignado.
Antes de exponer cómo funciona :sql:`UPDATE`, se agregan nuevos clientes para mostrar
de mejor manera las siguientes consultas:

.. code-block:: sql

    postgres=# INSERT INTO Cliente (rut, nombre, apellido, deuda, direccion) values
    (412,'Greg', 'Hanks',33, 'Cooper'), (132,'Mayim ', 'Bialik',null, 'Barnett 34'),
    (823,'Jim', 'Parsons',93, null),(193,'Johnny', 'Galecki',201, 'Helberg 11'),
    (453,'Leslie', 'Abbott',303,null), (583,'Hermione', 'Weasley',47, 'Leakey 24'),
    (176,'Ron', 'Granger',92,'Connor 891'), (235,'Hannah', 'Winkle',104, null),
    (733,'Howard', 'Brown',null, null);
    INSERT 0 9

Realizando una consulta SELECT, para ver todos los clientes que se insertaron, se
puede apreciar un espacio vacío en los valores que llevaban :sql:`NULL` al momento
de hacer INSERT. Tal es el caso de la dirección de 'Tom Hofstadter'  o la deuda
'Mayim Bialik' .

.. code-block:: sql

    postgres=# SELECT * FROM Cliente;
     rut |  nombre  |  apellido  | deuda | direccion
    -----+----------+------------+-------+------------
     123 | Tom      | Hofstadter |   456 |
     412 | Greg     | Hanks      |    33 | Cooper
     132 | Mayim    | Bialik     |       | Barnett 34
     823 | Jim      | Parsons    |    93 |
     193 | Johnny   | Galecki    |   201 | Helberg 11
     453 | Leslie   | Abbott     |   303 |
     583 | Hermione | Weasley    |    47 | Leakey 24
     176 | Ron      | Granger    |    92 | Connor 891
     235 | Hannah   | Winkle     |   104 |
     733 | Howard   | Brown      |       |
    (10 filas)


Ahora se puede actualizar un cliente:

.. code-block:: sql

    postgres=# UPDATE Cliente SET direccion=null WHERE rut=412;
    UPDATE 1

Se actualiza el cliente de rut 412,  dejando su dirección sin valor conocido.

Realizando nuevamente un SELECT para visualizar la tabla cliente, se puede apreciar
que el cliente con rut 412, ‘Greg  Hanks’, ahora aparece con una dirección sin un
valor asignado.

.. code-block:: sql

    postgres=# SELECT * FROM Cliente;
     rut |  nombre  |  apellido  | deuda | direccion
    -----+----------+------------+-------+------------
     123 | Tom      | Hofstadter |   456 |
     132 | Mayim    | Bialik     |       | Barnett 34
     823 | Jim      | Parsons    |    93 |
     193 | Johnny   | Galecki    |   201 | Helberg 11
     453 | Leslie   | Abbott     |   303 |
     583 | Hermione | Weasley    |    47 | Leakey 24
     176 | Ron      | Granger    |    92 | Connor 891
     235 | Hannah   | Winkle     |   104 |
     733 | Howard   | Brown      |       |
     412 | Greg     | Hanks      |    33 |
    (10 filas)


SELECT
~~~~~~~~

Seleccionar atributos NULL
===========================

* Para comprobar si hay valores :sql:`NULL`, se usa :sql:`IS NULL` o
* :sql:`IS NOT NULL` en la cláusula :sql:`WHERE`.

Forma general:

.. code-block:: sql

    SELECT atributo1 FROM nombreTabla WHERE atributo2 IS NULL

Utilizando el mismo ejemplo, Seleccionar todos los nombres y apellidos de los
clientes donde la dirección es :sql:`NULL`:

.. code-block:: sql

    postgres=# SELECT nombre,apellido FROM Cliente WHERE direccion IS NULL;

     nombre |  apellido
    --------+------------
     Tom    | Hofstadter
     Jim    | Parsons
     Leslie | Abbott
     Hannah | Winkle
     Howard | Brown
     Greg   | Hanks
    (6 filas)

Seleccionar todos los nombres y apellidos de los clientes donde la dirección es
distinta a :sql:`NULL`:

.. code-block:: sql

    postgres=# SELECT nombre,apellido FROM Cliente WHERE direccion IS NOT NULL;

     nombre  | apellido
    ----------+----------
     Mayim    | Bialik
     Johnny   | Galecki
     Hermione | Weasley
     Ron      | Granger
    (4 filas)


Al  utilizar la instrucción :sql:`IS NOT NULL` se seleccionan todos los clientes que
tienen una dirección conocida, es decir que poseen algún valor designado en la base
de datos.

Comparaciones con NULL
=======================

* La comparación entre dos :sql:`NULL` o entre cualquier valor y un :sql:`NULL` tiene
  un resultado desconocido pues el valor de cada :sql:`NULL` es desconocido.
  También se puede decir que no existen dos :sql:`NULL` iguales.

La siguiente consulta selecciona el nombre y apellido de los clientes que poseen una
deuda mayor a 100 o menor/igual a 100. Se puede apreciar que esta consulta abarcaría
a todos los clientes, pues cualquier número entero es mayor, menor o igual a 100.

.. code-block:: sql

    postgres=# SELECT nombre,apellido FROM Cliente WHERE deuda > 100 or deuda <=100;


Sin embargo al realizar la consulta retorna la siguiente tabla:

.. code-block:: sql

      nombre  |  apellido
    ----------+------------
     Tom      | Hofstadter
     Jim      | Parsons
     Johnny   | Galecki
     Leslie   | Abbott
     Hermione | Weasley
     Ron      | Granger
     Hannah   | Winkle
     Greg     | Hanks
    (8 filas)

Se puede notar que no se incluye a todos los clientes, esto ocurre pues el atributo
deuda admitía valores nulos, y como se mencionó, un :sql:`NULL` no se puede comparar
con ningún valor, pues arroja un resultado desconocido.

La forma de obtener todos los clientes es la siguiente:

.. code-block:: sql

    postgres=# SELECT nombre,apellido FROM Cliente WHERE deuda > 100 or deuda <=100 or deuda IS NULL;

      nombre  |  apellido
    ----------+------------
     Tom      | Hofstadter
     Mayim    | Bialik
     Jim      | Parsons
     Johnny   | Galecki
     Leslie   | Abbott
     Hermione | Weasley
     Ron      | Granger
     Hannah   | Winkle
     Howard   | Brown
     Greg     | Hanks
    (10 filas)


Ahora, se prueba la comparación con otra sentencia:

.. code-block:: sql

    postgres=# SELECT nombre,apellido FROM Cliente WHERE deuda > 100 or nombre= 'Howard';

     nombre |  apellido
    --------+------------
     Tom    | Hofstadter
     Johnny | Galecki
     Leslie | Abbott
     Hannah | Winkle
     Howard | Brown
    (5 filas)


'Howard' tiene deuda :sql:`NULL`, anteriormente se demostró que :sql:`NULL` no se
puede comparar, entonces no cumple con: deuda > 100. A pesar de esto, aparece en el
resultado de la consulta, pues cumple con la segunda condición: nombre= 'Howard'.
Con esto se quiere explicar que no necesariamente, por tener un valor :sql:`NULL`
dentro de sus atributos, pasa a ser completamente “invisible”, es decir mientras no
se compare solamente el atributo :sql:`NULL` puede estar en el resultado.

A modo de resumen se puede decir que:

    * A = NULL no se puede decir que A tenga el mismo valor que NULL.
    * A <> NULL no se puede decir que A tenga distinto valor a NULL.
    * NULL = NULL es imposible saber si ambos NULL son iguales.


Operaciones con NULL
=====================

* Recordar que :sql:`NULL` significa **desconocido**.  Al realizar suma donde uno de
* los datos es desconocido, la suma también es desconocida:

.. code-block:: sql

    postgres=# SELECT (SELECT deuda FROM cliente WHERE rut=132)+( SELECT deuda FROM cliente WHERE rut=583) as suma;

     suma
    ------

    (1 fila)

La sentencia suma la deuda del cliente 132 que es NULL con la deuda del cliente 583
que es 47, NULL + 47 arroja como resultado NULL. Lo mismo ocurre con la resta,
multiplicación y división.

Operadores lógicos
===================

* Cuando hay valores :sql:`NULL` en los datos, los operadores lógicos y de
  comparación pueden devolver un tercer resultado :sql:`UNKNOWN` (desconocido) en
  lugar de simplemente :sql:`TRUE` (verdadero) o :sql:`FALSE` (falso).
  Esta necesidad de una lógica de tres valores es el origen de muchos errores de la
  aplicación.

Se agrega una nueva columna que contenga valores booleanos:

.. code-block:: sql

    postgres=# ALTER table Cliente add actual bool;
    ALTER TABLE

Se insertan algunos valores para la nueva columna *actual*. Esta columna describe
si un cliente es actual o dejó de ser cliente de la compañía.

.. code-block:: sql

    postgres=# UPDATE Cliente SET actual=true WHERE rut=412;
    UPDATE 1
    postgres=# UPDATE Cliente SET actual=true WHERE rut=123;
    UPDATE 1
    postgres=# UPDATE Cliente SET actual=true WHERE rut=193;
    UPDATE 1
    postgres=# UPDATE Cliente SET actual=false WHERE rut=733;
    UPDATE 1
    postgres=# UPDATE Cliente SET actual=false WHERE rut=823;
    UPDATE 1
    postgres=# UPDATE Cliente SET actual=false WHERE rut=453;
    UPDATE 1

.. code-block:: sql

    postgres=#  SELECT * FROM Cliente;

     rut |  nombre  |  apellido  | deuda | direccion  | actual
    -----+----------+------------+-------+------------+--------
     132 | Mayim    | Bialik     |       | Barnett 34 |
     583 | Hermione | Weasley    |    47 | Leakey 24  |
     176 | Ron      | Granger    |    92 | Connor 891 |
     235 | Hannah   | Winkle     |   104 |            |
     412 | Greg     | Hanks      |    33 |            | t
     123 | Tom      | Hofstadter |   456 |            | t
     193 | Johnny   | Galecki    |   201 | Helberg 11 | t
     733 | Howard   | Brown      |       |            | f
     823 | Jim      | Parsons    |    93 |            | f
     453 | Leslie   | Abbott     |   303 |            | f
    (10 filas)

:sql:`IS UNKNOWN` retorna los valores que no son :sql:`false` ni :sql:`true`.
A continuación se muestra su uso, seleccionando de la tabla **cliente** todos los
nombres que en su atributo *actual*, no poseen valor.

.. code-block:: sql

    postgres=#  SELECT nombre FROM cliente WHERE actual IS UNKNOWN;

    nombre
    ----------
     Mayim
     Hermione
     Ron
     Hannah
    (4 filas)

:sql:`IS NOT UNKNOWN` funciona de la misma forma solo que retorna los valores que
poseen algún valor asignado, ya sea :sql:`true` o :sql:`false`.


Para los operadores and y or que involucran NULL, de manera general se puede decir:

    * NULL or false = NULL
    * NULL or true = true
    * NULL or NULL = NULL
    * NULL and false = false
    * NULL and true = NULL
    * NULL and NULL = NULL
    * not (NULL) El inverso de NULL también es NULL.

.. note::
    Para minimizar las tareas de mantenimiento y los posibles efectos en las
    consultas o informes existentes, debería minimizarse el uso de los valores
    desconocidos. Es una buena práctica plantear las consultas e instrucciones de
    modificación de datos de forma que los datos :sql:`NULL` tengan un efecto mínimo.



