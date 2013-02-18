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


.. note::

  No se considera :sql:`SELECT`, pues no provoca cambios. Recordemos que es una
  operación de selección.

Al momento de realizar un respaldo, se guarda el estado en que se encuentra la BD al momento
de realizar dicha operación de respaldo.

Al momento de realizar la operación de recuperación, puede ser de varias formas, ya sea
a través de las operaciones (en orden) que han dejado la BD en el estado actual u otras formas.


La gran mayoría de Motores de BD cuentan con funciones de este tipo y PostgreSQL no es la excepción.

========================
Servicios en PostgreSQL
========================

De forma nativa PostgreSQL cuenta con las siguientes funciones:

.. warning::

  Algunos de los comandos que se verán a continuación, son ejecutados en terminales
  bajo sistemas UNIX. No necesariamente dentro del entorno de PostgreSQL (psql).

=========
SQL Dump
=========

pg_dump
^^^^^^^
Esta función genera un archivo de texto con comandos SQL que, cuando son reintroducidos (bajo cierto contexto )
al servidor, se deja a la BD en el mismo estado en el que se encontraba al momento de ejecutar
este comando.

.. note::

  Esto ocurre siempre y cuando la BD esté vacía, es decir, en el mismo estado inicial. pg_dump
  guarda los comandos introducidos hasta el punto de control. El ejemplo 1 permitirá aclarar dudas.


su sintaxis es::

  pg_dump dbname > archivo_salida

y se usa desde la linea de comandos.


Para realizar la restauración se utiliza::

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

conectándose::

 \c lecture31

.. code-block:: sql

 CREATE TABLE Numbers(Number INTEGER, Name VARCHAR(20));
 INSERT INTO Numbers VALUES (1, 'One' );
 INSERT INTO Numbers VALUES (2, 'Two' );
 INSERT INTO Numbers VALUES (3, 'Three' );

A través de un select::

 number | name
 -------+-------
   1    | One
   2    | Two
   3    | Three

Para realizar el respaldo, se  utiliza pg_dump::

 pg_dump lecture31 > resp.sql

Un posible problema a la hora de ejecutar pg_dump es::

 pg_dump lecture31 > resp.sql (bash: permission denied)

Para evitar esto, es necesario considerar que el usuario de la BD debe tener permisos de escritura en la carpeta
donde se alojará el archivo.

.. note::

  Para los usuarios locales, basta con hacer "cd" en la linea de comandos (como usuario postgres),
  para acceder a la carpeta de postgres. Si desea realizar pruebas desde el servidor dedicado, puede
  crear BDs desde su sesión y alojar los archivos de respaldo en su capeta home.

.. note::

 Es posible cambiar los permisos de lectura y escritura de las carpetas, dar accesos a usuarios que no
 son dueños de las BD. No se profundiza esto, pues escapa a los alcances de este curso.


Supongamos que se comete un error, se borra información de seguridad nacional, digamos la tupla "1, One". Utilizando
el archivo de respaldo es posible volver al estado anterior::

 psql lecture31 < resp.sql

.. note::

 Nótese que dentro de la salida del comando aparece: ERROR: relation "numbers" already exists

Revisando la tabla a través de::

 \c lecture31

.. code-block:: sql

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

En este caso el contexto inicial corresponde a una BD vacía, dentro de la cual se crea una tabla y
se agregan algunos datos Se invita al lector a borrar la tabla y realizar la restauración.

Es necesario aclarar que se necesita una BD existente para hacer la restauración. Si ésta no existe,
por ejemplo utilizar lecture32 en lugar de 31, el siguiente error aparecerá::

 psql: FATAL: database "lecture32" does not exist


Pero ¿Qué ocurre si utilizamos el atributo *number* como PK?, es decir modificar sólo la linea (y seguir el resto
de los pasos de la misma forma):

.. code-block:: sql

 CREATE TABLE Numbers(Number INTEGER, Name VARCHAR(20), PRIMARY KEY (Number));

Al momento de borrar la tupla, digamos (3, 'Three'), e intentar restaurar, dentro de la salida del comando aparece::

 ERROR: relation "numbers" already exists
 ERROR: duplicate key violates unique constraint "numbers_pkey"
 CONTEXT: COPY numbers, line 1: "1    One"
 ERROR: multiple primary keys for table "numbers" are not allowed

¿Qué ocurre si se elimina la primera tupla antes de restaurar?

Ejemplo 2
^^^^^^^^^

Este ejemplo es muy similar al anterior, sólo que, en lugar de trabajar con atributos
INTEGER, se trabajará con atributo serial es decir::

 \c lecture31

.. code-block:: sql

 DROP TABLE Numbers;
 CREATE TABLE Numbers2(Number SERIAL, Name VARCHAR(20));
 INSERT INTO Numbers2 (name) VALUES ('One' );
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

.. note::
 Nótese que en la salida, es posible ver:
 setval
 3


Revisando la tabla a través de::

 \c lecture31

.. code-block:: sql

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
restauración, intentar agregar más tuplas (conectándose a la BD primero) y los que desee hacer el lector.

A modo de pista, si al agregar una tupla, aparece::

 ERROR: duplicate key value violates unique constraint "numbers2_pkey"

Siga intentando, verá que es posible agregar más tuplas. Fíjese en el valor de la llave primaria. ¿Cuántas veces
tuvo que intentar?

¿Qué ocurre si en lugar de eliminar la última tupla, se elimina la primera?


pg_dumpall
^^^^^^^^^^^
Un pequeño inconveniente con pg_dump es que sólo puede hacer respaldos de una BD a la vez.
Además no respalda información acerca de roles de usuario e información por el estilo

Para realizar un respaldo de la BD y el cluster de datos, existe el comando pg_dumpall.


su sintaxis es::

  pg_dumpall > archivo_salida

y para realizar la restauración (utilizar el comando unix) ::

  psql -f archivo_entrada postgres

Que trabaja emitiendo las consultas y comandos para recrear roles, tablespaces y Bases de
Datos vacíos. Posteriormente se invoca pg_dump por cada BD para corroborar consistencia interna.

.. warning::

 Es posible que el servidor dedicado no le permita restaurar, si se  utiliza
 con el usuario postgres. Por favor, utilice este comando sólo de manera local.
 Pruebe utilizando su propio usuario.


=============================
Respaldo a nivel de archivos
=============================

Otra forma de realizar respaldos es a través del manejo directo de archivos, en lugar de las sentencias
utilizadas.

No obstante, existen 2 restricciones que hacen que este método sea menos práctico
que utilizar pg_dump:

1. El servidor **debe** ser apagado para poder obtener un respaldo utilizable.
2. Cada vez que se realice un respaldo, el servidor debe estar apagado, para que los cambios se guarden
   en su totalidad.

.. warning::

 La mayor parte de las veces, se necesita acceso root, para poder realizar este tipo de operación,
 pues es necesario configurar archivos de configuración de postgres. Es de suma importancia que se realicen
 de forma correcta, pues ante algún fallo es posible destruir la base de datos de forma completa.
 Por lo tanto, no se abordará de forma extensa este apartado. No obstante es posible obtener información
 en internet.

Rsync
^^^^^

*Rsync*  corresponde a un programa que sincroniza dos directorios a través
de distintos sistemas de archivos, incluso si están en distinto computadores, físicamente hablando. A través
del uso de SSH o *Secure SHell* por sus siglas en inglés, se pueden realizar transferencias seguras y basadas
en llaves de autenticación.

La principal ventaja de utilizar *rsync* a diferencia de otros comandos similares, como *scp*, es que si
el archivo que se encuentra en la fuente, es el mismo que, el que se encuentra en el objetivo, no hay
transmisión de datos; si el archivo que se encuentra en el objetivo difiere del que se encuentra en
la fuente, **sólo aquellas partes que difieren son transmitidas**, en lugar de transmitir todo, por lo
que el *downtime* de la BD, es decir, el tiempo que debe permanecer apagada, es mucho menor.

Cabe destacar que es de suma importancia realizar una adecuada preparación de la  BD, para
evitar posibles desastres. En [1] se explican con gran nivel de detalle. No obstante, los cambios realizados
son bajo su  propio riesgo, y se recomienda fuertemente realizar pruebas de manera local.

=============
Conclusiones
=============

Para finalizar, **por lo general**, los respaldos realizados a través de **SQL Dump** suelen
ser más livianos, en tamaño, que los realizados a través de respaldo de archivos, ya que,
por ejemplo en el caso de pg_dump no es necesario copiar índices de tablas o cosas por
el estilo; sino que sólo los comandos que los crean. Es por ello que, generalmente estos
últimos, son más rápidos.

[1] http://www.howtoforge.com/how-to-easily-migrate-a-postgresql-server-with-minimal-downtime



