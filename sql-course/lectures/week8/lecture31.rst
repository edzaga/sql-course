Lecture 31 - Servicios de  Respaldo y Recuperación para Bases de Datos (BD)
---------------------------------------------------------------------------

.. role:: sql(code)
   :language: sql
   :class: highlight

.. Estructura a seguir:

Vamos a comenzar esta lectura con algunas preguntas que a medida que avance la lectura,
serán respondidas:

1. ¿Por qué debemos respaldar una BD? ¿Es posible recuperar información? ¿Cuál es la
   importancia de este tipo de servicios?
2. ¿Como funcionan?
3. ¿Son soportadas por los principales Sistemas de BD? ¿Cuál es el caso de PostgreSQL?

.. agregar más información general, tipo "materia"

Es de suma importancia tener algún sistema de respaldo/recuperación de datos, pues esto permite:

1. Tener sistemas con cierto nivel de seguridad y estabilidad ante posibles fallos.
2. Poder volver a un punto seguro en el estado de la BD, debido a cambios peligrosos.

Su funcionamiento está basado en estados. En cada momento la BD se encuentra en un estado
definido. Cuando realizamos operaciones de modificación, es decir:

1. :sql:`INSERT`
2. :sql:`UPDATE`
3. :sql:`DELETE`

Cambiamos su estado, llevándolo a uno nuevo.

.. agregar diagrama de estado simple

.. note::

  No se considera :sql:`SELECT`, pues no provoca cambios. Recordemos que es una
  operación de selección.

Al momento de realizar un respaldo, se guarda el estado en que se encuentra la BD al momento
de realizar la operación de respaldo.

Al momento de realizar la operación de recuperación, puede ser de varias formas, ya sea
a través de las operaciones (en orden) que han dejado la BD en el estado actual u otras formas.

.. llenar más

La gran mayoría de Motores de BD cuentan con funciones de este tipo y PostgreSQL no es la excepción.

========================
Servicios en PostgreSQL
========================

.. Párrafo introductorio,  Explicación más específica de como funcionan en este sistema (sintaxis, etc) y ejemplo prácticos

De forma nativa PostgreSQL cuenta con las siguientes funciones:

.. warning::

  Algunos de los comandos que se verán a continuación, son ejecutados en terminales
  bajo sistemas UNIX. No necesariamente dentro del entorno de PostgreSQL (psql).

=========
SQL Dump
=========

pg_dump
^^^^^^^
Esta función genera un archivo de texto con comandos SQL que, cuando son reintroducidos
al servidor, se deja a la BD en el mismo estado en el que se encontraba al momento de ejecutar
este comando.

.. note::
  
  Esto ocurre siempre y cuando la BD esté vacia, es decir, en el mismo estado inicial. pg_dump
  guarda los comandos introducidos hasta el punto de control. El ejemplo 1 permitirá aclarar dudas.


su sintaxis es::

  pg_dump dbname > archivo_salida

y se usa desde la linea de comandos.


Para realizar la restaurar se utiliza::

 psql dbname < archivo_entrada

Donde **archivo_entrada** corresponde al **archivo_salida** de la instrucción **pg_dump**.


Ejemplo 1
^^^^^^^^^^
Supongamos que tenemos una BD llamada lecture31 y dentro de ella una única tabla llamada **Numbers** con atributos 
*Number* Y *Name*, con datos::
 
 1 One 
 2 Two
 3 Three

Es decir:

.. code-block:: sql

 CREATE DATABASE lecture31;
 \c lecture31
 CREATE TABLE Numbers(Number INTEGER, Name VARCHAR(20));
 INSERT INTO Numbers VALUES (1, 'One' );
 INSERT INTO Numbers VALUES (2, 'Two' );
 INSERT INTO Numbers VALUES (3, 'Three' );

Es decir que si se hace un select, se podrá ver::
 
 number | name 
 -------+-------
   1    | One 
   2    | Two
   3    | Three

Para poder realizar el respaldo, utilizando pg_dump::
 
 pg_dump lecture31 > resp.sql

.. Posteriormente se puede conectar a la BD lecture31, eliminar la tabla **Numbers**, salir del entorno psql,
   y ejecutar::

Un posible problema a la hora de ejecutar pg_dump es::

  pg_dump lecture31 > resp.sql (bash: permission denied)

Para evitar esto, es necesario considerar que el usuario de la BD debe tener permisos de escritura en la carpeta
donde se alojará el archivo.

.. note::

  Para los usuarios locales, basta con hacer "cd" en la linea de comandos (como usuario postgres), 
  para acceder a la carpeta de postgres. Si desea realizar pruebas desde el servidor dedicado, puede 
  crear BDs desde su sesión y alojar los archivos de respaldo en su capeta home.

.. warning::
  
 Es posible cambiar los permisos de lectura y escritura de las carpetas, dar accesos a usuarios que no 
 son dueños de las BD. No se profundiza esto, pués escapa a los alcances de este curso.


Supongamos que se comete un error, se borra información valiosa, digamos la tupla "1, One". Utilizando
el archivo de respaldo es posible volver al estado anterior::
 
 psql lecture31 < resp.sql

.. note::
    
 Notese que dentro de la salida del comando aparece: ERROR: relation "numbers" already exists

Revisando la tabla a través de:

.. code-block:: sql

 \c lecture31
 SELECT * FROM Numbers;

La salida es::

 
 number | name 
 -------+-------
   2    | Two
   3    | Three
   1    | One 
   2    | Two
   3    | Three

Lo cual, claramente, no corresponde a la información inicial.

**Antes de restaurar, es necesario recrear el contexto que tenía la BD. Específicamente usuarios
que poseían ciertos objetos o permisos. Si esto no calza con la BD, original, es posible que la restauración
no se realice correctamente.**

En este caso el contexto inicial corresponde a una BD vacia. Se invita al lector a borrar la tabla y realizar la
restauración. 

Es necesario aclarar que se necesita una BD existente para hacer la restauración. Si está no existe, 
por ejemplo utlizar lecture32 en lugar de 31, el siguiente error aparecerá:: 
   
 psql: FATAL: database "lecture32" does not exist


Pero ¿Qué ocurre si utilizamos el atributo *number* como PK?, es decir modificar sólo la linea (y seguir el resto
de los pasos de la misma forma):

.. code-block:: sql

 CREATE TABLE Numbers(Number INTEGER, Name VARCHAR(20), PRIMARY KEY (Number));

Al momento de borrar la tupla (3, 'Three'), e intentar restaurar, dentro de la salida del comando aparece::
 
 ERROR: relation "numbers" already exists
 ERROR: duplicate key violates unique constraint "numbers_pkey"
 CONTEXT: COPY numbers, line 1: "1    One" 
 ERROR: multiple primary keys for table "numbers" are not allowed

Ejemplo 2
^^^^^^^^^

Resulta curioso el caso en que se desea, en lugar de trabajar con enteros, hacerlo serial es decir:

.. code-block:: sql

 \c lecture31
 DROP TABLE Numbers;
 CREATE TABLE Numbers2(Number SERIAL, Name VARCHAR(20));
 INSERT INTO Numbers2 (name)  VALUES ('One' );
 INSERT INTO Numbers2 (name) VALUES ('Two' );
 INSERT INTO Numbers2 (name) VALUES ('Three' );

Es decir que si se hace un select, se podrá ver::
 
 number | name 
 -------+-------
   1    | One 
   2    | Two
   3    | Three

Para poder realizar el respaldo, utilizando pg_dump::
 
 pg_dump lecture31 > resp2.sql

Digamos que se agrega la tupla (4, 'Four') y  borra la tupla (3, 'Three'). Después de realizar
el respaldo::

 number | name 
 -------+-------
   1    | One 
   2    | Two
   4    | Four

Posteriormente se realiza la restauración::
 
 psql lecture31 < resp.sql

Notese que en la salida, es posible ver::
 
 setval
 --------
      3
 (1 row)

Revisando la tabla a través de:

.. code-block:: sql

 \c lecture31
 SELECT * FROM Numbers2;

La salida es::

 number | name 
 -------+-------
   1    | One 
   2    | Two
   4    | Four
   1    | One 
   2    | Two
   3    | Three

Lo cual es un problema, pues se trabaja con valores seriales.
De hecho si en este estado se agrega la tupla (4, Four) y se revisan los contenidos de la tabla, la salida es::

 number | name 
 -------+-------
   1    | One 
   2    | Two
   4    | Four
   1    | One 
   2    | Two
   3    | Three
   4    | Four

Esto ocurre debido a que el contador serial vuelve a 3.

Ejercicio propuesto
^^^^^^^^^^^^^^^^^^^^

Se deja en manos del lector ver que ocurre en caso de trabajar con atributo serial PK, es decir:

.. code-block:: sql
 
 CREATE TABLE Numbers2(Number SERIAL, Name VARCHAR(20), PRIMARY KEY (number));

y luego seguir los mismos pasos, es decir agregar las tuplas (1, 'One'), (2, 'Two') y (3, 'Three'). Luego
realizar un respaldo, acceder a la BD, eliminar la última tupla, agregar (4, 'Four'), realizar la 
restauración, intentar agregar más tuplas (conectandose a la BD primero) y los que desee hacer el lector.

A modo de pista, si al agregar una tupla, aparece::
 
 ERROR: duplicate key value violates unique constraint "numbers2_pkey"

Siga intentando, verá que es posible agregar más tuplas. Fijese en el valor de la llave primaria. ¿Cuántas veces
tuvo que intentar?

¿Qué ocurre si en lugar de eliminar la última tupla, se elimina la primera?


pg_dumpall
^^^^^^^^^^^
Un pequeño inconveniente con pg_dump es que sólo puede hacer respaldos de una BD a la vez.
Además no respalda información acerca de roles de usuario e información por el estilo
.. ??
Para realizar un respaldo de la BD y el cluster de datos, existe el comando pg_dumpall.


su sintaxis es::

  pg_dumpall > archivo_salida

y para realizar la restauración::

  psql -f archivo_entrada postgres

Que trabaja emitiendo las consultas y comandos para re-crear roles, tablespaces y Bases de
Datos vacios. Posteriormente se invoca pg_dump por cada BD para corroborar consistencia interna.



=============================
Respaldo a nivel de archivos
=============================

Otra estrategia de respaldo es realizar copias de los archivos, los cuales por lo general
se encuentran en la ruta **/usr/local/pgsql/data**

.. note::
  Esto utilizando un sistema basado en UNIX.

Para poder realizar el respaldo::

  tar -cf backup.tar /usr/local/pgsql/data

No obstante, existen 2 restricciones que hacen que este método sea menos práctico
que utilizar pg_dump:

1. El servidor **debe** ser apagado para poder obtener un respaldo utilizable.
2.

Captura en frío
^^^^^^^^^^^^^^^



Rsync
^^^^^






.. =============
   Conclusiones
   =============

Para finalizar, por lo general, los respaldos realizados a través de **SQL Dump** suelen
ser más livianos, en tamaño, que los realizados a través de respaldo de archivos, ya que,
por ejemplo en el caso de pg_dump no es necesario copiar índices de tablas o cosas por
el estilo; sino que sólo los comandos que los crean. Es por ello que, generalmente estos
últimos, son más rápidos.




