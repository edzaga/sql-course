Lecture 31 - Servicios de  Respaldo y Recuperación para Bases de Datos (BD)
---------------------------------------------------------------------------

.. role:: sql(code) 
            :language: sql 
         :class: highlight 

.. Estructura a seguir:
 
Vamos a comenzar esta lectura con algunas preguntas que a meida que avance la lectura, 
serán respondidas:

1. ¿Por qué debemos respaladar una BD? ¿Es posible recuperar información? ¿Cuál es la 
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

Cambiamos su estado, llevandolo a uno nuevo.

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

.. Parrafo introducctorio,  Explicación más específica de como funcionan en este sistema (sintaxis, etc) y ejemplo practicos

De forma nativa PostgreSQL cuenta con las siguientes funciones:



=============
Conclusiones
=============

