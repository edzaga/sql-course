Tarea 6
=======

Fecha de entrega: Lunes 4 de Febrero 2013 hasta 23:59
------------------------------------------------------

.. role:: sql(code)
   :language: sql
   :class: highlight

-----------------------
Integración Referencial
-----------------------

Pregunta 1 (15 ptos.)
^^^^^^^^^^^^^^^^^^^^^

Realice un ejemplo en que se aplique la materia de las lecturas donde se apliquen los siguientes comandos:

* Crear 3 o más tablas, que deben incluir ``PRIMARY KEY, FOREIGN KEY, CASCADE, SET NULL``. (5 ptos)
* Insertar datos en las tablas. (2.5 ptos)
* Aplicar UPDATE, DELETE ó ambas. (2.5 ptos)
* Realizar una breve explicación de lo que se realizó. (5 ptos)

-----------------------
Triggers (disparadores)
-----------------------

Pregunta 1 (15 ptos.)
^^^^^^^^^^^^^^^^^^^^^

Realizar un trigger, en que al insertar un entero **no nulo**, calcule automáticamente en cuatro columnas "el entero + 1", "el entero + 2", "el entero al cuadraro" y "el entero al cubo". 

* Crear tabla "pregunta1", con atributos ``num``, ``suma1``, ``suma2``, ``cuadrado`` y ``cubo``. (2.5 ptos)
* Crear FUNCTION "preg1()" (7 ptos)
* Crear TRIGGER "preg1" (3 ptos)
* Insertar los enteros "2", "4", "6" y "8". (2.5 ptos) 

La salida es:

.. code-block:: sql

 SELECT * FROM pregunta1;
  num | suma1 | suma2 | cuadrado | cubo 
 -----+-------+-------+----------+------
    2 |     3 |     4 |        4 |    8
    4 |     5 |     6 |       16 |   64
    6 |     7 |     8 |       36 |  216
    8 |     9 |    10 |       64 |  512
 (4 rows)

.. note::

 **num:** entero no nulo.
 **suma1:** entero.
 **suma2:** entero.
 **cuadrado:** entero.
 **cubo:** entero.
 **PRIMARY KEY:** num.

 El que no cumpla con estas condiciones tendrá un descuento de (1 pto) por cada uno.

Pregunta 2 (30 ptos.)
^^^^^^^^^^^^^^^^^^^^^

Encontrar f(x) cuando x=1, x=3, x=6 y x=8.

.. math::

 f(x) = (x ^ 4 + x ^ 3 ) * 3 + x + 2

* Crear tabla "pregunta2", con los atributos "num" y "resultado". (5 ptos)
* Crear una FUNCTION "preg2()". (15 ptos)
* Crear un TRIGGER "preg2". (5 ptos)
* Insertar los enteros "1", "3", "6" y "8". (5 ptos)

La salida es:

.. code-block:: sql

 SELECT * FROM pregunta2;
  num | resultado 
 -----+-----------
    1 |         9
    3 |       329
    6 |      4544
    8 |     13834
 (4 rows)

.. note::

 **num:** entero no nulo.
 **resultado:** entero

 El que no cumpla con estas condiciones tendrá un descuento de (1 pto) por cada uno.

Pregunta 3 (40 ptos.)
^^^^^^^^^^^^^^^^^^^^^

Calcular el valor del impuesto del salario de un trabajador.

* Crear una tabla "pregunta3" con atributos "ID", "name", "salary" y "duty". (5 ptos) 
* Crear FUNCTION "preg3()" (25 ptos)
* Crear TRIGGER "preg3". (5 ptos)
* Insertar 4 datos (los que ud. desee). (5 ptos)

Condiciones para calcular el impuesto:

* si el salario es menor a 2500 (5% impuesto)
* si el salario es mayor o igual que 2500 y menor e igual que 3999 (6% de impuesto) 
* si el salario es mayor o igual que 4000 y menor e igual  que 8000 (8% de impuesto) 
* si el salario es mayor 8000 (10% de impuesto) 

.. note::

 **ID:** serial.
 **name:** VARCHAR.
 **salary:** INTEGER.
 **duty:** REAL.
 **PRIMARY KEY:** ID.

 El que no cumpla con estas condiciones tendrá un descuento de (1 pto) por cada uno.

 Ayuda: Para utilizar condiciones en la función:

 IF (condicion) THEN

 // Instrucción ;

 ELSIF (condicion) THEN

 // Instrucción ;

 ENDIF;

La salida a modo de ejemplo sería:

.. code-block:: sql

 SELECT * FROM pregunta3;
  id | name | salary |  duty  
 ----+------+--------+--------
   1 | Brad |   2506 | 150.36
   2 | Tom  |   4500 |    360
 (2 rows)

.. note::

     La tarea se `entrega`_  en un archivo comprimido, que contenga:

        * archivo assignment6.doc , .txt, .docx o .pdf que incluya la respuesta de todas las preguntas, 
          incluyendo las imágenes. Cuide bien el formato de entrega. Otros formatos no serán aceptados.
        * Existirá un descuento de 10 puntos por envíar tareas al mail del profesor.
        * La persona que posea problemas con la entrega, escribir al mail del profesor con la excusa pertinente.

.. _`entrega`: https://csrg.inf.utfsm.cl/claroline/


