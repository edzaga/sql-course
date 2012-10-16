Tarea 1
=======

-----------------------
Modelo Entidad Relación
-----------------------

^^^^^^^^^^^
Question 1:
^^^^^^^^^^^

Hacer un modelo E-R entidad relación:

  1. Tenemos una universidad, en la que hay varios cursos. Cada curso está dirigido por un profesor, el cual puede dirigir varios cursos. Los cursos son subveniados, por lo que sólo se permite que un alumno se matricule de un curso. supongamos que un curso está compuesto por varias asignaturas. Cada una de ellas tiene un número de créditos. Los alumnos se matriculan de las asignaturas que quieren. Por último el alumno recibe una nota para cada asignatura, al final del curso.

  2. Queremos hacer una base de datos con los discos que tenemos en casa. Un disco puede tener un cantante o grupo, o varios. Además un disco tiene una discográfica. Vamos a complicar un poco el ejemplo anterior: ahora hemos de tener en cuenta que un disco está compuesto por canciones. Éstas pueden estar escritas por la misma persona que las canta, pero a menudo se trata de personas diferentes.


--------------------------
Questions of alternatives:
--------------------------

^^^^^^^^^^^
Question 1:
^^^^^^^^^^^

Suppose relation R(A,B,C) has the following tuples

.. math::

 \begin{array}{|c|c|c|}
  \hline
  \textbf{A} & \textbf{B} & \textbf{C} \\
  \hline
  1 & 2 & 3 \\
  \hline
  4 & 2 & 3 \\
  \hline
  4 & 5 & 6 \\
  \hline
  2 & 5 & 3 \\
  \hline
  1 & 2 & 6 \\
  \hline
 \end{array}

and relation S(A,B,C) has the following tuples:

.. math::

 \begin{array}{|c|c|c|}
  \hline
  \textbf{A} & \textbf{B} & \textbf{C} \\
  \hline
  2 & 5 & 3 \\
  \hline
  2 & 5 & 4 \\
  \hline
  4 & 5 & 6 \\
  \hline
  1 & 2 & 3 \\
  \hline
 \end{array}

Compute the intersection of the relations R and S. Which of the following tuples is in the result?

a) (4,5,6)
b) (1,2,6)
c) (4,2,3)
d) (2,4,3)

^^^^^^^^^^^
Question 2:
^^^^^^^^^^^

Suppose relation R(A,B,C) has the following tuples:

.. math::

 \begin{array}{|c|c|c|}
  \hline
  \textbf{A} & \textbf{B} & \textbf{C} \\
  \hline
  1 & 2 & 3 \\
  \hline
  4 & 2 & 3 \\
  \hline
  4 & 5 & 6 \\
  \hline
  2 & 5 & 3 \\
  \hline
  1 & 2 & 6 \\
  \hline
 \end{array}

and relation S(A,B,C) has the following tuples:

.. math::

 \begin{array}{|c|c|c|}
  \hline
  \textbf{A} & \textbf{B} & \textbf{C} \\
  \hline
  2 & 5 & 3 \\
  \hline
  2 & 5 & 4 \\
  \hline
  4 & 5 & 6 \\
  \hline
  1 & 2 & 3 \\
  \hline
 \end{array}

Compute (R - S) union (S - R) often called the "symmetric difference" of R and S. Which of the following tuples is in the result?

a) (2,2,3)
b) (4,2,3)
c) (4,5,6)
d) (4,5,3)

^^^^^^^^^^^
Question 3:
^^^^^^^^^^^

Suppose relation R(A,B,C) has the following tuples:

.. math::

 \begin{array}{|c|c|c|}
  \hline
  \textbf{A} & \textbf{B} & \textbf{C} \\
  \hline
  1 & 2 & 3 \\
  \hline
  4 & 2 & 3 \\
  \hline
  4 & 5 & 6 \\
  \hline
  2 & 5 & 3 \\
  \hline
  1 & 2 & 6 \\
  \hline
 \end{array}

and relation S(A,B,C) has de following tuples:

.. math::

 \begin{array}{|c|c|c|}
  \hline
  \textbf{A} & \textbf{B} & \textbf{C} \\
  \hline
  2 & 5 & 3 \\
  \hline
  2 & 5 & 4 \\
  \hline
  4 & 5 & 6 \\
  \hline
  1 & 2 & 3 \\
  \hline
 \end{array}

Compute the union of R and S. Which of the following tuples DOES NOT appear in the result?

a) (2,5,3)
b) (2,5,4)
c) (4,5,6)
d) (1,5,4)

^^^^^^^^^^^
Question 4:
^^^^^^^^^^^
Suppose relation R(A,B) has the following tuples:

.. math::

 \begin{array}{|c|c|}
  \hline
  \textbf{A} & \textbf{B} \\
  \hline
  1 & 2 \\
  \hline
  3 & 4 \\
  \hline
  5 & 6 \\
  \hline
 \end{array}

and relation S(B,C,D) has de following tuples:

.. math::

 \begin{array}{|c|c|c|}
  \hline
  \textbf{B} & \textbf{C} & \textbf{D} \\
  \hline
  2 & 4 & 6 \\
  \hline
  4 & 6 & 8 \\
  \hline
  4 & 7 & 9 \\
  \hline
 \end{array}

Compute the natural-join of R and S. Which of the following tuples is in the result? Assume each tuple has schema (A,B,C,D).

a) (5,6,4,6) 
b) (1,4,6,8)
c) (5,6,7,9)
d) (3,4,7,9)

^^^^^^^^^^^
Question 5:
^^^^^^^^^^^
Suppose relation R(A,B,C) has the following tuples:

.. math::
 
 \begin{array}{|c|c|c|}
  \hline  
  \textbf{A} & \textbf{B} & \textbf{C} \\
  \hline
  1 & 2 & 3 \\
  \hline 
  4 & 2 & 3 \\
  \hline 
  4 & 5 & 6 \\
  \hline
  2 & 5 & 3 \\
  \hline
  1 & 2 & 6 \\
  \hline
 \end{array}

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

.. math::

 \textbf{PROVEEDORES}

 \begin{array}{|c|c|c|c|}
  \hline
  \textbf{P#} & \textbf{PNOMBRE} & \textbf{CATEGORIA} & \textbf{CIUDAD} \\
  \hline
  P1 & Sergio & 20 & Valparaíso \\
  \hline
  P2 & Pedro & 10 & Iquique \\
  \hline
  P3 & Cristian & 30 & Valparaíso \\
  \hline
  P4 & Javiera & 20 & Valparaíso \\
  \hline
  P5 & Andrea & 30 & Santiago \\
  \hline
 \end{array}

 \textbf{COMPONENTES}

 \begin{array}{|c|c|c|c|c|}
  \hline
  \textbf{C#} & \textbf{CNOMBRE} & \textbf{COLOR} & \textbf{PESO} & \textbf{CIUDAD} \\
  \hline
  C1 & X3A & Rojo & 12 & Valparaíso \\
  \hline
  C2 & B85 & Verde & 17 & Iquique \\
  \hline
  C3 & C4B & Azul & 17 & Rancagua \\
  \hline
  C4 & C4B & Rojo & 14 & Valparaíso \\
  \hline
  C5 & VT8 & Azul & 12 & Iquique \\
  \hline
  C6 & C30 & Rojo & 19 & Valparaíso \\
  \hline
 \end{array}

 \textbf{ARTICULOS}

 \begin{array}{|c|c|c|}
  \hline
  \textbf{T#} & \textbf{TNOMBRE} & \textbf{CIUDAD} \\
  \hline
  T1 & Clasificadora & Iquique \\
  \hline
  T2 & Perforadora & Rancagua \\
  \hline
  T3 & Lectora & Santiago \\
  \hline
  T4 & Consola & Santiago \\
  \hline
  T5 & Mezcladora & Valparaíso \\
  \hline
  T6 & Terminal & Arica \\
  \hline
  T7 & Cinta & Valparaíso \\
  \hline
 \end{array}

 \textbf{ENVIOS}

  \begin{array}{|c|c|c|c|} 
   \hline 
   \textbf{P#} & \textbf{C#} & \textbf{T#} & \textbf{CANTIDAD} \\
   \hline
   P1 & C1 & T1 & 200 \\
   \hline
   P1 & C1 & T4 & 700 \\
   \hline
   P2 & C3 & T1 & 400 \\
   \hline
   P2 & C3 & T2 & 200 \\
   \hline
   P2 & C3 & T3 & 200 \\
   \hline
   P2 & C3 & T4 & 500 \\
   \hline
   P2 & C3 & T5 & 600 \\
   \hline
   P2 & C3 & T6 & 400 \\
   \hline
   P2 & C3 & T7 & 800 \\
   \hline
   P2 & C5 & T2 & 100 \\
   \hline
   P3 & C3 & T1 & 200 \\
   \hline
   P3 & C4 & T2 & 500 \\
   \hline
   P4 & C6 & T3 & 300 \\
   \hline
   P4 & C6 & T7 & 300 \\
   \hline
   P5 & C2 & T2 & 200 \\
   \hline
   P5 & C2 & T4 & 100 \\
   \hline
   P5 & C5 & T4 & 500 \\
   \hline
   P5 & C5 & T7 & 100 \\
   \hline
   P5 & C6 & T2 & 200 \\
   \hline
   P5 & C1 & T4 & 100 \\
   \hline
   P5 & C3 & T4 & 200 \\
   \hline
   P5 & C4 & T4 & 800 \\
   \hline
   P5 & C5 & T5 & 400 \\
   \hline
   P5 & C6 & T4 & 500 \\
   \hline
 \end{array}

**PROVEEDORES:** Datos de los proveedores de componentes para la fabricación de articulos y su ciudad de residencia.

**COMPONENTES:** Información de las piezas utilizadas en la fabricación de diferentes artículos, indicando el lugar de fabricación del componente.

**ARTICULOS:** Articulos que se fabrican y lugar del montaje.

**ENVIO:** Suministros realizados por los diferentes proveedores de determinadas cantidades de componentes asignadas para la elaboración del artículo correspondiente.

^^^^^^^^^^
Preguntas:
^^^^^^^^^^

1) Seleccionar todos los detalles de los articulos que se montan en la ciudad Santiago.
2) Obtener todos los valores de P# para los proveedores que abastecen el articulo T1.
3) Obtener la lista de pares de atributos (COLOR,CIUDAD) de la tabla componentes eliminando los pares duplicados.
4) Seleccionar los valores de P# para los proveedores que suministran para el articulo T1 el componente C1
5) Obtener para los valores de P# para los proveedores que suministren los articulos T1 y T2.
	   
