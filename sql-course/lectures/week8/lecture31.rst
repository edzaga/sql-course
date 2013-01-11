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
al servidor, dejas a la BD en el mismo estado en el que se encontraba al momento de ejecutar
este comando.


su sintaxis es::
  
  pg_dump dbname > archivo_salida

y se usa desde la linea de comandos.

.. ojo con el problema acceso denegado pg_dump tarea2 > a.sql (bash: permission denied

Para realizar la restaurar se utiliza::
 
 psql dbname < archivo_entrada

Donde **archivo_entrada** corresponde al **archivo_salida** de la instrucción **pg_dump**.

Antes de restaurar, es necesario recrear el contexto que tenía la BD. Específicamente usuarios
que poseían ciertos objetos o permisos. Si esto no calza con la BD, 

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




