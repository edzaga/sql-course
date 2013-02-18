Tarea 8
========

Fecha de entrega: Miércoles  06 de Marzo de 2013 hasta 23:59
---------------------------------------------------------------


.. role:: sql(code)
   :language: sql
   :class: highlight


-------------------------------------
Vistas Materializadas (25 ptos)
-------------------------------------

Pregunta 1 (25 ptos)
^^^^^^^^^^^^^^^^^^^^^

De acuerdo a la lectura y en sus palabras:

1. ¿Qué son las vistas materializadas? ¿En qué difieren con las vistas revisadas en la semana 7? (7 ptos)

2. ¿Para qué sirve el comando *refresh matviews*? ¿Qué ocurre con la vista materializada si no se utiliza ? (8 ptos)

3. ¿Cómo se relacionan una vista materialiazada y el concepto de mantenimiento incremental? (5 ptos)

4. Nombre una ventaja y una desventaja respecto a las vistas virtuales. De acuerdo a sus funciones laborales y a lo visto en el curso
   ¿Cuál cree que es mejor para su trabajo? Explique. (5 ptos)

------------------------------------------------
Mantenimiento de Bases de Datos (BD) (40 ptos)
------------------------------------------------

Pregunta 1 (25 ptos)
^^^^^^^^^^^^^^^^^^^^^

De acuerdo a la lectura y en sus palabras:

1. ¿Qué realiza VACUUM? ¿Cuál es su importancia? (8 ptos)

2. ¿Qué realiza REINDEX DATABASE? ¿Cómo funciona? (8 ptos)

3. ¿Cuál es la importancia de utilizar índices en una tabla? (5 ptos)

4. ¿Qué realiza EXPLAIN? (4 ptos)


Pregunta 2 (15 ptos)
^^^^^^^^^^^^^^^^^^^^^

Cree una base de datos, una tabla e ingrese datos. Realice la operación VACUUM utilizando la opción VERBOSE sobre su tabla.
¿Cuál es la salida?
 
Borre una (o más) tupla(s) a su gusto y realice nuevamente la operación VACUUM VERBOSE sobre su tabla.
¿Cuál es la salida?

1. Analice que hace falta para que VACUUM realice algún cambio dentro de la tabla (15 ptos)

**HINT:** Puede utilizar un archivo con el siguiente contenido para crear la tabla e ingresar datos. Es libre de agregar más tuplas: 

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

Pregunta 1 (35 ptos)
^^^^^^^^^^^^^^^^^^^^^

De acuerdo a la lectura y en sus palabras:

1. ¿Cuál es la importancia de respaldar una BD? (8 ptos)

2. ¿Cómo funciona el comando pg_dump? ¿Existe algún requisito para utilizarlo? ¿Cuál? (9 ptos)

3. ¿Cuál es la principal diferencia en utilizar respaldos por *DUMP* que por archivos? (8 ptos)

4. ¿Cuál es la diferencia entre pg_dump y pg_dumpall? (5 ptos)

5. ¿Qué es Rsync? ¿Es posible decir que Rsync trabaja con mantención incremental? Explique (5 ptos) 

