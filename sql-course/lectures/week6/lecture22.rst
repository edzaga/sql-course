Lecture 22 - Restricciones y  triggers: Restricciones de múltiples tipos
-----------------------------------------------------------------------

.. role:: sql(code)
         :language: sql
         :class: highlight

.. contexto
Como se pudo apreciar en la lectura anterior, existen varios tipos de restricciones,
las cuales se dividen en:

1. Restricciones que no permiten valores NULL
2. Restricciones de clave primaria
3. Restricciones de atributo y tupla 
.. (lmiitados por cada implementaci+on de lenguaje sql... investigar más)
4. Restricciones generales
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
 
Una forma de evitar este error es utilizar UNIQUE en lugar de PRIMARY KEY, para el
atributo *sName*.


.. code-block:: sql

  CREATE TABLE Student (sID INT PRIMARY KEY, sName VARCHAR(50) UNIQUE, 
  Average INT);

En cuyo caso la salida será::
 
 NOTICE: CREATE TABLE /PRIMARY KEY will create implicit index "student_pkey"
 for table "student"
 NOTICE: CREATE TABLE /UNIQUE will create implicit index "student_sname_key"
 for table "student"
 CREATE TABLE

Al utilizar UNIQUE se permite tener incluso todos los atributos, que no son
clave primaria, como clave (no primaria). UNIQUE funciona comparando **sólo los valores de la 
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



===================================
Restricciones de atributo y tupla
===================================



========================
Restricciones generales
========================
