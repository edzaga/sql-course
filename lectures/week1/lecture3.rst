Lecture 3 - Relation algebra: Select, project, join
---------------------------------------------------

El álgebra relacional se define como un conjunto de operaciones que se ejecutan sobre las relaciones (tablas) para obtener un resultado (el cual es otra relación), es preescriptivo o procedural (algorítmico). 


Operaciones relacionales: 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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

====
JOIN
==== 

**Exercises[1]**

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

