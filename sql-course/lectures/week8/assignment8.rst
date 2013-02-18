Tarea 8
========

Fecha de entrega: Miércoles  06 de Marzo de 2013 hasta 23:59
---------------------------------------------------------------


.. role:: sql(code)
   :language: sql
   :class: highlight


-------------------------------------
Vistas Materializadas (ptos)
-------------------------------------




------------------------------------------------
Mantenimiento de Bases de Datos (BD) (32 ptos)
------------------------------------------------


Pregunta 1 (20 ptos)
^^^^^^^^^^^^^^^^^^^^^

De acuerdo a la lectura y en sus palabras:

1. ¿Qué realiza VACUUM? ¿Cuál es su importancia? (8 ptos)

2. ¿Qué realiza REINDEX DATABASE? ¿Cómo funciona? (8 ptos)

3. ¿Qué realiza EXPLAIN? (4 ptos)


Pregunta 2 (12 ptos)
^^^^^^^^^^^^^^^^^^^^^

Cree una base de datos, una tabla e ingrese datos. Realice la operación VACUUM utilizando la opción VERBOSE sobre su tabla.
¿Cuál es la salida?
 
Borre una (o más) tupla(s) a su gusto y realice nuevamente la operación VACUUM VERBOSE sobre su tabla.
¿Cuál es la salida?

1. Analice que hace falta para que VACUUM realice algún cambio dentro de la tabla (12 ptos)

HINT: Puede utilizar un archivo con el siguiente contenido:

.. code-block:: sql

 create table score (a serial, b integer);
 insert into score (b) values (1);
 insert into score (b) values (2);
 insert into score (b) values (3);
 insert into score (b) values (4);
 select * from score;


--------------------------------------------------------------------------
Servicios de respaldo y recuperación para Bases de Datos (BD) (35 ptos) 
--------------------------------------------------------------------------

Pregunta 1 (21 ptos)
^^^^^^^^^^^^^^^^^^^^^

De acuerdo a la lectura y en sus palabras:

1. ¿Cuál es la importancia de respaldar una BD?

2. ¿Cómo funciona el comando pg_dump? ¿Existe algún requisito para utilizarlo? ¿Cuál?

3. ¿Cuál es la principal diferencia en utilizar respaldos por *DUMP* que por archivos?


Pregunta 2 (14 puntos)

**agregar algún ejemplo práctico**


