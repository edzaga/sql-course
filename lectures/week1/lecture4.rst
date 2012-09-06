Lecture 4 - Relation algebra: Set operators, renaming, notation
---------------------------------------------------------------
The three most common operations on sets are union. intersection; and difference. Which are defined as follows arbitrary sets R and S:


Operaciones de conjunto: 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.. index:: Operaciones de conjunto: 

=====
UNION 
=====

La unión de dos relaciones R y S, es otra relación que contiene las tuplas que están en R, o en S, o en ambas, eliminándose las tuplas duplicadas. R y S deben ser unión-compatible, es decir, definidas sobre el mismo conjunto de atributo (R y S deben tener esquemas idénticos. El orden de las columnas debe ser el mismo).

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

**Ejemplo Ingenieros ``U``Jefes** 

==== ====== ====   
ID   Nombre Edad     
==== ====== ====          
123  León   39           
234  Tomás  34
345  José   45
143  Josefa 25
235  María  29
==== ====== ====

=========
INTERSECT
=========

 Define una relación que contiene el conjunto de todas las filas que están tanto en la relación R como en S. R y S deben ser unión-compatible.
Utilizando las mismas tablas del ejemplo anterior:

**Ejemplo Ingenieros INTERSECT Jefes** 

==== ====== ====   
ID   Nombre Edad      
==== ====== ====          
123  León   39           
==== ====== ====

* MINUS (o DIFFERENCE): La diferencia de dos relaciones R y S, es otra relación que contiene las tuplas que están en la relación R, pero no están en S. R y S deben ser unión-compatible. Es importante resaltar que R - S es diferente a S - R.

**Ejemplo Ingenieros ``-`` Jefes** 

==== ====== ====   
ID   Nombre Edad     
==== ====== ====          
234  Tomás    34
345  José   45
143  Josefa   25
==== ====== ====


**IMPORTANT** When we apply these operations to relations, we need to put some conditions on R and S:

 * R and S must have schemas with identical sets of attributes, and the types (domains) for each attribute must be the same in R and S.
 * Before compute the set-theoretic union, intersection, or difference of sets of tuples, the columns of R and S must be ordered so that the order
of attributes is the same for both relations.


=====
TIMES 
=====
(producto cartesiano):  Define una relación que es la concatenación de cada una de las filas de la relación R con cada una de las filas de la relación S. 

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
Exercises[1]
============
 Consider a database with the following schema:

1) Person ( name, age, gender ) : name is a key
2) Frequents ( name, pizzeria ) : (name, pizzeria) is a key
3) Eats ( name, pizza ) : (name, pizza) is a key
4) Serves ( pizzeria, pizza, price ): (pizzeria, pizza) is a key

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


[1] http://www.db-class.org/course/resources/index?page=opt-rel-algebra

