Lecture 3 - Relation algebra: Select, project, join
---------------------------------------------------

El álgebra relacional se define como un conjunto de operaciones que se ejecutan sobre las
relaciones (tablas) para obtener un resultado (el cual es otra relación), es preescriptivo
o procedural (algorítmico).


Operaciones relacionales:
~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index:: relational operators

Los operadores relacionales se utilizan para filtrar, cortar o combinar tablas.

======
SELECT
======

Este operador se aplica a una relación R, produce una nueva relación con un subconjunto de tuplas de R. Las tuplas de la relación resultante son los que satisfacen una condición C (expresión condicional, similar a las declaraciones del tipo “if”) sobre algún atributo de R. Es decir selecciona **filas** de una tabla según un cierto criterio C. El esquema de la relación resultante es el mismo esquema R, se muestran los atributos en el mismo orden que se usan en la tabla R.

**Notación en algebra relacional**

.. CMA: Que significa esta relación matemática?

.. math::

    \sigma_{c} \hspace{0.2cm} R


^^^^^^^^^^^
Ejercicio 1
^^^^^^^^^^^

**Ingenieros**

==== ====== ==== ===================
ID   Nombre Edad Años trabajados(AT)
==== ====== ==== ===================
123  León    39           15
234  Tomás   34           10
345  José    45           21
143  Josefa  25           1
==== ====== ==== ===================

Seleccionar las tuplas de la tabla **Ingenieros** que cumplan con tener una edad mayor a 30 años:

**Respuesta**

.. math::
 	\sigma_{edad>30} \hspace{0.2cm} Ingenieros


Así quedaría la tabla:

**Ingenieros**

==== ====== ==== ===================
ID   Nombre Edad Años trabajados(AT)
==== ====== ==== ===================
123  León    39           15
234  Tomás   34           10
345  José    45           21
==== ====== ==== ===================



^^^^^^^^^^^
Ejercicio 2
^^^^^^^^^^^

Seleccionar de la tabla **Ingenieros** las personas que tienen más de 30 años y que lleven menos de 16 años trabajando:

**Respuesta**

.. math::
	\sigma_{edad >30 \wedge AT <16}  \hspace{0.3cm}  Ingenieros

Así finalmente quedaría la tabla:

**Ingenieros**

==== ====== ==== ===================
ID   Nombre Edad Años trabajados(AT)
==== ====== ==== ===================
123  León    39           15
234  Tomás   34           10
==== ====== ==== ===================

=======
PROJECT
=======

El operador PROJECT se utiliza para producir una nueva relación desde R. Esta nueva relación contiene solo algunas de las columnas de R, es decir, realiza la selección de algunas de las **columnas** de una tabla R.

**Notación en algebra relacional**

.. math::

       \prod \hspace{0.2cm} _{A_1,...,A_n} \hspace{0.3cm} R

`A_1,...,A_n` son las columnas que se estan seleccionando de la relación R.

^^^^^^^^^^^
Ejercicio 1
^^^^^^^^^^^

**Ingenieros**

==== ====== ==== ===================
ID   Nombre Edad Años trabajados(AT)
==== ====== ==== ===================
123  León    39           15
234  Tomás   34           10
345  José    45           21
143  Josefa  25           1
==== ====== ==== ===================

Escoger columnas de ID y nombre de la tabla de ingenieros:

**Respuesta**

.. math::
           \prod \hspace{0.2cm}_{ID,Nombre} \hspace{0.3cm} Ingenieros

La tabla finalmente queda como:

**Ingenieros**

==== ======
ID   Nombre
==== ======
123  León
234  Tomás
345  José
143  Josefa
==== ======

^^^^^^^^^^^
Ejercicio 2
^^^^^^^^^^^

Seleccionar ID y nombre de los Ingenieros que tienen más de 30 años.

**Respuesta**

.. math::
	   \prod \hspace{0.2cm} _{ID,Nombre} (\sigma_{edad>30} \hspace{0.3cm} Ingenieros)

Finalmente la tabla queda de la siguiente manera:

**Ingenieros**

==== ======
ID   Nombre
==== ======
123  León
234  Tomás
345  José
==== ======


=============
Cross-product
=============

En teoría de conjuntos, el producto cartesiano de dos conjuntos es una operación que resulta en otro conjunto cuyos elementos son todos los pares ordenados que pueden formarse tomando el primer elemento del par del primer conjunto, y el segundo elemento del segundo conjunto. En el algebra relacional se mantiene esta idea con la diferencia que R y S son relaciones, entonces los miembros de R y S son tuplas, que generalmente consiste de más de un componente, el resultado de la vinculación de una tupla de R con una tupla de S es una tupla más larga, con un componente para cada uno de los componentes de las tuplas constituyentes. Es decir Cross-product define una relación que es la concatenación de cada una de las filas de la relación R con cada una de las filas de la relación S.


**Notación en algebra relacional**

.. math::
	R \times S

Por convención para la sentencia anterior, los componentes de R preceden a los componentes de S en el orden de atributo para el resultado.

Si R y S tienen algunos atributos en común, entonces se debe inventar nuevos nombres para al menos uno de cada par de atributos idénticos. Para eliminar la ambigüedad de un atributo A, que se encuentra en R y S, usamos R.A para el atributo de R y S.A para el atributo de S.

^^^^^^^^
Ejemplo
^^^^^^^^

**R**

=== === ===
 A   B   D
=== === ===
 1   2   3
 4   5   6
=== === ===

**S**

=== === 
 A   C  
=== === 
 7   5
 9   2
 3   4
=== === 

.. math::
	R \times S

===== === === ===== ===
 R.A   B   D   S.A   C
===== === === ===== ===
 1     2   3    7   5
 1     2   3    9   2
 1     2   3    3   4
 4     5   6    7   5
 4     5   6    3   4
 4     5   6    9   2
===== === === ===== ===

.. math::
	S \times R

===== === ===== === ===
 S.A   C   R.A   B   D
===== === ===== === ===
  7    5    1    2   3
  7    5    4    5   6
  9    2    1    2   3
  9    2    4    5   6
  3    4    1    2   3
  3    4    4    5   6
===== === ===== === ===


^^^^^^^^^^^
Ejercicio 1
^^^^^^^^^^^

Dada las siguientes tablas:

**Tabla Ingenieros**

==== ====== ====
ID   Nombre D#
==== ====== ====
123  León     39
234  Tomás    34
143  Josefa   25
==== ====== ====

**Tabla Proyectos**

======== ========
Proyecto Duración
======== ========
ACU0034  300
USM7345  60
======== ========

Escriba la tabla resultante al realizar la siguiente operación:
 
.. math::
	Ingenieros \times Proyectos

**Respuesta**

**Ingenieros x Proyectos**

==== ====== ==== ======== ========
ID   Nombre D#   Proyecto Duración
==== ====== ==== ======== ========
123  León    39  ACU0034  300
123  León    39  USM7345  60
234  Tomás   34  ACU0034  300
234  Tomás   34  USM7345  60
143  Josefa  25  ACU0034  300
143  Josefa  25  USM7345  60
==== ====== ==== ======== ========


===========
NATURALJOIN
===========

Este operador se utiliza cuando se tiene la necesidad de unir relaciones vinculando sólo las tuplas que coinciden de alguna manera.  NATURALJOIN une sólo los pares de tuplas de R y S que sean comunes. Más precisamente una tupla r de R y una tupla s de S se emparejan correctamente si y sólo si r y s coinciden en cada uno de los valores de los atributos comunes, el resultado de la vinculación es una tupla, llamada “joined tuple”.  Entonces, al realizar  NATURALJOIN se obtiene una relación con los atributos de ambas relaciones y se obtiene combinando las tuplas de ambas relaciones que tengan el mismo valor en los atributos comunes.

**Notación en algebra relacional**

.. CMA: Que es esto?????
.. math::
   R \rhd \hspace{-0.1cm} \lhd S

**Equivalencia con operadores básicos**

.. CMA: Que es esto?????
.. math::
   R \rhd \hspace{-0.1cm} \lhd S=  \prod \hspace{0.2cm} _{R.A_1,...,R.A_n,  S.A_1,...,S.A_n} (\sigma_{R.A_1=S.A_1 \wedge ... \wedge R.A_n=S.A_n  }\hspace{0.3cm} (R \times S ))

**Método**

   1. Se realiza el producto cartesiano `R x S`
   2. Se seleccionan aquellas filas del producto cartesiano para las que los atributos comunes tengan el mismo valor
   3. Se elimina del resultado una ocurrencia (columna) de cada uno de los atributos comunes

^^^^^^^^
Ejemplo
^^^^^^^^

**R**

=== === ===
 A   B   C
=== === ===
 1   2   3
 4   5   6
=== === ===

**S**

=== === 
 C   D  
=== === 
 7   5
 6   2
 3   4
=== === 

.. math::
	R \rhd \hspace{-0.1cm} \lhd S

=== === === ===
 A   B   C   D
=== === === ===
 1   2   3   4
 4   5   6   2
=== === === ===


^^^^^^^^^^^
Ejercicio 1
^^^^^^^^^^^

Realizar NATURALJOIN a las siguientes tablas:

**Tabla Ingenieros**

==== ======= ====
ID    Nombre  D#
==== ======= ====
123   León    39
234   Tomás   34
143   Josefa  25
090   María   34
==== ======= ====

**Tabla Proyectos**

====== ========
D#     Proyecto
====== ========
39     ACU0034
34     USM7345
====== ========

**Respuesta**

**Ingenieros join Proyectos**

==== ======= ==== ========
ID   Nombre   D#  Proyecto
==== ======= ==== ========
123  León     39   ACU0034
234  Tomás    34   USM7345
090  María    34   USM7345
==== ======= ==== ========

^^^^^^^^^^^
Ejercicio 1
^^^^^^^^^^^

Realizar NATURALJOIN a las siguientes tablas:

**Tabla Ingenieros**

==== ======= ====
ID    Nombre  D#
==== ======= ====
123   León    39
234   Tomás   34
143   Josefa  25
090   María   34
==== ======= ====

**Tabla Proyectos**

====== ========
D#     Proyecto
====== ========
39     ACU0034
34     USM7345
====== ========

**Respuesta**

**Ingenieros join Proyectos**

==== ======= ==== ========
ID   Nombre   D#  Proyecto
==== ======= ==== ========
123  León     39   ACU0034
234  Tomás    34   USM7345
090  María    34   USM7345
==== ======= ==== ========

^^^^^^^^^^^
Ejercicio 2
^^^^^^^^^^^

Dada las siguientes tablas:

**College**

======= ====== ==========
cName   State  enrollment
======= ====== ==========
 -	-	-
======= ====== ==========


**Student**

==== ======= ====== ======
sID   sName   GPA   sizeHS
==== ======= ====== ======
 -	-	-	-
==== ======= ====== ======


**Apply**

==== ======= ====== ====
sID   cName  major  dec
==== ======= ====== ====
 -	-	-    -
==== ======= ====== ====

Describa con palabras el resultado de esta expresión:

.. math::

   \prod _{sName,cName} (\sigma_{ sizeHS > enrollment } (\sigma_{ state = ‘California’}College \rhd \hspace{-0.1cm} \lhd Student   \rhd \hspace{-0.1cm} \lhd \sigma_{major = ‘CS’} Apply))


**Respuesta**

Students paired with all California colleges smaller than the student’s high school to which the student applied to major in CS

^^^^^^^^^^^
Ejercicio 3
^^^^^^^^^^^

Empleando las mismas tablas del ejercicio 2, escriba una sentencia que encuentre los IDs de todos los estudiantes tal que alguna universidad coincida con el nombre del estudiante.


**Respuesta**

.. math::

   \prod_{sID} (\sigma_{ cName=sName } (College \times Student))

==========
THETA JOIN
==========

Define una relación que contiene las tuplas que satisfacen el predicado F en el producto cartesiano de R x S. Conecta relaciones cuando los valores de determinadas columnas tienen una interrelación específica. El predicado F es de la forma R.ai operador_de_comparación S.bi. El predicado no tiene por que definirse sobre atributos comunes. Termino “join” suele referirse a theta join.

**Notación en algebra relacional**

.. math::
   R \rhd \hspace{-0.1cm} \lhd_F S

**Equivalencia con operadores básicos**

.. math::
   R \rhd \hspace{-0.1cm} \lhd_F S= \sigma_{F} (R \times S)

**Método**

   1. Se forma el producto cartesiano `R` x `S`.
   2. Se selecciona, en el producto, solo la tupla que cumplan la condición `F`.

^^^^^^^^^^
Ejemplo 1
^^^^^^^^^^

**R**

=== === === ===
 A   B   C   D
=== === === ===
 1   3   5   7
 3   2   9   1
 2   3   5   4
=== === === ===

**S**

=== === ===
 A   C   E
=== === ===
 1   5   2
 1   5   9
 3   9   2
 2   3   7
=== === ===

.. math::
   R \rhd \hspace{-0.1cm} \lhd_(A >= E) S 

**Respuesta**

**S**

===== === ===== === ===== ===== ===
 R.A   B   R.C   D   S.A   S.C  E
===== === ===== === ===== ===== ===
  3    2    9    1    1     5    2
  3    2    9    1    3     9    2
  2    3    5    4    1     5    2
  2    3    5    4    3     9    2
===== === ===== === ===== ===== ===


=========
EXERCISES 
=========

Consider a database with the following schema:

   1. Person ( name, age, gender ) : name is a key
   2. Frequents ( name, pizzeria ) : (name, pizzeria) is a key
   3. Eats ( name, pizza ) : (name, pizza) is a key
   4. Serves ( pizzeria, pizza, price ): (pizzeria, pizza) is a key

Write relational algebra expressions for the following five queries.

  * Seleccionar a las personas que comen pizzas con extra queso.
  * Seleccionar a las personas que comen pizzas con extra queso y frecuentan la pizzeria X


