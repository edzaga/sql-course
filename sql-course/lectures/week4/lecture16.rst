Lecture 16 - Teoría del Diseño Relacional: Dependencia Funcional
----------------------------------------------------------------

Dependencia Funcional
~~~~~~~~~~~~~~~~~~~~~

Las dependencias funcionales describen la relación existente entre atributos de una 
relación. Por ejemplo, si A y B son atributos de la relación R, B será funcionalmente 
dependiente de A ó A determina funcionalmente a B (lo que se denota A->B) si cada
valor de A está asociado con exactamente un valor de B.

Las dependencias funcionales son generalmente útiles para:

* Almacenamiento de datos - compresión
* Razonamiento acerca de las consultas - Optimización

Ejemplo 1:
==========

Estudiante(SSN, sNombre, dirección, HScodigo, HSnombre, HSciudad, GPA, prioridad)

Aplicar(SSN, cNombre, estado, fecha, principal)

Supongamos que la prioridad es determinada por GPA

GPA > 3,8 prioridad = 1

3,3 < GPA <= 3,8 prioridad = 2

GPA <= 3,3 prioridad = 3

Dos tuplas con el mismo GPA tienen la misma prioridad

.. math::

 \forall t, u \in Estudiante

 t.GPA = u.GPA \Rightarrow t.priority = u.priority

 GPA \rightarrow prioridad

De forma general sería:

.. math::

 \forall t, u \in R

 t.A = u.A \Rightarrow t.B = u.B

 A \rightarrow B

 \forall t, u \in R

 t.[A_{1}, ..., A_{n}] = u.[A_{1}, ..., A_{n}] => t.[B_{1}, ..., B_{n}] = u.[B_{1}, ..., B_{n}]

 A_{1}, A_{2}, ..., A_{n} \rightarrow B_{1}, B_{2}, ..., B_{n}

 \overline{A} \rightarrow \overline{B}

Ejemplo 2
=========

Considere la posibilidad de una relación R (A, B, C, D, E) con dependencias funcionales:

.. math::

 A,B \rightarrow C
 C,D \rightarrow E.

Supongamos que hay un máximo de 3 valores diferentes para cada uno de A, B y D. 
¿Cuál es el número máximo de valores diferentes para la E?

a) 27
b) 9
c) 3
d) 81

La alternativa correcta es (a), puesto que hay a lo sumo 3 * 3 = 9 combinaciones de 
valores de A, B, así que por A, B -> C como máximo 9 valores diferentes para C con 
un máximo de 3 valores diferentes para D, por C,D -> E hay en la mayoría de 9 * 3 = 27 
valores diferentes para E.


