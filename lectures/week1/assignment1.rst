Assignment 1
============

-----------------------
Modelo Entidad Relación
-----------------------

^^^^^^^^^^^
Question 1:
^^^^^^^^^^^

Hacer un modelo E-R entidad relación:

  1. Tenemos una universidad, en la que hay varios cursos. Cada curso está dirigido por un profesor, el cual puede dirigir varios cursos. Los cursos son subveniados, por lo que sólo se permite que un alumno se matricule de un curso
  2. supongamos que un curso está compuesto por varias asignaturas. Cada una de ellas tiene un número de créditos. Los alumnos se matriculan de las asignaturas que quieren. Por último el alumno recibe una nota para cada asignatura, al final del curso.


--------------------------
Questions of alternatives:
--------------------------

^^^^^^^^^^^
Question 1:
^^^^^^^^^^^

Suppose relation R(A,B,C) has the following tuples

= = =
A B C
= = =
1 2 3
4 2 3
4 5 6
2 5 3
1 2 6
= = =

and relation S(A,B,C) has the following tuples:

= = =
A B C
= = =
2 5 3
2 5 4
4 5 6
1 2 3
= = =

Compute the intersection of the relations R and S. Which of the following tuples is in the result?

a) (4,5,6)
b) (1,2,6)
c) (4,2,3)
d) (2,4,3)

^^^^^^^^^^^
Question 2:
^^^^^^^^^^^

Suppose relation R(A,B,C) has the following tuples:

= = =
A B C
= = =
1 2 3
4 2 3
4 5 6
2 5 3
1 2 6
= = =

and relation S(A,B,C) has the following tuples:

= = =
A B C
= = =
2 5 3
2 5 4
4 5 6
1 2 3
= = =

Compute (R - S) union (S - R) often called the "symmetric difference" of R and S. Which of the following tuples is in the result?

a) (2,2,3)
b) (4,2,3)
c) (4,5,6)
d) (4,5,3)

^^^^^^^^^^^
Question 3:
^^^^^^^^^^^

Suppose relation R(A,B,C) has the following tuples:

= = =
A B C
= = =
1 2 3
4 2 3
4 5 6
2 5 3
1 2 6
= = =

and relation S(A,B,C) has de following tuples:

= = =
A B C
= = =
2 5 3
2 5 4
4 5 6
1 2 3
= = =

Compute the union of R and S. Which of the following tuples DOES NOT appear in the result?

a) (2,5,3)
b) (2,5,4)
c) (4,5,6)
d) (1,5,4)

^^^^^^^^^^^
Question 4:
^^^^^^^^^^^
Suppose relation R(A,B) has the following tuples:

= = 
A B
= =
1 2
3 4
5 6
= =

and relation S(B,C,D) has de following tuples:

= = =
B C D
= = =
2 4 6
4 6 8
4 7 9
= = =

Compute the natural-join of R and S. Which of the following tuples is in the result? Assume each tuple has schema (A,B,C,D).

a) (5,6,4,6) 
b) (1,4,6,8)
c) (5,6,7,9)
d) (3,4,7,9)

^^^^^^^^^^^
Question 5:
^^^^^^^^^^^
Suppose relation R(A,B,C) has the following tuples:

= = =
A B C
= = =
1 2 3 
4 2 3 
4 5 6
2 5 3
1 2 6
= = =

Compute the projection
.. math::
     \pi_{C,B} (R)
Which of the following tuples is in the result? 

a) (6,2)
b) (2,5)
c) (4,2,3)
d) (1,2)


---------------
Query Questions
---------------

A continuación se realizarán una serie de preguntas de consultas sobre la base de datos formada por las tablas de PROVEEDORES, COMPONENTES, ARTICULOS y ENVÍOS. En cada base de datos esta almacenada la siguiente información.

**PROVEEDORES**

== ======= ========= =======
P# PNOMBRE CATEGORIA CIUDAD
== ======= ========= =======
P1 Carlos  20        Sevilla
P2 Juan    10        Madrid
P3 José    30        Sevilla
P4 Inma    20        Sevilla
P5 Eva     30        Caceres
== ======= ========= =======

**COMPONENTES**

== ======= ===== ==== =======
C# CNOMBRE COLOR PESO CIUDAD
== ======= ===== ==== =======
C1 X3A     Rojo  12   Sevilla
C2 B85     Verde 17   Madrid
C3 C4B     Azul  17   Malaga 
C4 C4B     Rojo  14   Sevilla
C5 VT8     Azul  12   Madrid
C6 C30     Rojo  19   Sevilla
== ======= ===== ==== =======

**ARTICULOS**

== ============= =========
T# TNOMBRE       CIUDAD
== ============= =========
T1 Clasificadora Madrid
T2 Perforadora   Malaga
T3 Lectora       Caceres
T4 Consola       Caceres
T5 Mezcladora    Sevilla
T6 Terminal      Barcelona
T7 Cinta         Sevilla
== ============= =========

**ENVIOS**

== == == ========
P# C# T# CANTIDAD
== == == ========
P1 C1 T1 200
P1 C1 T4 700
P2 C3 T1 400
P2 C3 T2 200
P2 C3 T3 200
P2 C3 T4 500
P2 C3 T5 600
P2 C3 T6 400
P2 C3 T7 800
P2 C5 T2 100
P3 C3 T1 200
P3 C4 T2 500
P4 C6 T3 300
P4 C6 T7 300
P5 C2 T2 200
P5 C2 T4 100
P5 C5 T4 500
P5 C5 T7 100
P5 C6 T2 200
P5 C1 T4 100
P5 C3 T4 200
P5 C4 T4 800
P5 C5 T5 400
P5 C6 T4 500
== == == ========

**PROVEEDORES:** Datos de los proveedores de componentes para la fabricación de articulos y su ciudad de residencia.

**COMPONENTES:** Información de las piezas utilizadas en la fabricación de diferentes artículos, indicando el lugar de fabricación del componente.

**ARTICULOS:** Articulos que se fabrican y lugar del montaje.

**ENVIO:** Suministros realizados por los diferentes proveedores de determinadas cantidades de componentes asignadas para la elaboración del artículo correspondiente.

^^^^^^^^^^
Preguntas:
^^^^^^^^^^

1) Seleccionar todos los detalles de los articulos que se montan en la ciudad Caceres.
2) Obtener todos los valores de P# para los proveedores que abastecen el articulo T1.
3) Obtener la lista de pares de atributos (COLOR,CIUDAD) de la tabla componentes eliminando los pares duplicados.
4) Seleccionar los valores de P# para los proveedores que suministran para el articulo T1 el componente C1
5) Obtener para los valores de P# para los proveedores que suministren los articulos T1 y T2.
   
