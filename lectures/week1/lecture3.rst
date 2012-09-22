Lecture 3 - Relation algebra: Select, project, join
---------------------------------------------------

El álgebra relacional se define como un conjunto de operaciones que se ejecutan sobre las relaciones (tablas) para obtener un resultado (el cual es otra relación), es preescriptivo o procedural (algorítmico). 


Basics of relational algebra
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index:: basics of relational algebra

An algebra, in general, consists of operators and atomic operands. For in stance, in the algebra of arithmetic, the atomic operands are 
variables like \textit{r}, and constants like 15. The operators are the usual arithmetic ones: 

  * addition
  * subtraction
  * multiplication
  * division. 

Any algebra allows us to build expressions by applying operators to atomic operands and/or other expressions of the algebra.
Usually, parentheses are needed to group operators and their operands. For instance, in arithmetic we have expressions such 
as (x + y) * z or ((x + 7)/(y - 3)) + x. Relational algebra is another example of an algebra. Its atomic operands are:

1) Variables that stand for relations

2) Constants, which are finite relations

As we mentioned, in the classical relational algebra, all operands and the results of expressions are sets.
The operations of the traditional relational algebra fall into four broad classes:

  a) The usual set operations - union, intersection, and difference - applied to relations.
 
  b) Operations that remove parts of a relation: "selection" eliminates some rows (tuples), and "projection" eliminates some columns.
  
  c) Operations that combine the tuples of two relations, including "Cartesian product," which pairs the tuples of two relations in all possible ways and various kinds of "join" operations, which selectively pair tuples from two relations.
  
  d) An operation called .'renaming" that does not affect the tuples of a relation, but changes the relation schema, i.e., the names of the attributesand/or the name of the relation itself.


We shall generally refer to expressions of relational algebra as queries. While we don't yet have the symbols needed to show vmany 
of the expressions of relational algebra, you should be familiar with the operations of group (a); and  thus recognize (R U S) as an example 
of an expression of relational algebra. R and S are atomic operands standing for relations, whose sets of tuples are unknown. This query asks
for the union of whatever tuples are in the relations named R and S.


Operaciones relacionales: 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index:: relational operators

Los operadores relacionales se utilizan para filtrar, cortar o combinar tablas.

======
SELECT 
======

Realiza una selección de las **filas** de una tabla, según sea la condición.

**Notación en algebra relacional**

.. math::

    \sigma_{c} \hspace{0.5cm} R
 
c is a condition (as in “if” statements) that refers to attributes of R (tabla o relación). 

------------
Ejercicio 1
------------

**Ingenieros** 

==== ====== ==== ===================   
ID   Nombre Edad Años trabajados(AT)    
==== ====== ==== ===================          
123  León    39           15
234  Tomás   34           10
345  José    45           21
143  Josefa  25           1
==== ====== ==== ===================

Seleccionar de la tabla **Ingenieros** las personas que tienen más de 30 años:

**Respuesta** 

.. math::
 	\sigma_{edad}>30 \hspace{1cm} Ingenieros

Así quedaría la tabla:

**Ingenieros** 

==== ====== ==== ===================   
ID   Nombre Edad Años trabajados(AT)    
==== ====== ==== ===================          
123  León    39           15
234  Tomás   34           10
345  José    45           21
==== ====== ==== ===================

-----------
Ejercicio 2
-----------

Seleccionar de la tabla **Ingenieros** las personas que tienen más de 30 años y que lleven menos de 16 años trabajando: 

**Respuesta**

.. math::
	\sigma_{edad >30 \wedge AT <16}  \hspace{1cm}  Ingenieros

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

Realiza la selección de las **columnas** de una tabla.

**Notación en algebra relacional**

.. math::

    \pi_{A_1,...,A_n} \hspace{0.5cm} R

`A_1,...,A_n` son las columnas que se estan seleccionando en la tabla o relación R. 

-----------
Ejercicio 1
-----------

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
        \pi_{ID,Nombre} \hspace{1cm} Ingenieros

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

-----------
Ejercicio 2
-----------
 
Seleccionar ID y nombre de los Ingenieros que tienen más de 30 años.

**Respuesta**

.. math::
	\pi_{ID,Nombre} (\sigma_{edad}>30 \hspace{1cm} Ingenieros)

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
(Cartesian product):  Define una relación que es la concatenación de cada una de las filas de la relación R con cada una de las filas de la relación S. 

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

**Ejemplo Ingenieros ``x`` Proyectos** 

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
El resultado es una relación con los atributos de ambas relaciones y se obtiene combinando las tuplas de ambas relaciones que tengan el mismo valor en los atributos comunes.

**Notación en algebra relacional**

.. math::
	R \rhd\lhd S

**Equivalencia con operadores básicos**

.. math::
	R \rhd\lhd S=

**Método**

1) Se realiza el producto cartesiano R x S

2) Se seleccionan aquellas filas del producto cartesiano para las que los atributos comunes tengan el mismo valor

3) Se elimina del resultado una ocurrencia (columna) de cada uno de los atributos comunes


-----------
Ejercicio 1
-----------

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

==========
THETA JOIN
==========

Define una relación que contiene las tuplas que satisfacen el predicado F en el producto cartesiano de R y S. Conecta relaciones cuando los valores de determinadas columnas tienen una interrelación específica. El predicado F es de la forma R.ai operador_de_comparación S.bi. El predicado no tiene por que definirse sobre atributos comunes. Term “join” often means theta join.

**Notación en algebra relacional**

.. math::
	R \rhd\lhd_F S

**Equivalencia con operadores básicos**

.. math::
	R \rhd\lhd_F S= \sigma_{F} (R x S)

**Método**

1) Se forma el producto cartesiano R y S

2) Se selecciona, en el producto, solo la tupla que cumplan la condición F

-----------
Ejercicio 1
-----------

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
      R \rhd\lhd_(A >= E) S 

**Respuesta**

**S**

=== === === === ===== ===== ===   
 A   B   C   D   S.A   S.C  E
=== === === === ===== ===== ===   
 3   2   9   1    1     5    2   
 3   2   9   1    3     9    2  
 2   3   5   4    1     5    2
 2   3   5   4    3     9    2
=== === === === ===== ===== ===    


============
EXERCISES[1]
============

 Consider a database with the following schema:

1) Person ( name, age, gender ) : name is a key
2) Frequents ( name, pizzeria ) : (name, pizzeria) is a key
3) Eats ( name, pizza ) : (name, pizza) is a key
4) Serves ( pizzeria, pizza, price ): (pizzeria, pizza) is a key

Write relational algebra expressions for the following five queries.
 
  * Seleccionar a las personas que comen pizzas con extra queso.
  * Seleccionar a las personas que comen pizzas con extra queso y frecuentan la pizzeria X
  *
  * 
  *

[1] http://www.db-class.org/course/resources/index?page=opt-rel-algebra

