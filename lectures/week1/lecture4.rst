Lecture 4 - Relation algebra: Set operators, renaming, notation
---------------------------------------------------------------

Basics of relational algebra
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index:: basics of relational algebra

An algebra, in general, consists of operators and atomic operands. For instance,
in the algebra of arithmetic, the atomic operands are variables like `r`,
and constants like 15. The operators are the usual arithmetic ones:

  * addition
  * subtraction
  * multiplication
  * division.

Any algebra allows us to build expressions by applying operators to atomic operands
and/or other expressions of the algebra.
Usually, parentheses are needed to group operators and their operands. For instance,
in arithmetic we have expressions such as `(x + y) * z` or
`((x + 7)/(y - 3)) + x`.

Relational algebra is another example of an algebra. Its atomic operands are:

   1. Variables that stand for relations
   2. Constants, which are finite relations

As we mentioned, in the classical relational algebra, all operands and the results of
expressions are sets.
The operations of the traditional relational algebra fall into four broad classes:

  a. The usual set operations - union, intersection, and difference - applied to relations.
  b. Operations that remove parts of a relation: "selection" eliminates some rows (tuples),
     and "projection" eliminates some columns.
  c. Operations that combine the tuples of two relations, including "Cartesian product",
     which pairs the tuples of two relations in all possible ways and various kinds of
     "join" operations, which selectively pair tuples from two relations.
  d. An operation called .'renaming" that does not affect the tuples of a relation, but
     changes the relation schema, i.e., the names of the attribute sand/or the name of the
     relation itself.


We shall generally refer to expressions of relational algebra as queries.
While we don't yet have the symbols needed to show many of the expressions of relational algebra,
you should be familiar with the operations of group `(a)`;
and  thus recognize `(R U S)` as an example of an expression of relational algebra.
`R` and `S` are atomic operands standing for relations,
whose sets of tuples are unknown.
This query asks for the union of whatever tuples are in the relations named `R` and `S`.

The three most common operations on sets are union, intersection;
and difference. Which are defined as follows arbitrary sets `R` and `S`:

.. role:: sql(code)
   :language: sql
   :class: highlight

Operaciones de conjunto:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.. index:: Operaciones de conjunto:

=====
UNION
=====
En matemáticas, se denomina álgebra de conjuntos a las operaciones básicas que pueden realizarse con conjuntos, como la unión, intersección, etc. Un conjunto es una colección de objetos considerada como un objeto en sí. La unión de dos conjuntos A y B es el conjunto que contiene todos los elementos de A y de B.

De manera análoga la unión de dos relaciones `R` y `S`, es otra relación que contiene las tuplas que están en `R`, o en `S`, o en ambas, eliminándose las tuplas duplicadas. `R` y `S` deben ser unión-compatible, es decir, definidas sobre el mismo conjunto de atributo (`R` y `S` deben tener esquemas idénticos. Deben poseer las mismas columnas y su orden debe ser el mismo).

**Notación en algebra relacional**

.. math::

	R \cup S \\ 

.. math::

	\textrm{ Si se realiza } R \cup S \textrm{ es lo mismo que }  S \cup R \textrm{ , es decir se obtiene el mismo resultado} \\

^^^^^^^^
Ejemplo 
^^^^^^^^

Dadas las siguientes relaciones:

**Tabla Ingenieros**
	==== ====== ====
	ID   Nombre Edad	
	==== ====== ====
	123  León    39
     	234  Tomás   34
     	345  José    45
     	143  Josefa  25
     	==== ====== ====

**Tabla Jefes**

     	==== ====== ====
     	ID   Nombre Edad
     	==== ====== ====
     	123  León   39
     	235  María  29
     	==== ====== ====

Aplicar el opedador Unión:

Ingenieros ``U`` Jefes

	==== ====== ====
	ID   Nombre Edad
	==== ====== ====
	123  León   39
	234  Tomás  34
	345  José   45
	143  Josefa 25
	235  María  29
	==== ====== ====

Como se mencionó anteriormente realizar la operación Jefes ``U`` Ingenieros daría como resultado la misma tabla anterior.

==========
DIFFERENCE
==========

Volviendo a la analogía de álgebra de conjuntos, la diferencia entre dos conjuntos A y B es el conjunto que contiene todos los elementos de A que no pertenecen a B.
De la misma forma la diferencia de dos relaciones `R` y `S`, es otra relación que contiene las tuplas que están en la relación `R`, pero no están en `S`.
`R` y `S` deben ser unión-compatible. 

**Notación en algebra relacional**

.. math::

	R - S

Es importante resaltar que `R - S` es diferente a `S - R`.

^^^^^^^^
Ejemplo 
^^^^^^^^

Empleando las mismas tablas dadas en el ejemplo anterior, realice Ingenieros ``-`` Jefes y Jefes ``-`` Ingenieros:

Ingenieros ``-`` Jefes

==== ====== ====
ID   Nombre Edad
==== ====== ====
234  Tomás   34
345  José    45
143  Josefa  25
==== ====== ====

Jefes ``-`` Ingenieros

==== ====== ====
ID   Nombre Edad
==== ====== ====
235  María  29
==== ====== ====

Como se puede apreciar, ambas operaciones dieron como resultado distintas relaciones, tal como se había mencionado anteriormente.

============
INTERSECTION
============

En  álgebra de conjuntos la intersección de dos conjuntos A y B es el conjunto que contiene todos los elementos comunes de A y B. De forma homóloga en álgebra relacional INTERSECTION define una relación que contiene las tuplas que están tanto en la relación `R` como en `S`. `R` y `S` deben ser unión-compatible.

**Notación en algebra relacional**

.. math::
	R \cap S

.. math::
	\textrm{ Si se realiza } R \cap S \textrm{ es lo mismo que }  S \cap R \textrm{ , es decir se obtiene el mismo resultado} \\

**Equivalencia con operadores anteriores**

.. math::
    R \cap S= R-(R-S)

^^^^^^^^
Ejemplo 
^^^^^^^^
Utilizando las mismas tablas del ejemplo anterior, encontrar la interseccion de la tabla de Ingenieros con la de Jefes:

.. math::
    Ingenieros \cap Jefes
 
==== ====== ====
ID   Nombre Edad
==== ====== ====
123  León   39
==== ====== ====


.. important::

   When we apply these operations to relations, we need to put some conditions on R and S:

      * `R` and `S` must have schemas with identical sets of attributes, and the types
        (domains) for each attribute must be the same in `R` and `S`.
      * Before compute the set-theoretic union, intersection, or difference of sets of tuples,
        the columns of `R` and `S` must be ordered so that the order of attributes is the
        same for both relations.

====================================
DEPENDENT AND INDEPENDENT OPERATIONS
====================================

Some of the operations that we have described in the lectures 3 and 4, can be expressed in 
terms of other relational-algebra operations. For example, intersection can be expressed in terms 
of set difference: R <INTERSECTION> S = R - (R - S). That is, if R and S are any two relations with the
same schema, the intersection of R and S can be computed by first subtracting S from R to form a 
relation T consisting of all those tuples in R but not S. We then subtract T from R, leaving only those 
tuples of R that are also in S.


===========================================
RELATIONAL ALGEBRA AS A CONSTRAINT LANGUAJE
===========================================

There are two ways in which we can use expressions of relational algebra to express constraints:

   1. If `R` is an expression of relational algebra, then `R = 0` is a constraint that says
      "The value of R must be empty," or equivalently "There are no tuples in the result of R."
   2. If `R` and `S` are expressions of relational algebra, then `R \subset S` is a constraint
      that says "Every tuple in the result of R must also be in the result of S."
      Of course the result of `S` may contain additional tuples not produced by `R`.

These ways of expressing constraints are actually equivalent in what they can express,
but sometimes one or the other is clearer or more succinct.
That is, the constraint `R \subset S` could just as well have been written `R - S = 0`.
To see why, notice that if every tuple in `R` is also in `S`, then surely `R - S` is empty.
Conversely, if `R - S` contains no tuples, then every tuple in `R` must be in `S`
(or else it would be in `R - S`).

On the other hand, a constraint of the first form, `R = 0`, could just as well have been written
`R \subset 0`.
Technically, `0` is not an expression of relational algebra, but since there are expressions
that evaluate to `0`, such as `R - R`, there is no harm in using `0` as a relational-algebra
expression.
Note that these equivalences hold even if `R` and `S` are bags, provided we make the conventional
interpretation of `R \subset S`: each tuple **t** appears in `S` at least as many times as it
appears in `R`.


=========
Exercises
=========

 Consider a database with the following schema:

   1. Person ( name, age, gender ) : name is a key
   2. Frequents ( name, pizzeria ) : (name, pizzeria) is a key
   3. Eats ( name, pizza ) : (name, pizza) is a key
   4. Serves ( pizzeria, pizza, price ): (pizzeria, pizza) is a key

Write relational algebra expressions for the following nine queries. (Warning: some of the later queries are a bit challenging.)

   * Find all pizzerias frequented by at least one person under the age of 18.
   * Find the names of all females who eat either mushroom or pepperoni pizza (or both).
   * Find the names of all females who eat both mushroom and pepperoni pizza.
   * Find all pizzerias that serve at least one pizza that Amy eats for less than $10.00.
   * Find all pizzerias that are frequented by only females or only males.
   * For each person, find all pizzas the person eats that are not served by any pizzeria the person frequents. Return all such person (name) / pizza pairs.
   * Find the names of all people who frequent only pizzerias serving at least one pizza they eat.
   * Find the names of all people who frequent every pizzeria serving at least one pizza they eat.
   * Find the pizzeria serving the cheapest pepperoni pizza. In the case of ties, return all of the cheapest-pepperoni pizzerias.
