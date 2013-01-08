Lecture 22 - Restricciones y  triggers: Restricciones de múltiples tipos
-------------------------------------------------------------------------

.. role:: sql(code)
         :language: sql
         :class: highlight

.. contexto

Como se pudo apreciar en la lectura anterior, existen varios tipos de restricciones,
las cuales se dividen en:

  1. Restricciones que no permiten valores *NULL*.
  2. Restricciones de clave primaria.
  3. Restricciones de atributo y tupla.
     .. (litados por cada implementaci+on de lenguaje sql... investigar más)
  4. Restricciones generales.
     .. (No implementado en ninguna distribución)

==========
Contexto
==========

En esta lectura se utilizará el ejemplo del sistema de Postulación de Estudiantes a
Establecimientos Educacionales::

    Student(sID, sName, Average);
    College(cName, State, Enrollment);
    Apply(sID, cName, Major, Desicion);

Comencemos a ver los diversos tipos de restricciones:

========================================
Restricciones para evitar valores NULL
========================================

Como su nombre lo indica, su idea es evitar que cierto atributo contenga valores nulos.

Ejemplo 1
^^^^^^^^^

Creemos una tabla de estudiantes, en la cual no se permita tener el campo 'Average' vacío.

.. code-block:: sql

  CREATE TABLE Student (sID SERIAL, sName VARCHAR(50)
  Average INT NOT NULL, PRIMARY KEY (sID) );

Y posteriormente realicemos una serie de inserciones:

.. code-block:: sql

  INSERT INTO Student (sName, Average) VALUES ('Amy', 60);
  INSERT INTO Student (sName, Average) VALUES ('Tim', null);
  INSERT INTO Student (sName, Average) VALUES (null, 90);

Lo cual para la segunda inserción, el siguiente error aparecerá::

  ERROR: null value in column "average" violates not-null constraint

Ejemplo 2
^^^^^^^^^

Si probamos utilizando comandos de actualización (**UPDATE**)

Digamos que el promedio de 'Amy' es incorrecto, pero aún no se sabe cual
es, por lo que la persona encargada de realizar este trabajo (que no sabe la restricción que
tiene la tabla), decide poner un valor NULL:

.. code-block:: sql

  UPDATE Student SET Average = null where sid = 1;

No obstante y para sorpresa de la persona, aparece::

  ERROR: null value in column "average" violates not-null constraint


==================================
Restricciones de clave primaria
==================================

Recordando, una clave primaria es una clave que se utiliza para identificar de forma **única a cada
linea en una tabla**.

Probemos este tipo de restricción con un par de ejemplos:

Ejemplo 3
^^^^^^^^^
Creemos una tabla de estudiantes (digamos estudiantes2 para no provocar confusiones), en la cual se
declare explícitamente su clave primaria.


.. code-block:: sql

  CREATE TABLE Student2 (sID INT PRIMARY KEY, sName VARCHAR(50),
  Average INT);

Y luego insertamos algunos datos:

.. code-block:: sql

 INSERT INTO Student2 VALUES (123,'Amy', 60);
 INSERT INTO Student2 VALUES (234,'Tim', 70);
 INSERT INTO Student2 VALUES (123,'Bob', 55);

Con las primeras dos inserciones no hay problemas, no obstante con la tercera, aparece el
siguiente error::

  ERROR: duplicate key value violates unique constraint "student2_pkey"
  DETAIL: Key (sid)=(123) already exists.


Esto ocurre dado que, se definió *sID* como la clave primaria de la tabla.

Ejemplo 4
^^^^^^^^^^
Similar al caso del Ejemplo 2, si se desea actualizar el valor del atributo *sID*,


.. code-block:: sql

  UPDATE Student2 SET sID = 123 where sid = 234;

el siguiente error aparece::

  ERROR: duplicate key value violates unique constraint "student2_pkey"
  DETAIL: Key (sid)=(123) already exists.

Cabe destacar que si se desea actualizar un *sID* que no existe por '123',
no aparece dicho error, pero, no hay actualización:


.. code-block:: sql

  UPDATE Student2 SET sID = 123 where sid = 999;

La salida es::

 UPDATE 0


Ejemplo 5
^^^^^^^^^
Un caso curioso se da cuando se desea realizar varios cambios a la vez.
El estado actual de la tabla **Student2** es::

  sid | sname | average
  ----+-------+--------
  123 | Amy   | 60
  234 | Tim   | 70

¿Qué ocurre si deseamos restar 111 a ambos *sID*?

.. code-block:: sql

  UPDATE Student2 SET sID = sID - 111;

La salida es::

 UPDATE 2

y el estado de la tabla es::

  sid | sname | average
  ----+-------+--------
   12 | Amy   | 60
  123 | Tim   | 70

Es decir no hay problemas. Pero ¿Qué pasa si se desea sumar 111 en lugar de
restar?

.. code-block:: sql

  UPDATE Student2 SET sID = sID + 111;

La salida es::

  ERROR: duplicate key value violates unique constraint "student2_pkey"
  DETAIL: Key (sid)=(123) already exists.

Es decir, el orden de operaciones es FIFO, pues en la operación de resta no hubo
problemas: el *sID* de 'Amy' pasa de 123 a 12, luego el de 'Tim' de 234 a 123.

En el segundo caso al sumar, el *sID* de 'Amy' pasa de 12 a 123, pero genera conflicto con
el de 'Tim'.


Existe más de una forma de definir claves primarias:


Ejemplo 6
^^^^^^^^^
Por lo general, en SQL sólo se permite una clave primaria (de allí el nombre), al igual que
varias de sus implementaciones. Esta clave permite realizar un orden rápido y eficiente.

.. note::

  Es posible definir más de un atributo como clave primaria propiamente tal, pero
  se reserva el método para el próximo ejemplo.


Supongamos que se desea realizar la tabla **Student** otra vez, debido a fallas. En lugar de

.. code-block:: sql

  DROP TABLE Student;

crear otra tabla, se utiliza el comando: En esta nueva tabla se desea que las claves
primarias sean *sID y sName*.

.. code-block:: sql

  CREATE TABLE Student (sID INT PRIMARY KEY, sName VARCHAR(50) PRIMARY KEY,
  Average INT);

No obstante la salida es::

 ERROR: multiple primary keys for table "student" are not allowed
 LINE1: ... E student (sID PRIMARY KEY, sNname VARCHAR(50) PRIMARY KE...
                                                           ^

Una forma de evitar este error es utilizar :sql:`UNIQUE` en lugar de PRIMARY KEY, para el
atributo *sName*.


.. code-block:: sql

  CREATE TABLE Student (sID INT PRIMARY KEY, sName VARCHAR(50) UNIQUE,
  Average INT);

En cuyo caso la salida será::

 NOTICE: CREATE TABLE / PRIMARY KEY will create implicit index "student_pkey"
 for table "student"
 NOTICE: CREATE TABLE / UNIQUE will create implicit index "student_sname_key"
 for table "student"
 CREATE TABLE

Al utilizar :sql:`UNIQUE` se permite tener incluso todos los atributos, que no son
clave primaria, como clave (no primaria). :sql:`UNIQUE` funciona comparando **sólo los valores de la
columna en cuestión**. Si se repite un valor, a pesar no haber claves conflictos en
la clave primaria, habrá error de todos modos:

.. code-block:: sql

 INSERT INTO Student VALUES (123,'Amy', 60);
 INSERT INTO Student VALUES (234,'Tim', 70);
 INSERT INTO Student VALUES (345,'Bob', 55);
 INSERT INTO Student VALUES (456,'Amy', 90);

Para las primeras 3 inserciones no hay problemas. Si bien en la cuarta no hay conflicto con
la clave primaria::

 ERROR: duplicate key value violates unique constraint "student_sname_pkey"
 DETAIL: Key (sname)=(Amy) already exists.

Es decir que se comparan sólo los valores de la columna/atributo *sName*. Como 'Amy' ya está,
aparece el error de arriba.


Ejemplo 7
^^^^^^^^^
Como se dijo en la nota del ejemplo anterior, es posible definir un grupo de atributos
como clave primaria.

Para variar un poco las cosas, utilicemos la tabla **College**.

Supongamos que se desea crear la tabla **College** con 2 atributos como clave primaria: *cName*
y *State*.

Por el ejemplo 6 ya sabemos que algo como lo siguiente, no funcionará:

.. code-block:: sql

 CREATE TABLE College (cName VARCHAR(50) PRIMARY KEY,
 State VARCHAR (30) PRIMARY KEY, Enrollment INT);

Pues no se permite el uso de múltiples claves primarias. Sin embargo es posible si se define la
clave primaria al final, única, pero de varios atributos:

.. code-block:: sql

  CREATE TABLE College (cName VARCHAR(50), State VARCHAR(30),
  INT Enrollment, PRIMARY KEY (cName, State));

En este caso la salida será::

 NOTICE: CREATE TABLE / PRIMARY KEY will create implicit index "college_pkey"
 for table "college"
 CREATE TABLE

Si nos fijamos, la clave primaria se compone de *cName* y *State*. A esto se le conoce como
**clave compuesta**, pues no es ni una ni la otra, sino la combinación de ambas. Por ejemplo si
se hubiese dejado solo *cName* como clave primaria y *State* como :sql:`UNIQUE`, no se permitirían las
inserciones de este tipo:

.. code-block:: sql

  INSERT INTO College VALUES ('MIT', 'CA',20000);
  INSERT INTO College VALUES ('Harvard', 'CA', 34000);

.. note::

   Los datos de las inserciones de arriba no tienen correlación con los datos utilizados
   en otras lecturas o los reales. Sólo se utilizan para explicar el ejemplo.

Pues con :sql:`UNIQUE` en la columna *State*, no se permitiría 'CA' dos veces. No obstante al ser
un **clave primaria compuesta**, si se permite. En este caso una violación a la restricción, sería
el caso de 2 filas que compartan los mismos valores en ambos atributos, es decir en *cName* y *State*

.. note::

   Para el caso de PostgreSQL, en una atributo declarado como :sql:`UNIQUE`, se permite el múltiple
   uso de valores NULL. Por otra parte si e desea utilizar NULL en una clave primaria (PK), no
   está permitido.

===================================
Restricciones de atributo y tupla
===================================

Este tipo de restricción busca limitar los valores de entrada (o actualización) permitidos; con el
fin de evitar errores como por ejemplo insertar valores negativos cuando sólo se permiten positivos.
Para ello se utiliza la palabra reservada **CHECK**.

Ejemplo 8
^^^^^^^^^
Si creamos la tabla estudiantes 3, cuya característica principal es verficar que, en las operaciones
de inserción y actualización, los promedios estén dentro del valor permitido:

.. code-block:: sql

  CREATE TABLE Student3 (sID INT, sName VARCHAR(50),
  Average INT CHECK(Average>=0 and Average<=100));

Para comprobar el chequeo, hagamos algunas inserciones:

.. code-block:: sql

 INSERT INTO Student3 VALUES (123,'Amy', 60);
 INSERT INTO Student3 VALUES (234,'Tim', 70);
 INSERT INTO Student3 VALUES (345,'Bob', -55);
 INSERT INTO Student3 VALUES (456,'Clara', 190);

Con las primeras dos inserciones no hay problemas, pero con la tercera y cuarta, el siguiente error
aparece::

 ERROR: new row for relation "student3" violates check constriaint "student3_average_check"

pues violan la restricción del promedio.


Ejemplo 9
^^^^^^^^^

Es posible además, restringir cadenas de caracteres, como el caso del atributo *sName*. Supongamos que
se desea denegar la entrada o actualización de nombres groseros o sin sentido, limitemos el caso a las
cadenas: 'asd' y 'lala':

.. code-block:: sql

  DROP TABLE Student3;
  CREATE TABLE Student3 (sID INT,
  sName VARCHAR(50) CHECK(sName <> 'amY' and sName <> 'amy  '),
  Average INT CHECK(Average>=0 and Average<=100));

Si realizamos algunas inserciones:

.. code-block:: sql

 INSERT INTO Student3 VALUES (123,'amY', 60);
 INSERT INTO Student3 VALUES (234,'amy', 70);
 INSERT INTO Student3 VALUES (345,'amy  ',55);
 INSERT INTO Student3 VALUES (454,'Amy',90);

Tanto para la primera inserción como para la tercera se tiene::

  ERROR: new row for relation "student3" violates check constraint "student3_sname_check"

Para las segunda y cuarta inserciones, no existe tal error pues, y como se mencionó dentro
de las primeras semanas, el único caso en que SQL es sensible al uso de mayúsculas y minúsculas 
es para cadenas de caracteres que estén dentro de comillas simples (''). por lo tanto 'amY' o 
'amy  ' que son las cadenas restringidas difieren de 'Amy' y de 'amy'.

.. note::

 Es sumamente importante que si se desea declarar cadenas de caracteres y que además
 se quieran  restringir valores específicos (como ocurre en el Ejemplo 9), el largo permitido
 no sea ni demasiado largo, como para tener que restringir cada caso específico, ya sea: 'asd',
 'asd ', 'asd  ',... o 'Asd', 'Asd '... considerando todas las combinaciones posibles; ni
 demasiado corto para tener problemas de inserción con datos reales.

Al igual que en los primeros ejemplos, si se desea actualizar los atributos que cuentan con el tipo
de restricción de este apartado, con valores que están fuera de rango o dentro de las restricción,
se obtendrá un error de tipo::

  ERROR: new row for relation "**table**" violates check constraint "**table**_*atribute*_check"

Donde **table** se refiere a la relación en cuestión y *atribute* al atributo que cuenta con la
restricción del tipo **CHECK**.


Es posible, además utilizar este tipo de restricción para evitar valores NULL, como
se verá en el siguiente ejemplo.

Ejemplo 10
^^^^^^^^^^
Supongamos que deseamos creamos la tabla de postulación **Apply**, pero que el atributo
*desicion*, de tipo booleano, no admita valores nulos, utilizando restricciones de
atributo y tupla.

.. code-block:: sql

 CREATE TABLE Apply (sID INT, cName VARCHAR(50), Major VARCHAR(11),
 decision BOOL, CHECK(decision IS NOT NULL));

Y luego insertamos algunos datos:

.. code-block:: sql

 INSERT INTO Apply VALUES (123, 'MIT', 'engineering', true);
 INSERT INTO Apply VALUES (123, 'Stanford', 'engineering', null);

Para la primera inserción no hay problemas, pero para la segunda::

 ERROR: new row for relation "apply" violates  check constraint "apply_decision_check"

Si se quisiera actualizar la primera inserción a *decision=null*:

.. code-block:: sql

  UPDATE Apply SET decision = null WHERE sID = 123;

Nos topamos con el mismo error::

 ERROR: new row for relation "apply" violates  check constraint "apply_decision_check"


Ejemplo 11
^^^^^^^^^^

Supongamos que al agregar una nueva postulación en la tabla **Apply**,  deseamos
verificar la existencia en la tabla **Student** a través del atributo *sID*, utilizando
para ello, subconsultas:

.. code-block:: sql

 DROP TABLE Student;
 CREATE TABLE Student (sID INT, sName VARCHAR (50), Average INT);
 CREATE TABLE (sID INT, cName VARCHAR(50), Major VARCHAR(11),
 decision BOOL, CHECK( sID IN (SELECT sID FROM Student)));

Con las primeras 2 instrucciones no hay problemas, pero al intentar crear la tabla **Apply**,
el siguiente error aparece::

 ERROR: cannot use subquery in check constraint

Eso es, utilizar subconsultas dentro de un CHECK no está permitido en PostgreSQL, de hecho
no se permite en la mayoría de motores de bases de datos.

.. La forma de realizar restricciones de integridad con otras tablas,se verá en otra lectura.

=========================
Restricciones generales
=========================

Si bien son formas de restricción bastante poderosas, no están soportadas por casi
ningún sistema actual.

Ejemplo 12
^^^^^^^^^^
Supongamos una Tabla **T** de atributo *A*. Deseamos forzar que este atributo sea
llave de **T**.

.. code-block:: sql

 CREATE TABLE T (A INT);
 CREATE ASSERTION KEY CHECK ((SELECT COUNT (DISTICT A) FROM T)=
 (SELECT COUNT(*) FROM T));

La consulta de arriba busca forzar que por cada fila de la tabla **T**, el atributo *A*
sea distinto, lo que dejaría a *A* como clave.

No obstante la función **assertion** no está implementada en PostgreSQL::

 CREATE ASSERTION is not yet implemented

.. Así finaliza esta lectura.

